Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC06C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 13:26:48 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web10.55990.1722259603627646147
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jul 2024 06:26:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=D89C8sAa;
 spf=pass (domain: gmail.com, ip: 209.85.128.177, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-67b709024bfso20263937b3.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259602; x=1722864402; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eSI9W3TmF8jYFIeeuPgU9RLI4PTHOz+4odIBGZpFqqQ=;
        b=D89C8sAa5yxP2brNzVN35o3j6OpLJ3TnhX55Dvj3evGBOyAaT7NyYN0YBMZ0By5ujs
         fd46wYXWStKmpUYmt9ye/jOqQaHFdmWkxPYewHEyCZ4cv2akWZVctzPKcdPiRP/6UipA
         drx06hkhytnh0zFT5TII5Ls/9jg5fobXhwqbYry9yiX6wfzu87oZinDi9LSAX8Hqv3Op
         cR+38TKso0Zq9/8LK/nmiNFrmwwi4zsfLaVpEQD9pHuP/BlU3TEAuKJzFwJ82siSAMkN
         IyPZOhiCfgkPB90yApw38CXiAlMGlU0VYizY72IZmgPGT5d0mTmkVha/0Wh3CwXDnD1J
         uvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259603; x=1722864403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSI9W3TmF8jYFIeeuPgU9RLI4PTHOz+4odIBGZpFqqQ=;
        b=bASWZiCVdpFfZ122XlbJ8vhtmrGEGLhjY/qY29QQrfGmqL9aDmI2kXeYXKzxgw3Z3y
         5sEbBUvVUTkPHwmWUaKFWVMGfY8xL+kXWsbMTOJXLs1L2hWatsm3WYcED+gygRCqsDop
         eyDBWVqfiC8Rmn/Gbaj1/36sSrVYTQ0c9eDdoTgcQCA9xCOEfuKSHGmcMtEdv0Bh2aZn
         4YvZUlEcyGSV5Z38kBtBJByU1pwQmBblJU9gJ4jarDeRfC68v2a21Gf8/m6zvG+HDkbE
         Kgju+Wu085l/wNiWatttGDkCcd+98/FATGikm8hxFGT11L5WKwYtcUP58xMfoIpyYlSU
         owFA==
X-Gm-Message-State: AOJu0YwJrdZGKVOQy0EbnkVEUpIcRFP9R4cgGpYAGYQNWozZT46WPd49
	RrFPsIF6fPKjbOnpgc322RENd7WV/FVefVglZpbIpydN/hykq0BxvOfSpA==
X-Google-Smtp-Source: AGHT+IHtQnY2eF7CoTja5fhABC2/aXIWmDxZHSzoE9hO7D2LbxHes/vFlY0hO258Rh1PQjNUOOkjlw==
X-Received: by 2002:a05:6902:1589:b0:e05:5fcf:ccbd with SMTP id 3f1490d57ef6-e0b545f3068mr7509094276.36.1722259602640;
        Mon, 29 Jul 2024 06:26:42 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:47bc:453d:d517:b47])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b29f1c269sm1836397276.11.2024.07.29.06.26.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:26:42 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] chipsec: Fix QA Warnings
Date: Mon, 29 Jul 2024 09:26:41 -0400
Message-Id: <20240729132641.3066494-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 13:26:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/494

ERROR: chipsec-1.9.1-r0 do_package_qa: QA Issue: File /usr/lib/python3.12/site-packages/chipsec/helper/linux/chipsec.ko in package chipsec contains reference to TMPDIR [buildpaths]
ERROR: chipsec-1.9.1-r0 do_package_qa: QA Issue: File /usr/lib/python3.12/site-packages/chipsec/helper/linux/.debug/chipsec.ko in package chipsec-dbg contains reference to TMPDIR [buildpaths]

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 recipes-security/chipsec/chipsec_1.9.1.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-security/chipsec/chipsec_1.9.1.bb b/recipes-security/chipsec/chipsec_1.9.1.bb
index 24451f8..213b047 100644
--- a/recipes-security/chipsec/chipsec_1.9.1.bb
+++ b/recipes-security/chipsec/chipsec_1.9.1.bb
@@ -24,6 +24,9 @@ do_compile:append() {
 }
 
 do_install:append() {
+    sed -i -e 's#${S}##g' ${S}/drivers/linux/chipsec.ko
+    sed -i -e 's#${STAGING_KERNEL_BUILDDIR}##g' ${S}/drivers/linux/chipsec.ko
+    sed -i -e 's#${STAGING_KERNEL_DIR}##g' ${S}/drivers/linux/chipsec.ko
 	install -m 0644 ${S}/drivers/linux/chipsec.ko ${D}${PYTHON_SITEPACKAGES_DIR}/chipsec/helper/linux
 }
 
@@ -32,3 +35,4 @@ COMPATIBLE_HOST = "(i.86|x86_64).*-linux"
 FILES:${PN} += "${exec_prefix}"
 
 RDEPENDS:${PN} = "python3 python3-modules"
+INSANE_SKIP:${PN} = "already-stripped"
-- 
2.34.1


