Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8A1C5CFCF
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 15:11:03 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15026.1786720258694502747
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Aug 2026 08:10:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=041mAH3F;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D9D831A1640
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 15:10:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A8477604AA
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 15:10:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D18D11C4EDDE;
	Fri, 14 Aug 2026 17:10:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786720252; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oYNGDFTo1dY07YCj5axRkAV5ovVFilbtLypQKHXLrho=;
	b=041mAH3FbJnvTPmCPaeFvrlWsAcJKdWmHV9dPFg390iFtX1c5NRsMFP++wBQzbkb8OiGZM
	9KQjcmD3WSQKN5WtERnDkMJe6KhAj7myKUGkrM+0eG+MIH/wUAWVbvEBcRAS8GYCKaRgtJ
	JCbHQrC2XTddIo4hYAttSZwQ6abQMxar8KyAYis1quO6zpBS4/179R63nSy15LGp8WgsUa
	I2H9oGDI4F2m1zltqYjmiiXkXDrc1ZIGC3G1Js+v+TaYwUs7ieyZWGqz+EgEEO4kIMjjWd
	O6JPhbvUkMF22O1k+njXhVyKkvVVKyM8U620MmiTMtMctcSiUub45a1GIHSkIg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 14 Aug 2026 17:10:36 +0200
Subject: [yocto-autobuilder-helper][PATCH 2/2]
 scripts/dashboard/index.html: add link to documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-dashboard-updates-v1-2-2ef14945639c@bootlin.com>
References: <20260814-dashboard-updates-v1-0-2ef14945639c@bootlin.com>
In-Reply-To: <20260814-dashboard-updates-v1-0-2ef14945639c@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=807;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=XaH1Gjv/qRS0MGA75YcZZHzrHc074ZUljwsaJBMAZ64=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqfy/xI6NiCRvKW3gNHnjAqf5NK1MMhQWO6X6vi
 hTdZHUHW7aJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCan8v8QAKCRDRgEFAKaOo
 NjA1D/4ymFar38I54i9I3aCF3SzSpaxjwbuSrwvNtIhDLTFmsbxIkjyPv2jJD0SrytVBNuva3fX
 mtl4xx/x0AF2cJlRlcLhDuOB/6MIo9xQTicgoMo4J1+OYnxhwmikSLf8IeBXE/hdVTxzHF8umrk
 92NRuiSFz7n+XNccmqc2fuk8gMehkAcpCpyJ851qWL2DhafDKpsXYRdnEHtMfyuexkgQzfxnCTk
 O4L+TvICzVSIUplz+CzByAPdCR0k+h6LfXxBM/V2QDPF9wxkZHMhCADz3tvtnhDD6ip5GKeJpSY
 ggI0wcFSIHG32fR9AB3IDfiLF2UjSqWgKDTOn849yR9cmw5dV5/K/ljCs0aKXAuFYlk+PeEOihz
 L6Ihi+3gsZHgKrnw9b9pfhqoe+4fDnDRIzzZLM+X7DO/PLrQbTyCB/JpD1p0AgLhWrJGk1QJ5Uo
 VRZ7OuKQbnw6TZzIWqYTtoIHuMmzDwjrmjUYcaFuvGP45xIlaJOrsE87gzeXcLK38T6vCfgZoup
 vVUvw5U9j7arTUwF8IoQ2vaTuQuKqjn6pNCxEUKby4py6pOMpo3TpcxxFjbJMWx1c4j/sfOBliO
 Y51Ro6gtkvyZnJs/NibFawvLtNZormOQgfSH3C0M1Ezmy/gjmJ2vWbPC4CxTHSDKcImlKZGsoYQ
 gQt3eA1iSXOdj1Q==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 15:11:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4666

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/dashboard/index.html | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/dashboard/index.html b/scripts/dashboard/index.html
index d20276f..0944f90 100644
--- a/scripts/dashboard/index.html
+++ b/scripts/dashboard/index.html
@@ -28,6 +28,7 @@
       <p>Other useful links:</p>
       </p>
       <ul>
+        <li><a href="https://docs.yoctoproject.org/">Yocto Project Documentation</a></li>
         <li><a href="https://www.yoctoproject.org/development/releases/">Release Information</a></li>
         <li><a href="https://valkyrie.yocto.io/pub/">Autobuilder unreleased build output</a></li>
         <li><a href="https://swatbot.yoctoproject.org/">Swatbot - CI failure triage system</a></li>

-- 
2.55.0


