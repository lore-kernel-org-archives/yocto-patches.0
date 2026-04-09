Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C93F364A0
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 16:33:18 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.130752.1775737994092851101
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 05:33:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=O0YEak3Z;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E19681A324B;
	Thu,  9 Apr 2026 12:33:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B8CD15FDEB;
	Thu,  9 Apr 2026 12:33:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DFA90104500B3;
	Thu,  9 Apr 2026 14:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775737991; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qlBUEuWmagNIBHBl+9lECfqH+fuLNtEDSYWAcWWwvGU=;
	b=O0YEak3ZcxZNLvJ2Sk1mzVfOoCsbsKfLSqyz1q/E0Eg+IjRni6EHPNVl/GIE25C8s3jljK
	I09DixPyfykY4AbNmqXC+UFK79mxJZIL1jAyPlZ8HqN84I9QebtDPnXstf3XNatHU0k+/A
	q0O5hMVxmtPNP7US1QvSPDj1btG74kIUfXchP2Mpo7hZMf3QnL7C7ytOD7aSKjeJ23p5JT
	efhcimH0XMqZQvj/oxG8VxAaXSPRhouFjGRUCsU55vqkVtXoIqc2h5o2VukUwZLAfbaXSU
	cbCBSmtBoYPx6Qqq5CBjE1e8eA8LPPqzkRG7OWxaSDD7+leruRr0CQNJfnkbvw==
From: Antonin Godard <antonin.godard@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Antonin Godard <antonin.godard@bootlin.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [scarthgap][yocto-autobuilder-helper][PATCH] scripts/yocto-supported-distros: fix the centos stream regular expression
Date: Thu,  9 Apr 2026 14:32:47 +0200
Message-ID: <20260409123254.182485-3-antonin.godard@bootlin.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3677

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
https://lore.kernel.org/r/20260408114639.453987-2-antonin.godard@bootlin.=
com
---
 scripts/yocto-supported-distros | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-di=
stros
index cdd3967..3266d52 100755
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

