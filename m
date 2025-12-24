Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5706E74AE1
	for <webhook@archiver.kernel.org>; Wed, 24 Dec 2025 06:47:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.115951.1766558825047135001
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Dec 2025 22:47:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=CQjue1HM;
 spf=pass (domain: intel.com, ip: 198.175.65.13, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766558826; x=1798094826;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=R+NyMMj8ZPT2fkDSWPLMpMu3OVhW2/vPvfF5ls1pMwI=;
  b=CQjue1HMdHEPf4pVvB/gzbG+SHtHnkD5xhu2dEjKiBJqRDEHCcNEW+ph
   0z5hFuiK1mRh0dDeY9mwicScKxtFhox9p6PQktJd27MtnhbwQvNQujBov
   fEx1IcWKCOy5ijbYa2JEyB8aajrqeSbQkd4wTZDOxNRoJDv4uoLlibifK
   TTXGp5MLQHfokbt1WXsh+dlz1XvNwap7mOjRnemqXfhEXthOrEx9JGNRP
   LT3Liyc+WjBTuJgvb8fczH8ODanKcLPSs8rQ89LHbJbBkPWQdMvVtdG4s
   E+wv5FwIGpIQnJRYG1eg+sgJfyo5mwFgbZhZLTk3UoY1hxgCBzYYrHdCu
   w==;
X-CSE-ConnectionGUID: CVJSHao6RLyuDOlso9ix/w==
X-CSE-MsgGUID: P/CD4YtcSMOp57x/xGArgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="79518838"
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="79518838"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 22:47:06 -0800
X-CSE-ConnectionGUID: 2yJ3YwUgQVy/0hW23WmrHQ==
X-CSE-MsgGUID: 0cI9zc35TaqyN1X7GoPV+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="230614394"
Received: from cheeyang-desk4.png.intel.com ([10.107.249.123])
  by orviesa002.jf.intel.com with ESMTP; 23 Dec 2025 22:47:05 -0800
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 4/4] README: update build guide with bitbake-setup
Date: Wed, 24 Dec 2025 14:46:35 +0800
Message-ID: <20251224064635.1187089-4-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251224064635.1187089-1-chee.yang.lee@intel.com>
References: <20251224064635.1187089-1-chee.yang.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Dec 2025 06:47:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2870

From: cheeyanglee <chee.yang.lee@intel.com>

update build guide to use bitbake-setup.

also drop the reference to poky

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 README.md | 121 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 43 deletions(-)

diff --git a/README.md b/README.md
index 669e921..4094eb8 100644
--- a/README.md
+++ b/README.md
@@ -6,76 +6,111 @@ This layer enables building Zephyr using Yocto Project.
 
 This layer depends on:
 
-	URI: https://git.yoctoproject.org/poky
-	layers: meta
-	branch: master
+    URI: https://git.openembedded.org/bitbake
+    branch: master
 
-	URI: https://git.openembedded.org/meta-openembedded
-	layers: meta-oe, meta-python
-	branch: master
+    URI: https://git.openembedded.org/openembedded-core
+    layers: meta
+    branch: master
+
+    URI: https://git.openembedded.org/meta-openembedded
+    layers: meta-oe, meta-python
+    branch: master
 
 ## Building Zephyr Images via bitbake recipes
 
-More detailed and up-to-date information can be found here:
+### Quick Build
 
