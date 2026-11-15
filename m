Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13009.1794770286823350575
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 11:18:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=zaBOqkg2;
 spf=pass (domain: gmail.com, ip: 209.85.215.174, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so968502a12.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 11:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794770286; x=1795375086; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a3BMKvtT94aNr+kGdd+j6ZpTK7kd40ViMj0e8EkX7hk=;
        b=zaBOqkg2mcdUD9yeA1ZhTn0W3RgTRqoKrWDz6dreAGQJ2YqvX8tdoS4qpuLW1lUOBY
         VuI3seFONbt2/0VdO+nIav+t6sDQ5m1qpgiLYfR+wO1I2wiRJex9+fn3eSd263eDlb5x
         JGPyItUR28PIIHU8qGsdCO2cLXI5nkqaW5v9UaLMZp4qV2wANNwcSf1Vb/wChrI8PEZk
         ZLqo61j5WYmoerTLCp6zTrhcLK+VGIP84zpFsuCC/bcWLRYsOCi1D3qnyq7c+zOJjLAo
         4flWbgKZS7GUhQfe9ruEk9YzvhbujEWidYtMKM0c4fERp2YU8qboKGPyTTv8dVFV/KQ9
         WtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794770286; x=1795375086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a3BMKvtT94aNr+kGdd+j6ZpTK7kd40ViMj0e8EkX7hk=;
        b=jq9Pv2XrD1Dt0Bz+tWLquHeYDAOU0DthJVu7Y4/J0vANrbdrUfnKGVgqWTJvMbJL1z
         +CyDO9q5oWhWYOgns0xrvfK00SoD0DVufXC96yZ5Uem8HpyNv+HyxcGHHcDcbEd2izDK
         KpaHLGd4aHVcovEqe+9ldqQHntSz+71rUffGW+roD1RBZ4964MkiPJ9Sd493hPk20O/1
         S7DU/6+Nck6yINttNV83od5vjS13WU3Lae+Y102N5vhm5cB9Lwqwitd3Qh4qKtKu8paK
         2LztXvY/og5z75VFXvNDs/jM5uTsusbqE93QJvfPlBOa8tQXB8glNRmDtdsiARxTYmYl
         JkGg==
X-Gm-Message-State: APuU4Z8QNH6uUUis8fWWfB5yIAR4dlaisg6q2Sw/oe6asWKWwaufPI85
	hdctMN3L7PC18uvspZqwF3pz6E5sNY+PNhTxOjyrLSfCJ2zvfJyug9N50fP/tg==
X-Gm-Gg: AYBFou1f1c6DOirpJJv9SMzpTqQFlcmV3cLljdjq3kdSNbNMQ3vX2oWc54D9wlCc3c2
	b7SV1eAz4T4fcOiEuXfP020RX5GvppPxihPP5B1QEFstnR20eXipdcoOyRDMUlTlIcD2+CCZO9q
	WUDGRMGVILqpP5PI9OwI3cRbhLwEBWe8o2UNubH3D9FQnMIS2U/AkjSh+IlumdVNP77V/R3CEQT
	IA5oSVembgW36/CwVYpVODLvs85GTCzzLaQP8ZhT3d3SSUOgaebWcxjNZX7GpdgGsIenA5T3sXU
	XpSRxPLCSfe4ODHX6i6wj+8lxsm47RAIsDOb4Vhy9YtDCsiMP/5HRnwoJuvbbt2rjsLORGXXuUe
	D/BAX3BX6qhosa7MOobLqDwbXl7QMqsMOhX90lmsZV3K1LBA522PFQcudZwr0OlLVzeAoPRD5Hz
	N0/vXUyfa/MFv3aqSGrUBFEC6lD50/7msAi0YyX7ADGtaswp+2+QfMxU/v0IOvIJ0OerSl63suW
	bE+sP4c+PjgpFFdmoe8cwYlh1Yufh2vOkvW8x/dE9ZfiZncorCSMwtIbvV/XrJJM4ccUFRv8dzR
	KH3W2jsPto8j06lkLhI2/XunL9LZHCiNKb9mMdT+YB3pTmX+KS0ACR6bpvQtWQ==
X-Received: by 2002:a17:90b:1b06:b0:3ac:b44c:2d84 with SMTP id 98e67ed59e1d1-3b1b0a0e8d1mr8872219a91.13.1794770285971;
        Sun, 15 Nov 2026 11:18:05 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c6dd2dsm17977070a91.2.2026.11.15.11.18.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 11:18:04 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][RFC PATCH v2 1/2] Dockerfile: serve the application with uWSGI
Date: Sun, 15 Nov 2026 11:17:33 -0800
Message-ID: <20261115191734.23604-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115191734.23604-1-tim.orling@konsulko.com>
References: <20261115191734.23604-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 19:18:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5396
Content-Type: text/plain; charset="utf-8"

Replace gunicorn with uWSGI, keeping 4 workers and the 60 second
request timeout. uWSGI serves HTTP, as gunicorn did, so the nginx
configurations work unchanged. It also serves the static files, which
are now collected into the image, for proxies that don't serve them,
such as nginx-proxy.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Dockerfile | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Dockerfile b/Dockerfile
index f4d19ab..35c49fc 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -53,7 +53,7 @@ RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 	&& locale-gen en_US.UTF-8 \
 	&& update-locale \
     && pip3 install --ignore-installed setuptools wheel \
-    && pip3 install gunicorn \
+    && pip3 install uwsgi \
     && pip3 install -r /requirements.txt \
     && apt-get purge -y autoconf g++ make python3-dev pkg-config libjpeg-dev \
 	&& apt-get autoremove -y \
@@ -68,14 +68,19 @@ COPY docker/updatelayers.sh ${APP_DIR}/updatelayers.sh
 COPY docker/migrate.sh ${APP_DIR}/migrate.sh
 COPY docker/connectivity_check.sh ${APP_DIR}/connectivity_check.sh
 
-RUN mkdir ${APP_DIR}/workdir \
+RUN mkdir ${APP_DIR}/workdir ${APP_DIR}/static \
 	&& adduser --system --uid=500 --home /home/layers layers \
-	&& chown -R layers ${APP_DIR}/workdir
+	&& chown -R layers ${APP_DIR}/workdir ${APP_DIR}/static
 USER layers
 
+# Collect the static files for uWSGI to serve (see below)
+RUN cd ${APP_DIR}/layerindex \
+	&& SECRET_KEY=collectstatic STATIC_ROOT=${APP_DIR}/static python3 manage.py collectstatic --noinput -v0
+
 # Always copy in .gitconfig and proxy helper script (they need editing to be active)
 COPY docker/.gitconfig /home/layers/.gitconfig
 COPY docker/git-proxy ${APP_DIR}/bin/git-proxy
 
-# Start Gunicorn
-CMD ["/bin/sh", "-c", "/usr/local/bin/gunicorn wsgi:application --workers=4 --bind=:5000 --timeout=60 --log-level=debug --chdir=${APP_DIR}/layerindex"]
+# Start uWSGI, serving HTTP so that it works behind any proxy. It also serves
+# the static files, for proxies that don't (e.g. nginx-proxy).
+CMD ["/bin/sh", "-c", "exec /usr/local/bin/uwsgi --http-socket :5000 --master --workers 4 --enable-threads --harakiri 60 --die-on-term --need-app --chdir ${APP_DIR}/layerindex --module wsgi:application --static-map /static=${APP_DIR}/static"]
-- 
2.56.1

