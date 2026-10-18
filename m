Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C33CCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 21:49:13 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22363.1792360149157268072
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 14:49:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ZInbTq4f;
 spf=pass (domain: gmail.com, ip: 209.85.214.180, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e987a2ba0cso11583235ad.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792360148; x=1792964948; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WQH47KL4K4DKWgIzpb/JB6x+bhWd+t/PX5zj04kV7a8=;
        b=ZInbTq4fjxhMnhy5LGtlrre519s9wOlSKR/5tXwm2NpUtX/AJqCce8E92dZx1glgL3
         BAMXC38ZBMCg+/KGFy+MXjS7X6Fpo+ft/LKHDTaNc4IcxKnd6XrR/uLGkDYFzCsPdDcS
         Vfn5grz7LsTlFVLJgqGTQ+UpYx+X4Za4XdiZdPToGBxmPUgqmdCMEhYcTVZv6lJS8z3h
         DddZBOc036ONgjxT+mqV+gO664WNB5KCjK3s0Hj0b9V8MHkyV5iSGadj13XwrNBTMBNi
         XfU0X5JLQIR3U1WbWJE60YXxIOnvM67+Z0QUg5Jg/INcSrhBBom0cPr4fLohiQdhpOav
         +xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792360148; x=1792964948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WQH47KL4K4DKWgIzpb/JB6x+bhWd+t/PX5zj04kV7a8=;
        b=cKuhbOPmz2bK/fLQbP7kmzVZTnuaw+NEymkdKy4kdF3bAnes64T2RzxRNyTC+799qI
         ZThmbMosA37MW/PVXKe0F22Q2BrX40AxGcCkaKU9wYhII0/tktfbEpg/bpeSsa6YQGUu
         YmE3HE//0KP22g6nZMT0sN7S6JcNh3v+O4EbFmglMvF+JDruqInYOBBQBR+ulaAOn1D0
         ti4SePIXyTkGV0oSc0OO2hMOG9pSj2ABQ0ftdrY/DBbc9sqPlvRrog7zP4ySFftohqFU
         aJjX6b8oTc5lJtmJrvAf2niXF7UXVtXOSKC062A5b3bR1emzOmfNMqVkLjrApyCiZX/o
         Hynw==
X-Gm-Message-State: AFq9FYJr8GzZkdS09GCJEXP4HHTutUqOC2rqZvPORf6sAJXfNjyOwabE
	ffvABAfwtZpegfKPVUy6aFWibjJKbfz3+5ei9WQFhi0JmX0WViVsp/1QM+wTppT3
X-Gm-Gg: AYBFou1e0273h8OI3jGOZm1l7qGe+HVJwT3w1t1ipLgHQA25TzcbIPMp0g7NJ9ENCzT
	vJGMU2+ju8M9Xm72tjdSnt8UyIEbzlMpGtTsxZ+C5CGwc5hgi4ZZW35T/Ju69egG3dRouJvojZb
	YaU9cZulXFdUcNx7wItGk5NmNZKqFsTFrElFhzvrWNeLVfIlF6bvc5Z8bnNUpMJcQXcDiZKphkp
	9pgyBqxgc3p3NsTilCmsj6Lp8PBkCaR5dR+xntWbfc0L4AvtWH0mbK188h4b2y/WolD279X0VsZ
	vTnI8XsKDQtH77l8rqie1C0qibB5pE8oHbfVCJW29vkVs4CYdw9AxHVgv8JM0x9yTmPgqXMaO6/
	epK0KMDRkkyB1pDdCOSpzk58aXtKdNZsLFQbD7dlCNnXPFur3CIC2rKzfvW1C737NxPQPucVa7o
	RRXf3RbyUGIhGGzMl44khhI+gDGxYBDpkirkX4wuRAwfvK+nmsbbsmegd0FSdTvYEkMHVcWKMPi
	vDm/ZjHi7x54z3ZwHrUfW0EoKYXD54=
X-Received: by 2002:a05:6a20:43a2:b0:3e2:2221:182f with SMTP id adf61e73a8af0-3e225fb5cddmr4782346637.46.1792360148340;
        Sun, 18 Oct 2026 14:49:08 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a04493551csm2010759b3a.44.2026.10.18.14.49.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 14:49:07 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/3] dockersetup.py: use "docker compose" when it is available
Date: Sun, 18 Oct 2026 14:48:47 -0700
Message-ID: <20261018214847.69431-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018214847.69431-1-tim.orling@konsulko.com>
References: <20261018214847.69431-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 21:49:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5080

