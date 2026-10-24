Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14292.1792880806360861663
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 24 Oct 2026 15:26:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VJhPQTe2;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1148696a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 24 Oct 2026 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792880806; x=1793485606; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vgRp4CqeaWbU/cr59ZzZbJWim3nJtjRuAt8f1nyvA9c=;
        b=VJhPQTe22f7QWQiKcHVDUGTkTjQMhQ0iHvvN7Tn6c3zLjSCF/erTxAdZdG6JCk/CK5
         Wz/n8L1aXucNpyTcOyoopNaDHsBWtet9SH6YpYhnz7oqOSb/Lto4pbsPYDQhudt3uLsm
         yQoFBRR5i6TABr+X23iggqZ8J0r1/ATBx8foHw5gARsG7BnrtHk5Q/ojEbYoVl7IxT5Z
         zLyEfMYiqlPYJk+glB0+3s4Pn+kdp1rGMO4oSdyRSWqLZed2sHBIamJr839DcxUV+qY0
         qlaxQRLGwSNREmKDYm844vbB6kPtpcfSy2EY8CbxWwIQawZ9yg/hbwGnBnfeP5MiyO0X
         AaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792880806; x=1793485606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vgRp4CqeaWbU/cr59ZzZbJWim3nJtjRuAt8f1nyvA9c=;
        b=Hwq2y0tHkYe8UNgBx/oWpMMnaOXG7KicRCum8TrK/rat9Gbn0gMbl3GuYGcvQygH/2
         mN0UwLrdd31vzglcTYZHHZDD9EirisNCADq97WG3BBix8lijhRcce9X21k2QgiN3FSC3
         8xWv8aCZkOLg+Y0a+iUxHNb4P7ErltWwFoTcZjTpL6AUUsFsLQ5paKUDKNZXjGLSihuy
         kQkD5tGjQdyGvRzvW40az6iwXmGntak66Bt1OUK737P70J49UDjUczzduPyq9KOCFK4f
         PvUpLTDLrxtSZTvXTJWg+pAwI2FNIGkvEPWie7ApkAGPgI5QrCDyuTKh1NrZ0Kc9b+xL
         K8Yg==
X-Gm-Message-State: AFq9FYKpQgWS3pOG7cyxRn4/aXqFIbmq1VigbwhlUPxjPpboWDNVSerY
	XAPAnNnlGdsJ+1AmxVR3L/RIcbAnlpGhfBEs7qKb3f6O49dwzK9pr64SSjDIYqNU
X-Gm-Gg: AYBFou1OkyUjhm9dJt4dKdvscb96nHmGOR2z95MqymlEdaZztTHQlrSgP32rFJGAV4P
	uCCNuaQWXSvncxQe0E9qAJzUizqphiKqTC8mGuLvDV0k1ygrTBSXnf+FoXdDE7e496EzmKok/y4
	ZnKUigco/A8Ixf1rfk2magViq6O4iin5awMsbGYAtGRxrk2/65pWB6u92hkH1OkIoNh1+OOR71G
	FuvfPycA34puZEwXDkIRwOVwP8wNTZXWYSRJrRRH71uYMYXsHO/o5jjN6KIY5OgZLICwb5MzvYP
	ZcF9ap7YzwUSUn7utkk12DtrT0sAOw+ACSC1wRyQM5BWdD6ArlJn74mGzenNpm61+PlVyGRLeyk
	C7wNBtF9LLJfPfxSeDbNkjs9dBKUIQqCx94PJ23g5b9WOm0XmIdGWs7kq/J3Qm8akP4XwIaM5nc
	VydK//IrVBSShITcb1A23aw3H4vQrJQkGVfNF1G5FlsPZqPgz0gvhIe/rElQq/cY0wul59+21yO
	s9kBTm8w5yiQzkS1eXZQ/7Gm+oNZjsNChQtYUibh6oP8g59l06oPybfHKJZys8guN81MgXEHv0/
	VejbNEXTLFKmI3OGxTeQHq3L8aHnuy2sxw==
