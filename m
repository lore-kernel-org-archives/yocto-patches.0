Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2817.1794616253875251727
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 16:30:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=KRoa7gn8;
 spf=pass (domain: gmail.com, ip: 209.85.215.178, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso660330a12.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 16:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794616253; x=1795221053; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=emhFVJAzBMycAoeUqXgwlj0bhwRKhT/S2Rh8ambTnJ4=;
        b=KRoa7gn89e2FlDQmzmsjH2nUuZUBhlbqQsLbLqXR5sl5dow3QkiyzK84RkaWr6QTma
         UFIyqbeiyynY2oTDyOmOfNFeMyWx+N2r99GdYBBJGw3sqz0uAJUBAKQtKGZ2SD9k+6b4
         RCQY9B6v+nrcihetCBRfrWGnRB8QVBccyvxCkDW19CJIUXuE/jtBOtG+jKnC7vxkP3/p
         3gh/hAF4Ir4vzEVfmhsVYFfJURefZ7tSl5zY/bWRiWd9ewOFMsg7J0egoitHhwC2RMVR
         m2wAwgUWwFuzMqvbrtf33UeizsdcHPIdWM0YlDgx9jCrl56pDAr6L2fQI5TU63VWogBd
         XeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794616253; x=1795221053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=emhFVJAzBMycAoeUqXgwlj0bhwRKhT/S2Rh8ambTnJ4=;
        b=dJVUUB91xublhKpkFjflnsW8Vg1iPPbUCD8YiOX69o3+HDj05rXdc1kdO11ETjylUu
         le1hHvcCIlER450vEpdO499TFISdOvvCLIg3mor6hDLHo0vLQtUsVuuMTsUoM5wsYsqH
         AHhb5mCVDzhk3nJiKCz7rtj+/cAwq46nfHfqK0UeSDBlKNaOmgdKvgFcGE8khw9gG2UD
         incUjaEEOTCf6jVFuxXCRre0i01SDz5mmukfsPBbSY3fzHtl6QawnCg+FOdqr5V3M/9k
         6zK4Dmjmqs2c0mwYOBv4d8dqccKNDsyZNHvSVkcJD00lp6SHL2FHMzar0Hl8nTOh8Ta+
         XGCg==
X-Gm-Message-State: APuU4Z/toyKHVSRvEO7cm3s9v78zfX1H9f+yhdz1ydkKMiJTwnZ2baNH
	1bj6HoMIJ8s0R6q/WhdvnUaCcj2NIOnfGUGG5rQHaiAIJMFyXdgJEwHCEJZcFQ==
X-Gm-Gg: AYBFou26Kd+7X6wO5V20WlF655cQqGkj5Uabibnuz8wK5OunU1Qfk5Ct659GOBijpkR
	DxATZala+bxIl2li8XMUL/GeOVTnJaAJjLHdfYCOvisnLTT/9sb1OwZW0M3tAbuQp4R8SRw4mya
	XX++zxJIihDiLVS8jV87iKbU8z5opyX+GhakX279IH7sHWUxY5GTL+yE4dCspav1kF2u84YejhA
	RYvkMd1AXGjr6fINZZxABmDwy1QJ02BF2w7X76E6gYv0sw4g/yBLm4nIBNl7tFtEJUeky4FD6uS
	3eMMRhn8m6/GJzxeKbQ0c1R/pvV0ujAp7RhvS9CvdmNbFEMfgY7z6+CxnWooJoenbe/+OJBQ5OR
	UyHOH4ZSushuGAgZMmdGboyf2BVXp8t+J42Z0OH1rMhikSLJM9jvRhFWKUDITmUzrf51lWusysa
	XLnUtBzBMIMON3/8HDhmJ7aKGhkDDjtx5y6BGiXTVwO+HJJy/rTZS0Q5OZFrAoL3mBTaM0Ky3kW
	he02ojH0rhnu6OaWMg2oWE4LAMCCruwAhg/LKbw1MnS6jqxa9grBzZ5qAZnGWgf7ujYrDK/C/BY
	hevHEmoUovVHp3ehkwi4XwxvVwZFW0EvL5EfEgyqNRhuc1WldOTuvdjAsXpxnja4HjMlxM2qgw7
	M1dooDJg=
X-Received: by 2002:a17:90a:d2c7:b0:3a8:86b7:ad95 with SMTP id 98e67ed59e1d1-3b1b0cabc2dmr3792262a91.60.1794616253024;
        Fri, 13 Nov 2026 16:30:53 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec63b9bsm6684787a91.12.2026.11.13.16.30.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 16:30:51 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/3] layerindex/views: fix the live log on the task status page
