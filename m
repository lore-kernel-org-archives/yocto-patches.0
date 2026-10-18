Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F01CCF2C7
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 02:01:56 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8020.1792288908231865195
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 19:01:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=I3irTvEc;
 spf=pass (domain: gmail.com, ip: 209.85.216.53, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso638100a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 19:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288907; x=1792893707; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p9M3MLZaamTylsuBAxRFX4wRzkj6g7kG5tVO3UeqlmE=;
        b=I3irTvEcezaoExz5tRCuDi6rSl3nyI/g3M7U5+IFKEsFRjLclpdpBl9kzRjRypGcFY
         7EF/9N0L2+N+J1D11xZ9fz5OCRXiVSE2lyKQRQEcYVYy3V1uV05yP/cMElFl1zyaFg0U
         sbDHU+prCTpwUlRnWSc4uGt9oXu16CHcwFTNQOyV1P7tBZlnKKtf/kisA4cZVDLoHBwD
         XjmYGSvI0RboS1/jCxcCrgPNXnfStPmVc9koXO36jiwUenyvNBchrfdsUGEgYMOdQQoA
         2Ztu++z3eDKj/qzZ7LEagdDXZ8kdAqLt46HAzopn4zzqPhjRBbvj3Cs69hPqXZqK7WXx
         0lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288907; x=1792893707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p9M3MLZaamTylsuBAxRFX4wRzkj6g7kG5tVO3UeqlmE=;
        b=rSdKNALYEo3vE/ge13Y0TdwxtqKxmYC6Xxb1456DjTYW+xf7rZXXGfxQAQbHowa8CG
         mxLIXTm9CsUGzykujy0YMdSYXrnuQQKPHC4UkKzHyL7+QZhPedNZ3y7pTdOuU874wPbZ
         nWZTp14avnqdqkEWk/OYUTXKk6oTDUBa0KsfUFhCP+9SHW7Kj+IRD3Wfbh3hk4L3Brba
         ohqo7pk9SqrM2fZqQzo9mcwKIuPOvatk4q4XMX51ghTfuFiLvGqWoI6Ow5+WtCaiG0yD
         5vfcNeIGj4kvJ1jUVfxxZPWMBU44sa5UICMVJe5cndkw00KaDwglhvOIZ0eeLvH75RGq
         4upQ==
X-Gm-Message-State: AFq9FYKzR8mBmeFBLtgA9XUfxl5Deh2bo+BsMsKIjV3hDAOdFfuHNmWT
	+/rd/eYe6QjrQCnjxfBt+XMR3k6dDdp4atOFzLiABupjtAZ1Opz7TXAbsqrbGA==
X-Gm-Gg: AYBFou0/+7CeYBK8I6B9Ae+e0TE/hHbHOoApmCHje2AWkqakkZwBPwifN4cNuSA9ZbO
	GldKfm5POM0/i6sb4Z0WivE47uRZ1dqNtsKpHisFo4fzPKW/IoSP+3grah1SaZs+/Ec/LQWaGjC
	wsGbLYm93cLIg/z9znFoK1hRGcYgY5DHaPePNaIDQxzSeH2uBWFtNIDYIGn6RDegVkOP0rudeF6
	tNFkTGC4a+Qn20oZEsngQXkf55ta+BlwH9w7hu6/PuhGRWgDkJO/uiWP2sOY6ZZJH6jG5qQwhz3
	2zfVuA1dqH/vpYu4SPJR68ICJaLi8s98TITb8pzEsX3HNXXPxmSWWERHONtDvytXlU4P6ckodiD
	qVieH/yIl+vO1orTG8LMo6nA2adYjJx45uUhHB9QJQGVBV5lrAdR4JvFeRbYEpkoawEHffuDUka
	pRDpUN3z9Jt5BLZAPp4OK2bEV94tD1vvlyO/29S07kUj2HrGZA4KMCLcfujz+VwSerW+BLavOeI
	cOu1f+HZSqMhwUI86Traohd05meyvo=
X-Received: by 2002:a17:90b:4a4d:b0:3ac:97bc:4c98 with SMTP id 98e67ed59e1d1-3acef648c40mr3531731a91.64.1792288907515;
        Sat, 17 Oct 2026 19:01:47 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947928b4sm14569131a91.11.2026.10.17.19.01.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 19:01:45 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 1/4] Run gunicorn behind nginx in docker-compose.