-https://wiki.yoctoproject.org/wiki/TipsAndTricks/BuildingZephyrImages
+Ensure your build host meets the
+[Yocto Project system requirements](https://docs.yoctoproject.org/ref-manual/system-requirements.html)
+and follow the
+[Quick Build setup guide](https://docs.yoctoproject.org/brief-yoctoprojectqs/index.html#yocto-project-quick-build)
+to setup the host enviroment.
 
-> **Pre-requisites:**
-1. Refer [Yocto Project Quick Build]( https://docs.yoctoproject.org/dev/singleindex.html#yocto-project-quick-build) documentation.
+Clone the following repos:
 
-2. Clone and add following layers to BBLAYERS
-    * meta-openembedded/meta-oe
-    * meta-openembedded/meta-python
-    * meta-zephyr-core
-    * meta-zephyr-bsp
-```
-    $ mkdir sources
-    $ git clone -b <release-branch> https://git.yoctoproject.org/poky
-    $ git clone -b <branch-name> https://git.openembedded.org/meta-openembedded
-    $ git clone -b <branch-name> https://git.yoctoproject.org/meta-zephyr
-    $ source poky/oe-init-build-env
-    $ bitbake-layers add-layer ../meta-openembedded/meta-oe
-    $ bitbake-layers add-layer ../meta-openembedded/meta-python
-    $ bitbake-layers add-layer ../meta-zephyr/meta-zephyr-core
-    $ bitbake-layers add-layer ../meta-zephyr/meta-zephyr-bsp
-```
+- bitbake
+- meta-zephyr
 
-### Building and Running Zephyr Samples
+```console
+git clone https://git.openembedded.org/bitbake
+git clone https://git.yoctoproject.org/meta-zephyr
+```
 
-You can build Zephyr samples. There are several sample recipes.
+Initialize default build configuration with bitbake-setup:
 
-To use the Yocto toolchain, modify local conf by adding:
-```
-    DISTRO = "zephyr"
+```console
+./bitbake/bin/bitbake-setup init --non-interactive \
+  ./meta-zephyr/zephyr-master.conf.json \
+  zephyr-default distro/zephy machine/qemu-x86
 ```
 
-To use the Zephyr pre-built toolchain, modify local conf by adding:
+Alternatively, run bitbake-setup with interactive mode to choose for
+different configuration:
+
+```console
+./bitbake/bin/bitbake-setup init ./meta-zephyr/zephyr-master.conf.json
 ```
-    ZEPHYR_TOOLCHAIN_VARIANT = "zephyr"
+
+Initialize build environment
+
+```console
+source ./bitbake-builds/zephyr-master/build/init-build-env
 ```
 
-For example, to build the Zephyr "philosophers" sample:
+build the Zephyr "helloworld" sample:
+
+```console
+bitbake zephyr-helloworld
 ```
-    $ MACHINE=qemu-x86 bitbake zephyr-philosophers
+
+### Building and Running other Zephyr Samples
+
+You can build other Zephyr samples. There are several sample recipes
+[available here](https://git.yoctoproject.org/meta-zephyr/tree/meta-zephyr-core/recipes-kernel/zephyr-kernel).
+
+For example, to build the
+[Zephyr "philosophers" sample](https://git.yoctoproject.org/meta-zephyr/tree/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-philosophers.bb):
+
+```console
+bitbake zephyr-philosophers
 ```
 
 You can then run the created "philosophers" image in qemu:
+
+```console
+runqemu
 ```
-    $ runqemu qemu-x86
-```
 
-The same sample, for ARM image:
+The same sample can be built for other machines/boards, for example ARM Cortex-M3:
+
+```console
+bitbake-config-build enable-fragment machine/qemu-cortex-m3
+bitbake zephyr-philosophers
+runqemu
 ```
-    $ MACHINE=qemu-cortex-m3 bitbake zephyr-philosophers
-    $ runqemu qemu-cortex-m3
+
+Alternatively, you can use the MACHINE variable to define the target machine,
+you will need to disable the machine fragment to prevent conflict:
+
+```console
+bitbake-config-build disable-fragment machine/qemu-x86
+MACHINE=qemu-cortex-m3 bitbake zephyr-philosophers
+runqemu qemu-cortex-m3
 ```
 
-The same sample, for Nios2 image:
+The default configuration (with `zephyr` DISTRO) uses the Yocto Project toolchain
+to compile Zephyr applications. To use the Zephyr pre-built toolchain instead,
+modify `local.conf` by adding:
+
 ```
-    $ MACHINE=qemu-nios2 bitbake zephyr-philosophers
-    $ runqemu qemu-nios2
+ZEPHYR_TOOLCHAIN_VARIANT = "zephyr"
 ```
 
+Other Tips and Tricks for building zephyr image can be found
+[here](https://wiki.yoctoproject.org/wiki/TipsAndTricks/BuildingZephyrImages).
+
+
 ### Flashing
 
 You can flash Zephyr samples to boards. Currently, the following MACHINEs
-- 
2.43.0


