Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED5AD72359
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 09:00:27 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.64024.1769158816916082575
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 01:00:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=IExM7qTL;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 934D4C21ABE
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 689C76070A
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08003119A879C;
	Fri, 23 Jan 2026 10:00:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769158814; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0mldMJNYeUgeNMrYXX4S2OeQOTZUYYTnoUAFyiUyTzQ=;
	b=IExM7qTLUSmUjFnOQDw8k3FM3hFT3I4xu8kFJPAkNgTvcqEqadEowHbGZziKAy0yvREJlu
	knc0b9y/P7QnwNtt93jyewnTbdVUbmgPGHvstZMseAERiEWfKhEWGJNeZFj+55i5D843iL
	dDkOFuRUipNp9ZT1/VyVHMCQ45rVkAfalF5atdPmhCZu4wxLPn4BSMhG9v7md2Ip79w/xB
	R5LKxsNxD8QamaOYYOp3o8AQXCsxnCwTCsim2uv3P6FaC0E4diojJDD8pSFna3w5vM1dNQ
	if24tTwoRBqgfh7kxayFgQZ8Hnj6WjSJpEK+Zbi+AzaNwH5UvuKcjoGlncEGIw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 23 Jan 2026 09:59:51 +0100
Subject: [yocto-autobuilder-helper][PATCH v2 8/9]
 scripts/release-parser.py: update commit for yocto-docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-releases-parser-updates-v2-8-c24c30da807b@bootlin.com>
References: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
In-Reply-To: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=878;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=rs5J6AQioUZD3ZpAUWWsk6bcvJqjFQgyz9wzudGIRm4=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcziWpOIbYSIXrDeZRzKa3+Hfzpa8gpoddsapo
 nw2Xmk462WJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXM4lgAKCRDRgEFAKaOo
 NoovEADLP0U/6+Nyjc32Tu1+pKtskZUl8Sx9KIsj22njYNmIxKUyA0+4qErggf2Mg+40qlMa32Y
 Cf49d47B34h0S8eqjkufs5X//WttZi7ak790WT4V+LdiMQMmH7V/WK0yQncl+MKt47EKUaoZYD+
 qwLmo37XQcPIgdqU9UlTFDxwpfX6qROkkoVHfQuZJeNXpkIAOS24zhYiU57BPPK2RSL7rOxZ+BC
 hfTrdHWhSF2GG8UiMLJrQWQnbP1YvUiABDEkcbQi6UeKw2tMst9lJWzS4crt4mqGXy3imUnI1sx
 /59mXViec5LjPPHj95VKd6ge55dspj3lP6Gfwio8mUfhdRfc907P/bnTbUFWaybAREEZ07Ou7iT
 FoYWMNEUG4iChPEyEfwDjNywl5psx/o8awqyv1tLg+RlYTuRgzvtqyBt9Hiabb1O1vJI9aNT5+i
 RqpytG0dBKTbZupbM5Hmluy6d02leCrVs7GpGyObREbS7fSveCP87ZRx6tzTdSNLskvr+s6r0g/
 mi3FTqWLfVnGH3IxKAMuVu2N/dDANIuyRcTjfw+jYmFxclDBsrNhV76mBl/x08u16R+QlBDAgL8
 6flzs97DUtxafXpMIAKa/0ZuTczkf81zyNNgHMzL2OWFKSJLgGZxIjqxgsno7rjYG9ins/d8VOl
 zSvkQorZpaATFaw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3063

Comment above says: "Only calculate for releases after standard tagging
began in yocto-1.4.1". Update commit sha to point to yocto-1.4.1 on
yocto-docs.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index f161ef1..10c7df6 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -75,7 +75,7 @@ def get_git_tags():
         if (
             tags[-1].commit.committed_datetime
             >= repo.commit(
-                "73f103bf9b2cdf985464dc53bf4f1cfd71d4531f"
+                "f056d4fd95d45c53a89c893419eab0537c7e1ffd"
             ).committed_datetime
         ):
             download = "https://downloads.yoctoproject.org/releases/yocto/{}".format(

-- 
2.52.0


