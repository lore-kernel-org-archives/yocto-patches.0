Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7626.1794702923357278221
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 16:35:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=UPAySoeZ;
 spf=pass (domain: gmail.com, ip: 209.85.216.42, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso1183437a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 16:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794702923; x=1795307723; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5zQIlcf6igv8ZMfOTPYoi4S+xdDj9g/4a1seM7IGeaI=;
        b=UPAySoeZZgRUiHe4FE+3/9NSDuX3AHWyN5uaPC9PGKhPuM4BjqnmFyzeWkLS8aScRR
         AWHxbBgFmusWoJBv7NQ+8uKe3odq/u3unanWySxFTg6NO/5pEe3sbDo6fkOXKCDbhtFz
         DSQUuBfGsl6NzGJw3LtU2Y7XWPgOoNjX16Usaif3k91gbWb+8BmupxPZtK7xwGms0V5Z
         4mhXIeOKmp48bCEjfTImKnpONmYhnxwsmaSDiAfNkkKlqXbOrGaMa2tW/LDAh4Nxe6tc
         mpocmK+luBtS6tV0LWlooS6J9UkxnjwAHOG4+S43PzQnJkOvv0UiXfC2jGDhOEqBPmHs
         pTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702923; x=1795307723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5zQIlcf6igv8ZMfOTPYoi4S+xdDj9g/4a1seM7IGeaI=;
        b=WWqUrhQ9vSOBsDTJPq2nxJkUKu2QZdIB9Y6XQnZkb2wcLNsZ2fmyqSCX0dfclLErVR
         iiSdN9SM4r8q/NJ0htVoocyq3Duwywk5qZMI+5D+eo3qnt2WTApHjbTJMqUndXpR7E4p
         1xdzdht7DiFdMfmIzF3BGEzVf95k+B/aIZKmZ5WgSr4B9a+AAH9x47xnSlwNXwrpCzlN
         wtcjom9K2AIf5d8hEuM+O1CkFjpf1LuImDSW1V4LlweedzkCxc2E3rcR9XzMbyyolbiQ
         2c/jnuMA8XJZfJMYWTJdV2/LzQkWXX8rJ1DpzCwngCb5hUhIhCQ3PtSJjc6ldYnzPIi/
         WrQA==
X-Gm-Message-State: APuU4Z8fC0FfK9uAOApeOhE1xIKPZSm+nHXLS+wAh8siKrJngsjQX/8x
	0Exm0wUGM/JQdLZEY5WNyphXy8X7A/9N0xFbzm/OZaIg7XYq8WdUWDbkH76LZKCK
X-Gm-Gg: AYBFou2HIU1HbDrsj8jDAdYGY9e6fVuvPSwemKgXiTVnWseYKO8tjESihcIAf3OijFd
	TaZpRHStN2iSsYbBxHaBzNLagZ5zjHZyLXE6sffhuIzo9HlImXYG96Sqqc2WTFfHrUCTy3P7oh8
	Sn1lQC1d3SqKsfpOmdyeXl/MrmcHGhSMhCvNHPFt/5kJ6mq2enIwRXtav/StkvlMJLevVbKBHlg
	iNsMDKKFptvmCKjIOOgo8ISig9w1n4KkxR2SpepZXnSQAuoDbcgEn0wAS1pd2j379EN4jigRcA/
	HtXtuL8GVeOYFA8dWvtvj0eHJf8I9k6bCypUiGgPyOQoPGjeeYmKDxpoYTTsfdxkTixCvqoDevI
	7g5icdlf1tXd1STkBZivbT6ItUWwzj6M1vMIFI1o6JRF5navd/JHApeUhM5HxIxhO8INGfLK7Iz
	4nnglmI4+a7SmD1Ztpf8OUin+BPArHexYTjl+P24owdK2TzPgyUPRmr9NCedtiPcgRGoe/NTsH/
	/VjGRSsF5wtw0hSdkj08+2pnKJ29Iaq7PYkCqiOZ7LptfamdXguwwqGE3mfaVbnrExfWDKQb+ZL
	KZ2OKmfyFw03xlWDN5r5OgFVRhLD6qWPRFJgYa7nZWEB1s5FWsO9BlJ4jU+H9g==
X-Received: by 2002:a17:90b:574b:b0:3ae:2969:903f with SMTP id 98e67ed59e1d1-3b1b0b8bcb7mr6057137a91.45.1794702922483;
        Sat, 14 Nov 2026 16:35:22 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b39fb9a3sm5464089a91.3.2026.11.14.16.35.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 16:35:21 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/6] rrs/tools/common.py: don't write a log file without TOOLS_LOG_DIR