dockersetup.py ran the standalone docker-compose command, which current
Docker Engine and Docker Desktop installs no longer provide: Compose v2
is a Docker CLI plugin run as "docker compose", and the old Python
docker-compose reached end of life in 2023. Use "docker compose" when
"docker compose version" works, and fall back to docker-compose
otherwise, for every Compose call the script makes and in the
project name hint it prints at the end.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 dockersetup.py            | 55 ++++++++++++++++++++++++++-------------
 tests/test_dockersetup.py | 25 ++++++++++++++++++
 2 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/dockersetup.py b/dockersetup.py
index e58cff2..eb02f33 100755
--- a/dockersetup.py
+++ b/dockersetup.py
@@ -30,6 +30,7 @@ if sys.version_info < min_version:
 
 import os
 import argparse
+import functools
 import re
 import subprocess
 import time
@@ -61,7 +62,7 @@ def get_args():
     parser.add_argument('--email-ssl', action="store_true", default=False, help='Use SSL when connecting to email host')
     parser.add_argument('--email-tls', action="store_true", default=False, help='Use TLS when connecting to email host')
     parser.add_argument('-m', '--portmapping', type=str, help='Port mapping in the format HOST:CONTAINER. Default is %(default)s', required=False, default='8080:80,8081:443')
-    parser.add_argument('--project-name', type=str, help='docker-compose project name to use')
+    parser.add_argument('--project-name', type=str, help='Docker Compose project name to use')
     parser.add_argument('--no-https', action="store_true", default=False, help='Disable HTTPS (HTTP only) for web server')
     parser.add_argument('--cert', type=str, help='Existing SSL certificate to use for HTTPS web serving', required=False)
     parser.add_argument('--cert-key', type=str, help='Existing SSL certificate key to use for HTTPS web serving', required=False)
