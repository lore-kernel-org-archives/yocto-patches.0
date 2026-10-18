Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B0ECCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 02:02:46 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7982.1792288965028029358
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 19:02:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Ebsk6W/z;
 spf=pass (domain: gmail.com, ip: 209.85.215.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso728759a12.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 19:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288964; x=1792893764; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aT3TzLIKd/y/G/5/GBZQtjRzvOdRA7AcEO17RAuKEL0=;
        b=Ebsk6W/zYOhMOK/JKLb7aLe2IUkhIktjxmYeGvRQ2luWezypqKEvK9QRYFFQt8yb0Q
         u+HOEK9Htfrq7HCxriY2hdHLY3QhXp71fE7EcNcEV5k6pGEQ54IR+ff7CbQBWRFSoFpy
         8gEEj/rY0CpMZX+n7kpwdlBFWkcaFyfKnbEn1MEp9TYVtPQLGx+sW52qmxe0x/8wzMU9
         UwZn+TlAfLHL2om1p+Qa+qKRJcCN40PAksRrbtQgj/CR45VGsTPuVMGM8RDd4KvhgX6z
         HkSbQklJQBTjo58ibbMNHXS2hKaIuuygYYkXTJkFTz7Rg2n0V4n1pr4gMogWslKj09NA
         80lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288964; x=1792893764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aT3TzLIKd/y/G/5/GBZQtjRzvOdRA7AcEO17RAuKEL0=;
        b=zkRM9pulkrG+esD9pQKxZJHjWt1xsa89qodvMi4hCfifTB6y8ahaISIqGBYZvBWXQ3
         hClCPiau+EdG5a4Y2HWC3zqxqqrKynHfa1JGAf8OWL8Axi5AFJdsbAhgrQk4LwDh++wr
         QJ3gN245y/EY7Zz0ROsmi/jglOlQRw2VM+xnhV1dGnukS+/cTdkMWUMWzR/6Mmiv+9pM
         +7RrwOB2OTGBkwqqtkzZ54tvMXKIoAM1nYQzXUVnKw5PTVI4DvhuRXgPYw49CMN3XtAI
         1wIjnWB5PXCyVQpO58yfJrTdXWjnXULpC4158U94DWgStQwlcsF4sUTiF+6exh0M2CR6
         n33A==
X-Gm-Message-State: AFq9FYLfcBZBmHDYYC9ncdr42szQezuS2qVtlE68/WTKwUmFijZhgU84
	RoTUHVCxDuJ5EtExrwlUKjjr/9W75uFA57V2TyipnTRxUb9uh0x0jRe8puSb+zm9
X-Gm-Gg: AYBFou06FiLXS9BVWT/B9AH5ZBC6yhkuiLpxM2BDwA2e98vBI6RPHAo9DhCHzCqWXTA
	07GoCbg1ul2l5H7onerLm7ShXaSY8FvZ2L02HLBkjrfvvJqcdpOXf1ZHNchgKzdUGlB6cS9n/hs
	KQk8QnZK37E2tGP1OidtGmDiy5O6ttBjP4bjvFtQO+kZlJqe6IcCmjgj5SubFXDusumUyZVXBIF
	YvIDT+HLGXgeBml1rRLeDU1sRrdojp2hxX9FttzLqxykPQCKlDTrFb/mLJO3C424qe/nyyfwQFu
	rmp55KWs5OP63OtUN7ADWJ3UrE5X+nxUSEtWMhPq/6s4j9vzl3J/KyeK6cMRP0OCK8a2ZDz7QVQ
	qErWcrNVTGN95V/9cJfYUmceCSfYfTe5BRgYvOSxY/9wtsSgOl3VCbSvV3Ay5qFN1/xSRtKVR4k
	LxYuTsoUYytWmFK8Ciq1Lv1KQp1nQhHbdQ0IFx2kpByHvdRI8UAzzuN4YViaOfvWff8Fxv0bzyg
	XzL6xQo8IAIGTPL8MMmBafQLRZstKL0
X-Received: by 2002:a17:90a:c110:b0:39e:6a80:b799 with SMTP id 98e67ed59e1d1-3aceefab282mr3156394a91.41.1792288964210;
        Sat, 17 Oct 2026 19:02:44 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947928b4sm14569131a91.11.2026.10.17.19.02.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 19:02:42 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 2/4] Add staging and production docker-compose setups with env files.
