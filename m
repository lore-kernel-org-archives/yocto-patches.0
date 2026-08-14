Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B52C5CFCF
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 15:10:53 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15023.1786720249807878066
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Aug 2026 08:10:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=U+KTtaS/;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B43581A1640
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 15:10:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8851D6046D
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 15:10:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2DC811C4EE47;
	Fri, 14 Aug 2026 17:10:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786720243; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Tr2OCNBDoomgcfy3VWy4jLtZ09BIG+VmB9V6OvTL6Cw=;
	b=U+KTtaS/Nl1jPaU0hrqE5Q1J44UpoTXirmlVa6vqsb1HwXcHpOyQquPN6bTgetS2TdQr5Y
	H03EQypMnMjTxghwvl/ZmERUPSX/jYinhCaX/nYVG/3/rkskgtJYI9JmnZ3SL1Rh6adu1h
	iHINucb8WRTdrvR9+2f7kRaq7MI4tgNFbuBLSRyIMEZ2VnZZR/dnEhuD4PWXjvJ7chrLsm
	F0OQJiEmh4z0WpVzvIbk+kYTnDu+fqF0Xc9mAbVAGw4BMz+wT5lDq46hxyphRaaJZDl6Yv
	X5oXjfv5VXorNebC6jLQ141bTMB4bG2Gm2tRl4alISmSEigz2P7YI9LwN68oyw==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 0/2] Dashboard updates
Date: Fri, 14 Aug 2026 17:10:34 +0200
Message-Id: <20260814-dashboard-updates-v1-0-2ef14945639c@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ7CIBBA4as0s3YSKFWJV2m64GcqmKY0DBhN0
 7uLuvwW7+3AlCMx3LodMj0jx7Q2yFMHLpj1Thh9M/SivwgtB/SGg00me6ybN4UYtVLyOp9pUFp
 A67ZMc3z9nuP0N1f7IFe+o/GdXEloakm2xsVTxkDLRnmC4/gA+4DqK48AAAA=
X-Change-ID: 20260814-dashboard-updates-83317f5e4380
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=399;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=exzrY6VjW/kG/rEJP5UJsy6lVeIt6MfU6ylZV4qH0PE=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqfy/wuvYh+6TT9kp6b9+Bx+i3/oIPi/mdjurAU
 rvxi3Up68SJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCan8v8AAKCRDRgEFAKaOo
 Ns27EADNrK7/4z370cSPhqO9w46LQgL9L8G+PEB1lcImVIrqwQfRCUPwdAHXyYjZCuxCiTk2F3o
 w3e+m8f1fF1GxZIIc4CeyRt2V2QTgi96ddVKA1JHXZqVRChi43rphkGyehaeqXRUuHaVRh23wqE
 hqlsEv/cIhNnP54DRWMNY1omKCN25hW8WAIxBqLeR9TOJEet1FU+tJpcEXb5GvJMMj54qAU2ODo
 Tp8i0rUzXAPCI5pKgG1LwORI8FmK25Ck9Ec4FUVVnL6bQOcRfq3Z1b3lmCCQcL/QtMEmkjIqfjA
 1nrXMWAs0l0J2EG5W48wpVtckS0x3Duh1wYBiah7RgVXC0Gzb3+rpR/wkNbvZ2Pbz6xg+eeGq74
 5YAFX0cG2BJp6Uo0O3n2Hix4GSINt4JjWCEZ/u631MfF3BwKs5/5k1BzcU/aZ95YZisM4unCOVe
 TtaYyns4LDOE7MHcAP3sSiLtsACgdk91Ak+1Gyw70vxfffoUQt7N/34zO3g6TRFw7g6/A96u3vL
 qzQjLQ0NL8Bbym0HjE5JdDaXf09/+ZY0c4vyhjPCCykdGEWEHgvgiKPlu5B1nAbcYozXn7WCsfi
 W36PLBQYTztx0ElYBFHf/z1W1Kza/9iuI5aJjj79XVL/96mLi0ec6whGQQXqt2Vpd/L3swgTmoJ
 oW1n+hhm7Kxc7Yg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 15:10:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4664

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      scripts/dashboard/index.html: fix a typo
      scripts/dashboard/index.html: add link to documentation

 scripts/dashboard/index.html | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 1c2ad463e90a1a37a5740b3c4e1f398dd2708135
change-id: 20260814-dashboard-updates-83317f5e4380


