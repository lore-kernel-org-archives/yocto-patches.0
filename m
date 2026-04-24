Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28623FE5200
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 10:18:24 +0000 (UTC)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18156.1777025903232379632
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 03:18:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=L29hgyx5;
 spf=pass (domain: 0leil.net, ip: 185.125.25.9, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g28710Mh8zGgy;
	Fri, 24 Apr 2026 12:18:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1777025900;
	bh=khSgBGQ64ww5dpMmhv7PNCZt8WMKfR3EkR3THCaBFh8=;
	h=From:Date:Subject:To:Cc:From;
	b=L29hgyx58Ald1pRBJ502p8r0+Umg9y2x47LbITLmZVqdNWARvDVmG9tbSg1HY1ha2
	 VB/yRdMgkTiRFZRRQnBth6L9KPTH6Xs9YFZtEs6fSpnONG3jI3TLzDqmvRDo5LoAUw
	 N27MVr60S5xqa+H7iaqa26PnvN69e+vbFj9S7RxHD2pQNJPMgl+IfApFm8LBP62bab
	 P3ciHadJ7BAU41ZYTizbaLdPEXoLZeg7VHMbqgz9/JvFjIAFlN6g/wIoj0ELqQwMSt
	 SWVb/Z66MJuTl1QgmnwOah3BUkpIkIi1n9weP6RM1yrmZQYswLnmfxXQW/kHifqErn
	 /SJadl/2NdrrA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4g28703qqNz4JN;
	Fri, 24 Apr 2026 12:18:20 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 24 Apr 2026 12:18:15 +0200
Subject: [PATCH wic] add basic b4 config file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-b4-v1-1-04ede4cc261f@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyMT3SQTXYPUVMvEJHPTtERzUyWgwoKi1LTMCrAh0UrlmclKsRDB4tK
 krNTkEpB2pdpaAO1/drxrAAAA
X-Change-ID: 20260424-b4-0ee9ab75fa75
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 10:18:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3786

From: Quentin Schulz <quentin.schulz@cherry.de>

b4[1] is a very nice tool for mail-based contribution. A config[2] file
exists to set up a few defaults. We can use it to set the To recipients
to always add, in our case the mailing list, and the Cc recipients, in
our case, Trevor's address.

Additionally, automatically provide a default prefix so that one doesn't
need to not forget to run `b4 prep --set-prefixes wic` for each series.

[1] https://pypi.org/project/b4/
[2] https://b4.docs.kernel.org/en/latest/config.html

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .b4-config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000..dc2b2ab
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,4 @@
+[b4]
+  send-series-to = yocto-patches@lists.yoctoproject.org
+  send-series-cc = twoerner@gmail.com
+  send-prefixes = wic

---
base-commit: 5974ade11032f218841d9f449ef0efeee3f9a2ca
change-id: 20260424-b4-0ee9ab75fa75

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


