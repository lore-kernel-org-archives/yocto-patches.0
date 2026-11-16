Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20043.1794797799803784406
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 18:56:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wDHoIVncPpqYdQAAA--.940S3;
	Mon, 16 Nov 2026 10:54:31 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABn+WnccPpqPNA3AA--.14039S4;
	Mon, 16 Nov 2026 10:56:36 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [PATCH 2/6] refpolicy: fix shadow lock issue
Date: Mon, 16 Nov 2026 10:56:16 +0800
Message-ID: <20261116025620.2558594-3-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
References: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABn+WnccPpqPNA3AA--.14039S4
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYNCmr5tRgFSgAEs2
X-CM-DELIVERINFO: =?B?qfkun6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoONahKFcN3sR551ZGDSnKFd8y00cREoaKfNfTdZyeBFUSTBZgGszeRPd1GuvOmS9NP70t
	JRZr3n1awOO/ccPDTkd5aRBlGnxz2xTFyYapbkYP3iOEj+zlCz2ogC+v30esAw==
X-Coremail-Antispam: 1Uk129KBj93XoWxWryrGr4rXFW7ZF15Gw1ktFc_yoW5KFy7pr
	4rAa4YkFWkXFn2qFsrCF4UZr15K3y8Gws8Z3yUWF4UCrW5AF1kua1rJryDWrWS9r17GrZF
	vrsIkFy5t3WUAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYh7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU2xhLUUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 02:56:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5399
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Add a local patch to fix shadow lock issue.

Upstream issue and PR:
https://github.com/SELinuxProject/refpolicy/issues/1274
https://github.com/SELinuxProject/refpolicy/pull/1280

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 ...allow-creating-the-shadow-lock-files.patch | 41 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 42 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0058-authlogin-allow-creating-the-shadow-lock-files.patch

diff --git a/recipes-security/refpolicy/refpolicy/0058-authlogin-allow-creating-the-shadow-lock-files.patch b/recipes-security/refpolicy/refpolicy/0058-authlogin-allow-creating-the-shadow-lock-files.patch
new file mode 100644
index 0000000..b9f3542
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0058-authlogin-allow-creating-the-shadow-lock-files.patch
@@ -0,0 +1,41 @@
+From 69277d9047ebf1aee9af59c97a27a0fcad2a47ee Mon Sep 17 00:00:00 2001
+From: Chen Qi <chenqi_hycx@cetc.com.cn>
+Date: Mon, 9 Nov 2026 15:46:47 +0800
+Subject: [PATCH] authlogin: allow creating the shadow lock files
+
+auth_rw_shadow_lock() declares the file transitions for .pwd.lock,
+passwd.lock and group.lock but only grants rw_file_perms, which has no
+create.  A domain that finds no lock file therefore cannot create it:
+
+  avc: denied { create } for name=".pwd.lock"
+       scontext=system_u:system_r:systemd_sysusers_t:s0
+       tcontext=system_u:object_r:shadow_lock_t:s0 tclass=file
+
+The problem was revealed by systemd-sysusers with systemd 262. But any
+command that manages user password is likely to fail, e.g., `passwd root'.
+
+Upstream-Status: Inappropriate [OE Specific]
+[
+  Note that this patch is marked as 'Inappropriate' because there's a PR
+  upstream tracking this issue: https://github.com/SELinuxProject/refpolicy/pull/1280
+  When that PR is merged, we should drop this patch.
+]
+
+Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
+---
+ policy/modules/system/authlogin.if | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/system/authlogin.if b/policy/modules/system/authlogin.if
+index 6518f230e..91a46ed08 100644
+--- a/policy/modules/system/authlogin.if
++++ b/policy/modules/system/authlogin.if
+@@ -878,7 +878,7 @@ interface(`auth_rw_shadow_lock',`
+ 		type shadow_lock_t;
+ 	')
+ 
+-	allow $1 shadow_lock_t:file rw_file_perms;
++	allow $1 shadow_lock_t:file { create rw_file_perms };
+ 	files_etc_filetrans($1, shadow_lock_t, file, ".pwd.lock")
+ 	files_etc_filetrans($1, shadow_lock_t, file, "passwd.lock")
+ 	files_etc_filetrans($1, shadow_lock_t, file, "group.lock")
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 4b5108a..4fa2ae5 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -73,6 +73,7 @@ SRC_URI += " \
         file://0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0057-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0058-authlogin-allow-creating-the-shadow-lock-files.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
-- 
2.43.0