X-Received: by 2002:a17:90b:534b:b0:3aa:fc22:8aac with SMTP id 98e67ed59e1d1-3adeae5dcdbmr2801298a91.51.1792880805643;
        Sat, 24 Oct 2026 15:26:45 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe9078asm3725209a91.10.2026.10.24.15.26.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 15:26:44 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/3] Dockerfile: move to Ubuntu noble (24.04)
Date: Sat, 24 Oct 2026 15:26:32 -0700
Message-ID: <20261024222633.84011-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024222633.84011-1-tim.orling@konsulko.com>
References: <20261024222633.84011-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 24 Oct 2026 22:26:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5147
Content-Type: text/plain; charset="utf-8"

Ubuntu jammy's Python 3.10 is too old for current releases of some
dependencies, e.g. Pillow 13 needs Python 3.11 or later; noble has
Python 3.12.

Noble has no python2, so drop it; it was only needed for OE-Classic and
branches up to krogoth, none of which have updates enabled. Allow pip to
install into the system Python (PEP 668), skip upgrading the
distribution's own pip and setuptools, install adduser, which the noble
base image lacks, and keep /home/layers as the layers user's home,
which noble's adduser --system no longer creates by default.

Python 3.12 removed asyncore, which the pyinotify bundled with BitBake
for dunfell and hardknott imports; add the pyasyncore backport.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Dockerfile       | 9 ++++-----
 requirements.txt | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Dockerfile b/Dockerfile
index 4ba040e..ee59e77 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -1,11 +1,12 @@
 # See README.md for how to use this.
 
-FROM ubuntu:jammy
+FROM ubuntu:noble
 LABEL maintainer="Michael Halstead <mhalstead@linuxfoundation.org>"
 
 ARG APP_DIR=/opt
 ENV APP_DIR=${APP_DIR}
 ENV PYTHONUNBUFFERED=1 \
+    PIP_BREAK_SYSTEM_PACKAGES=1 \
     LANGUAGE=en_US \
     LANG=en_US.UTF-8 \
     LC_ALL=en_US.UTF-8 \
@@ -24,6 +25,7 @@ RUN DEBIAN_FRONTEND=noninteractive apt-get update \
         && locale-gen en_US.UTF-8 \
         && update-locale \
     && apt-get install -y --no-install-recommends \
+	adduser \
 	autoconf \
 	cpio \
 	curl \
@@ -36,7 +38,6 @@ RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 	make \
 	netcat-openbsd \
 	pkg-config \
-	python2 \
 	python3-dev \
 	python3-pip \
 	python3-wheel \
@@ -48,8 +49,6 @@ RUN DEBIAN_FRONTEND=noninteractive apt-get update \
     && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 	&& locale-gen en_US.UTF-8 \
 	&& update-locale \
-    && pip3 install pip --upgrade \
-    && pip3 install setuptools --upgrade \
     && pip3 install gunicorn \
     && pip3 install -r /requirements.txt \
     && apt-get purge -y autoconf g++ make python3-dev pkg-config libjpeg-dev \
@@ -66,7 +65,7 @@ COPY docker/migrate.sh ${APP_DIR}/migrate.sh
 COPY docker/connectivity_check.sh ${APP_DIR}/connectivity_check.sh
 
 RUN mkdir ${APP_DIR}/workdir \
-	&& adduser --system --uid=500 layers \
+	&& adduser --system --uid=500 --home /home/layers layers \
 	&& chown -R layers ${APP_DIR}/workdir
 USER layers
 
diff --git a/requirements.txt b/requirements.txt
index a0d32c2..3da41f9 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -28,6 +28,7 @@ mysqlclient==2.2.8
 packaging_legacy==23.0.post0
 Pillow==12.3.0
 prompt-toolkit==3.0.53
+pyasyncore==1.0.5
 python-dateutil==2.9.0.post0
 pytz==2026.3.post1
 six==1.17.0
-- 
2.56.0

