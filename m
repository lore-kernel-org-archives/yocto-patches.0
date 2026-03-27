Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DC710BA45A
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 09:11:02 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.68851.1774602657616414559
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Mar 2026 02:10:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=YrtNSVJC;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7B6091A2FFE
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 09:10:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5386560230;
	Fri, 27 Mar 2026 09:10:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 455C410450FAF;
	Fri, 27 Mar 2026 10:10:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774602654; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WV59vOtUCofFi/QC98QN2xMroekqUT/FtSZCyEj6/do=;
	b=YrtNSVJCSWlrJFxMDclpJV4IFGfPSJT6LOH3ky3+UKR8qWH8VAynSOnY5SWYTw3B7eKkp1
	5nLuH6NON72TkWi1pmTQI7tUN8vTnoQGaNkh3A2U4JeyDtxgHr/qcbmi2QdzOj+snc/A4B
	Gs44JLAcCyE7xxi7deVHtjVLyesI2tM2paj48cvyCPmNrWcDUVMrcAnzcFF6w1DyEjgrH8
	71ZeX1GSt0iY96B26Cv3SB1pjqF8mt4ESSy3MEZ92k1ovLRG9AVSWZMKP2nNwO/dgN9n4w
	0Az+40T6Ufh8tjHZ9r/1AEGdnG0vIlGKlWuVlyTyuuUTvx4dPc+RvzA/ZakoyA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 10:10:53 +0100
Message-Id: <DHDG50DJ45GF.37HBUXC0THTEZ@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH][0/2] base
 branch names on branches instead of tags
Cc: "Richard Purdie" <richard.purdie@linuxfoundation.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <CADfgfobj5xkU4ypgEq5YQU7T3NNzpVqgAENvZXE5nFvKX0aizA@mail.gmail.com>
In-Reply-To: <CADfgfobj5xkU4ypgEq5YQU7T3NNzpVqgAENvZXE5nFvKX0aizA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 09:11:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3565

Hi,

On Fri Mar 27, 2026 at 9:58 AM CET, Michael Halstead via lists.yoctoproject=
.org wrote:
> I have pushed updates to the following location:
> https://git.yoctoproject.org/yocto-autobuilder-helper/log/?h=3Dcontrib/ha=
lstead/master
>
> This change updates the release-parser reference branches instead of the
> branchname tags in order to remove the branchname style tags. These chang=
es
> are needed for docs builds to complete successfully.

I seem to find a diff in the releases.json output compared to before:

diff --git a/before.json b/after.json
index 7e1fad3..b0e2f92 100644
--- a/before.json
+++ b/after.json
@@ -675,7 +675,7 @@
     "series_version": "0.9",
     "original_release_date": "2010-10-22T13:56:31+01:00",
     "latest_release_date": "2010-10-22T13:56:31+01:00",
-    "release_codename": "Laverne",
+    "release_codename": "Krogoth",
     "latest_tag": "0.9.1",
     "releases": [
       "0.9",

Maybe a missing branch/tag in yocto-docs?

Apart from this, if the output is the same as before there will be no
consequences on the docs build.

Thanks,
Antonin

