Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235D4FC592F
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 11:56:40 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.68250.1772106989452270668
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 03:56:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Mechzebp;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 434EE1A13BA
	for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 11:56:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 100A25FDEB
	for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 11:56:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56F8C1036934B;
	Thu, 26 Feb 2026 12:56:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772106986; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=EWs6t7GKd6a2PRmZWwG4hNOzQpatVRmKSNd2dHSHlrw=;
	b=MechzebpTmoUN7yt1BkZmhjw5qMPMXufU/ECmNG+hbsj37yoCx3Ifv+uT5JbS96c/xOErW
	hurqnhOPWb54xf0V1nfpetjNXapV1XWOPZF0HUr5lgxRwZHf+c1o/oSSUoznYGebEuEgHn
	AJzKei8vey5YChGiR2cqxKmd/WcnPgPX+gkXCnLwOXPVHLbk9SstCezB4hbzuHrljQRi0c
	0zpMj+SRmedZVsDhqI//7K5umpV4NuSI3UPOVYqvkzrZbpfDnzHaGddBkENiCvNpgpwIx3
	nCUKuuZX4ezY9dyWz6D2a35+KC60gxou+GmFvtNigfGYmjPp+nspWGDGwp91Yg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 26 Feb 2026 12:56:19 +0100
Subject: [yocto-autobuilder-helper][PATCH] scripts/run-docs-build: export
 LATEXMKOPTS to make latexmk silent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-docs-silent-latexmk-v1-1-c8aceabe2357@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQrCMBBA4auUWTsQBwzqVUoXaTKxozEp+ZFK6
 d2tuvwW761QOAsXuHYrZH5JkRR3HA8d2MnEG6O43UCKtCLS6JItWCRwrBhM5eX5wMtZaU8nZcg
 T7OWc2cvyu/bD36WNd7b1u+rfydaEptU0NgmOM04cZs4DbNsHQGyvH5EAAAA=
X-Change-ID: 20260226-docs-silent-latexmk-9806f250a2f2
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=GRhgUhdgg/JfQFC5TVWxhWH8ME2gSXTK4nZDkbRT8xE=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpoDTpg0PiDenlB/CoXSRdLhrbG4p/S0RduVyu/
 2QZDqTpUsyJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaaA06QAKCRDRgEFAKaOo
 Nmq7EADIEtONTT3kjxiCyNXzT7GZdhWdkLgLpAf540IYX1V8Z4HQ7XZqw3xOkfWPCMRs6lPbvpQ
 TRBxXO7JP+VAAUvs6bocnO91Lh4fdPpGCLm7HlgN4k1SByB5dPw6opaoZm4xdUDbo2XCULA0xdu
 hm+ql8TzRcjW600dvXzDuW/NBG0DXNzHOAq/qQlPaHDc4Crd7PEdfAU/pRvCJCe4yyvDX4r13l8
 7GBYUCSH4PhomADFbd2jIfkslWkHZI2ddwI5/l2f76nDPMefJ7i4CIQYrx2JOsy3he2OP/PAZy1
 AE0BFvaOHs2G5QL9cbT+zxIctE3oLh0Rp1aWBep05z/M8A06iQy3PvOfsosIIOgMvIeuWRAC+JK
 8P8A4g8oR+VhwrXYGHzQinGM1sz9Y14DLOBn3l8AekJI26aqoqWhV6XwXLwMC7JXgpRK7nV5AKX
 Kofe9SrBL8n2t8VLYqstsb9LYPET2BNCw7B3LJrIcWyzfbLWP9q71/fTMo73vj3i7cdYQY41Im5
 mIml2cU8LMqh0yIMXELQAQZPXRDqDeJce923PmYlM0mwBPatSnlHdxEL0qTJV/lNP6R3sAOV8Io
 UlnbC7LSFYUM6aO/oV7erdZUiXpDCMjHOphcet90DAEiCBHa8BfZAjFf+Jj91F8+mYNyjVsQE90
 2CkrOEdu0msJHmQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 11:56:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3281

Like what is done in [1], make latexmk silent to drastically reduce the
amount of lines printed on the console. We already have this on
yocto-docs, but since we build old tags on the Autobuilder we would
still have the output for these. Export here so it applies to all
builds.

[1]: https://lore.kernel.org/yocto-docs/20260219-latexmk-quiet-v1-1-acc137bc88b9@bootlin.com/

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index b97f20c..97c5d7a 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -173,6 +173,8 @@ latest_tag=$(./set_versions.py getlatest)
 git reset --hard
 git clean -ffdx
 
+export LATEXMKOPTS="-silent"
+
 for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)') $(git tag --contains "$first_sphinx_commit" --contains "$first_dunfell_sphinx_commit" 'yocto-*'); do
     if [ "$branch" = "HEAD" ]; then
         continue

---
base-commit: 50c2af6d82e6af4d42d99cee5614212c6cfd272f
change-id: 20260226-docs-silent-latexmk-9806f250a2f2