Date: Sat, 14 Nov 2026 16:35:01 -0800
Message-ID: <20261115003506.53654-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115003506.53654-1-tim.orling@konsulko.com>
References: <20261115003506.53654-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 00:35:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5379
Content-Type: text/plain; charset="utf-8"

get_logger() always added a log file at TOOLS_LOG_DIR/<name>, but
TOOLS_LOG_DIR is empty by default, so the file was created in the
current directory. In the Docker image that is /opt/layerindex, which
the layers user can't write to, so every RRS update script failed as
soon as it started. Only log to the console when TOOLS_LOG_DIR is not
set.

[YOCTO #16499]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 docker/settings.py       |  2 +-
 rrs/tools/common.py      | 16 ++++++++++------
 settings.py              |  2 +-
 tests/test_rrs_logger.py | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 8 deletions(-)
 create mode 100644 tests/test_rrs_logger.py

diff --git a/docker/settings.py b/docker/settings.py
index a610052..9f18a55 100644
--- a/docker/settings.py
+++ b/docker/settings.py
@@ -309,7 +309,7 @@ AXES_COOLOFF_TIME = 1
 # Full path to directory to store logs for dynamically executed tasks
 TASK_LOG_DIR = "/opt/layerindex-task-logs"
 
-# Full path to directory where rrs tools stores logs
+# Full path to a directory where the rrs tools also write their logs, if any
 TOOLS_LOG_DIR = ""
 
 USE_X_FORWARDED_HOST = True
diff --git a/rrs/tools/common.py b/rrs/tools/common.py
index 0cac1f7..0caf1c9 100644
--- a/rrs/tools/common.py
+++ b/rrs/tools/common.py
@@ -34,12 +34,16 @@ def get_logger(name, settings):
     handler.setFormatter(formatter)
     logger.addHandler(handler)
 
-    filename = os.path.join(settings.TOOLS_LOG_DIR, name)
-    maxBytes = 8388608 # 8MB
-    handler = RotatingFileHandler(filename, maxBytes=maxBytes)
-
-    handler.setFormatter(formatter)
-    logger.addHandler(handler)
+    # Also log to a file if a directory is set for it; otherwise the console
+    # output is all there is (as collected by cron, systemd or docker)
+    log_dir = getattr(settings, 'TOOLS_LOG_DIR', '')
+    if log_dir:
+        filename = os.path.join(log_dir, name)
+        maxBytes = 8388608 # 8MB
+        handler = RotatingFileHandler(filename, maxBytes=maxBytes)
+
+        handler.setFormatter(formatter)
+        logger.addHandler(handler)
 
     logger.setLevel(logging.INFO)
 
diff --git a/settings.py b/settings.py
index 324ad50..495af1e 100644
--- a/settings.py
+++ b/settings.py
@@ -298,5 +298,5 @@ AXES_COOLOFF_TIME = 1
 # Full path to directory to store logs for dynamically executed tasks
 TASK_LOG_DIR = "/tmp/layerindex-task-logs"
 
-# Full path to directory where rrs tools stores logs
+# Full path to a directory where the rrs tools also write their logs, if any
 TOOLS_LOG_DIR = ""
diff --git a/tests/test_rrs_logger.py b/tests/test_rrs_logger.py
new file mode 100644
index 0000000..b03c928
--- /dev/null
+++ b/tests/test_rrs_logger.py
@@ -0,0 +1,38 @@
+# layerindex-web - tests for the RRS tools' logger
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import logging
+import os
+import sys
+import types
+
+import pytest
+
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'rrs', 'tools'))
+from common import get_logger
+
+
+@pytest.fixture
+def readonly_cwd(tmp_path, monkeypatch):
+    os.chmod(tmp_path, 0o555)
+    monkeypatch.chdir(tmp_path)
+    yield tmp_path
+    os.chmod(tmp_path, 0o755)
+
+
+def test_no_log_file_without_tools_log_dir(readonly_cwd):
+    # [YOCTO #16499] the scripts run in a directory they can't write to
+    logger = get_logger('RRSTestNoDir', types.SimpleNamespace(TOOLS_LOG_DIR=''))
+    assert not [h for h in logger.handlers if isinstance(h, logging.FileHandler)]
+    assert os.listdir(readonly_cwd) == []
+
+
+def test_log_file_in_tools_log_dir(tmp_path):
+    logger = get_logger('RRSTestDir', types.SimpleNamespace(TOOLS_LOG_DIR=str(tmp_path)))
+    logger.info('hello')
+    for h in logger.handlers:
+        h.flush()
+    assert 'hello' in (tmp_path / 'RRSTestDir').read_text()
-- 
2.56.1

