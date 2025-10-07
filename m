Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC68CCD18B
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:34 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.20535.1759847848675975747
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Qer7vVhb;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 657751A1169
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D969606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 83820102F216B;
	Tue,  7 Oct 2025 16:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847846; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ngzc4cRpkiV9RSNmy5vim5w5ZrsMe5hgHqnfNFqwf7I=;
	b=Qer7vVhb/hrqDvNeW0V/t1aRjz7gQJlBhP7WyQ6nawFbTNUlcb+XLLdm3ahs1N/yd+6ZlB
	LjGNisvVJebj/3Qw/xvZ+D/dXMsZpxNJmeRAZrYcO95XU4hKMPVAouS6RlOlgkYwWW38u5
	AzIoCrbEiTx6wU7oeSu9ZRNE50smKGG9Cd0ZntlpAv1zVIVmZs250qWGazRso40VfFLhHI
	nt44Dh43kNk3414gBZzKxRIxJnotd9mdKYwHbvIgXwX3+gItNCAH9lT+hXtV1ZjjU87DZ1
	tED6SonGiRFNqISpnPqUIAP/i97KWT0OF0yQl0auEI7V3dNeuxMy5cnpyfIVhw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Oct 2025 16:37:23 +0200
Subject: [PATCH yocto-autobuilder2 07/10] yocto_console_view: fix error
 link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-contrib-mathieu-bb-setup-links-v1-7-bb1d79289c3f@bootlin.com>
References: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
In-Reply-To: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847841; l=2021;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=OOUSMFHiGOKuzdmHtqWnA6Me8OfsI9afGGkh8+HZaNs=;
 b=YIrSWdImXXODBg76Qn1JV5TTXWKswLH1Cc3QKRcDd48Khe6AIk2gMZQtbZGsbo7OU5g/yBc4E
 42pCLgVPvkUBFwC6WUItFQ9CwAFU3qC6KdWfcvyioL0Q2bOPlo4dwXl
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2283

This might need to be updated once https://errors.yoctoproject.org is
fixed for the bitbake-setup switch.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/views/ConsoleView/ConsoleView.tsx | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index dd84c7913cdab3ae3e4537e4b00d0fb077be4b71..19b24d1a04270f71bda9ea8b55b62196be79f7b7 100644
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


