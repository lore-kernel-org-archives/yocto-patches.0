Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13900.1793940889061132011
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Nov 2026 20:54:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wC3StUjXe1qp5oDAA--.14343S3;
	Fri, 06 Nov 2026 12:52:51 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADnd2jIXO1qmt8tAA--.32741S3;
	Fri, 06 Nov 2026 12:51:27 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][wrynose][PATCH 2/5] refpolicy-targeted: remove useless POLICY_MLS_SENS setting
Date: Fri,  6 Nov 2026 12:54:22 +0800
Message-ID: <20261106045426.2536283-2-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106045426.2536283-1-chenqi_hycx@cetc.com.cn>
References: <20261106045426.2536283-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowADnd2jIXO1qmt8tAA--.32741S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYDCmrshhUP1QABsD
X-CM-DELIVERINFO: =?B?gH/lWKc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOIpW4/8Z0l7A1TJMY5S9w3rj0zZ2UiiD53z9UYf7+qMfmnGKwbf1rq6ZfoZjCF6R6xzG
	9EUfGCWCAxr+aH5IvFNeZhTX8ruIa9FiLn52svHMF2RcGoVNkVWldaT/xEH8iA==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw4rWFWDAw4xKF4xXr1DurX_yoWfXrXEgr
	WxZr9rAa15ZF48G3WIk34fGF1qvr1rKr1a9r10k34ag3s8Zr4fKrW5XFyrArWfJF15Xa1f
	GFyagFyjkry7GosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjgY5I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVW8XbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E
	87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWU
	XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4kE6xkIj40Ew7xC0wCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
	daVFxhVjvjDU0xZFpf9x07jYv38UUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Nov 2026 04:54:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5247
Content-Type: text/plain; charset="utf-8"

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

