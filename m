Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752E8CD5BAB
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:16:16 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7164.1779624966799068576
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:16:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=grEl7jEE;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso135120986d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779624966; x=1780229766; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KG3fqPPh9IbFdsP+TWH4RiDpILV0ygthFmsSLpMbxxA=;
        b=grEl7jEEnnlhARPio3/pMsuT02IB/lMQRmqne1h34x3CAu1r8SKvC0nsh9K2eggoDb
         +7wxoygF2OD2KSrYMAJydDlVCDUaHbBQ327oFppdI1aTPpIcc5pFpCPia0aVYzv7qJ+t
         c1n0exemZPWNkBUvSZjCtuMZWfh2U/o2N7beI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779624966; x=1780229766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KG3fqPPh9IbFdsP+TWH4RiDpILV0ygthFmsSLpMbxxA=;
        b=HMxbdDgphaaywP+M2qZRj3TOcLovz80VybDjK4Eu9SMGMCaRPvrbpkoX2gzEofA/gL
         wnqq0k3aO2x17Cl/Ryu09ObO1CDKPfrQw1iX4r8A7/DMYnYD9YHQQMrqKvUdVVtiAvE4
         y9VivR5GItVwKMSlKnZjN0H8uEOWtZfG+2mcXq7pld9G5Vrehj8R8c2aPHbuxn3OXltF
         Tm3P5OT6FMJaz+csjWYumeLWKxiqT0oEIIcXJXSDYYQ2wpCo/2JA+8tU5akpDI3eGLTQ
         n0P19UXqQ287gIk4Hg6t7vOK0X2ilKDrV4Po8MVm4InNTCcia8CJK01XcOsbeTMuyolt
         v6pg==
X-Gm-Message-State: AOJu0YzgiQMnsKJBReJ5whjDHfs4WwUAhax0yIjPHFCAgd9Lo8wf84a8
	l4NwtJxOXkAvCaSaNT+SB+mKHkvRFsiolTnknsncbCKS6YGlp52Q+gE6/PNceeRjvddyraPSfq2
	l90Ev
X-Gm-Gg: Acq92OHsqS0GITO/ZXLnG0FUjYT0aMIr8Oco1etGWktnvqu6TW3bYBWWoKY9GpfR26r
	tLR08POfZ4BBQuvdgvXvgW3RrQZc5q1MhsDdmUXPiWLLqgosvjZTnaIu5A6ZACFk8xQ7XIKYOBT
	TvOj5tmCGjk62+5ZZCrznFl7rtehQ7FHd/NeOvNo00Icm0aSTcIxsk9sTXELi/++gY1MyIupCt3
	kaqGl1ppvT5OBKXO8CNvGX10SghqVlcsEDmvWve70f1pKX6svIcEKCozsbWXbg1mRuXbeiw9A83
	gYF8rzu30cpa/1XeMu5awBQmzelBPIH59Oe/A2/BUgGkBaaH7PTU0gtqGiQfP4QVtb58i9atsS2
	9ay2YPtKsEwv2qEG7XMq4im/fcNqF16MEuB61V4iukv7XOE2/zEKggQFgm6l8OKSl7JfsKWlA4H
	gypRPoeCKU9kL94uKMgfp6zVc9U357i4SCnumuxFwLanKIRRqXv5xCxHwXa1NMhhHYupPrUJiHC
	cVZALfNkEFFd657ROquzARWvnwJtGYa9uGRHysNDJ3u0Hw99KvDjO5t/xyN5aXe
X-Received: by 2002:a05:6214:5290:b0:896:fb99:f692 with SMTP id 6a1803df08f44-8cc7bdb426fmr139885626d6.0.1779624965309;
        Sun, 24 May 2026 05:16:05 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm82385186d6.38.2026.05.24.05.16.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:16:05 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 13/13] samhain: upgrade 4.5.2 -> 4.5.3
Date: Sun, 24 May 2026 08:15:40 -0400
Message-ID: <dc0a7622e4a60c8729d281b5f909119c781e8a67.1779624335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779624335.git.scott.murray@konsulko.com>
References: <cover.1779624335.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:16:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4019

From: Bin Cao <bin.cao.cn@windriver.com>

Update samhain-client, samhain-server, and samhain-standalone to 4.5.3.

Release notes: https://www.la-samhna.de/samhain/archive.html

Signed-off-by: Bin Cao <bin.cao.cn@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/samhain/samhain.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-ids/samhain/samhain.inc b/recipes-ids/samhain/samhain.inc
index fc4e423..95413cb 100644
--- a/recipes-ids/samhain/samhain.inc
+++ b/recipes-ids/samhain/samhain.inc
@@ -3,7 +3,7 @@ HOMEPAGE    = "http://www.la-samhna.de/samhain/"
 LICENSE     = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=8ca43cbc842c2336e835926c2166c28b"
 
-PV = "4.5.2"
+PV = "4.5.3"
 
 SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://${INITSCRIPT_NAME}.init \
@@ -22,7 +22,7 @@ SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://0001-Format-test-output-to-match-Automake-standards.patch \
            "
 
-SRC_URI[sha256sum] = "0b5d3534fd60ecf45dfd79bd415e81f7a56eba7f1755771735e204f334033578"
+SRC_URI[sha256sum] = "e7837adfde3d59a23c59e1bf3ebacdf71bce018619194cfad938cd30cbb9d15b"
 
 UPSTREAM_CHECK_URI = "https://www.la-samhna.de/samhain/archive.html"
 UPSTREAM_CHECK_REGEX = "samhain_signed-(?P<pver>(\d+(\.\d+)+))\.tar"
-- 
2.53.0