Date: Fri, 13 Nov 2026 16:30:40 -0800
Message-ID: <20261114003041.15197-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114003041.15197-1-tim.orling@konsulko.com>
References: <20261114003041.15197-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 00:31:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5348
Content-Type: text/plain; charset="utf-8"

The task status page showed the log as a Python bytes literal, because
escape() no longer decodes bytes since Django 3.0, and did not see the
task finish when the poll reached another process than the one that
started it, because the rpc:// result backend only returns results to
that process. Decode the log, and take whether the task finished and
its exit status from the update record, which the task already sets.

[YOCTO #15395]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/views.py         | 24 ++++++++----------------
 tests/test_update_button.py | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/layerindex/views.py b/layerindex/views.py
index 9f238fd..e7728ca 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -1671,7 +1671,6 @@ class TaskStatusView(TemplateView):
         return context
 
 def task_log_view(request, task_id):
-    from celery.result import AsyncResult
     if not request.user.is_authenticated:
         raise PermissionDenied
 
@@ -1679,7 +1678,11 @@ def task_log_view(request, task_id):
         # Block anything that looks like a path
         raise Http404
 
-    result = AsyncResult(task_id)
+    # The task records when it finished and its result in the Update. Read
+    # that before the log, which is complete by the time it is set. (The
+    # Celery result backend is no use here: with rpc:// only the process
+    # that started the task can read the result.)
+    updateobj = get_object_or_404(Update, task_id=task_id)
     start = int(request.GET.get('start', 0))
     try:
         f = open(os.path.join(settings.TASK_LOG_DIR, 'task_%s.log' % task_id), 'rb')
@@ -1693,24 +1696,13 @@ def task_log_view(request, task_id):
         datastr = re.sub(b'\n[^\n]+\r', b'\n', datastr)
         # We need to escape this or else things that look like tags in the output
         # will be interpreted as such by the browser
-        data = escape(datastr)
+        data = escape(datastr.decode('utf-8', errors='replace'))
         response = HttpResponse(data)
-        try:
-            ready = result.ready()
-        except ConnectionResetError:
-            # FIXME this shouldn't be happening so often, but ultimately we don't care -
-            # the frontend is polling so it'll likely succeed in a subsequent request
-            ready = False
-        if ready:
+        if updateobj.finished:
             response['Task-Done'] = '1'
-            updateobj = get_object_or_404(Update, task_id=task_id)
             response['Task-Duration'] = utils.timesince2(updateobj.started, updateobj.finished)
             response['Task-Progress'] = 100
-            if result.info:
-                if isinstance(result.info, dict):
-                    response['Task-Result'] = result.info.get('retcode', None)
-                else:
-                    response['Task-Result'] = -1
+            response['Task-Result'] = updateobj.retcode
         else:
             response['Task-Done'] = '0'
             preader = utils.ProgressReader(settings.TASK_LOG_DIR, task_id)
diff --git a/tests/test_update_button.py b/tests/test_update_button.py
index b518bc2..bb3b84a 100644
--- a/tests/test_update_button.py
+++ b/tests/test_update_button.py
@@ -60,3 +60,25 @@ def test_run_update_command_keeps_fields_set_by_command(settings, tmp_path, monk
     assert update.reload
     assert (update.log, update.retcode) == ('output', 0)
     assert update.finished is not None
+
+
+@pytest.mark.django_db
+@pytest.mark.parametrize('finished, retcode, done, result', [
+    (False, 0, '0', None),
+    (True, 0, '1', '0'),
+    (True, 2, '1', '2'),
+])
+def test_task_log_reports_status_from_update(client, django_user_model, settings, tmp_path,
+                                             finished, retcode, done, result):
+    settings.TASK_LOG_DIR = str(tmp_path)
+    (tmp_path / 'task_test-task.log').write_text('line 1 <b>\n', encoding='utf-8')
+    Update.objects.create(started=datetime.now(), task_id='test-task', retcode=retcode,
+                          finished=datetime.now() if finished else None)
+    client.force_login(django_user_model.objects.create_user('user', 'user@example.com', 'pw'))
+
+    response = client.get(reverse('task_log', args=('test-task',)))
+
+    assert response.status_code == 200
+    assert response.content == b'line 1 &lt;b&gt;\n'
+    assert response['Task-Done'] == done
+    assert response.get('Task-Result') == result
-- 
2.56.0

