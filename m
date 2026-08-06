Return-Path: <ross.sweng@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE095C56208
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 13:22:07 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19169.1786022511719142620
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Aug 2026 06:21:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YrktDP5A;
 spf=pass (domain: gmail.com, ip: 209.85.160.49, mailfrom: ross.sweng@gmail.com)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4566a5bc186so866924fac.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Aug 2026 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786022511; x=1786627311; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KJCeISmb53vb+qTKkaVwTBoBxKonznB+iz9ry4FZZEQ=;
        b=YrktDP5AR1PweBdXNLfCQfLWM3j1/+tLpeSk+qXhP3vR6oiC0bR0W8KYYRMHwcAYWB
         o9M5iwoC6yXntMFUKBrOPq9hycrY03CfPRN0BAeqTT4/HfUWVA6SW24MNGnu/wAqpNy9
         m9KUr57GVfonXgIX1v2kE32DBDTXShuYY5h6q0FHtbQiaJr7tIjwax4xuLxFjAxX86jT
         o9BpzSDMTRypxwdIgAdSmWqQCjjX5uUGRqxeHb1iohoeS5vsMIHcCF+gORRmVeNfVFLW
         Q3YZxp5UiQfaIPqgZ8zPr/bcH1qQweApxKG/q5kSaPhN1sERuBbA7mApCIjfAZJxwCf7
         MYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786022511; x=1786627311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KJCeISmb53vb+qTKkaVwTBoBxKonznB+iz9ry4FZZEQ=;
        b=MF97obJM8LvWkkdo97l5zgP3aWuoqXbTiZc1MDPyWvb4IXd2VFvxXrr6eCpun9l9kX
         swUgKXR0WHHeM5twDkNmZzgJUupLa43XXb57SHxhR13Mcl15dXnFOmkyIR0ysQw1uSJW
         KnNbBMwCvcTA4+Bs/3mpDfL2e0TyX2XWIFaSc28oAN4PmNyVLxGOMjVMx22aRAlsS6so
         xRRvSUQoDS2uELOrLe3GE1vhqXYj0tIriRAgAFi69L0MnvJ4H5b0ttNzaYl/xF9GL3MX
         4LnOvLNUJ3Cn/4Q4mv5vSyCORrFN4S3fm1dyVlPm/C9/rAhTuK4sq/4qZpbMt2ozP0xL
         ctoQ==
X-Gm-Message-State: AOJu0Yw5QR8pvhg+x4O/LBO30VVNOYU5yBUezEC2v49B+6pLIrOQ6B/J
	TXoM6VM0Cj28HLgvWddE/t7Zs+Mq3PTQKyH1Vo8vzPL7ExGRR77Oai8pJODTCflK
X-Gm-Gg: AR+sD10x022AlJ8BeQu3kkvFiU1dYAJ6TbfZDoKZH9wrpHepu3mXcSghty0oPghyGgd
	KsMzM5XhihgQSiNI+AiNyZuSXpxrSdwZlMB/ufOecN1kFMQMNpHw8Jt6c0iUqluMXFroVAOrAwJ
	uGAVJVqS9enqbM8g2r8t94mprfbnb8s01wFozRDQIvwPMKV5pIRl6nsPO7ge5nTWEitcRnBZaX8
	/73AeuJhcUA0KVdKvFRepQgm+Waj67V8PiipAg44yRZZFdeFyuMfMyUz/2oQG0XAG110UgyiqeG
	x9SqNE6dsMasSBJoYI0/4WzaZSGnMrUgyTz40tlwePMb4WO+f7xnlJst3bP3NHjr0f+ByuX7rYS
	cPqcY6OmeX6hlPZUcf7foPnBnRyP4RD9SnOS270gfpK1YO31dz2EbQY2xn6omeQksFSsgnXgAOM
	myz+CRvPjj13znbhD5Xz9h5b3QSzGI+iiVkvLGBdVs38Yr9WKvbCHepncgR3daQJQ6bDmNQUqVH
	xN3EuU=
X-Received: by 2002:a05:6870:2e8f:b0:456:b6b3:605b with SMTP id 586e51a60fabf-459e30f6d1amr980972fac.16.1786022510902;
        Thu, 06 Aug 2026 06:21:50 -0700 (PDT)
Received: from OLA-9X4GN34.ad.garmin.com ([185.153.204.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4599e5b460dsm5449642fac.11.2026.08.06.06.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:21:50 -0700 (PDT)
From: Ross Stutterheim <ross.sweng@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Ross Stutterheim <ross.sweng@gmail.com>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [meta-mingw][scarthgap][PATCH] toolchain-scripts-mingw32: add /usr/share/pkgconfig
Date: Thu,  6 Aug 2026 08:21:43 -0500
Message-ID: <20260806132143.3727894-1-ross.sweng@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Aug 2026 13:22:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4642

OE core commit 1bea760f3f462fdcc3eefc0d8597688d61447ddd added
/usr/share/pkgconfig to PKG_CONFIG_PATH back in 2016. Add here so SDKs
generated for windows can find the same packages as SDKs for linux
when using pkg-config after sourcing the environment-setup script.

Signed-off-by: Ross Stutterheim <ross.sweng@gmail.com>
Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
(cherry picked from commit f27dbe7597d1d116f750f5588772253c542df112)
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


