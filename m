Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA80CA1015
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 15:46:30 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.40.1757000782041568372
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 08:46:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=svx2Xbw1;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B9C224E40C66
	for <yocto-patches@lists.yoctoproject.org>; Thu,  4 Sep 2025 15:46:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9399D606C4
	for <yocto-patches@lists.yoctoproject.org>; Thu,  4 Sep 2025 15:46:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B07F1C22DE77;
	Thu,  4 Sep 2025 17:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757000780; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dZwyjsCh8H6wDp7V3QS4DVMR+0TDgMoMniBFuG6CObo=;
	b=svx2Xbw13GPeNOi4DtXZPVpqnwGvtUlKMTp27RTDQn+RQdCqbjL+KmuyRYqXAGsZPXTl0R
	RKLBOeyny+6JufzFMIMGdAPUp8JOjJClgiUyALjAZO95ACgav5XoWxbWfjIctgrv0XGn5n
	PCFDTnYP6N5L3t0NKrV/r36xZrppqqhYBytm0Dap201rIFYWTJ88CLlBS3bmabOins6tAJ
	lu65gt8pmbPOu6zHoxh9PrOOEvBRitDXYWep/ZERMIjY3rlA8iqp3lD74KXDIkRAOurvro
	mTdqBiEPOiTZVbV86wHVOCNXc3hv/qSmvWQgrzT6D5ZjfcOMxlAgWo/ZvrvjVQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 04 Sep 2025 17:45:32 +0200
Subject: [PATCH yocto-autobuilder-helper 2/2] b4-config: Add basic b4
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-contrib-mathieu-build_props-v1-2-28de412ac349@bootlin.com>
References: <20250904-contrib-mathieu-build_props-v1-0-28de412ac349@bootlin.com>
In-Reply-To: <20250904-contrib-mathieu-build_props-v1-0-28de412ac349@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757000770; l=610;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=29GnlNM6nC+i6S21zDRcgsSlnQZ30VfA1fIyS9Gf7w4=;
 b=GeKFFIJZ/CiRsS51UZNQ/Cr4/ZdoyfBRYE6IddyRjOrAwzJbiJA70Uv2wtQIL4ZT7Tnp9oEKf
 Sv6JtyIukJsAjBIudqQGNN8afXvMUkKejwFruAbnphXrIW8F6KrLnQe
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 15:46:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2130

Allow to easily prepare mail series with b4. Most of the configuration
was shamelessly stolen from openembedded-core git.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .b4-config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 000000000000..8f8204a78ff1
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,4 @@
+[b4]
+  send-series-to = yocto-patches@lists.yoctoproject.org
+  prep-pre-flight-checks = disable-needs-auto-to-cc, disable-needs-checking
+  send-prefixes = yocto-autobuilder-helper

-- 
2.39.5


