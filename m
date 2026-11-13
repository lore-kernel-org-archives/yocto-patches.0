Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1895.1794612507500781188
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 15:28:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=WUbuprJY;
 spf=pass (domain: gmail.com, ip: 209.85.215.171, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cddc597d062so1290645a12.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 15:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794612507; x=1795217307; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PACwRzpR9Bs5dS2AbPTW6J7/q/A2iGukOTfcFZM6xh8=;
        b=WUbuprJY+CkDNqtcqEbBx/kOTwR0ux7TvOLhSZHXpU81qauRBPJYo6HlNLf1viRAKl
         I5Zgtdoufirk72Ksf97ztm9gbyob/tCz28t9W0UiJi4pfyQeIzOihCftfPnIljk/xob2
         IwqImi4pYnjYKeaEtzbCeGgsloTzSJt2s+COg81MIj3JETUgu1GmjPBQt3u4zWgquO3m
         pToLA7l6GThGV94YfI4cyrjV51W6CbP0Sy7IYoct+jtRo5+4Wy0wq6EmXpUjI9Y3kwBV
         +5jr+QtCaKihq3ygrtk6URWZ8g89fNCXiXthx6f4RVDnmF4o4x2hQ8/tzLfEHZeF+L0K
         PKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794612507; x=1795217307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PACwRzpR9Bs5dS2AbPTW6J7/q/A2iGukOTfcFZM6xh8=;
        b=BSESI+0kjfoPe6Edcrx3cu2uLRFtIxic9yYszuKy6A2AZ8TyEsiBOJH8PoK6lYcnAq
         ROJKSHrWd18ayNMp80MlqzhZ3nF5wind4smk4gPu0+qFUiaekb9uBI2Jt/z04uAhfUc9
         k+S77bmENqnxqE9uAphxPUYyUXO5LlcWYFp6QSPls6Hg130fmt4dwik+8JwgCp5onlgK
         5SSygHVInYBk4PB+2rq+1qFtIx73gs3Gw19GJkFwyi+dJ8QRn8B8p4ouSrG4QtGLdLsi
         340SIYtZ/gcw4JQBVeObkV/CE8eS9TJJ97zoYPVy6RoMX4nFHEkc5AXbzt6jYYb+wSCt
         ReFA==
X-Gm-Message-State: APuU4Z+0bWXfNPc3DvmZOojHCPJOpP9WNgR8z8ZXtB5aUe/3gH9CmX/Z
	OZcv38nCAUtVvQ9xtRrwGaCNfhkdxPkt+Tl8KpQoRDeIv6BFMa131BxZ8z9kMw==
X-Gm-Gg: AYBFou0wiOCw2MYyjR2Q9gyBSHpgzlUXh9eNnSumC/bucI1RLHuY9i404XfC7zJS28k
	9kLHykhM3KG/059d3jR92F6rNbAT+Od4a8Qqibrihyot99XhiFgVIoQid2jtnB2FnQXLVqYen35
	+kp1754O+vd6Sdh7d6CEy+XhvLIfAQhzmK9i8DvrgpM9htSsXkEAoQZOW0+uSKKt/ednbdgZgAA
	UNKVy+dksjQ24GLltVbd/E0aZDw3abKQqmER4rTXzxv7xzZ0lkixxEaYrJ2x7CGbz41jEdGrgY7
	mN/MmNspOgla1q9BSrOvDLU9Mp2poHExuY+V08h5jvGh562dzQcwiU044O4b2XtTOd09TA+mEUN
	FA2Qhw0sWRawxSupxO5XUSu63yGZWsVBWR74u/gvenEAqImUPgCRhFYPjdPFZYRIynwe1v9f/8z
	kq0iJAox7OPw9W9zu9vHMsS2mO7eWU7TfMx5Fh/ZzMRCFHPZYsG7u18MVMo7avMdsb5wcst6boJ
	emPSuDk2PiUJjrxGa5dIeNlFx+ihaTkxDk6iOPT/OA982B9n3rtbK2F65oFsGJFHlTxmKa+AhZE
	0few2YEXlLbxkFnzcJIjypAueO21dAispWzMLC2UQW4NqBV+39sTdMZMH4MM7g==
X-Received: by 2002:a17:90b:548e:b0:3ac:9df3:6b07 with SMTP id 98e67ed59e1d1-3b1b0b8c31emr4018624a91.24.1794612506786;
        Fri, 13 Nov 2026 15:28:26 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1bfb607e7sm1279789a91.3.2026.11.13.15.28.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 15:28:25 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 4/4] tests: add tests for the Celery tasks
Date: Fri, 13 Nov 2026 15:28:08 -0800
Message-ID: <20261113232808.96792-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113232808.96792-1-tim.orling@konsulko.com>
References: <20261113232808.96792-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 23:28:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5343
Content-Type: text/plain; charset="utf-8"

Run send_email and run_update_command in-process, so that Celery
upgrades are checked without a broker.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 tests/test_tasks.py | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 tests/test_tasks.py

diff --git a/tests/test_tasks.py b/tests/test_tasks.py
new file mode 100644
index 0000000..d4cde76
--- /dev/null
+++ b/tests/test_tasks.py
@@ -0,0 +1,39 @@
+# layerindex-web - tests for the Celery tasks in layerindex/tasks.py
+#
+# The tasks run in-process with apply(), so no broker is needed.
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+from datetime import datetime
+
+import pytest
+
+from layerindex import tasks
+from layerindex.models import Update
+
+
+def test_send_email(mailoutbox):
+    result = tasks.send_email.apply(('Subject', 'Body', 'from@example.com', ['to@example.com']))
+    assert result.successful()
+    assert len(mailoutbox) == 1
+    msg = mailoutbox[0]
+    assert (msg.subject, msg.body, msg.from_email, msg.to) == ('Subject', 'Body', 'from@example.com', ['to@example.com'])
+
+
+@pytest.mark.django_db
+@pytest.mark.parametrize('command, retcode, log', [
+    ('echo update %update% on %branch%', 0, 'update {id} on master'),
+    ('echo failed; exit 3', 3, 'failed'),
+])
+def test_run_update_command(settings, tmp_path, command, retcode, log):
+    settings.TASK_LOG_DIR = str(tmp_path / 'logs')
+    update = Update.objects.create(started=datetime.now(), task_id='test-task')
+    result = tasks.run_update_command.apply(('master', command), task_id='test-task')
+    assert result.get()['retcode'] == retcode
+    update.refresh_from_db()
+    assert update.retcode == retcode
+    assert update.log == log.format(id=update.id)
+    assert update.finished is not None
+    assert (tmp_path / 'logs' / 'task_test-task.log').exists()
-- 
2.56.0

