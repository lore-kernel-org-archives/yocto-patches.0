Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69ADEDF16C
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 14:28:23 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.72855.1770992899688384316
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Feb 2026 06:28:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=vSh7BP0u;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 32AD41A0EC3
	for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 14:28:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 09FA4606BE
	for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 14:28:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B76610368EAD;
	Fri, 13 Feb 2026 15:28:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770992897; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zEaLAB6SHuzbPdkGw4EnahnPU/tz0QeMgtEWC6xqaxw=;
	b=vSh7BP0uLSihqgc6kPzegxkkn6Sn6mzYmpWvMyZAg0bpSk650EBhEnpT3mow/9OFSF49m1
	c58+FMlwVc1WWNfnwDB/pxtgdnPwM23IzdbenfIdJXrn4HQYaNC3hFiNhaSz+t9BBbiNZD
	h108jL8d4XbQYhjF0kS+lOcyZ9LJ6mGzaSxhFSCPaMeUdlfPt8MrfJ7RZuKh0E13yUnfqx
	9sLidiMISrxMhLW19+tjKw7IgzbW9wXR8CgbnA4dVMIZVMaTxDo05kiv1FgHYWAxYdEW5n
	ZberubXnx8kup3UMIsfyx1CCwUylApXL6rJq4T0DBpPjAvCXBC6j4YGAyHCPAQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 13 Feb 2026 15:28:10 +0100
Subject: [PATCH error-report-web 2/2] settings: Increase maximum upload
 size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-mathieu-too-big-data-v1-2-2f2c28ebb28a@bootlin.com>
References: <20260213-mathieu-too-big-data-v1-0-2f2c28ebb28a@bootlin.com>
In-Reply-To: <20260213-mathieu-too-big-data-v1-0-2f2c28ebb28a@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770992895; l=575;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=VB2b1QnniGAN5hlHF4QipH9vVmQhjy7dVm5n8Nt164s=;
 b=bmVhUo8yEUCr6qG8tElaM0D5+Qg3rDgId49O/lW/GjfDjqWCclkuTraZT2LBlrJ9t8USAww3+
 cMzf14hjrkRChl9uSeRNMsqtmFoJ+rBefvsINMfCO8XP0bUQhPVnwUk
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 14:28:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3234

Raising from default 5MB to 10 MB.

Fixes [YOCTO #16165]

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 project/settings.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/project/settings.py b/project/settings.py
index d0d8279ac40c..33d8ef9dd186 100644
--- a/project/settings.py
+++ b/project/settings.py
@@ -206,3 +206,5 @@ LOGIN_REDIRECT_URL = '/Errors'
 
 TEST_RUNNER = 'django.test.runner.DiscoverRunner'
 DEFAULT_AUTO_FIELD = 'django.db.models.AutoField'
+
+DATA_UPLOAD_MAX_MEMORY_SIZE = 10485760

-- 
2.47.3


