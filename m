Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8925FB518A
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 16:33:18 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.130750.1775737992438947656
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 05:33:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=VlxagVGs;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E65FBC5C182
	for <yocto-patches@lists.yoctoproject.org>; Thu,  9 Apr 2026 12:33:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 402C85FDEB
	for <yocto-patches@lists.yoctoproject.org>; Thu,  9 Apr 2026 12:33:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27BEC104500B4;
	Thu,  9 Apr 2026 14:33:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775737989; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=p1dgGZnHzg5q8sfwpwswA5OEd6VcQaWBC0I8rdPBCaw=;
	b=VlxagVGsstc0GkhDg5RbqbQhk99Ht3KIXivN5dGhDqbohMvmJAPg2YBOlTfmgCxRVw+/Tp
	2J91Bcc/38YqzVr1w9m19nFLLmOm870mrK+hfNyPQpCVGx2McCL08RjFd/Qe7MKz2sJVGb
	dePbA3KPamSESpmh9fvkEbQtDH/GKPIPgNHKAlJ/1aKbv5+m8w5X1nWP36f6AY/l26OLhP
	nty7yEl9jPhDffTwfsrmT8VLyDIBLTgb16KsqNGuPnpqukLq80Co9jk9vUCPO7VUknfZgP
	iRE1mZSF8jhbJsRpHEZ3vbf4Gtds3PAViWG1fjxm3iWo5oGoRdGNKnF8iDz9Zw==
From: Antonin Godard <antonin.godard@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Antonin Godard <antonin.godard@bootlin.com>
Subject: [master][yocto-autobuilder-helper][PATCH] scripts/yocto-supported-distros: really fix the centos stream regular expression
Date: Thu,  9 Apr 2026 14:32:45 +0200
Message-ID: <20260409123254.182485-1-antonin.godard@bootlin.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 16:33:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3675

The poky.conf file was wrongly referring these distros with
centosstream-*, but this is now fixed with [1]. Change the
regular expression for CentOS Stream to match this. Remove the CentOS
(no Stream) definition as we do not support it anymore and it conflicts
with this one.

[1]: https://git.yoctoproject.org/meta-yocto/commit/?id=3D2ed5aa3ac9eb708=
2b2534f12fb6b2f7fc3dc4bee

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/yocto-supported-distros | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-di=
stros
index f1dac04..f01a401 100755
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
-        "lsb": re.compile(r"^centosstream-(\d+)"),
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

