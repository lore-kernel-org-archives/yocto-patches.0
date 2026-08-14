Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3C6C5CFC1
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 15:11:03 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15024.1786720254348737003
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Aug 2026 08:10:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=EtQsLRmu;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 616554E4122E
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 15:10:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 36F766046D
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 15:10:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FA7611C4EE4A;
	Fri, 14 Aug 2026 17:10:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786720247; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zrvH2xyBbpSdZ1zEzErK09G7djedjAJ8pH+NtzJN+Lk=;
	b=EtQsLRmuX0nL8gR9B6fkfpP23Q0lGLksaiSq1eKptVmdB6ooqg2Otwm7W8To7zhw4ShyTV
	i2fUaO1AlSokRWoeyjubywhTkEGz/Xa4xBCEoI9DessFv2mNBdHq0JKJPZJABxnW/KXCiI
	UKp1gR1DwJlqafpcG/obZSYjchM8BfD/ocyYbE9kveOM2JMzB6zOe4d0qlXNfGdP73xazT
	kSNtaxWeQYzC6zu9WrNiMUmvlXQlYeZJrrd1yIqiOynLoeqbl82J4jJtb+KEFKLloNAaVC
	QliJZ+2tIxLd7TU7HRpSegC0MYQnJlEQIeH6joEMkpIWukx27emm3XuzTQcTNQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 14 Aug 2026 17:10:35 +0200
Subject: [yocto-autobuilder-helper][PATCH 1/2]
 scripts/dashboard/index.html: fix a typo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-dashboard-updates-v1-1-2ef14945639c@bootlin.com>
References: <20260814-dashboard-updates-v1-0-2ef14945639c@bootlin.com>
In-Reply-To: <20260814-dashboard-updates-v1-0-2ef14945639c@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=vc5sFb82kteaCON+il51ggp+lZfnInwPPIIiPd0Iyqg=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqfy/xKRgk2Y8cDOo0UQpFoSTTbuZb1D0oCAOJX
 6KKUxMQNXGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCan8v8QAKCRDRgEFAKaOo
 Nv9ND/45QRJWbWcII1nRCkWm+SQcg8nsX0C/sKEokerB80Fk0fFkWgLS2Js9MukDo6xYCU/NzQM
 JNNyQv8sf6hOdWJ5gUP3rAa5dw9i9vGjW+at9FUDABa7f8PIQ6pj/amd4MqoQ15vXRwPx1/fyGO
 7AckZrbjsPOD6JxoCWb1nLFx9m6C8dzpjMK4IhaF3cPrgFKbWltjHRgVxv1cYz1Yb7QSzP9mW0u
 D0AM1kFeYqRuk4iPOZDz09dcA/eIZ2eMSky7PtJKZFJ92JTO6wNNOjqb8etnTyl4B1R3gvNA3Mj
 rELXJTpHrmSZ8jo0LToZGJdsnOJsyHs0kmuHw0yfdqvVmRr4l4GpEGf4nEfAlqn/yLBbAz151VZ
 X/y9xqnH6+ivMxfUw6N6SC6D0IlBlrTMuB2YEp3eVFvlWxb4UWAiaZD/P/yGxn0dV6nnXTCRvTi
 t5Z+ZO/3NNuZ1bEy3WVcr2VeQnjQgaY+bUtAq9QDDHrsv0AbhwbTRtgkeTud7eXRwE/NnxInNYt
 9ZGo8gLkWeIRAYUVcD22vkxax+xzIQHW1c+HprVXvJp535FNhtwcMl/jjOrciLgQgJrr0D29bgc
 tsk+w5OSJ6Z/ro/j4YtPrUqKyWKPuVOvDO3766nbXuerGj7PCd7qLTKU8QZ35w1fXZBm15lW47Y
 3DLKsAg88tfuWoQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 15:11:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4665

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/dashboard/index.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dashboard/index.html b/scripts/dashboard/index.html
index c4f657b..d20276f 100644
--- a/scripts/dashboard/index.html
+++ b/scripts/dashboard/index.html
@@ -37,7 +37,7 @@
         <li><a href="https://git.openembedded.org/">OpenEmbedded Source Code Repositories (git)</a></li>
         <li><a href="https://bugzilla.yoctoproject.org/">Yocto Project Bugzilla</a></li>
         <li><a href="https://www.yoctoproject.org/development/yocto-project-compatible-layers/">Yocto Project Compatible Layers</a></li>
-        <li><a href="https://www.yoctoproject.org/reproducible-build-results/">Reproducibile Build Status</a></li>
+        <li><a href="https://www.yoctoproject.org/reproducible-build-results/">Reproducible Build Status</a></li>
         <li><a href="https://lore.kernel.org/">Lore Public Inbox for mailing lists</a></li>
       </ul>
     </section>

-- 
2.55.0


