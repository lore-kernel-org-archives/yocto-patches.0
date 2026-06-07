Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB0BCD8C89
	for <webhook@archiver.kernel.org>; Sun,  7 Jun 2026 19:30:39 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39317.1780860630153281586
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 07 Jun 2026 12:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=KhOhEkTs;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-2026060719303212d0be549a00020755-nynhfk@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026060719303212d0be549a00020755
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 07 Jun 2026 21:30:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rSBcHfQKY+cKUtN5HZ7WgbgTGg1K/0aWJIIks/S9aD8=;
 b=KhOhEkTs50YpxFV46De9u66ts9vY+tGX/gqNvuIDEGrDU+qOzy2Fr+ZPeUMJuh9MJFhwvk
 cAZoFJ+FOxQd6gzw4PMFWjYLlTNh2fIHOjwHCHDA9zy/TKFzpIKMTIOdZDClnOXn6dFBBDUe
 +TMcolADESOFf27kMkNv+HExURaa1kU5B6LcquIcuUJKAGd01m3Dm53JbAlK5L9Cp5ulitRo
 h6By7LCJ0+RIjiYiWo805NtjF2AdOL6S6QeMkZO9bn0pa6AahLtPt7fpAskCopJQZUAuOEEJ
 3vYAZiQU/numYZIpfRoQPvMpH4jlni+VaqgrgDr9Xk7DvjA5qbuY4rYA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 3/4] readme: add cgo-helloworld to testing
Date: Sun,  7 Jun 2026 21:29:33 +0200
Message-ID: <20260607192934.156036-3-peter.marko@siemens.com>
In-Reply-To: <20260607192934.156036-1-peter.marko@siemens.com>
References: <20260607192934.156036-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 07 Jun 2026 19:30:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4172

From: Peter Marko <peter.marko@siemens.com>

New runtime test for cgo was added, so add it to acceptance tests.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 README.md | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index 28d43f0..8de9b79 100644
--- a/README.md
+++ b/README.md
@@ -54,9 +54,9 @@ Automated tests to verify go toolchain functionality are being executed with fol
 * OEQA runtime
 
     ```
-    IMAGE_INSTALL:append = " go-helloworld packagegroup-go-sdk-target"
+    IMAGE_INSTALL:append = " cgo-helloworld go-helloworld packagegroup-go-sdk-target"
     IMAGE_CLASSES += "testimage"
-    TEST_SUITES:append = " go"
+    TEST_SUITES:append = " go go_mixin"
     ```
 
     ```

