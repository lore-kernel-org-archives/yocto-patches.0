Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015C8C88E77
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 02:41:15 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14666.1789440070255596191
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 19:41:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wAnGBgUsKhqhnwBAA--.2587S3;
	Tue, 15 Sep 2026 10:40:20 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowABn6WnCr6hqV9kxAA--.38863S3;
	Tue, 15 Sep 2026 10:39:04 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 2/2] coreutils: enable selinux support for native variant
Date: Tue, 15 Sep 2026 10:41:00 +0800
Message-ID: <20260915024100.1955287-2-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915024100.1955287-1-chenqi_hycx@cetc.com.cn>
References: <20260915024100.1955287-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABn6WnCr6hqV9kxAA--.38863S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYLCmqn+AUJFAADsr
X-CM-DELIVERINFO: =?B?PTNITpMTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ3KSwAYM2Ck2shLWqtE7
	j2jxZbBKf/cx1n1ux+0lqoP+oog3WSbOcNoSsON5pZGOV3riuyPfPIiC+dX4iyBEpyOVGM
	nau1eBK2pe+WGmB8atJDWwIPEq2uL58Ef7JAmY/+iukbPNaKFaI1+7IwKsexVw==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw47trW7uw4UuF4DCFWxGrX_yoWfurb_tr
	1kKFyfArWrZFW2g3W7J3ZYq345C347ZF1rtw4Ik347Xry7Jrs8CrWDC3sava4xAFsI9rsx
	J3yv934Fg3Z5XosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjgY5I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVW8JbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4kE6xkIj40Ew7xC0wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1Y6r17MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jrIDwUUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 15 Sep 2026 02:41:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4849

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
index 74e22b3..21de5a7 100644
--- a/recipes-core/coreutils/coreutils_%.bbappend
+++ b/recipes-core/coreutils/coreutils_%.bbappend
@@ -1 +1,3 @@
 inherit ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'enable-selinux', '', d)}
+
+PACKAGECONFIG:class-native:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux', '', d)}"
-- 
2.43.0


