Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D974CA0EE5
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 15:23:52 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.104214.1755098625433502874
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Aug 2025 08:23:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=htQtg5o8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-256628-20250813152338178f1053c8a4215de3-2btywi@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250813152338178f1053c8a4215de3
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 13 Aug 2025 17:23:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oXKWMTgSYq7IfWEqcORRP2X7I8VdJJNrOwcyqcssqkw=;
 b=htQtg5o826vY7u997LGTVQyWQg4qjbyyPPnSt4B73o94Vu8ql7b2nQ+2D4jP6MupU7S+b7
 4r10G7UUayreD/kBBCxwuNaPnA2Eky62+xgQ8Fxh6OEdohm7+xh44RBSuiZ9O55vMHjT078A
 GK0XEc1QYIh4M2GHEgSmNnA3LYSeGQjBTCAqFN+FLE4co6oiNKLmtZNsjHguIdtfXR/1fle5
 16vIUJ6X4zDBIYeicBR9tS9A/zQoX9hK+1yQiYNZGYq1XD9NxV9a3+uXgxTjN3tzmx7aBIz/
 7+SNbgU0NoROAey8V7CaQHfEhXkoIdcsg0YWnzsY5eucMejiLA9G2InA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Khem Raj <raj.khem@gmail.com>,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][kirkstone/go][PATCH 2/2] go-cross: Disable build with ccache
Date: Wed, 13 Aug 2025 17:22:53 +0200
Message-Id: <20250813152253.10940-2-peter.marko@siemens.com>
In-Reply-To: <20250813152253.10940-1-peter.marko@siemens.com>
References: <20250813152253.10940-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Aug 2025 15:23:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1983

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
 

