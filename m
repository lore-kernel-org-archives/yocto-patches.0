Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E11ECCF2D3
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 21:42:13 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22279.1792359729713653856
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 14:42:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cm/l/QgU;
 spf=pass (domain: gmail.com, ip: 209.85.214.182, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso7194125ad.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 14:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359729; x=1792964529; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tSQlUuO9WdnlKPjoIetJ5YKdNPMZIM6rKHRlJd/f1lo=;
        b=cm/l/QgU0M03V51MeLR2F3WJUayR+/zAP326HHUerXwuinYtyuLI29oIOsNsaN3a4A
         RpqyYWUwJerzoTIUbJE+MDPDsw9A7LAhJL96HA1qEmTzQooMIH5zZSEzF8KeuGJJz1g0
         TP2cJqFSEByZ7iul2pqy2TptLgQykKdX0jKznZghYPga6Fg9NJ+lY/dK0DFKBInZVz83
         9gx7geRSlwN9xelVyhC/buc4lq30lNZYUfyJMmtLc7i0W7OfjPTtetnzyK64F316TP1L
         hawzpNNbLNuRg/pKlz7CFUtjKQFtXJA2YTNxSRf/t0Cec4BMPt1ADud1UXWybUrxFJG9
         qM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359729; x=1792964529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tSQlUuO9WdnlKPjoIetJ5YKdNPMZIM6rKHRlJd/f1lo=;
        b=NFRlDdH7op49AAxmyd/vyKcRmw38NvKW3VSnCsfR8t/pRFT8TUH7cJ0wlzoi/T+YXM
         /xcwsT7LQmJi2JV+ZllWLP8+wxStgPMVeEcCFIUiZRr4vDE4FeKHrh7k59Z4iZI8NJ6I
         96NuyLMtLb0D4FYgarPy01Z7KahBXtdJ9ODaw0IC2oYvXqnmd9chY6d0UmXxVilI4jYd
         xQMzK6EiJeIJNeT1O03grGq1kfV+zGoFQYFODfGuqhVAMNHJG44tboGdLICNWTqDkpWy
         l0SeZ+RoMZI1vjgeyzDQ9Ahomjwvq+Y5AOOBjLG0ux2eGn+oKa6QBdGl87z1aXvPdP0F
         Xx3A==
X-Gm-Message-State: AFq9FYKu9N7USmLPBS7/0QT24SsJ2YcgF3HJEhESS2jAhJU7ITHq93Jv
	9pBIiqgigOyq5cExF2htMF0vNrx9BEkvyaJtOx3c03HygHzx64ZOMqUE2jdnM1EF
X-Gm-Gg: AYBFou1GhM75xl79YOED2IfvNBvJw3UTJHAQvuSBdzWeON8be0lIZCPx7WeCm2PYXHd
	afRPLmZbrq0gGTW7amGjnMO9IxF7wOP0dZ4TmhDr+Hw0lpIZYSSdFnHThWIosIQTmnruLHrd5hP
	I8TMh/tTao1Jy9SZp8o4AnTF1m0zJoFtVi9Q3OaDubV1EGxGMiQR7FJ24ZQX6AGN+xTBZqaDdoG
	gb7ZvPraZZT/1Er2bZl9aFXXGUuPmelWqLvQp71Hy7ysAhqy7NEuxXV3ymBuF+wzGHFZY9iJQW0
	0zdJSbOZ56iq8Sy+cGZ19No+7rZFhSUKLn9FwYwZsyztmzj32MiU8SX+3hZo/Yo0YJ8KEexhMsV
	6UXymdbU2fYrnsIyWzMDyVAYB2+o7jw/xdfuFFFtQNn45pUlgWgZfWS8Ifnqj3NqvT8xJYvQute
	nP77nxkZvuDEyLY+PQmhBAQ3TF963a67LkZ57hj9FTzEmqsIRwnrXSstlL59Py0ptQz6MENKvS9
	BhVumXKMtJGBPC+lLBI++wCJH7W1x4=
X-Received: by 2002:a17:902:f601:b0:2e9:9846:2da5 with SMTP id d9443c01a7336-2e9a683450amr53794895ad.8.1792359728809;
        Sun, 18 Oct 2026 14:42:08 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e9d3fa9ffdsm9004155ad.58.2026.10.18.14.42.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 14:42:06 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 4/4] Add staging and production docker-compose setups with env files
