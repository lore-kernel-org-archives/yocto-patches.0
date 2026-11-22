Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29934.1795327890330258411
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 21 Nov 2026 22:11:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wD3ylwIhwJrMjEAAA--.1306S3;
	Sun, 22 Nov 2026 14:09:12 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABH2GiLhwJrkBE+AA--.9795S3;
	Sun, 22 Nov 2026 14:11:25 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [PATCH v2 1/4] refpolicy: update to c89bd1537
Date: Sun, 22 Nov 2026 14:11:19 +0800
Message-ID: <20261122061122.2042600-2-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122061122.2042600-1-chenqi_hycx@cetc.com.cn>
References: <20261122061122.2042600-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABH2GiLhwJrkBE+AA--.9795S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYTCmsBnhoDrwADsc
X-CM-DELIVERINFO: =?B?D467xac9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOHShpPsBtNldyiwV+ylxQUmqGqX0HddvdWD0v04TezVm/8cwxCTbe26owk5BC5M09h/h
	HdVD9f4RGrW9SKgVL1Z/jkAw6Vnjm8cxnK3XFe3MbK2ITikG4DbCu1lqXzAReQ==
X-Coremail-Antispam: 1Uk129KBj93XoW3XF43Zw43uw13CFy7KF4kuFX_yoW7uF43pF
	4Fya4FkrykXF18AFsFkF1xZr1xK3s09w4UWayFkr47C3yUAryDCa1fta43WF4rZr13Crya
	vryaya43Xa1jyacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GFUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYz7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2
	z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIF
	yTuYvjxU4WSoDUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 22 Nov 2026 06:11:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5486
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Bump to latest for the systemd 262 fixes and for the shadow lock
rework.

systemd 262, for the services and paths that it added:
```
d6ef7f26b systemd: let the user manager getattr clock devices
98421e290 systemd: allow systemd-coredumpd to start
c89e5d936 systemd: give /run/sysctl.d its own type
b88bdf4fe systemd: let user systemd-tmpfiles read /usr
8c2498a23 ntp: let systemd-timesyncd read the IPv6 sysctls
13afa2496 systemd: allow varlink socket xattr access
c9085fb7c logging: grant journald access to /run/systemd/units
```

shadow lock (upstream PR #1280):
```
fd41cadd0 authlogin: create a bundle interface for shadow + shadow lock
8e880a6af init: allow creating the shadow lock
aead3a373 authlogin: create an interface to create the shadow lock
c8a588f58 authlogin: split file transitions out of auth_rw_shadow_lock
eca17962e authlogin: separate auth_rw_shadow_lock from auth_manage_shadow
```
auth_rw_shadow_lock() no longer declares the file transitions, so
auth_change_shadow_passwords() can grant create on .pwd.lock, passwd.lock
and group.lock together with the read/write it already gave, and its
callers are moved over; chfn gets create on its own.

others:
```
71a73d9c9 sudo: prevent SELinux denial after console login
2c5e71180 fapolicyd: ptrace permission for user namespace
6d89b2abe fapolicyd: Updates for fapolicyd v2.0.1
19f69c48e fapolicyd: set default context for /etc/fapolicyd/compiled.rules.prev
```

Refresh 0040: upstream added a /run/sysctl.d entry to systemd.fc, which
shifted the context of its hunk.

Assisted-by: Codewhale:deepseek-v4-flash
Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 ...main-used-for-login-program-to-conne.patch | 20 +++++++++----------
 recipes-security/refpolicy/refpolicy_git.inc  |  2 +-
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy/0040-systemd-allow-domain-used-for-login-program-to-conne.patch b/recipes-security/refpolicy/refpolicy/0040-systemd-allow-domain-used-for-login-program-to-conne.patch
index 46d3046..e4f0c08 100644
--- a/recipes-security/refpolicy/refpolicy/0040-systemd-allow-domain-used-for-login-program-to-conne.patch
+++ b/recipes-security/refpolicy/refpolicy/0040-systemd-allow-domain-used-for-login-program-to-conne.patch
@@ -1,7 +1,8 @@
-From f94cd726509a88f8efd72b175fe3079544e9ef26 Mon Sep 17 00:00:00 2001
+From 03f2558a168c4ff3fa879774d7cb416bcc991225 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 6 Feb 2026 22:13:03 +0800
 Subject: [PATCH] systemd: allow domain used for login program to connect to
+
  systemd-logind over unix socket
 
 Fix the following AVC denials:
@@ -25,10 +26,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  3 files changed, 22 insertions(+)
 
 diff --git a/policy/modules/system/authlogin.if b/policy/modules/system/authlogin.if
-index 82d3f6684..db1fcc344 100644
+index 5add629ac..6518f230e 100644
 --- a/policy/modules/system/authlogin.if
 +++ b/policy/modules/system/authlogin.if
-@@ -230,6 +230,7 @@ interface(`auth_login_pgm_domain',`
+@@ -233,6 +233,7 @@ interface(`auth_login_pgm_domain',`
  		systemd_read_logind_state($1)
  		systemd_write_inherited_logind_sessions_pipes($1)
  		systemd_use_passwd_agent_fds($1)
@@ -37,7 +38,7 @@ index 82d3f6684..db1fcc344 100644
  ')
  
 diff --git a/policy/modules/system/systemd.fc b/policy/modules/system/systemd.fc
-index 505a054ff..e44d82a88 100644
+index dacf27a49..6622a1c74 100644
 --- a/policy/modules/system/systemd.fc
 +++ b/policy/modules/system/systemd.fc
 @@ -127,6 +127,7 @@ HOME_ROOT/.+\.home	--	gen_context(system_u:object_r:systemd_homed_storage_t,s0)
@@ -46,13 +47,13 @@ index 505a054ff..e44d82a88 100644
  /run/systemd/io\.systemd\.NamespaceResource	-s	gen_context(system_u:object_r:systemd_nsresourced_runtime_t,s0)
 +/run/systemd/io\.systemd\.Login	-s	gen_context(system_u:object_r:systemd_logind_runtime_t,s0)
  
- /run/tmpfiles\.d	-d	gen_context(system_u:object_r:systemd_tmpfiles_conf_t,s0)
- /run/tmpfiles\.d/.*		<<none>>
+ /run/sysctl\.d(/.*)?	gen_context(system_u:object_r:systemd_sysctl_runtime_t,s0)
+ 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index b67b78a69..cc57a29f4 100644
+index 3231f5c82..777376536 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -1601,6 +1601,26 @@ interface(`systemd_inherit_logind_fds',`
+@@ -1679,6 +1679,26 @@ interface(`systemd_inherit_logind_fds',`
  	allow systemd_logind_t $1:fd use;
  ')
  
@@ -79,6 +80,3 @@ index b67b78a69..cc57a29f4 100644
  ######################################
  ## <summary>
  ##      Watch logind sessions dirs.
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index 67a727b..06b5b62 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20260922+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "8f247dafb92bd12cbfb53a11ff58be17a88df86a"
+SRCREV_refpolicy = "c89bd1537a63c4a332945897fa34bed81f2921a3"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.43.0

