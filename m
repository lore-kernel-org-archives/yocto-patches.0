Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F84C79FBF
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 02:43:20 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4993.1789008190964938436
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Sep 2026 19:43:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wAnOOwUGaJqSgMEAA--.13430S3;
	Thu, 10 Sep 2026 10:42:28 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowAB3+WnCGKJqxvQsAA--.25715S4;
	Thu, 10 Sep 2026 10:41:12 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 3/3] packagegroup-selinux-policycoreutils: use policycoreutils instead of listing each utility
Date: Thu, 10 Sep 2026 10:43:01 +0800
Message-ID: <20260910024301.2228292-3-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910024301.2228292-1-chenqi_hycx@cetc.com.cn>
References: <20260910024301.2228292-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowAB3+WnCGKJqxvQsAA--.25715S4
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYGCmqhYikJvgABs9
X-CM-DELIVERINFO: =?B?AmaNFJMTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ35Rt/fA/pqtc40DVWE/
	da9NEcJqLukKXDsgG+b3TZy6kTC2V6bOT/sFQnwJmxVQQJ9AZX9H2/FdDAZduNd72Io1ps
	c/hJ37HSLjkksMBJnJzN03SMMMfacyr/3dOLW12iiukbPNaKFaI1+7IwKsexVw==
X-Coremail-Antispam: 1Uk129KBj93XoW7KrykuF15Cw1DZw1rKw45Jwc_yoW8XF1kpr
	ZIkr9xZr10gryUJws7CFy2qasYqa4UCaykXFy3G3Wj9r18Jr4jk393JF45Cr97uFy7t3yj
	vrnakFZrJFyqq3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY47kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l
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
	nUUI43ZEXa7IU8LjjDUUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Sep 2026 02:43:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4762

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Besides the newly added `unsetfiles', this packagegroup is using all
utilities from policycoreutils. As we have now changed policycoreutils
to use the empty main package to pull in all its utilities, we can
just use policycoreutils here to simplifies and and to adapt to future
policycoreutils upstream changes.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 .../packagegroup-selinux-policycoreutils.bb          | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/recipes-security/packagegroups/packagegroup-selinux-policycoreutils.bb b/recipes-security/packagegroups/packagegroup-selinux-policycoreutils.bb
index 7fd5d1c..2654701 100644
--- a/recipes-security/packagegroups/packagegroup-selinux-policycoreutils.bb
+++ b/recipes-security/packagegroups/packagegroup-selinux-policycoreutils.bb
@@ -9,17 +9,7 @@ PACKAGES = "\
 ALLOW_EMPTY:${PN} = "1"
 
 RDEPENDS:${PN} = "\
-	policycoreutils-fixfiles \
-	policycoreutils-genhomedircon \
-	policycoreutils-loadpolicy \
-	policycoreutils-newrole \
-	policycoreutils-runinit \
-	policycoreutils-secon \
-	policycoreutils-semodule \
-	policycoreutils-sestatus \
-	policycoreutils-setfiles \
-	policycoreutils-setsebool \
-	policycoreutils-hll \
+	policycoreutils \
 	semodule-utils-semodule-expand \
 	semodule-utils-semodule-link \
 	semodule-utils-semodule-package \
-- 
2.43.0


