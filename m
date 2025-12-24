Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94230E74AE0
	for <webhook@archiver.kernel.org>; Wed, 24 Dec 2025 06:47:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.115951.1766558825047135001
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Dec 2025 22:47:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=AawXLExS;
 spf=pass (domain: intel.com, ip: 198.175.65.13, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766558825; x=1798094825;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=x51JE2TiUlipTrcK0Z+yOqBYVz914hiEwd0fSCqw65w=;
  b=AawXLExSrindZ5pohPs8797kyho9HQsYSBqDawAVZIWJAMOrEFU244xH
   dAwzUQ4F9u7zYGJupcRUYhhE8z/Cpz/VKYRA0w6+sYJ0iJYuGv+88DiYY
   hOkbEHZaeaKhUXXybB3cCzF4y7hqs4dA/1D1d+NR77sftGHOXVDRGnMnH
   v8cgRbpp7cgDNF/Dtuaj8VTCqedomuerclEYN3HVY0nw2KtFitZCf5AkN
   OPPG1yMKOLkaHwOX7pB0d+Jxq4dimUsHJbOMdv7KhJ41LCowBzbLohUH7
   RuXHQtqloyKNinpGH/RRl1mSJiS0/xY+qEvJn6wEDyrdWlIG3kXYXkSXa
   w==;
X-CSE-ConnectionGUID: liK2QG/JRJyD/V/gwXkflg==
X-CSE-MsgGUID: vaXehV4wQhyAFuyB1bg4pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="79518836"
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="79518836"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 22:47:05 -0800
X-CSE-ConnectionGUID: T/1JsWKFSJKosXYIFzdLdA==
X-CSE-MsgGUID: u3w/QGs1Sym4pPYItbiQEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; 
   d="scan'208";a="230614388"
Received: from cheeyang-desk4.png.intel.com ([10.107.249.123])
  by orviesa002.jf.intel.com with ESMTP; 23 Dec 2025 22:47:04 -0800
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-zephyr][PATCH 3/4] zephyr-master.conf.json: add config for bitbake-setup
Date: Wed, 24 Dec 2025 14:46:34 +0800
Message-ID: <20251224064635.1187089-3-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251224064635.1187089-1-chee.yang.lee@intel.com>
References: <20251224064635.1187089-1-chee.yang.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Dec 2025 06:47:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2869

From: Lee Chee Yang <chee.yang.lee@intel.com>

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 zephyr-master.conf.json | 82 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 zephyr-master.conf.json

diff --git a/zephyr-master.conf.json b/zephyr-master.conf.json
new file mode 100644
index 0000000..f8dd18b
--- /dev/null
+++ b/zephyr-master.conf.json
@@ -0,0 +1,82 @@
+{
+    "description": "Meta-zephyr default configuration",
+    "sources": {
+        "bitbake": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "https://git.openembedded.org/bitbake"
+                    }
+                },
+                "branch": "master",
+                "rev": "master"
+            }
+        },
+        "openembedded-core": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "https://git.openembedded.org/openembedded-core"
+                    }
+                },
+                "branch": "master",
+                "rev": "master"
+            }
+        },
+        "meta-openembedded": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "https://git.openembedded.org/meta-openembedded"
+                    }
+                },
+                "branch": "master",
+                "rev": "master"
+            }
+        },
+        "meta-zephyr": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "https://git.yoctoproject.org/meta-zephyr"
+                    }
+                },
+                "branch": "master",
+                "rev": "master"
+            }
+        }
+    },
+    "bitbake-setup": {
+        "configurations": [
+        {
+            "name": "zephyr-default",
+            "description": "Base zephyr configuration",
+            "setup-dir-name": "zephyr-master",
+            "bb-layers": [
+                "openembedded-core/meta",
+                "meta-openembedded/meta-oe",
+                "meta-openembedded/meta-python" ,
+                "meta-zephyr/meta-zephyr-core",
+                "meta-zephyr/meta-zephyr-bsp"
+	        ],
+            "oe-fragments-one-of": {
+                "machine": {
+                    "description": "Target machines",
+                    "options" : [
+                        "machine/96b-nitrogen",
+                        "machine/intel-x86-64",
+                        "machine/qemu-cortex-m3",
+                        "machine/qemu-x86"
+                        ]
+                },
+                "distro": {
+                    "description": "Distribution configuration variants",
+                    "options" : ["distro/zephyr"]
+                }
+            }
+
+        }
+        ]
+    },
+    "version": "1.0"
+}
-- 
2.43.0


