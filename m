Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97970CCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 02:03:26 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7991.1792288997521634439
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 19:03:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YbdHO7cc;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso702032a91.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 19:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288997; x=1792893797; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FAJm5Lx8byFouTxg0tyT5qpsZi5P4kG4wJYvLf/tYsE=;
        b=YbdHO7ccIPWfFr8WwMw69Em95+uecbW/GEKUJx3FaZvYE9Xrk2T73cObeNe7WpBbcf
         pxL7D91MyowhsSV2mKmWwqZz5LI9l+F+vgiHkToylxG5deuQVBPRTVJ7IjheAoIPbvYu
         LQWxH06q4JPQ2CTgnPan4HzH1ovfzBybBOnR2oTjLXNN7PTGPTY4JThts37ffT9qaEGL
         8+5MtNh3/aFkHg/VIGtWOnPu0aDXX5yuH+jJ8eRstd9ap6XOL5kT3WfXP+jdE6JvO8Ls
         DZCGACNf/fyMu2v4VdcO45FV2T7Nxq65Xh76eV+49/AypiinTlcaZsjzptc2VvN3iX+1
         GuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288997; x=1792893797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FAJm5Lx8byFouTxg0tyT5qpsZi5P4kG4wJYvLf/tYsE=;
        b=I/BDo3A94IqMK074ABaZivNRt9uY0Uj7/Jr3yUYLRpr4HB/C944KeJEveqQTosnsUw
         m65fu/iEuFjY0bQ1Mjx9LJvXDRkKaJBnyEiExj8zJEVxU4ExWa6rbZHHRXGMc6McSBIc
         NcrHjWyyGKlqGJ8spIG9gX2ZeKlhIk+LW37K406MpNFUp0qc+Q1BqpfraD149qTytgzW
         cu7btiIOf0oY+Wy3ptcudkGYmu7+Mw3fY4Ue4NOSoUaH9SE0nptydZQoADLLXdYtCp+D
         nGhxK12T1E/DF12686OaLkfY1yJOM8QxC5psQf8m/wWwHRAv92bwJdi8+puHZNPXZ62b
         +mEg==
X-Gm-Message-State: AFq9FYJ+jTToTkAdfb1O6EO4ViBBLXLZ6sZYdBNAPqUzsxfgSigeYYtC
	TK1Ei4Rb50zZg09g33/5B1bth+ZXwi0DJ1DJ+N3pBQIC0A8TSva7jJhQ/7n/EvBr
X-Gm-Gg: AYBFou3KwhVQ+DqR5/Bl7Ai8pqfI3SIEppWdfA1VvikOXTc3h8YczBY9ylj5kgQZj3B
	X4/56KHzuOHKh0mVb60pj2da5hgjJOO6RB5jA6YZj3Ow74mPW5YVF7/FPaiUE8tSdwWYHP6IWBN
	3ZY2qJEauXO0EzATvxqKcrst1yMeMvIs4Fk4LMS6pTvd7FGWZmo+SLKP5W3l/RNkpMDnbI7MV26
	2S6GNLdnzr19j+6lsqVToU80HtGjbgwRIjcAczH5Vrnwyd8XF+sUKRc+XKw6nrWiBtmUiGsbkey
	WZxdSbkOOpRGb+gBshbwjoHOBgnUmoxdyPmBusSJQ4E+MLDLv6NeEf4vfIy2qNtSE/eUjlzC9EF
	IRxPrGIMD5+ipex8RFC+XGebMHAb4z6qdST9UxMiuoHUlXcbmHCToSjyEcTSUHQYJDo3gnPsaAW
	LK0s3UkHAovbvgDMQ6qPxeDfmkcSM28TeIVbVSfaw+iSie9Egu6iOKyi34cYI9PnsvzsSH8/rR8
	cIhrVGFRofoOjJ1n8ViRtP2cJJvFHg=
