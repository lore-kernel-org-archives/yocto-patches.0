Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12D0CF396F
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9149.1763564756735047863
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=AAy+d04Q;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-202511191505559ad277654d0002077c-cpexkb@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202511191505559ad277654d0002077c
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5x+BvErG6AfV6bRcF9g/rH47/c7ErF1EI5fhAh1M7iA=;
 b=AAy+d04Q17wof5HHiglWnMQjHULW/y0saPxvRLcDkZGKStFA5BjIfo3feANYQ5QO1FaAlD
 1xRPfCSFIuIaKdFPvvDyc+boAgr+2bt15GP53SFOYuULTYsaS6xL8GbPF8FfgV2Lrp8sgwiz
 dkFwHSIWUYi/puquQ+jlO9UlWJ2X49tsYmwj47G+t4mOFyoP7+DiFtVxLDJfKFm7bEVrk8IJ
 BQZG/NTLbQ94lr7K6aicLtBq4zEz1tqrp321aJz6LFzAGd/+dIspUdynkaib0taXjY+Znr1R
 utaC/4pCQP+UChrAb6z7ei/r925zf04qaNRIvLD2JWa4DPnAp5uTTlxw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 22/35] meta: remove consecutive blank lines
Date: Wed, 19 Nov 2025 16:05:09 +0100
Message-Id: <20251119150522.15477-23-peter.marko@siemens.com>
In-Reply-To: <20251119150522.15477-1-peter.marko@siemens.com>
References: <20251119150522.15477-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 15:05:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2614

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

