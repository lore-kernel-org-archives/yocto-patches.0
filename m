Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCB9CCD184
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 08:20:58 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.10783.1760689248749159816
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Oct 2025 01:20:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=fRmTD9XO;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 66EE54E4111B
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 08:20:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3E908606DB
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 08:20:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9843B102F2335;
	Fri, 17 Oct 2025 10:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760689246; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=NkWNEiSNXJcKTFOtL2XwJpcmtDZ+N8tu+2vvn23HeaI=;
	b=fRmTD9XOUQhbJYqzqaC/JE9kCz7RWNVB+coxYPXRZhDQlOE86qVRxBcpK1/+VzfD0Oakid
	sBlu2w/gJjidBtuF5KZBGtcWrY0l/cUDTh69x03QFeuJiimt4FTDcfhAyEdCbaFqV0eXx9
	3XnRyqvgp7eT1OB5ALbdTel/Wyxi3j5/MMopjBeEtZd7d1wcFErh0Odn7TIfNP3X7ys9cc
	z6uu5PTzazg/bqkPwtXnncQ4iAz7yFmKwDXv1WS+uII5Me24A7yp3VnmeX4IBacYpktyUT
	Ytdz7erkr08EcjcHFcE7vY4QjBOe5qB1uzggCmSnheAZu8EosTBTt+ne/pZbtg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 17 Oct 2025 10:20:43 +0200
Subject: [PATCH yocto-autobuilder2] schedulers: Update my release selector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mathieu-update-release-selector-v1-1-9e7d18416924@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAFr88WgC/x2N0QrCMBAEf6XcswdJUAv+ivhwbVZ7UJtySYpS+
 u8Gn4aBYXenDFNkunU7GTbNmpYm/tTROMnyAmtsTsGFi3e+57eUSVG5rlEK2DBDMjg3jiUZu8G
 dwxVR+hCorayGp37+D3f6ptaw1JKGqnOEBXocxw9BYm/JhQAAAA==
X-Change-ID: 20251017-mathieu-update-release-selector-0b0426eda722
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760689246; l=1136;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=bFt/tbFGA0NjGKozzus5NPYFVR6DX/MtgZ8TIIdkV10=;
 b=IcWUhRXxaFeX0momKUReOELYmCECfW5GPNTs3mtf5xaw7sE+3ZuJnuaSjPeVPdUJakG7YqjGS
 dN7JL51HSHFDIiAWL9Qj0c7SCU+LBGOPGxvkDcD0BZDpLjQwMBJZME6
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 08:20:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2347

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 schedulers.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index 40a7facd5424..8ab9dee54f33 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -45,12 +45,14 @@ branchdefaults = {
         'branch_oecore': 'master-next',
     },
     'mathieu-next': {
+        'reason': 'test mathieu/master-next',
         'repo_poky': 'ssh://git@push.yoctoproject.org/poky-contrib',
         'branch_poky': 'mathieu/master-next',
         'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
         'branch_oecore': 'mathieu/master-next',
         'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
         'branch_bitbake': 'mathieu/master-next',
+        'branch_meta-yocto': 'contrib/mathieu/master-next',
     },
     'mut': {
         'branch': 'master',

---
base-commit: 37a0183944496fb30ed73e4d2fd3acdb532a7d06
change-id: 20251017-mathieu-update-release-selector-0b0426eda722

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


