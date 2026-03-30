Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070DCFB3CE2
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 09:02:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46844.1774861322538621306
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 30 Mar 2026 02:02:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=l4vKwFjz;
 spf=pass (domain: intel.com, ip: 198.175.65.20, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774861323; x=1806397323;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=blA/uW6UAJ4QZKJbxrmW3YANIpNy0zilrzF+yZKP330=;
  b=l4vKwFjzFvToyJSgwqO5Bgz19wvdgcQG6yIxM07x+ptkRB4qEjrckTVN
   d4cxLVJ9jaEXLdtju/w0kj4/xpQwD4/ChEK4i/2on0EqnPGY9xidk/wcl
   W4ng+fpsuWv+RH1ZNCRmiCZT912ZKlk33HDlbFUKDa8iWHkAPjCQmddo/
   q0d3PFkwHZLHT6zNn+aAd+U4RAoF5qMtAQaK3qO0w4otyfJarLeBnPImi
   2eO59NDDfUQ7q1EwFS5OFbrAsLUp1bZhxpdUigMNAtKLc+r34pnxBlO21
   WUgTQV6gsh0ySwlZrlTnt4PoozFa2qpxRkJHp84rR1X867tyNjWa27VhH
   g==;
X-CSE-ConnectionGUID: mjYOhBtjTm+TR/psYW0mkw==
X-CSE-MsgGUID: lmqvDW57S+uI+tAUUQkLsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75559310"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75559310"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 02:02:02 -0700
X-CSE-ConnectionGUID: +qVBJxebSdyZvriNpPrCng==
X-CSE-MsgGUID: B0/0tHjGTC6Bw/PWqT+ClQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="225992881"
Received: from andromeda02.png.intel.com ([10.107.232.49])
  by orviesa008.jf.intel.com with ESMTP; 30 Mar 2026 02:02:01 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 1/2] zephyrtargetcontrol: fix missing native_sysroot
Date: Mon, 30 Mar 2026 15:46:25 +0800
Message-Id: <20260330074626.3818977-1-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 09:02:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3581

From: Lee Chee Yang <chee.yang.lee@intel.com>

fix
Exception: TypeError: QemuTargetZephyr.__init__() got an unexpected
keyword argument 'native_sysroot'

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 meta-zephyr-core/lib/oeqa/controllers/zephyrtargetcontrol.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-zephyr-core/lib/oeqa/controllers/zephyrtargetcontrol.py b/meta-zephyr-core/lib/oeqa/controllers/zephyrtargetcontrol.py
index d342314..e9bc6bb 100644
--- a/meta-zephyr-core/lib/oeqa/controllers/zephyrtargetcontrol.py
+++ b/meta-zephyr-core/lib/oeqa/controllers/zephyrtargetcontrol.py
@@ -15,7 +15,7 @@ class QemuTargetZephyr(OETarget):
             machine='', rootfs='', tmpdir ='',dir_image ='',display=None,
             kernel='',boottime=60,bootlog='',kvm=False,slirp=False,
             dump_dir='',serial_ports=0,ovmf=None,tmpfsdir='' ,target_modules_path='',powercontrol_cmd='',powercontrol_extra_args='',
-            serialcontrol_cmd=None,serialcontrol_extra_args='',testimage_dump_target='',testimage_dump_monitor=''):
+            serialcontrol_cmd=None,serialcontrol_extra_args='',testimage_dump_target='',testimage_dump_monitor='',native_sysroot=None):
 
         timeout =  300
         user = 'root'
-- 
2.37.3


