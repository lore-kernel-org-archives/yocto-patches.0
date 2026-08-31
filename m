Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DE6C624A5
	for <webhook@archiver.kernel.org>; Mon, 31 Aug 2026 07:08:13 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24266.1788160086889162852
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 31 Aug 2026 00:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wBHQKM3KJVqC1AGAA--.24752S3;
	Mon, 31 Aug 2026 15:07:35 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowAB3+WnjJ5Vqc2QkAA--.64718S2;
	Mon, 31 Aug 2026 15:06:15 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH] refpolicy-targeted: remove useless POLICY_MLS_SENS setting
Date: Mon, 31 Aug 2026 15:07:53 +0800
Message-ID: <20260831070753.1435111-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowAB3+WnjJ5Vqc2QkAA--.64718S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYQCmqUMyEQdwACsU
X-CM-DELIVERINFO: =?B?CGFc75MTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ35Rt/fA/pqtc40DVWE/
	da9Au2knOD+lD9q//CttQet9umFb9LULN/QP8ywDf62Sc8BcAv8xrd6i8WM5Y1vmlA0/8P
	Wlg75PGDkEi+ps5CdwY+oTPXZcnMhOQcE+HQXwseiukbPNaKFaI1+7IwKsexVw==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw4rWFWDAw4xKF4xXr1DurX_yoWfXrXEgr
	WxZr9rAa15ZF48G3WIk34fGF1qvr1rKr1a9r10k34ag3s8Zr4fKrW5XFyrArWfJF15Xa1f
	GFyagFyjkry7GosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjgY5I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVW8CbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
	CTnIWIevJa73UjIFyTuYvjxU7NVyUUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 31 Aug 2026 07:08:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4720

From: Chen Qi <chenqi_hycx@cetc.com.cn>

When 'mcs' refpolicy type is used, the mls sens is hardcoded to 1.
See https://github.com/SELinuxProject/refpolicy/blob/main/policy/mcs#L7

So remove this POLICY_MLS_SENS as it's useless and misleading.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/refpolicy/refpolicy-targeted_git.bb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-security/refpolicy/refpolicy-targeted_git.bb b/recipes-security/refpolicy/refpolicy-targeted_git.bb
index 321407d..b4bec46 100644
--- a/recipes-security/refpolicy/refpolicy-targeted_git.bb
+++ b/recipes-security/refpolicy/refpolicy-targeted_git.bb
@@ -8,7 +8,6 @@ enabled. \
 
 POLICY_NAME = "targeted"
 POLICY_TYPE = "mcs"
-POLICY_MLS_SENS = "0"
 
 include refpolicy_${PV}.inc
 
-- 
2.43.0