Date: Sun, 18 Oct 2026 14:41:46 -0700
Message-ID: <20261018214146.67856-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018214146.67856-1-tim.orling@konsulko.com>
References: <20261018214146.67856-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 21:42:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5076

Move the container settings out of docker-compose.yml into tracked
.env.<context>.<service> files, so local configuration no longer means
editing the compose file and fighting upstream changes to it.
docker-compose.yml uses the .env.dev.* files, which keep the existing
development-only values.

Add docker-compose.staging.yml and docker-compose.prod.yml, which use
.env.staging.* and .env.prod.*, serve ports 80 and 443, run certbot,
and keep the database in a volume. Their secrets are commented out, so
nothing starts with a known password; the real values belong in a local
commit on the server. Keep the .env* files out of the Docker images.

dockersetup.py used to write the generated secret key, database and
RabbitMQ passwords and email settings into the environment entries of
docker-compose.yml. It now copies each .env.dev.<service> to
.env.local.<service> (mode 0600) with those values filled in and DEBUG
off, and points docker-compose.yml at the copies. Update mode reads the
root password back from .env.local.db, or from docker-compose.yml for
installations made before this change. Git ignores the .env.local.*
files and the .env file that dockersetup.py already writes.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .dockerignore              |   1 +
 .env.dev.app               |  14 +++++
 .env.dev.celery            |  14 +++++
 .env.dev.db                |   3 +
 .env.dev.rabbit            |   3 +
 .env.prod.app              |  15 +++++
 .env.prod.celery           |  15 +++++
 .env.prod.db               |   4 ++
 .env.prod.rabbit           |   4 ++
 .env.staging.app           |  15 +++++
 .env.staging.celery        |  15 +++++
 .env.staging.db            |   4 ++
 .env.staging.rabbit        |   4 ++
 .gitignore                 |   2 +
 README                     |  23 +++++++-
 docker-compose.prod.yml    |  74 +++++++++++++++++++++++++
 docker-compose.staging.yml |  74 +++++++++++++++++++++++++
 docker-compose.yml         |  42 +++-----------
 dockersetup.py             | 111 +++++++++++++++++--------------------
 19 files changed, 341 insertions(+), 96 deletions(-)
 create mode 100644 .env.dev.app
 create mode 100644 .env.dev.celery
 create mode 100644 .env.dev.db
 create mode 100644 .env.dev.rabbit
 create mode 100644 .env.prod.app
 create mode 100644 .env.prod.celery
 create mode 100644 .env.prod.db
 create mode 100644 .env.prod.rabbit
 create mode 100644 .env.staging.app
 create mode 100644 .env.staging.celery
 create mode 100644 .env.staging.db
 create mode 100644 .env.staging.rabbit
 create mode 100644 docker-compose.prod.yml
 create mode 100644 docker-compose.staging.yml

diff --git a/.dockerignore b/.dockerignore
index 3b82016..e689d37 100644
--- a/.dockerignore
+++ b/.dockerignore
@@ -19,3 +19,4 @@ dockersetup.py
 .venv
 .idea
 .DS_Store
