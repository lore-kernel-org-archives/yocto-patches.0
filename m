Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12927.1794770290169873063
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 11:18:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=Y9yqWNos;
 spf=pass (domain: gmail.com, ip: 209.85.216.45, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso1227976a91.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 11:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794770289; x=1795375089; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=trKPoHHfmcWC2GPMk76z+1ezqHrJDqzl+KxKQyQYAEQ=;
        b=Y9yqWNosIRx+assqmZkbVrE6+IlQEilK6rZYMM/+Xp+eAajl1VPr0Cc6PCUL8xI8M2
         cw72Vh3iSYp/PsvYEH+meBFYb4dqmDsb+tJbjrZa0IuM34Mr10hbhocsd6T5f+I5PnJ3
         e6iTg7ziEuBAUU55J6/rbM9Taan5fsUNbj9wdMJ10aHYN/E/+qGi9iKUP/EjfRr6gUcx
         QBnBbQ8gKvNt+Odd+CX94a48w/Af6kyLtEdJW2y8ISssEGNS9oSioPP6GSnFfwoJbV1t
         LEQtMpdFKtmBFZHkZ/E2vHPSBlMFKkGWJ+9DbFLgo7q3ZFuJNJmaBEcEgw1/4rUBRP0L
         ULaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794770289; x=1795375089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=trKPoHHfmcWC2GPMk76z+1ezqHrJDqzl+KxKQyQYAEQ=;
        b=dJX1yxSQHrAiqHmFWtmHjsNgKEfedbPJ7+ZFFgvdbspm7GxGPkLxw2dwnjqgPRw3zW
         c3csW+ytv8gjcZLJNvuPSVjXVZOKI2QGg21uX5RVHaXzcCDsFXUVn2jH2ijUKZnbo7/Y
         kh9b8ZyjThz1SDE4gyxSO5DTPxBhrhVgCVJtHk4bNiXSRbMNM3vlDtAqRIq4D8WNO43F
         BazlYSPSaBpdNA2G0gH1R8BmE0CGkZwai5CMjGhIh3+ZP3nrwansOm71LFGPQNx/vQdg
         x9fIzFXCeCqtBF8Z7BUbVZX6u0zH1+O2goU3eoTbZpC+54qk+S/k5IoJ1XprX6f7wjcQ
         C8Dw==
X-Gm-Message-State: APuU4Z9++A2oncG6MRGqZeapxnoJG6TLJcm+sv1/HW9PVeQFXhliNAcH
	Yv8HVUCa1GQLLR6C2mXbS/h25RZhpFlun9dHnMrDFijUiqFjpW30F0m5qL79lg==
X-Gm-Gg: AYBFou3WNBqKjpuvrXkB6D+C9rdZeJJcuj0k0GqATnkjL4LFAsaFFZnikjjuqmsR6qW
	Za8iKjkPEj+5oCG6NGTJolT6JQoBqA3c6C4qyo9rYqP/WsRnuxIwbtR22vi2NBqrt9dCfUGU8wa
	BkkVUEvLr9FHyuT8ywk9doTmWxoROymHRpW8aJriGHjdJGC5qnutx84X3gCzqs18tagRoKaCt0b
	OZv19WKncK5SxEzNhDRGDDcDuvfkBY3agODI5yUfDBdMHYT0jgLQJOdjCKYMubWSvsj5Cj5vm0B
	ZYJT9pEdtJLEDCya26R+5SzhlvKRkipuWAsLDBTtvzrrawYPS7YIPZ0Kdcn7WfVejAPpS39LXRM
	sqja2YbSb14GRCfs3IvkNY3N+KoectMaG7zT/ZrjWhyOzWidpYN9pmQ1aWzNS6aFbGYaCDJfc5P
	eYPqOoakHyazta7A3qsXba77AkIJKl0zOBG7Gfb5y1Xq65jxHHl4ll+aByoL24KADd6CO4/BJ1G
	owmicVkhbw4iBDX0yDDw1PGWcyIccqA9RlSQsIyKrACAyAMoguiCr+cLJ5AxFHyroRqTiSPZDfO
	0r1FlHp+pvIVojBvA4q3zYC+isNqGkEJ9GjZjrqzWy4iC7WpprzsRsToXAOloQ==
X-Received: by 2002:a17:90b:5806:b0:3a7:e11c:4e6e with SMTP id 98e67ed59e1d1-3b1b0b8b064mr7992958a91.59.1794770289478;
        Sun, 15 Nov 2026 11:18:09 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c6dd2dsm17977070a91.2.2026.11.15.11.18.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 11:18:08 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][RFC PATCH v2 2/2] docker-compose.nginx-proxy.yml: add a production setup using nginx-proxy
Date: Sun, 15 Nov 2026 11:17:34 -0800
Message-ID: <20261115191734.23604-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115191734.23604-1-tim.orling@konsulko.com>
References: <20261115191734.23604-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 19:18:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5397
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
 docker-compose.nginx-proxy.yml | 93 ++++++++++++++++++++++++++++++++++
 tests/test_dockersetup.py      |  3 +-
 4 files changed, 114 insertions(+), 1 deletion(-)
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
index 0000000..7ce1ec4
--- /dev/null
+++ b/docker-compose.nginx-proxy.yml
@@ -0,0 +1,93 @@
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
+    # "docker compose run" of update.py and the RRS tools: reap the
+    # bitbake servers that recipe parsing leaves behind
+    init: true
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
diff --git a/tests/test_dockersetup.py b/tests/test_dockersetup.py
index 4d61ee7..d94ab05 100644
--- a/tests/test_dockersetup.py
+++ b/tests/test_dockersetup.py
@@ -203,7 +203,8 @@ def test_compose_command(monkeypatch, result, expected):
 
 
 @pytest.mark.parametrize('compose_file', ['docker-compose.yml', 'docker-compose.prod.yml',
-                                          'docker-compose.staging.yml'])
+                                          'docker-compose.staging.yml',
+                                          'docker-compose.nginx-proxy.yml'])
 def test_compose_layersapp_has_init(compose_file):
     # [YOCTO #16515] in "docker compose run --rm layersapp ..." the script is
     # process 1; without an init process the bitbake servers started by
-- 
2.56.1

