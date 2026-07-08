Return-Path: <ross.sweng@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1091C43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 14:46:11 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10155.1783521962595804648
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 Jul 2026 07:46:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=o0m8NeQb;
 spf=pass (domain: gmail.com, ip: 209.85.161.48, mailfrom: ross.sweng@gmail.com)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6a1888969ddso411034eaf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 Jul 2026 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783521962; x=1784126762; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9SXWku/Nb3FqwTXsm0H2B3Jx8TGPb/n00WY2yeO/Noc=;
        b=o0m8NeQbGxNejSIno6p179EyqlhkhQWgw12SUFVBdj1Q0N9lS3ADGEZ0rfwxXH/2tr
         d/7Q3pSnhyZJ/fv4+w4AKtmFa5ZKK019WKDyNQdWunB/ujw2o0PZtPWtBGoMEZPggv5r
         wE8eHpa6QpCn5OpFnGNV4gMUAwHzwmj65kxN28CiHRB41HziMj45L0OtEMPlki/eDOxo
         Dw5UmA2xvtKBB+qTl6canJdj2YZsbY0OG+GUqGYQvlmTOlYIXJXYG1AZpMZoE0YQuCme
         noq4BQRhGvZLif9MA5PJuxvAO9kikI+ep5TfLbSo7OojxtROhA/0HUp9jYprSNs73/oZ
         dihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783521962; x=1784126762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9SXWku/Nb3FqwTXsm0H2B3Jx8TGPb/n00WY2yeO/Noc=;
        b=rVbW5bNLJ1VlUO4/NZEoBpcxhg4iYY0EcSuM8eIl8H9I++sO9JYEDPBoE/h9fKcz3c
         VM4c6D7RL2kwmNY9N3Vme/2iW43iT+y8N2Hvb+CoA3a+9AFbj2P8DodDZ880MdZZ9rol
         X7kZtYhbvxwTB47em+zGQ2Fe5wAq2eCKUKSijnOY7jlUxiPTZy/ER2iRZn1UJMxl4Qe1
         tJygOP6ber85cd0u8Zihg7wHOFf6DtV4D+bm6yExwqjoCd+ipUlKu+MQcavQg29Ixc6i
         ndzKWf/SuD+4bcyjo3JSldE3RZ2ASxoDFsh3ZuSxVNmdDobMt7AOziWH7tIRMpDf9zKb
         GV+w==
X-Gm-Message-State: AOJu0YxQomAlBsYS+f9ZUBswRzAmVsLVY6SJ4rPqxlDOMXUjhzW3tpxx
	RRJ8PUA7lZtCo2yl1XPX2PPI/0xiBsGbFv5K0vpjDsw2q4ecQZZwOTKwmDvjBcXQbU/bWZjA
X-Gm-Gg: AfdE7clygg5VFT1yCfCF0V2m5UY3D9vNqel29JLuabDeRo1IxDA1aAaN0dxZCH7HqtY
	0vQmHbrWXE51OeYPf/FmUCssX3PtMy+p0bDu7r+ZFUHewOLKJJPqx0QtOPUd/yq/5h6Uz88wOfA
	mJSTC+LBYpG/3wEP+gdjyKZDcrNXlx3NTAK3xVhagt5Vtt455dqx3PyjXuA7LnXOtUvaUuITzuJ
	le5aUlPk74mnpz/PIHceCyjJfR2IfxWTaJ0NL0YtGJPT2rCdtcgvyf1SbtY83JvAStITGM/2LkD
	hOvihB51fI/lXXAmcaEW+2QNBpqIkuE1m/l6YGFVp9kYI67UpP1UsHILlDBS92i7YHFKrMG++Pf
	tsl6NU/wE10+VkknpeFS4U7kTiZLiCSsqyuOXKB5VsgT2g1/QpyrNhzVTAbxFJiZlHyrDpaG63t
	fon8NytPuAsn+VpiPfkgHelKJU8+FsgbY=
X-Received: by 2002:a05:6820:4dc6:b0:6a1:7895:658f with SMTP id 006d021491bc7-6a36da61045mr2064660eaf.41.1783521961612;
        Wed, 08 Jul 2026 07:46:01 -0700 (PDT)
Received: from OLA-9X4GN34.ad.garmin.com ([185.153.204.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a83ecc4sm1894940eaf.11.2026.07.08.07.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:46:00 -0700 (PDT)
From: Ross Stutterheim <ross.sweng@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com,
	Ross Stutterheim <ross.sweng@gmail.com>
Subject: [meta-mingw] [PATCH] toolchain-scripts-mingw32: add /usr/share/pkgconfig
Date: Wed,  8 Jul 2026 09:45:51 -0500
Message-ID: <20260708144551.2741360-1-ross.sweng@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 Jul 2026 14:46:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4454

poky commit e0bcf333df8bccbc7aca39048423d97247454c5e added
/usr/share/pkgconfig to PKG_CONFIG_PATH back in 2016. Add here so SDKs
generated for windows can find the same packages as SDKs for linux
when using pkg-config after sourcing the environment-setup script.

Signed-off-by: Ross Stutterheim <ross.sweng@gmail.com>
---
 classes/toolchain-scripts-mingw32.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/toolchain-scripts-mingw32.bbclass b/classes/toolchain-scripts-mingw32.bbclass
index 8cb426a..ee53bf8 100644
--- a/classes/toolchain-scripts-mingw32.bbclass
+++ b/classes/toolchain-scripts-mingw32.bbclass
@@ -25,7 +25,7 @@ toolchain_create_sdk_env_script:sdkmingw32 () {
 	done
 	echo "set PATH=$sdkpathnative$bindir;$sdkpathnative$bindir/../${HOST_SYS}/bin;$sdkpathnative$bindir/${TARGET_SYS}"$EXTRAPATH';%PATH%' >> $script
 	echo 'set PKG_CONFIG_SYSROOT_DIR=%SDKTARGETSYSROOT%' >> $script
-	echo 'set PKG_CONFIG_PATH=%SDKTARGETSYSROOT%'"$libdir"'/pkgconfig' >> $script
+	echo 'set PKG_CONFIG_PATH=%SDKTARGETSYSROOT%'"$libdir"'/pkgconfig;%SDKTARGETSYSROOT%'"$prefix"'/share/pkgconfig' >> $script
 	echo 'set CONFIG_SITE=%SDKROOT%/site-config-'"${multimach_target_sys}" >> $script
 	echo "set OECORE_NATIVE_SYSROOT=$sdkpathnative" >> $script
 	echo 'set OECORE_TARGET_SYSROOT=%SDKTARGETSYSROOT%' >> $script
-- 
2.54.0


