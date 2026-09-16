Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F2EC88E77
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 00:55:15 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4765.1789520107468457244
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Sep 2026 17:55:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wCHjyu46KlqrwoCAA--.4232S3;
	Wed, 16 Sep 2026 08:54:16 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowACnJ2hr6Klq9uIyAA--.29881S3;
	Wed, 16 Sep 2026 08:53:00 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH V2 2/2] coreutils: enable selinux support for native variant
Date: Wed, 16 Sep 2026 08:55:03 +0800
Message-ID: <20260916005503.2557329-2-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916005503.2557329-1-chenqi_hycx@cetc.com.cn>
References: <20260916005503.2557329-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowACnJ2hr6Klq9uIyAA--.29881S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYMCmqpSYUFyAABsB
X-CM-DELIVERINFO: =?B?qOF9hJMTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ3KSwAYM2Ck2shLWqtE7
	j2jwueHYRQG94FH1DGleTlu27/HfVbFeVh3A9IuqMBDuuDKHm3qHA7r7eqbQwLO4wNF/Rp
	2fX9xONTWPK2PWW6AVigIkImTZXRv2O7Q7dOiQWg
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw47trW7uw4UuF4DCFWxGrX_yoWfCFc_tr
	1DKFyfArWrAF42g3W7JFnYq345C347ZF1rtw4Ik347Zry7Jrs8urWDCrySva48AFs09rsx
	Jayv934Fg3Z5WosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjg05I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVWDYxn0WfASr-VF
	AUDa7-sFnT9fnUUIcSsGvfJTRUUUb4kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I
	8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVWDMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuY
	vjxUx038UUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 00:55:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4852

From: Chen Qi <chenqi_hycx@cetc.com.cn>

It's really a common task to check selinux labels for rootfs to ensure
that files are labelled correctly. To do this, coreutils-native
needs to have libselinux linked to make commands such as 'ls -Z' work
as expected.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-core/coreutils/coreutils_%.bbappend | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-core/coreutils/coreutils_%.bbappend b/recipes-core/coreutils/coreutils_%.bbappend
index 74e22b3..09c7021 100644
--- a/recipes-core/coreutils/coreutils_%.bbappend
+++ b/recipes-core/coreutils/coreutils_%.bbappend
@@ -1 +1,3 @@
 inherit ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'enable-selinux', '', d)}
+
+PACKAGECONFIG:class-native:append = " ${@bb.utils.filter('DISTRO_FEATURES', 'selinux', d)}"
-- 
2.43.0


