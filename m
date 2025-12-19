Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7331CD767D1
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 10:36:18 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14246.1766140571576161578
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Dec 2025 02:36:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=WO1+Bkmo;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DE4574E41CB5
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 10:36:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B5C776071D
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 10:36:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4A43102F0CD3;
	Fri, 19 Dec 2025 11:36:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766140565; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PNtwwYsyTo1xJ6bGiIPr/t7WWCnPot0Pcjk4UcqrCfw=;
	b=WO1+BkmoHdVlIXNtPs8k5rvCC0ATzaKlif01C8JnTLtQ9MTKIkniAZTZyupgcaBz4IM9CK
	C5fu8/XV7wbzVn5f7ervh69XbVo/Qsigm8z/6/wnb9u+OXER/1Gd18aiKSqNUPMmnsFPED
	FKG94Zqb6U6pdA7zKCl2CWf4/CXuDWqwn8e22jq1rYSNQTY/KqnE32IXe4G+/QylrSHHBa
	5Y9ll99i5UHW+JYdwBRDgX801t3R0nWl3hOiuXB4XsgeIt3IMaKVX666loIFO4j5zWU8iL
	jNgBRMo1KCbaNXjBjZXOHmq72HEevJyoLjMrWkWDK9g+Iyu+BTQZwI4y4BDZ/A==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 19 Dec 2025 11:35:38 +0100
Subject: [yocto-autobuilder-helper][PATCH 2/3] scripts/release-parser.py:
 update for Wrynose/Whinlatter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-releases-parser-updates-v1-2-6830e6a67db0@bootlin.com>
References: <20251219-releases-parser-updates-v1-0-6830e6a67db0@bootlin.com>
In-Reply-To: <20251219-releases-parser-updates-v1-0-6830e6a67db0@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=hufaxn76aXYjWoEsCz265XF0SnkezD6tvAHy2mK8TEU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpRSqKYsxU0ZnKfKbNFNXNXhDQIbgIRWszgUUYE
 cJxp+KfZ8uJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaUUqigAKCRDRgEFAKaOo
 Nl5GD/93YQ9TpdYLRGaQGMyLCetNcYdIKnb3bMOpTpo8yV9/swnpqEONjm2+lg5+7NbA7NaxFmX
 e8dNKtGmXBmNEDkdecKmxGYyJAgt5Gq/VZJymn7XPMNpEngyOBuAVc6637TQAEvxW0h4X9CVXuH
 DuGCClBw+sJ8gUGaU90jPNBgYEBtNMiYHhpYht9c4GYYr5tJqaohJdt9auOySOKphx3Ga2CtcoA
 /3J36Y8rqSsXDu4lBleHTG8j8nUVEpa2DAZ25rYPzmxhaUmYNYesr/wyhbanDbZGOBUB6VjQMSH
 nlOiCAaRbitqynQ5Qmy9N4O2QOblP8ydRIDcQnATCZckypUOVpfOO7lbWvPHmWMxoLAT1Kdo6RC
 aqzbp/0uu+HAzCCr4O8wvFZIwuVstzIp9pCB72/NpT5WlG9uSOWOHu2SrhFtn4xA9dXsESxgjyj
 wz8/s7knto06l3wZpfc5g6sGOTBrQN4EDxSOzQHJxPL/dDoLJnlJPFm64qCE+pMxQdrzlNfTuFd
 UeUepMuISzmtzsXPGxqpjI38BkcoqlWccCkK3l1wMTAA0UurVVSnPuHx7ck0gIygsu3Grr2TsAC
 eM0fpg+ZOWeEKhI8J60VvxgH8eCvIgpuqtr6josqQwxqo7XIki2tDkTJIpLTcQo5hAzBczzJiQj
 huN04L88VFm8GTw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 10:36:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2830

Update the script to show Wrynose as the current Active Development, and
Whinlatter as the stable branch. Since will put Walnascar as EOL too.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index ef25289..61ff935 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -83,8 +83,8 @@ def get_git_tags():
             status = "LTS until Apr. 2026"
         if branch == "yocto-5.0":
             status = "LTS until Apr. 2028"
-        if branch == "yocto-5.2":
-            status = "Stable Release until Nov 2025"
+        if branch == "yocto-5.3":
+            status = "Stable Release until April 2026"
 
         # Create a dictionary for the series entry
         tag_dict = {
@@ -108,12 +108,12 @@ tags = sorted(get_git_tags(), key=lambda x: x["original_release_date"], reverse=
 
 tags.append(
     {
-        "series_version": "5.3",
+        "series_version": "6.0",
         "original_release_date": "",
         "latest_release_date": "",
-        "release_codename": "Whinlatter",
+        "release_codename": "Wrynose",
         "latest_tag": "",
-        "releases" : list(e.name for e in filter(lambda e: e.name.startswith("5.3"), repo.tags)),
+        "releases" : list(e.name for e in filter(lambda e: e.name.startswith("6.0"), repo.tags)),
         "status": "Active Development",
         "download": "",
     }

-- 
2.51.0


