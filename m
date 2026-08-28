Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE83C61DCB
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 11:39:02 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4379.1787917136879724245
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 28 Aug 2026 04:38:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Dc4vFWbQ;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3C5E84E413D5
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:38:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 10F3360537
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:38:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4DFF311C78176;
	Fri, 28 Aug 2026 13:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787917130; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R0CosVGKk/zN3iIQiE1iEonh6aPf4QZSEFtBBkxyyZM=;
	b=Dc4vFWbQsUXYbrJuq6YtNTIirng53+PMjZ/F2I92RW/bRJXHxm+DZ13PZLSbuOMHZwSmC4
	ic5TL5+njULWpLmpE47GfK8hSZVLZU84TAELWIcFJ3jJ1p21KAGpMxNzdQtOtx3R/c8O0u
	Khv8cTUQ+dJN6rqU2QZ5Uo0T9g/fenqvrSd4ZGyV5zeCyI7h2z+Op/fjQXSnV4Ha6ffMpX
	p3HCaEjH3J3rkdBtWkNaSs0rUhQXUnCIfjUoktuyb/ANI2qMTgnrNQwXR5yufiaSh0xDHy
	WKe/cv6i8resJe7JHfbgALIjOdhKux9VoX0BpTbaPFZ/YfZpqkbniAXW9XML1w==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 28 Aug 2026 13:38:34 +0200
Subject: [yocto-autobuilder-helper][PATCH 1/4] scripts/run-docs-build: fix
 a typo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-run-docs-build-tweaks-v1-1-24a7c832e352@bootlin.com>
References: <20260828-run-docs-build-tweaks-v1-0-24a7c832e352@bootlin.com>
In-Reply-To: <20260828-run-docs-build-tweaks-v1-0-24a7c832e352@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=552;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=cnk9xBMbht6vCMXZit17F/4sXLQrs13qhrNXOOtckVg=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqkXNEK9ZR5aIczCkkJpv0BvPaOCJ44byuONwo8
 1e4v86+DkWJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCapFzRAAKCRDRgEFAKaOo
 NmVID/0fMFKKV9Xfo0mTluJdcOKyNPogxd3Y1uAdM4Cy8z1pUYGozS8zjSlJ90d3/qDcSzYLPgn
 4yEUdK7KgB15s0sq42PXhoYcTuoPmCzCUO9BgYF3ed7kI5KqNJm0ybqLw48kqfFYIMVUEvo7iCB
 /fhplgF3yY3o4W6SXA1PfvaB6S8UCOn0QQidl00FRgyFyQxa2Z7+vkMtkJo1JeOwCoTOrlWdmvF
 9olEK6D0KWoUP+32PZrYnhwGXLa8RBuJ8EqK8qP4hxHr+IPWB77xUNnutlTa4L7vtpFBXhah1/D
 NvjYOX66+3GsscZqisNCfMIkLmodrfCJqY1Z2qWxDxHFClbYKOOzgeF80DJ2kwdpVr+t4pUrFV2
 /6kZKwwf9PYFNi5JItb+F/zI2WuLV8HjkYhi0YaYdRS4HuAJ9aW8W3Ni5Wj+4GGY7z2/pycKSsq
 fQ4GYWfOxVDPvHvBVqd2TolmqvScXpWb4Dxo7LQKWihsSoWTM0MdnuOvZGZZcYQYWRqaY7jThei
 di3fliPZxWDBkJv3rP560z7en2knLd5K6Us7yunHStZedihTR7sDHilJgy4M9MnqrhHwtVYQn6c
 RUF+N2fhl75TW6YCocGmcM/O62bo7ulw/9N4dMZkxILLfvdY6LB4rQOkAzJ87aBGvvrrN4xm4Wu
 al6AojOhYYXGNPw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:39:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4715

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 090e5b0..6b6e5de 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -92,7 +92,7 @@ fi
 
 mkdir $outputdir
 cd $outputdir
-echo Extracing old content from archive
+echo Extracting old content from archive
 tar --exclude=eclipse -xJf ${docbookarchive_localpath}
 
 $scriptdir/docs_add_banner.py

-- 
2.55.0


