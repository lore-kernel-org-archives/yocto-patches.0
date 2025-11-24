Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937D9CFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 18:35:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24113.1764009342192887829
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Nov 2025 10:35:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 458A514BF;
	Mon, 24 Nov 2025 10:35:34 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40A9E3F86F;
	Mon, 24 Nov 2025 10:35:41 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: bruce.ashfield@gmail.com
Subject: [PATCH kernel-module-hello-world 2/2] Makefile: cleanup, use KERNEL_SRC
Date: Mon, 24 Nov 2025 18:35:34 +0000
Message-ID: <20251124183534.870124-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124183534.870124-1-ross.burton@arm.com>
References: <20251124183534.870124-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 18:35:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2701

Use KERNEL_SRC to specify the location of the kernel source tree, to
match module.bbclass in OpenEmbedded Core.

Also add a modules_install target.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 Makefile | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index e357001..b6fa870 100644
--- a/Makefile
+++ b/Makefile
@@ -1,11 +1,12 @@
-KERNELRELEASE	?=3D `uname -r`
-KERNEL_DIR	?=3D /lib/modules/$(KERNELRELEASE)/build
-PWD		:=3D $(shell pwd)
-obj-m		:=3D hello-world.o
+obj-m      :=3D hello-world.o
+KERNEL_SRC ?=3D /lib/modules/$(shell uname -r)/build
+SRC        :=3D $(shell pwd)
=20
 all:
-	@echo "Building hello-world kernel module..."
-	$(MAKE) -C $(KERNEL_DIR) M=3D$(PWD) modules
+	$(MAKE) -C $(KERNEL_SRC) M=3D$(SRC) modules
+
+modules_install:
+	$(MAKE) -C $(KERNEL_SRC) M=3D$(SRC) modules_install
=20
 clean:
-	make -C $(KERNEL_DIR) M=3D$(PWD) clean
+	make -C $(KERNEL_SRC) M=3D$(PWD) clean
--=20
2.43.0


