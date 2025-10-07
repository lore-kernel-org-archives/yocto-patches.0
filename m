Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1D8CCD18C
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:34 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.20407.1759847850044746447
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=dEI3Rrer;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BC6AC1A1167
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 947B7606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F011B102F216E;
	Tue,  7 Oct 2025 16:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847848; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7FTHC1WqOutoZr31C01ER1b3g5TUAy9zFh1kH/x7L7Q=;
	b=dEI3Rrerp5bLrRXz+FxpADxoSy3GE//JRCmPJwv2aLGHsrrcJ2He0S7HXfpZFR8GYOdhNY
	eF7AZLIPkgfz23EipuLwvQUMs2bNSUAUwYt9HHJ0Q0pN7qtSxTbTz1EYaxDX1p4g8KtpFy
	d8tqgUtvYIn/JAGUSDUT0iuO9iBTtNvtBt/aLqY3tyYAqZlYsWAW8wAtrTTiB+f2fsrdc1
	wVbnEaUnqVK5Udl/X9KFvQC+ShMvxDA2iDzVH2efmG6yIAbs1/V6OoHdNMN41Z4cjHSMBm
	6lvcvayNKy0D86GMvxWwS9lNXXhGZ7yoCzFFX4T/NqGvznsomOHikZ1whQQEWQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Oct 2025 16:37:25 +0200
Subject: [PATCH yocto-autobuilder2 09/10] b4-config: Add basic b4
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-contrib-mathieu-bb-setup-links-v1-9-bb1d79289c3f@bootlin.com>
References: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
In-Reply-To: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847841; l=660;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=IGO0VLkONfppPBejsLIyP4119ueXJPi/xfZrG8SXO20=;
 b=9UUksSlBVVhesstqkwId/XJyiOz8HLIF4PyYRvmWj/X4MICpr/lEp3j4oyiADRXeQPE+iRi73
 KSXEucLwi6ZBvX+ITjyr/AoD8Z9tOWuWfjWMhWlnIWEBzmiGx8q9nER
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2285

Allow to easily prepare mail series with b4. Most of the configuration
was shamelessly stolen from openembedded-core git.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .b4-config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000000000000000000000000000000000000..0f1f430c74f3312f121648b9fba31c20a5e37628
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,4 @@
+[b4]
+  send-series-to = yocto-patches@lists.yoctoproject.org
+  prep-pre-flight-checks = disable-needs-auto-to-cc, disable-needs-checking
+  send-prefixes = yocto-autobuilder2

-- 
2.47.3


