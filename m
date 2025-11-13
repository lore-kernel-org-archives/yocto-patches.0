Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F15CD6E5C
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23165.1763038637506209674
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=DvQ5AJST;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-20251113125715f821bbbbf200020777-gvqrlb@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251113125715f821bbbbf200020777
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oXKWMTgSYq7IfWEqcORRP2X7I8VdJJNrOwcyqcssqkw=;
 b=DvQ5AJSTb8FWAOgWYswywf8ixoaZqcYaV+u6TyEl6yTfulj1Za/8/TEpDrCW10GsyX6UUx
 sRcZqtBUL23fxFBsxmJwOpxk78hDJTZc8mJQcjMDGvDcC88rDxLshibbnjyZi22FrAg5RERy
 cAm9M/2On31YKdkU+s6e/uBDiAkuSpEy8BEU+GGVjMl8pP16tu5UNT948hSmgF+k6Mahjzzr
 CjjSuYTixUDGPtJFn8xQH8gl+hwisMPY+tbm/S7bmvqYQE8o4YWzrhEl+Aw1PCNdu3VvatgN
 YS0ywTELF2omQEcW82v+yaK/XAkfZZ6exGHW9N0WFOk3B1iei2gCndjQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 25/34] go-cross: Disable build with ccache
Date: Thu, 13 Nov 2025 13:57:03 +0100
Message-Id: <20251113125712.18914-26-peter.marko@siemens.com>
In-Reply-To: <20251113125712.18914-1-peter.marko@siemens.com>
References: <20251113125712.18914-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:57:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2536

From: Khem Raj <raj.khem@gmail.com>

go compiler does not work reliably with ccache
gcc: fatal error: no input files

(From OE-Core rev: 136743fe72591b90794ec30b9a3fbb41fe6a66aa)

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-cross.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/go/go-cross.inc b/recipes-devtools/go/go-cross.inc
index a0fbdbe..ebee2e5 100644
--- a/recipes-devtools/go/go-cross.inc
+++ b/recipes-devtools/go/go-cross.inc
@@ -5,6 +5,8 @@ DEPENDS = "go-native"
 
 PN = "go-cross-${TUNE_PKGARCH}"
 
+CCACHE_DISABLE = "1"
+
 export GOCACHE = "${B}/.cache"
 CC = "${@d.getVar('BUILD_CC').strip()}"
 

