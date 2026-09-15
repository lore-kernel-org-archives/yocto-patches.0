Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA827C88E75
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 02:24:14 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14507.1789439045455630830
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 19:24:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wCn5XkRrKhqnHkBAA--.6927S3;
	Tue, 15 Sep 2026 10:23:13 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowABn6WnBq6hqitQxAA--.38802S3;
	Tue, 15 Sep 2026 10:21:56 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 2/2] policycoreutils: remove confusing RDEPENDS class-target override
Date: Tue, 15 Sep 2026 10:23:55 +0800
Message-ID: <20260915022355.646123-2-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915022355.646123-1-chenqi_hycx@cetc.com.cn>
References: <20260915022355.646123-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABn6WnBq6hqitQxAA--.38802S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYLCmqn+a4I9gAAsi
X-CM-DELIVERINFO: =?B?/GYHlpMTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ35Rt/fA/pqtc40DVWE/
	da9B1iDYHXXey+SyDVN7T94vrMOr6Vm236Fnr/Uoh/i9iZS+MJWu4pxVDmJBun8h8gG8dB
	N4gbn21pf9MjwqOTCwN6dj3+cddD731fjqDOEES0iukbPNaKFaI1+7IwKsexVw==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw47WryUCr48Jw45JF4DZFc_yoWkGrb_GF
	yku3WDJr48ZF4rt3WxAFnayrZ3Z34xuFWagryFqrn7t34xJws8G3y8Xas3Za47AFsFqrsx
	GasxWa4jgw4YgosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjgY5I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVW8JbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
	6r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
	A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI
	43ZEXa7IU8StC5UUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 15 Sep 2026 02:24:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4847

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


