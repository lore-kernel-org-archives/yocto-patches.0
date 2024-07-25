Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0526EC52CD9
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:26 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web11.32097.1721898139591064731
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=TabzY5tS;
 spf=pass (domain: linaro.org, ip: 209.85.167.43, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efc89dbedso680288e87.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898138; x=1722502938; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZHTQo/km/a/80u7HzdBBIQQ3ZfG5ZV8wQbgMYn50iQ=;
        b=TabzY5tSz7naPb5AuwRaXrwAIbPPwABeppxLLK19zJDA5kC1Cb6k618+xVwMUtwxJC
         YiPaAXbm9aTkrs+0L/yWZ/ueIRhHdMLq7XBN3laNkxL/M2B520Y4uvEWtXG2NprHUfR6
         fD7XSYb7ZCFU5mGrnjrFZPdRrZx+2xIFWaxHEpaV63yfSUlM9+tHEam12DjlSf5h9h7m
         sGL6ibsLoXXH51yR+PVo/BBw4dLljyJ8v+92WrV8tAfPfGiCQ+oN+YgGZGnvqXJn0gss
         QNDL5zZ/1Ar/GJPylIOFLv5gzbvoX4MiyU3pYZRjaQvLDsaBjN68FewTsaqFpHzb9jFD
         2KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898138; x=1722502938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZHTQo/km/a/80u7HzdBBIQQ3ZfG5ZV8wQbgMYn50iQ=;
        b=soIVXemVQqjrrlEMte6v404NfRYGW6oyPzuOEOp/unK28Yy8WEggc5wGHA2NrKUR7l
         60SwNuCHt7ZDGrOIEAKPLyYuRPk0Og/FeoqLHXT2WTVxvus7bQwGmg9LdfkdRIW0BMKs
         rTyJcHdZ5jdA9RVV1P3GwrCDEC9yvmsBEnOFb1kzgVYoQvP5iuSdL2+zjhCecIqFBEW8
         wl2plh2pzjjxXlaxn1Fok1bm1tZTQpxWStzIsb9Kkzf0Xlqi0mpEy1gExzi4wwZEQzlO
         jBHlgoCg8wh0nT6/cvGS4DQy2OUQIrR2vMVYU/9WHzzNYLQNUiBuYt7ooeIj2VU0VsC/
         nefg==
X-Gm-Message-State: AOJu0YygLtS+QMbsdKjOYTuSKPlFZUxR3F5MTg51V72xKr1lBTKoBO5I
	j5HONPIy+dEj4bTpiGaUNp2P7x25jQKF0oRiL2ZPu1gs4zlYn9HUJ6hqn7ISVtG7aZdrSUA7sm9
	Z
X-Google-Smtp-Source: AGHT+IGS6LX3IS/SvGgVqZAWVlesKKO2SdGhTyS+KRFKfi9CVq4Xejq81WdcnJ0iYEZm3roj4eZttQ==
X-Received: by 2002:ac2:4c4b:0:b0:52c:c5c4:43d4 with SMTP id 2adb3069b0e04-52fd60fafcbmr1046478e87.53.1721898137848;
        Thu, 25 Jul 2024 02:02:17 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:17 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 12/17] clamav: UNPACKDIR fixes
Date: Thu, 25 Jul 2024 12:01:26 +0300
Message-ID: <20240725090131.75860-12-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/469

New poky uses UNPACKDIR instead of WORKDIR

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 recipes-scanners/clamav/clamav_0.104.4.bb | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-scanners/clamav/clamav_0.104.4.bb b/recipes-scanners/clamav/clamav_0.104.4.bb
index 102f267..ad9e124 100644
--- a/recipes-scanners/clamav/clamav_0.104.4.bb
+++ b/recipes-scanners/clamav/clamav_0.104.4.bb
@@ -58,9 +58,9 @@ do_install:append () {
     install -d -o ${PN} -g ${CLAMAV_GID} ${D}/${localstatedir}/lib/clamav
     install -d ${D}${sysconfdir}/clamav ${D}${sysconfdir}/default/volatiles
 
-    install -m 644 ${WORKDIR}/clamd.conf ${D}/${prefix}/${sysconfdir}
-    install -m 644 ${WORKDIR}/freshclam.conf ${D}/${prefix}/${sysconfdir}
-    install -m 0644 ${WORKDIR}/volatiles.03_clamav  ${D}${sysconfdir}/default/volatiles/03_clamav
+    install -m 644 ${UNPACKDIR}/clamd.conf ${D}/${prefix}/${sysconfdir}
+    install -m 644 ${UNPACKDIR}/freshclam.conf ${D}/${prefix}/${sysconfdir}
+    install -m 0644 ${UNPACKDIR}/volatiles.03_clamav  ${D}${sysconfdir}/default/volatiles/03_clamav
     sed -i -e 's#${STAGING_DIR_HOST}##g' ${D}${libdir}/pkgconfig/libclamav.pc
     rm ${D}/${libdir}/libclamav.so
     if [ "${INSTALL_CLAMAV_CVD}" = "1" ]; then
@@ -71,7 +71,7 @@ do_install:append () {
 
     if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)};then
         install -d ${D}${sysconfdir}/tmpfiles.d
-        install -m 0644 ${WORKDIR}/tmpfiles.clamav ${D}${sysconfdir}/tmpfiles.d/clamav.conf
+        install -m 0644 ${UNPACKDIR}/tmpfiles.clamav ${D}${sysconfdir}/tmpfiles.d/clamav.conf
     fi
     oe_multilib_header clamav-types.h
 }
-- 
2.34.1