Date: Sat, 17 Oct 2026 18:57:05 -0700
Message-ID: <20261018020116.75276-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018020116.75276-1-tim.orling@konsulko.com>
References: <20261018020116.75276-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 02:01:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5062

As in layerindex-web, nginx serves static files and proxies to
gunicorn. Unlike it, nginx sets X-Forwarded-Proto and accepts 10MB
reports. Drop the obsolete compose version key.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Dockerfile                 |  2 +-
 docker-compose.yaml        | 20 ++++++++++++----
 docker/nginx.conf          | 49 ++++++++++++++++++++++++++++++++++++++
 project/settings.py.docker |  3 ++-
 4 files changed, 68 insertions(+), 6 deletions(-)
 create mode 100644 docker/nginx.conf

diff --git a/Dockerfile b/Dockerfile
index 94d55a6..b786a8c 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -10,7 +10,7 @@ WORKDIR /app
 
 # Install dependencies
 COPY requirements.txt /app/
-RUN pip install -r requirements.txt
+RUN pip install -r requirements.txt gunicorn==26.2.0
 
 # Copy the project code into the container
 COPY . /app/
diff --git a/docker-compose.yaml b/docker-compose.yaml
index 0291ff5..1fcb242 100644
--- a/docker-compose.yaml
+++ b/docker-compose.yaml
@@ -1,4 +1,3 @@
-version: '3'
 services:
   db:
     image: mysql:8.4
@@ -23,14 +22,27 @@ services:
       context: .
       dockerfile: Dockerfile
     container_name: error_report_web_backend
-    command: sh -c "python3 manage.py migrate --noinput && python3 manage.py runserver 0.0.0.0:8000"
+    command: sh -c "python3 manage.py migrate --noinput && python3 manage.py collectstatic --noinput && gunicorn project.wsgi --bind=:8000 --workers=4 --timeout=60"
     restart: always
-    ports:
-      - "8000:8000"
+    volumes:
+      - static:/app/staticfiles
     env_file:
       - .env
     depends_on:
       db:
          condition: service_healthy
+
+  web:
+    image: nginx:1.30
+    container_name: error_report_web_nginx
+    restart: always
+    ports:
+      - "8080:80"
+    volumes:
+      - ./docker/nginx.conf:/etc/nginx/nginx.conf:ro
+      - static:/usr/share/nginx/html/static:ro
+    depends_on:
+      - backend
 volumes:
   data:
+  static:
diff --git a/docker/nginx.conf b/docker/nginx.conf
new file mode 100644
index 0000000..f1afcd4
--- /dev/null
+++ b/docker/nginx.conf
@@ -0,0 +1,49 @@
+# nginx in front of gunicorn, plain HTTP for local use. Production uses
+# nginx-ssl.conf.
+#
+# SPDX-License-Identifier: MIT
+
+error_log /dev/stdout info;
+worker_processes 1;
+pid /tmp/nginx.pid;
+
+events {
+    worker_connections 1024;
+    accept_mutex off;
+}
+
+http {
+    include mime.types;
+    default_type application/octet-stream;
+    access_log /dev/stdout combined;
+    sendfile on;
+
+    upstream app_server {
+        server backend:8000 fail_timeout=0;
+    }
+
+    server {
+        listen 80 default;
+        server_name _;
+        # Reports can be up to DATA_UPLOAD_MAX_MEMORY_SIZE (10MB).
+        client_max_body_size 10m;
+        keepalive_timeout 20;
+
+        # path for static files
+        root /usr/share/nginx/html;
+
+        location / {
+            try_files $uri @proxy_to_app;
+        }
+
+        location @proxy_to_app {
+            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
+            # Overwrites the client's value; Django trusts it.
+            proxy_set_header X-Forwarded-Proto $scheme;
+            proxy_set_header Host $http_host;
+            proxy_redirect off;
+
+            proxy_pass http://app_server;
+        }
+    }
+}
diff --git a/project/settings.py.docker b/project/settings.py.docker
index e1f9812..8cc9b7f 100644
--- a/project/settings.py.docker
+++ b/project/settings.py.docker
@@ -105,7 +105,8 @@ MEDIA_URL = ''
 # Don't put anything in this directory yourself; store your static files
 # in apps' "static/" subdirectories and in STATICFILES_DIRS.
 # Example: "/home/media/media.lawrence.com/static/"
-STATIC_ROOT = ''
+# Shared with nginx.
+STATIC_ROOT = '/app/staticfiles'
 
 # URL prefix for static files.
 # Example: "http://media.lawrence.com/static/"
-- 
2.56.0


