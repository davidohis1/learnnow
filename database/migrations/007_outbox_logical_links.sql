-- Resolve queued notification URLs at delivery time so APP_URL changes do not strand queued mail.
ALTER TABLE mail_outbox ADD link VARCHAR(500) NULL;
UPDATE mail_outbox m JOIN notifications n
ON n.user_id=m.user_id AND m.dedup_key=CONCAT(n.user_id,':',n.dedup_key)
SET m.body=n.body,m.link=n.link
WHERE m.status IN ('queued','failed');
