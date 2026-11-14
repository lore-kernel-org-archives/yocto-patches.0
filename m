Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2814.1794616251038710094
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 16:30:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=iaSgxp7g;
 spf=pass (domain: gmail.com, ip: 209.85.210.170, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so871910b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 16:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794616250; x=1795221050; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQOCk2CEQN1vobMATiYp1oJ7NLZopj2J9d7k/lDKlm8=;
        b=iaSgxp7grYQeQgtfkuSo8iFI/MXBTQ6Dbt/AA/pMqWA1bOVncl+PGmBNsrcQS1e5lr
         GAOCIjkJehJ/TUESLwEPEOmkaBbmRhhc25LvViuAarBF17spp0O9mKwAmDRkr8PUxKxL
         4snnZGl1bnwSZXQW3QQzhBid6XUMS3TNql+N2OTFH3QEl1rXQPAW2qb2Ndp2ZqPpVbv+
         L7bzXC7ugv5AFZIC0v1kGyhaj5AJ0OOMwGE5k6kVo7GjVGWJQ7eSPI361DRoLu3jZPF6
         mH2g6z1TPfbGdP/d06eSEtCzdkUmBCplZjejczcakS6AT00kxO7GIDydNuf6l2o1hRl/
         zChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794616250; x=1795221050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQOCk2CEQN1vobMATiYp1oJ7NLZopj2J9d7k/lDKlm8=;
        b=LxxM8A4xtjOffL3SpCfRIS3ShsvQj/tXIvLo8iSrIbAE5+AmOavGF89fxCVf6lZ8J8
         TZW/Z7S/7ZoZB/yt9dsQpj7qhKkbvGZPlFIyBFHYfsxYsos/vIgWtoVgr8v8UbJ6oqUx
         iMt/GZuZWS6hZ9aeYOg9d0quSxJDQXdPmSnvtFfkruTma8RyV+sQV/e0GYmDtORJtzt3
         hNRLlCB8gh0AKx1ILJXyaxu6h7fxhiZjpTzTuZIbmRxszQVTgBzu+87pssNxft0Ev7NF
         KfX0nVVC//myKGifz6bPt86OncG4+UjMmbSw5Z46ZyrpGulAkQNuLAS+ey7WvuxWl85q
         Ax3A==
X-Gm-Message-State: APuU4Z+TAL+G90ZjBcJs9La2v5J2yz9t9d3z6Y07zZ4BuZ23VBGFhYya
	WE8ul4ep5JGflKJ4bQI+RbBWMLrhSYVxx5eG90vEsN0yUnj9IhxS2F11f7xg6M1o
X-Gm-Gg: AYBFou16ZO+4Ds2AjBErHvkp/J24lyDkAlno51ovmooc/Ofd2DNvCtie6G4DCg5jV+w
	zM9foEG2M+FjcUXOxiJgfb8Xm9k593rhiPIsgAGU1DnxE4yuFbdPBcHCvr7sEd+YatuSGz2AWvF
	U94OSqi/efsrN6nB0puZa+tIhnJWDh95Q2ocYygRQdC3lWi0sysd5U8Hmu7k7/792WLimPBxf6Q
	DqKGKfrhHV++40aXD02Sk1rgvjFfZhDE564L5VUshBdp8uFglWncMZja1lKCPpY/R9DWAEEyHhH
	EpkcZy7f1QK3+fF+r/XhEGTVpj6faAEUrLZSlbhsdrCO89aUyR8IUvcb/lfTATRrsJyyd/RkIsh
	NT7Fqo9ut70+IYEk99NZ5hlhHAE5/5DTCBskvDdgtYEypbtDdlxE0TckqK4NZ+UotvPHYZBiDz/
	hOWzqom9ZENmvUtXpzIktu2aCIIRq+ZfEepfKqKaibEwULaYAig5Uoz0sWD9uHJLiLb0ebRVBnU
	XFZcc/pM2wHStWEYIsVDmG62Iti6Q+huxXP52+DkUp5c0xK7pZDDykrac/Ug1VjU1OeFtkuFYka
	LLCl4ukXV6dSZ+L4wSErVF5qTn6bvnWkRTBwhUvFqCXIAtW308z5iMkxgf+wFA==
X-Received: by 2002:a17:90b:3146:b0:3ab:f38:2b43 with SMTP id 98e67ed59e1d1-3b1b0a4513emr3630697a91.34.1794616250171;
        Fri, 13 Nov 2026 16:30:50 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec63b9bsm6684787a91.12.2026.11.13.16.30.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 16:30:49 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/3] layerindex: record Update Layer runs in a single update record
