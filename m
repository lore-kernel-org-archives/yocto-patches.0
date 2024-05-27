Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0159EC25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 04:55:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mx.groups.io with SMTP id smtpd.web10.20909.1716785699871168951
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 May 2024 21:55:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=eGq/vqvx;
 spf=pass (domain: intel.com, ip: 192.198.163.18, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716785700; x=1748321700;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hZtufBZ1uGyCmw0Z9c6hIw6CRRQKtYrd8dsOEG5BjH8=;
  b=eGq/vqvxtLf3orBgEYhJrQnglQ8H8LCojJq2BZCrxj6MsTRoHX2UBBv5
   UG3R+WysfEfqlR6XsF/ifoEBwFk7kWeWm68LviaVnzirGwv4Szmw13N25
   Pf/YZa9g3ZZrNRa5fuX0kqtwnwhqWJbq092kK4t6lHp8bNISdbQPsBIib
   dIW4PxGV6+fz0rKmjnYPNacoYKeV+4oVxOofeQW5zmrOWVGBeKS38i6tY
   zxlKilLAGoFLgCh49yPnwtCQXnFsXlKdJWAZmBsF3J6/AA6Sn4BmlKjG4
   i73lQY7jG1lUu4uU8ig7+C34ph1suzhThZ/hTRJdmri+PpzBhWwiyrURk
   Q==;
X-CSE-ConnectionGUID: 3MX93U1iS1m7JNbX7cClEA==
X-CSE-MsgGUID: CA/yhG0NRB+j193JG2Jobw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12864062"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="12864062"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 21:54:59 -0700
X-CSE-ConnectionGUID: diTgdAnRThmRwgs5r3Q4bQ==
X-CSE-MsgGUID: QAM5VNjwShOdoyac/zbqFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39036325"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.234.73])
  by fmviesa005.fm.intel.com with ESMTP; 26 May 2024 21:54:59 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH] zephyr-sdk: use UNPACKDIR
Date: Mon, 27 May 2024 12:17:52 +0800
Message-Id: <20240527041752.1240273-1-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 04:55:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/206

do_unpack: Bitbake Fetcher Error: UnpackError("subdir
argument isn't a subdirectory of unpack root"

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 .../recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5-1.bb     | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5-1.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5-1.bb
index 0b608bc..5f49e37 100644
--- a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5-1.bb
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5-1.bb
@@ -12,11 +12,14 @@ DEPENDS += "cmake"
 
 SDK_ARCHIVE = "zephyr-sdk-${PV}_linux-${BUILD_ARCH}.tar.xz"
 SDK_NAME = "${BUILD_ARCH}"
-SRC_URI = "https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${PV}/${SDK_ARCHIVE};subdir=${S};name=${SDK_NAME}"
+SRC_URI = "https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${PV}/${SDK_ARCHIVE};name=${SDK_NAME}"
 
 SRC_URI[x86_64.sha256sum] = "01f942146d2fc6d6afd5afe6f4b5c315525d2c937c7e613d3312b0992b33bc68"
 SRC_URI[aarch64.sha256sum] = "1749b6891a6a6e70b013d8b31ff067c5a94891f651985a6da9a20367b2deb6c7"
 
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
+
 do_configure[noexec] = "1"
 do_compile[noexec] = "1"
 
@@ -24,7 +27,7 @@ ZEPHYR_SDK_DIR = "${prefix}/zephyr-sdk"
 
 do_install() {
     install -d ${D}${prefix}
-    cp -r ${S}/zephyr-sdk-${PV} ${D}${ZEPHYR_SDK_DIR}
+    cp -r ${UNPACKDIR}/zephyr-sdk-${PV} ${D}${ZEPHYR_SDK_DIR}
 
     # Install host tools
     ${D}${ZEPHYR_SDK_DIR}/setup.sh -h
-- 
2.37.3


