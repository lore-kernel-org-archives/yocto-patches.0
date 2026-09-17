Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C29C982C1
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 04:25:55 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32206.1789619151170416427
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 21:25:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wB3tXmYa6tqc7YCAA--.11009S3;
	Thu, 17 Sep 2026 12:24:57 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowAB3+WlKa6tq8iQ0AA--.49314S2;
	Thu, 17 Sep 2026 12:23:39 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 1/2] refpolicy_common.inc: default to deny for UNK_PERMS
Date: Thu, 17 Sep 2026 12:25:43 +0800
Message-ID: <20260917042544.3894019-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowAB3+WlKa6tq8iQ0AA--.49314S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYNCmqqnLARQwABs-
X-CM-DELIVERINFO: =?B?E51n2JMTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ35Rt/fA/pqtc40DVWE/
	da9DfcIMgI9r3HyMTpovPsIRAF/XyNd8M7CqIceRQhSajsxOdXPiAhbPI7MUKSqXvCZd/D
	iYjKSrxBvbulSWvU8wsmQddtpKV9fwzrtQZcq6LriukbPNaKFaI1+7IwKsexVw==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw4xGFWDXr43XF1xZrWDGFX_yoWkXFc_Kr
	9Fkr1UZay5AF4rKa1SvFyfZF1qv340gr4Sgw109342g34Yyw4fKr4qga1Y9FW3GF1Ygw48
	JFyagFy09r1avosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjgY5I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVW8XbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E
	87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4kE6xkIj40Ew7xC0wCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r1Y6r17MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZF
	pf9x07jwzV8UUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 17 Sep 2026 04:25:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4901

From: Chen Qi <chenqi_hycx@cetc.com.cn>

The default value for UNK_PERMS in refpolicy is "deny", which
means if refpolicy does not have classes/permissions that kernel
define, the related rules will be "denied".

This is a more reasonable default value as "allow" will cover
problems.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/refpolicy/refpolicy_common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 1d88557..8787797 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -108,7 +108,7 @@ DEFAULT_ENFORCING ??= "enforcing"
 POLICY_NAME ?= "${POLICY_TYPE}"
 POLICY_DISTRO ?= "debian"
 POLICY_UBAC ?= "n"
-POLICY_UNK_PERMS ?= "allow"
+POLICY_UNK_PERMS ?= "deny"
 POLICY_DIRECT_INITRC ?= "y"
 POLICY_SYSTEMD ?= "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'y', 'n', d)}"
 POLICY_MONOLITHIC ?= "n"
-- 
2.43.0


