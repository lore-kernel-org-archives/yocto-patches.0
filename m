Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3323.1792521089472955308
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Oct 2026 11:31:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=B49oFKd6;
 spf=pass (domain: gmail.com, ip: 209.85.215.172, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc751eddf25so1924360a12.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792521089; x=1793125889; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UNUA2+9BfE7j/gSEwYyHFQyF7czRh05JK3pG0kloHxA=;
        b=B49oFKd6afpiA9lWLPYroXQVdhA18hItpHa76ElPhZhLIkvrRnSfcJQmHp/71uR//x
         6qbLiX0nLhJ5H4xidnZbkv3itFN3OjzeuebSlOy4bUi/Lv31Skecr7euBeLEqASnUi7O
         YGO+8wbjgWU7w1ktkClkkl/mt3lugmumVXaUhsEuIYjdPZrhCHWnRcQKjBMnREFt39FS
         Aio9/7vQ86Vd6mPdADOqlI4TIieimcc/BzXaC9r+eJ5BoqyHsY5fKaB/kJEO+FqWnUE8
         yoZgWzvkuEA+IGs4G1ddCGzvv0F+k1wsvCH4KodthlcsDGJDbTLbkmJ73Q/V8u6Ds+bN
         1opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792521089; x=1793125889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UNUA2+9BfE7j/gSEwYyHFQyF7czRh05JK3pG0kloHxA=;
        b=Cm5o6ltmgIgOdrS+fqkELWTE2bET1fJ+Qo/nWnToMNVey8j48Q6hcxKcIX8/qKiKjm
         RJObmlZn2mG6Y0LoKa+ZHKGMCiG9dYrFOkC1yd7aukzV/vwX2xKmIrro+XhhchOD0Rmf
         tVtydLGq2qtrIIBu1zPOIK0Q5DnMNMOlKLvS6y/54yyl2Sgouwe+lU0/QI5tl52jyzTI
         Lb0Ju+EAVzVfY+kL4uzgFN9JAj2hm4IwtTO1CPynfFCdOsGhqqeAMt6OJ/sp3rINh1hH
         dm+94KwAstTRK3tLnYCXt/4RzwVTRi8WK/lpuXWcTz3hx/pblZNfMZLHhv22TWCj0FSD
         zB9Q==
X-Gm-Message-State: AFq9FYLkVzCVPeVX7qh6ahij2OzZ2KdwmLIkLzup7aOrOJBZoB97WHXG
	wBaoYb10H4N+9BM37W857mkaoDOfapoBBCDN74zEzSM7HyGifvo73pPBaK142iD+
X-Gm-Gg: AYBFou2MPOkOSa6lHhSxvzkdIezoPfYWBuf8IDU5YzIl0sKRKNAHj2d83VP1ZB7frbF
	Igg28uK1DlbMVoCtLqPBk7EHktJa8aJ5S0q2KSYIruNLTYNF0SJ2Mro4iQRIHppGoD+nqRsX4/J
	BWe815sFA8kXwGZUoFewJzogHJe9AJ36SGG36dKJA2PMWSBzxQ9Vlgy0NuFZemrz1NETM0ubJC3
	BelYR66ZSafEveCU9q8G7mouZwVI5TYymqXZv/EktBOC7YsCibDsPmUgOuvMsBpHDD3t+qTS0br
	6iqn3RnwRwmy/9gnT25AOxhEaRNCTXVRExs2IRtfDK+55gAfh2ea8D6Ezgd3vA97NIj4xGj7ZlB
	bmG491ohQdfd9/ONNRzHHNOwWbhJl0+TrDLu8tygUlOQwk1sBhd4Xl0XbxT2RKtutqZtjpScY+F
	OqwXAQbodwTgJuZ9bzmGQmBrYM0J4tWJnCq2igojKSOo1qEeQutrMjSP6+mN9RYQYCAupMxirLu
	SQz8NV3kH40qtjGUC3IafDmzlQAujI=
X-Received: by 2002:a17:90b:56cc:b0:3ac:af8b:6f4 with SMTP id 98e67ed59e1d1-3acef4e1328mr9737140a91.37.1792521088723;
        Tue, 20 Oct 2026 11:31:28 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad80cbe295sm526810a91.5.2026.10.20.11.31.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 11:31:27 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH] Use MariaDB instead of MySQL.
Date: Tue, 20 Oct 2026 11:31:00 -0700
Message-ID: <20261020183059.9361-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 18:31:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5112
Content-Type: text/plain; charset="utf-8"

errors.yoctoproject.org runs MariaDB, and layerindex-web uses
mariadb:lts too, so its dumps import as they are. Django and mysqlclient
support both. The MariaDB image has no mysqladmin, so use its
healthcheck.sh.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .devcontainer/devcontainer.json      | 4 ++--
 .devcontainer/docker-compose.dev.yml | 2 +-
 README                               | 2 +-
 docker-compose.prod.yaml             | 4 ++--
 docker-compose.staging.yaml          | 4 ++--
 docker-compose.yaml                  | 5 ++---
 docker/run-tests.sh                  | 6 +++---
 7 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/.devcontainer/devcontainer.json b/.devcontainer/devcontainer.json
