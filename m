Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3231.1794617419022064784
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 16:50:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=Om4enaKM;
 spf=pass (domain: gmail.com, ip: 209.85.214.175, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ede7cb02daso19063675ad.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 16:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794617418; x=1795222218; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ecAHffuk5bR9HtVYXfGrvMpEJnnD1E99vqmzvFV+qPE=;
        b=Om4enaKMrICnD7f5PPPK+3vnkmBIEM5YdImGpHeQSwzJdB2bipihXJacjRolv7/CGa
         MddtwtlTDMsimboxRBOJ+40VF+oLkMx7g3LmSz6nC/qZdwWy2of9wv6YSZUmjJTF4D6F
         CfO7lnHNufwWChvjVXf4mdDNzfScjgqFt0vGGIYoJJsEwpzXaf85kbI1cJ5V/Bk77Ymn
         khiq9k5pbIlYswU5F0iqjz7fEOqpsBuan9MtzRk1D+4ksu8sQfUV/wN/InmFASc724st
         L65LX8qaB7J9W1AhKigCkh0g8pGMuo0HJ+86vXNw1V6virkna40CmFNAWI2AR6ofol3B
         k5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794617418; x=1795222218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ecAHffuk5bR9HtVYXfGrvMpEJnnD1E99vqmzvFV+qPE=;
        b=V6mPpPA0TLlCI+Wopd1qGSHbzKYdemIFFxO11YtnTnfBUhQPO5RNUQvAkvqG/JswtX
         Aea2PYFyp5MBgxJrVP7XRjUPiyNBVOJvPkd/wxGo4cIpDtdfiyLnfcP3tSBRLNnJtNhb
         gRWIL6w2KHYgCILJEHlKVjg2WXeNTMSaaT/j6+yMaGAMjCrBV/kqLTarjM1AbrlwtTSr
         wTWEsSYjvIHCJcji3BS/4cKRr1Z3iAwZCG8m0Nd4P0cjs9hHWiB5amjuwOjML0RH0jjZ
         qXsx7/44LBoJ26tNJ8jVpi5CcuT9A99/9zKa0Udfa5rmovLpKSHnVApXt1feiScXJ9eO
         2NVQ==
X-Gm-Message-State: APuU4Z9ulmsY2Hq3pp/sRgeL6ujUSwHvRxT0TgzWPIxttbO2if4gq4XK
	B9MuKMHOnSgeybC0NLE1sne55CrwAvWH6XOBjRqIZZ3xyNhWlWU8W/m5ndYb7A==
X-Gm-Gg: AYBFou2ECyIFEae6T+tYke4gQ11bvrSRGZsLHb7bzyV7wClmxHRjXMkZ5MamsJKnScf
	/LfwJRP0NTEbU7yD9gceqb0fIvu/udfB7Y1E5cM8gjwKs2jKc+/RPvdMG9vx6VHmwLwultCNV8M
	Wu5J2qEbExLQAONGKfTurYLU43NDFRlXw0ciRAuy+bMDq+5vyZhhBYz/K2PqHhgVSzh+/SiCfpq
	ksjHjOk7yXk8ZLnPNEjOrmCVdoTu8YeqMsVyOy4Qk/4iVL83JUkOUiipOXSYr+8ftyBooHMnBz6
	dM92njDHVw3/U0R9CjkonkRjmrhTQkyBuemV4jT/HCGliQ9XQL48wWKaZKeU5HkcwCCQLPzcJlY
	PR0Is9gieaIC2SGyQh31ebEkD/o535nekolv4+AiTwX0tCkzLhSk0qS6dNZ0oO1+vQdvN7IhQIl
	2vh36PjBSAs7B+cGuk0cO9ZqLdIyVdzk0LrymakgR0JH20AV2svSF4HPSsUNLWYrz5/RAykc3BH
	4jTiqrk68p52PBftyRkl1KNWSvDi4/qzNHmYrTUV7BqQHwac81pyu6hSTpVCcN6BvywCgo/ZTiN
	KtZuq9UsyEX5TXqDIHSJawzlZHr1ejfWt63oOHonH1OtfejGp1hECZeMKEn/gcQ=
X-Received: by 2002:a17:90b:184b:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3b1b0ccf45cmr2674221a91.30.1794617418291;
        Fri, 13 Nov 2026 16:50:18 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce55c1sm11790295a91.3.2026.11.13.16.50.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 16:50:16 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: mhalstead@linuxfoundation.org,
	Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][RFC PATCH 2/2] docker-compose.nginx-proxy.yml: add a production setup using nginx-proxy
