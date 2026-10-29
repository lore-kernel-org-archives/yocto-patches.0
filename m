Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5537.1793252232420780446
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 22:37:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wAnULgX2+JqjV8AAA--.71S3;
	Thu, 29 Oct 2026 13:35:20 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowACXKWq52uJqDCAnAA--.25245S2;
	Thu, 29 Oct 2026 13:33:57 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][PATCH] libselinux/libselinux-python/setools: fix LICENSE warnings
Date: Thu, 29 Oct 2026 13:36:40 +0800
Message-ID: <20261029053640.2130457-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowACXKWq52uJqDCAnAA--.25245S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYPCmrh+hMRJwAAsV
X-CM-DELIVERINFO: =?B?U88yW6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOKAVCGp4YV81L5jQR5ux1riq/5GC+s1JOIFTYofx0I6vq8tjrqd/a2OjI7cUyzdxYcs2
	A7LDET5Am5LbDMRgZ3XWSlDLK2EIw4EUErRjv2ncsdMse0qDliarKWsmUSHd1Q==
X-Coremail-Antispam: 1Uk129KBj93XoWxCw1fZry3ZF45Xw4kWrykJFc_yoW5WF43pF
	sxtFWUJr48J3WrWwn7C3WqgF48Was5CFWxCrWrW3Wjvas8urn7Xw4qkry3Kr1aqrnrAr40
	v3y7J39xWa4kC3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrJv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7IU8Odb5UUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Oct 2026 05:37:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5181
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Convert legacy LICENSE expressions to SPDX expressions to avoid
the following warnings:

  WARNING: libselinux: LICENSE is using an old syntax and should be upgraded to: "LicenseRef-PD"
  WARNING: libselinux-python: LICENSE is using an old syntax and should be upgraded to: "LicenseRef-PD"
  WARNING: setools: LICENSE is using an old syntax and should be upgraded to: "GPL-2.0-only AND LGPL-2.1-only"

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/selinux/libselinux-python_3.10.bb | 2 +-
 recipes-security/selinux/libselinux_3.10.bb        | 2 +-
 recipes-security/setools/setools_4.6.0.bb          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-security/selinux/libselinux-python_3.10.bb b/recipes-security/selinux/libselinux-python_3.10.bb
index e0fcb4b..01b7b93 100644
--- a/recipes-security/selinux/libselinux-python_3.10.bb
+++ b/recipes-security/selinux/libselinux-python_3.10.bb
@@ -3,7 +3,7 @@ DESCRIPTION = "libselinux provides an API for SELinux applications to get and se
 process and file security contexts and to obtain security policy \
 decisions.  Required for any applications that use the SELinux API."
 SECTION = "base"
-LICENSE = "PD"
+LICENSE = "LicenseRef-PD"
 LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=84b4d2c6ef954a2d4081e775a270d0d0"
 
 require selinux_common.inc
diff --git a/recipes-security/selinux/libselinux_3.10.bb b/recipes-security/selinux/libselinux_3.10.bb
index 24956ae..98fc5c8 100644
--- a/recipes-security/selinux/libselinux_3.10.bb
+++ b/recipes-security/selinux/libselinux_3.10.bb
@@ -3,7 +3,7 @@ DESCRIPTION = "libselinux provides an API for SELinux applications to get and se
 process and file security contexts and to obtain security policy \
 decisions.  Required for any applications that use the SELinux API."
 SECTION = "base"
-LICENSE = "PD"
+LICENSE = "LicenseRef-PD"
 LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=84b4d2c6ef954a2d4081e775a270d0d0"
 
 require selinux_common.inc
diff --git a/recipes-security/setools/setools_4.6.0.bb b/recipes-security/setools/setools_4.6.0.bb
index 1c8bc79..f458e90 100644
--- a/recipes-security/setools/setools_4.6.0.bb
+++ b/recipes-security/setools/setools_4.6.0.bb
@@ -3,7 +3,7 @@ DESCRIPTION = "\
 SETools is a collection of graphical tools, command-line tools, and \
 libraries designed to facilitate SELinux policy analysis."
 SECTION = "base"
-LICENSE = "GPL-2.0-only & LGPL-2.1-only"
+LICENSE = "GPL-2.0-only AND LGPL-2.1-only"
 
 SRC_URI = "git://github.com/SELinuxProject/${BPN}.git;branch=4.6;protocol=https \
            file://setools4-fixes-for-cross-compiling.patch \
-- 
2.43.0

