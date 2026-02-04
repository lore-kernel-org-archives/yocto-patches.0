Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0944AE83EEE
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 08:08:55 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15404.1770192531336532359
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Feb 2026 00:08:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=NcjpLrkK;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 09C484E423F8
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D507160745
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50EC4119A88FA;
	Wed,  4 Feb 2026 09:08:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770192528; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0mldMJNYeUgeNMrYXX4S2OeQOTZUYYTnoUAFyiUyTzQ=;
	b=NcjpLrkK3tGtAoykzecIALJPRCAl33jWjR/xo+OzpnPgob0gk/BELgsINzDjLjKuXDk08J
	bJ63m9l3S/hoodYaVpdClwsEyytsCFf+kWEFYgyBl3wgcaiXCouc9MTaTUxupgEaeR41ns
	bnPt8q77v1wdF1lqrEQZsuGxd6qtQsV5gx00x6WgoFqeVejTc7GA+JNIK0NGkcQMY36915
	dZUPjMo0HFxWIZ7yUqyOTFrb+OOYuZ43f4TY8NQJ3GXERstQukLXLJaNrC+qY8f295FlGu
	JOJ1kihD/C3Jb+jgLZdgy6kJHJTR5PkYa1U2+FMP5zi+xOLT39Wob80K5VLeTg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 04 Feb 2026 09:08:26 +0100
Subject: [yocto-autobuilder-helper][PATCH v3 6/7]
 scripts/release-parser.py: update commit for yocto-docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-releases-parser-updates-v3-6-be208a7748b1@bootlin.com>
References: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
In-Reply-To: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=878;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=rs5J6AQioUZD3ZpAUWWsk6bcvJqjFQgyz9wzudGIRm4=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpgv6M2MMEYUnex02vP3vPYcDigE18H1vYPU7Au
 uq+utUgKOGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYL+jAAKCRDRgEFAKaOo
 NkGgD/0TTB8ULB4iIL81ti2MMI87ZZaoF0NPhxxfmzWziNWFAv5HBrIBEbJd+XSA42g5qR+QOln
 /o6K0gZbPUQYqPBH1IyQYMQFrpoI2Mo28lA/X9BqrKhpBeD2JQ3cJxTSYhkp65S03QevT4204g6
 DI+Ogrlrcj5XnnyHsoGXn4TFs6k88YIVMvuiiAQn86TZmx7fGl9EMDNWctr6Rnt1zh9FrJPvp3m
 6FPbg5hniF8HGOA9repW0aflS/G4pQpYpGChZx05ZtY4ZjDj62q3y7JAaLH4R9rEMb2FRa7eKLk
 S2IxBKA9QGge/fp65emzsYwJiRZLbl7UhxztoXNl7IwcS0tgspUc8fQSB6rUB52e9mdGNz/kBw9
 TXg/USoi1oim45gE/6+j+ywN51X4UQoFBsqgxbtKXTsxKxA9fE9fo28otS5gMJXwMI7hwqxRrvo
 vVBfriJUcN9GEG+GsjS5BLtRV3nTWKywJBnxV24Nwom43kwI2IrEUBoC8ODhs2dqke5YIDbgEKw
 eyoxQAnG8x1DLb0ajIeVGvq33b3fwRYnV31NDFgjYZAVsDlbDL8JOw+bR7Oe/Tez028OjWRkWrG
 e1bzs4yPSK5axz0I+3uxMtpv3TkWvk7HSAFf058Y8tCHOTB+0KnWSmEoCZeaCjxj5kphKxrwqBu
 0TNPsMhuWTuk55g==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 08:08:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3187

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


