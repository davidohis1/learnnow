-- Essential security identities belong to installation, not optional curriculum seeding.
-- Names, not assumed numeric IDs, bind permissions. Existing installations are preserved.
INSERT IGNORE INTO roles(name) VALUES ('learner'),('administrator'),('reviewer');
INSERT IGNORE INTO permissions(name) VALUES ('admin.access'),('content.manage'),('users.manage'),('roles.manage'),('review.manage'),('settings.manage'),('certificates.manage'),('community.manage'),('reports.view');
INSERT IGNORE INTO role_permissions(role_id,permission_id)
SELECT r.id,p.id FROM roles r CROSS JOIN permissions p
WHERE r.name='administrator' AND p.name IN ('admin.access','content.manage','users.manage','roles.manage','review.manage','settings.manage','certificates.manage','community.manage','reports.view');
INSERT IGNORE INTO role_permissions(role_id,permission_id)
SELECT r.id,p.id FROM roles r CROSS JOIN permissions p
WHERE r.name='reviewer' AND p.name IN ('admin.access','review.manage');
