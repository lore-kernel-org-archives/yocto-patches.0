Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE256C79FB6
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 02:43:10 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4991.1789008189389431586
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Sep 2026 19:43:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wDnsu4SGaJqSAMEAA--.14200S3;
	Thu, 10 Sep 2026 10:42:26 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowAB3+WnCGKJqxvQsAA--.25715S2;
	Thu, 10 Sep 2026 10:41:06 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 1/3] policycoreutils: split unsetfiles like other utilities
Date: Thu, 10 Sep 2026 10:42:59 +0800
Message-ID: <20260910024301.2228292-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowAB3+WnCGKJqxvQsAA--.25715S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYGCmqhYIQJyQAAsn
X-CM-DELIVERINFO: =?B?nBY535MTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ3KSwAYM2Ck2shLWqtE7
	j2j2jl+NKtdB4a/eTyJE34v+pdeUxWSENW1dD5BkiIgSIuZeJT32Ox5i6dh91O5+//PFps
	c/hJ37HSLjkksMBJnJyAKJ+OdsDSbV2MUzAl0f+fiukbPNaKFaI1+7IwKsexVw==
X-Coremail-Antispam: 1Uk129KBj93XoW7Jw4rGw4fAryUWr4fXF4kXwc_yoW8JrWkpF
	WYkFZrGry8XF1xJwsrCasFva409rZ5Cr47u395Wa4jk34UZr1DWw45Arya9FnxXF4xt3yI
	vwnFqrZ8Xa4kZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYh7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7UUUUUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Sep 2026 02:43:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4761

From: Chen Qi <chenqi_hycx@cetc.com.cn>

The `unsetfiles' was introduced in the 3.8 version[1].
We should split unsetfiles out into a separate package just like
other utilities.

[1] https://github.com/SELinuxProject/selinux/commit/0faf3433e87219b679e11a16d2483b1375e33510

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/selinux/policycoreutils_3.10.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-security/selinux/policycoreutils_3.10.bb b/recipes-security/selinux/policycoreutils_3.10.bb
index c2a3871..159a77e 100644
--- a/recipes-security/selinux/policycoreutils_3.10.bb
+++ b/recipes-security/selinux/policycoreutils_3.10.bb
@@ -70,6 +70,7 @@ PACKAGES =+ "\
     ${PN}-sestatus \
     ${PN}-setfiles \
     ${PN}-setsebool \
+    ${PN}-unsetfiles \
 "
 FILES:${PN}-fixfiles = "${base_sbindir}/fixfiles"
 FILES:${PN}-genhomedircon = "${base_sbindir}/genhomedircon"
@@ -103,6 +104,9 @@ FILES:${PN}-setsebool = "\
     ${base_sbindir}/setsebool \
     ${datadir}/bash-completion/completions/setsebool \
 "
+FILES:${PN}-unsetfiles = "\
+    ${base_sbindir}/unsetfiles \
+"
 
 export STAGING_INCDIR
 export STAGING_LIBDIR
-- 
2.43.0


