Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6835.1794639623284248210
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 23:00:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=A6q1CWmt;
 spf=pass (domain: qbee.io, ip: 209.85.221.42, mailfrom: piotr@qbee.io)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-491846221ffso1691190f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 23:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1794639621; x=1795244421; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ywn2Y9//LyZSPqt4gABPt3xufwXYY5Lfg9uabyuAyzk=;
        b=A6q1CWmtTW4w8+rB9UG664Y7kg37NJYlLA9OMk6DIHDuRa6xSkV0/JfIFC32lnAOGi
         lbQu85My9j1/7CV3O2P7MA3S5aKx8THkc5PsMMcZcytXlKamq5BCY3zOgoZuyGfipS0i
         Je/G6suKeuNKVD67DqEBd9q3xtvAA1pQmp6fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794639621; x=1795244421;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ywn2Y9//LyZSPqt4gABPt3xufwXYY5Lfg9uabyuAyzk=;
        b=GkNMrSP3veb9YCrbB9oDGtMmiKnj/aE5z4VRkYxtaMjllSD4555w2nM7+j8WfeKCTQ
         g9T6cZdKF31eAyAWS1iU6QeVjka0n2ik3mW284Zru4VxR4CejzJv97dDIc6eMCXB1V+S
         2T11SFO1WwFsl/gN0KaWyO0IBsFgMKJKEYi97Q5T181rJhcxFWLzZ/FxlDGYW2I6D/pr
         Ewq3G+EF28AB31a42EwjvxMUsOPEs+b8nnGqUoMHxkmWqHFWhJCgoxydcLJBPILRrvin
         D2gvlN60eFljKu+DhTyWHontAUn+gvHIugGeFtH9hSF9w93LyrARtv/8s7OKpfywgngn
         IP0w==
X-Gm-Message-State: APuU4Z8U6dop3sJFtOfjAaBTfMMOT3UqmYeaAve+C/+lbDrtU8AverFU
	upgP9zmarCo3gQV+4NrhD1lXKoE/ENIjog+xqlXIJYPxcyChvqgk/FQLNjGi37c5COZ0itHSaAV
	m8/EDR0I=
X-Gm-Gg: AYBFou0Qg9lfS9Ja3jvdT4Nsybv3xPvbjkOwusRlcCCE8vtO8y8lJqJEOyOTESL4rU5
	jf1v9OPDUGZB6rgfnh9XIGdtuQIbgylrcftZu8FGuGKt2k88pvnW0EvzmajLVj5ZoW0EqnCHNRG
	qxJOXX9x44f22CsfSKD/+A3yf8xgMWAiABnfa0s46UEW4pri413u31a0m/pzYr6OJKVrthh8IHr
	UWE+wEa7P1kx+24E+kONRbq+RiIXTmX1p4r0qsTQ2ygzUmOe2og2gCCNpVuJuu8dRvo4NMq3AuL
	Q7ikukFheaiqRdTb04vBr+qiqEGUgDUBvhIGMgapKmyGoSckG1PT7NSFufGHcwVUuLje88u8k7k
	vDmg8hcHBwBh0h3hEd5DzuNfF27gG4e6PjV7ZDkImu65pCv/NHXj5c7NDQrck6V0Kewn/jeiqFO
	UUHofuSQjvjXtOpTclbQFVPzlSY9XAI/aW2yH8JRbnItoYqjACNbSnIawG1oyE0R4F7XzXngTSC
	nlj3Yqdh2KqgxkDoZTr//yxI1mr31/7GbyS65bbmeU1MnnFiLlWTVzWvzN/ocHrYSONQbfNCvYK
	fv/YXP3lqUstm+u8LiddK4d1C/ZuSPrN4gNBPQCx1Ef3H0xI9PXUZPbqK3zCEw6GekYB8MMu6Ah
	hs5NjYw==
X-Received: by 2002:a05:6000:428a:b0:491:8462:20be with SMTP id ffacd0b85a97d-49c70de380emr11044416f8f.12.1794639620390;
        Fri, 13 Nov 2026 23:00:20 -0800 (PST)
Return-Path: <piotr@qbee.io>
Received: from localhost ([9.246.55.32])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-49c60f8d615sm9500117f8f.56.2026.11.13.23.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 23:00:19 -0800 (PST)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>,
	"Claude Fable 5.2" <noreply@anthropic.com>
