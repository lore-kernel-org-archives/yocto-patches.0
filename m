Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A40CEBF70
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 02:48:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mx.groups.io with SMTP id smtpd.web10.60797.1727405297394162759
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Sep 2024 19:48:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=bWm+zOBQ;
 spf=pass (domain: intel.com, ip: 198.175.65.14, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727405298; x=1758941298;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Qu7OrxMaJSQ1TI0uZZcAs28s2Ni0HddM/28rFm1iBl8=;
  b=bWm+zOBQ6joYemkoHsmg2yMHG5Z0pbdpXR6BQx1VbZZpqtRBel4UzNHK
   fkTCd/dVmac1Wppi6favPGSuwzKhefOe+A8T4qxoC93LEPWLV8acPj23j
   fBJLRd7gvlxSKLLGmcv0VhU9y+gJnSFv9gmcuurEFQBASv6UmJ3NgowMo
   FKRgZuVSPb4Op/HMvu2GbNxLcU1ZRFPLcuN5YnwHIySo3tkkpSXi7G47c
   WsbDsqpDYAC6d6AvuaoDXDK7T3qf93oEd4sEcb/8xTmtN1fOA62D1ShSS
   1xHZP7yUU8Xl1+wr0AxeVX+mKzSB34u6JDUwj7TQAKn7pB4+hURuu8baf
   w==;
X-CSE-ConnectionGUID: +zEtMQaTQ/ujfHoKIzKwJA==
X-CSE-MsgGUID: FtgBL4vIRf20QScx8OOnoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30330046"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="30330046"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 19:48:18 -0700
X-CSE-ConnectionGUID: iOMJBvdJRmSOsCPzQk+7Aw==
X-CSE-MsgGUID: pRVmLHpTTbSSz1fL/57uBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72538318"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.73])
  by fmviesa008.fm.intel.com with ESMTP; 26 Sep 2024 19:48:17 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 2/2] qemu-x86.conf: remove invalid option
Date: Fri, 27 Sep 2024 10:03:54 +0800
Message-Id: <20240927020354.3338858-2-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240927020354.3338858-1-naveen.kumar.saini@intel.com>
References: <20240927020354.3338858-1-naveen.kumar.saini@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Sep 2024 02:48:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/677

qemu-system-i386: -no-acpi: invalid option

https://github.com/zephyrproject-rtos/zephyr/issues/72191

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 meta-zephyr-bsp/conf/machine/qemu-x86.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-zephyr-bsp/conf/machine/qemu-x86.conf b/meta-zephyr-bsp/conf/machine/qemu-x86.conf
index 3535a4c..9551523 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-x86.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-x86.conf
@@ -10,7 +10,7 @@ ZEPHYR_INHERIT_CLASSES += "zephyr-qemuboot"
 # For runqemu
 QB_SYSTEM_NAME = "qemu-system-i386"
 QB_MACHINE = "-machine type=pc-q35-2.10"
-QB_GRAPHICS = "-nographic -no-acpi"
+QB_GRAPHICS = "-nographic -machine acpi=off"
 QB_CPU:x86 = "-cpu qemu32,+nx,+pae"
 QB_CPU_KVM:x86 = "-cpu kvm32"
 
-- 
2.37.3