Date: Sat, 17 Oct 2026 18:57:07 -0700
Message-ID: <20261018020116.75276-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018020116.75276-1-tim.orling@konsulko.com>
References: <20261018020116.75276-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 02:02:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5063

Follow layerindex-web's timo/docker-compose-env branch: tracked
.env.{dev,staging,prod}.{app,db}, with real values in a local commit on
the server. Staging and prod leave secrets commented out, so nothing
starts with a known password, and serve HTTPS with Let's Encrypt
(staging from its staging server); certbot renews. /ClientPost/ stays on
HTTP, as send-error-report may post there. The db healthcheck no longer
needs the root password. Keep docker/certs out of git and the env files
out of the image.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .dockerignore               |  2 ++
 .env.dev.app                |  8 +++++
 .env.dev.db                 |  5 +++
 .env.prod.app               |  9 +++++
 .env.prod.db                |  6 ++++
 .env.staging.app            |  9 +++++
 .env.staging.db             |  6 ++++
 .gitignore                  |  1 +
 README                      | 39 ++++++++++++++++++++
 docker-compose.prod.yaml    | 55 ++++++++++++++++++++++++++++
 docker-compose.staging.yaml | 55 ++++++++++++++++++++++++++++
 docker-compose.yaml         | 12 +++----
 docker/nginx-ssl.conf       | 72 +++++++++++++++++++++++++++++++++++++
 13 files changed, 272 insertions(+), 7 deletions(-)
 create mode 100644 .env.dev.app
 create mode 100644 .env.dev.db
 create mode 100644 .env.prod.app
 create mode 100644 .env.prod.db
 create mode 100644 .env.staging.app
 create mode 100644 .env.staging.db
 create mode 100644 docker-compose.prod.yaml
 create mode 100644 docker-compose.staging.yaml
 create mode 100644 docker/nginx-ssl.conf

diff --git a/.dockerignore b/.dockerignore
index adce5c5..217a4a4 100644
--- a/.dockerignore
+++ b/.dockerignore
@@ -8,3 +8,5 @@ __pycache__
 *.patch
 venv
 .venv
