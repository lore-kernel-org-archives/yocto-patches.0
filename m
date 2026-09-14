Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2379AC88E6F
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:13:23 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5587.1789413201073225199
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 12:13:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=M+FV7ZRi;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-256628-202609141913194e4ec1c6c8000207aa-fttvsg@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202609141913194e4ec1c6c8000207aa
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 14 Sep 2026 21:13:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yMj+38evx9Yy5woo8kryov/21PgVQKNM4jd0RUM/O4k=;
 b=M+FV7ZRifsldfEyQu7o1W7LVHL3JDMke7N2MfOIz/vtBWo+cyid/8MfRiO/Y7AbsvKAO7C
 gdajUXf7JFrXb3/itsdYqSkN0P3wHXMtNjAieMSFOtd4c8+Jn+UEQ+QJws0QG2GSDSBEcDvY
 FH/BD1EpHTPjjBZjYgeEVSaMjrhfFai9nVT9D93b4arzk81WXjFUUdgdNQ8rabAzOLLcADqy
 YIiXhkwURRZwoM86bZsWTX3UcOxXv49LEbfxzT/ZEQn+bgocdYz/TRJrRZvn9V9hQFrp6Deu
 FVnrLOgrFz2bWAYhX0GbC5w5h47EXyFSvDhgaNjBACXbMBLAUCVtluPw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][wrynose/go][PATCH 02/11] readme: update testing instructions
Date: Mon, 14 Sep 2026 21:12:31 +0200
Message-ID: <20260914191240.1066469-2-peter.marko@siemens.com>
In-Reply-To: <20260914191240.1066469-1-peter.marko@siemens.com>
References: <20260914191240.1066469-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 19:13:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4829

From: Peter Marko <peter.marko@siemens.com>

Add fragment for root login without password needed for ptest.
"Unsafe" settings were removed from default distro configs in Wrynose.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 README.md | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README.md b/README.md
index 7330b8c..6968860 100644
--- a/README.md
+++ b/README.md
@@ -57,6 +57,7 @@ Automated tests to verify go toolchain functionality are being executed with fol
     IMAGE_INSTALL:append = " cgo-helloworld go-helloworld packagegroup-go-sdk-target"
     IMAGE_CLASSES += "testimage"
     TEST_SUITES:append = " go go_mixin"
+    OE_FRAGMENTS += "core/yocto/root-login-with-empty-password"
     ```
 
     ```

