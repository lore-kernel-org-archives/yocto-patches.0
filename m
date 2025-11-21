Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBBACFC503
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 20:34:28 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20914.1763757260456963300
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Nov 2025 12:34:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=VqAeqU7G;
 spf=pass (domain: qbee.io, ip: 209.85.167.53, mailfrom: piotr@qbee.io)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5959da48139so2476711e87.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 12:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1763757258; x=1764362058; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l2ZX/qcMR2qr4NIvxJvli2CibOiTpTjMjdImG2uwpkM=;
        b=VqAeqU7G+3adp6vvwI8MYQuUpqmjCI/85VD0YBkBw8IcfWsxkhXcbg2LHuDH/+Jaa4
         jpywGdAj/Oey8NdgT6YPgpZRzJ+2mte16U3GlR//o0S5RsEXuCL3vfnCpAVln8l9mKdl
         9/YTYljagRpMHdUjorFP4D2NHCgxxjErElCF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763757258; x=1764362058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2ZX/qcMR2qr4NIvxJvli2CibOiTpTjMjdImG2uwpkM=;
        b=dJmvDSHdchXApWQfrPjGHmDmEku9sRRcAmBgdnG7zywV8ZJbZ4D9wP3hp1pxewqugu
         ODykkXYsoJ56/lWaiUnnWtuPSLauH0okVuWemJ0dNqBYBFB34GkD2yLVq4aHBXuRz+PM
         2eTwOIQ9rbIeGx9Bm5x7H+A3fZuXzSmlqFJLa2SUCJRBd2Tgqh6enHaNsvaaPRkacHG7
         vHXcUZWhRMSfpObC7Tq+JcsAjc9A3a83f7EwV9Iulv21Hn/jGsiiMCpxIu3waOfxqlj8
         VEA9j08N/bUJ6OItXMuZuYy6YPjNUSipxGF9gVRn/M5nv7o57FMA4BX5SlRpm6yj5X/1
         zMyA==
X-Gm-Message-State: AOJu0Yz7WVxdruB1dfEor5G9QrIv93vWFHmZyLO3diGVi0XMLn5aFf4C
	asmM/HfsOxwy1nGHRDewGiRY3ZCNJVssysApvTgppqAC5IZicViJJ0seyUiFYcR6+k+95bBZnEM
	AmyCgKBk=
X-Gm-Gg: ASbGncs/lqvCVEJmHesLu6IaSklLFD7PDLEL4QfBKNhLTT2IiRbeFJtOLj7lAPjyJa/
	x+aKdaSKQjSryFmsQW5JyfYaCgarjhtXO3AdOIXOh8reRxaWGntsH0RGLL/5R4BOLa4jP5mVdXv
	63+evkr7hvCBm0W4gV2rMMpCoTpKDqrK1gVxs6sASU91FalvHp2qdKdjlOwnCLR/JYObc2YhrrZ
	FE0atrr0/gA+6AYqlQDSg2OQVxF/MJz99UWg0SQpv1Li6H773VkpsX2LW1ttfDwtNe2NRSgvhQ5
	UVaVNlHYs08uK+92QwPTuqElExUBl56YXcoRTHxB3MwHlsxRC5Nr1mMuiv2ob+vTYEgHYqrVpld
	KHchg8Duv1zIxc/Ublp+LhomnX4eC/yLAnpKZoLwuVnAGVoH1hKRPe2xZQMpEFlu3N5gKtBty/O
	GselkJePOv6Me7uWuIJ0bF1PlmfH3DJPI2NDkZZhEo
X-Google-Smtp-Source: AGHT+IFHgynqfwuZeeDvMdpFOqWqz56Tubo+DB+qscj9GRHj/KJjWMa8pri2TPd7JV2iB76P9IHMWg==
X-Received: by 2002:a05:6512:3e0a:b0:57d:6fca:f208 with SMTP id 2adb3069b0e04-596a3eefe83mr1300777e87.45.1763757257406;
        Fri, 21 Nov 2025 12:34:17 -0800 (PST)
Received: from localhost (80.89-10-247.nextgentel.com. [89.10.247.80])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5969db75627sm1857476e87.5.2025.11.21.12.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 12:34:17 -0800 (PST)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH 1/3] Add support for Development Containers
Date: Fri, 21 Nov 2025 21:33:48 +0100
Message-ID: <20251121203350.55855-1-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 20:34:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2652

This lowers the barrier of entry for new contributors by setting up a
completely functional layerindex system from a clean repository.

More on dev containers: https://containers.dev

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 .devcontainer/.env               |  6 +++
 .devcontainer/devcontainer.json  | 63 ++++++++++++++++++++++++++++++++
 .devcontainer/docker-compose.yml | 56 ++++++++++++++++++++++++++++
 README.vscode                    | 50 +++++++++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 .devcontainer/.env
 create mode 100644 .devcontainer/devcontainer.json
 create mode 100644 .devcontainer/docker-compose.yml
 create mode 100644 README.vscode

