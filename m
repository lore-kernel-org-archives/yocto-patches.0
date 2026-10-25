Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16903.1792894013208805750
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 24 Oct 2026 19:06:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=M7+OjRer;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so1031610a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 24 Oct 2026 19:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792894012; x=1793498812; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hceSCJt5QvGMleZ6GAdqYk3zJeGbMsTNnmPle+tplQQ=;
        b=M7+OjRer1nv8dAVnBS52WQdhupOoF/BvU68cSMIec3B/NrIqSFurHHQMYtHWS8Wvkw
         IP4agpFgSCiD0v4TBIZXgv4EBm0NssB8kOTpLAh6S0byjEz3Rq6/UQNmi301vAFTXStn
         p4u6uGfl9fobIqmoF2GjT7vJ2brjK15GBaNGeVib91FzGRzeXfyVeg3sDpFaIoyi7jrC
         /iFts13BHs9rgGeoARmZ7Go0g7lGL89TZlMFP85be4UPR8klWx7CqlDIp5uaGyDNRtem
         fRSJ0G0xlIbml65YCw+C4sjUU+boO/VTdjiOifKbWnETPmOIwX+VMWFq9YAIn6tqxcsU
         U5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894012; x=1793498812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hceSCJt5QvGMleZ6GAdqYk3zJeGbMsTNnmPle+tplQQ=;
        b=wLEJcCC6e3+oU3E4B0x9DEHGXEjMUigGkBZtigKTdOndhR60iPJyTaDJhW18C+YexE
         yRU5+J3DqseoqfRCjdbbmG+WysW56Qeh3nl/et6wBUP3vdeXvta0SZMNQG59QGHlz+kE
         29lxSxdzSba47LkyphWMPPE8s0HIHjAK3ILiQRLBCVvXRNB1c0AdX05mZUpCZXem4kcT
         YCgz2zaAvE7lL2zFtaPIVv8XDBevDY38sU+xaSgKavcZnWrkftZqkGTkonLOVFYHSVIo
         YvwtfBHG9roWVKrrUv31muO0tYSglAFGBM3sqeWyy9BRIrnEua7sqv7ynFlWcWob11Be
         YsrA==
X-Gm-Message-State: AFq9FYKjQGaVebde8TyNr6hE2F6xt/m5i+eT8XgER3vM7hjbaVZlKEp+
	2xrULspDKq4T5L9TUeU57eEu8bekJLiLSmTuXh1L+8DGWi/873NQU8P2g6JGoL7g
X-Gm-Gg: AYBFou37Zc3ed/X4qU9bkC83vJA9jlniu9Ov1akA4vkokTSpFwfpdiUa7vkjmPkGN/f
	tAjCKhDiOnIkRaeN3nflNBMa8GefX8D5Kdzsrr8NDLTGafuyHlm9bfm9TQYP+AwethtZ4uog0Ci
	cZtr4EWDBJKf/dx6La+h6wi29i0rSCYtx5MArs36O3EpBEidHtOomN7cymCXKyG/JFUv4okv7C3
	SeZzGoSfYl6CEXeOYy1kCzCZnhNthIDuRmi/mGbPdMXMl2X5fD1/yAcf1dmR2rA8FZ072IWdJ38
	AoQ2mkar/bl/66eROIU09bSwbtnCM8rcdS8KyzUGEr7Ub523fxZ2MCba8BpM8e0nf31FgdCzZzN
	NOB5nVnLOKDoET2wqgEgK83uhw+20zROHfIjBIo1nFCZ5KUpuofIXw8mRLotOPtZRYpoMp0vavl
	UODkgNANMROKYpk2zDstg+8Va/b5j/z0iF2zwCeYhqvLisdDUpX2suPslW1OuQbZ5UGcNU2hNhn
	kD3mhL6h26n/qeoXAZUNyLmd8hzWdvMFc274CGaxjB1/j8H3RqutnQxS6IA9Ahd1PV2nxKpWGUL
	9Oq6VJ1nvuEu
