Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFA5E83EF6
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 08:08:55 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15341.1770192531368835428
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Feb 2026 00:08:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=U/PvCbE2;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 932584E423F7
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6AAAE60745
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD964119A88F9;
	Wed,  4 Feb 2026 09:08:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770192528; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jvsQti7qZrTILQWXzEsoEKIrUW4Lu+6toq4+TS+Eexc=;
	b=U/PvCbE28hO4/IduzDmobLHUzegYZuArg1C4Fecs8x6dbFiMQfcyV0Pf97DYwCg8F3yjJJ
	XKU2XAj3mJvGZwcJjtne17Fg8uUsphorddSycH91mJvXVHeJtP+yESnPNxtTOlq4FLwD5E
	4u7kai9l4zu/iwociq7v2bONSxwXG8HNJe3md/ZMCcG/TXa4ODZ+Q6/sz7I4zzabKlN1rb
	4EcAYjPDIogxRfulnjylvQ2OrNfhg+EbUY15APS6tjc9co9a7RJ5ljEB31mKBqTyeAZ6sr
	U3fX3PpibH5p6ZYst/XO606GEVCuFEOvMzzhDfUzVn2ZullXM35coYeHNiVr3g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 04 Feb 2026 09:08:25 +0100
Subject: [yocto-autobuilder-helper][PATCH v3 5/7]
 scripts/release-parser.py: don't remove non-existing branch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-releases-parser-updates-v3-5-be208a7748b1@bootlin.com>
References: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
In-Reply-To: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=961;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=PJf9Lgmj65ADLTSRaleNhUQQIcaAupKWC5VnfVTKtaU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpgv6MqPJyKUKPz+auIeNOMacjmw6NHxzLshrt4
 iJ7zj1bqJ+JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYL+jAAKCRDRgEFAKaOo
 NgNCEACaszcid9HFLdZGpLH+I3WCFy2Qb6Oe1uMRIC7dlhLoKptb+tTgiGOKAYYt9to6EfqPe3M
 y10xHzAuvJDK1s3AbQtiuUKUtYkwf7TBhDZICjzpRICpSMlSfi9hVFVupV/Cw8uR+2wG7L/iTa7
 +RCpNGrsqlsnPLBO4ztQoGlSvgoiyxa4NfuioMW+i7zbQSDAogxEgA5GoEPatCZVOWL7wxLOKZy
 S7YFf3yobCwdVAy8Zr7Ax6lMvbLNQx9GkjyktrbT+AyBNOa7gKyDcL/FMMAav4nJzWlhi9w16WZ
 w7k8LdqZCdBDDYAzyF4LPpZKT+u7XCIirEbKyO+M5m1j4iAERmjYedKmMrkJNvRfZaR3syMxqzq
 ORYpjlowYwjsKbio3QgDl1WquE7DMxa0O1ohB18GfX4D0FoRS7LUqZG3RrzDetmZ7ffaiGy5xyn
 rC+rxCBUEn2WDYRd691jULRfsSkdFzJjZ1BRpRa4Xu0GktIVh4vethxbcea0qL7HjRY1F06QLKW
 75kEbW0dXgwFQsqI234e/Q8xs2D8QIkNZbKfhRWPdX1qsLm6JHdx3K9fPpjap/zFn8RLEnMOSRE
 9PeSONsBZKl+U3n8mtudsdMLEVif9+9ucY6FWQ7LRp6VkJt0nUoxshYiYdQo8FOriD6/o7Nfbb5
 YghajQY4S7SnXpQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 08:08:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3186

The yocto-1.9 branch/tag does not exist on yocto-docs, so this call
fails with:

    branches.remove("yocto-1.9") # To deal with milestone 1 before 1.9 was renamed 2.0.
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ValueError: list.remove(x): x not in list

Remove it.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index cb56257..f161ef1 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -42,8 +42,6 @@ def get_git_tags():
     # Collect tag information into a list of dictionaries
     tag_list = []
     branches = sorted(set([tag.name[:9] for tag in tags]))
-    # Remove bad tags
-    branches.remove("yocto-1.9") # To deal with milestone 1 before 1.9 was renamed 2.0.
 
     odd_commit_strings = ["rc", "final", "docs"]
     for branch in branches:

-- 
2.52.0