diff --git a/.devcontainer/.env b/.devcontainer/.env
new file mode 100644
index 0000000..230c010
--- /dev/null
+++ b/.devcontainer/.env
@@ -0,0 +1,6 @@
+DJANGO_SETTINGS_MODULE = 'docker.settings'
+DEBUG = 1
+SECRET_KEY = 'replace-me'
+HOSTNAME = 'localhost'
+EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
+BASE_DIR = '/opt/layerindex'
\ No newline at end of file
diff --git a/.devcontainer/devcontainer.json b/.devcontainer/devcontainer.json
new file mode 100644
index 0000000..4eb5b22
--- /dev/null
+++ b/.devcontainer/devcontainer.json
@@ -0,0 +1,63 @@
+{
+  "name": "Layerindex Web Development Container",
+  "dockerComposeFile": "docker-compose.yml",
+  "service": "app",
+  "workspaceFolder": "/opt/layerindex",
+  "postCreateCommand": "pip install ruff pytest && python3 manage.py migrate",
+  "remoteUser": "layers",
+  "forwardPorts": [
+    8000
+  ],
+  "customizations": {
+    "vscode": {
+      "extensions": [
+        // Python extensions, since this is a Python/Django project
+        "ms-python.python",
+        // Include Pylance for type checking
+        "ms-python.vscode-pylance",
+        // Debugging support
+        "ms-python.debugpy",
+        // Ruff linter
+        "charliermarsh.ruff",
+        // Beautiful syntax and scoped snippets for Django
+        "batisteo.vscode-django",
+        // SQL tools allowing to connect to the database
+        "mtxr.sqltools-driver-mysql"
+      ],
+      "settings": {
+        "terminal.integrated.defaultProfile.linux": "bash",
+        "python.defaultInterpreterPath": "/usr/bin/python3",
+        "remote.autoForwardPorts": false,
+        "sqltools.connections": [
+          {
+            "mysqlOptions": {
+              "authProtocol": "default",
+              "enableSsl": "Disabled"
+            },
+            "ssh": "Disabled",
+            "previewLimit": 50,
+            "server": "layersdb",
+            "port": 3306,
+            "driver": "MariaDB",
+            "name": "layersdb",
+            "database": "layersdb",
+            "username": "root",
+            "password": "testingpw"
+          }
+        ],
+        "editor.formatOnSaveMode": "modifications",
+        "[jsonc]": {
+          "editor.defaultFormatter": "vscode.json-language-features"
+        },
+        "[python]": {
+          "editor.defaultFormatter": "charliermarsh.ruff"
+        },
+        "python.testing.unittestEnabled": false,
+        "python.testing.pytestEnabled": true,
+        "editor.rulers": [
+          80
+        ]
+      }
+    }
+  }
+}
\ No newline at end of file
diff --git a/.devcontainer/docker-compose.yml b/.devcontainer/docker-compose.yml
new file mode 100644
index 0000000..83fc864
--- /dev/null
+++ b/.devcontainer/docker-compose.yml
@@ -0,0 +1,56 @@
+services:
+  layersdb:
+    image: mariadb:lts
+    environment:
+      MARIADB_DATABASE: layersdb
+      MARIADB_ROOT_PASSWORD: testingpw
+    healthcheck:
+      test: ["CMD", "healthcheck.sh", "--connect", "--innodb_initialized"]
+      start_period: 10s
+      interval: 5s
+      timeout: 5s
+      retries: 5
+    command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci --wait_timeout=28800 --max_allowed_packet=128M
+
+  layersrabbit:
+    image: rabbitmq:alpine
+    healthcheck:
+      test: rabbitmq-diagnostics -q ping
+      start_period: 10s
+      interval: 5s
+      timeout: 5s
+      retries: 5
+
+  app:
+    depends_on:
+      layersdb:
+        condition: service_healthy
+      layersrabbit:
+        condition: service_healthy
+    build: ..
+    image: yoctoproject/layerindex-web
+    working_dir: /opt/layerindex
+    volumes:
+      - ..:/opt/layerindex
+      - workdir:/opt/workdir
+    env_file:
+      - .env
+    command: ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
+
+  celery:
+    depends_on:
+      layersdb:
+        condition: service_healthy
+      layersrabbit:
+        condition: service_healthy
+    image: yoctoproject/layerindex-web
+    working_dir: /opt/layerindex
+    volumes:
+      - ..:/opt/layerindex:ro
+      - workdir:/opt/workdir
+    env_file:
+      - .env
+    command: /usr/local/bin/celery --workdir=/opt/layerindex --app layerindex.tasks worker --loglevel=INFO
+
+volumes:
+  workdir:
diff --git a/README.vscode b/README.vscode
new file mode 100644
index 0000000..db72329
--- /dev/null
+++ b/README.vscode
@@ -0,0 +1,50 @@
+VSCode + DevContainers Setup
+----------------------------
+
+If you already use VSCode and Docker, you can setup the local development
+environment using preconfigured DevContainers extension.
+
+Getting Started
+---------------
+
+1. Install Dev Containers extension (ms-vscode-remote.remote-containers)
+2. Open local clone of this repository in VSCode
+3. Click on "Reopen in Container" when prompted by VSCode
+4. Wait 1-2 minutes for VSCode to setup your DevContainer
+
+Once the DevContainer setup process is completed, you'll have access to:
+
+* Django development server running at http://localhost:8000
+* All Django database migrations applied
+* PyTest autodiscovery and debugger configured
+* Database client extension configured with the local server
+* Code linting and formatting with ruff
+* Command line git support with your SSH keys mounted in the container
+
+FAQ
+---
+
+1.  How do I import master branch from the public instance?
+
+    Run the following command in the VSCode Terminal:
+
+    $ layerindex/tools/import_layers.py https://layers.openembedded.org
+
+
+2.  How do I see emails sent by the development system?
+
+    Emails are logged to the standard output of the layerindex-web container.
+
+    To see the logs:
+
+    1. Open the Command Palette: Ctrl+Shift+P / Cmd+Shift+P
+    2. Type: "Remote Explorer: Focus on Dev Containers View"
+    3. Right-click on the layerindex-web container
+    4. Select "Show Container Log"
+
+
+3.  How do I interact with Django's manage.py script?
+
+    Open a new terminal window in VSCode and type:
+
+    $ ./manage.py ...
\ No newline at end of file

