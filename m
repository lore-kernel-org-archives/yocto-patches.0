Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EB1FD8761
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 12:35:08 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.74877.1773750904034160502
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 05:35:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=FYV414C3;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5AA2E1A2DF9
	for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 12:35:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 321155FC9A
	for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 12:35:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE78F104504BB;
	Tue, 17 Mar 2026 13:35:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773750901; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ik266wcMDGJdykG6JTxUF/FgzmW1hDfZuIqc2+wb5UI=;
	b=FYV414C3caQpDElvAV4ePuLr9qX5EVXI1/xAVR1fGqNoekZOZ3wSxoCkUwH2DvcButtvhV
	0zsWPcj7ODkBeJSxOk0FoNwiIYuKSMLzMizGxOXQixwq8n7F9Qu/N66TEibWhUvfypBGM2
	5fmFvLeEOTjNYqy8G+rpMpJuCSq8faTyiRIjDVSZPj+xOgrgyExJJj7FqgNIPISMGeHxN9
	qFu2atfJlqu/AVHVAJJkd5sXcjGK/t07yxkatgt20HyJbFUScKB1vUxF71lBkwNwygMxcT
	xLsVjr0jsPGyT6Usj1nOPbpoM6JaEjmcncf4gu+/fT0UMBdubM66BmG9Avy1ag==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 17 Mar 2026 13:34:53 +0100
Subject: [yocto-autobuilder-helper][PATCH 1/3] scripts/run-docs-build: fix
 the releases.json file generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-fix-releases-json-generation-v1-1-f57f3267c88a@bootlin.com>
References: <20260317-fix-releases-json-generation-v1-0-f57f3267c88a@bootlin.com>
In-Reply-To: <20260317-fix-releases-json-generation-v1-0-f57f3267c88a@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=850;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=9WwpPWxzRylIvkWt8timR9mV99v9rBQwaGrXsNLMvxg=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpuUpy4eyA8H0usyYW82dvCybeBNdqkhVbUfcd5
 1lioxi13TuJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCablKcgAKCRDRgEFAKaOo
 NjzFD/wKxd8kbm6glLxKaIWe+Po1H+zkok6IoQftRMzCPrFsZ+EHrhhsYjsvEnackYL20f7Gojy
 t6wwB8u1RVVS8ntvqUv2KSpE46cgVkTiy1G1EVm09Nb3qbL28px++ijYZeYCDfZQjP/g5mZixNG
 OR1fOQ0jTgRb0cUPXP9o86dNz/jsm9ROsPyfm5ACvfcpLd8PZ5jZ0EjWP9pSOIcv2C1x+ZPM7KU
 lfHwxGhORFcGF5UxnqU4eg2ucGQ3lFqe9UF9R61wa5M1boruoj4OW3eEDCh7pLSmYZbk2M4osCr
 O3BRURRPFHYkAwtjO5hGICoUhyg1n/tnr3HnXlLjHZ1Ct3vsAMeQVrR9HGTz+fK/7S7uG+Yi1M9
 Ykx9d0f4Q2FXPwAcvyihephmaBH1+7ObvU7uQN6KH/799B6lJMf66okvBhaoSUtmHKbKvTVZUi8
 jrHSokm1TqPwToGMARoTGSxS0bHP33KyhMXvBhFcSamtwJqFdRj8tHN/NMVKgBrt/dGUYEzMIW7
 ovr7M60054ZguQPU3VXX0nqxF4wxPBN8q7WBnPWro8jb1RFwOoxaiiWETBSgLqF5APi6M0Dj0WY
 8Hg9u2gcSq+WEhGV/FHs9Y/wcuv5AGY/TmcFthNLVR8MgMTMhjTad7powTVBPwzVfZ0+YM0aK5x
 a3OTLeDFgoTALKg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 12:35:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3485

After [1], we need to update the call to release-parser.py to pass the
bitbake repo path to get tags from the bitbake repo.

[1]: https://git.yoctoproject.org/yocto-autobuilder-helper/commit/?id=62d06a23f8168863777b85fa106cf5a1ebb1eade

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index edd0574..ed32412 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -98,7 +98,7 @@ tar --exclude=eclipse -xJf ${docbookarchive_localpath}
 $scriptdir/docs_add_banner.py
 
 # generate the releases.json in PWD
-$scriptdir/release-parser.py $ypdocs/..
+$scriptdir/release-parser.py "$ypdocs/.." "$bbdocs/.."
 cp releases.json "$builddir"
 
 cd $bbdocs

-- 
2.53.0