Date: Fri, 13 Nov 2026 16:50:06 -0800
Message-ID: <20261114005006.28193-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114005006.28193-1-tim.orling@konsulko.com>
References: <20261114005006.28193-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 00:50:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5352
Content-Type: text/plain; charset="utf-8"

Add docker-compose.nginx-proxy.yml, which uses nginx-proxy and
acme-companion in place of the layersweb and layerscertbot containers
of docker-compose.prod.yml: the Let's Encrypt certificate is obtained
and renewed automatically, without a hand-edited nginx configuration,
and layersapp serves the static files. The host name and email address
go in .env.prod.proxy.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .env.prod.proxy                |  7 +++
 README.md                      | 12 +++++
 docker-compose.nginx-proxy.yml | 90 ++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 .env.prod.proxy
 create mode 100644 docker-compose.nginx-proxy.yml

diff --git a/.env.prod.proxy b/.env.prod.proxy
new file mode 100644
index 0000000..1350f27
--- /dev/null
+++ b/.env.prod.proxy
@@ -0,0 +1,7 @@
+# For docker-compose.nginx-proxy.yml. Set real values in a local commit on the
+# server; never push them.
+# The site's host name, for nginx-proxy and for the certificate
+#VIRTUAL_HOST=<set this here>
+#LETSENCRYPT_HOST=<set this here>
+# The email address Let's Encrypt sends expiry notices to
+#LETSENCRYPT_EMAIL=<set this here>
diff --git a/README.md b/README.md
index a1f6087..c912034 100644
--- a/README.md
+++ b/README.md
@@ -101,6 +101,18 @@ credentials, email server, `DEBUG`) from `.env.<context>.<service>` files, where
   docker compose -f docker-compose.prod.yml up -d --build
   ```
 
+- `docker-compose.nginx-proxy.yml` is a production setup that uses
+  [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy) and
+  [acme-companion](https://github.com/nginx-proxy/acme-companion) in place of
+  the `layersweb` and `layerscertbot` containers: the certificate is obtained
+  and renewed automatically, and `layersapp` serves the static files. It uses
+  the `.env.prod.*` files, and `.env.prod.proxy` for the host name and the
+  email address for Let's Encrypt:
+
+  ```sh
+  docker compose -f docker-compose.nginx-proxy.yml up -d --build
+  ```
+
 The `.env*` files are excluded from the Docker images.
 
 Other settings the app and celery files can set:
diff --git a/docker-compose.nginx-proxy.yml b/docker-compose.nginx-proxy.yml
new file mode 100644
index 0000000..b9deb44
--- /dev/null
+++ b/docker-compose.nginx-proxy.yml
@@ -0,0 +1,90 @@
+# Production setup with nginx-proxy and acme-companion in place of the
+# layersweb (nginx) and layerscertbot containers of docker-compose.prod.yml:
+# nginx-proxy forwards requests to layersapp, which also serves the static
+# files, and acme-companion gets and renews its Let's Encrypt certificate.
+# Set the host name and email in .env.prod.proxy (see README.md).
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
+     # Only layersapp may read this file: nginx-proxy forwards requests to
+     # every container that has VIRTUAL_HOST set
+     - ".env.prod.proxy"
+    environment:
+      VIRTUAL_PORT: 5000
+    restart: unless-stopped
+
+  layersproxy:
+    depends_on:
+      - layersapp
+    image: nginxproxy/nginx-proxy:1.9-alpine
+    container_name: layersproxy
+    ports:
+     - "443:443"
+     - "80:80"
+    volumes:
+     - certs:/etc/nginx/certs
+     - acmehtml:/usr/share/nginx/html
+     - vhost:/etc/nginx/vhost.d
+     - /var/run/docker.sock:/tmp/docker.sock:ro
+    restart: unless-stopped
+
+  layersacme:
+    depends_on:
+      - layersproxy
+    image: nginxproxy/acme-companion
+    environment:
+      NGINX_PROXY_CONTAINER: layersproxy
+    volumes:
+     - /var/run/docker.sock:/var/run/docker.sock:ro
+     - certs:/etc/nginx/certs
+     - acmehtml:/usr/share/nginx/html
+     - vhost:/etc/nginx/vhost.d
+     - acme:/etc/acme.sh
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
+volumes:
+  layersmeta:
+  mariadb_data:
+  logvolume:
+  certs:
+  acmehtml:
+  vhost:
+  acme:
-- 
2.56.0

