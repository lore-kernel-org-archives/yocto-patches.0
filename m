Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4561.1794624058090782178
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 18:40:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=e4yCmCD5;
 spf=pass (domain: gmail.com, ip: 209.85.214.172, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ed06b725fdso18718995ad.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 18:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794624057; x=1795228857; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cnHEYSnWkZEK2v2CJKPg6/dAkBrLVAD0yIyCx/x5J3A=;
        b=e4yCmCD5DewqwLGERD+NpLcaXSWm/qHM7wW2xUQ43IexQis/DYJaDN0qcxWGhGGdIf
         JH0CAqcWEyINIMUBmMYz/9hWbvswaRbG7gdE4ObJn9xO+qTKC1OP9jrEm5bYJ5T5Jg2k
         vGvJTLDdHVQW/dVYvB9BYc1hJVFhLIinUGlsbtA3IZ4ikhh1Ot/OHC4FPiBneq6TAA3x
         T09scGbATuqB2o594meClaqE+fNRhlU/PPjLelZmyh2RmCYltqw8jSWIPtvvCVDYLpcr
         pdBjOvKXH5mN4NYLfnWvKpvNURBwa9C77HgVQ7TYlz1AoNASOwrEcq/oB6joYt3SrKIx
         WSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794624057; x=1795228857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cnHEYSnWkZEK2v2CJKPg6/dAkBrLVAD0yIyCx/x5J3A=;
        b=LU7tWAE42sgb38k4BbNvKjPm07AnFqQTGVUn1dicZAL0jWY+tMO2weCnu1HB6fnd5D
         oNH5Cd56ZaaMW1BuHX5rumxWYHGsGowdmgOoGylC3kFHFcZlmw44GMjQ5woNDShjeHLS
         uGJfbzviyoPR3tdDbC1mgBUa+nt3T+A5z7OUkdbvjg07ZsRoAkUMrH97XOzOqM/6i4Fo
         IO/zmaQT9rWve/X3iZuZ1alVZaOuQn9zRY+X8IXVjbWfvg5mF6ZK2g9QJm4zNA+xWN8L
         YSgh/FlJ8aEdpEUGygQ0+ecAMNpyx/BcoqQPhoGEa/5TxOfzNQ27vVggUXkPI8kHenYa
         dUcg==
X-Gm-Message-State: APuU4Z/ehytFonzgaYyyjZQhPPHgz6r4sJeprg3282CVWIyAQNNKaF4n
	aOrofxN9pR+54nbjNq9OWjxI57G7ydUc2GPbbbIfrDyINF38GQIdX58nE/viJMPc
X-Gm-Gg: AYBFou04k9xhS6qM+uEX6pNcCIcm2Ch+FfunNErPjec6JQFxRiEITqLGZj02gljRQW3
	YbvKWjLNAFK2QwbBa576ZcePcqlprLLk2AWelpmkIK4cl890rpSULdl7WyrZRVSAIttVoskgKWc
	/e5wEAkHwBj4otcPMS/CHcpCsBdcGsbVeR5ILBRRd/YBY0zDKNe3dEkWraVhKlrH3EykQEHfy9l
	71vXPfXqCaIocinIo3iMdBYWKJCu1WRy1k3e6L8KbshYyJ9hHuWzm6300g3askl0ZCi7joMT0J1
	FEwSOKQBhNyQioDQ/5jXimMUGMNDXFHjxJR0d9gzpYnYEsyZX/wcda/xs6jmJeKXSffhkRggM68
	ic32BWn/DnifQrHB/PO2GPFey25LBtA8FBC/MCQm5teLTYS8zeEB7oUkOS9E3vsdc+tWAM/XMN7
	Q7jCNxTixaz2TxRM9LOm6bUK2V6YsClp24WeBmmDg/So01Ie4UTIOMBuGKj2Tj+v/7WBru9/EW+
	2VxKzXqngLq/6J3T5/nx4CZJf0QhfrIXOxSVVSiy8lxctMmCzc+CfHAM+BdM2WoW/eIthMsS0nB
	V5HkAFk9YCSotVbWrl5EjYbWOcJZdXdjXwXaSkh0sQn1J2Dv6GQov00OPVjzJUQ43ZSqEPuP+Uj
	nnMFMAEs=
X-Received: by 2002:a17:903:3886:b0:2ea:dee6:d672 with SMTP id d9443c01a7336-2edf1f2a656mr53542185ad.19.1794624057266;
        Fri, 13 Nov 2026 18:40:57 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7d0d1fsm16686025ad.30.2026.11.13.18.40.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 18:40:56 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] dockersetup: move TASK_LOG_DIR with --app-dir
