Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC57CD343F
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 06:30:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2670.1779085819162090919
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 May 2026 23:30:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=MFMWgJTB;
 spf=pass (domain: intel.com, ip: 198.175.65.18, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779085819; x=1810621819;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1ivHBiTmeks85z+nUv4IFxOEgALiq/NU8kTF9S+vqtc=;
  b=MFMWgJTBmoPQMjk0n7FQ/ijwg8N2+Eiu+yIBpnlZISFCniSqnVIm/fhn
   OMnomhMJecnAvrMXnlY/XxFoC3Mai9DZ3Uuhmo6KjxGYT0tKs6CC3pt2e
   sY+aSipq5j2zVkfKyGF8uatMPHZbrvay0jQu4ZNlwcItDpljBVUL1LA97
   OyEtcAVkT4bPHrKD388amREWpZ5o5XUwfzlnjEA7XNDVgwaoW2xcNMOlo
   QTZsDvfvEjYFtzjcLYbgygiXSqeCPPvTEniubnOTDJX+oUSkuAAhQ7XST
   /ITYYee0JBZcID6x+RIQOU8iVvrjS0rdNv5taZKZNbAJf3fLjty8/YLjH
   Q==;
X-CSE-ConnectionGUID: i2646N/xT1uk0zUlvMf+Eg==
X-CSE-MsgGUID: LHYcasxiQ4OQ5TTKEsVKHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79979313"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79979313"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 23:30:18 -0700
X-CSE-ConnectionGUID: BFD35TzvRL+2sGqn4ZWkQw==
X-CSE-MsgGUID: o2zSotvZRQWDo2jcLbDzWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="262852682"
Received: from andromeda02.png.intel.com ([10.107.232.49])
  by fmviesa002.fm.intel.com with ESMTP; 17 May 2026 23:30:17 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][meta-zephyr 1/4] zephyr-kernel/4.3: Fix sysrootarg
Date: Mon, 18 May 2026 13:14:34 +0800
Message-Id: <20260518051437.693745-1-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 May 2026 06:30:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3997

From: Lee Chee Yang <chee.yang.lee@intel.com>

|     build_elf(args.elf_file, args.includes)
|     ~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
|   File "/data/build-zephyr/tmp/work/intel_ehl_crb-zephyr/zephyr-helloworld/4.3.0+git/sources/zephyr-helloworld-4.3.0+git/zephyr/arch/x86/zefi/zefi.py", line
 120, in build_elf
|     ["-fno-stack-protector", "-fpic", "-mno-red-zone", "-fshort-wchar", sysrootarg,
|                                                                         ^^^^^^^^^^
| NameError: name 'sysrootarg' is not defined
| ninja: build stopped: subcommand failed.

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 ...-x86-fix-efi-binary-generation-issue-in-cross-compila.patch | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
index ba454a9..fe7b7ef 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
@@ -24,11 +24,12 @@ diff --git a/arch/x86/zefi/zefi.py b/arch/x86/zefi/zefi.py
 index b98419f8a49..790797f011a 100755
 --- a/arch/x86/zefi/zefi.py
 +++ b/arch/x86/zefi/zefi.py
-@@ -115,8 +115,9 @@ def build_elf(elf_file, include_dirs):
+@@ -115,8 +115,10 @@ def build_elf(elf_file, include_dirs):
      includes = []
      for include_dir in include_dirs:
          includes.extend(["-I", include_dir])
 +    #  Pass --sysroot path for cross compilation
++    sysrootarg = "--sysroot=" + args.sysroot
      cmd = ([args.compiler, "-shared", "-Wall", "-Werror", "-I."] + includes +
 -           ["-fno-stack-protector", "-fpic", "-mno-red-zone", "-fshort-wchar",
 +           ["-fno-stack-protector", "-fpic", "-mno-red-zone", "-fshort-wchar", sysrootarg,
-- 
2.37.3


