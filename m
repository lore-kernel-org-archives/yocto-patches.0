Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66FFC79FB6
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 02:38:40 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4888.1789007917144209483
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Sep 2026 19:38:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [101.95.142.114])
	by mtasvr (Coremail) with SMTP id _____wD3YvX6F6JqwAIEAA--.14413S3;
	Thu, 10 Sep 2026 10:37:47 +0800 (CST)
Received: from server-7r32.. (unknown [101.95.142.114])
	by front01 (Coremail) with SMTP id C6CowAB3+WmuF6JqIvQsAA--.25703S2;
	Thu, 10 Sep 2026 10:36:30 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 1/3] selinux-image.bbclass: fix selinux_set_labels
Date: Thu, 10 Sep 2026 10:38:23 +0800
Message-ID: <20260910023825.1829224-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowAB3+WmuF6JqIvQsAA--.25703S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYGCmqhYIQJowAAsN
X-CM-DELIVERINFO: =?B?jh/33ZMTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ3KSwAYM2Ck2shLWqtE7
	j2j3y1idtR2Omz1+d0wE13o2zMJuzzp3wYcoSA5ifANGjG0i5y4WIlgxu8IyCFR37wDB+R
	cvB7NDVKf9OPxAtslLwa/aXFoQFaGKBowG9kYuFoiukbPNaKFaI1+7IwKsexVw==
X-Coremail-Antispam: 1Uk129KBj93XoW7KrykAF4UWF4DKr4rGF1xWFX_yoW8CF18pa
	1vvr4ak3WrJF1fKrn7Aa42gFyFqrWkCas7W3sIkrW5Za4Ykr48Xr4qkw1avr47JrW7Jwsr
	Aa1rXFW7XFW8trgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4kE6xkIj40Ew7xC0wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1Y6r17MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jUCztUUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Sep 2026 02:38:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4759

From: Chen Qi <chenqi_hycx@cetc.com.cn>

1. The selinux_set_labels needs to be run before reproducible_final_image_task.
2. The ';' needs to be removed, as it's useless and it will prevent
   selinux_set_labels to have the correct function contents value,
   causing signature calculation not depending on the function's
   contents.
3. Add a bbnote to give users more information. The command is a
   key one, and it's useful that users know what is running.

Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 classes/selinux-image.bbclass | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/classes/selinux-image.bbclass b/classes/selinux-image.bbclass
index 852db5f..97ff99e 100644
--- a/classes/selinux-image.bbclass
+++ b/classes/selinux-image.bbclass
@@ -1,6 +1,7 @@
 selinux_set_labels() {
     if [ -f ${IMAGE_ROOTFS}/${sysconfdir}/selinux/config ]; then
         POL_TYPE=$(sed -n -e "s&^SELINUXTYPE[[:space:]]*=[[:space:]]*\([0-9A-Za-z_]\+\)&\1&p" ${IMAGE_ROOTFS}/${sysconfdir}/selinux/config)
+	bbnote "Running setfiles -m -r ${IMAGE_ROOTFS} ${IMAGE_ROOTFS}/${sysconfdir}/selinux/${POL_TYPE}/contexts/files/file_contexts ${IMAGE_ROOTFS}"
         if ! setfiles -m -r ${IMAGE_ROOTFS} ${IMAGE_ROOTFS}/${sysconfdir}/selinux/${POL_TYPE}/contexts/files/file_contexts ${IMAGE_ROOTFS}
         then
             bbwarn "Failed to set security contexts. Restoring security contexts will run on first boot."
@@ -19,7 +20,7 @@ python selinux_setlabels_handler() {
     if d.getVar('FIRST_BOOT_RELABEL') == '1':
         return
 
-    d.appendVar('IMAGE_PREPROCESS_COMMAND', ' selinux_set_labels; ')
+    d.prependVar('IMAGE_PREPROCESS_COMMAND', ' selinux_set_labels ')
     d.appendVarFlag('do_image', 'depends', ' policycoreutils-native:do_populate_sysroot')
 }
 
-- 
2.43.0