+.env*
diff --git a/.env.dev.app b/.env.dev.app
new file mode 100644
index 0000000..9f8fb5a
--- /dev/null
+++ b/.env.dev.app
@@ -0,0 +1,14 @@
+# Development only; not secret.
+#SECRET_KEY=<set this here>
+DATABASE_USER=root
+DATABASE_PASSWORD=testingpw
+DATABASE_HOST=layersdb
+RABBITMQ_DEFAULT_USER=guest
+RABBITMQ_DEFAULT_PASS=guest
+#EMAIL_HOST=<set this here>
+#EMAIL_PORT=<set this here if not the default>
+#EMAIL_USER=<set this here if needed>
+#EMAIL_PASSWORD=<set this here if needed>
+#EMAIL_USE_SSL=<set this here if needed>
+#EMAIL_USE_TLS=<set this here if needed>
+DEBUG=1
diff --git a/.env.dev.celery b/.env.dev.celery
new file mode 100644
index 0000000..cb07c1c
--- /dev/null
+++ b/.env.dev.celery
@@ -0,0 +1,14 @@
+# Development only; not secret.
+#SECRET_KEY=<set this here>
+DATABASE_USER=layers
+DATABASE_PASSWORD=testingpw
+DATABASE_HOST=layersdb
+RABBITMQ_DEFAULT_USER=guest
+RABBITMQ_DEFAULT_PASS=guest
+#EMAIL_HOST=<set this here>
+#EMAIL_PORT=<set this here if not the default>
+#EMAIL_USER=<set this here if needed>
+#EMAIL_PASSWORD=<set this here if needed>
+#EMAIL_USE_SSL=<set this here if needed>
+#EMAIL_USE_TLS=<set this here if needed>
+#DEBUG=1
diff --git a/.env.dev.db b/.env.dev.db
new file mode 100644
index 0000000..90c6252
--- /dev/null
+++ b/.env.dev.db
@@ -0,0 +1,3 @@
+# Development only; not secret.
+MYSQL_DATABASE=layersdb
+MYSQL_ROOT_PASSWORD=testingpw
diff --git a/.env.dev.rabbit b/.env.dev.rabbit
new file mode 100644
index 0000000..41a5eeb
--- /dev/null
+++ b/.env.dev.rabbit
@@ -0,0 +1,3 @@
+# Development only; not secret.
+RABBITMQ_DEFAULT_USER=guest
+RABBITMQ_DEFAULT_PASS=guest
diff --git a/.env.prod.app b/.env.prod.app
new file mode 100644
index 0000000..0160450
--- /dev/null
+++ b/.env.prod.app
@@ -0,0 +1,15 @@
+# Set real values in a local commit on the server; never push them.
+# Without SECRET_KEY the application refuses to start.
+#SECRET_KEY=<set this here>
+DATABASE_USER=root
+#DATABASE_PASSWORD=<set this here>
+DATABASE_HOST=layersdb
+#RABBITMQ_DEFAULT_USER=<set this here>
+#RABBITMQ_DEFAULT_PASS=<set this here>
+#EMAIL_HOST=<set this here>
+#EMAIL_PORT=<set this here if not the default>
+#EMAIL_USER=<set this here if needed>
+#EMAIL_PASSWORD=<set this here if needed>
+#EMAIL_USE_SSL=<set this here if needed>
+#EMAIL_USE_TLS=<set this here if needed>
+DEBUG=0
diff --git a/.env.prod.celery b/.env.prod.celery
new file mode 100644
index 0000000..e2e426f
--- /dev/null
+++ b/.env.prod.celery
@@ -0,0 +1,15 @@
+# Set real values in a local commit on the server; never push them.
+# Use the same values as in .env.prod.app.
+#SECRET_KEY=<set this here>
+DATABASE_USER=layers
+#DATABASE_PASSWORD=<set this here>
+DATABASE_HOST=layersdb
+#RABBITMQ_DEFAULT_USER=<set this here>
+#RABBITMQ_DEFAULT_PASS=<set this here>
+#EMAIL_HOST=<set this here>
+#EMAIL_PORT=<set this here if not the default>
+#EMAIL_USER=<set this here if needed>
+#EMAIL_PASSWORD=<set this here if needed>
+#EMAIL_USE_SSL=<set this here if needed>
+#EMAIL_USE_TLS=<set this here if needed>
+#DEBUG=1
diff --git a/.env.prod.db b/.env.prod.db
new file mode 100644
index 0000000..99232ab
--- /dev/null
+++ b/.env.prod.db
@@ -0,0 +1,4 @@
+# Set real values in a local commit on the server; never push them.
+# Without MYSQL_ROOT_PASSWORD the database refuses to start.
+MYSQL_DATABASE=layersdb
+#MYSQL_ROOT_PASSWORD=<set this here>
diff --git a/.env.prod.rabbit b/.env.prod.rabbit
new file mode 100644
index 0000000..b422a9a
--- /dev/null
+++ b/.env.prod.rabbit
@@ -0,0 +1,4 @@
+# Set real values in a local commit on the server; never push them.
+# Use the same values as RABBITMQ_* in .env.prod.app.
+#RABBITMQ_DEFAULT_USER=<set this here>
+#RABBITMQ_DEFAULT_PASS=<set this here>
diff --git a/.env.staging.app b/.env.staging.app
new file mode 100644
index 0000000..0160450
--- /dev/null
+++ b/.env.staging.app
@@ -0,0 +1,15 @@
+# Set real values in a local commit on the server; never push them.
+# Without SECRET_KEY the application refuses to start.
+#SECRET_KEY=<set this here>
+DATABASE_USER=root
+#DATABASE_PASSWORD=<set this here>
+DATABASE_HOST=layersdb
+#RABBITMQ_DEFAULT_USER=<set this here>
+#RABBITMQ_DEFAULT_PASS=<set this here>
+#EMAIL_HOST=<set this here>
+#EMAIL_PORT=<set this here if not the default>
+#EMAIL_USER=<set this here if needed>
+#EMAIL_PASSWORD=<set this here if needed>
+#EMAIL_USE_SSL=<set this here if needed>
+#EMAIL_USE_TLS=<set this here if needed>
+DEBUG=0
diff --git a/.env.staging.celery b/.env.staging.celery
new file mode 100644
index 0000000..445226a
--- /dev/null
+++ b/.env.staging.celery
@@ -0,0 +1,15 @@
+# Set real values in a local commit on the server; never push them.
+# Use the same values as in .env.staging.app.
+#SECRET_KEY=<set this here>
+DATABASE_USER=layers
+#DATABASE_PASSWORD=<set this here>
+DATABASE_HOST=layersdb
+#RABBITMQ_DEFAULT_USER=<set this here>
+#RABBITMQ_DEFAULT_PASS=<set this here>
+#EMAIL_HOST=<set this here>
+#EMAIL_PORT=<set this here if not the default>
+#EMAIL_USER=<set this here if needed>
+#EMAIL_PASSWORD=<set this here if needed>
+#EMAIL_USE_SSL=<set this here if needed>
+#EMAIL_USE_TLS=<set this here if needed>
+#DEBUG=1
diff --git a/.env.staging.db b/.env.staging.db
new file mode 100644
index 0000000..99232ab
--- /dev/null
+++ b/.env.staging.db
@@ -0,0 +1,4 @@
+# Set real values in a local commit on the server; never push them.
+# Without MYSQL_ROOT_PASSWORD the database refuses to start.
+MYSQL_DATABASE=layersdb
+#MYSQL_ROOT_PASSWORD=<set this here>
diff --git a/.env.staging.rabbit b/.env.staging.rabbit
new file mode 100644
index 0000000..36a26e4
--- /dev/null
+++ b/.env.staging.rabbit
@@ -0,0 +1,4 @@
+# Set real values in a local commit on the server; never push them.
+# Use the same values as RABBITMQ_* in .env.staging.app.
+#RABBITMQ_DEFAULT_USER=<set this here>
+#RABBITMQ_DEFAULT_PASS=<set this here>
diff --git a/.gitignore b/.gitignore
index 6b271d4..814f9d1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -18,3 +18,5 @@ requirements.txt.updated
 requirements_outdated.txt
 requirements_safety_check.txt
 requirements_deptree.txt
