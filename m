Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34162D72366
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 09:00:17 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.63629.1769158815586406673
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 01:00:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ExVuDwp8;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3531EC21ABC
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B06C6070A
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BD9C119A879B;
	Fri, 23 Jan 2026 10:00:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769158813; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jvsQti7qZrTILQWXzEsoEKIrUW4Lu+6toq4+TS+Eexc=;
	b=ExVuDwp8dtTKtAba+CB1cqxqWFfpNzORB6Nad2qpnAbxuyqtuKZgWOEkJt6BPsmBomn0/P
	IOM4kL8Mo7Dw9U1wGVBxwGdCvrJ2OGiSOvKCZKKjTNVjWWxiEt4ecFwmk2xF488TdAD4es
	TPpth8a16KLfQoEFuhBjFEFctWbWbCmBIOr/o+oW3CFsAXnaAZRXmhAFtlfuQzbHnN23L1
	iT/IqB2kdWjGQW+xS1jEXu5Bo9V2NiN2xY/yGKc+LO+FoIL0DcD0/LpHDcnqwGLv5sCuFN
	SsfHKPBVKM0rhkpr+AK5dvXPRlr/HX9q7KZxJa+rMy8icwLCh8Qr9yL2NvoISg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 23 Jan 2026 09:59:50 +0100
Subject: [yocto-autobuilder-helper][PATCH v2 7/9]
 scripts/release-parser.py: don't remove non-existing branch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-releases-parser-updates-v2-7-c24c30da807b@bootlin.com>
References: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
In-Reply-To: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=961;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=PJf9Lgmj65ADLTSRaleNhUQQIcaAupKWC5VnfVTKtaU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcziWjb91xWPJiP4OR1OS+wh3Q+4Qk6BTAoiFk
 YFbjpJOplmJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXM4lgAKCRDRgEFAKaOo
 NpziD/9tyCoB8jsnXpPT66NqusDmZKi8/IHx+3ARAUtw5JL/cWyOnFe/zmHuLvq7fPMC8JLZcfE
 nzwFWdimb/1EAUMoRFz8+s9FWeT4TdCnG9o58RDkbMp5gR4FasxOI2B5/u6SF7/OGnRmvYMMLt3
 dxSXNWcsbjGuJrkxdg7/PYVL7wmYeobo7ZQGLdU3+YiYe728FbKr30u5cMCRudJBGXAVnFcd96X
 9rM/WO8480/VaZfYLurZmBqabSkug4x3PVpBg+pnWwIqN2/1gNfDyHOXuKlffxwtMhYNaLM+s5E
 hTFb+v7Gfd/N11uE1RHwNy9ioNVTWyh9R5DaJBuS4PwxxJtnHpYY0flgmObFAWTvH4u7wm3YS1L
 9cUqlGzJhdCxYusdw7+50hrgm0fYTCPqQUsHvYZvQV+9+9eQW53GoMZRRzVQb2FePn5yCc/fcZ0
 gI6N4kR7Tqm+8ycUOc4yp1vIOXLzL4XKA6nU/9VBQAYbOO3xFMKdc3QA1Up/aOAMh3psv7iPGu+
 rktWaluFoc3vOc72BhTk06Owzq6ahPDcWfXYOwttaEdcDthPPpFcuiZU1ww2KFaIzOiM/iog7t0
 KRISkyZQQecLrQPTx2lwTI6DeNGkadGwANfH6F6u4cKRJzEVUG4u/aYkjbRwJ64mOtAMtC7+V5e
 B+WXAF+pMI37mAg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3062

The yocto-1.9 branch/tag does not exist on yocto-docs, so this call
fails with:

    branches.remove("yocto-1.9") # To deal with milestone 1 before 1.9 was renamed 2.0.
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ValueError: list.remove(x): x not in list

Remove it.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index cb56257..f161ef1 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -42,8 +42,6 @@ def get_git_tags():
     # Collect tag information into a list of dictionaries
     tag_list = []
     branches = sorted(set([tag.name[:9] for tag in tags]))
-    # Remove bad tags
-    branches.remove("yocto-1.9") # To deal with milestone 1 before 1.9 was renamed 2.0.
 
     odd_commit_strings = ["rc", "final", "docs"]
     for branch in branches:

-- 
2.52.0


