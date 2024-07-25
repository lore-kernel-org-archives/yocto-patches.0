Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2371C49EA1
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:15 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web10.32011.1721898133420476185
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=eDXN4kYB;
 spf=pass (domain: linaro.org, ip: 209.85.167.46, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so900669e87.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898131; x=1722502931; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zz+lIpp/JsPl5UFda8y7mFcOJiDS73uEfzOlppeLUhw=;
        b=eDXN4kYBSyEY2FDtKV/SpY1JWjW6l0p7Cugc1+mWmiD7mT/qE7aCQ9YFi8aShWL5Gn
         e5CSSMJKNyegrRmIdEU6eZWRNzeVH+y6hZTQa4TPuML4XKGdb3UcaFIyZ45zNs+chJCF
         rbwLKnB4AMAh7D0rOBgEOoqifM6XrEQNz69/sfzKF1p7tsjRNaL0vHvATL36+cFt9v8k
         0h7y3Ta6184zjg6Nvjxrs4824Tld2CmXZF1vlDdGRaJEr8Zts+RtYZqQd2GC+epztqVG
         pAO0iCDIsA/bHCHXDrlEciYK2K3wxBjGeT58M3XGnC2wDEqod5+456WGM0toQ+pedIYt
         Ahqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898131; x=1722502931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zz+lIpp/JsPl5UFda8y7mFcOJiDS73uEfzOlppeLUhw=;
        b=GQslKO3H1Rqy4eqgqA4Lc4b+HAyMQJPlQ+umc/U/FwNgyQXcoCkCcz07Z6zdFvVHiv
         3xQ3Isfefr5zhU1HNNTotS/A/u5NEy4lvsj3cxov52mAFdMQKks+n4MkpQe4YQjkbVVk
         xNrJwtAyXKpgj/ginsQawv6/NusP9TBoLA8wBl41i5vcXmA4L51+QxMYtz3Sgp83aECJ
         D7sDD3e/5TOQZF754nI2oezzpEG8EcgVAMwg1dQ4gUJ/3/W14k0jxHvtlh+GyrEazN00
         Ta7ZJMrDmfViOb2PwhgxIxbwJ7PQTqOxtxcd14Z6dW54PKF8u45SSHT5Zl+6tRmdoZ9O
         l21Q==
X-Gm-Message-State: AOJu0YzPYwbcDqoBtV5ZFQuBdozinuZ98mWZdYKqaYAiB0DIOLd/PWKU
	v4ZreR9pdDx/Tex0/ftf0GlUyKefyzwqz0i2slKVgW60YetVFQT7qrK1IT5bR0uFFkb8xy821uH
	p
X-Google-Smtp-Source: AGHT+IGAeeZK5xPSxtOMweeIY9A6t3IH5eWeGN6ZP8qHacEku2O6zd+FwJzGE/i5HnQ6v+bQwgc8FQ==
X-Received: by 2002:a05:6512:31d4:b0:52f:159:2dc5 with SMTP id 2adb3069b0e04-52fd60f5052mr1106814e87.42.1721898131588;
        Thu, 25 Jul 2024 02:02:11 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:11 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 08/17] trousers: UNPACKDIR fixes
Date: Thu, 25 Jul 2024 12:01:22 +0300
Message-ID: <20240725090131.75860-8-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/465

New poky uses UNPACKDIR instead of WORKDIR. Combine
with whitespace fixes.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../recipes-tpm1/trousers/trousers_git.bb     | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/meta-tpm/recipes-tpm1/trousers/trousers_git.bb b/meta-tpm/recipes-tpm1/trousers/trousers_git.bb
index 192c66c..0940f76 100644
--- a/meta-tpm/recipes-tpm1/trousers/trousers_git.bb
+++ b/meta-tpm/recipes-tpm1/trousers/trousers_git.bb
@@ -10,13 +10,13 @@ SRCREV = "94144b0a1dcef6e31845d6c319e9bd7357208eb9"
 PV = "0.3.15+git${SRCPV}"
 
 SRC_URI = " \
-	git://git.code.sf.net/p/trousers/trousers;branch=master \
-    	file://trousers.init.sh \
-    	file://trousers-udev.rules \
-    	file://tcsd.service \
-        file://get-user-ps-path-use-POSIX-getpwent-instead-of-getpwe.patch \
-        file://0001-build-don-t-override-localstatedir-mandir-sysconfdir.patch \
-    	"
+    git://git.code.sf.net/p/trousers/trousers;branch=master \
+    file://trousers.init.sh \
+    file://trousers-udev.rules \
+    file://tcsd.service \
+    file://get-user-ps-path-use-POSIX-getpwent-instead-of-getpwe.patch \
+    file://0001-build-don-t-override-localstatedir-mandir-sysconfdir.patch \
+"
 
 S = "${WORKDIR}/git"
 
@@ -32,15 +32,15 @@ do_install () {
 
 do_install:append() {
     install -d ${D}${sysconfdir}/init.d
-    install -m 0755 ${WORKDIR}/trousers.init.sh ${D}${sysconfdir}/init.d/trousers
+    install -m 0755 ${UNPACKDIR}/trousers.init.sh ${D}${sysconfdir}/init.d/trousers
     install -d ${D}${sysconfdir}/udev/rules.d
-    install -m 0644 ${WORKDIR}/trousers-udev.rules ${D}${sysconfdir}/udev/rules.d/45-trousers.rules
+    install -m 0644 ${UNPACKDIR}/trousers-udev.rules ${D}${sysconfdir}/udev/rules.d/45-trousers.rules
 
     if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
         install -d ${D}${systemd_unitdir}/system
-        install -m 0644 ${WORKDIR}/tcsd.service ${D}${systemd_unitdir}/system/
+        install -m 0644 ${UNPACKDIR}/tcsd.service ${D}${systemd_unitdir}/system/
         sed -i -e 's#@SBINDIR@#${sbindir}#g' ${D}${systemd_unitdir}/system/tcsd.service
-    fi        
+    fi
 }
 
 CONFFILES:${PN} += "${sysconfig}/tcsd.conf"
-- 
2.34.1


