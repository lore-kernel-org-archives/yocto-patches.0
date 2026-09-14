Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15812C88E64
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 06:41:57 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14449.1789368113587096065
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 13 Sep 2026 23:41:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wDXFXr8lqdqBw8BAA--.5659S3;
	Mon, 14 Sep 2026 14:41:01 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowABn6Wmwlqdqt+UwAA--.35924S2;
	Mon, 14 Sep 2026 14:39:44 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH] policycoreutils: remove confusing RDEPENDS class-target override
Date: Mon, 14 Sep 2026 14:41:45 +0800
Message-ID: <20260914064145.3572321-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABn6Wmwlqdqt+UwAA--.35924S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYKCmqmqC0YVAAAsC
X-CM-DELIVERINFO: =?B?muLTqpMTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ35Rt/fA/pqtc40DVWE/
	da9Kg/OsCThdnCeD6f53W6EdgOmPHgPN/K/jZ5bf5Qr1zGr6odEQbpC0ywp6qRkQ7tAYTr
	oQ1jNB9BIZ0JHIZ/xBOVHdRWdu3pqZY7pyRVT130iukbPNaKFaI1+7IwKsexVw==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw47WryUCr48Jw45JF4DZFc_yoWkGrb_GF
	yku3WDJr48ZF4rt3WxAFnayrZ3Z34xuFWagryFqrn7t34xJws8G3y8Xas3Za47AFsFqrsx
	GasxWa4jgw4YgosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjgY5I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVW8AbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIF
	yTuYvjxU4J5rDUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 06:41:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4826

From: Chen Qi <chenqi_hycx@cetc.com.cn>

This setting was there since the born of the recipe. But in actual
fact the utilities are mostly written in C. Such RDEPENDS is not
necessary. What's more confusing is that such dependency is only
for target.

Remove this setting. If it turns out some utility *really* needs
selinux-python, we should set its own RDEPENDS.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/selinux/policycoreutils_3.10.bb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-security/selinux/policycoreutils_3.10.bb b/recipes-security/selinux/policycoreutils_3.10.bb
index 42b4666..64b8049 100644
--- a/recipes-security/selinux/policycoreutils_3.10.bb
+++ b/recipes-security/selinux/policycoreutils_3.10.bb
@@ -56,7 +56,6 @@ RDEPENDS:${PN}-setsebool = "\
     libselinux \
     libsemanage \
 "
-RDEPENDS:${PN}:class-target = "selinux-python"
 
 # The purpose of the following settings is to split out each utility
 # into its own package and make the main package, policycoreutils, an
-- 
2.43.0


