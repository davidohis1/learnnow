"""Build isolated Apache fixtures; never copy private user data or start a daemon here.
Requires Debian/Ubuntu apache2 + libapache2-mod-php8.4 for this test harness only.
The application itself does not require root privileges or an Apache installation script.
"""
from pathlib import Path
import json, os, shutil, subprocess
ROOT=Path(__file__).resolve().parents[1]
QA=ROOT/'storage/qa-apache'
QA.mkdir(mode=0o700,parents=True,exist_ok=True)
php="require 'app/bootstrap.php'; $v=[]; foreach(['APP_KEY','DB_SOCKET','DB_HOST','DB_PORT','DB_USERNAME','DB_PASSWORD'] as $k)$v[$k]=env($k); echo json_encode($v);"
values=json.loads(subprocess.check_output(['php','-r',php],cwd=ROOT,text=True))
for directory,base in [(QA/'root-app','http://127.0.0.1:8083'),(QA/'webroot/classroom/skills','http://127.0.0.1:8084/classroom/skills')]:
    directory.mkdir(parents=True,exist_ok=True)
    for folder in ['app','bin','config','database','public','routes','vendor']:
        shutil.copytree(ROOT/folder,directory/folder,dirs_exist_ok=True)
    for filename in ['index.php','.htaccess','composer.json','composer.lock']:
        shutil.copy2(ROOT/filename,directory/filename)
    for folder in ['logs','uploads','mail']:
        (directory/'storage'/folder).mkdir(mode=0o700,parents=True,exist_ok=True)
    env={**values,'APP_ENV':'testing','APP_URL':base,'COOKIE_SECURE':'false','DB_DATABASE':'learnow_refactor_test','MAIL_ENABLED':'false','DEFAULT_TIMEZONE':'Africa/Lagos'}
    (directory/'.env').write_text('\n'.join(f'{k}="{v}"' for k,v in env.items())+'\n');os.chmod(directory/'.env',0o600)
(QA/'run').mkdir(exist_ok=True)
subprocess.run(['openssl','req','-x509','-newkey','rsa:2048','-nodes','-days','2','-subj','/CN=localhost','-addext','subjectAltName=DNS:localhost,IP:127.0.0.1','-keyout',str(QA/'tls-key.pem'),'-out',str(QA/'tls-cert.pem')],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL,check=True)
os.chmod(QA/'tls-key.pem',0o600)
modules=['mpm_prefork','authz_core','authz_host','dir','mime','env','rewrite','alias','socache_shmcb','ssl']
conf=f'''ServerRoot "{QA}"
PidFile "{QA}/httpd.pid"
DefaultRuntimeDir "{QA}/run"
ServerName localhost
Listen 127.0.0.1:8083
Listen 127.0.0.1:8084
Listen 127.0.0.1:8443
User {os.environ.get('USER','user')}
Group {os.environ.get('USER','user')}
ErrorLog "{QA}/error.log"
LogLevel warn
'''
conf+='\n'.join(f'LoadModule {m}_module /usr/lib/apache2/modules/mod_{m}.so' for m in modules)
conf+=f'''
LoadModule php_module /usr/lib/apache2/modules/libphp8.4.so
AddType application/x-httpd-php .php
TypesConfig /etc/mime.types
DirectoryIndex index.php
StartServers 1
MinSpareServers 1
MaxSpareServers 2
ServerLimit 5
MaxRequestWorkers 5
php_admin_flag display_errors Off
php_admin_value upload_max_filesize 5M
php_admin_value post_max_size 6M
<Directory />
    AllowOverride None
    Require all denied
</Directory>
<Directory "{QA}/root-app/public">
    Options FollowSymLinks
    AllowOverride FileInfo
    Require all granted
</Directory>
<Directory "{QA}/webroot">
    Options FollowSymLinks
    AllowOverride FileInfo
    Require all granted
</Directory>
<VirtualHost 127.0.0.1:8083>
    DocumentRoot "{QA}/root-app/public"
</VirtualHost>
<VirtualHost 127.0.0.1:8084>
    DocumentRoot "{QA}/webroot"
</VirtualHost>
<VirtualHost 127.0.0.1:8443>
    ServerName localhost
    DocumentRoot "{QA}/webroot/classroom/skills"
    SSLEngine on
    SSLCertificateFile "{QA}/tls-cert.pem"
    SSLCertificateKeyFile "{QA}/tls-key.pem"
    SetEnv APP_ENV production
    SetEnv APP_URL https://localhost:8443/college
    SetEnv COOKIE_SECURE true
</VirtualHost>
'''
(QA/'httpd.conf').write_text(conf)
subprocess.run(['/usr/sbin/apache2','-t','-f',str(QA/'httpd.conf')],check=True)
print('Prepared private Apache root, physical-subdirectory shared-hosting, and HTTPS/prefix fixtures.')
print('Start with: /usr/sbin/apache2 -f '+str(QA/'httpd.conf')+' -DFOREGROUND')
