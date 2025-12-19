Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910E5D767D1
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 10:36:08 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14171.1766140562621984301
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Dec 2025 02:36:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=gvZHNC4g;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AFD5F1A22DF
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 10:36:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7AABE6071D
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 10:36:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C89F102F0CD2;
	Fri, 19 Dec 2025 11:35:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766140556; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=AowxS4YQJQNA5ENFifwfQ7S6yNENaV8OO3fw/U9QMfs=;
	b=gvZHNC4gfvCDeJ2Kss7cxLb/C+ud6S7DdorS9nlc3vsPxbSQsl7Gi+ejJwITp737DoJYbD
	7TnncGydrBLWxOlqV0ItYAKvMfPsByNF8sFRi5p6mEC1c9hetQHcWCrka7z99uXbI3pmg/
	Cu9Nm4el48z2T5T3oNfz+ghla1lU2CuxsDCDW3nyL7ktcLHUMKhXW1FJE0rdUG03GNJN+6
	TyWnzK2JO0GDxdzXLVqE5n//m6ceagA+ZEU2WT9YdfunC3qgVxfzDXonHWDBRJdwPkldu9
	ergqnia3Lxvjsw03eEOepCgtvxYEJ1yS+0pLjAset6aDqgHUaM6CxIU+0cwmfw==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 0/3] scripts/release-parser.py:
 update and move from poky
Date: Fri, 19 Dec 2025 11:35:36 +0100
Message-Id: <20251219-releases-parser-updates-v1-0-6830e6a67db0@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHgqRWkC/yXMTQ7CIBBA4as0s5ak9EeDV2m6oDDaMaQQBoym6
 d0ddfkt3tuBMRMyXJsdMj6JKW4CfWrArXa7oyIvhq7tRt1pozIGtIysks3Sqpq8LcKLa8dhQNO
 fTQ9Sp4w3ev3O0/w31+WBrnx30zu6EpWtJS6VgpfRiiFhnuE4Pob4oiaVAAAA
X-Change-ID: 20251219-releases-parser-updates-7c0544e93693
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=989;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=QMTA2lPZ8GIiZKRbstdkWO/aTC4IrSiM+jHh6W6SeDg=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpRSqKKbZGR7CK+e/8yqN8Zq9bVgnbBzJD3HQyI
 NwIgIaZyGKJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaUUqigAKCRDRgEFAKaOo
 Nt4RD/9BQNtqt2EEEcwT/RuLFXVrb2BtBLl+k6DaQxUnKVkGu6MAD2p0tlLeqKe0EatJwwMX/9o
 nxfmQ5PDni10UZvUc1uoYnm4nJPC1adYkJzwaOHMYCMyasoIUbiI3mlXfdoaxYr8OPya1boGPm3
 iUadVucCsDumDVr3PVAiiABeL4GaLe/3h6azOviuYXGTbQJbvyHsrn54hnqtIE7sk66SB67cPrc
 IdjYyfju5lnLxcKZKwOIyySUns2ANTh5Aho6z7lV9Mm8Y6P+9U6nYjfJ9KLXiI2fnT17J3vS0QO
 hp92AWcR7PAp/93B5wzFI1mtv1elrP1k/0hx5ipXSATQK1xHwaoObfYjIW8I24X/UlAEHn8AWg9
 YYH5O31yzzffI37B1idZp/Hu+o2Zy0eeqsPNwJP307EQANdgMQ/yYX/zKzQn/Kc5B6XUWlQlIVK
 Cj2hslAvE9sg5khPUh1BN8coLUDZ2xaVAIa16TcK3vGgwb89C5odtgTGQ2Xvo7oaxVek0oi1r4t
 Do3BuTTrT2N+XZLSYQT5Oeiijiv+5N6uG4RNNM0Dv1OlV4ad0MMtTs2rS21S2Bn6OJFZ8BZzeJZ
 WyqMwEkW90gU55IbBxoW4qkOEthf+qJiNb87qi5HUBDbkIeseOBxaiKhz9DFstlV06EABm63ogc
 t6RAQcfYsQuHTaw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 10:36:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2828

Make the necessary changes to move away from poky and use yocto-docs to
get the tag information we need. yocto-docs is currently one of the
closest source of tags compared to poky.

I don't have the autobuilder setup locally, so this is a best guess on
my side to understand how to put the yocto-docs repository in
~/git/mirror.

The last patch is a simple refactoring to avoid mistakes when updating
this release-parser.py file.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (3):
      scripts/release-parser.py: use yocto-docs instead of poky
      scripts/release-parser.py: update for Wrynose/Whinlatter
      scripts/release-parser.py: define globals for stable/active versions

 config.json               |  1 +
 scripts/release-parser.py | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)
---
base-commit: b98e33ede486a09d37f89f7df934c7e7ad0a3e58
change-id: 20251219-releases-parser-updates-7c0544e93693