+.env.*
+docker/certs
diff --git a/.env.dev.app b/.env.dev.app
new file mode 100644
index 0000000..26e1c54
--- /dev/null
+++ b/.env.dev.app
@@ -0,0 +1,8 @@
+# Development only; not secret.
+SECRET_KEY=dev-only-not-secret
+DEBUG=1
+ALLOWED_HOSTS=localhost,127.0.0.1
+MYSQL_DATABASE=errorreport
+MYSQL_USER=errorreport
+MYSQL_PASSWORD=testingpw
+#CSP_REPORT_ONLY=1
diff --git a/.env.dev.db b/.env.dev.db
new file mode 100644
index 0000000..72b7b32
--- /dev/null
+++ b/.env.dev.db
@@ -0,0 +1,5 @@
+# Development only; not secret.
+MYSQL_DATABASE=errorreport
+MYSQL_USER=errorreport
+MYSQL_PASSWORD=testingpw
+MYSQL_ROOT_PASSWORD=testingpw
diff --git a/.env.prod.app b/.env.prod.app
new file mode 100644
index 0000000..485c553
--- /dev/null
+++ b/.env.prod.app
@@ -0,0 +1,9 @@
+# Set real values in a local commit on the server; never push them.
+# Commented-out secrets stop the service starting.
+#SECRET_KEY=<set this here>
+DEBUG=0
+ALLOWED_HOSTS=errors.yoctoproject.org
+MYSQL_DATABASE=errorreport
+MYSQL_USER=errorreport
+#MYSQL_PASSWORD=<set this here, same as in .env.prod.db>
+#CSP_REPORT_ONLY=1
diff --git a/.env.prod.db b/.env.prod.db
new file mode 100644
index 0000000..55fc5fd
--- /dev/null
+++ b/.env.prod.db
@@ -0,0 +1,6 @@
+# Set real values in a local commit on the server; never push them.
+# Commented-out secrets stop the service starting.
+MYSQL_DATABASE=errorreport
+MYSQL_USER=errorreport
+#MYSQL_PASSWORD=<set this here, same as in .env.prod.app>
+#MYSQL_ROOT_PASSWORD=<set this here>
diff --git a/.env.staging.app b/.env.staging.app
new file mode 100644
index 0000000..d9aeeb0
--- /dev/null
+++ b/.env.staging.app
@@ -0,0 +1,9 @@
+# Set real values in a local commit on the server; never push them.
+# Commented-out secrets stop the service starting.
+#SECRET_KEY=<set this here>
+DEBUG=0
+#ALLOWED_HOSTS=<set this here>
+MYSQL_DATABASE=errorreport
+MYSQL_USER=errorreport
+#MYSQL_PASSWORD=<set this here, same as in .env.staging.db>
+#CSP_REPORT_ONLY=1
diff --git a/.env.staging.db b/.env.staging.db
new file mode 100644
index 0000000..ca595b1
--- /dev/null
+++ b/.env.staging.db
@@ -0,0 +1,6 @@
+# Set real values in a local commit on the server; never push them.
+# Commented-out secrets stop the service starting.
+MYSQL_DATABASE=errorreport
+MYSQL_USER=errorreport
+#MYSQL_PASSWORD=<set this here, same as in .env.staging.app>
+#MYSQL_ROOT_PASSWORD=<set this here>
diff --git a/.gitignore b/.gitignore
index 2b8f143..a0a7642 100644
--- a/.gitignore
+++ b/.gitignore
@@ -8,3 +8,4 @@ pull-*/
 venv
 *.sqlite3
 .env
+docker/certs/
diff --git a/README b/README
index a7bb64c..7539329 100644
--- a/README
+++ b/README
@@ -41,6 +41,45 @@ In order to send an error report to the server, run the "send-error-report file_
 
 For more information on error reporting and log collection see: http://www.yoctoproject.org/docs/current/dev-manual/dev-manual.html#using-the-error-reporting-tool
 
+Docker
+------
+
+docker-compose.yaml runs a development setup: MySQL, the application in
+gunicorn, and nginx serving it on http://localhost:8080. Its settings are in
+.env.dev.app and .env.dev.db, which hold development-only values.
+
+  docker compose up -d --build
+
+To run the tests in a container, as CI does:
+
+  docker/run-tests.sh
+
+docker-compose.staging.yaml and docker-compose.prod.yaml serve the site over
+HTTPS on ports 80 and 443, with a certificate from Let's Encrypt. Staging uses
+Let's Encrypt's staging server, whose certificates browsers don't trust but
+whose rate limits are generous; production uses the real server. Taking prod
+as the example:
+
+1. Set the real values in .env.prod.app and .env.prod.db (SECRET_KEY,
+   ALLOWED_HOSTS and the database passwords) in a local commit on the server.
+   Never push them.
+2. Get the first certificate. nginx needs it to start, so certbot answers the
+   challenge itself on port 80 (for staging, use docker-compose.staging.yaml
+   and add --test-cert):
+
+     docker compose -f docker-compose.prod.yaml run --rm -p 80:80 \
+         --entrypoint certbot certbot certonly --standalone \
+         --cert-name error-report-web -d errors.example.org \
+         -m you@example.org --agree-tos --no-eff-email
+
+   The certificate is stored in docker/certs, which git ignores.
+3. Start everything:
+
+     docker compose -f docker-compose.prod.yaml up -d --build
+
+The certbot container renews the certificate from the server that issued it,
+and nginx reloads every 6 hours to pick it up.
+
 Content Security Policy
 -----------------------
 
