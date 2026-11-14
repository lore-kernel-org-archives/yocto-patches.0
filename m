Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5877.1794632209218322723
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 20:56:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=Zi2z+ywH;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso2397086a91.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 20:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794632208; x=1795237008; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rGMqTnl6c2/p7M1YOINxuS651gp8Z0PnPoot8zgyQDY=;
        b=Zi2z+ywHVbVxjYrr3QSdfvypQLosX/nDjnzNz9q60k/+gfCnDYNlf3w3Ei5MroYjV5
         LbxuapHbQUWRYrICekMmESNl6k5TOiyCMuqHYpEi6HL2h06mp9HkEXIUjTofavj5xj1U
         zZTEgjrrzydFmUp2gPNQORd+VIIfTlp3/mLKTFDbb+fJZJxwFkfLlPgCaPDfa/HMWGDV
         VXyytuXCv27DMUKzjQsoshUZVT7cAZ9m50mn19kaVU7+6BLNSTUK4jAVr1fswntbGMmi
         9893rGjFKvHL5Va/HR7gV2jclkcDuXxtiqHwXUIlTAhS64YoPeNIz6/CnTM47CA7qoZZ
         rElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794632208; x=1795237008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rGMqTnl6c2/p7M1YOINxuS651gp8Z0PnPoot8zgyQDY=;
        b=wUfD1r3oFAVv0SZMBLH8JKieGu+jXRyaLx1FIjuKQxAng4LNJ3tch54j1tBDBHImmW
         l1HAni175cpKhljkgWhyHlhnhPWGRm71M1Ms2v4RQmXFd3Xg7KXyA3syNXC/7ZkZSNE5
         dsd8iV2JJ/NbQFm+o/q+DjdwdRpYkmz4LvQBjMvGDFG/b9K7G6h1KESruIisuJTjd1JK
         mO8U6wdPP5wpKoZ5pGxndEdVFze5ZY+W3Lis+NqO3YGN3sy4PoV3SiGEsHBJgzU36VWL
         HvFrWpa2uE05qKn1gbg+aAgctEOasRGq3nW8AtPl3aBZDAVZQsKBv16fTEkQkaRT5eJI
         fGFA==
X-Gm-Message-State: APuU4Z+JdMWUobbXcGm7LOZP2Ei2wrqKGtAQ17uMqM7DXpElKCXPwa5K
	tH2kENiOc/jQdn97yUwR/ZQBW1TFGGZo7UfNdUslyVTIG5iRWZyURLoxlVnZHSKe
X-Gm-Gg: AYBFou1NJ3METyxbD0W5j8iSd9cQF8eWCrhdqOcJ9XWkVW/50TCZ1Mnkylh/gHrxWe/
	9GnXs3QLeiM8hsMCzuxPUriziz2lgcccaCHBSkSOHkv9awoga18Y+cfcQBHLiRoHt/LWSMS3lGa
	lo6A8AcGOc39fmpA/bpJOURLO0yU5bVUFiTkU7YX+RWlP+EtkB99wXe/VmjFBM5x/+dUHbQLNO0
	7zYw9rqySjh5uS229CkoWFtFZfu+QV9t9BNrsHSpIZg9esukjsQEIAD9M+0NuUEt9FyFECzfex4
	jmO8Wrgz9VQx/KosFCgaRDL3IT6VngliHa//YzRuNdDMgDq+6MP3ZWUsVxz21te04aCv2JpYCIZ
	o/vJBbS4VX7DTBFZYaMdeKVX+qvy11roz5rKyvyFDvH/3MvQGvoyy9eJ5AJeN7jJQUJ0O/G2BmG
	cbz1fwqY+lM5T40TgRpb2fhu1GB+n5fn+9F6hXC+mZjXquC3mkCBPoq/o2DTnWbHBywYKx7dG72
	nc56fxD1gErxfT8bPl/T5lfEYWzZsPGRf96Q8eyAEmMNU0kli2k8QqkI6SJDBMRJMEPyOPwPoeE
	0TSPhOr+Tpze0UGP/jxsdae2ypPipCz/2mJmCP/gdlPCtqxBXrr0jukgfPX0hA==
X-Received: by 2002:a17:90b:28cd:b0:3a5:147a:3b63 with SMTP id 98e67ed59e1d1-3b1b087c1c9mr4150883a91.8.1794632208499;
        Fri, 13 Nov 2026 20:56:48 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae8be5adsm7333912a91.0.2026.11.13.20.56.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 20:56:47 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] layerindex: wait for a running update in the Update Layer button
Date: Fri, 13 Nov 2026 20:56:44 -0800
Message-ID: <20261114045644.91749-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 04:56:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5367
Content-Type: text/plain; charset="utf-8"

When another update held the layer index lock, e.g. the regular full
update, the update started by the Update Layer button gave up after 30
seconds. Wait up to 12 hours instead. While waiting, lock_file() retried
without pausing, using a whole CPU, and logged every 5 seconds; have it
pause between tries, and log once and then once a minute, so that the
task page shows that the update is waiting for another one.

