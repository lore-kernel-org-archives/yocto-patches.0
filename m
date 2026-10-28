Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34707.1793153901646507478
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Oct 2026 19:18:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=GQ1+yG5b;
 spf=pass (domain: intel.com, ip: 192.198.163.7, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793153902; x=1824689902;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0R25vOQoq9LwaCoHPQ9vqciS+m0d8/vZDkYewEdLfdo=;
  b=GQ1+yG5bOImekNnecGMwq3lkqVxlWsS6FqGu4RGb0zs7IB24bPLrsuTq
   eI0Ah1ugYGO7Mv+EVXZ1PpwyeyB2aignF0KR9M5c70PTru/7670FjxdG6
   M+pdD40XVulRebIZN/Goyn5tGmhiVddv3sBA+y3HDDPLuQyf4+NR2QtWu
   6R3l1SPWKcDkNITd8wUA/jWEQY0/OA1ACZG0tC2oM4AwejYQZ6HcindxK
   +HmexTNF7bByefz0NPqGmoOE5jOLBhSCZ0gc98BYZvAvv+1t2dAGxbXvo
   IBnkynHMsxRHF3XfSlbcrdFFTby5loc2E5Jn4lXHkTOvtkwQzVqlSHXCJ
   Q==;
X-CSE-ConnectionGUID: eAYR1K4ITQ6J9q0h+vxn5Q==
X-CSE-MsgGUID: Lw5749E3RI+a9vhv3RVslg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1754650"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1754650"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 19:18:21 -0700
X-CSE-ConnectionGUID: pRYTk6A4TK2i+FizbS4hWQ==
X-CSE-MsgGUID: 2aeiwOOaS7q8kF2nb4Wq+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5068433"
Received: from cheeyang-desk4.png.intel.com ([10.107.249.123])
  by fmviesa009.fm.intel.com with ESMTP; 27 Oct 2026 19:18:20 -0700
From: chee.yang.lee@intel.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][meta-zephyr] zephyrtargetcontrol: fix unexpected ignore_ssh_fails
Date: Wed, 28 Oct 2026 10:17:22 +0800
Message-ID: <20261028021722.326062-1-chee.yang.lee@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 02:18:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5164
Content-Type: text/plain; charset="utf-8"

From: Lee Chee Yang <chee.yang.lee@intel.com>

fix unexpected keyword argument for QemuTargetZephyr

File: '/data/blacksail/openembedded-core/meta/lib/oeqa/utils/postactions.py', lineno: 88, function: run_coredumpctl_info
     0084:    # message ID for coredumps, so it shows all of the coredumps that are in the
     0085:    # journal.
     0086:    output_file = d.expand("${localstatedir}/log/coredumps.txt")
     0087:    cmd = f"coredumpctl info MESSAGE_ID=fc2e22bc6ee647b6b90729ab34a250b1 | tee {output_file}"
 *** 0088:    tc.target.run(cmd, ignore_ssh_fails=True)
     0089:
     0090:
     0091:##################################################################
     0092:# General post actions runner
Exception: TypeError: OETarget.run() got an unexpected keyword argument 'ignore_ssh_fails'

Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
---
 .../lib/oeqa/controllers/zephyrtargetcontrol.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/meta-zephyr-core/lib/oeqa/controllers/zephyrtargetcontrol.py b/meta-zephyr-core/lib/oeqa/controllers/zephyrtargetcontrol.py
index e9bc6bb..a557a5c 100644
--- a/meta-zephyr-core/lib/oeqa/controllers/zephyrtargetcontrol.py
+++ b/meta-zephyr-core/lib/oeqa/controllers/zephyrtargetcontrol.py
@@ -15,7 +15,8 @@ class QemuTargetZephyr(OETarget):
             machine='', rootfs='', tmpdir ='',dir_image ='',display=None,
             kernel='',boottime=60,bootlog='',kvm=False,slirp=False,
             dump_dir='',serial_ports=0,ovmf=None,tmpfsdir='' ,target_modules_path='',powercontrol_cmd='',powercontrol_extra_args='',
-            serialcontrol_cmd=None,serialcontrol_extra_args='',testimage_dump_target='',testimage_dump_monitor='',native_sysroot=None):
+            serialcontrol_cmd=None,serialcontrol_extra_args='',testimage_dump_target='',testimage_dump_monitor='',native_sysroot=None,
+            ignore_ssh_fails=True):
 
         timeout =  300
         user = 'root'
@@ -60,3 +61,17 @@ class QemuTargetZephyr(OETarget):
 
     def serial_readline(self):
         return self.runner.serial_readline()
+
+    def run(self, cmd, timeout=None, ignore_status=True, raw=False, ignore_ssh_fails=False):
+        """
+        QemuTargetZephyr has no SSH (or other remote shell) support, only
+        a serial console. Treat every call as an SSH failure (status 255),
+        matching OESSHTarget's convention, so that callers written for
+        SSH-capable targets (e.g. testimage's post-failure actions) degrade
+        gracefully instead of raising a TypeError.
+        """
+        status, output = 255, "QemuTargetZephyr has no SSH support; only serial console access is available"
+        if not ignore_ssh_fails:
+            raise AssertionError(output)
+        return (status, output)
+
-- 
2.43.0