diff --git a/docker-compose.prod.yaml b/docker-compose.prod.yaml
new file mode 100644
index 0000000..582f76c
--- /dev/null
+++ b/docker-compose.prod.yaml
@@ -0,0 +1,55 @@
+# Prod: nginx with Let's Encrypt TLS in front of gunicorn. See README.
+services:
+  db:
+    image: mysql:8.4
+    restart: unless-stopped
+    volumes:
+      - data:/var/lib/mysql
+    env_file:
+      - .env.prod.db
+    healthcheck:
+      test: ["CMD", "mysqladmin", "ping", "-h", "127.0.0.1", "--silent"]
+      timeout: 20s
+      retries: 10
+
+  backend:
+    build: .
+    command: sh -c "python3 manage.py migrate --noinput && python3 manage.py collectstatic --noinput && gunicorn project.wsgi --bind=:8000 --workers=4 --timeout=60"
+    restart: unless-stopped
+    volumes:
+      - static:/app/staticfiles
+    env_file:
+      - .env.prod.app
+    depends_on:
+      db:
+        condition: service_healthy
+
+  web:
+    image: nginx:1.30
+    restart: unless-stopped
+    ports:
+      - "80:80"
+      - "443:443"
+    volumes:
+      - ./docker/nginx-ssl.conf:/etc/nginx/nginx.conf:ro
+      - static:/usr/share/nginx/html/static:ro
+      - ./docker/certs:/etc/letsencrypt:ro
+      - certbot-www:/var/www/certbot:ro
+    # Reload every 6 hours to pick up renewed certificates.
+    command: "/bin/sh -c 'while :; do sleep 6h & wait $${!}; nginx -s reload; done & nginx -g \"daemon off;\"'"
+    depends_on:
+      - backend
+
+  # Renews from whichever Let's Encrypt server issued the certificate.
+  certbot:
+    image: certbot/certbot
+    restart: unless-stopped
+    volumes:
+      - ./docker/certs:/etc/letsencrypt
+      - certbot-www:/var/www/certbot
+    entrypoint: "/bin/sh -c 'trap exit TERM; while :; do certbot renew --webroot -w /var/www/certbot; sleep 12h & wait $${!}; done;'"
+
+volumes:
+  data:
+  static:
+  certbot-www:
diff --git a/docker-compose.staging.yaml b/docker-compose.staging.yaml
new file mode 100644
index 0000000..908bbb7
--- /dev/null
+++ b/docker-compose.staging.yaml
@@ -0,0 +1,55 @@
+# Staging: nginx with Let's Encrypt TLS in front of gunicorn. See README.
+services:
+  db:
+    image: mysql:8.4
+    restart: unless-stopped
+    volumes:
+      - data:/var/lib/mysql
+    env_file:
+      - .env.staging.db
+    healthcheck:
+      test: ["CMD", "mysqladmin", "ping", "-h", "127.0.0.1", "--silent"]
+      timeout: 20s
+      retries: 10
+
+  backend:
+    build: .
+    command: sh -c "python3 manage.py migrate --noinput && python3 manage.py collectstatic --noinput && gunicorn project.wsgi --bind=:8000 --workers=4 --timeout=60"
+    restart: unless-stopped
+    volumes:
+      - static:/app/staticfiles
+    env_file:
+      - .env.staging.app
+    depends_on:
+      db:
+        condition: service_healthy
+
+  web:
+    image: nginx:1.30
+    restart: unless-stopped
+    ports:
+      - "80:80"
+      - "443:443"
+    volumes:
+      - ./docker/nginx-ssl.conf:/etc/nginx/nginx.conf:ro
+      - static:/usr/share/nginx/html/static:ro
+      - ./docker/certs:/etc/letsencrypt:ro
+      - certbot-www:/var/www/certbot:ro
+    # Reload every 6 hours to pick up renewed certificates.
+    command: "/bin/sh -c 'while :; do sleep 6h & wait $${!}; nginx -s reload; done & nginx -g \"daemon off;\"'"
+    depends_on:
+      - backend
+
+  # Renews from whichever Let's Encrypt server issued the certificate.
+  certbot:
+    image: certbot/certbot
+    restart: unless-stopped
+    volumes:
+      - ./docker/certs:/etc/letsencrypt
+      - certbot-www:/var/www/certbot
+    entrypoint: "/bin/sh -c 'trap exit TERM; while :; do certbot renew --webroot -w /var/www/certbot; sleep 12h & wait $${!}; done;'"
+
+volumes:
+  data:
+  static:
+  certbot-www:
diff --git a/docker-compose.yaml b/docker-compose.yaml
index 1fcb242..9f0a735 100644
--- a/docker-compose.yaml
+++ b/docker-compose.yaml
@@ -5,15 +5,13 @@ services:
     restart: always
     volumes:
       - data:/var/lib/mysql