X-Received: by 2002:a17:90b:4985:b0:3ab:413:49b6 with SMTP id 98e67ed59e1d1-3adeae6d3c3mr2718095a91.41.1792894012225;
        Sat, 24 Oct 2026 19:06:52 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0718esm3966914a91.11.2026.10.24.19.06.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 19:06:51 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/2] dockersetup: trust the site's own origin for CSRF
Date: Sat, 24 Oct 2026 19:06:45 -0700
Message-ID: <20261025020646.89376-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 25 Oct 2026 02:07:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5149
Content-Type: text/plain; charset="utf-8"

A default dockersetup.py install serves the site on https://localhost:8081,
but CSRF_TRUSTED_ORIGINS only allowed https://localhost, so logging in
failed with "Origin checking failed" (403). Let CSRF_TRUSTED_ORIGINS be
set from the environment, and have dockersetup.py write the URL the site
is served on, including any non-standard port, to .env.local.app.

[YOCTO #15329]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .env.dev.app              |  1 +
 docker/settings.py        |  4 +++-
 dockersetup.py            | 30 ++++++++++++++++--------------
 tests/test_dockersetup.py | 19 +++++++++++++++++++
 4 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/.env.dev.app b/.env.dev.app
index 9f8fb5a..a268cdc 100644
--- a/.env.dev.app
+++ b/.env.dev.app
@@ -11,4 +11,5 @@ RABBITMQ_DEFAULT_PASS=guest
 #EMAIL_PASSWORD=<set this here if needed>
 #EMAIL_USE_SSL=<set this here if needed>
 #EMAIL_USE_TLS=<set this here if needed>
+#CSRF_TRUSTED_ORIGINS=<set this if the site is not served on https://HOSTNAME>
 DEBUG=1
diff --git a/docker/settings.py b/docker/settings.py
index e18a9c2..a610052 100644
--- a/docker/settings.py
+++ b/docker/settings.py
@@ -314,7 +314,9 @@ TOOLS_LOG_DIR = ""
 
 USE_X_FORWARDED_HOST = True
 ALLOWED_HOSTS = [os.getenv('HOSTNAME', 'layers.test')]
-CSRF_TRUSTED_ORIGINS = ['https://' + os.getenv('HOSTNAME', 'layers.test')]
+# Comma-separated; set it when the site is not served on https://HOSTNAME,
+# e.g. on a non-standard port
+CSRF_TRUSTED_ORIGINS = (os.getenv('CSRF_TRUSTED_ORIGINS') or 'https://' + os.getenv('HOSTNAME', 'layers.test')).split(',')
 SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
 SECURE_BROWSER_XSS_FILTER = True
 SECURE_CONTENT_TYPE_NOSNIFF = True
diff --git a/dockersetup.py b/dockersetup.py
index eb02f33..406bdf9 100755
--- a/dockersetup.py
+++ b/dockersetup.py
@@ -582,7 +582,7 @@ def write_env_file(app_dir):
 # Write the generated secrets and email settings to .env.local.<service>,
 # starting from the tracked .env.dev.<service> defaults. These files hold
 # secrets and are ignored by git.
-def write_service_env_files(dbpassword, dbapassword, secretkey, rmqpassword, email_host, email_port, email_user, email_password, email_ssl, email_tls):
+def write_service_env_files(dbpassword, dbapassword, secretkey, rmqpassword, email_host, email_port, email_user, email_password, email_ssl, email_tls, site_origin=None):
     values = {
         'SECRET_KEY': secretkey,
         'DATABASE_USER': 'layers',
@@ -596,6 +596,7 @@ def write_service_env_files(dbpassword, dbapassword, secretkey, rmqpassword, ema
         'EMAIL_PASSWORD': email_password,
         'EMAIL_USE_SSL': str(email_ssl) if email_ssl else None,
         'EMAIL_USE_TLS': str(email_tls) if email_tls else None,
+        'CSRF_TRUSTED_ORIGINS': site_origin,
         'DEBUG': '0',
     }
     for service in ('app', 'celery', 'db', 'rabbit'):
@@ -613,6 +614,17 @@ def write_service_env_files(dbpassword, dbapassword, secretkey, rmqpassword, ema
             f.write(''.join(newlines))
 
 
+# Return the protocol and host[:port] that the site is served on
+def site_protocol_host(hostname, http_port, https_port, no_https):
+    if https_port and not no_https:
+        protocol, port, defport = 'https', https_port, '443'
+    else:
+        protocol, port, defport = 'http', http_port, '80'
+    if port == defport:
+        return protocol, hostname
+    return protocol, '%s:%s' % (hostname, port)
+
+
 def check_connectivity(app_dir='/opt'):
     return_code = subprocess.call(compose('run', '--rm', 'layersapp', app_dir + '/connectivity_check.sh'), shell=False)
     if return_code != 0:
@@ -813,7 +825,8 @@ provide information as needed.
         edit_dockerfile(args.http_proxy, args.https_proxy, args.no_proxy)
         write_env_file(args.app_dir)
 
-        write_service_env_files(dbpassword, dbapassword, secretkey, rmqpassword, email_host, email_port, args.email_user, args.email_password, args.email_ssl, args.email_tls)
+        protocol, host = site_protocol_host(args.hostname, http_port, https_port, args.no_https)
+        write_service_env_files(dbpassword, dbapassword, secretkey, rmqpassword, email_host, email_port, args.email_user, args.email_password, args.email_ssl, args.email_tls, '%s://%s' % (protocol, host))
         edit_dockercompose(args.hostname, args.portmapping, args.letsencrypt, args.app_dir)
 
         edit_dockerfile_web(args.hostname, args.no_https)
@@ -940,18 +953,7 @@ provide information as needed.
         print("Collecting static files failed")
         sys.exit(1)
 
-    if https_port and not args.no_https:
-        protocol = 'https'
-        port = https_port
-        defport = '443'
-    else:
-        protocol = 'http'
-        port = http_port
-        defport = '80'
-    if port == defport:
-        host = args.hostname
-    else:
-        host = '%s:%s' % (args.hostname, port)
+    protocol, host = site_protocol_host(args.hostname, http_port, https_port, args.no_https)
 
     if not args.update:
         if not args.databasefile:
diff --git a/tests/test_dockersetup.py b/tests/test_dockersetup.py
index 7958946..0109c80 100644
--- a/tests/test_dockersetup.py
+++ b/tests/test_dockersetup.py
@@ -77,10 +77,29 @@ def test_env_files_are_private_and_leave_unset_email_commented(workdir):
     app = read_env(workdir / '.env.local.app')
     assert 'EMAIL_HOST' not in app
     assert 'EMAIL_USE_TLS' not in app
+    assert 'CSRF_TRUSTED_ORIGINS' not in app
     # The tracked defaults are left alone
     assert read_env(workdir / '.env.dev.db')['MYSQL_ROOT_PASSWORD'] == 'testingpw'
 
 
+def test_env_files_get_site_origin(workdir):
+    # The default port 8081 is not the standard https port, so the browser
+    # sends it in the Origin header and Django's CSRF check must allow it
+    dockersetup.write_service_env_files('dbpw', 'rootpw', 'sekrit', 'mqpw', None, None,
+                                        None, None, False, False, 'https://localhost:8081')
+    assert read_env(workdir / '.env.local.app')['CSRF_TRUSTED_ORIGINS'] == 'https://localhost:8081'
+
+
+@pytest.mark.parametrize('http_port, https_port, no_https, expected', [
+    ('8080', '8081', False, ('https', 'localhost:8081')),
+    ('80', '443', False, ('https', 'localhost')),
+    ('8080', None, True, ('http', 'localhost:8080')),
+    ('80', '8081', True, ('http', 'localhost')),
+])
+def test_site_protocol_host(http_port, https_port, no_https, expected):
+    assert dockersetup.site_protocol_host('localhost', http_port, https_port, no_https) == expected
+
+
 def load_compose(workdir):
     return yaml.safe_load((workdir / 'docker-compose.yml').read_text())
 
-- 
2.56.0

