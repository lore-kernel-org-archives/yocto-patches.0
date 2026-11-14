Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3147.1794617415218030375
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 16:50:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=g7+ivn4V;
 spf=pass (domain: gmail.com, ip: 209.85.215.175, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdb684859cbso1514939a12.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 16:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794617414; x=1795222214; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+zDmxDmgyXnRdWDXt+Niu1OrCYv5h8RAnzPjJRBA1I=;
        b=g7+ivn4V9g21y0MWy7ZXb+zXf3fXggTNrI0/wo0tAxYmlVzUyenN41H/JPYbSg7n13
         U10PA+lSJxuCKrZ6TgynaoCB2voI9Z+U2PjcQd+o+yY7b7aYUvLObovrLNbyM+ip7TrB
         YznGi62lHcd3wCuQ3BJw2/PLBCUPVrze5INGrdabpGXw0ZMofqerWS7gJDbyihtOcMS6
         uVVPIrOecX2uOg1nATDvuHuGKOtwbYs1QunortuNFmWMtE0w179LEpQrN2wzQ3Eqnnpn
         q9h/gI590XI52uE7j741nrBJpDaMbKQlCV7V9fwc5Dfn+AO/9a8yVQ2pZzK9+/LKKSiZ
         mk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794617414; x=1795222214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+zDmxDmgyXnRdWDXt+Niu1OrCYv5h8RAnzPjJRBA1I=;
        b=B1EuE/x/RMwjZvu8e3ela/b7PocSdJAecHBsdCJHanXCDL/uQCCeK1w29gCZBleOeq
         Dgq1k2+150Vj2Xo1VFiHUHDHs66Y7BMg5W6Jpm3P+qE+lPUP3MfFH03Id8xeUeUItcxk
         R+HmgMGofp7dDh/44DIczo4VoZ3ViA+gmIMfC9O/prgvjmHaWVHZCyDe10ID/SPLs1Qs
         uy5OBL6wl+AzGi8U8cq1ChO7ejq/gFvOOHCbetpCeXhN/W2evG8Cd7NRM9nXlAe54u71
         ykzkveh4OcG2GPWb+a+Kkz6UhXLmZWO1FK/66RRR818nNw+xxNkp0V+01FTKjgcbmknc
         1ktQ==
X-Gm-Message-State: APuU4Z+Z3qVxDQPVvtaVW7Hqd5CaN0p8fZO5CeHRdZfJDj1HBv471fBN
	ZX32iYTZ0mKW8JSl60ondVFDU4He6h+f7pse4woe6GU9GtZQKuqmfXpU6wARSgZF
X-Gm-Gg: AYBFou0h/xW5n2Dy3cEEZXkUbvet/4gvKsrVIgx2a90XZwoBkORdZ0UfiHLAw5ZtqOu
	usLqueTtmaReF8idwZw0LMWCMBuIkwrQjS+HQw+sHT//weNp4WK6n0LjPZTdA9QegFMTMKznzb+
	t4b2Fa9+ulmbQP9S9lwotDqGa93gSVXaICcl+H+5yFHCdXQ301SgBxLDCYYJqR8j+qbVRpnslHy
	E1vQSwjK/OI6Swcz1djZDeerokU1BZyAuc6QWTEzG48CSfc5YdiQClM9acDQzCXNclbn9zMo2WW
	WYja2/dVYx9vzEHurrBCGJAkHu7y2MB+3uSsg25Q6L8qVdkE/QWnuMJ0ZPQ6x3SuFmN8WK2eZAK
	T80u/hz4k4Kw29eE7BLt5ad5dZ7UygFiSEv4oIxfZ6WtvFkD4PnLNX9dituj9RO8NyiuT5DWcU8
	rVRcXgsv2Egp5IR8WdWcIz6oC8aUuAVMUJv1OMRsNVIg50xVhVsLIdQUwIDw9Qfo4LwR2VZDWk6
	QjJpMBfaSOAzFtnatzr5MASEbE676DZVeeLbUPl6wO0s37ia8jBMERObCbETNiNgmg1fn94VV/9
	Ey2GxSyNVSnKq1jcWSPcnA0fDaW/I+57nGtWjQI+u1Hfm95Cwe7mzraZrr//hw==
X-Received: by 2002:a17:90b:2ec3:b0:3b0:9781:ee8b with SMTP id 98e67ed59e1d1-3b1b09fcbc5mr4079041a91.26.1794617414358;
        Fri, 13 Nov 2026 16:50:14 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce55c1sm11790295a91.3.2026.11.13.16.50.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 16:50:13 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: mhalstead@linuxfoundation.org,
	Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][RFC PATCH 1/2] Dockerfile: serve the application with uWSGI
Date: Fri, 13 Nov 2026 16:50:05 -0800
Message-ID: <20261114005006.28193-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114005006.28193-1-tim.orling@konsulko.com>
References: <20261114005006.28193-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 00:50:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5351
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
2.56.0

