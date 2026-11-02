ALTER TABLE quiz_attempts ADD assigned_reviewer_id BIGINT UNSIGNED NULL, ADD CONSTRAINT fk_quiz_reviewer FOREIGN KEY(assigned_reviewer_id) REFERENCES users(id);
