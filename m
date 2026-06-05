Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CC9CD6E6B
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 07:58:41 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3457.1780646310395715628
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 00:58:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=U/O+SvHR;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0E39B1A0904
	for <yocto-patches@lists.yoctoproject.org>; Fri,  5 Jun 2026 07:58:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CF90F5FED1
	for <yocto-patches@lists.yoctoproject.org>; Fri,  5 Jun 2026 07:58:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 544D2106A1FBA;
	Fri,  5 Jun 2026 09:58:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780646307; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=kGS1GghZWOStGzMHDxdSFCfHuDS7UHXHf81ngHELl6w=;
	b=U/O+SvHR9SS6VGkIST6lg47zrVbIjh9fznNTil3/rLmAGLxic/ebAuGfY4HnEGLgGaG4y8
	deLuZWquYvPy6eTnR74OlRaPP/+4X2+y7/9fux5OWR4xcqeeZGx298+CspTHA8STVtAANv
	OW7uq7n74+lhucgpAUSubpqwA501hQZEUB9Xdnhe8DanUvLklNZYz6QKxdLMw6xzQRTZDE
	zErIqUuEzRmtAYbW+s8En9feBsAhFAzLlFB2OtIjcPc1ZlqM317jCHAtiSnD21YJmRV22A
	dSGynGVsvdc8QT4dbygOvlhx0LLYJaFP0zTtc7U803Njq9e3GkPfQqNgFum0+w==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 05 Jun 2026 09:58:10 +0200
Subject: [PATCH yocto-autobuilder2] schedulers: add missing wrynose branch
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-mathieu-wrynose-branches-v1-1-a18888aab77f@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAJGBImoC/x3MQQ7CIBBA0as0s3YSpEKMVzEuKAwyiYIZQG2a3
 l3i8i3+36CSMFW4TBsIvblyyQPHwwQ+uXwn5DAMWmmrrDL4dC0xdfzImkslXMRln6jibM7KnKK
 Nc1Aw8pdQ5O9/fYW1+FbQ9VaWzo9AouG27z/gp8q1fgAAAA==
X-Change-ID: 20260605-mathieu-wrynose-branches-358054f6f3d0
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780646306; l=1056;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=B81r+8sLz2c03C1d2QcFbOqru1h+ncy963vBGEDudvY=;
 b=rdFPDL3aHHHG5Aht1Ea2v7p0b4XacxDIIi1mbJfuVzt9TcTZJMoji0cah948rbLrhfUZfX0E3
 X7Q0ilcyzgzA8pi2W98ZOxbYi6nkPmdVYUozsmhLuoFAYd6kC8UZVM0
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 07:58:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4143

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 schedulers.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index 67fdd39d8f88..78e057bc3365 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -74,6 +74,14 @@ branchdefaults = {
     'wrynose': {
         'branch': 'wrynose',
         'branch_bitbake': '2.18',
+        'branch_meta-arm': 'wrynose',
+        'branch_meta-aws': 'wrynose',
+        'branch_meta-clang': 'wrynose',
+        'branch_meta-exein': 'wrynose',
+        'branch_meta-qcom': 'wrynose',
+        'branch_meta-risc': 'wrynose',
+        'branch_meta-ti': 'wrynose',
+        'branch_meta-virtualization': 'wrynose',
         'branch_meta-yocto': 'wrynose',
         'branch_oecore': 'wrynose',
         'branch_yocto-docs': 'wrynose',

---
base-commit: a999d97e0aab0059ee6dd25432740660511e6db2
change-id: 20260605-mathieu-wrynose-branches-358054f6f3d0

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


