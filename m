Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987F3CD6E7A
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23131.1763038637349290657
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=TH2cwGdm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-202511131257142ebd74db7d0002070a-2zapxy@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202511131257142ebd74db7d0002070a
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QK0SGDZSV8y4NHhAC83g+A4Co3deYvBGGcJPRD3dgKc=;
 b=TH2cwGdm2JXHSOfw6in31U/G9mZi2QzeKfyjwT5mKFiMgcLUFbKZhJvDi39D3RtU0y0XH+
 uAJScAyWryd884ATnk4oEJi289eblBkzaq+76IBnBydQjLtdBH84LhR2TtbRM4SAQXSsT1Hu
 U6FY99IWFHv25pKcNz3cZEqySHBrBzaBwfMxeXLyF6czE6ixrFu4h1c6IC6cQNej69bOq8UO
 aTtMPkidEStBGNuw+wr6cQacUj6K92PpeMKjMs0sWT7CzxHovD1RsMO5etRNNfD3EvR1c9w7
 YveOiN+tr7m4AmPbOOvXYHWh9ALQqJau3BIGagcroJgUPl1XMIiAvS+g==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 10/34] go-helloworld: update to latest revision
Date: Thu, 13 Nov 2025 13:56:48 +0100
Message-Id: <20251113125712.18914-11-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2522

From: Gyorgy Sarvari <skandigraun@gmail.com>

Shortlog:
- go.mod: update golang.org/x dependencies
- weave: fix %include parsing, add highlighting
- example/slog-handler-guide: run `make`
- example/weave: update TOC anchors to remove **, _, and `
- slog-handler-guide: remove doubled word
- slog-handler-guide: warn against embedding
- slog-handler-guide: fix typo, tweak phrasing

(From OE-Core rev: cfc6da6d0226d9d2ba1d59ecb1c86358be5daab2)

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-extended/go-examples/go-helloworld_0.1.bb
index cafcb2c..586f45b 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -6,7 +6,7 @@ LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
 
 SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https;destsuffix=${GO_SRCURI_DESTSUFFIX}"
-SRCREV = "d7b0ac1278591aea848a99258ccfdee8e4d454c1"
+SRCREV = "8b405629c4a5215871be932097e099c05ec5cb2e"
 UPSTREAM_CHECK_COMMITS = "1"
 
 # drop the 'destsuffix' so we make the oe-core backports easier without conflits