X-Received: by 2002:a17:90b:5864:b0:3ac:80dc:f40b with SMTP id 98e67ed59e1d1-3acef15450bmr3393601a91.33.1792288996623;
        Sat, 17 Oct 2026 19:03:16 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947928b4sm14569131a91.11.2026.10.17.19.03.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 19:03:14 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 3/4] Add a VS Code devcontainer.
Date: Sat, 17 Oct 2026 18:57:09 -0700
Message-ID: <20261018020116.75276-7-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018020116.75276-1-tim.orling@konsulko.com>
References: <20261018020116.75276-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 02:03:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5064

Layered on docker-compose.yaml, as layerindex-web's is: runserver on
the mounted workspace, MySQL unpublished, no nginx. Ruff formats changed
lines only.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .devcontainer/devcontainer.json      | 63 ++++++++++++++++++++++++++++
 .devcontainer/docker-compose.dev.yml | 15 +++++++
 2 files changed, 78 insertions(+)
 create mode 100644 .devcontainer/devcontainer.json
 create mode 100644 .devcontainer/docker-compose.dev.yml

diff --git a/.devcontainer/devcontainer.json b/.devcontainer/devcontainer.json
new file mode 100644
index 0000000..9d8ef1e
--- /dev/null
+++ b/.devcontainer/devcontainer.json
@@ -0,0 +1,63 @@
+{
+  "name": "error-report-web (Django + MySQL)",
+  "dockerComposeFile": [
+    "../docker-compose.yaml",
+    "docker-compose.dev.yml"
+  ],
+  "service": "backend",
+  "workspaceFolder": "/app",
+  "shutdownAction": "stopCompose",
+  "remoteUser": "root",
+
+  // requirements.txt may have changed since the image was built.
+  "postCreateCommand": "pip install --no-cache-dir -r requirements.txt ruff==0.17.0 && python3 manage.py migrate --noinput",
+
+  "forwardPorts": [
+    8000
+  ],
+
+  "customizations": {
+    "vscode": {
+      "extensions": [
+        "ms-python.python",
+        "ms-python.vscode-pylance",
+        "ms-python.debugpy",
+        "charliermarsh.ruff",
+        "batisteo.vscode-django",
+        "mtxr.sqltools",
+        "mtxr.sqltools-driver-mysql"
+      ],
+      "settings": {
+        "python.defaultInterpreterPath": "/usr/local/bin/python",
+        "python.terminal.activateEnvironment": false,
+        "remote.autoForwardPorts": false,
+        // Values from .env.dev.db.
+        "sqltools.connections": [
+          {
+            "mysqlOptions": {
+              "authProtocol": "default",
+              "enableSsl": "Disabled"
+            },
+            "previewLimit": 50,
+            "server": "db",
+            "port": 3306,
+            "driver": "MySQL",
+            "name": "errorreport",
+            "database": "errorreport",
+            "username": "errorreport",
+            "password": "testingpw"
+          }
+        ],
+        // Format changed lines only.
+        "editor.formatOnSaveMode": "modifications",
+        "[python]": {
+          "editor.defaultFormatter": "charliermarsh.ruff"
+        },
+        "files.exclude": {
+          "**/__pycache__": true,
+          "**/*.pyc": true
+        }
+      }
+    }
+  }
+}
diff --git a/.devcontainer/docker-compose.dev.yml b/.devcontainer/docker-compose.dev.yml
new file mode 100644
index 0000000..32aa685
--- /dev/null
+++ b/.devcontainer/docker-compose.dev.yml
@@ -0,0 +1,15 @@
+# Devcontainer override for docker-compose.yaml: runserver on the mounted
+# workspace, MySQL port unpublished (no clash with other dev DBs), no nginx.
+services:
+  backend:
+    command: ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
+    restart: "no"
+    volumes:
+      - .:/app:cached
+
+  db:
+    restart: "no"
+    ports: !reset []
+
+  web:
+    profiles: [nginx]
-- 
2.56.0


