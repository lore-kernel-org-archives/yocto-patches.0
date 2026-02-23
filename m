Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFD4EA4FA7
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 11:03:34 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33030.1771844611799049524
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Feb 2026 03:03:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=uvBu8k57;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F0680C143C5
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DEE185FD43
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C90910368F66;
	Mon, 23 Feb 2026 12:03:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771844609; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1AL+T0nidbVLg8UWuTHU43novA795O4Ruk8HJS552H0=;
	b=uvBu8k57mME8YiSfz3SF9ph3aYxrTZezDAF/SGCo3Gu5WkBJpCkB8HkpxKaYokUJznI267
	sTyLMpfFk6McgdjuvCj11hbY50Xwk1roqgme48OpCJ0QukwpFOgjskenEmkmzLcwRwlmxA
	H+3ac5AEqZkzHLNKIn96e5ESwspN1hXP1DTM0yAQy06w39u32RNFGT3TrzyP2CoMG/lBrv
	xq8tUyOEuHPWU/VrenARtxupbnZqLlQP1APx5CZ2oINd0B/FU5Se+zKlInx1LGJ1kUx9da
	6SnSvzsqRL5TW3bOgzlJQocmUSzMdzLrcK8cl8ssG/kNM3S8/qrpbzfaSmKcjw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 23 Feb 2026 12:03:20 +0100
Subject: [yocto-autobuilder-helper][PATCH 1/4] scripts/run-docs-build: do
 not run set_versions.py manually
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-fix-switchers-js-ydocs-v1-1-6f58a78ee8c3@bootlin.com>
References: <20260223-fix-switchers-js-ydocs-v1-0-6f58a78ee8c3@bootlin.com>
In-Reply-To: <20260223-fix-switchers-js-ydocs-v1-0-6f58a78ee8c3@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=943;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=RLtc3Cu4VZdYpvUhpyOF3SWuUT6BIl4rrI+ITuIpXrQ=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpnDP+dihgRBLGXRp5F/D3owgVFKnMexYAcaQmu
 pcuhlyBXA2JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaZwz/gAKCRDRgEFAKaOo
 NoOEEADJZp2OFR1bCFlXaEw5pk71+pFoBY9BQictskZqMXSTOrUzCxNK40CWwUGy6Xgrc9k7fBg
 XbNt8bYrmA1VOpK0/0yjPdcjyhJEYlbY5jTUWdklaEgldox2OM1UGkmdCnYFRu//MR4jGPYyPj4
 56O5Zt+MwmpeQSXrfbfvsvUS82MzVOCMOhOMmmtwRA2AsqmAIUiqT+tmIaFuOgGL47dRrVFnTLE
 QFY23pqESpggDgZMfCnqeCihHm35szsGSP4bJq5+wmRSAulVLrDyM2Q0tbYCq62LhdvDOzLDs6V
 1OTl5P/5HrU++gvEpMpUTd/+Plu0vozE7d9Bza/w5U382rfKAP1JT/hrVY3zjdQfnG+VbTYvQph
 4FsGspfOo382+P4Whg18qXXp7gJ0NQ10bu0qGUOHa2Gs9jNW3nxrMPjOfwPUcYhDDNnSurt+3eR
 woO7nqMAITerbtlxXMWk4zgPWMCmYdlv4C2EjwTPcFQX+gylSA9vqQW0/VJgVS9k5zbi29nlJjq
 x8gY5fPescKpbcpvAHm+9a+aTdFkkXcKOEUc1QiMw6N8zGBZNk0GByIcYKNXo/Od5/J4fUw3ewP
 B5UxE3zK4sOXkMukO2awnCKksVxVFfHAoVLy6xUqxjk0sUiUlAK7bkLnzIWkO2dlWWDdUwFRFLM
 NfqJSkxKO17J/6Q==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3265

Recent changes to the set_versions.py script make this unnecessary, as
the version is automatically deduced in the script already.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 1d3b099..e64e447 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -202,14 +202,6 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
     git checkout origin/master sphinx-static/switchers.js.in set_versions.py
     if [ -e poky.yaml ]; then
         cp poky.yaml poky.yaml.in
-        case $branch in
-            yocto-*)
-                ./set_versions.py $(echo "$branch" | sed 's/yocto-//')
-                ;;
-            *)
-                ./set_versions.py
-                ;;
-        esac
     fi
 
     (

-- 
2.52.0


