<?php
require __DIR__.'/bootstrap.php';
use Learnow\Repositories\DB;
$action=$argv[1]??'setup';
if($action==='jwt'){echo \Firebase\JWT\JWT::encode(json_decode($argv[2],true),env('APP_KEY'),$argv[3]??'HS256');exit;}
if($action==='sql') { $query=$argv[2]??'';$params=json_decode($argv[3]??'[]',true);$result=DB::run($query,$params);echo json_encode($result->columnCount()?$result->fetchAll():['count'=>$result->rowCount(),'id'=>DB::pdo()->lastInsertId()],JSON_THROW_ON_ERROR);exit; }
if($action!=='setup')exit(1);
foreach(['administrator'=>'admin','reviewer'=>'reviewer','learner'=>'learner'] as $role=>$name){$email=$name.'@test.learnow.invalid';$uid=(int)DB::value('SELECT id FROM users WHERE email=?',[$email]);if(!$uid){$uid=fixtureUser('Test '.$name,$role);DB::run('UPDATE users SET email=? WHERE id=?',[$email,$uid]);} }
DB::run('DELETE FROM rate_limits');
echo "Isolated HTTP fixtures ready. These are test accounts, not public learner activity.\n";
