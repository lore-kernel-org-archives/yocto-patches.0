Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F640CCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:56:56 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7909.1792288615609425654
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:56:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=C/9jiHlV;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso700006a91.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288615; x=1792893415; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F+SJRMHXb8EKEjoPyoR8Q8txy2y7N4LB/sfn+2fGL+g=;
        b=C/9jiHlVMF2ctrfa2oTCTWdrV9hM3OzMJ6nCD/4TY+h6KlrYom5JEwJKxfn09GERJc
         BFgYRd/jO+VgO1FZe1O8DIds8QrHvoui3rffd7Q7Z/hRlZqAGD6Ye8S3dxfWhQOh4MLK
         z6oIo3ojCqcEOUTDSaWLrbLUceGjIs/Bbaf8/FT4jbM0CayRQE8EullO2qDK35Zi5Vjq
         3rKqHYq7jff4/n2DfEj292Gmr+JDfUPcVXhBU4HY7frJbCgiqCmcwoaefh+dkzfU8Mhg
         tjU69d9DyazDZkD9T416lsdr/Ag3leT8tCVOdCPNHbyiIiYx3rkFlTkZz5yW6gFMR19H
         ZyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288615; x=1792893415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F+SJRMHXb8EKEjoPyoR8Q8txy2y7N4LB/sfn+2fGL+g=;
        b=ZWjLNjN/+swHe04hfWSAYZKv53I1BbTbWCYntkoFUiLOKWliz3DnpwfcKP0sRRK1yj
         AGwx1c9gMcO/5sCvliZcpJTOSGljoEBWEYXXwqPuqJq9jAsTlJYJP0kxv71D5sRnMuz8
         sgTh94HTk7Zc/EorrRyBDF/QeYi4E9gphW3MnuVfS0PCbEOsPT3jMOIEC0mY8Ja7l4yu
         S6+YZE8kbhAXuCZSMCVBmEjgrTNBXiS6i/hOy2Jw+CeXzSApqFtBAz67LEbyZnI4T5l9
         jqKxCtmdAjqYXGnmaf1qOSPczZ1oTSoT+rJTNnK2NLv7sV8gEizh2Ur/ndkKDPwfyiFq
         3dQQ==
X-Gm-Message-State: AFq9FYKQMZafCC0qbn8gBTL1+0PJI1ycjc8ON0BBWhsKSlKZLdaeepwj
	DlRTkKO4rkqss+F/hWnFuxQEZF7hxMQ84jAZBy6IsB7215jRH5ITkWnAv4l44Gro
X-Gm-Gg: AYBFou3hM+VgNLpXcVhEM1Mu8TYoUOVFHeTpkeFm4OkPwA3Wio6ovYy0Ya/ygPWDA/W
	jRaJZMVevgKy2UmlP+Fylfocek2G91LH2YoIJKoGr0xNxW98Ofe/niLDnfZKDIrz60JvIN/mI2j
	A5S+wZI0ZScHD2b3abNK2O2bD2ZmnV8MxpJxkPK85XbPrNvxpPLOF5XUK9AJ9Vv/X9WyzSqiP63
	OEVKqmJLEPyH4sHsgya98S5ZNg1nnB67y80rAlt9C8BnfTD2sao3V26S3zF4r/S6ILCyZq4b8+C
	SvI4aGlayMYHL4zZG4cN3Ro/M9ZpkRsRW1ktzbD0X4v97fBfHjEUz+xHh7zpn6+pZ2JqXKS4eSa
	6HS7rTP+mfwDzzDp6lyaW5iMmLd5NAlB42GBLn/50TsENpmpGkrNMpNwikZk4lB9uyY40trOzBJ
	Z9XarkJ0uWsbymwPAqxhlE7hOK7wMzvxG9djhZK9ySU619Z3Do5nazy45Xnl0KTSXULbkUBj7Pj
	+ee5cwl2LgKP+HzOLzuhOwsRUwECP4=
