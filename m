Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A31BFCE093
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 14:26:51 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.70962.1772116000806545226
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 06:26:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=aFGjN1RA;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 50D9E1A147E
	for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 14:26:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2844A5FDEB
	for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 14:26:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4AC63103693A8;
	Thu, 26 Feb 2026 15:26:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772115998; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Vz4EFcVG6MSuMZ09vJrSa3sMu6/IaonxE6R2GxA/pUs=;
	b=aFGjN1RAOlO4uUlCzoGnyskiv9KMB5VTntsd+Le4krrB89YPDWyjMcdH71WpSAsXnKvLaO
	lpBl9UJY5r/mGpc8eh2XF2txxyKHgxZ6tr1yo2bLy1oyybSOJm/h/sDWwpbJDCrX6uCFZ5
	Ys3L1l1b5sXlku7glu5hYe/VXJX9gQu2+CKy5Im+8tuhU/l9YJ3hKPZK8HDPntRRUala9+
	nZcAUxlQcaZfJZdgSSvO6ftyS9A6k/QENt7i2ucRz1W1NkeBx7Mr0PBGQ53rIOQdskFJ3r
	DSn7i3NrWxrwGKGjWtrhFL7oL7uIs6AAbr8mAK3I9eAX88daLUTc56W+SDe/bg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 26 Feb 2026 15:26:30 +0100
Subject: [yocto-autobuilder-helper][PATCH 2/2] scripts/release-parser.py:
 sort and remove unused imports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-release-parser-improvements-v1-2-3cc1c9842a87@bootlin.com>
References: <20260226-release-parser-improvements-v1-0-3cc1c9842a87@bootlin.com>
In-Reply-To: <20260226-release-parser-improvements-v1-0-3cc1c9842a87@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=645;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=ijHzkDS0eyKRsmXnQ2vcvV/OpTjM3pCOwz94d0W75NE=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpoFgbMH2jfOQhUhrB5hRp6ckScsNraobdieZ/t
 +RqgVfzMzSJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaaBYGwAKCRDRgEFAKaOo
 NjuhEADCfh+Yii4khb1Tady0+clOetiMNfcupK2OgAWFFJx9xRY8hRjduz0fYWasQdApCuF3u4k
 TPO6RzRzgKdv10mx4CZT4MP9xJPvb/nmOZ8b7yvCOIShi9PamtbeKcCgKEUZcjoBEljeDy18O/Z
 66SROWUomgH83qdjCvw/wlU+TPeIxsB4PZpm2q4Ta0Ah9AXQ3HrKEaTbnNwaUhyag0LI/DIQ6oe
 ER29mulsyguBI7Yqbrk/w+ETLeUYjuT4UwgXMzC7x9qz8GwQOLmMqx6DMxJUveLIHT6pPJVwG65
 k1Q+jTpHHhBmQw9zA0eRUURaWscCHM7NAK3Qe3HxrpMNxylUkVQY4mDJNfAsLNRKyHHB762x3SM
 QosAEGyxUINeF2BqDGZ0Sv33bMKEtwA2blPb6tnuNJ0cOWtdlI02OIo6rru3uTdIhdHVlThUbVW
 NwAmVTpQUJED1MxTxW+wb3mUvnE/Z8j1d3Y6WlflJxsBEHiXLM1HR53v5zL9ybuhmzZWpkXbRwF
 QftLaJBC7mZ3CQaKnSNwQhQOBy1mKdvsSmPLSpx9yuOo26xtUsWQG8ArwDlOqW6srNM65lWtXY1
 XC1fPQh7sOQZ2UYxBqgDSA3MBYMgh1O4zepYAGdH1GxzPEQKwlStCCbIufJI4kB9iBDFoNoMKi6
 iHbM/ybZ5hMzRvA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 14:26:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3288

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index 882c0fd..15ef017 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -1,14 +1,11 @@
 #!/usr/bin/env python3
 
-import subprocess
-import re
 import json
-import os, sys
-from git import Repo
-import semver
-from collections import defaultdict
-import datetime
+import re
 import semver
+import sys
+
+from git import Repo
 
 GIT_REPO = sys.argv[1]
 

-- 
2.52.0


