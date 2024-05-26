Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D963C25B78
	for <webhook@archiver.kernel.org>; Sun, 26 May 2024 01:02:19 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web10.9205.1716685337085761476
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 25 May 2024 18:02:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eMn6D/VX;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43fc100549cso2654141cf.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 25 May 2024 18:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716685335; x=1717290135; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeLDGmDf1/7tTfYiJxh+Tr0l3nCr7JuqJ8jhahq1kPY=;
        b=eMn6D/VXvJL7mafcOwLojdaFTF/GM5D7o0DKcT5cTTLhrkNI6nc8M2QvworgkaSoyO
         JuZ8pAOikkxt+1d5TknXlOn+a2qnok4JKqY5HTHNUwRurVctkQM2zkqi6MBFJjnHYsm9
         WbjhnQXPS5MoX+s6W21tHfNpJWwPgs/Z46/IjhPfCz+bvbINqoyeKJ4KrIjA6iCq8ciA
         Dnp+7/fQoKgJeKCORY8gWLKMrsts457qnpK+CgLnuExbF/XDiKTb6pkLvNgDvQdnqnlZ
         fF/JVBn5uV9mmYv7ZZ0aPszexpEdpQVLTjVKPd+WHnHtuyCGbkCGhsPQIA2xi6drIn4G
         d59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716685335; x=1717290135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeLDGmDf1/7tTfYiJxh+Tr0l3nCr7JuqJ8jhahq1kPY=;
        b=QGL8bLg7g9HGYV4w3N7sS/yVILWIk8XMhb2WEheiMwij8u7SbsDytNaZJJOd5lEEF8
         fGQ9aENe74HOppX1Mbh9zUw8M92MTnWAWyv0RjyeRVa1qP6V4g8pkFjjZlVffpcTYQQI
         HiDvxH1pI4EhR1jWrnQXWm62SUn4Auhpam83U/eDqSccq8b887LUCM4KUXCObuYUbp+D
         Bcq1JQFhu8Ptmpuf6qq7d5e07hdBSMKgU7qcGJLma36INU/3t1zWwjj75GtE7GP3aPok
         DF5/9jojeZBOgKC4a4zaDKowKQyUWHDciM+S0fOELLhFroEHSgqnt+e6wZUUNOFfc92g
         UD+Q==
X-Gm-Message-State: AOJu0Yx3n8FYfjKeDEAbshlwQzuWrPJBHZEzVuUA2C/BNpJEKukhYV6S
	jqrGwkC+cJDAzsvXb+JyyzvVGpA97Y5NiPYzaC7psKGJVTy2I3IndL9fxQ==
X-Google-Smtp-Source: AGHT+IF7yNa7cc+h3IfjD0wdGGukc1anfOXGPmQkKSSkCVgsJ9rQdc0s9e6IDwk1mFCdPNdbO1xNiQ==
X-Received: by 2002:a05:6214:318e:b0:6ab:6ddc:4ba0 with SMTP id 6a1803df08f44-6abcd0cd73dmr59371786d6.53.1716685334789;
        Sat, 25 May 2024 18:02:14 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad5b5da00csm19134656d6.92.2024.05.25.18.02.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 18:02:14 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] u-boot: updates for WORKDIR/UNPACKDIR cleanup
Date: Sat, 25 May 2024 21:02:09 -0400
Message-ID: <20240526010209.33012-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 01:02:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/197

Builds no longer work if artifacts are placed in WORKDIR.

oe-core: b84eec5c4cbf ("base: Switch UNPACKDIR to a subdir of WORKDIR")
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-bsp/u-boot/u-boot_%.bbappend | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index 5c9e442cca8d..7d2e4a02e151 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -58,7 +58,7 @@ rk_generate_env() {
 	UBOOT_ENV_SIZE="$(cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" | cut -d'=' -f2)"
 
 	# linux user-space U-Boot env config file
-	echo "/dev/disk/by-partlabel/uboot_env 0x0000 ${UBOOT_ENV_SIZE}" > ${WORKDIR}/fw_env.config
+	echo "/dev/disk/by-partlabel/uboot_env 0x0000 ${UBOOT_ENV_SIZE}" > ${UNPACKDIR}/fw_env.config
 
 	# convert text-based environment to binary suitable for image
 	if [ "${@bb.utils.to_boolean(d.getVar('RK_IMAGE_INCLUDES_UBOOT_ENV'), False)}" = "True" ]; then
@@ -66,14 +66,14 @@ rk_generate_env() {
 			echo "initial, text-formatted U-Boot environment file \"${B}/u-boot-initial-env\" not found"
 			return 1
 		fi
-		mkenvimage -s ${UBOOT_ENV_SIZE} ${B}/u-boot-initial-env -o ${WORKDIR}/u-boot.env
+		mkenvimage -s ${UBOOT_ENV_SIZE} ${B}/u-boot-initial-env -o ${B}/u-boot.env
 	fi
 }
 do_compile[postfuncs] += "${@'rk_generate_env' if 'rk-u-boot-env' in d.getVar('MACHINEOVERRIDES').split(':') else 'rk_no_env'}"
 
 do_deploy:append:rk-u-boot-env() {
-	if [ -f ${WORKDIR}/u-boot.env -a "${@bb.utils.to_boolean(d.getVar('RK_IMAGE_INCLUDES_UBOOT_ENV'),False)}" = "True" ]; then
+	if [ -f ${B}/u-boot.env -a "${@bb.utils.to_boolean(d.getVar('RK_IMAGE_INCLUDES_UBOOT_ENV'),False)}" = "True" ]; then
 		install -d ${DEPLOYDIR}
-		install -m 0644 ${WORKDIR}/u-boot.env ${DEPLOYDIR}
+		install -m 0644 ${B}/u-boot.env ${DEPLOYDIR}
 	fi
 }
-- 
2.44.0.478.g7774cfed6261


