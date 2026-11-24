Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16191.1795520515261822654
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Nov 2026 03:41:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wAX8lp0dwVrQdQAAA--.4347S3;
	Tue, 24 Nov 2026 19:39:32 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowACXKWr5dwVrLcFAAA--.28459S4;
	Tue, 24 Nov 2026 19:41:48 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][PATCH 2/4] refpolicy: label start_getty as bin_t in corecommands.fc
Date: Tue, 24 Nov 2026 19:41:35 +0800
Message-ID: <20261124114137.2203106-3-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124114137.2203106-1-chenqi_hycx@cetc.com.cn>
References: <20261124114137.2203106-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowACXKWr5dwVrLcFAAA--.28459S4
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYBCmsEQuMpvgAAsV
X-CM-DELIVERINFO: =?B?ylPnTqc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOGf+ybSYYtFb9Hm0wXO+e7pOKY+wsB/zrqdnV9An/LPree36kE4hrIkNESG5sF+eSOH8
	xqw77qx6FZnroB8n+ezvq/Oy/3z4zCRlZrQ78qjqjX6TAgYoZUbthG6uLSsmwQ==
X-Coremail-Antispam: 1Uk129KBj93XoW3XF1ftr1xJF17Zr4UJr15KFX_yoW7XFWUpF
	4rC3Z8Aa18WFyxZFs7CF1jvF13Ka95Za1j934rCFs7A3s5JF18C3Wjyr9FyFW8Zry7K34a
	vrs0yFyfXa17JrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_Gw7v73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYw7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jrv_JF1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07jO189UUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 11:42:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5503
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

SELint reports:

  getty.fc: 7: (S): Type bin_t is declared in module corecommands, but
  used in file context here. (S-002)

bin_t is declared in corecommands, so the context for the wrapper script
belongs in that module.

Assisted-by: Codewhale:deepseek-flash
Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 ...ecommands-label-start_getty-as-bin_t.patch | 30 +++++++++++++++++++
 ...etty-add-file-context-to-start_getty.patch | 27 -----------------
 .../refpolicy/refpolicy_common.inc            |  2 +-
 3 files changed, 31 insertions(+), 28 deletions(-)
 create mode 100644 recipes-security/refpolicy/refpolicy/0023-fc-corecommands-label-start_getty-as-bin_t.patch
 delete mode 100644 recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch

diff --git a/recipes-security/refpolicy/refpolicy/0023-fc-corecommands-label-start_getty-as-bin_t.patch b/recipes-security/refpolicy/refpolicy/0023-fc-corecommands-label-start_getty-as-bin_t.patch
new file mode 100644
index 0000000..6353aa7
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0023-fc-corecommands-label-start_getty-as-bin_t.patch
@@ -0,0 +1,30 @@
+From 75ad7b87b85a3fb0f0d00b88831a3171a01e8fa0 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Fri, 15 Nov 2019 16:07:30 +0800
+Subject: [PATCH] fc/corecommands: label start_getty as bin_t
+
+start_getty is a wrapper script, so it must not inherit getty_exec_t
+from the /usr/bin/.*getty pattern.  bin_t is declared in corecommands,
+hence the label belongs in that module's file context.
+
+Upstream-Status: Inappropriate [embedded specific]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/kernel/corecommands.fc | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
+index 110e7471d..3b13d3ba8 100644
+--- a/policy/modules/kernel/corecommands.fc
++++ b/policy/modules/kernel/corecommands.fc
+@@ -178,6 +178,7 @@ ifdef(`distro_gentoo',`
+ /usr/bin/scponlyc		--	gen_context(system_u:object_r:shell_exec_t,s0)
+ /usr/bin/sh			--	gen_context(system_u:object_r:shell_exec_t,s0)
+ /usr/bin/smrsh			--	gen_context(system_u:object_r:shell_exec_t,s0)
++/usr/bin/start_getty		--	gen_context(system_u:object_r:bin_t,s0)
+ /usr/bin/tcsh			--	gen_context(system_u:object_r:shell_exec_t,s0)
+ /usr/bin/yash			--	gen_context(system_u:object_r:shell_exec_t,s0)
+ /usr/bin/zsh.*			--	gen_context(system_u:object_r:shell_exec_t,s0)
+-- 
+2.34.1
diff --git a/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch b/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
deleted file mode 100644
index e9b70b2..0000000
--- a/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
+++ /dev/null
@@ -1,27 +0,0 @@
-From 75ad7b87b85a3fb0f0d00b88831a3171a01e8fa0 Mon Sep 17 00:00:00 2001
-From: Yi Zhao <yi.zhao@windriver.com>
-Date: Fri, 15 Nov 2019 16:07:30 +0800
-Subject: [PATCH] fc/getty: add file context to start_getty
-
-Upstream-Status: Inappropriate [embedded specific]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- policy/modules/system/getty.fc | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/policy/modules/system/getty.fc b/policy/modules/system/getty.fc
-index c7701c930..8b70b609a 100644
---- a/policy/modules/system/getty.fc
-+++ b/policy/modules/system/getty.fc
-@@ -4,6 +4,7 @@
- /run/agetty\.reload	--	gen_context(system_u:object_r:getty_runtime_t,s0)
- 
- /usr/bin/.*getty	--	gen_context(system_u:object_r:getty_exec_t,s0)
-+/usr/bin/start_getty	--	gen_context(system_u:object_r:bin_t,s0)
- 
- 
- /var/log/mgetty\.log.*	--	gen_context(system_u:object_r:getty_log_t,s0)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 3f629bc..be0aa83 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -38,7 +38,7 @@ SRC_URI += " \
         file://0020-fc-ldap-apply-policy-to-ldap-alternatives.patch \
         file://0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch \
         file://0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch \
-        file://0023-fc-getty-add-file-context-to-start_getty.patch \
+        file://0023-fc-corecommands-label-start_getty-as-bin_t.patch \
         file://0024-fc-vlock-apply-policy-to-vlock-alternatives.patch \
         file://0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch \
         file://0026-file_contexts.subs_dist-set-aliase-for-root-director.patch \
-- 
2.43.0

