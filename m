Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E03CAC592
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 12:21:51 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web10.31620.1757938910578625921
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Sep 2025 05:21:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=stGO5uSl;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0C396C8F1D2
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 12:21:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 565BE6063F
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 12:21:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6013102F2AE8;
	Mon, 15 Sep 2025 14:21:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757938909; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qxqq5I3vLjw13VHUnzfMmKT1KNl0LEFheI6lDVGBd6A=;
	b=stGO5uSl7GEV1hxOpWplqnkNuvSlWE2kR4eZws9GwS5lpEv+KCa0qc/rhhISMb9/D0Nkw9
	xKkVNoybhxEnpcOD1pjYKK9ORP2OERqxv+C1CA6jVje7fc4TPUP+kuZrsv3P7pyRb20ymK
	gjCPrpMq8Z/EmR+a+1LQykOldr03GW3e0Rot8Esbt4KNwDopzWTSopOHC/3D3PTZN0MoYM
	w63C02bqsgmD49M05JbumV30rAryAI5qxrRg8xK2D4UkWnIta58XH2oLYf2I11OWoYqe3p
	ntEhNuL/4SxnUapJVxoXRYe0uhjDumRDNfybMNP8g0NdOPRmjARevDkXOIFaDw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 15 Sep 2025 14:19:49 +0200
Subject: [yocto-autobuilder-helper][PATCH 3/3] scripts/run-docs-build: pass
 version to bitbake docs build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-pass-bitbake-active-releases-v1-3-a5530a97b9ef@bootlin.com>
References: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com>
In-Reply-To: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=OuFVy/NEPssXn11jN0aVuUYQHiP5P8m90+FyWUj3pF4=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoyATazcWpQnomFR/fb4u69oyGUji5MF3nnT44D
 F8FjP7LmMCJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaMgE2gAKCRDRgEFAKaOo
 NvB8EAClK5qXhvmd7GFfR2AQsUaJ2f1St2bO5h9HCIWCxrP0DZgQqZYEPv4KZSucA13HRw7DVTK
 GgDRMMBXHxfg7tYvzD5X899ttSGlXXkJ8XF2eI+er7CyaIIqI7vvvabYPspa+VmLoSgGARBpsgB
 /HfCbYXmErOMAOSu0E2tQZp/vY+XxkkYWoedEw2FQF5Ff9A2fZ6bHRwshGV4yuUzu9BL7GCt5Bj
 mz+EeVTJmA+LJwsikNhnSTIRlrwZfCVQUQHar2rfOusVEfdEt1Z/Osm8gGTQF7fBgNjJzz2wiuv
 64u/UfUd6rq9EVo/MFn0V3kQEeGCrAwnO4wLTlFDhcTQJ5tTBd18sB3HxMPfShztbUAmMnfmMtz
 x6wtWGuqwFgOAH0CNZHGl2G3Pdt4rFDTX8GFhky9T0VZU70I0p3qyvqwpv6mXybtagwnG53doEQ
 ltP3odMaxbo+GNfZr93l2aPAcPhnKyz7qE1UWbrB8hScQlgzLgR6yC/Uwsd2+JRb/97QgHIYuZV
 r3jrhMZMOiAm7EWu3o3YlviLQ7NvJA+gfNrGHNPDUwd7AVXmkRx6i4dN9bT63o2d4xiUKYoHH97
 cAwKizkRntybiOM3Se6ZH5cWK4UsXhCxXRbBYMVkDWoIGfDS9/GhzTCAWpmP8avwuOvGHb64f6B
 FtwIvRdHyg4ynQQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 12:21:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2190

Bitbake's conf does is not aware of the current version it is building.
Pass the information, which is read from bitbake/doc/conf.py. We have to
checkout conf.py from master in additions to this, so this change
applied on all branches.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 549032f..654b401 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -138,7 +138,11 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
     git checkout $branch
     git reset --hard
     git clean -ffdx
-    git checkout origin/master releases.rst set_versions.py sphinx-static/switchers.js.in Makefile
+    git checkout origin/master releases.rst set_versions.py sphinx-static/switchers.js.in Makefile conf.py
+
+    # Pass this information to Bitbake so the docs gets built on the proper
+    # version. See bitbake/doc/conf.py.
+    export BITBAKE_CURRENT_VERSION="$branch"
 
     (
         . $builddir/buildtools/environment-setup*
@@ -213,7 +217,7 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
         git am "${scriptdir}/docs-build-patches/${branch}/"000*
     fi
 
-    git checkout origin/master sphinx-static/switchers.js.in set_versions.py
+    git checkout tmp sphinx-static/switchers.js.in set_versions.py Makefile
     if [ -e poky.yaml ]; then
         cp poky.yaml poky.yaml.in
         case $branch in

-- 
2.51.0


