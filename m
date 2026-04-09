Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C15E98FDF
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 16:33:18 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.130751.1775737992704865504
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 05:33:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=F9tqpn0L;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B0E8FC5C183
	for <yocto-patches@lists.yoctoproject.org>; Thu,  9 Apr 2026 12:33:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B52D5FDEB;
	Thu,  9 Apr 2026 12:33:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CA57104500B5;
	Thu,  9 Apr 2026 14:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775737990; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=H/kOrcL19K4SB5G3l4mFzohwBHMCfVHJqa4gtGAXgmw=;
	b=F9tqpn0LkYBLdyW/7TdsicE9g/R8ypkp+l0EcNg75kra8VoJjXagBEHWqSe56o5mqpDfTI
	G2bVGcOAFuTQlNV3co1aTYUu1OP9sr7sWjHknZpXma1TDCE1uDSFSiSWqKiP7CflRgXpjd
	Wznr4HeG4Twn5dFThEfuh5L5Ht7Uk3FxvtdVXttghhIxv6Nb4shYhpGMC10b/ON5btEzZk
	bXhOsQ774QZ7O9YsW8AIrUQzAACyj6CTq8fBkvi/xZ2x6Z/ko5yL/86wALlo68P5CZUCDv
	0pVWNTOWMce1dj6rPLPEuc61JIUIIYs4AK4iq0AEv3bvWbDfQQdLxfCEOTj+8w==
From: Antonin Godard <antonin.godard@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Antonin Godard <antonin.godard@bootlin.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [whinlatter][yocto-autobuilder-helper][PATCH] scripts/yocto-supported-distros: fix the centos stream regular expression
Date: Thu,  9 Apr 2026 14:32:46 +0200
Message-ID: <20260409123254.182485-2-antonin.godard@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409123254.182485-1-antonin.godard@bootlin.com>
References: <20260409123254.182485-1-antonin.godard@bootlin.com>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 16:33:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3676

The poky.conf file was wrongly referring these distros with
centosstream-*, but this is now fixed. Change the regular expression for =
CentOS
Stream to match this. Remove the CentOS (no Stream) definition as we do n=
ot
support it anymore and it conflicts with this one.

Cc: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Needs to be merged with:
https://lore.kernel.org/r/20260408114639.453987-1-antonin.godard@bootlin.=
com
---
 scripts/yocto-supported-distros | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-di=
stros
index 11b05b7..f01a401 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -77,13 +77,9 @@ INPUT_REGEXES =3D {
         "ab": re.compile(r"^opensuse(\d{2})(\d{1})"),
         "lsb": re.compile(r"^opensuse-(\d{2})\.(\d{1})"),
     },
-    "centos": {
-        "ab": re.compile(r"^centos(\d+)"),
-        "lsb": re.compile(r"^centos-(\d+)"),
-    },
     "centosstream": {
         "ab": re.compile(r"^stream(\d+)"),
-        "lsb": re.compile(r"^stream-(\d+)"),
+        "lsb": re.compile(r"^centos-(\d+)"),
     },
     "rocky": {
         "ab": re.compile(r"^rocky(\d+)"),
@@ -112,12 +108,8 @@ OUTPUT_FORMATS =3D {
         "lsb": "opensuseleap-{}.{}",
         "docs": "-  OpenSUSE Leap {}.{}",
     },
-    "centos": {
-        "lsb": "centos-{}",
-        "docs": "-  CentOS {}",
-    },
     "centosstream": {
-        "lsb": "centosstream-{}",
+        "lsb": "centos-{}",
         "docs": "-  CentOS Stream {}",
     },
     "rocky": {