+.env
+.env.local.*
diff --git a/README b/README
index 96c2ddd..3f733af 100644
--- a/README
+++ b/README
@@ -75,7 +75,28 @@ instructions will walk you through the setup.
 
    Note that updating with -u/--update will only work if the configuration
    changes originally made by dockersetup.py upon installation (e.g. passwords,
-   hostname, etc.) are still present in the source tree.
+   hostname, etc.) are still present in the source tree. The generated
+   passwords and secret key are written to .env.local.* files, which git
+   ignores; keep them, and do not commit them.
+
+Environment files:
+
+The containers read their settings (secret key, database and RabbitMQ
+credentials, email server, DEBUG) from .env.<context>.<service> files, where
+<context> is dev, staging or prod and <service> is app, celery, db or rabbit:
+
+  - docker-compose.yml uses the .env.dev.* files, which hold development-only
+    values. dockersetup.py copies them to .env.local.*, fills in the secrets
+    it generates, and points docker-compose.yml at those copies.
+  - docker-compose.staging.yml and docker-compose.prod.yml use the
+    .env.staging.* and .env.prod.* files. Their secrets are commented out, so
+    nothing starts with a known password. Set the real values, and the
+    hostname in the compose file, in a local commit on the server and never
+    push them. Then run, for example:
+
+        docker compose -f docker-compose.prod.yml up -d --build
+
+The .env* files are excluded from the Docker images.
 
 
 