[YOCTO #15395]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
This applies on top of "[PATCH 0/3] Fix the Update Layer button" (bug
15395), and on master-next. It is the part of the bug about waiting
for a running update.

Tested on a test instance with a Celery worker: with the layer index
lock held for 100 seconds, the Update Layer button's task log showed
"Waiting for another update to finish" at 0 and 60 seconds, and the
update then ran and succeeded. Before, it failed with "Layer index lock
timeout expired" after 30 seconds.

 layerindex/utils.py         | 12 ++++++------
 layerindex/views.py         |  4 +++-
 tests/test_update_button.py |  2 ++
 tests/test_utils.py         | 24 ++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/layerindex/utils.py b/layerindex/utils.py
index fd29de0..f10c501 100644
--- a/layerindex/utils.py
+++ b/layerindex/utils.py
@@ -451,8 +451,7 @@ class ListHandler(logging.Handler):
 
 def lock_file(fn, timeout=30, logger=None):
     start = time.time()
-    last = start
-    counter = 1
+    last = None
     while True:
         lock = open(fn, 'w')
         try:
@@ -463,11 +462,12 @@ def lock_file(fn, timeout=30, logger=None):
             current = time.time()
             if current - start > timeout:
                 return None
-            # Print a message in every 5 seconds
-            if logger and (current - last > 5):
+            # Say why we are waiting, then once a minute
+            if logger and (last is None or current - last >= 60):
                 last = current
-                logger.info('Trying to get lock on %s (tried %s seconds) ...' % (fn, (5 * counter)))
-                counter += 1
+                logger.info('Waiting for another update to finish (lock %s held, waited %d of up to %d seconds) ...'
+                            % (fn, current - start, timeout))
+            time.sleep(1)
 
 def unlock_file(lock):
     fcntl.flock(lock, fcntl.LOCK_UN)
diff --git a/layerindex/views.py b/layerindex/views.py
index e7728ca..8584620 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -147,7 +147,9 @@ def update_layer_view(request, template_name, branch='master', slug=None):
 
     from celery import uuid
 
-    cmd = 'layerindex/update.py --layer %s --branch %s --update %%update%%;' % (layeritem.name, branch)
+    # Wait for an update that is already running (e.g. the regular full
+    # update, which can take hours) rather than failing after 30 seconds
+    cmd = 'layerindex/update.py --layer %s --branch %s --update %%update%% --timeout 43200;' % (layeritem.name, branch)
 
     task_id = uuid()
     # Create this here first, because inside the task we don't have all of the required info
diff --git a/tests/test_update_button.py b/tests/test_update_button.py
index bb3b84a..cde153f 100644
--- a/tests/test_update_button.py
+++ b/tests/test_update_button.py
@@ -40,6 +40,8 @@ def test_update_layer_creates_one_update(staff_client, monkeypatch):
     assert Update.objects.filter(task_id=task_id).exists()
     # update.py records its work in the view's Update rather than a new one
     assert '--update %update%' in cmd
+    # and waits for an update that is already running
+    assert '--timeout 43200' in cmd
 
 
 @pytest.mark.django_db
diff --git a/tests/test_utils.py b/tests/test_utils.py
index 95b5e04..396d5ef 100644
--- a/tests/test_utils.py
+++ b/tests/test_utils.py
@@ -43,6 +43,30 @@ def test_is_deps_satisfied(fake_bb, req_ver, collections, expected):
     assert utils.is_deps_satisfied('core', req_ver, collections) is expected
 
 
+def test_lock_file_waits_without_spinning(tmp_path, caplog):
+    # [YOCTO #15395] the Update Layer button waits for a running update
+    import fcntl
+    import logging
+    import threading
+    import time
+    fn = str(tmp_path / 'layerindex.lock')
+    held = open(fn, 'w')
+    fcntl.flock(held, fcntl.LOCK_EX)
+    logger = logging.getLogger('test')
+    with caplog.at_level(logging.INFO):
+        start, cpu = time.time(), time.process_time()
+        assert utils.lock_file(fn, timeout=2, logger=logger) is None
+        assert time.time() - start >= 2
+        assert time.process_time() - cpu < 0.5
+    assert len([r for r in caplog.records if 'Waiting for another update' in r.message]) == 1
+
+    threading.Timer(1, lambda: fcntl.flock(held, fcntl.LOCK_UN)).start()
+    lock = utils.lock_file(fn, timeout=10)
+    assert lock is not None
+    utils.unlock_file(lock)
+    held.close()
+
+
 def make_layer(path):
     (path / 'conf').mkdir(parents=True)
     (path / 'conf' / 'layer.conf').write_text('')

base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
prerequisite-patch-id: 23026c7697b245494ae240bea1d68b9fcaa8ba63
prerequisite-patch-id: 26ce753e3fb271485dbcf24e2c2e518acb4bcb82
prerequisite-patch-id: 74a73c75f97102b56617334eff8faae8c94e24df
-- 
2.56.0

