Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E48BCA1013
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 15:49:30 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.138.1757000966696873262
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 08:49:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=13o1aB+8;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 69C1E1A0DD3
	for <yocto-patches@lists.yoctoproject.org>; Thu,  4 Sep 2025 15:49:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3EA34606C4;
	Thu,  4 Sep 2025 15:49:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F21A61C22D6B1;
	Thu,  4 Sep 2025 17:49:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757000964; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pT0KZ/1J7lSAu3A9i+mUiRxyUjhbCz+F9O0N2qpMeR0=;
	b=13o1aB+88i8K+mnCnQLDbONOqTsx87jCPpt2G9tBiGNUozs/js+RbkuavfZRWNKWgdHdDB
	VmOuT9HwrkF06m/amY3a2tBGOeJGBTnhbbJlrGE/pBXI2yVz8ohnAmRkslEyWzphsysptl
	4cmyTRSiQw2cNvzc9O0I0NHKYNyLkgTsK6vv8KJ2jncDDmkbkzdiVFAPxdtdHDOYW5ccpu
	L1sG/Vb5qwasEPsEpijtBCHcWZ8gUSSQJWhWQDELoCBlaE5kG9gNHhcgxB2ePpMdHu76+8
	pUE+Y7JFI/86L1WNWrCciB/Vlmq3nnRoF9ReTDqraHrNIiTqg5GlTxGqUcxu3w==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 04 Sep 2025 17:48:51 +0200
Subject: [PATCH yocto-autobuilder2 3/3] b4-config: Add basic b4
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-contrib-mathieu-build_props-v1-3-0ffaafcd01cb@bootlin.com>
References: <20250904-contrib-mathieu-build_props-v1-0-0ffaafcd01cb@bootlin.com>
In-Reply-To: <20250904-contrib-mathieu-build_props-v1-0-0ffaafcd01cb@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>, 
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757000954; l=604;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=yfS1+Wa11Hdc1MJgqAeYVSjlh4VQZMKghuCGC0i73nY=;
 b=IptunAJM5pc2V8b+ZKj9TL7zrJAwYQtZOJgEOzZT5dPJsiMsGnYkcimNmnDc4VteWP3hO3vj8
 4s+RXsr9hOUBv3o1dJoluyOSF+2yY/dyla6gGbVsQ2pS6bcWZWBer/e
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 15:49:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2134

Allow to easily prepare mail series with b4. Most of the configuration
was shamelessly stolen from openembedded-core git.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .b4-config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 000000000000..0f1f430c74f3
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,4 @@
+[b4]
+  send-series-to = yocto-patches@lists.yoctoproject.org
+  prep-pre-flight-checks = disable-needs-auto-to-cc, disable-needs-checking
+  send-prefixes = yocto-autobuilder2

-- 
2.39.5


