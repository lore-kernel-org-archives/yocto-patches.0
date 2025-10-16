Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39436CCD1A2
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 13:20:23 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.8313.1760620822016284419
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 06:20:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=IMCETQmK;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B414E1A1430
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8AE3C6062C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E4C9102F2309;
	Thu, 16 Oct 2025 15:20:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760620819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=a1ReeITivHOL14+hY2qYQDWJUpTEMX8IEQTF5zGwMoI=;
	b=IMCETQmKkjDKXgn0sSR/JZsEXYsYBD5AUiC1Lb+fDKu7B8S9+nlop6NjyaXdnyR6x43Q6X
	uaOK/xn0OWoEZuJgtFM8eNlUMoEM6OkJ7i9MbxKCO1c2UJn8JahlqnuIKrFlwaB5okrQHh
	ZohfxHCgltQue2UafgJ3pxOXRyCytGiCTqGCB1vk7vtv3bV7kiVCemxyMbnXfw/07LyJeU
	wvUymwy48F6Dhi0vKWAm43kpSVfer4PqiB6qLDBn6QJYdgzgL3vuy1d5Smq0HOzKRkKAXx
	MRoA4Qm/IrDExPmplkd8DaK4whtacfcxWgbuUmHj7PpQ9dFY/mNChGhBKXHmnw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 16 Oct 2025 15:20:14 +0200
Subject: [PATCH yocto-autobuilder2 v2 3/6] yocto_console_view: fix error
 link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-contrib-mathieu-bb-setup-links-v2-3-095908455e0b@bootlin.com>
References: <20251016-contrib-mathieu-bb-setup-links-v2-0-095908455e0b@bootlin.com>
In-Reply-To: <20251016-contrib-mathieu-bb-setup-links-v2-0-095908455e0b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760620815; l=1965;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=3nV2ECtsV3As0UMgR0uiUCbYgTaIe7n5bMmbhOprw1Y=;
 b=PaLBDy/G+Apv9SCOeCEIgf84bXv0Ro73PKqYSsTxkSaZ1o9FnPVVMTYEiFSb7YzvXqvi08w/i
 h2eIgL7n5Y7D/b3z7udKZsr0IRq9Hk3tq07YOE6Ew9LFJHBFEhzNq6X
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2316

This might need to be updated once https://errors.yoctoproject.org is
fixed for the bitbake-setup switch.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/views/ConsoleView/ConsoleView.tsx | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index dd84c7913cda..19b24d1a0427 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
@@ -197,6 +197,7 @@ function selectChangeForBuild(build: Build, buildset: Buildset,
       if (!use_bitbake_setup) {
         change.change.poky_revlink = "http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=" + revision;
         change.change.poky_revision = revision;
+        change.change.errorlink = "http://errors.yoctoproject.org/Errors/Latest/?filter=" + revision + "&type=commit&limit=150";
       } else {
         // We might retrieve the "use_bitbake_setup" after the first execution, so wrong poky data might have been added: remove them.
         change.change.poky_revlink = change.change.poky_revision = undefined;
@@ -205,8 +206,8 @@ function selectChangeForBuild(build: Build, buildset: Buildset,
         change.change.bitbake_revlink = "https://git.openembedded.org/bitbake/commit/?id=" + bitbake_revision;
         change.change.oecore_revision = oecore_revision;
         change.change.bitbake_revision = bitbake_revision;
+        change.change.errorlink = "http://errors.yoctoproject.org/Errors/Latest/?filter=" + oecore_revision + "&type=commit&limit=150";
       }
-      change.change.errorlink = "http://errors.yoctoproject.org/Errors/Latest/?filter=" + revision + "&type=commit&limit=150";
 
       let bid = build.buildid;
       if ((buildset !== null) && (buildset.parent_buildid != null)) {

-- 
2.47.3


