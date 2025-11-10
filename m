Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ECACCFA13
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 09:56:12 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44902.1762768568156477352
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Nov 2025 01:56:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=qiqxAi0v;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 58C194E41606
	for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 09:56:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2B571606F5
	for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 09:56:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3685103716F0;
	Mon, 10 Nov 2025 10:56:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762768565; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=jbFrU7QctMZvAgx4FoajeNkwiB3/0Pn9ITUTG056//M=;
	b=qiqxAi0vdlKF2eD0rgoS2P0RlF1XB+N5/wSBQdnlUQp0TWTHY1tMUNfo1u8YON+PWrRaPG
	S4RrjguuhPury7uzZGUpr6g2YmU6W/kDqQwPbXj2qWBRRCs9IbMEL8uzVoSyY7sx6IGmoU
	ENffoYN6iA3cAtVbDGgVPNNgpfvX+ja3R1chWLTZAqwiIIIPJ/htMFZ18OE0VGMNZTQICe
	nrsCBljEvqtWCnLj47rVlazCbNRMNrYuIpsRa+G4POMHVs7Pb+4fIl6FqJ5gBDRmxQ91La
	XXC+mabXeN/YOTEjVcf6ywelaP50V7t1roslzOl64vfVhyDvmasON2mt2K3VGg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 10 Nov 2025 10:55:51 +0100
Subject: [PATCH yocto-autobuilder2 v2] consoleview: fix handling of
 undefined URL strings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-mathieu-fix-url-replace-v2-1-ee360c02a1ea@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAKa2EWkC/4WNTQqDMBBGr1Jm3SlJqla66j2KixjHOqCO5Ecq4
 t0bvECXD973vR0CeaYAz8sOnlYOLHMGc72AG+z8IeQuMxhlSq1VjZONA1PCnr+Y/IieltE6wkd
 fGVv0tqxaBXm9eMrK+fyGTVwUtClKm3jsyBtosjNwiOK3M77q0/zbWTVqdKRcrQp37zS9WpE48
 nxzMkFzHMcPw3U6BtQAAAA=
X-Change-ID: 20251108-mathieu-fix-url-replace-7f62a4fa56b0
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762768564; l=3769;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=GFVhxBMOTR/ZXxweJT44AAc0IhZXXMCNRwEg1GgCxJk=;
 b=IXdgUjqpQ9vhzqI0X9s39cJKLwfEfpSyvCSNgHPQyid5yUpIG5BWA2Lc0+ddBeRhySqhXj3C0
 ip/aUVZs0NHBZBT8wFb5ZY9tAmNYDjQ/kEdviRK1s9D5BRo+ChzMAi3
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 09:56:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2471

Some errors were observed on the console view when the URL string is
undefined. Just mask URLs in such case, as it would otherwise lead to a
JS exception.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v2:
- Trying to fix the whole logic instead of just skipping undefined
  values.
- Link to v1: https://lore.kernel.org/r/20251108-mathieu-fix-url-replace-v1-1-ce0c804c3d1e@bootlin.com
---
 .../src/views/ConsoleView/ConsoleView.tsx          | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index 16569ea9eac8..14276ce92da9 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
@@ -185,16 +185,16 @@ function selectChangeForBuild(build: Build, buildset: Buildset,
         oecore_revision = build.properties['commit_oecore'][0];
       }
       if ('repo_oecore' in build.properties) {
-        oecore_repo = build.properties['repo_oecore'][0];
+        oecore_repo = getHttpURL(build.properties['repo_oecore'][0]);
       }
       if ('commit_oecore' in build.properties) {
         bitbake_revision = build.properties['commit_bitbake'][0];
       }
       if ('repo_bitbake' in build.properties) {
-        bitbake_repo = build.properties['repo_bitbake'][0];
+        bitbake_repo = getHttpURL(build.properties['repo_bitbake'][0]);
       }
       if ('repo_poky' in build.properties) {
-        poky_repo = build.properties['repo_poky'][0];
+        poky_repo = getHttpURL(build.properties['repo_poky'][0]);
       }
       if ('use_bitbake_setup' in build.properties) {
         use_bitbake_setup = build.properties['use_bitbake_setup'][0];
@@ -220,20 +220,22 @@ function selectChangeForBuild(build: Build, buildset: Buildset,
         change.change.caption = branchMapping[build.buildid];
       }
 
-      oecore_repo = getHttpURL(oecore_repo);
-      bitbake_repo = getHttpURL(bitbake_repo);
-      poky_repo = getHttpURL(poky_repo);
-
       if (!use_bitbake_setup) {
-        change.change.poky_revlink = poky_repo + "/commit/?id=" + revision;
+        if (poky_repo !== undefined) {
+          change.change.poky_revlink = poky_repo + "/commit/?id=" + revision;
+        }
         change.change.poky_revision = revision;
         change.change.errorlink = "http://errors.yoctoproject.org/Errors/Latest/?filter=" + revision + "&type=commit&limit=150";
       } else {
         // We might retrieve the "use_bitbake_setup" after the first execution, so wrong poky data might have been added: remove them.
         change.change.poky_revlink = change.change.poky_revision = undefined;
 
-        change.change.oecore_revlink = oecore_repo + "/commit/?id=" + oecore_revision;
-        change.change.bitbake_revlink = bitbake_repo + "/commit/?id=" + bitbake_revision;
+        if (oecore_repo !== undefined) {
+          change.change.oecore_revlink = oecore_repo + "/commit/?id=" + oecore_revision;
+        }
+        if (bitbake_repo !== undefined) {
+          change.change.bitbake_revlink = bitbake_repo + "/commit/?id=" + bitbake_revision;
+        }
         change.change.oecore_revision = oecore_revision;
         change.change.bitbake_revision = bitbake_revision;
         change.change.errorlink = "http://errors.yoctoproject.org/Errors/Latest/?filter=" + oecore_revision + "&type=commit&limit=150";

---
base-commit: fdc34623463b1c708220021649ba4b8b53db3dbf
change-id: 20251108-mathieu-fix-url-replace-7f62a4fa56b0

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