diff --git a/docker-compose.prod.yml b/docker-compose.prod.yml
new file mode 100644
index 0000000..c8ec3fd
--- /dev/null
+++ b/docker-compose.prod.yml
@@ -0,0 +1,74 @@
+services:
+  layersdb:
+    image: mariadb:lts
+    command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci --wait_timeout=28800 --max_allowed_packet=128M
+    volumes:
+      - mariadb_data:/var/lib/mysql
+    env_file:
+     - ".env.prod.db"
+    restart: unless-stopped
+
+  layersapp:
+    depends_on:
+      - layersdb
+    build: .
+    image: halstead/layerindex-app
+    hostname: localhost
+    volumes:
+     - layersmeta:/opt/workdir
+     - logvolume:/opt/layerindex-task-logs
+    env_file:
+     - ".env.prod.app"
+    restart: unless-stopped
+
+  layersweb:
+    depends_on:
+      - layersapp
+    build:
+      context: .
+      dockerfile: Dockerfile.web
+    image: halstead/layerindex-web
+    hostname: localhost
+    ports:
+     - "443:443"
+     - "80:80"
+    volumes:
+     - layersstatic:/usr/share/nginx/html
+     - ./docker/certs:/opt/cert
+     - certbotwww:/var/www/certbot
+    command: "/bin/sh -c 'while :; do sleep 6h & wait $${!}; nginx -s reload; done & nginx -g \"daemon off;\"'"
+    restart: unless-stopped
+
+  layersrabbit:
+    image: rabbitmq:alpine
+    restart: unless-stopped
+    env_file:
+     - ".env.prod.rabbit"
+
+  layerscelery:
+    depends_on:
+      - layersdb
+      - layersapp
+      - layersrabbit
+    image: halstead/layerindex-app
+    volumes:
+     - layersmeta:/opt/workdir
+     - logvolume:/opt/layerindex-task-logs
+    env_file:
+     - ".env.prod.celery"
+    restart: unless-stopped
+    command: /usr/local/bin/celery --workdir=/opt/layerindex --app layerindex.tasks worker --loglevel=INFO
+
+  layerscertbot:
+    image: certbot/certbot
+    volumes:
+     - ./docker/certs:/opt/cert
+     - certbotwww:/var/www/certbot
+    entrypoint: "/bin/sh -c 'trap exit TERM; while :; do certbot renew; sleep 12h & wait $${!}; done;'"
+
+volumes:
+  layersmeta:
+  layersstatic:
+  mariadb_data:
+  logvolume:
+  certbotwww:
diff --git a/docker-compose.staging.yml b/docker-compose.staging.yml
new file mode 100644
index 0000000..80ceef6
--- /dev/null
+++ b/docker-compose.staging.yml
@@ -0,0 +1,74 @@
+services:
+  layersdb:
+    image: mariadb:lts
+    command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci --wait_timeout=28800 --max_allowed_packet=128M
+    volumes:
+      - mariadb_data:/var/lib/mysql
+    env_file:
+     - ".env.staging.db"
+    restart: unless-stopped
+
+  layersapp:
+    depends_on:
+      - layersdb
+    build: .
+    image: halstead/layerindex-app
+    hostname: localhost
+    volumes:
+     - layersmeta:/opt/workdir
+     - logvolume:/opt/layerindex-task-logs
+    env_file:
+     - ".env.staging.app"
+    restart: unless-stopped
+
+  layersweb:
+    depends_on:
+      - layersapp
+    build:
+      context: .
+      dockerfile: Dockerfile.web
+    image: halstead/layerindex-web
+    hostname: localhost
+    ports:
+     - "443:443"
+     - "80:80"
+    volumes:
+     - layersstatic:/usr/share/nginx/html
+     - ./docker/certs:/opt/cert
+     - certbotwww:/var/www/certbot
+    command: "/bin/sh -c 'while :; do sleep 6h & wait $${!}; nginx -s reload; done & nginx -g \"daemon off;\"'"
+    restart: unless-stopped
+
+  layersrabbit:
+    image: rabbitmq:alpine
+    restart: unless-stopped
+    env_file:
+     - ".env.staging.rabbit"
+
+  layerscelery:
+    depends_on:
+      - layersdb
+      - layersapp
+      - layersrabbit
+    image: halstead/layerindex-app
+    volumes:
+     - layersmeta:/opt/workdir
+     - logvolume:/opt/layerindex-task-logs
+    env_file:
+     - ".env.staging.celery"
+    restart: unless-stopped
+    command: /usr/local/bin/celery --workdir=/opt/layerindex --app layerindex.tasks worker --loglevel=INFO
+
+  layerscertbot:
+    image: certbot/certbot
+    volumes:
+     - ./docker/certs:/opt/cert
+     - certbotwww:/var/www/certbot
+    entrypoint: "/bin/sh -c 'trap exit TERM; while :; do certbot renew; sleep 12h & wait $${!}; done;'"
+
+volumes:
+  layersmeta:
+  layersstatic:
+  mariadb_data:
+  logvolume:
+  certbotwww:
diff --git a/docker-compose.yml b/docker-compose.yml
index 8704599..bafa64d 100644
--- a/docker-compose.yml
+++ b/docker-compose.yml
@@ -2,9 +2,8 @@ services:
   layersdb:
     image: mariadb:lts
     command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci --wait_timeout=28800 --max_allowed_packet=128M
