Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03CAC88E72
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 04:25:55 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32207.1789619151583301670
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 21:25:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wAX8iqba6tqdbYCAA--.3337S3;
	Thu, 17 Sep 2026 12:24:59 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowAB3+WlKa6tq8iQ0AA--.49314S3;
	Thu, 17 Sep 2026 12:23:40 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 2/2] selinux/refpolicy: introduce POLICY_VERSION variable
Date: Thu, 17 Sep 2026 12:25:44 +0800
Message-ID: <20260917042544.3894019-2-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917042544.3894019-1-chenqi_hycx@cetc.com.cn>
References: <20260917042544.3894019-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowAB3+WlKa6tq8iQ0AA--.49314S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYNCmqqnLARQwACs8
X-CM-DELIVERINFO: =?B?GLGWqJMTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ35Rt/fA/pqtc40DVWE/
	da9JlFras1e3sHCggBahZpux+1b0Nev5+nX7ufohTfnsYNOPPKigC0fm12/QmoFp4W1d/D
	iYjKSrxBvbulSWvU8wsyVOAVPAvUdQolaI7DcOkViukbPNaKFaI1+7IwKsexVw==
X-Coremail-Antispam: 1Uk129KBj93XoWxXw4DKry5Zr18WrWxAw1kJFc_yoW5AryDpF
	WjyF98AF1UXF18Wrn7CF1j93ZIqas8Ca1xu3yUGw4qkryDZF4kZw4jy3sxWFs3XryxXFWk
	Ar4aywsxGayUA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrDv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYT7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
	CTnIWIevJa73UjIFyTuYvjxUcsjjDUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 17 Sep 2026 04:25:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4902

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Introduce POLICY_VERSION which is used by refpolicy and semanage.
Previously, the recipes are just hardcoding '35'. Let's introduce
a new variable to put things in a common place and allow for user
configuration.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 conf/selinux_refpolicy_common.inc               | 2 ++
 recipes-security/refpolicy/refpolicy_common.inc | 4 +++-
 recipes-security/selinux/libsemanage_3.10.bb    | 2 +-
 recipes-security/selinux/selinux_common.inc     | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)
 create mode 100644 conf/selinux_refpolicy_common.inc

diff --git a/conf/selinux_refpolicy_common.inc b/conf/selinux_refpolicy_common.inc
new file mode 100644
index 0000000..2b0226a
--- /dev/null
+++ b/conf/selinux_refpolicy_common.inc
@@ -0,0 +1,2 @@
+# policy version used by refpolicy and semanage
+POLICY_VERSION ?= "35"
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 8787797..544769c 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -77,6 +77,8 @@ SRC_URI += " \
 
 S = "${UNPACKDIR}/refpolicy"
 
+require conf/selinux_refpolicy_common.inc
+
 CONFFILES:${PN} = "${sysconfdir}/selinux/config"
 
 POLICY_STORE_ROOT ?= "${localstatedir}/lib/selinux"
@@ -208,7 +210,7 @@ path = ${STAGING_DIR_NATIVE}${sbindir_native}/sefcontext_compile
 args = \$@
 [end]
 
-policy-version = 35
+policy-version = ${POLICY_VERSION}
 store-root = "${POLICY_STORE_ROOT}"
 EOF
 
diff --git a/recipes-security/selinux/libsemanage_3.10.bb b/recipes-security/selinux/libsemanage_3.10.bb
index 4a18fae..d499b19 100644
--- a/recipes-security/selinux/libsemanage_3.10.bb
+++ b/recipes-security/selinux/libsemanage_3.10.bb
@@ -52,7 +52,7 @@ do_install:append() {
 
     if [ -f "${conf_file}" ]; then
         # Update "policy-version" for semanage.conf
-        sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 35/' \
+        sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 ${POLICY_VERSION}/' \
             ${D}/etc/selinux/semanage.conf
 
         # Update "store-root" for semanage.conf
diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security/selinux/selinux_common.inc
index aaf0b90..6932fea 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -3,6 +3,8 @@ HOMEPAGE = "https://github.com/SELinuxProject"
 SRC_URI = "git://github.com/SELinuxProject/selinux.git;branch=main;protocol=https"
 SRCREV = "ca10fc4204ed60540d41d2499127c18ad0643f9e"
 
+require conf/selinux_refpolicy_common.inc
+
 S = "${UNPACKDIR}/${BP}/${BPN}"
 
 UPSTREAM_CHECK_GITTAGREGEX = "(?P<pver>\d+(\.\d+)+)"
-- 
2.43.0


