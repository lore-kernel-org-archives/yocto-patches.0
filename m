Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17642C5DF6D
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 06:09:22 +0000 (UTC)
Received: from cetci.com.cn (cetci.com.cn [220.181.78.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1206.1787119757229214745
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Aug 2026 23:09:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.78.204, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.198])
	by mtasvr (Coremail) with SMTP id _____wAXAWN6SIVqRbkAAA--.3827S3;
	Wed, 19 Aug 2026 14:08:59 +0800 (CST)
Received: from chenqi-Matebook14.. (unknown [123.125.172.198])
	by front01 (Coremail) with SMTP id C6CowACnJ2gsSIVqwj4QAA--.10209S2;
	Wed, 19 Aug 2026 14:07:43 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH] selinux-image.bbclass: fix selinux_set_labels
Date: Wed, 19 Aug 2026 14:08:57 +0800
Message-ID: <20260819060857.274091-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowACnJ2gsSIVqwj4QAA--.10209S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYECmqEYRYPTAABsS
X-CM-DELIVERINFO: =?B?zlQd/5MTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ35Rt/fA/pqtc40DVWE/
	da9DFuAIZ/qTrE0jX7KAvClOFz9Y8Hb+NgtD9Wfe56IAC345v2KWabDcZNTkJbv8sMwEJh
	JBo8l58W71Kb9ZhHHtZd/H1izO0p69zfX0t33+GV
X-Coremail-Antispam: 1Uk129KBj93XoW7KrykAF4UWF4DKr4rGF1xWFX_yoW8CF18pa
	1vvr4ak3WrJF1fKrn7Aa42gFyFqrWkCas7W3sIkrW5Za4Ykr48Xr4qkw1avr47JrW7Jwsr
	Aa1rXFW7XFW8trgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GFUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYz7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIF
	yTuYvjxU2eMNUUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Aug 2026 06:09:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4674

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


