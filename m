Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C131DCFD342
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 18:35:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24051.1764009341681156402
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Nov 2025 10:35:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BD281477;
	Mon, 24 Nov 2025 10:35:33 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79BDC3F86F;
	Mon, 24 Nov 2025 10:35:40 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: bruce.ashfield@gmail.com
Subject: [PATCH kernel-module-hello-world 1/2] hello-world: some cleanups
Date: Mon, 24 Nov 2025 18:35:33 +0000
Message-ID: <20251124183534.870124-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 18:35:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2700

No need to include linux/init.h as module.h does this.

Set the author to a real name for clarity.

Print the filename of the module to verify that path remapping is
working if specified.

Fix a typo in the comments.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 hello-world.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hello-world.c b/hello-world.c
index 8ca2dc6..9c22cde 100644
--- a/hello-world.c
+++ b/hello-world.c
@@ -7,27 +7,26 @@
  *
  *
  */
-#include <linux/init.h>
 #include <linux/module.h>
=20
=20
 /* See module.h for additional #defines you may want to customize*/
 MODULE_LICENSE("Dual MIT/GPL"); /* See module.h for acceptable options *=
/
-MODULE_AUTHOR("Homer Simpson");
+MODULE_AUTHOR("Mark Asselstine");
 MODULE_DESCRIPTION("A hello-world kernel module");
 MODULE_VERSION("0.1");
=20
 /* Initialize the module, called when first loaded */
 static int __init hello_world_init(void) {
   /* print "Hello World" to the dmesg on module load */
-  printk(KERN_INFO "Hello World\n");
+  printk(KERN_INFO "Hello World from " __FILE__ "\n");
=20
   return 0;
 }
=20
 /* Last call before module unload, complete any cleanup */
 static void __exit hello_world_exit(void) {
-  /* print "Goodby World" to the dmesg on module unload */
+  /* print "Goodbye World" to the dmesg on module unload */
   printk(KERN_INFO "Goodbye World\n");
 }
=20
--=20
2.43.0


