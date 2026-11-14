Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2783.1794616143175067252
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 16:29:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=hfLEERS5;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso2312386a91.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 16:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794616142; x=1795220942; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9WgE5gy3Hu0Xtbx25nvCcY2W4Lu7v4ByrcxaEV59bKA=;
        b=hfLEERS5xzvQpkDImnspOrMcGI/cW/8nf2Vz4h5V5mYJxJXToiXyVAT/li1sVHt1JU
         jlvPLaeODuRloO9q7F+KsSjT4y7V+X7ukXZSzBR5ec49bk3ykpdYYouF+TZle4munhHG
         6I58OULGenVmZaT4WHIyXVpl/ewwCh4a3Gyndc/eIEpjZ42jvNa06mGwKCSqEj8Q+KHc
         ME3l+euvhzsQl6fzN0iBIV568yiWT2SoCHLVhmmbaFEp1OkNWyEO3tgcCqs76lMrQrMj
         827HQgGYyaVXWBA9hUGzKQYNYvQlQJ8Z3uuAw4AWuLiMW2B8GTGUCJuyl0jcjyrrBQOt
         qjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794616142; x=1795220942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9WgE5gy3Hu0Xtbx25nvCcY2W4Lu7v4ByrcxaEV59bKA=;
        b=FRJqcOG/JTUrNctH9WnYWxUj9GcBBSXHcCLE7DzW++jxSVm5LBWyrj65DHg2WxHeSZ
         DCQDgZSvj0D3NFOedqbc0hWOCpCQDaZ/wxbU4Tb8WdHIjy0FfoS9myFLy98puhjVFkV7
         kBgk2pBFX9F0xsPLLXLyozwjxgTdpUpMXm4ffRBl98fH6xuYjwCCEmPT6actBDi2a7Ve
         /LEOhswc9MVXMeQRTQL05R6wK7zzOGz8ZKkUtcfllSLKBvSB8hzQkHs5ELKahJZ6FfI8
         rJFnM4g9TatfJbY78LiGOiCQJBk2cY0aeihJ3J9u+lNRkUaGOEkh1ps7KCApr2BhdZOY
         hudQ==
X-Gm-Message-State: APuU4Z8uPPy9w+0mpH1lPms7TRcve+Zfp/eNaEFtPbwFCi5OzfV8U0PX
	lmijsGiLVXKHiP2+xg/FJcCSkjwZztvmqfafDevgFE1NY9M7qPZeKwLaIlQkXw==
X-Gm-Gg: AYBFou2pHIsI6ZK40Jr1c89uDaSsJpCNhhZnWvuCfShzgPilPT9XYYIp0oiZtJvnuMx
	WoMqcUo146XUu7tigdN0qR6gWUbHwy0hAuZlGIvOqoUQ8XoaHxhGjfgS8LTj747t2idI5xcI3IY
	MDgHutbjNu0c/jsgpMNc/4pyV9ijkxxGN0a21iWlTMVvXuaMjRH9iNLIABCraQv5KgjygN8hNex
	4zBKDKneipNbY0Y2SRKr3zqaja2tmp0LR1n4A1HmUNtITXYEOY+mCv7IPeq143QKj391q+n0D4Y
	/i4wIpjoO/H8DJ1sIcM9opsGsLmSJ9CgCinlaACz6Wbl+jcETh5AhEhBzrJbzV9Kd1Rcw8znZQF
	o9o7BQu4rYTckhfGmIO3PEci+LvJT81BVx3dn08/vUdcDwTHwYD7SnxcF/jWjPVD2ahNaF4I6W4
	s11BIqtAQzVr4c3FDtVXbfp1ZaRlB1YpGkRUwZNyatF9hGeeNZl72Vywr3GwsTlGTopARzFWuYM
	yyDgAV94s75upXDpkmXrxY8GpTi4kuFWMH1FJAksb6DTnqLyCtMWtyprGSCkyrp9bpF/a6nn9KC
	yuYdpqzzWm1vnyyHaCBLeyWFtDetKvawho3EVs9dN3s2ttEGc+t59TqCV4Zgw2E=
X-Received: by 2002:a17:90b:4c02:b0:3b1:922a:7b22 with SMTP id 98e67ed59e1d1-3b1b0d77ae9mr4007470a91.60.1794616142432;
        Fri, 13 Nov 2026 16:29:02 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec3a903sm7032062a91.8.2026.11.13.16.29.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 16:29:01 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] layerindex/tasks.py: fix loading the settings in the Celery worker
Date: Fri, 13 Nov 2026 16:28:57 -0800
Message-ID: <20261114002857.14954-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 00:29:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5345
Content-Type: text/plain; charset="utf-8"

Since "Update Django settings import to use the correct form"
(dc63275), the worker fails to start unless DJANGO_SETTINGS_MODULE is
set: importing django.conf never raises ImportError, so
utils.setup_django() is no longer called, and reading the broker
setting fails. Set DJANGO_SETTINGS_MODULE as setup_django() does.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
Found while adding RabbitMQ and a Celery worker to a test instance: the
worker exited with ImproperlyConfigured on startup. The Docker setups
don't set DJANGO_SETTINGS_MODULE, so a deployment of current master has
no working worker (no Update Layer button, no email).

 layerindex/tasks.py      | 12 +++++-------
 tests/test_celery_app.py | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 7 deletions(-)
 create mode 100644 tests/test_celery_app.py

diff --git a/layerindex/tasks.py b/layerindex/tasks.py
index 4af9466..5bd40a8 100644
--- a/layerindex/tasks.py
+++ b/layerindex/tasks.py
@@ -16,13 +16,11 @@ import subprocess
 import shlex
 from datetime import datetime
 
-try:
-    from django.conf import settings
-except ImportError:
-    # not in a full django env, so settings is inaccessible.
-    # setup django to access settings.
-    utils.setup_django()
-    from django.conf import settings
+# The Celery worker imports this module outside Django; point it at the
+# settings, as utils.setup_django() does. (Importing django.conf always
+# succeeds; the settings are only loaded when first used.)
+os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings")
+from django.conf import settings
 
 tasks = Celery('layerindex',
     broker=settings.RABBIT_BROKER,
diff --git a/tests/test_celery_app.py b/tests/test_celery_app.py
new file mode 100644
index 0000000..bbd12a1
--- /dev/null
+++ b/tests/test_celery_app.py
@@ -0,0 +1,19 @@
+# layerindex-web - test that the Celery worker can load the task module
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import os
+import subprocess
+import sys
+
+
+def test_tasks_module_loads_without_django_settings_module():
+    # As the worker does: celery --workdir=<source> --app layerindex.tasks
+    env = {k: v for k, v in os.environ.items() if k != 'DJANGO_SETTINGS_MODULE'}
+    srcdir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
+    result = subprocess.run([sys.executable, '-c', 'import layerindex.tasks as t; print(t.tasks.conf.broker_url)'],
+                            cwd=srcdir, env=env, capture_output=True, text=True)
+    assert result.returncode == 0, result.stderr
+    assert result.stdout.startswith('amqp://')

base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
-- 
2.56.0

