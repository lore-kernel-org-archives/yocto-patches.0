Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5165.1793048901138804949
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Oct 2026 14:08:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ktsBiifa;
 spf=pass (domain: gmail.com, ip: 209.85.210.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso1098270b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Oct 2026 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793048900; x=1793653700; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A2JeYcwOR+ZDIyub8L1TxRN9psvTQcHpQFe9FpHLqF4=;
        b=ktsBiifaIbsU6v8bMPMMy5E5LGp8NmIVEE3+hIZgdpVaJUQdA0oYUO0+knImhZkmKm
         QBwoAkyzfCK5ogBvBoiZuTYM3EJ2iaREFGmFQ8I2tYtsnL41JwvE8iQVJOqUIboNi3iL
         C3mdWI80vkrG06uLusf8IJnadHNXdK/4Wa1Yzgna2wuAfIGtOJdnwgyxOjhecC7jjABy
         4Gy7uitxFyeyinuQJRRDlNtZagl/8JPFM7djXz10veVdTDccQzAs7T+ANuIAD5j2XMHK
         2WpIPcMHLBEcm4TxNu974mqAzCofXDtXZIWUiRw5minlCrxMF72pe3oHDgP825t3rpMa
         sN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048900; x=1793653700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A2JeYcwOR+ZDIyub8L1TxRN9psvTQcHpQFe9FpHLqF4=;
        b=d9hf0pb5Tu/UD5o94u7pgKDGAadERoKjjT51UDrN8r9kD5Sho9NckOMcj96ur6Ldvu
         Tnm/tCW3zQw4XWj7cKXVN7fppwXgLX/cK4swNzr9SvK0yu8cQRFW6sg/KYiSDm71DDEm
         naCtnaoZrp639NO6l6Vqw9c/x6CkO0Vt3FpWYsaLvdfFxJQ3q1WAkOMbQmxMwrR/fGpQ
         6rp5sslVZRZvfMrUZU6rUdGKh4PRSCJ9m5GY6nxvQUKbDxx4Z9WD4ioePiRnJIxp78h1
         TPE/px6PAio8LdTTdeH5LZ/ar9ldOnCmJWjFjF9Tnm5SXlVq7e+SNYfdiUOZ0waZ7Ky9
         boBQ==
X-Gm-Message-State: AFq9FYKmTLrkG4FHVatJSfyLBm3wDfXJQ5KgwhR0VwjC8LI+6KJS8iiD
	cwiZfGqZX2v0Bz0rNZtathZqXcx1zUcyM8ZvepXOgTrRsidlMCs2/N8bV5jw76mb
X-Gm-Gg: AYBFou1M/ObecKiQcwie/x5rmdH14WIcXhBvEM7s/DW6+sDs78DAEVHQQ8TGPqrNUyR
	xAXbSY5pIgYWpyMFrxxAqOMPHbUd8zrknIyVOU5iXBL97rUmNb+n0Lc8r9Pw8WMIyR2VpA7NYK4
	MWWs/LYV7ZFAUeivz6nujEjLDosSaGRNT0mW5klgTJylrGfTV4cwzE8b57wuizGgz2fQjQas6Sl
	mUeYf/WRw6C9gzB9nY/E7mUTc+crrgLvf40y6Ssjp//rpnbq91pGeg8F2iDUVT2YUYwaOWPb2Cz
	VaaSCp4U6/cOUby/3Pp6dYMa238hHDnX80gi6HygFeBzfYtXvcktydvFGqLp1UXE3Dey7s9/ciJ
	P7rOyDx6luPD8UkpYX+vf+8yCxa6n1DdiaQ1xkAKiRikZFtzAAtWgLu+pP2/mgpJBPG37jzrgAj
	7TBgQa3M+gm2JyOdLBsY+Vq6WrcyKcsk/BXmUlxQN98gajvHNn1Op5wTV4s0S8BO4n1DlWXe8QL
	L6PVvq90ashJezYyUOSVu3P+MH1HJga/HNiEdC6cJLYQQeQFnKa49lb3ONo2RvwS3jkfcyITPHM
	JQJtoNiIf4j3
X-Received: by 2002:a05:6a00:4005:b0:8a0:2914:5d27 with SMTP id d2e1a72fcca58-8a369168952mr6152189b3a.44.1793048900358;
        Mon, 26 Oct 2026 14:08:20 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36acadefesm1774026b3a.19.2026.10.26.14.08.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 14:08:19 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] Dockerfile: install current setuptools and wheel
Date: Mon, 26 Oct 2026 14:08:12 -0700
Message-ID: <20261026210812.96436-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Oct 2026 21:08:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5160
Content-Type: text/plain; charset="utf-8"

Since the move to noble the image has Debian's setuptools 68.1.2 and
wheel 0.42.0, which Safety reports as vulnerable (CVE-2026-59890,
CVE-2026-24049 and others). pip can't upgrade them in place ("RECORD
file not found"), so install current releases with --ignore-installed;
they go to /usr/local, which takes precedence.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Dockerfile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Dockerfile b/Dockerfile
index ee59e77..f4d19ab 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -18,6 +18,9 @@ ENV PYTHONUNBUFFERED=1 \
 
 # NOTE: we don't purge gcc below as we have some places in the OE metadata that look for it
 
+# Debian's setuptools and wheel can't be upgraded by pip in place, so install
+# current releases alongside them in /usr/local, which takes precedence
+
 COPY requirements.txt /
 RUN DEBIAN_FRONTEND=noninteractive apt-get update \
     && apt-get install -y locales \
@@ -49,6 +52,7 @@ RUN DEBIAN_FRONTEND=noninteractive apt-get update \
     && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 	&& locale-gen en_US.UTF-8 \
 	&& update-locale \
+    && pip3 install --ignore-installed setuptools wheel \
     && pip3 install gunicorn \
     && pip3 install -r /requirements.txt \
     && apt-get purge -y autoconf g++ make python3-dev pkg-config libjpeg-dev \
-- 
2.56.0

