Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A5BCCFA18
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 14:31:38 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6607.1762612294837792502
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 06:31:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=wgrvx88V;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6B650C0E63E
	for <yocto-patches@lists.yoctoproject.org>; Sat,  8 Nov 2025 14:31:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA91960710
	for <yocto-patches@lists.yoctoproject.org>; Sat,  8 Nov 2025 14:31:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36DB311850330;
	Sat,  8 Nov 2025 15:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762612292; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=GppHZe7aH6OCi+ycfODyxdNsUhtp7XkrNVRw/RpVoi8=;
	b=wgrvx88VSN2IT+3r8rEP4l8ZIG4XnMmWvam1VwFXQlklnqWHSfUS4id5HACdCUt7zcCpGU
	kq97FFRR7PChSr81JMBXsb9O51SFlRQ4uj5T9hO1+SwZC7zx6XRW0WUXj/IK+r0jfVnTbA
	c0y6hLAIEea7cxU4EPPvfEsmvf1FB644FUxyn2y79faYsDhMtzrT991UPXNxiSfiM8LjOf
	H7SaXtase/NcvGZlFb1gozUsmtdFYDOMyMc9dOcvZ7AyQVrBYr7FMmROWoM4NMuSud19Py
	GESLS0hRYTEPeEEMJm9LHtmrSgaljZ2WYl6olOlBJpKhgrIM+HXqZjTvQU3T+w==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Sat, 08 Nov 2025 15:31:09 +0100
Subject: [PATCH yocto-autobuilder2] consoleview: fix handling of undefined
 URL strings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-mathieu-fix-url-replace-v1-1-ce0c804c3d1e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIACxUD2kC/x2MQQqDMBAAvyJ77kISqi39SulhjZu6kBrZJKVF/
 LvB48DMbJBZhTM8ug2Uv5IlLQ3spQM/0/JmlKkxOON6a80dP1Rm4YpBflg1ovIayTPewuDoGqg
 fRgOtXpWbcp6f8E++JKRa0lglTqwOXvt+AFy/9Hd9AAAA
X-Change-ID: 20251108-mathieu-fix-url-replace-7f62a4fa56b0
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762612291; l=1186;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=Wjy1IYs5yHW4dT2xsSj5CrO34kLG/JXCGQewcOx1dVY=;
 b=o2hhSFqt1JxzW8bg4ceMWVDDP1TkQNeL/RgK3oz5zAaYYhWqkLzGZsd1f/1+JLKH12t6vkt2z
 wV9FNdC3b2GCGSEkYe1kesrVLSCriq/to+r+GNogy8YX9VVWTYEs7XK
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 14:31:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2432

Some errors were observed on the console view when the URL string is
undefined. Reason for undefined URLs is unexplained so far, but we
should at least try to not generate any JS exception.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/views/ConsoleView/ConsoleView.tsx | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index 16569ea9eac8..a30402a9a335 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
@@ -156,6 +156,10 @@ const gitHostAliases = new Map([
 
 function getHttpURL(url)
 {
+       if (url === undefined) {
+               return url;
+       }
+
        let u = new URL(url.replace(RegExp("^[a-z]*://"), "https://"));
        u.username = "";
        if (gitHostAliases.has(u.host)) {

---
base-commit: fdc34623463b1c708220021649ba4b8b53db3dbf
change-id: 20251108-mathieu-fix-url-replace-7f62a4fa56b0

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


