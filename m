Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D75FF8864
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 09:15:31 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7337.1777454123950910725
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 02:15:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=XfDI+xvU;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D006EC5CD50
	for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 09:16:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BAF2B601DF
	for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 09:15:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8AB810729A19;
	Wed, 29 Apr 2026 11:15:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777454121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=O0xQyOzA25+7rTrXCR3aB4lPesH0gumukNTaWF9UF3E=;
	b=XfDI+xvU4i6pCt32lRMaKi14yImxMl3rRAOYT+gCjoCrDjKpGDWLOLjwTZooyUO6B/mtL3
	Ls55cqD7IdW+KKjcrJenVIYNa+wCsODIHBXCj6z6IxD+TABjgwFEughgSbAfE9vkiEElN3
	BBnMGl1hqQY/NoCzcKXaSlfOTlPUw/br9f2K0wc/3LRrGG9RwPyepGd50ZXnb7E0RmSv4z
	8ie8QBlZHvPzB5mgSb4I2Tq0vUVqDmSIQNx6lMrVX7cRh6SQchRuGkeQx3wCKJMQXk5Jhi
	1+joDiXEe/yUV3P4XIAOiEu41VJXGE8ZRNk6ZqU6tWVP3vpSxK8LwXKiDlOWLQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 29 Apr 2026 11:15:16 +0200
Subject: [yocto-autobuilder-helper][PATCH] scripts/run-docs-build: use
 bitbake's setversions.py to get the latest branch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-fix-docs-bitbake-latest-branch-v1-1-25cce6bf4f26@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBCF4auQWTsJVALEqxAW03aUUdKSdjAaw
 t2tuvwW7387ZE7CGS7VDomfkiWGguZUgZsp3BjFF4OpTVe3ZsCrvNBHl9GKWnowLqScFW2i4Gb
 s2r5xNQ3cnwlKZE1cFr+Dcfo7b/bOTr/V8R2dRqRNo91k8Zxw5mXlNMFxfABZ0JxxnAAAAA==
X-Change-ID: 20260428-fix-docs-bitbake-latest-branch-6471c0a8e73a
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=ZDSq9Te20a3EfOIMgpsJxxt+rvjuOkiBpATVZggc9Cs=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBp8cwoK0luAcysvycy2p+DJwIn07/RJi5EKp1rW
 1aY4D1FOwyJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCafHMKAAKCRDRgEFAKaOo
 NvYJEACfDlMpQ4BHUSS5/WK4/YboXj8wAHYvkQcq7DB8S3MTFL5XwOIm72IST8ic3Y7QiAypByz
 Mzyylw2M1LbHcz+qcRFO2NRQ51HFayCAkD4lJC5MP7LTN6W4wL+Bz+EBRcy01y2Hkl5/YWpxB/f
 mFcjnnDUNyXcLe+ZZAQbl6sRF93fBcKVWdt+8tsqIxnWY3oDwuIeQRoPLglZQn+xoZlYcBmDfY8
 0gjeWZ1LdKDfamxDUxWi+XJzyAmbNjOF3rM+rCAbrTv8tnC7AXvFDfN7vgTXcITUlXaBQ04QH0D
 hDT3NyA3kW4dG4HBKpPQTBng8eNvSIKbana1tVPnHScW5PvwkF7mHJ32OIZh+Ilp74owtayS1YI
 HMSuNLYmtSIAqxv+6f6ZYNMahZykpfKd6/y0k0uFUHZW0KfUG33L4WqTiNuMhZOsmhAPr0YMQUE
 3RqBmOXJVVQ3sivEzATlj3QtqPSorAcyxconsPxwvlE9HlRlKdAblQhcU744qt+S7iM5+Z2FDLA
 UydK9KlILeTidZG7SLoHEW4emP2WK09/jcyNKTNbIEe45rcLAQ5OMWjT2R7sElGs4Zc5XMfeJ7S
 ucPpTlm1a09FpIN9YfFzWEZoLZDbGYEPwPcfXcwVbOL/07w8JFVh810XoZmEl6+hZu+7+0nsVS0
 uoJmns+4tkwTjAw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 09:15:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3873

The current script uses the list of branches to determine the current
latest bitbake version to show as the default page on
https://docs.yoctoproject.org/bitbake. However, this is not necessarily
the right branch, for example if the branch was created before it was
officially released.

Use the setversions.py script's --get-latest-branch argument for that,
which returns the latest branch based on what is found in the
releases.json file. Double check that this branch looks correct and exit
if not.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
NOTE: depends on https://lore.kernel.org/r/20260429-doc-get-latest-branch-v1-1-e5a0ce87cec4@bootlin.com
---
 scripts/run-docs-build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index acd8a24..090e5b0 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -111,7 +111,12 @@ mkdir $outputdir/bitbake
 # see the latest releases.
 first_sphinx_commit=84ccba0f4aff91528f764523fe1205a354c889ed
 
-latest_branch=$(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)' --sort='-version:refname' | grep --max-count=1 "[0-9]*\.[0-9]*")
+latest_branch=$(./setversions.py --get-latest-branch 2>/dev/null)
+if ! echo "$latest_branch" | grep -qE "^[0-9]+\.[0-9]+$"; then
+  echo "Got unexpected branch from ./set_versions.py: $latest_branch"
+  echo "Should be in X.Y format"
+  exit 1
+fi
 
 for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)'); do
     if [ "$branch" = "HEAD" ]; then

---
base-commit: 7ba82651cae130890e2120dccca939153ec7042e
change-id: 20260428-fix-docs-bitbake-latest-branch-6471c0a8e73a


