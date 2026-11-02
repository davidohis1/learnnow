<?php

namespace Learnow\Services;

use Learnow\Repositories\DB;
use Learnow\Validators\Validate as V;

final class AdminContentService
{
    public static function config(string $resource): array
    {
        $all = require ROOT . '/config/resources.php';
        if (!isset($all[$resource])) {
            abort(404, 'This content type does not exist.');
        }return $all[$resource];
    }
    public static function options(string $table): array
    {
        $allowed = ['categories','learning_paths','stages','modules','lessons'];
        if (!in_array($table, $allowed, true)) {
            return [];
        }
        return match ($table) {
            'categories'=>DB::all('SELECT id,name AS label FROM categories ORDER BY name LIMIT 500'),
            'stages'=>DB::all("SELECT s.id,CONCAT(p.title,' / ',s.title) AS label FROM stages s JOIN learning_paths p ON p.id=s.path_id ORDER BY p.id,s.position LIMIT 500"),
            'modules'=>DB::all("SELECT m.id,CONCAT(p.title,' / ',s.title,' / ',m.title) AS label FROM modules m JOIN stages s ON s.id=m.stage_id JOIN learning_paths p ON p.id=s.path_id ORDER BY p.id,s.position,m.position LIMIT 500"),
            'lessons'=>DB::all("SELECT l.id,CONCAT(s.title,' / ',l.title) AS label FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id ORDER BY s.path_id,s.position,l.position LIMIT 500"),
            default=>DB::all('SELECT id,title AS label FROM learning_paths ORDER BY id LIMIT 500')
        };
    }
    public static function validate(array $config, array $d): array
    {
        $values = [];
        foreach ($config['fields'] as $key => $f) {
            [$label,$type] = $f;
            $required = $f[2] ?? false;
            $v = $d[$key] ?? null;
            $values[$key] = match ($type) {
                'checkbox'=>(int)!empty($v),
                'number'=>V::int($v ?? ($f[3] ?? 0), $label, $f[3], $f[4]),
                'select'=>V::choice($v ?? array_key_first($f[3]), array_keys($f[3]), $label),
                'relation'=>!$required && !$v ? null : V::int($v, $label, 1, 2147483647),
                'youtube'=>V::youtube($v),
                'datetime-local'=>self::date($v),
                default=>V::text($v ?? '', $label, $required ? 1 : 0, $f[3] ?? 5000)
            };
            if ($type === 'slug' && !preg_match('/^[a-z0-9]+(?:-[a-z0-9]+)*$/D', $values[$key])) {
                abort(422, 'A slug can contain lowercase letters, numbers and single hyphens.');
            }
            if ($type === 'relation' && $values[$key] && !DB::value('SELECT 1 FROM ' . $f[3] . ' WHERE id=?', [$values[$key]])) {
                abort(422, 'Choose an existing ' . $label . '.');
            }
        }
        return $values;
    }
    private static function date(mixed $v): ?string
    {
        if (!$v) {
            return null;
        }$d = \DateTimeImmutable::createFromFormat('!Y-m-d\TH:i', (string)$v, new \DateTimeZone('UTC'));
        if (!$d || $d->format('Y-m-d\TH:i') !== $v) {
            abort(422, 'Choose a valid due date.');
        }return $d->format('Y-m-d H:i:s');
    }
    public static function save(int $actor, string $resource, string $id, array $d): int
    {
        $c = self::config($resource);
        $pk = $c['pk'] ?? 'id';
        $values = self::validate($c, $d);
        return DB::transaction(function () use ($actor, $resource, $id, $d, $c, $pk, $values) {
            if (in_array($resource, ['stages','skills'], true)) {
                DB::one('SELECT id FROM learning_paths WHERE id=? FOR UPDATE', [$values['path_id']]);
            } elseif ($resource === 'lessons') {
                DB::one('SELECT p.id FROM learning_paths p JOIN stages s ON s.path_id=p.id JOIN modules m ON m.stage_id=s.id WHERE m.id=? FOR UPDATE', [$values['module_id']]);
            }
            $existing = $id === 'new' ? null : DB::one('SELECT * FROM ' . $c['table'] . ' WHERE ' . $pk . '=? FOR UPDATE', [(int)$id]);
            if ($id !== 'new' && !$existing) {
                abort(404, 'Record not found.');
            }
            if ($existing) {
                $immutableParents = ['stages' => ['path_id'],'modules' => ['stage_id'],'lessons' => ['module_id'],'skills' => ['path_id','stage_id']];
                foreach ($immutableParents[$resource] ?? [] as $field) {
                    if ((int)$values[$field] !== (int)$existing[$field]) {
                        abort(422, 'Existing hierarchy parents are fixed to protect prerequisite and progress records. Duplicate or create a new item in the desired parent.');
                    }
                }
                if ($resource === 'assignments' && DB::value('SELECT 1 FROM assignment_submissions WHERE assignment_id=? LIMIT 1', [$id])) {
                    foreach (['stage_id','lesson_id','max_score','passing_score'] as $field) {
                        if ((string)$values[$field] !== (string)$existing[$field]) {
                                                abort(422, 'Assessment location and score rules are fixed after a submission. Create a new assignment revision instead.');
                        }
                    }
                }
            }
            if ($resource === 'quizzes' && $existing && DB::value('SELECT COUNT(*) FROM quiz_attempts WHERE quiz_id=?', [$id])) {
                foreach ($values as $k => $v) {
                    if (!in_array($k, ['status','title','instructions','show_answers'], true) && (string)$v !== (string)$existing[$k]) {
                        abort(422, 'Scoring and assessment rules are locked after the first attempt. Create a new quiz revision instead.');
                    }
                }
            }
            if (in_array($resource, ['quizzes','assignments'], true) && $values['lesson_id']) {
                $stage = DB::value('SELECT m.stage_id FROM lessons l JOIN modules m ON m.id=l.module_id WHERE l.id=?', [$values['lesson_id']]);
                if ((int)$stage !== $values['stage_id']) {
                    abort(422, 'The selected lesson must belong to the selected stage.');
                }
            }
            if ($resource === 'assignments' && ($values['passing_score'] > $values['max_score'] || (!$values['allow_text'] && !$values['allow_url'] && !$values['allow_file']))) {
                abort(422, 'Use a passing score within the maximum and enable at least one submission type.');
            }
            if ($resource === 'skills' && (int)DB::value('SELECT path_id FROM stages WHERE id=?', [$values['stage_id']]) !== $values['path_id']) {
                abort(422, 'Choose a stage from the selected path.');
            }
            if ($resource === 'quizzes' && ($values['status'] ?? '') === 'published' && (!$existing || !DB::value('SELECT COUNT(*) FROM quiz_questions WHERE quiz_id=?', [$id]))) {
                abort(422, 'Save this quiz as a draft and add valid questions before publishing.');
            }
            if ($existing) {
                if ($pk === 'level' && $values['level'] !== (int)$existing['level']) {
                    abort(422, 'Create a new level rather than changing its number.');
                }$set = implode(',', array_map(fn($k)=>'`' . $k . '`=?', array_keys($values)));
                DB::run('UPDATE ' . $c['table'] . ' SET ' . $set . ' WHERE ' . $pk . '=?', [...array_values($values),(int)$id]);
                $newId = (int)$id;
            } else {
                $cols = implode(',', array_map(fn($k)=>'`' . $k . '`', array_keys($values)));
                $slots = implode(',', array_fill(0, count($values), '?'));
                $newId = DB::insert('INSERT INTO ' . $c['table'] . '(' . $cols . ') VALUES(' . $slots . ')', array_values($values));
                if ($pk === 'level') {
                    $newId = $values['level'];
                }
            }
            if ($resource === 'stages') {
                self::prerequisites($newId, V::ids($d['prerequisites'] ?? []), false);
            }
            if ($resource === 'skills') {
                DB::run('DELETE FROM skill_connections WHERE node_id=?', [$newId]);
                foreach (V::ids($d['skill_prerequisites'] ?? []) as $nid) {
                    $node = DB::one('SELECT * FROM skill_nodes WHERE id=? AND path_id=?', [$nid,$values['path_id']]);
                    if (!$node || $nid === $newId) {
                        abort(422, 'Choose another skill node in the same path.');
                    } self::checkCycle((int)$values['stage_id'], (int)$node['stage_id'], false);
                    DB::run('INSERT INTO skill_connections(node_id,prerequisite_node_id) VALUES(?,?)', [$newId,$nid]);
                }
            }
            if ($resource === 'lessons') {
                self::prerequisites($newId, V::ids($d['lesson_prerequisites'] ?? []), true);
                $items = array_slice(lines(V::text($d['checklist'] ?? '', 'Checklist', 0, 8000)), 0, 30);
                $old = DB::all('SELECT * FROM lesson_checklists WHERE lesson_id=? ORDER BY position,id', [$newId]);
                if (array_column($old, 'label') !== $items) {
                    DB::run('DELETE FROM lesson_checklists WHERE lesson_id=?', [$newId]);
                    foreach ($items as $i => $label) {
                        DB::run('INSERT INTO lesson_checklists(lesson_id,label,position) VALUES(?,?,?)', [$newId,V::text($label, 'Checklist item', 1, 500),$i]);
                    }
                }
                DB::run('DELETE FROM lesson_resources WHERE lesson_id=?', [$newId]);
                foreach (array_slice(lines(V::text($d['resources'] ?? '', 'Resources', 0, 15000)), 0, 20) as $line) {
                    $parts = explode('|', $line, 2);
                    if (count($parts) !== 2) {
                        abort(422, 'Each resource should be Title | https://example.com.');
                    }DB::run('INSERT INTO lesson_resources(lesson_id,title,url) VALUES(?,?,?)', [$newId,V::text($parts[0], 'Resource title', 1, 160),V::url(trim($parts[1]))]);
                }
            }
            if ($resource === 'assignments') {
                $rubrics = lines(V::text($d['rubrics'] ?? '', 'Rubric', 0, 8000));
                DB::run('DELETE FROM grading_rubrics WHERE assignment_id=?', [$newId]);
                $total = 0;
                foreach (array_slice($rubrics, 0, 20) as $line) {
                    $parts = explode('|', $line, 2);
                    if (count($parts) !== 2) {
                        abort(422, 'Each rubric row should be Criterion | points.');
                    }$points = V::int(trim($parts[1]), 'Rubric points', 1, 1000);
                    $total += $points;
                    DB::run('INSERT INTO grading_rubrics(assignment_id,criterion,max_points) VALUES(?,?,?)', [$newId,V::text($parts[0], 'Criterion', 1, 300),$points]);
                }if ($rubrics && $total !== $values['max_score']) {
                    abort(422, 'Rubric points must add up to the assignment’s maximum score.');
                }
            }
            audit($actor, $existing ? 'content.update' : 'content.create', $resource, $newId, ['status' => $values['status'] ?? null,'title' => $values['title'] ?? $values['name'] ?? $values['label'] ?? '']);
            return $newId;
        });
    }
    private static function prerequisites(int $id, array $required, bool $lesson): void
    {
        $table = $lesson ? 'lesson_prerequisites' : 'stage_prerequisites';
        $col = $lesson ? 'lesson_id' : 'stage_id';
        $req = $lesson ? 'required_lesson_id' : 'required_stage_id';
        $parent = $lesson ? DB::value('SELECT s.path_id FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id WHERE l.id=?', [$id]) : DB::value('SELECT path_id FROM stages WHERE id=?', [$id]);
        foreach ($required as $rid) {
            $rparent = $lesson ? DB::value('SELECT s.path_id FROM lessons l JOIN modules m ON m.id=l.module_id JOIN stages s ON s.id=m.stage_id WHERE l.id=?', [$rid]) : DB::value('SELECT path_id FROM stages WHERE id=?', [$rid]);
            if ($rid === $id || !$rparent || (int)$rparent !== (int)$parent) {
                abort(422, 'Prerequisites must be different activities within the same path.');
            }
            if ($lesson) {
                $currentStage = (int)DB::value('SELECT m.stage_id FROM lessons l JOIN modules m ON m.id=l.module_id WHERE l.id=?', [$id]);
                $requiredStage = (int)DB::value('SELECT m.stage_id FROM lessons l JOIN modules m ON m.id=l.module_id WHERE l.id=?', [$rid]);
                $ancestors = [];
                $queue = [$currentStage];
                while ($queue) {
                    $stage = array_pop($queue);
                    if (isset($ancestors[$stage])) {
                        continue;
                    }$ancestors[$stage] = true;
                    foreach (DB::all('SELECT required_stage_id AS id FROM stage_prerequisites WHERE stage_id=? UNION SELECT p.stage_id AS id FROM skill_connections c JOIN skill_nodes n ON n.id=c.node_id JOIN skill_nodes p ON p.id=c.prerequisite_node_id WHERE n.stage_id=?', [$stage,$stage]) as $upstream) {
                        $queue[] = (int)$upstream['id'];
                    }
                }
                if (!isset($ancestors[$requiredStage])) {
                    abort(422, 'A lesson prerequisite must be in the same stage or an upstream prerequisite stage, not a locked future stage.');
                }
            }
            self::checkCycle($id, (int)$rid, $lesson);
        }
        DB::run('DELETE FROM ' . $table . ' WHERE ' . $col . '=?', [$id]);
        foreach ($required as $rid) {
            DB::run('INSERT INTO ' . $table . '(' . $col . ',' . $req . ') VALUES(?,?)', [$id,$rid]);
        }
    }
    private static function checkCycle(int $id, int $required, bool $lesson): void
    {
        $queue = [$required];
        $seen = [];
        while ($queue) {
            $current = array_pop($queue);
            if ($current === $id) {
                abort(422, 'This prerequisite would create a circular dependency.');
            }if (isset($seen[$current])) {
                continue;
            }$seen[$current] = true;
            $rows = $lesson ? DB::all('SELECT required_lesson_id AS id FROM lesson_prerequisites WHERE lesson_id=?', [$current]) : DB::all('SELECT required_stage_id AS id FROM stage_prerequisites WHERE stage_id=? UNION SELECT p.stage_id AS id FROM skill_connections c JOIN skill_nodes n ON n.id=c.node_id JOIN skill_nodes p ON p.id=c.prerequisite_node_id WHERE n.stage_id=?', [$current,$current]);
            foreach ($rows as $r) {
                $queue[] = (int)$r['id'];
            }
        }
    }
    public static function questions(int $actor, int $qid, array $questions): void
    {
        DB::transaction(function () use ($actor, $qid, $questions) {
            $q = DB::one('SELECT * FROM quizzes WHERE id=? FOR UPDATE', [$qid]);
            if (!$q) {
                abort(404, 'Quiz not found.');
            }if (DB::value('SELECT COUNT(*) FROM quiz_attempts WHERE quiz_id=?', [$qid])) {
                abort(422, 'Questions are locked after the first attempt. Create a new quiz revision.');
            }if (count($questions) < 1 || count($questions) > 50) {
                abort(422, 'Add between one and fifty questions.');
            }DB::run('DELETE FROM quiz_questions WHERE quiz_id=?', [$qid]);
            foreach ($questions as $position => $question) {
                if (!is_array($question)) {
                    abort(422, 'Question data is invalid.');
                }$type = V::choice($question['type'] ?? '', ['single','multiple','boolean','short'], 'question type');
                $prompt = V::text($question['prompt'] ?? '', 'Question', 3, 3000);
                $points = V::int($question['points'] ?? 1, 'Question points', 1, 100);
                $explanation = V::text($question['explanation'] ?? '', 'Explanation', 0, 4000);
                $id = DB::insert('INSERT INTO quiz_questions(quiz_id,type,prompt,explanation,points,position) VALUES(?,?,?,?,?,?)', [$qid,$type,$prompt,$explanation,$points,$position]);
                if ($type === 'short') {
                    continue;
                }$options = $question['options'] ?? [];
                if (!is_array($options) || count($options) < 2 || count($options) > 8 || ($type === 'boolean' && count($options) !== 2)) {
                    abort(422, 'Use 2–8 options; true/false questions need exactly two.');
                }$correct = 0;
                foreach ($options as $i => $o) {
                    $label = V::text($o['label'] ?? '', 'Answer option', 1, 1000);
                    $isCorrect = (int)!empty($o['correct']);
                    $correct += $isCorrect;
                    DB::run('INSERT INTO answer_options(question_id,label,is_correct,position) VALUES(?,?,?,?)', [$id,$label,$isCorrect,$i]);
                }if (!$correct || (in_array($type, ['single','boolean'], true) && $correct !== 1)) {
                    abort(422, 'Choose the correct answer or answers for each question.');
                }
            }audit($actor, 'quiz.questions.update', 'quizzes', $qid, ['count' => count($questions)]);
        });
    }
    public static function duplicate(int $actor, int $pathId): int
    {
        return DB::transaction(function () use ($actor, $pathId) {
            $p = DB::one('SELECT * FROM learning_paths WHERE id=?', [$pathId]);
            if (!$p) {
                abort(404, 'Path not found.');
            }$copy = function (string $table, array $row, array $replace = []): int {
                unset($row['id'], $row['created_at'], $row['updated_at']);
                $row = array_replace($row, $replace);
                return DB::insert('INSERT INTO ' . $table . '(`' . implode('`,`', array_keys($row)) . '`) VALUES(' . implode(',', array_fill(0, count($row), '?')) . ')', array_values($row));
            };
            $new = $copy('learning_paths', $p, ['title' => mb_substr($p['title'], 0, 150) . ' · Copy','slug' => mb_substr($p['slug'], 0, 175) . '-' . bin2hex(random_bytes(4)),'status' => 'draft']);
            $stageMap = [];
            $lessonMap = [];
            foreach (DB::all('SELECT * FROM stages WHERE path_id=?', [$pathId]) as $s) {
                $sid = $copy('stages', $s, ['path_id' => $new]);
                $stageMap[$s['id']] = $sid;
                foreach (DB::all('SELECT * FROM modules WHERE stage_id=?', [$s['id']]) as $m) {
                    $mid = $copy('modules', $m, ['stage_id' => $sid]);
                    foreach (DB::all('SELECT * FROM lessons WHERE module_id=?', [$m['id']]) as $l) {
                        $lid = $copy('lessons', $l, ['module_id' => $mid,'status' => 'draft']);
                        $lessonMap[$l['id']] = $lid;
                        foreach (['lesson_resources','lesson_checklists'] as $table) {
                            foreach (DB::all('SELECT * FROM ' . $table . ' WHERE lesson_id=?', [$l['id']]) as $row) {
                                        $copy($table, $row, ['lesson_id' => $lid]);
                            }
                        }
                    }
                }
            }
            foreach ($stageMap as $old => $newStage) {
                foreach (DB::all('SELECT required_stage_id FROM stage_prerequisites WHERE stage_id=?', [$old]) as $r) {
                    if (isset($stageMap[$r['required_stage_id']])) {
                        DB::run('INSERT INTO stage_prerequisites(stage_id,required_stage_id) VALUES(?,?)', [$newStage,$stageMap[$r['required_stage_id']]]);
                    }
                }
                foreach (DB::all('SELECT * FROM quizzes WHERE stage_id=?', [$old]) as $q) {
                    $qid = $copy('quizzes', $q, ['stage_id' => $newStage,'lesson_id' => $q['lesson_id'] ? ($lessonMap[$q['lesson_id']] ?? null) : null,'status' => 'draft']);
                    foreach (DB::all('SELECT * FROM quiz_questions WHERE quiz_id=?', [$q['id']]) as $question) {
                        $questionId = $copy('quiz_questions', $question, ['quiz_id' => $qid]);
                        foreach (DB::all('SELECT * FROM answer_options WHERE question_id=?', [$question['id']]) as $option) {
                            $copy('answer_options', $option, ['question_id' => $questionId]);
                        }
                    }
                }
                foreach (DB::all('SELECT * FROM assignments WHERE stage_id=?', [$old]) as $a) {
                    $aid = $copy('assignments', $a, ['stage_id' => $newStage,'lesson_id' => $a['lesson_id'] ? ($lessonMap[$a['lesson_id']] ?? null) : null,'status' => 'draft']);
                    foreach (DB::all('SELECT * FROM grading_rubrics WHERE assignment_id=?', [$a['id']]) as $r) {
                        $copy('grading_rubrics', $r, ['assignment_id' => $aid]);
                    }
                }
            }
            foreach ($lessonMap as $old => $newLesson) {
                foreach (DB::all('SELECT required_lesson_id FROM lesson_prerequisites WHERE lesson_id=?', [$old]) as $r) {
                    if (isset($lessonMap[$r['required_lesson_id']])) {
                                        DB::run('INSERT INTO lesson_prerequisites(lesson_id,required_lesson_id) VALUES(?,?)', [$newLesson,$lessonMap[$r['required_lesson_id']]]);
                    }
                }
            }
            $nodeMap = [];
            foreach (DB::all('SELECT * FROM skill_nodes WHERE path_id=?', [$pathId]) as $node) {
                $nodeMap[$node['id']] = $copy('skill_nodes', $node, ['path_id' => $new,'stage_id' => $stageMap[$node['stage_id']]]);
            }
            foreach ($nodeMap as $old => $newNode) {
                foreach (DB::all('SELECT prerequisite_node_id FROM skill_connections WHERE node_id=?', [$old]) as $edge) {
                    if (isset($nodeMap[$edge['prerequisite_node_id']])) {
                                        DB::run('INSERT INTO skill_connections(node_id,prerequisite_node_id)VALUES(?,?)', [$newNode,$nodeMap[$edge['prerequisite_node_id']]]);
                    }
                }
            }
            audit($actor, 'path.duplicate', 'paths', $new, ['original' => $pathId]);
            return $new;
        });
    }
}
