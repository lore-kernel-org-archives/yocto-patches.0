Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248BDC369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 07:03:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mx.groups.io with SMTP id smtpd.web11.11443.1745910197989855976
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Apr 2025 00:03:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=VFGNHGB/;
 spf=pass (domain: intel.com, ip: 198.175.65.14, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745910199; x=1777446199;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=QSUYiFqSkLN7i9qgy9HlW2JWR2GfeXKnFzVYK0WCl9I=;
  b=VFGNHGB/I6IxlicsJKeaEFJ/+/TVat75TXWFq+58m4i4oeuyJh1evmWV
   bPR+AxmRUkfLiA5cwTim42Mda3hM70Ldwia6CkdRpRKLVROLniMWR8pi+
   oaIWjjtBnzThloKBv4Ja5SeJ4KzXa1ysQ8snNSN5wmd9cZq+S00e3naK7
   1AsICvwho6oOi07nqz/u/O0W/qPACDN62IK13yZJlUpWOF1Kh36rm2hj1
   JyJ1ofFHO/CCYSm+LcOdeMVYJqv65xV6gPTJl8+uGW/vVt0ZdN53PEEGw
   J/oJykmezGZdFvqf9yxBd7gn1V2Jsjy649hr2FBtYUfZGXFbYBqUQgHFk
   Q==;
X-CSE-ConnectionGUID: xW2Mly1+SFWjBP6qFvBSiA==
X-CSE-MsgGUID: xj3gCxG2SoCYpAYCHqtUDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="51338435"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="51338435"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 00:03:18 -0700
X-CSE-ConnectionGUID: IfYUPReHRKythNv96PqcmA==
X-CSE-MsgGUID: GppmLwdXQeiG3qd9iOXS1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="138551478"
Received: from andromeda02.png.intel.com (HELO andromeda02..) ([10.107.232.49])
  by fmviesa005.fm.intel.com with ESMTP; 29 Apr 2025 00:03:17 -0700
From: Naveen Saini <naveen.kumar.saini@intel.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][walnascar][PATCH 2/2] README.txt: update for walnascar release
Date: Tue, 29 Apr 2025 14:13:03 +0800
Message-Id: <20250429061303.3703928-2-naveen.kumar.saini@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250429061303.3703928-1-naveen.kumar.saini@intel.com>
References: <20250429061303.3703928-1-naveen.kumar.saini@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Apr 2025 07:03:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1418

Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
---
 README.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README.txt b/README.txt
index d3694a6..2dbe1b3 100644
--- a/README.txt
+++ b/README.txt
@@ -9,9 +9,9 @@ Prerequisites:
 ==============
 
 This layer depends on:
-    Yocto distro (master)
+    Yocto distro (walnascar)
         git://git.yoctoproject.org/poky
-    Python layer (meta-openembedded/meta-python)
+    Python layer (meta-openembedded/meta-python) (walnascar)
         git://git.openembedded.org/meta-openembedded
 
 Add "meta-openembedded/meta-oe" to BBLAYERS
-- 
2.37.3


