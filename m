Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDD4FCE090
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 14:26:51 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.71148.1772116000202138522
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 06:26:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Q1SMPeQf;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 943A91A13CC;
	Thu, 26 Feb 2026 14:26:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6B9D65FDEB;
	Thu, 26 Feb 2026 14:26:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F8F6103693B0;
	Thu, 26 Feb 2026 15:26:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772115997; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jSrg6pJG+cptPTB+njH5sg6+LzfYGdUETHBZ+jjlD0I=;
	b=Q1SMPeQf0BEMDYOtqQsH+L2+ixxMn7L0yMcDARb9Fu/yKY/k9DzVvJg7ILBf9G/cyb6HHO
	A1df7EJ0Y+eLC/hhhYTRUzZQW+MpKtHXqWQMoWmZToBNn3MUvaYW0ALu6hPX8KiWSwjbGx
	HulGOEPxpaLtoY3lZYl7Z3hJpDA7jHaAxx5QLz6ZpakHHZGwteOHJJnIwpzAU+mdVT0ea0
	TTdb5Xpe2Uh7vEThJoIpVtJn5ht+1lBQatP8+e6b174ULVNyIl3DEZnXYmr+h5fv3Oz6vi
	uMNHNk89WF8cpao9sO+40avxMvlMq0blTCcyqVPtB75y3sTvccRcvoWKBHHXXg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 26 Feb 2026 15:26:29 +0100
Subject: [yocto-autobuilder-helper][PATCH 1/2] scripts/release-parser.py:
 sort tags based on semantic versioning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-release-parser-improvements-v1-1-3cc1c9842a87@bootlin.com>
References: <20260226-release-parser-improvements-v1-0-3cc1c9842a87@bootlin.com>
In-Reply-To: <20260226-release-parser-improvements-v1-0-3cc1c9842a87@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Nzj8kA1s0aLiwq4tIwXvFM3NTnF4O2fIsAjyhFg/Zbk=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpoFgbZVSDoKgZ/pQ/NvpPsTAOhma/bipYMSxfk
 2wU1X2AgTqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaaBYGwAKCRDRgEFAKaOo
 NrzPD/9XLaFtZuXnzCcHp5DtQk+DjBHk5i5XxV6MrTT4lD/DLDQX2dshND9IsFrlDtU0eO400kV
 7fiRhZNTVJ0HuEZ2a4RSYFFDWVQTxI/CyWl8r7iWV2t18FA8hlyz+BR/C/HdIBnknu80AwWQytf
 rybpWaxKsYcSPQhLBpTo5cij+4OesegOV+hMzcBw5JEHwRAJQOwTzTVod6dUljbYvMCMb7qISOl
 3x7n86cJd5/+mMj8lqJt6pJ65uO1lszVNeBT9FrVBwHlKJupVj654XEqB+yUQ5+GrZWXynYuLqn
 NUOFXXAZhtHH6yL/DxS8RbN4pcHQGgWyJJUwtfg5vJ0e5xf9yUDrLVycK9D8lM/gZGoeXarneSc
 4cka06e0rwXrbpHm4jTMDOXqi+RrjEkkq0CoBkpkkES7aUm8i9eJuFS4DA84EkE2bmO48fFUPvf
 kbp9EruINRqjaGegkkjZDraZKOZEYGgqKLn8caOOFGVUGMpn2KP2RmCtgIbFk3yPd4jLEQMoayZ
 qLLBAhcKs4oRkce92KCXNP4OcYnfC3JifeiocDFSPEiyfb7d5bZg9N0ePQhZ7Z0v/A8cQTYh1zG
 VFRF0mm7sRLIZ/aKqKtpc1+oLxvh93UB6e+15Cx/OOoVET2LjUOvenJsMus5/n1nGXeK4r5CEwq
 lxJLKZGaUo4yjCQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 14:26:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3286

Sort the "releases" array to sort tags based on semantic versioning.

Turning:

    "releases": [ "5.0", "5.0.1", "5.0.10", [...] "5.0.8", "5.0.9" ]

into:

    "releases": [ "5.0", "5.0.1", "5.0.2", [...] "5.0.14", "5.0.15" ],

Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index e07fd71..882c0fd 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -60,7 +60,8 @@ def get_git_tags():
                 return semver.VersionInfo.parse(tag + ".0")
 
         tag_names = [parse(re.sub(r"yocto-", "", e.name)) for e in tags]
-        tag_strings = [re.sub(r"yocto-", "", e.name) for e in tags]
+        tag_strings = sorted([re.sub(r"yocto-", "", e.name) for e in tags],
+                             key=lambda x: [int(y) for y in x.split('.')])
 
         if len(tag_names) == 1:
             latest_tag = repo.tags[

-- 
2.52.0


