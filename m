Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20385.1794797803756046463
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 18:56:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wCHj9NscPpqa9QAAA--.933S3;
	Mon, 16 Nov 2026 10:54:36 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABn+WnccPpqPNA3AA--.14039S7;
	Mon, 16 Nov 2026 10:56:39 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [PATCH 5/6] refpolicy_common: use ??= for POLICY_BOOLEANS
Date: Mon, 16 Nov 2026 10:56:19 +0800
Message-ID: <20261116025620.2558594-6-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
References: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABn+WnccPpqPNA3AA--.14039S7
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYNCmr5ttwQhgAAsv
X-CM-DELIVERINFO: =?B?BNCAPac9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOBNkiu0Ezb1p2pGXeRzsQOMxYjOueDKtUdoWQlRhwX8fb0nd4pHWhteIJrZHQV4seFPO
	cY/ShaWwYz/MzElIRuN5aRBlGnxz2xTFyYapbkYP9Cckka7bXSkdtk1axUgKHA==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw4xJr45urW8JrWkKrW8KrX_yoWDZFb_Kr
	9Fv347Awn0yF4rGa1SyFyfJ3Wqv340kr4agr10ka4aq3s0ya1fKr4jq3WrCrW3JF15t3W7
	tFyagFy0kr17XosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjgY5I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVW8JbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
	A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
	0xZFpf9x07jUUUUUUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 02:56:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5403
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Let's use '??=' for POLICY_BOOLEANS in refpolicy_common.inc so that
refpolicy variants such as refpolicy-targeted could override to its
own default value via '?='. And users can easily override things via
'=' in conf files such as local.conf.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/refpolicy/refpolicy_common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index e6dac8e..4664a2f 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -123,7 +123,7 @@ POLICY_MCS_CATS ?= "1024"
 
 # Space-separated policy boolean/tunable settings in name=value format.
 # Values must be either true or false.
-POLICY_BOOLEANS ?= ""
+POLICY_BOOLEANS ??= ""
 
 EXTRA_OEMAKE = "NAME=${POLICY_NAME} \
     TYPE=${POLICY_TYPE} \
-- 
2.43.0