-    environment:
-     - "MYSQL_DATABASE=layersdb"
-     - "MYSQL_ROOT_PASSWORD=testingpw"
+    env_file:
+     - ".env.dev.db"
     restart: unless-stopped
   layersapp:
     depends_on:
@@ -15,20 +14,8 @@ services:
     volumes:
      - layersmeta:/opt/workdir
      - logvolume:/opt/layerindex-task-logs:z
-    environment:
-     #- "SECRET_KEY=<set this here>"
-     - "DATABASE_USER=root"
-     - "DATABASE_PASSWORD=testingpw"
-     - "DATABASE_HOST=layersdb"
-     - "RABBITMQ_DEFAULT_USER=guest"
-     - "RABBITMQ_DEFAULT_PASS=guest"
-     #- "EMAIL_HOST=<set this here>"
-     #- "EMAIL_PORT=<set this here if not the default>"
-     #- "EMAIL_USER=<set this here if needed>"
-     #- "EMAIL_PASSWORD=<set this here if needed>"
-     #- "EMAIL_USE_SSL=<set this here if needed>"
-     #- "EMAIL_USE_TLS=<set this here if needed>"
-     #- "DEBUG=1"
+    env_file:
+     - ".env.dev.app"
     restart: unless-stopped
   layersweb:
     depends_on:
@@ -52,9 +39,8 @@ services:
   layersrabbit:
     image: rabbitmq:alpine
     restart: unless-stopped
-    environment:
-     - "RABBITMQ_DEFAULT_USER=guest"
-     - "RABBITMQ_DEFAULT_PASS=guest"
+    env_file:
+     - ".env.dev.rabbit"
   layerscelery:
     depends_on:
       - layersdb
@@ -64,20 +50,8 @@ services:
     volumes:
      - layersmeta:/opt/workdir
      - logvolume:/opt/layerindex-task-logs:z
-    environment:
-     #- "SECRET_KEY=<set this here>"
-     - "DATABASE_USER=layers"
-     - "DATABASE_PASSWORD=testingpw"
-     - "DATABASE_HOST=layersdb"
-     - "RABBITMQ_DEFAULT_USER=guest"
-     - "RABBITMQ_DEFAULT_PASS=guest"
-     #- "EMAIL_HOST=<set this here>"
-     #- "EMAIL_PORT=<set this here if not the default>"
-     #- "EMAIL_USER=<set this here if needed>"
-     #- "EMAIL_PASSWORD=<set this here if needed>"
-     #- "EMAIL_USE_SSL=<set this here if needed>"
-     #- "EMAIL_USE_TLS=<set this here if needed>"
-     #- "DEBUG=1"
+    env_file:
+     - ".env.dev.celery"
     restart: unless-stopped
     command: /usr/local/bin/celery --workdir=/opt/layerindex --app layerindex.tasks worker --loglevel=INFO
   #layerscertbot:
diff --git a/dockersetup.py b/dockersetup.py
index 3a74eb3..bf4a814 100755
--- a/dockersetup.py
+++ b/dockersetup.py
@@ -253,8 +253,9 @@ def yaml_comment(line):
     return out
 
 