Date: Fri, 13 Nov 2026 16:30:39 -0800
Message-ID: <20261114003041.15197-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114003041.15197-1-tim.orling@konsulko.com>
References: <20261114003041.15197-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 00:30:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5347
Content-Type: text/plain; charset="utf-8"

The Update Layer button created two update records: one from the view,
with the task id and log, and another from update.py, with the layer
updates. Add a --update option to update.py, as other update tools
have, to record its work in an existing record, and use it from the
view. Save only the fields each side sets, so that the task and
update.py don't overwrite each other's changes.

[YOCTO #15395]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/tasks.py         |  6 ++--
 layerindex/update.py        | 30 +++++++++++++-----
 layerindex/views.py         |  2 +-
 tests/test_update_button.py | 62 +++++++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 10 deletions(-)
 create mode 100644 tests/test_update_button.py

diff --git a/layerindex/tasks.py b/layerindex/tasks.py
index 4af9466..b6aa0ae 100644
--- a/layerindex/tasks.py
+++ b/layerindex/tasks.py
@@ -42,7 +42,9 @@ def run_update_command(self, branch_name, update_command):
     from layerindex.models import Update
     updateobj = Update.objects.get(task_id=self.request.id)
     updateobj.started = datetime.now()
-    updateobj.save()
+    # Save only the fields set here: the update command may write to the
+    # same record (update.py --update)
+    updateobj.save(update_fields=['started'])
     output = ''
     shell = False
     if isinstance(update_command, str):
@@ -71,5 +73,5 @@ def run_update_command(self, branch_name, update_command):
         updateobj.log = output
         updateobj.finished = datetime.now()
         updateobj.retcode = retcode
-        updateobj.save()
+        updateobj.save(update_fields=['log', 'finished', 'retcode'])
     return {'retcode': retcode, 'output': erroutput}
diff --git a/layerindex/update.py b/layerindex/update.py
index ca68e3e..8a76084 100755
--- a/layerindex/update.py
+++ b/layerindex/update.py
@@ -183,6 +183,9 @@ def main():
     parser.add_option("-q", "--quiet",
             help = "Hide all output except error messages",
             action="store_const", const=logging.ERROR, dest="loglevel")
+    parser.add_option("-u", "--update",
+            help = "Record the update in this existing update record instead of creating a new one",
+            type="int", action="store", dest="update_id")
     parser.add_option("", "--keep-temp",
             help = "Preserve temporary directory at the end instead of deleting it",
             action="store_true")
@@ -267,14 +270,23 @@ def main():
     listhandler.setFormatter(logging.Formatter("%(levelname)s: %(message)s"))
     logger.addHandler(listhandler)
 
-    update = Update()
-    update.started = datetime.now()
+    if options.update_id:
+        update = Update.objects.filter(id=options.update_id).first()
+        if not update:
+            logger.error("Specified update id %s does not exist in database" % options.update_id)
+            sys.exit(1)
+    else:
+        update = Update()
+        update.started = datetime.now()
     if options.fullreload or options.reload:
         update.reload = True
     else:
         update.reload = False
     if not options.dryrun:
-        update.save()
+        if options.update_id:
+            update.save(update_fields=['reload'])
+        else:
+            update.save()
     try:
         lockfn = os.path.join(fetchdir, "layerindex.lock")
         lockfile = utils.lock_file(lockfn, options.timeout, logger)
@@ -611,10 +623,14 @@ def main():
         logger.error(traceback.format_exc().rstrip())
         sys.exit(1)
     finally:
-        update.log = ''.join(listhandler.read())
-        update.finished = datetime.now()
-        if not options.dryrun:
-            update.save()
+        # With --update, whatever runs this command (e.g. the
+        # run_update_command task) records the log and when it finished,
+        # together with the exit status
+        if not options.update_id:
+            update.log = ''.join(listhandler.read())
+            update.finished = datetime.now()
+            if not options.dryrun:
+                update.save()
 
     if not options.dryrun:
         # Purge old update records
diff --git a/layerindex/views.py b/layerindex/views.py
index 592311f..9f238fd 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -147,7 +147,7 @@ def update_layer_view(request, template_name, branch='master', slug=None):
 
     from celery import uuid
 
-    cmd = 'layerindex/update.py --layer %s --branch %s;' % (layeritem.name, branch)
+    cmd = 'layerindex/update.py --layer %s --branch %s --update %%update%%;' % (layeritem.name, branch)
 
     task_id = uuid()
     # Create this here first, because inside the task we don't have all of the required info
diff --git a/tests/test_update_button.py b/tests/test_update_button.py
new file mode 100644
index 0000000..b518bc2
--- /dev/null
+++ b/tests/test_update_button.py
@@ -0,0 +1,62 @@
+# layerindex-web - tests for the Update Layer button and its task status page
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+from datetime import datetime
+
+import pytest
+from django.urls import reverse
+
+from layerindex import tasks, views
+from layerindex.models import Branch, LayerBranch, LayerItem, Update
+
+
+@pytest.fixture
+def staff_client(client, django_user_model):
+    user = django_user_model.objects.create_user('staff', 'staff@example.com', 'pw', is_staff=True)
+    client.force_login(user)
+    return client
+
+
+@pytest.mark.django_db
+def test_update_layer_creates_one_update(staff_client, monkeypatch):
+    branch, _ = Branch.objects.get_or_create(name='master', defaults={'bitbake_branch': 'master'})
+    layer = LayerItem.objects.create(name='meta-test', status='P', layer_type='A',
+                                     summary='test', description='test',
+                                     vcs_url='git://example.com/meta-test.git')
+    LayerBranch.objects.create(layer=layer, branch=branch)
+    queued = []
+    monkeypatch.setattr(views.tasks.run_update_command, 'apply_async',
+                        lambda args, task_id: queued.append((args, task_id)))
+    before = Update.objects.count()
+
+    response = staff_client.get(reverse('update_layer', args=('master', 'meta-test')))
+
+    assert response.status_code == 302
+    (branch_name, cmd), task_id = queued[0]
+    assert Update.objects.count() == before + 1
+    assert Update.objects.filter(task_id=task_id).exists()
+    # update.py records its work in the view's Update rather than a new one
+    assert '--update %update%' in cmd
+
+
+@pytest.mark.django_db
+def test_run_update_command_keeps_fields_set_by_command(settings, tmp_path, monkeypatch):
+    settings.TASK_LOG_DIR = str(tmp_path)
+    update = Update.objects.create(started=datetime.now(), task_id='test-task')
+
+    def fake_runcmd(cmd, destdir, outfile, shell):
+        # Stands in for update.py --update, writing to the same record
+        assert cmd == 'update.py --update %d' % update.id
+        Update.objects.filter(id=update.id).update(reload=True)
+        return 'output'
+    monkeypatch.setattr(tasks.utils, 'runcmd', fake_runcmd)
+
+    tasks.run_update_command.apply(('master', 'update.py --update %update%'), task_id='test-task')
+
+    update.refresh_from_db()
+    assert update.reload
+    assert (update.log, update.retcode) == ('output', 0)
+    assert update.finished is not None
-- 
2.56.0

