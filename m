Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78F2C79FB7
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 02:38:40 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4887.1789007913428856018
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Sep 2026 19:38:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wAnk_X7F6JqwQIEAA--.14310S3;
	Thu, 10 Sep 2026 10:37:47 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowAB3+WmuF6JqIvQsAA--.25703S3;
	Thu, 10 Sep 2026 10:36:31 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 2/3] selinux-autorelabel: do not carry /.autorelabel
Date: Thu, 10 Sep 2026 10:38:24 +0800
Message-ID: <20260910023825.1829224-2-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910023825.1829224-1-chenqi_hycx@cetc.com.cn>
References: <20260910023825.1829224-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowAB3+WmuF6JqIvQsAA--.25703S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYGCmqhYikJngAAsc
X-CM-DELIVERINFO: =?B?RLeUbZMTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ35Rt/fA/pqtc40DVWE/
	da9NrDgnUo58seCGLhs610EbGR2RUZuMZKVhqpYwhvLZcad02lOBrdLF852MPSyKjO1B+R
	cvB7NDVKf9OPxAtslLxtxN/ZClDmUIbyb4saWZoUiukbPNaKFaI1+7IwKsexVw==
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWUCFWUKF4DKrW8uF1Dtwc_yoW8CF4rpF
	ZIya1UXa4xJa4xZrnrCF40gF45XFZ8Ca4fu3yUKayjyry8Zw4kWrsrAFy5GFZ0qF48JF18
	Ars3t398u3yDGrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	GVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4kE6xkIj40Ew7xC0wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1Y6r17MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jjApnUUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Sep 2026 02:38:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4757

From: Chen Qi <chenqi_hycx@cetc.com.cn>

It's just logically wrong that a package carries /.autorelabel file.
This is because installing this package causes the whole system to
autorelabel. Besides, this /.autorelabel file is really an admin file
that should be managed at rootfs or target runtime.

We should let selinux-image.bbclass to handle this file.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 recipes-security/selinux-scripts/selinux-autorelabel_0.1.bb | 6 ------
 recipes-security/selinux-scripts/selinux-initsh.inc         | 2 --
 2 files changed, 8 deletions(-)

diff --git a/recipes-security/selinux-scripts/selinux-autorelabel_0.1.bb b/recipes-security/selinux-scripts/selinux-autorelabel_0.1.bb
index 9fd066c..c6eefbe 100644
--- a/recipes-security/selinux-scripts/selinux-autorelabel_0.1.bb
+++ b/recipes-security/selinux-scripts/selinux-autorelabel_0.1.bb
@@ -18,9 +18,3 @@ SRC_URI = "file://${BPN}.sh \
 INITSCRIPT_PARAMS = "start 01 S ."
 
 require selinux-initsh.inc
-
-do_install:append() {
-    if ${@bb.utils.contains('FIRST_BOOT_RELABEL', '1', 'true', 'false', d)}; then
-        echo "# first boot relabelling" > ${D}/.autorelabel
-    fi
-}
diff --git a/recipes-security/selinux-scripts/selinux-initsh.inc b/recipes-security/selinux-scripts/selinux-initsh.inc
index 1fc1ec1..7fbb650 100644
--- a/recipes-security/selinux-scripts/selinux-initsh.inc
+++ b/recipes-security/selinux-scripts/selinux-initsh.inc
@@ -18,8 +18,6 @@ inherit update-rc.d systemd
 
 SYSTEMD_SERVICE:${PN} = "${SELINUX_SCRIPT_SRC}.service"
 
-FILES:${PN} += "/.autorelabel"
-
 do_install () {
 	install -d ${D}${sysconfdir}/init.d/
 	install -m 0755 ${S}/${SELINUX_SCRIPT_SRC}.sh ${D}${sysconfdir}/init.d/${SELINUX_SCRIPT_DST}
-- 
2.43.0