X-Received: by 2002:a17:90b:28d0:b0:3ab:189b:6981 with SMTP id 98e67ed59e1d1-3acef51e8e7mr3415263a91.48.1792288614916;
        Sat, 17 Oct 2026 18:56:54 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05fb680sm6135920a91.2.2026.10.17.18.56.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:56:53 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 2/2] Read security settings from the environment and expect a proxy.
Date: Sat, 17 Oct 2026 18:54:40 -0700
Message-ID: <20261018015615.74684-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018015615.74684-1-tim.orling@konsulko.com>
References: <20261018015615.74684-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:56:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5060

Fixes the remaining check --deploy warnings, in both settings files.
DEBUG, ALLOWED_HOSTS and SECRET_KEY (now required) come from the
environment. Behind a TLS proxy that sets X-Forwarded-Proto, cookies are
secure and HSTS is sent unless DEBUG. W008 (the proxy redirects) and
W005/W021 (the domain owner's call) are silenced. run-tests.sh runs
check --deploy so new warnings fail CI.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Post/test.py               |  5 +++++
 README                     |  5 ++++-
 docker/run-tests.sh        |  7 ++++---
 project/settings.py        | 20 ++++++++++++++++++--
 project/settings.py.docker | 20 ++++++++++++++++++--
 5 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/Post/test.py b/Post/test.py
index 28982e4..f48beec 100755
--- a/Post/test.py
+++ b/Post/test.py
@@ -273,6 +273,11 @@ class CSPTest(TestCase):
         self.assertEqual(response['X-Content-Type-Options'], 'nosniff')
         self.assertEqual(response['Referrer-Policy'], 'same-origin')
 
+    def test_hsts_only_over_https_from_proxy(self):
+        self.assertNotIn('Strict-Transport-Security', self.client.get('/Statistics/'))
+        response = self.client.get('/Statistics/', HTTP_X_FORWARDED_PROTO='https')
+        self.assertEqual(response['Strict-Transport-Security'], 'max-age=31536000')
+
     def test_csp_report_only(self):
         with override_settings(CONTENT_SECURITY_POLICY_REPORT_ONLY=True):
             # New client so the middleware picks up the setting
diff --git a/README b/README
index fb38a66..a7bb64c 100644
--- a/README
+++ b/README
@@ -23,7 +23,10 @@ Setup instructions:
 1. Initialise and activate a python virtual environment. `virtualenv venv && source ./venv/bin/activate`
 2. Install the dependencies via `pip install -r requirements.txt`
 3. Set DATABASES.default.ENGINE in settings.py to use the database engine of your choice.
-4. Set a SECRET_KEY in settings.py
+4. Set the SECRET_KEY environment variable, for example
+   `export SECRET_KEY=$(python3 -c "import secrets; print(secrets.token_urlsafe(50))")`.
+   Set DEBUG=1 for development, and ALLOWED_HOSTS to a comma-separated list of
+   the host names the site is served as (default: localhost,127.0.0.1).
 5. Setup the database schema with the Django model. Run `python manage.py migrate`.
 
 
diff --git a/docker/run-tests.sh b/docker/run-tests.sh
index 2eafd98..be1faeb 100755
--- a/docker/run-tests.sh
+++ b/docker/run-tests.sh
@@ -25,8 +25,9 @@ until docker exec $DB mysql -h127.0.0.1 -uroot -ptestingpw -e 'SELECT 1' >/dev/n
     sleep 1
 done
 
-# -Wa shows deprecation warnings, i.e. what breaks on the next Django.
+# Fail on deployment warnings (hence the random key); -Wa shows deprecations.
 docker run --rm --network $NET \
-    -e SECRET_KEY=ci-only \
+    -e SECRET_KEY="$(head -c 48 /dev/urandom | base64)" \
     -e MYSQL_DATABASE=errorreport -e MYSQL_USER=root -e MYSQL_PASSWORD=testingpw \
-    "$IMAGE" python3 -Wa manage.py test --noinput Post
+    "$IMAGE" sh -c 'python3 manage.py check --deploy --fail-level WARNING &&
+        python3 -Wa manage.py test --noinput Post'
diff --git a/project/settings.py b/project/settings.py
index 97c179c..12f7f1c 100644
--- a/project/settings.py
+++ b/project/settings.py
@@ -6,7 +6,11 @@
 
 import os
 
-DEBUG = True
+# DEBUG=1 for development; off by default.
+DEBUG = os.environ.get('DEBUG', '').lower() in ('1', 'true', 'yes')
+
+# Comma-separated.
+ALLOWED_HOSTS = [h for h in os.environ.get('ALLOWED_HOSTS', 'localhost,127.0.0.1').split(',') if h]
 
 ADMINS = (
     # ('Your Name', 'your_email@example.com'),
@@ -129,7 +133,7 @@ STATICFILES_FINDERS = (
 )
 
 # Make this unique, and don't share it with anybody.
-SECRET_KEY = 'changeme'
+SECRET_KEY = os.environ['SECRET_KEY']
 
 MIDDLEWARE = [
     'django.middleware.security.SecurityMiddleware',
@@ -209,6 +213,18 @@ LOGGING = {
 
 BUGZILLA_URL = 'https://bugzilla.yoctoproject.org'
 
+# Expects a proxy that terminates TLS, redirects to HTTPS and sets
+# X-Forwarded-Proto, overwriting the client's.
+SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
+SESSION_COOKIE_SECURE = not DEBUG
+CSRF_COOKIE_SECURE = not DEBUG
+SECURE_HSTS_SECONDS = 0 if DEBUG else 31536000
+SILENCED_SYSTEM_CHECKS = [
+    'security.W008',  # the proxy redirects to HTTPS
+    'security.W005',  # HSTS includeSubDomains and preload are
+    'security.W021',  # the domain owner's call
+]
+
 EMAIL_HOST = 'localhost'
 DEFAULT_FROM_EMAIL = 'noreply@example.com'
 
diff --git a/project/settings.py.docker b/project/settings.py.docker
index 70c9253..e1f9812 100644
--- a/project/settings.py.docker
+++ b/project/settings.py.docker
@@ -6,7 +6,11 @@
 
 import os
 
-DEBUG = True
+# DEBUG=1 for development; off by default.
+DEBUG = os.environ.get('DEBUG', '').lower() in ('1', 'true', 'yes')
+
+# Comma-separated.
+ALLOWED_HOSTS = [h for h in os.environ.get('ALLOWED_HOSTS', 'localhost,127.0.0.1').split(',') if h]
 
 ADMINS = (
     # ('Your Name', 'your_email@example.com'),
@@ -123,7 +127,7 @@ STATICFILES_FINDERS = (
 )
 
 # Make this unique, and don't share it with anybody.
-SECRET_KEY = os.environ.get('SECRET_KEY', 'changeme')
+SECRET_KEY = os.environ['SECRET_KEY']
 
 MIDDLEWARE = [
     'django.middleware.security.SecurityMiddleware',
@@ -203,6 +207,18 @@ LOGGING = {
 
 BUGZILLA_URL = 'https://bugzilla.yoctoproject.org'
 
+# Expects a proxy that terminates TLS, redirects to HTTPS and sets
+# X-Forwarded-Proto, overwriting the client's.
+SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
+SESSION_COOKIE_SECURE = not DEBUG
+CSRF_COOKIE_SECURE = not DEBUG
+SECURE_HSTS_SECONDS = 0 if DEBUG else 31536000
+SILENCED_SYSTEM_CHECKS = [
+    'security.W008',  # the proxy redirects to HTTPS
+    'security.W005',  # HSTS includeSubDomains and preload are
+    'security.W021',  # the domain owner's call
+]
+
 EMAIL_HOST = 'localhost'
 DEFAULT_FROM_EMAIL = 'noreply@example.com'
 
-- 
2.56.0