-    environment:
-      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
-      MYSQL_DATABASE: ${MYSQL_DATABASE}
-      MYSQL_USER: ${MYSQL_USER}
-      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
+    env_file:
+      - .env.dev.db
     ports:
       - "3306:3306"
     healthcheck:
-      test: ["CMD", "mysql", "-h", "localhost", "-u", "root", "-p${MYSQL_ROOT_PASSWORD}", "-e", "SELECT 1"]
+      # TCP: MySQL's init-time server only listens on the socket.
+      test: ["CMD", "mysqladmin", "ping", "-h", "127.0.0.1", "--silent"]
       timeout: 20s
       retries: 10
   
@@ -27,7 +25,7 @@ services:
     volumes:
       - static:/app/staticfiles
     env_file:
-      - .env
+      - .env.dev.app
     depends_on:
       db:
          condition: service_healthy
diff --git a/docker/nginx-ssl.conf b/docker/nginx-ssl.conf
new file mode 100644
index 0000000..264ecca
--- /dev/null
+++ b/docker/nginx-ssl.conf
@@ -0,0 +1,72 @@
+# nginx with TLS for docker-compose.{staging,prod}.yaml; see README.
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
+    # Reports can be up to DATA_UPLOAD_MAX_MEMORY_SIZE (10MB).
+    client_max_body_size 10m;
+    keepalive_timeout 20;
+
+    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
+    # Overwrites the client's value; Django trusts it.
+    proxy_set_header X-Forwarded-Proto $scheme;
+    proxy_set_header Host $http_host;
+    proxy_redirect off;
+
+    server {
+        listen 80 default_server;
+        server_name _;
+
+        location /.well-known/acme-challenge/ {
+            root /var/www/certbot;
+        }
+
+        # send-error-report may POST over HTTP; a redirect would drop it.
+        location /ClientPost/ {
+            proxy_pass http://app_server;
+        }
+
+        location / {
+            return 301 https://$host$request_uri;
+        }
+    }
+
+    server {
+        listen 443 ssl default_server;
+        server_name _;
+        ssl_certificate     /etc/letsencrypt/live/error-report-web/fullchain.pem;
+        ssl_certificate_key /etc/letsencrypt/live/error-report-web/privkey.pem;
+        ssl_protocols       TLSv1.2 TLSv1.3;
+        ssl_session_cache   shared:SSL:12m;
+        ssl_session_timeout 12m;
+
+        # path for static files
+        root /usr/share/nginx/html;
+
+        location / {
+            try_files $uri @proxy_to_app;
+        }
+
+        location @proxy_to_app {
+            proxy_pass http://app_server;
+        }
+    }
+}
-- 
2.56.0


