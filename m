Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDD7C79FB6
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 02:43:20 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4994.1789008193247051840
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Sep 2026 19:43:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wDnUvUTGaJqSQMEAA--.14334S3;
	Thu, 10 Sep 2026 10:42:27 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowAB3+WnCGKJqxvQsAA--.25715S3;
	Thu, 10 Sep 2026 10:41:11 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 2/3] policycoretuils: allow an empty main package which pull in other packages
Date: Thu, 10 Sep 2026 10:43:00 +0800
Message-ID: <20260910024301.2228292-2-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910024301.2228292-1-chenqi_hycx@cetc.com.cn>
References: <20260910024301.2228292-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowAB3+WnCGKJqxvQsAA--.25715S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYGCmqhYikJvgAAs8
X-CM-DELIVERINFO: =?B?vKEkB5MTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ35Rt/fA/pqtc40DVWE/
	da9EQ53lJx/wreqnqnBYKs/9lKmj5e9qW6NX8u6SQvywP/mCXWtsHpfQ2H4DeKTUlSa1ps
	c/hJ37HSLjkksMBJnJy7WAwiRr8B7vp0jHzPMzxLiukbPNaKFaI1+7IwKsexVw==
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWUXrWkArWUWr45tFW8AFc_yoW8XrW7pr
	WayFZxJw10gFyxGwnrCa1293WYg398Cw4rZ3ykWa4Ykwn8Jr4UWwsxJr109F9xWF1ft3y0
	vrnFqrZ3G3yUZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY47kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU8svttUUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Sep 2026 02:43:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4763

From: Chen Qi <chenqi_hycx@cetc.com.cn>

It's more reasonable to allow and empty main package just like util-linux.
In this way, people can just install policycoreutils and it will pull
in other splitted packages.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/selinux/policycoreutils_3.10.bb | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/recipes-security/selinux/policycoreutils_3.10.bb b/recipes-security/selinux/policycoreutils_3.10.bb
index 159a77e..42b4666 100644
--- a/recipes-security/selinux/policycoreutils_3.10.bb
+++ b/recipes-security/selinux/policycoreutils_3.10.bb
@@ -58,7 +58,10 @@ RDEPENDS:${PN}-setsebool = "\
 "
 RDEPENDS:${PN}:class-target = "selinux-python"
 
-PACKAGES =+ "\
+# The purpose of the following settings is to split out each utility
+# into its own package and make the main package, policycoreutils, an
+# empty package that could be used to introuduce all these utilities.
+POLICYCOREUTILS_PACKAGES = "\
     ${PN}-fixfiles \
     ${PN}-genhomedircon \
     ${PN}-hll \
@@ -72,6 +75,10 @@ PACKAGES =+ "\
     ${PN}-setsebool \
     ${PN}-unsetfiles \
 "
+PACKAGES =+ "${POLICYCOREUTILS_PACKAGES}"
+ALLOW_EMPTY:${PN} = "1"
+RDEPENDS:${PN} += "${POLICYCOREUTILS_PACKAGES}"
+
 FILES:${PN}-fixfiles = "${base_sbindir}/fixfiles"
 FILES:${PN}-genhomedircon = "${base_sbindir}/genhomedircon"
 FILES:${PN}-loadpolicy = "\
-- 
2.43.0


