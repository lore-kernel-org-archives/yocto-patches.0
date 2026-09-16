Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15A7C88E7F
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 00:55:15 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4747.1789520107742088636
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Sep 2026 17:55:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wAnVnm46KlqqgoCAA--.8867S3;
	Wed, 16 Sep 2026 08:54:17 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowACnJ2hr6Klq9uIyAA--.29881S2;
	Wed, 16 Sep 2026 08:52:59 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH V2 1/2] layer.conf: add selinux to DISTRO_FEATURES_FILTER_NATIVE
Date: Wed, 16 Sep 2026 08:55:02 +0800
Message-ID: <20260916005503.2557329-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowACnJ2hr6Klq9uIyAA--.29881S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYMCmqpSYUFyAAAsA
X-CM-DELIVERINFO: =?B?0qU6VZMTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ3KSwAYM2Ck2shLWqtE7
	j2j/qzkynd06syThh9nJN+J1/I8lDFVjab5VC70l472RtUkTs9wnscIZ6uQnBXQwmFI/Rp
	2fX9xONTWPK2PWW6AVgT9Ipe6cwCLw4Bj1PwR3V6
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw47tF4xur1fGw4UtryUtwc_yoWDurgE9r
	WDKw1kZ3y5ZFy093W3JFn8Gr4fCryI9FyxG348t3s2vryUWw4FkanrGryjvw4xta1YvFsx
	WFyFga4j9r1UWosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjg05I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVWDYxn0WfASr-VF
	AUDa7-sFnT9fnUUIcSsGvfJTRUUUb4kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I
	8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVWDMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuY
	vjxU2aZXUUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 00:55:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4853

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Previously, no matter how you set DISTRO_FEATURES, it does not affect
native recipes regarding the selinux ditro feature. Add 'selinux' to
DISTRO_FEATURES_FILTER_NATIVE so that 'selinux' can be filtered into
native recipes' DISTRO_FEATURES.

This enables us to build selinux support for some native utilities,
notably coreutils-native.

This will also bring possible 'regressions' in case some recipes are
enabling selinux for native variable without testing it, e.g., ostree.
But these 'regressions' are really findings of errors of those recipes.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 conf/layer.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/layer.conf b/conf/layer.conf
index 245b4ef..172a1db 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -25,3 +25,5 @@ LAYERDEPENDS_selinux = " \
 "
 
 PREFERRED_PROVIDER_virtual/refpolicy ??= "refpolicy-targeted"
+
+DISTRO_FEATURES_FILTER_NATIVE:append = " selinux"
-- 
2.43.0


