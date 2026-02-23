Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A13EA4FAC
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 11:03:35 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33032.1771844612163866406
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Feb 2026 03:03:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=qO94ATVH;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 72FEEC143C6
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61F685FD43
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C640C10368F7C;
	Mon, 23 Feb 2026 12:03:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771844610; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uKL2Tl7tj+LQa7+SEbNDNPjlDnEkf7nLTIv1GVB23jA=;
	b=qO94ATVHTT/lDP+CPM55lYQnp0VXF8imzSyRQ4GL84CpEm93b1mPCRraZUomA5Y8QJRaL1
	zbinRq1iMWmMryL9Q2wGhEvAdv3Ghj9VmFsupjZpWtKTwLjCegvUwDIUXp6xUudO6B8Dxw
	fyqWVmFF1e3sYF1ZQQB4OwwmxaSW7KD9DyU8CIWfoA6diKBdhZn1w5R+SPyS/ImP6nUaMZ
	lmEv1Upz0QjUATfySy4cLBUTXE5XLO5J9FJh7lS3NwgpZtaEDo12mXUx6fPDdorvB2AaDj
	fjIgQKlSkBONGN/axwH7SanzXC/ydtvii5uIgv2jxqB81lVrYZXq9SqStLy/XQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 23 Feb 2026 12:03:21 +0100
Subject: [yocto-autobuilder-helper][PATCH 2/4] scripts/run-docs-build:
 remove transition from built branches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-fix-switchers-js-ydocs-v1-2-6f58a78ee8c3@bootlin.com>
References: <20260223-fix-switchers-js-ydocs-v1-0-6f58a78ee8c3@bootlin.com>
In-Reply-To: <20260223-fix-switchers-js-ydocs-v1-0-6f58a78ee8c3@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=953;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=AOnd7bA3ns/G4CHLisOm9F7DNr2mzzvsfZIF9Vm6d/o=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpnDP/Y8XTjQtn9ZFYpfzV1hbT23vWqhtIRG1hl
 WJRvEnt4ruJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaZwz/wAKCRDRgEFAKaOo
 NuwND/9WLzGPNbx6GEM8sqGon2R6RD6wKfeLq7hQhX53NjtxVv6TBec/6qwDY6rrfKUzB/lDhce
 UKYXO2HsQmqOBAEXZxDjBXME51W5WZU8DhXsgd38JDaj0v690LDTIVsrMwadLja855h3Agj+bNT
 LjTDumtK6ftrxs3o1B6o+rZ0exgaGNtTfjyOE4c3PyTW5btCgdH8rR0mAPdmhV41tG03YmwVmDv
 uI3ygk21eOtmMD6krzV9XwLRuYD6bgqSSD5WGxIHcvwKvGjwT+4EkL7ZFe9J63IXdUyqSwLf/xm
 UCFzYAVJjy8O7SiaSltbZQLzYcpcvu6w2fwbhqTZZROHkKGezJ/A7mHhRJrlxmfhRW/Ju0f7jnG
 a7xSylzUDAlM7BDXTlD8Xjl1K56RMXGDbZkVlMn+SPkK2Ge43Oop9u7KPz0Xn+PddTgD5t8gxps
 SSPZerH63cllYsoGTxzMHDLsJ5u7U/00IX9+z9apDZhkcKJjTq4Wz2fgSewipMtgeeT2NtpEG2W
 T3/SptDk+7QefPZ8QNlqUdPROt0/9e0+XL/LKxYyNFCicpwokElAFpzy2XmjTxhanByUXd05hYC
 2Jklh+lNGAsbd4j8Shop9IOBqzkDo7gNSB1N/vHB0v3JrzfZgtJOApvhxXCxKNjWtm6DxRilmZW
 ymbzG7Rq+MKQkzw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3264

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index e64e447..924b446 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -173,7 +173,7 @@ latest_tag=$(./set_versions.py getlatest)
 git reset --hard
 git clean -ffdx
 
-for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)') $(git tag --contains "$first_sphinx_commit" --contains "$first_dunfell_sphinx_commit" 'yocto-*') transition; do
+for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)') $(git tag --contains "$first_sphinx_commit" --contains "$first_dunfell_sphinx_commit" 'yocto-*'); do
     if [ "$branch" = "HEAD" ]; then
         continue
     fi

-- 
2.52.0


