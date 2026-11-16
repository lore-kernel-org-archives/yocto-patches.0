Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20393.1794797855624434548
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 18:57:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wC3rbCacPpqhtQAAA--.912S3;
	Mon, 16 Nov 2026 10:55:22 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowAB3umoScfpqcNA3AA--.13220S2;
	Mon, 16 Nov 2026 10:57:22 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [PATCH 6/6] refpolicy-targeted: allow ssh_sysadm_login by default
Date: Mon, 16 Nov 2026 10:57:14 +0800
Message-ID: <20261116025714.2558951-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowAB3umoScfpqcNA3AA--.13220S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYNCmr5tRgQNgAAsb
X-CM-DELIVERINFO: =?B?CbqBJKc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoONahKFcN3sR551ZGDSnKFd9i0T6pGC08Xw7uUtzS3miiAjbl+DknbSKnvAtVxjrlZ7iG
	q2n8NxEkW6588qFF1gyvoKZCNGM4BpGFYvUeMAH/q5kRIfSAfxVdrEVE0OP7CA==
X-Coremail-Antispam: 1Uk129KBj93XoW7KrykXrykZw1rCFW8Ww1fKrX_yoW8JFW7pr
	WrtayYyF1xXFyxCw17C3WFgr17ta45Cr4UZayUGw18Aan8ZF4DCw4rW343WFs5ur43JrZ2
	vF43Z3y3Wa1UJrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYc7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4kE6xkIj40Ew7xC0wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1Y6r17MIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjxU7UUUUUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 02:57:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5404
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

The targeted repolicy is a looser policy than standard/mcs/mls
variants. What surprises users is that a looser repolicy does not
allow ssh login while the sticter ones do.

This is because Yocto's targeted policy is making users land in
unconfined_u selinux user by default, and unconfined_u is treated
as privileged user, thus being forbidden by default as the default
value of ssh_sysadm_login is false.

Change to enable ssh_sysadm_login for targeted thus minimal by
default.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/refpolicy/refpolicy-targeted_git.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/refpolicy/refpolicy-targeted_git.bb b/recipes-security/refpolicy/refpolicy-targeted_git.bb
index b4bec46..32457f1 100644
--- a/recipes-security/refpolicy/refpolicy-targeted_git.bb
+++ b/recipes-security/refpolicy/refpolicy-targeted_git.bb
@@ -15,3 +15,5 @@ SRC_URI += " \
         file://0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch \
         file://0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch \
         "
+
+POLICY_BOOLEANS ?= "ssh_sysadm_login=true"
-- 
2.43.0