index 9d8ef1e..5b2f1c6 100644
--- a/.devcontainer/devcontainer.json
+++ b/.devcontainer/devcontainer.json
@@ -1,5 +1,5 @@
 {
-  "name": "error-report-web (Django + MySQL)",
+  "name": "error-report-web (Django + MariaDB)",
   "dockerComposeFile": [
     "../docker-compose.yaml",
     "docker-compose.dev.yml"
@@ -41,7 +41,7 @@
             "previewLimit": 50,
             "server": "db",
             "port": 3306,
-            "driver": "MySQL",
+            "driver": "MariaDB",
             "name": "errorreport",
             "database": "errorreport",
             "username": "errorreport",
diff --git a/.devcontainer/docker-compose.dev.yml b/.devcontainer/docker-compose.dev.yml
index 32aa685..6b73bd3 100644
--- a/.devcontainer/docker-compose.dev.yml
+++ b/.devcontainer/docker-compose.dev.yml
@@ -1,5 +1,5 @@
 # Devcontainer override for docker-compose.yaml: runserver on the mounted
-# workspace, MySQL port unpublished (no clash with other dev DBs), no nginx.
+# workspace, MariaDB port unpublished (no clash with other dev DBs), no nginx.
 services:
   backend:
     command: ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
diff --git a/README b/README
index 7539329..63f3776 100644
--- a/README
+++ b/README
@@ -44,7 +44,7 @@ For more information on error reporting and log collection see: http://www.yocto
 Docker
 ------
 
-docker-compose.yaml runs a development setup: MySQL, the application in
+docker-compose.yaml runs a development setup: MariaDB, the application in
 gunicorn, and nginx serving it on http://localhost:8080. Its settings are in
 .env.dev.app and .env.dev.db, which hold development-only values.
 
diff --git a/docker-compose.prod.yaml b/docker-compose.prod.yaml
index 582f76c..576590d 100644
--- a/docker-compose.prod.yaml
+++ b/docker-compose.prod.yaml
@@ -1,14 +1,14 @@
 # Prod: nginx with Let's Encrypt TLS in front of gunicorn. See README.
 services:
   db:
-    image: mysql:8.4
+    image: mariadb:lts
     restart: unless-stopped
     volumes:
       - data:/var/lib/mysql
     env_file:
       - .env.prod.db
     healthcheck:
-      test: ["CMD", "mysqladmin", "ping", "-h", "127.0.0.1", "--silent"]
+      test: ["CMD", "healthcheck.sh", "--connect", "--innodb_initialized"]
       timeout: 20s
       retries: 10
 
diff --git a/docker-compose.staging.yaml b/docker-compose.staging.yaml
index 908bbb7..704fcf0 100644
--- a/docker-compose.staging.yaml
+++ b/docker-compose.staging.yaml
@@ -1,14 +1,14 @@
 # Staging: nginx with Let's Encrypt TLS in front of gunicorn. See README.
 services:
   db:
-    image: mysql:8.4
+    image: mariadb:lts
     restart: unless-stopped
     volumes:
       - data:/var/lib/mysql
     env_file:
       - .env.staging.db
     healthcheck:
-      test: ["CMD", "mysqladmin", "ping", "-h", "127.0.0.1", "--silent"]
+      test: ["CMD", "healthcheck.sh", "--connect", "--innodb_initialized"]
       timeout: 20s
       retries: 10
 
diff --git a/docker-compose.yaml b/docker-compose.yaml
index 9f0a735..d5339ab 100644
--- a/docker-compose.yaml
+++ b/docker-compose.yaml
@@ -1,6 +1,6 @@
 services:
   db:
-    image: mysql:8.4
+    image: mariadb:lts
     container_name: error_report_web_db
     restart: always
     volumes:
@@ -10,8 +10,7 @@ services:
     ports:
       - "3306:3306"
     healthcheck:
-      # TCP: MySQL's init-time server only listens on the socket.
-      test: ["CMD", "mysqladmin", "ping", "-h", "127.0.0.1", "--silent"]
+      test: ["CMD", "healthcheck.sh", "--connect", "--innodb_initialized"]
       timeout: 20s
       retries: 10
   
diff --git a/docker/run-tests.sh b/docker/run-tests.sh
index be1faeb..4e7913b 100755
--- a/docker/run-tests.sh
+++ b/docker/run-tests.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Run the tests in the app image against a throwaway MySQL. Used by CI.
+# Run the tests in the app image against a throwaway MariaDB. Used by CI.
 #
 # SPDX-License-Identifier: MIT
 
@@ -17,8 +17,8 @@ trap 'docker rm -f $DB >/dev/null; docker network rm $NET >/dev/null' EXIT
 # Root so Django can create the test database; testingpw isn't a secret.
 docker run -d --name $DB --network $NET --network-alias db \
     -e MYSQL_ROOT_PASSWORD=testingpw -e MYSQL_DATABASE=errorreport \
-    mysql:8.4 >/dev/null
-until docker exec $DB mysql -h127.0.0.1 -uroot -ptestingpw -e 'SELECT 1' >/dev/null 2>&1; do
+    mariadb:lts >/dev/null
+until docker exec $DB healthcheck.sh --connect --innodb_initialized >/dev/null 2>&1; do
     if [ "$(docker inspect -f '{{.State.Running}}' $DB)" != true ]; then
         docker logs $DB | tail -5; exit 1
     fi
-- 
2.56.0

