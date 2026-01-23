Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28884D72364
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 09:00:17 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.63627.1769158814105589532
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 01:00:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=LTBdJngz;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9953EC21ABF
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6F7526070A
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BAC03119A8790;
	Fri, 23 Jan 2026 10:00:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769158812; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Y4/O3EfN+h4Sbo3S9dKvbUWIjR+SuIiEDywXgMk2lns=;
	b=LTBdJngzeSXNPrm4di+Sl/amRT4+fvCv4e5qOgBHRraUDIW9BFnctOx0xHvQ7SX/XkZvDj
	yyuGlGBm0kUNAsf1Iye0jDRd6+Nt1hqS9yjwiq1dF2nf+kcE135SGNYAs4GSxvJ+z+Ide0
	9dN+5sWUMP+7FY+5p26iZ4D4ofu1rI9BIxALZfi35GgvVq59sbp1QszQKov33vpO+8q0pX
	AjE3te+VXNS74I/kLyK/5bucb/J7liUIdF7W8N/T/Wlfv1ppvX784grFdsOVU2Bt1+wCvs
	SP2x6v843s0xPHgfXFBhZfNpb5GKMzWeJ2rZtdN2SwaRE+NONqUZpkdQsNh/Lg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 23 Jan 2026 09:59:48 +0100
Subject: [yocto-autobuilder-helper][PATCH v2 5/9] config.json: indexing:
 don't add yocto-docs as a layer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-releases-parser-updates-v2-5-c24c30da807b@bootlin.com>
References: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
In-Reply-To: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=690;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=NqHdaWe6aBbuG7ZJ3pld8pa7k6i7hqmrrnjEdNTc4aA=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcziVClZnuYpZuX5U/LPQmkrY4shUzKJnt8A5X
 tGeb/sFrrmJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXM4lQAKCRDRgEFAKaOo
 Ng/ZD/9Ljnv1xojRQLF0a1WjYs2gwIlfh3WgIkHhuh8oe5Pj4tL7+04DnlDACeZRhQOpSbn3/bZ
 Uvkn9VpbNZ/xkutSOowheOYnKz55LvPXIrf7yISgDC1x0eZTAMeNcs7+phk1qKlbAXpHSRrMo5h
 Bnyl2eirfpYItWt0sBN/5duj87+eWxE+9x3FUwX9B9PaoRmREdP1MVwqgaZu9KMBb645iX9sjkK
 /XSrkIlJ+KBz4CHG3cQMRGSQKseua4lKz0GZ/uPPFEdttL9EpnrOAN5YlJEf8/WBYcd2nqTYA2Z
 SVqC8O9zQDryxq7/zX0EZsyeChIY1rwCzmeQKwRGLd44qY5jatQKxEfmwvweT3p4s1XLJHuyUsr
 bA45fQ7f8VJ8RT4KTMh/plWfkNSAJpJuKAOukQ7T5GZIHfSCg5OvxDNWtST3tD/Nzdpua0uxO3b
 /ykyFLVJOx3cUGJuVD+o7rd9BqkGbUxfCD/MiVQgSuRudaQKkQJQhSFczdyzu5vFGsdzQAnBx20
 tuR9rZ2Ibvwh0Vcn0E5S25gmir2jjEwu4sIFvbLTuHsjSP8h1lK0d1LpQ3TYk/DpjqI20iGyiEx
 +hxXLHEWhSuTeeMUZcGfpAObOLKXWFLOETgJnwkmqEA0LBorsliovd4UpssTTDIwOHYWz70Bpcp
 MzxCRd2zNlwGP5Q==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3060

This is not a layer so exclude it to avoid bitbake-layers from trying to
add it.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 config.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.json b/config.json
index 4bfce70..8fb34af 100644
--- a/config.json
+++ b/config.json
@@ -1403,6 +1403,7 @@
         },
         "indexing" : {
             "NEEDREPOS": ["bitbake", "yocto-docs"],
+            "NOLAYERADD": ["yocto-docs"],
             "step1" : {
                 "shortname" : "Generate non-release index",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/generate-testresult-index.py ${BASE_SHAREDDIR}/pub/non-release/"]

-- 
2.52.0


