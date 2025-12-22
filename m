Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A46E677F5
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 16:28:43 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83504.1766420915736820780
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Dec 2025 08:28:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=lbDPlwnU;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id ADAB14E41D34
	for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:28:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 74FC0606C1
	for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:28:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59E1910AB0089;
	Mon, 22 Dec 2025 17:28:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766420911; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=6H6Tsz7Xy47LtQuu2BU3ahhdPjOs03p+hAs05BsFHXQ=;
	b=lbDPlwnUVJs6IGtu2ZkaGDfi49ves7ONySxS+FKxGoLmtRe3CY9MJW1ENTvUu63jOd7AqR
	/pi+EcP+7IoiqWXgP1WLUFKa5LU7qbRgD3Ao73Eamaw5FI0Ruh820DugNdgFV1JpPesToQ
	KCNKEgWp1MC29O8qo58TiDyuPotHkN+DUPelu12Z0iFqB3JdnSZUJ8msTYFDrTZ7bHKlAd
	+WIXonp1m2aANquOWmh4nKxc0Aj4BuZEpxST6i0lYEC9RdKoQcFGgZSAYl1UFgJ326aHB5
	hvSeUJKjUoJjzY9DXpG2PXZHkgLFBSgg6W511SQadGd0SChplyfp0TOgUm3agw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 0/3] observer: Fix ptest link
 generation, again...
Date: Mon, 22 Dec 2025 17:28:12 +0100
Message-Id: <20251222-mathieu-fix-ptest-urls-v1-0-4153fdb174a8@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJxxSWkC/x2MQQrCQAwAv1JyNtBGqtSviIfYjTZQuyXJilL6d
 xePAzOzgYupOFyaDUze6pqXCt2hgXHi5SmoqTJQS31HRPjimFQKPvSDa4gHFpsd2/6UhoHPR+Y
 ENV5NqvEfX+Gbx8jIJfK96JzECG77/gNGGvIIfAAAAA==
X-Change-ID: 20251222-mathieu-fix-ptest-urls-056d99a73aad
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766420910; l=808;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=d625c079GI/MEAV0ZUklJNfDV3oq8A6XOy/HBJfAHLc=;
 b=DEjCmuIgv4f3tZJ7e/q0V89I4pt+vk0J5JM7MN6hgqXF81WGAmaXvUMd26Ll07W7pdXWEj36M
 rvU/S5rYmdPB4sXLrnrtiKjAHGc2OcLYIbYjuKs+4c/VeE3gN8Id9dJ
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:28:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2847

Trying again to fix this. I had a bit of fun running a local buildbot
instance with QEMU working inside to debug this. Locally, this is
working now.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (3):
      docker: Fix QEMU on yocto-worker docker
      docker: do not change shared and publish directory
      observer: Fix builder name detection

 docker/Dockerfile   |  9 +++++----
 docker/compose.yaml | 11 +++++++++--
 docker/entry.sh     |  6 ++++--
 steps/observer.py   |  7 +++++--
 4 files changed, 23 insertions(+), 10 deletions(-)
---
base-commit: 315e7c2300adc03a3519f355c641404fad4f11c0
change-id: 20251222-mathieu-fix-ptest-urls-056d99a73aad

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


