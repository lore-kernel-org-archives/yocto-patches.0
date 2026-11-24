Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17423.1795526093765163149
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Nov 2026 05:14:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=prZrElsl;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6B875C2C648
	for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:14:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0353F601E1
	for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:14:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4DDD411E6868D;
	Tue, 24 Nov 2026 14:14:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795526087; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mz7VrdZJs9P+blclLLPD49oLTuoM3b3FI92jvPchAz8=;
	b=prZrElslU48g7lsiLS8d4XoI2NsetcrOUxgN9cGkKckmUDiWPnpNK21ZaGvTdxg7J0RIwn
	/KhXwn4WxoDaA0ndLoJO6waNqIlzYymZBaRvER09MfoZ8B9sU98xX1EHFryedrTL5lXGV5
	4oIkTiMctLyJzFkWoNu0Z1/FOXoty7Xe+cE18Pw8IlW689qXljGLnRrvkn1ZNRehmdPtd6
	RPnVqjon2NKth+/ZSbT33B2p+WChbxVp4qz3fqMF4+aEjCLeISO9llVkRn/SzLSPxkdA6p
	YWe40BOQbhDYCnm5uAPenqE13pHryvxwFO/2+cW2PGBEBAZpKj30DnpuC5Sdrw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 24 Nov 2026 14:14:35 +0100
Subject: [yocto-autobuilder-helper][PATCH 1/4] scripts/run-docs-build: add
 openembedded-core as new argument of the script
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-docs-build-oecore-functions-v1-1-ce9f3c4fbad4@bootlin.com>
References: <20261124-docs-build-oecore-functions-v1-0-ce9f3c4fbad4@bootlin.com>
In-Reply-To: <20261124-docs-build-oecore-functions-v1-0-ce9f3c4fbad4@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=769;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=dtiwNZYXLI5JPAn3olbHhjUccEpT1YmBshA3OVtedfM=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBrBY282KjrGaPADZtTOQWSD9ZdTKBCsP8vbVKh3
 Ux+GJVdouaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCawWNvAAKCRDRgEFAKaOo
 Nnb8D/97xD6yngdkwnk5EoN2NEazaeMwrECWyZvMn3I7F4VqvOWC4KITB6o/Vg4x1CmFK4D5v62
 yP0EvxC1i93GiDm/FZrzUUGRDRUsc6amMdwcoXF8RAXzd7teotBal3CoIMnvO1qLhNdX3nbPlnU
 xpc03BUNAQdbogGzKGC6+OqbC20y8fQGQPcpsGBlxNWixvYIK0YqNqNgA1OXCSv6e2dx5Kow8q0
 GlfDbbpWzFmenYyN/hQNfr7MtMZT0ltNNahWq2D8RdzxKejRu5hRWw6+szdueb5PRoWhN6aIjPX
 9ubxvmDiG+w7j/vqjXEzsg2Ajute+A1JvOGDI6DmllkfrLhREFWrNvED1a3kABtbWF8uqutnf+P
 UgDd5Na1x2GI9FY3qvpTsG94HOQsXucoubzYvMytPI102mhTtBYMqtwJu5QgmvRpFN4b44uf6re
 isuGGAC2BmCTXJs1rfJPDhg2YdQ1p5mGDpoqZlD1i8WoV1zJmD8hZiMOmpxUoZqQdIdNqKdeWur
 FyzlN6o/eXUYehhQ4uLrnuqcQLPQO+nVzewZPcg5i6XJJoCtiSQ6WoFKstBIR2kqfVU2ZTYa6VG
 jwGRHKm05eYwDL5YYK37ZD8EA1qlRsZPO0yBtSthV38JYqpSFsQv1rDNXdsaE2ktLJwLmYUclaB
 3fozPRRaoFGKy4A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:14:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5508

The script should now support openembedded-core as an argument to be
able to auto-document library functions in meta/lib/. This directory is
passed from yocto-autobuilder2's Buildbot configuration.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 438a1fd..57044f2 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -24,6 +24,7 @@ set -x
 builddir=$(realpath "$1")
 ypdocs=$(realpath "$2/documentation/")
 bbdocs=$(realpath "$3/doc/")
+oecore=$(realpath "$4")
 outputdir=$builddir/output
 scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
 PUBLISH=${PUBLISH:-1}

-- 
2.56.0

