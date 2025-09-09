Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FA1CAC58E
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 14:31:24 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.15037.1757428275732650456
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 07:31:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=e+Jzwxbb;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2A8CE1A0984
	for <yocto-patches@lists.yoctoproject.org>; Tue,  9 Sep 2025 14:31:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0501760630;
	Tue,  9 Sep 2025 14:31:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27F8A102F2888;
	Tue,  9 Sep 2025 16:31:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757428273; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pT0KZ/1J7lSAu3A9i+mUiRxyUjhbCz+F9O0N2qpMeR0=;
	b=e+Jzwxbb112QNSw2L59XvAJQIwHB5ZbCf7Gdo3Rlh0G1b+HXbMl2GFwN6GWhj/GDk5p7Ig
	CMthxYX9Q85SAfab/WMlVXnANEBCfkfVgqauo8YOc2XEPY4XdSUyHp/ee73ab0dTAJ8zkc
	x8tH51KwQnnR5NUJ+wjD1e4C+DulVidCHSr2Uk8AiaHDNmTBakmFFCeZWuqmAahhrlUKZy
	3S9mD5e0EGNyAiSVFsHuR9Ga2opODBNP4RagATqqVAh5h3q5vmCn7CsNl+xzRy/n4gMcKa
	UfcY6GRACI6Rzj6eIBpEiV0cauXaNr4I4KAjojUQhwVEW6x+9x7SggmO1HWcxQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 09 Sep 2025 16:31:05 +0200
Subject: [PATCH yocto-autobuilder2 v2 3/3] b4-config: Add basic b4
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-contrib-mathieu-build_props-v2-3-14b809f99dfa@bootlin.com>
References: <20250909-contrib-mathieu-build_props-v2-0-14b809f99dfa@bootlin.com>
In-Reply-To: <20250909-contrib-mathieu-build_props-v2-0-14b809f99dfa@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>, 
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757428270; l=604;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=yfS1+Wa11Hdc1MJgqAeYVSjlh4VQZMKghuCGC0i73nY=;
 b=mDOshg8b/g2OsCcdQIuNMIVZecH0X4pGr8C2mdA9mmVawIGW1Ny54jE7rUZ6NgGBsR7Z5zTlm
 NFlLg3cTczjD/DYi/652zZmBeBmsefn8DuYdreIVIje91XCZxfMyax9
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 14:31:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2156

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