@@ -496,7 +497,7 @@ def setup_https(hostname, http_port, https_port, letsencrypt, letsencrypt_produc
     edit_nginx_ssl_conf(hostname, https_port, container_cert_dir, certfile, keyfile)
 
     if letsencrypt:
-        return_code = subprocess.call(['docker-compose', 'up', '-d', '--build', 'layersweb'], shell=False)
+        return_code = subprocess.call(compose('up', '-d', '--build', 'layersweb'), shell=False)
         if return_code != 0:
             print("docker-compose up layersweb failed")
             sys.exit(1)
@@ -515,7 +516,7 @@ def setup_https(hostname, http_port, https_port, letsencrypt, letsencrypt_produc
             shutil.rmtree(os.path.join(local_cert_dir, 'live'))
 
             # Create a test file and fetch it to ensure web server is working (for http)
-            return_code = subprocess.call("docker-compose exec -T layersweb /bin/sh -c 'mkdir -p /var/www/certbot/.well-known/acme-challenge/ ; echo something > /var/www/certbot/.well-known/acme-challenge/test.txt'", shell=True)
+            return_code = subprocess.call(compose_sh() + " exec -T layersweb /bin/sh -c 'mkdir -p /var/www/certbot/.well-known/acme-challenge/ ; echo something > /var/www/certbot/.well-known/acme-challenge/test.txt'", shell=True)
             if return_code != 0:
                 print("Creating test file failed")
                 sys.exit(1)
@@ -523,7 +524,7 @@ def setup_https(hostname, http_port, https_port, letsencrypt, letsencrypt_produc
             if return_code != 0:
                 print("Reading test file from web server failed")
                 sys.exit(1)
-            return_code = subprocess.call(['docker-compose', 'exec', '-T', 'layersweb', '/bin/sh', '-c', 'rm -rf /var/www/certbot/.well-known'], shell=False)
+            return_code = subprocess.call(compose('exec', '-T', 'layersweb', '/bin/sh', '-c', 'rm -rf /var/www/certbot/.well-known'), shell=False)
             if return_code != 0:
                 print("Removing test file failed")
                 sys.exit(1)
@@ -536,7 +537,7 @@ def setup_https(hostname, http_port, https_port, letsencrypt, letsencrypt_produc
             email_arg = '--email %s' % quote(emailaddr)
         else:
             email_arg = '--register-unsafely-without-email'
-        return_code = subprocess.call('docker-compose run --rm --entrypoint "\
+        return_code = subprocess.call(compose_sh() + ' run --rm --entrypoint "\
   certbot certonly --webroot -w /var/www/certbot \
     %s \
     %s \
@@ -549,7 +550,7 @@ def setup_https(hostname, http_port, https_port, letsencrypt, letsencrypt_produc
             sys.exit(1)
 
         # Stop web server (so it can effectively be restarted with the new certificate)
-        return_code = subprocess.call(['docker-compose', 'stop', 'layersweb'], shell=False)
+        return_code = subprocess.call(compose('stop', 'layersweb'), shell=False)
         if return_code != 0:
             print("docker-compose stop failed")
             sys.exit(1)
@@ -613,7 +614,7 @@ def write_service_env_files(dbpassword, dbapassword, secretkey, rmqpassword, ema
 
 
 def check_connectivity(app_dir='/opt'):
-    return_code = subprocess.call(['docker-compose', 'run', '--rm', 'layersapp', app_dir + '/connectivity_check.sh'], shell=False)
+    return_code = subprocess.call(compose('run', '--rm', 'layersapp', app_dir + '/connectivity_check.sh'), shell=False)
     if return_code != 0:
         print("Connectivity check failed - if you are behind a proxy, please check that you have correctly specified the proxy settings on the command line (see --help for details)")
         sys.exit(1)
@@ -631,6 +632,24 @@ def writefile(filename, data):
         f.write(data)
 
 
+# The Docker Compose command to use: the "docker compose" plugin that current
+# Docker installs provide, or else the older standalone docker-compose
+@functools.lru_cache(maxsize=None)
+def compose_command():
+    try:
+        if subprocess.call(['docker', 'compose', 'version'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL) == 0:
+            return ('docker', 'compose')
+    except FileNotFoundError:
+        pass
+    return ('docker-compose',)
+
+def compose(*args):
+    return list(compose_command()) + list(args)
+
+def compose_sh():
+    return ' '.join(compose_command())
+
+
 # Read the database root password of an existing installation, from
 # .env.local.db or, for installations made before it existed, from
 # docker-compose.yml. Returns the development default if neither has one.
@@ -775,7 +794,7 @@ provide information as needed.
                 print('Entered email address is not valid')
 
     if args.reinstall or args.uninstall:
-        return_code = subprocess.call(['docker-compose', 'down', '-v'], shell=False)
+        return_code = subprocess.call(compose('down', '-v'), shell=False)
 
     if args.uninstall:
         # We're done
@@ -807,7 +826,7 @@ provide information as needed.
             setup_https(args.hostname, http_port, https_port, args.letsencrypt, args.letsencrypt_production, args.cert, args.cert_key, emailaddr, args.app_dir)
 
     ## Start up containers
-    return_code = subprocess.call(['docker-compose', 'up', '-d', '--build'], shell=False)
+    return_code = subprocess.call(compose('up', '-d', '--build'), shell=False)
     if return_code != 0:
         print("docker-compose up failed")
         sys.exit(1)
@@ -818,7 +837,7 @@ provide information as needed.
 
     # Get real project name (if only there were a reasonable way to do this... ugh)
     real_project_name = ''
-    output = subprocess.check_output(['docker-compose', 'ps', '-q'], shell=False)
+    output = subprocess.check_output(compose('ps', '-q'), shell=False)
     if output:
         output = output.decode('utf-8')
         for contid in output.splitlines():
@@ -844,7 +863,7 @@ provide information as needed.
         env = os.environ.copy()
         env['MYSQL_PWD'] = dbapassword
         # Dummy command, we just want to establish that the db can be connected to
-        return_code = subprocess.call("echo | docker-compose exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb", shell=True, env=env)
+        return_code = subprocess.call("echo | " + compose_sh() + " exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb", shell=True, env=env)
         if return_code == 0:
             break
         else:
@@ -866,7 +885,7 @@ provide information as needed.
                 catcmd = 'cat'
             env = os.environ.copy()
             env['MYSQL_PWD'] = dbapassword
-            return_code = subprocess.call("%s %s | docker-compose exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb" % (catcmd, quote(args.databasefile)), shell=True, env=env)
+            return_code = subprocess.call("%s %s | %s exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb" % (catcmd, quote(args.databasefile), compose_sh()), shell=True, env=env)
             if return_code != 0:
                 print("Database import failed")
                 sys.exit(1)
@@ -876,7 +895,7 @@ provide information as needed.
         env = os.environ.copy()
         env['DATABASE_USER'] = 'root'
         env['DATABASE_PASSWORD'] = dbapassword
-        return_code = subprocess.call(['docker-compose', 'run', '--rm', '-e', 'DATABASE_USER', '-e', 'DATABASE_PASSWORD', 'layersapp', args.app_dir + '/migrate.sh'], shell=False, env=env)
+        return_code = subprocess.call(compose('run', '--rm', '-e', 'DATABASE_USER', '-e', 'DATABASE_PASSWORD', 'layersapp', args.app_dir + '/migrate.sh'), shell=False, env=env)
         if return_code != 0:
             print("Applying migrations failed")
             sys.exit(1)
@@ -894,7 +913,7 @@ provide information as needed.
             # (avoids password being visible through ps or /proc/<pid>/cmdline)
             env = os.environ.copy()
             env['MYSQL_PWD'] = dbapassword
-            return_code = subprocess.call("docker-compose exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb < " + quote(sqlscriptfile), shell=True, env=env)
+            return_code = subprocess.call(compose_sh() + " exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb < " + quote(sqlscriptfile), shell=True, env=env)
             if return_code != 0:
                 print("Creating database user failed")
                 sys.exit(1)
@@ -916,7 +935,7 @@ provide information as needed.
                 sys.exit(1)
 
     ## Generate static assets. Run this command again to regenerate at any time (when static assets in the code are updated)
-    return_code = subprocess.call("docker-compose run --rm -e STATIC_ROOT=/usr/share/nginx/html -v %s_layersstatic:/usr/share/nginx/html layersapp %s/layerindex/manage.py collectstatic --noinput" % (quote(real_project_name), args.app_dir), shell = True)
+    return_code = subprocess.call(compose_sh() + " run --rm -e STATIC_ROOT=/usr/share/nginx/html -v %s_layersstatic:/usr/share/nginx/html layersapp %s/layerindex/manage.py collectstatic --noinput" % (quote(real_project_name), args.app_dir), shell = True)
     if return_code != 0:
         print("Collecting static files failed")
         sys.exit(1)
@@ -937,12 +956,12 @@ provide information as needed.
     if not args.update:
         if not args.databasefile:
             ## Set site name
-            return_code = subprocess.call(['docker-compose', 'run', '--rm', 'layersapp', args.app_dir + '/layerindex/layerindex/tools/site_name.py', host, 'OpenEmbedded Layer Index'], shell=False)
+            return_code = subprocess.call(compose('run', '--rm', 'layersapp', args.app_dir + '/layerindex/layerindex/tools/site_name.py', host, 'OpenEmbedded Layer Index'), shell=False)
 
         if not args.no_admin_user:
             ## For a fresh database, create an admin account
             print("Creating database superuser. Input user name and password when prompted.")
-            return_code = subprocess.call(['docker-compose', 'run', '--rm', 'layersapp', args.app_dir + '/layerindex/manage.py', 'createsuperuser', '--email', emailaddr], shell=False)
+            return_code = subprocess.call(compose('run', '--rm', 'layersapp', args.app_dir + '/layerindex/manage.py', 'createsuperuser', '--email', emailaddr), shell=False)
             if return_code != 0:
                 print("Creating superuser failed")
                 sys.exit(1)
@@ -953,7 +972,7 @@ provide information as needed.
     else:
         if args.project_name:
             print("")
-            print("NOTE: you may need to use -p %s (or set COMPOSE_PROJECT_NAME=\"%s\" ) if running docker-compose directly in future" % (args.project_name, args.project_name))
+            print("NOTE: you may need to use -p %s (or set COMPOSE_PROJECT_NAME=\"%s\" ) if running %s directly in future" % (args.project_name, args.project_name, compose_sh()))
         print("")
         print("The application should now be accessible at %s://%s" % (protocol, host))
         print("")
diff --git a/tests/test_dockersetup.py b/tests/test_dockersetup.py
index 3a6d8ff..7958946 100644
--- a/tests/test_dockersetup.py
+++ b/tests/test_dockersetup.py
@@ -156,3 +156,28 @@ def test_nginx_ssl_conf_round_trip(workdir):
     assert 'layers.openembedded.org' in (workdir / 'docker' / 'nginx-ssl.conf').read_text()
     assert dockersetup.read_nginx_ssl_conf('/opt/cert') == \
         ('layers.example.com', '8081', '/opt/cert', 'cert.pem', 'key.pem')
+
+
+@pytest.mark.parametrize('result, expected', [
+    (0, ['docker', 'compose', 'up']),
+    (1, ['docker-compose', 'up']),
+    (FileNotFoundError(), ['docker-compose', 'up']),
+])
+def test_compose_command(monkeypatch, result, expected):
+    calls = []
+
+    def fake_call(cmd, **kwargs):
+        calls.append(cmd)
+        if isinstance(result, Exception):
+            raise result
+        return result
+
+    monkeypatch.setattr(dockersetup.subprocess, 'call', fake_call)
+    dockersetup.compose_command.cache_clear()
+    try:
+        assert dockersetup.compose('up') == expected
+        assert dockersetup.compose_sh() == ' '.join(expected[:-1])
+        # Detected once and then reused
+        assert calls == [['docker', 'compose', 'version']]
+    finally:
+        dockersetup.compose_command.cache_clear()
-- 
2.56.0