Subject: [layerindex-web][PATCH] tests/test_update.py: stop rewriting settings.py
Date: Sat, 14 Nov 2026 08:00:13 +0100
Message-ID: <20261114070013.40715-1-piotr@qbee.io>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 07:00:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5374
Content-Type: text/plain; charset="utf-8"

The update tests launch import_layer.py and update.py as separate
processes, which read the settings afresh and so would connect to the
real database instead of the test database the tests look in. To avoid
that, the tests appended the test database configuration to settings.py
in the source tree and restored the file afterwards.

That only works when the scripts load that file. In the dev container
DJANGO_SETTINGS_MODULE is docker.settings, so the appended configuration
is ignored and the scripts import the test layers into the development
database. An interrupted run also leaves settings.py modified.

Take the database name in docker/settings.py from a new DATABASE_NAME
environment variable, defaulting to "layersdb" as before, in the same
way as the user, password, host and port. In the tests, replace the
fixtures that rewrote settings.py with one that sets DATABASE_NAME to
the name of the test database for the scripts to inherit.

Tested by running tests/test_update.py in a copy of the tree with a
separate LAYER_FETCH_DIR, both with DJANGO_SETTINGS_MODULE set to
docker.settings and with docker/settings.py copied to settings.py as in
the Docker image: all 5 tests pass, the settings files are unchanged
and nothing is added to the development database. The remaining 89
tests still pass.

Signed-off-by: Piotr Buliński <piotr@qbee.io>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 docker/settings.py   |  2 +-
 tests/test_update.py | 30 +++++++++++++-----------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/docker/settings.py b/docker/settings.py
index a610052..30c47d8 100644
--- a/docker/settings.py
+++ b/docker/settings.py
@@ -18,7 +18,7 @@ MANAGERS = ADMINS
 DATABASES = {
     'default': {
         'ENGINE': 'django.db.backends.mysql',
-        'NAME': 'layersdb',
+        'NAME': os.getenv('DATABASE_NAME', 'layersdb'),
         'USER': os.getenv('DATABASE_USER', 'root'),
         'PASSWORD': os.getenv('DATABASE_PASSWORD', 'testingpw'),
         'HOST': os.getenv('DATABASE_HOST', 'layersdb'),
diff --git a/tests/test_update.py b/tests/test_update.py
index a0ac897..a1e409d 100644
--- a/tests/test_update.py
+++ b/tests/test_update.py
@@ -23,7 +23,6 @@
 
 import sys
 import os
-import shutil
 import subprocess
 import pytest
 
@@ -44,25 +43,22 @@ def db_access_without_rollback_and_truncate(request, django_db_setup, django_db_
     request.addfinalizer(django_db_blocker.restore)
 
 @pytest.fixture(scope="module")
-def backup_settings(tmpdir_factory):
-    stmpdir = tmpdir_factory.mktemp('settings')
-    settingsfile = os.path.join(basepath, 'settings.py')
-    backupfile = os.path.join(stmpdir, 'settings.bak')
-    shutil.copy(settingsfile, backupfile)
-    yield settingsfile
-    shutil.copy(backupfile, settingsfile)
-
-@pytest.fixture(scope="module")
-def hack_settings(backup_settings):
-    # It's horrific to have to do this, but we need to have additional
-    # scripts connect to the testing database and not whatever's in settings.py
-    # on disk right now, and this appears to be the only real way to do that
+def script_database(django_db_setup):
+    """
+    Point the scripts we launch at the test database.
+
+    The scripts run in separate processes and so read the settings afresh,
+    which would connect them to the real database. The settings take the
+    database name from DATABASE_NAME, so set that in the environment the
+    scripts inherit.
+    """
     from django.conf import settings
-    with open(backup_settings, 'a') as f:
-        f.write('\nDATABASES = %s\n' % settings.DATABASES)
+    with pytest.MonkeyPatch.context() as mp:
+        mp.setenv('DATABASE_NAME', settings.DATABASES['default']['NAME'])
+        yield
 
 @pytest.fixture(scope="module")
-def import_layer(hack_settings):
+def import_layer(script_database):
     run_cmd("layerindex/tools/import_layer.py https://git.openembedded.org/openembedded-core -s meta openembedded-core")
     run_cmd("layerindex/tools/import_layer.py https://git.yoctoproject.org/meta-layerindex-test -s meta-layerindex-test")
     run_cmd("layerindex/update.py -l meta-layerindex-test")
-- 
2.34.1

