Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B4E10A88E4
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 16:22:26 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51588.1774542143720926904
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Mar 2026 09:22:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=b7JvmDBM;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7FD744E4280D;
	Thu, 26 Mar 2026 16:22:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45DA6601FA;
	Thu, 26 Mar 2026 16:22:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E20BD10450839;
	Thu, 26 Mar 2026 17:22:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774542140; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=5ynSzHj9Z2yr0kFDFhxIcRorKepgOAecqJl42Ei+XhA=;
	b=b7JvmDBM8bO/K4uIScPx9qFt9QM/GkeBdQPs03Qvd9NlWrV1C4FLQtdgIpBGet7HN+YZsL
	sTsWOgAu4R0xZ+ZKBv7roYJaW8c3GHoqzGVhLFTcYnszTZTxWMHeuzqHufpuJLfzHYnvhL
	PdeM4mX4MGvwfSN/WnFzSXDyVzq3KCDCNqYobrjExSu7EEdPuJSy9t4uIMg9P31/kxq3hf
	EPH80jCP590DAAWddol8xWuahMgIhSxVFvDjObS31e4xRfKZMihGq3LvFdw8rYrmAO1pZs
	q6qsb2ic0qq/tG1y+qgq/ij8C3/zd9v/bUr21PleIV8W5Y7QZ9fLPoldBfh3rg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 26 Mar 2026 17:22:06 +0100
Subject: [yocto-autobuilder-helper][PATCH] scripts/yocto-supported-distros:
 fix an incorrect regular expression for stream
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-ysd-fix-centos-regexp-v1-1-e41c6cbe1a18@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQqDMBCE4avIPnchjWKhVxEfNJlqiiSSTUQR7
 960ffxg5j9JEB2EntVJEZsTF3zB/VaRmQc/gZ0tJq10q2rd8iGWX25nA5+CcMSEfWXbPABVG2M
 bTeW7RpTRr9v1f0se3zDpG+uOYFLgIacwZrdYRJ6xrIg9XdcHzrQup5MAAAA=
X-Change-ID: 20260326-ysd-fix-centos-regexp-d47ee03ccd42
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Yoann Congal <yoann.congal@smile.fr>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Qc+22c9XSe6qws/jiKd7klPlko3WAm66Rue9d3gY1b8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpxV07E2jGnPwwR59bC02VdiEqAy0c108qB6vWS
 SSZ2Ftl08+JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCacVdOwAKCRDRgEFAKaOo
 NpKDD/4kdAeRE5DTh2gFGPA4gRuT5Z2YdpvouNfxdtgPXrNDbs25nHsww6kkAzTrkSqv2hHLpJV
 JsWWbjFkkDItMqMTE4ryLIqj+QxDWojK5VDIWMuomQynK63L6wOgZ/HHID/HB+dZNq0sbID46zB
 lbK7FwQzzeEr/OhgalDsHMwe5eUFa63th28uGX8KegudSrRsHHqkaa/Mo7S0LcFODW01iKyLMeP
 VUTBh0zmGo1SOyO/Sq2DQaLwQiR83hImTuQpY6Jo3G9664muLMMd5E24nfYUwQoGSJfrNBBJsHE
 3JxdPdt6CxzM13hT8ynCd4IxJO6npjhHkGeLlY3y+qFGNseLI3VO7TghZsAAtJRgaHNC+QXGn2k
 DUmckgR6M5Qu7Kyt/m6RPFi6n3Jm11f/FM5UzEoknLfLvdeTjMosY5xHg1TKxnR6p9d24Dn5qpL
 +sycZSA9m4Tcco3/ttwXl5pkujlXVSxEk7OQr48dtiqQI4+ajIJzEXCCgewcJOTJ/jNH1ub/Gff
 IBOEDi754X/Lj3slRt3XDh6nANaH0+lkLBl9eZkZHoZ3UD54f11rKZU12y6O9buGV+tn1KS21Vk
 YncfWXItWeBxbdYyjowACt4V/Yseh4RIg1EZ5qg+VI8Apq8VBXStV4nOHQIo9rqMEvlO870HKlO
 9Rs/cq1LGX8HkSQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 16:22:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3559

The lsb string for CentOS Stream is actually centosstream-*, not
centos-*. It was thus not detecting centosstream entries in
SANITY_TESTED_DISTROS.

This was preventing the script from outputting the docs-formatted CentOS
strings.

Reported-by: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/yocto-supported-distros | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index 11b05b7..f1dac04 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -83,7 +83,7 @@ INPUT_REGEXES = {
     },
     "centosstream": {
         "ab": re.compile(r"^stream(\d+)"),
-        "lsb": re.compile(r"^stream-(\d+)"),
+        "lsb": re.compile(r"^centosstream-(\d+)"),
     },
     "rocky": {
         "ab": re.compile(r"^rocky(\d+)"),

---
base-commit: 1fc6dae73202e4fdebaac26000c82c1b7a556ca8
change-id: 20260326-ysd-fix-centos-regexp-d47ee03ccd42


