Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F288FC79FB7
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 02:42:10 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4976.1789008124649182562
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Sep 2026 19:42:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wAnk_XSGKJqKAMEAA--.14316S3;
	Thu, 10 Sep 2026 10:41:22 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowABnmmqEGKJqrvQsAA--.24398S2;
	Thu, 10 Sep 2026 10:40:05 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH] packagegroup/selinux: require selinux-init only for sysvinit
Date: Thu, 10 Sep 2026 10:41:55 +0800
Message-ID: <20260910024155.2152398-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABnmmqEGKJqrvQsAA--.24398S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYGCmqhYikJuQAAs7
X-CM-DELIVERINFO: =?B?UXQXiZMTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ35Rt/fA/pqtc40DVWE/
	da9PezmXvgticv2pkik17FmtsBS2yEQx6a1mejkr4hAG7NNVN+ic1qaqq7Q0stSplSpJOW
	qeiZM8J4FGxmfENulMQ8cvHPqsEIIq1Anf6Y6zVm
X-Coremail-Antispam: 1Uk129KBj93XoW7KrykXrWfXw1xuFW8Gry3trc_yoW8Cr4Upr
	sFyF1UJr10gFy8Xrnru3W2gw4ruFWrCa4UA345Ka48tFn8ur18XF9rWF45GFZrXF13Z3W8
	A3WY93yDKaykXagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYc7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxUzlksDUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Sep 2026 02:42:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4760

From: Chen Qi <chenqi_hycx@cetc.com.cn>

The selinux-init for systemd is quite misleading. systemd itself
can load selinux policies. Extra userspace tools are not needed
for systemd.

In fact, the init script does nothing but only checks some tools.
And the result can be misleading as these tool are not necessary
for systemd.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/packagegroups/packagegroup-core-selinux.bb    | 2 +-
 recipes-security/packagegroups/packagegroup-selinux-minimal.bb | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-security/packagegroups/packagegroup-core-selinux.bb b/recipes-security/packagegroups/packagegroup-core-selinux.bb
index 148c8a2..b5dc1e4 100644
--- a/recipes-security/packagegroups/packagegroup-core-selinux.bb
+++ b/recipes-security/packagegroups/packagegroup-core-selinux.bb
@@ -20,7 +20,7 @@ RDEPENDS:${PN} = " \
 	setools \
 	setools-console \
 	selinux-autorelabel \
-	selinux-init \
+	${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'selinux-init', '', d)} \
 	selinux-labeldev \
 	refpolicy \
 	coreutils \
diff --git a/recipes-security/packagegroups/packagegroup-selinux-minimal.bb b/recipes-security/packagegroups/packagegroup-selinux-minimal.bb
index f06b183..b8e2825 100644
--- a/recipes-security/packagegroups/packagegroup-selinux-minimal.bb
+++ b/recipes-security/packagegroups/packagegroup-selinux-minimal.bb
@@ -20,7 +20,7 @@ RDEPENDS:${PN} = "\
 	policycoreutils-sestatus \
 	policycoreutils-setfiles \
 	selinux-autorelabel \
-	selinux-init \
+	${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'selinux-init', '', d)} \
 	selinux-labeldev \
 	refpolicy \
 "
-- 
2.43.0