-# Add hostname, secret key, db info, and email host in docker-compose.yml
-def edit_dockercompose(hostname, dbpassword, dbapassword, secretkey, rmqpassword, portmapping, letsencrypt, email_host, email_port, email_user, email_password, email_ssl, email_tls, app_dir='/opt'):
+# Add hostname, port mapping and certificates in docker-compose.yml, and use
+# the .env.local.* files written by write_service_env_files()
+def edit_dockercompose(hostname, portmapping, letsencrypt, app_dir='/opt'):
 
     in_layersapp_build = False
 
@@ -341,60 +342,8 @@ def edit_dockercompose(hostname, dbpassword, dbapassword, secretkey, rmqpassword
         elif "hostname:" in line:
             format = line[0:line.find("hostname")].replace("#", "")
             newlines.append(format +"hostname: " + hostname + "\n")
-        elif '- "SECRET_KEY' in line:
-            format = line[0:line.find('- "SECRET_KEY')].replace("#", "")
-            newlines.append(format + '- "SECRET_KEY=' + secretkey + '"\n')
-        elif '- "DATABASE_USER' in line:
-            format = line[0:line.find('- "DATABASE_USER')].replace("#", "")
-            newlines.append(format + '- "DATABASE_USER=layers"\n')
-        elif '- "DATABASE_PASSWORD' in line:
-            format = line[0:line.find('- "DATABASE_PASSWORD')].replace("#", "")
-            newlines.append(format + '- "DATABASE_PASSWORD=' + dbpassword + '"\n')
-        elif '- "MYSQL_ROOT_PASSWORD' in line:
-            format = line[0:line.find('- "MYSQL_ROOT_PASSWORD')].replace("#", "")
-            newlines.append(format + '- "MYSQL_ROOT_PASSWORD=' + dbapassword + '"\n')
-        elif '- "RABBITMQ_DEFAULT_USER' in line:
-            format = line[0:line.find('- "RABBITMQ_DEFAULT_USER')].replace("#", "")
-            newlines.append(format + '- "RABBITMQ_DEFAULT_USER=layermq"\n')
-        elif '- "RABBITMQ_DEFAULT_PASS' in line:
-            format = line[0:line.find('- "RABBITMQ_DEFAULT_PASS')].replace("#", "")
-            newlines.append(format + '- "RABBITMQ_DEFAULT_PASS=' + rmqpassword + '"\n')
-        elif '- "EMAIL_HOST' in line:
-            format = line[0:line.find('- "EMAIL_HOST')].replace("#", "")
-            if email_host:
-                newlines.append(format + '- "EMAIL_HOST=' + email_host + '"\n')
-            else:
-                newlines.append(format + '#- "EMAIL_HOST=<set this here>"\n')
-        elif '- "EMAIL_PORT' in line:
-            format = line[0:line.find('- "EMAIL_PORT')].replace("#", "")
-            if email_port:
-                newlines.append(format + '- "EMAIL_PORT=' + email_port + '"\n')
-            else:
-                newlines.append(format + '#- "EMAIL_PORT=<set this here if not the default>"\n')
-        elif '- "EMAIL_USER' in line:
-            format = line[0:line.find('- "EMAIL_USER')].replace("#", "")
-            if email_user:
-                newlines.append(format + '- "EMAIL_USER=' + email_user + '"\n')
-            else:
-                newlines.append(format + '#- "EMAIL_USER=<set this here if needed>"\n')
-        elif '- "EMAIL_PASSWORD' in line:
-            format = line[0:line.find('- "EMAIL_PASSWORD')].replace("#", "")
-            if email_password:
-                newlines.append(format + '- "EMAIL_PASSWORD=' + email_password + '"\n')
-            else:
-                newlines.append(format + '#- "EMAIL_PASSWORD=<set this here if needed>"\n')
-        elif '- "EMAIL_USE_SSL' in line:
-            format = line[0:line.find('- "EMAIL_USE_SSL')].replace("#", "")
-            if email_ssl:
-                newlines.append(format + '- "EMAIL_USE_SSL=' + str(email_ssl) + '"\n')
-            else:
-                newlines.append(format + '#- "EMAIL_USE_SSL=<set this here if needed>"\n')
-        elif '- "EMAIL_USE_TLS' in line:
-            format = line[0:line.find('- "EMAIL_USE_TLS')].replace("#", "")
-            if email_tls:
-                newlines.append(format + '- "EMAIL_USE_TLS=' + str(email_tls) + '"\n')
-            else:
-                newlines.append(format + '#- "EMAIL_USE_TLS=<set this here if needed>"\n')
+        elif '".env.dev.' in line:
+            newlines.append(line.replace('.env.dev.', '.env.local.') + '\n')
         elif "ports:" in line:
             if in_layersweb:
                 in_layersweb_ports = True
@@ -629,6 +578,40 @@ def write_env_file(app_dir):
             f.write('%s=%s\n' % (k, v))
 
 
+# Write the generated secrets and email settings to .env.local.<service>,
+# starting from the tracked .env.dev.<service> defaults. These files hold
+# secrets and are ignored by git.
+def write_service_env_files(dbpassword, dbapassword, secretkey, rmqpassword, email_host, email_port, email_user, email_password, email_ssl, email_tls):
+    values = {
+        'SECRET_KEY': secretkey,
+        'DATABASE_USER': 'layers',
+        'DATABASE_PASSWORD': dbpassword,
+        'MYSQL_ROOT_PASSWORD': dbapassword,
+        'RABBITMQ_DEFAULT_USER': 'layermq',
+        'RABBITMQ_DEFAULT_PASS': rmqpassword,
+        'EMAIL_HOST': email_host,
+        'EMAIL_PORT': email_port,
+        'EMAIL_USER': email_user,
+        'EMAIL_PASSWORD': email_password,
+        'EMAIL_USE_SSL': str(email_ssl) if email_ssl else None,
+        'EMAIL_USE_TLS': str(email_tls) if email_tls else None,
+        'DEBUG': '0',
+    }
+    for service in ('app', 'celery', 'db', 'rabbit'):
+        newlines = ['# Written by dockersetup.py. Contains secrets; do not commit.\n']
+        for line in readfile('.env.dev.' + service).splitlines():
+            if line.startswith('# '):
+                continue
+            key = line.lstrip('#').split('=', 1)[0]
+            if values.get(key):
+                newlines.append('%s=%s\n' % (key, values[key]))
+            else:
+                newlines.append(line + '\n')
+        filename = '.env.local.' + service
+        with open(os.open(filename, os.O_WRONLY | os.O_CREAT | os.O_TRUNC, 0o600), 'w') as f:
+            f.write(''.join(newlines))
+
+
 def check_connectivity(app_dir='/opt'):
     return_code = subprocess.call(['docker-compose', 'run', '--rm', 'layersapp', app_dir + '/connectivity_check.sh'], shell=False)
     if return_code != 0:
@@ -656,10 +639,15 @@ except argparse.ArgumentTypeError as e:
     sys.exit(1)
 
 if args.update:
-    with open('docker-compose.yml', 'r') as f:
-        for line in f:
-            if 'MYSQL_ROOT_PASSWORD=' in line:
-                dbapassword = line.split('=')[1].rstrip().rstrip('"')
+    dbapassword = 'testingpw'
+    for filename in ('.env.local.db', 'docker-compose.yml'):
+        if os.path.exists(filename):
+            with open(filename, 'r') as f:
+                for line in f:
+                    if 'MYSQL_ROOT_PASSWORD=' in line and not line.lstrip().startswith('#'):
+                        dbapassword = line.split('=')[1].rstrip().rstrip('"')
+                        break
+            if dbapassword != 'testingpw':
                 break
     # Use last project name
     try:
@@ -801,7 +789,8 @@ else:
     edit_dockerfile(args.http_proxy, args.https_proxy, args.no_proxy)
     write_env_file(args.app_dir)
 
-    edit_dockercompose(args.hostname, dbpassword, dbapassword, secretkey, rmqpassword, args.portmapping, args.letsencrypt, email_host, email_port, args.email_user, args.email_password, args.email_ssl, args.email_tls, args.app_dir)
+    write_service_env_files(dbpassword, dbapassword, secretkey, rmqpassword, email_host, email_port, args.email_user, args.email_password, args.email_ssl, args.email_tls)
+    edit_dockercompose(args.hostname, args.portmapping, args.letsencrypt, args.app_dir)
 
     edit_dockerfile_web(args.hostname, args.no_https)
 
-- 
2.56.0