Date: Fri, 13 Nov 2026 18:40:50 -0800
Message-ID: <20261114024050.63499-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 02:41:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5360
Content-Type: text/plain; charset="utf-8"

With --app-dir, dockersetup.py mounts the task logs volume under the
application directory, but left TASK_LOG_DIR in docker/settings.py at
/opt/layerindex-task-logs, so the Celery worker wrote the task logs
outside the volume and the task page could not show them. Set
TASK_LOG_DIR from the application directory, as is already done for
LAYER_FETCH_DIR.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
Found while reviewing the task logs volume for the Update Layer button
series ("Dockerfile: create the task logs directory" creates
${APP_DIR}/layerindex-task-logs, which this matches). Covered by a new
test in tests/test_dockersetup.py.

 dockersetup.py            |  3 +++
 tests/test_dockersetup.py | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/dockersetup.py b/dockersetup.py
index 406bdf9..9e4d05e 100755
--- a/dockersetup.py
+++ b/dockersetup.py
@@ -427,6 +427,9 @@ def edit_settings_py(emailaddr, app_dir='/opt'):
         elif line.lstrip().startswith('LAYER_FETCH_DIR'):
             newlines.append("LAYER_FETCH_DIR = \"%s/workdir\"\n" % app_dir)
             continue
+        elif line.lstrip().startswith('TASK_LOG_DIR'):
+            newlines.append("TASK_LOG_DIR = \"%s/layerindex-task-logs\"\n" % app_dir)
+            continue
         newlines.append(line + "\n")
     writefile("docker/settings.py", ''.join(newlines))
 
diff --git a/tests/test_dockersetup.py b/tests/test_dockersetup.py
index 0109c80..97a78f6 100644
--- a/tests/test_dockersetup.py
+++ b/tests/test_dockersetup.py
@@ -22,6 +22,7 @@ TRACKED_FILES = [
     '.env.dev.app', '.env.dev.celery', '.env.dev.db', '.env.dev.rabbit',
     'Dockerfile',
     'docker/git-proxy', 'docker/.gitconfig', 'docker/nginx-ssl.conf',
+    'docker/settings.py',
 ]
 
 
@@ -115,6 +116,19 @@ def test_compose_uses_local_env_files(workdir):
     assert 'layerscertbot' not in services
 
 
+def test_app_dir_moves_task_logs_with_the_volume(workdir):
+    # The task logs volume and TASK_LOG_DIR must agree, or the task log page
+    # can't find the logs the Celery worker writes
+    dockersetup.edit_dockercompose('layers.example.com', '8080:80,8081:443', False, app_dir='/srv/li')
+    dockersetup.edit_settings_py(None, app_dir='/srv/li')
+    services = load_compose(workdir)['services']
+    settings = (workdir / 'docker' / 'settings.py').read_text()
+    for service in ('layersapp', 'layerscelery'):
+        assert 'logvolume:/srv/li/layerindex-task-logs:z' in services[service]['volumes']
+    assert 'TASK_LOG_DIR = "/srv/li/layerindex-task-logs"' in settings
+    assert 'LAYER_FETCH_DIR = "/srv/li/workdir"' in settings
+
+
 def test_compose_enables_certbot_for_letsencrypt(workdir):
     dockersetup.edit_dockercompose('layers.example.com', '80:80,443:443', True)
     services = load_compose(workdir)['services']

base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
-- 
2.56.0

