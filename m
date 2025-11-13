Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04605CD8C91
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:29 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23139.1763038637498373493
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=hWogHE8d;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-2025111312571537bb769de2000207f5-q9k_ft@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025111312571537bb769de2000207f5
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5x+BvErG6AfV6bRcF9g/rH47/c7ErF1EI5fhAh1M7iA=;
 b=hWogHE8dqaQK04fxWMMlahImrMrHG8kJkU7+gqIrAmgv2BI44RJZAj/VgHkgMN85C1mxsK
 En9HdGnK6JbLv2rVD5IiOdn4hDK0Jdifnz44Xg8V5+9prBVit1RhCNaQLNq9ox073IWzfkwk
 ryU9TcDXyoRxYzDnzwlZwzUIFBzjDIyqQsNgoRW692LdibM8BZV7x4Yfu78XBSZOq3PWcTdC
 gpW34Hh+r5jt35VZ4Pnp9zGhrmT+6DpAduJTcWShfxhu1dP5Q+izDYBv004w0y/H98DcsOPm
 FwCyBi+ZZqhZ0omSr/gDthGRBLzgQbcmsyVYsJvstJKfFyM3n84rNohQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 22/34] meta: remove consecutive blank lines
Date: Thu, 13 Nov 2025 13:57:00 +0100
Message-Id: <20251113125712.18914-23-peter.marko@siemens.com>
In-Reply-To: <20251113125712.18914-1-peter.marko@siemens.com>
References: <20251113125712.18914-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:57:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2509

From: Alexander Kanavin <alex@linutronix.de>

Some of them were introduced by mass-removal of S = WORKDIR/git assignments;
rather than try to fix up (or redo) just these, I've run this sed command over
the whole tree:

sed -i -z -E 's/([ \t\f\v\r]*\n){3,}/\n\n/g' `find . -name *.bb -o -name *.inc`

The rationale is that more than one empty line is wasting vertical screen space, and
does nothing for readability.

(From OE-Core rev: cedc4ff7c9bcfb22a20e43e47f9759f4007a4f1a)

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-cross-canadian.inc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-devtools/go/go-cross-canadian.inc b/recipes-devtools/go/go-cross-canadian.inc
index dd485b6..101a208 100644
--- a/recipes-devtools/go/go-cross-canadian.inc
+++ b/recipes-devtools/go/go-cross-canadian.inc
@@ -29,7 +29,6 @@ do_compile() {
 }
 do_compile[cleandirs] += "${GOTMPDIR} ${B}/bin ${B}/pkg"
 
-
 make_wrapper() {
 	rm -f ${D}${bindir}/$2
 	cat <<END >${D}${bindir}/$2

