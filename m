Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B22BC88E62
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:13:53 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48518.1789157630305237711
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dC2zOZNn;
 spf=pass (domain: konsulko.com, ip: 209.85.160.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5300bdf61d9so17729301cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157629; x=1789762429; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sAss0NJYrQRfSWACUnzN4RDurNVJylnhOhQwoCLUU10=;
        b=dC2zOZNns2b8OabMpgDfA/BqRr8FG3YULGyPTtzL4kN1J826nXwsYZhxmINKrOsW/J
         UdgZic9RZg9+TkHVHrbZH3K93yVK4WZDCLcPG/6pOiwKFPRfoGjbuUR1WjJnHnZlaTD0
         69Jl86BrCmNCCgoA3p8oFMTOl9mCuWwAG+Td0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157629; x=1789762429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sAss0NJYrQRfSWACUnzN4RDurNVJylnhOhQwoCLUU10=;
        b=ZW61YABMCxlO640XRxMhn1BKLTMkP4Hizs3aRtIXB1iDjtVR5Yg1DjWAddNkJTnhe9
         XvyoJ88kVt2wguYl+D0+nbQf+m47Igh8tcsDTWpGg5vFnOLko4lzSx/nGyqzQCgFPBxX
         CmRfdlhRn7WHpa/Mn+4jrZfCzuBHj5JGGMSk5LJQQdxVxTjyj17RzZUl6X3gM9F+T9T9
         jr+SaJQj2gdmyzaeFr3tFA8qfRXN75y98/YfJTmEGvw14vkOX7Oh8+ky1qRH5BqHF9J8
         ofPLOrcZGS2HFukFwQPKHFRqBIdMGBIT50frBi73NdCiIj+TiI2jXE73ZDrm6Z4xzIOI
         rZrA==
X-Gm-Message-State: AFuF++ktMBdx5YZfbRf5kJEE6gJnRz0rBJStP/jAtCU/3CRoR0X7qjiG
	JFI6AAX/F/m8t9nd4ZN7dl4MJqFYIugAAkpZ631XRAd5V7MYMF+bAVWMH/C0DSFZeUcvd6ixY1S
	CaLzf
X-Gm-Gg: AYBFou3WNdiRBKasSOO73K1qVz0eGQSMAjMpT5KOXp0L+4/cYWAKePJi7RyGkHy7Ueu
	QZpPiD1qJcXfEZV/TA+mEa70OewYig1bzRUUagxJGQZ8hvzkeDL+J5vWASdMJiYuNkihp7qhNdB
	IlHTSSTp1MqG80A21KgM0Y4YTNr+QOO8Kzbpv9a9acm9JpGcH8+5ksYnf11UIbOgcTr4HRTglkR
	xRZF5l2zN4a1N3fSD586yD+yHIBT1LwhPOnSN/XZCzGZZf4Zm8rgNXIrR5rRpkBxCejrxI8PcbW
	h/YRWw8R0r4lnxTEKqS8bcHet/vPOKB/gQPhdpeFQne9n2pcQgU7uNYu+XOyKSrUzstsJEUZV5/
	IbX5MN4xe/WimyLROPa8dr+9/+r6HdlQcu+4U47cjN4oNnDBX3FTUtkFsPgkKZr4TnplMK1T17G
	ifZFAfDSRv8mBDueEFIX5BG0Ra0I1c/KYD9Pj9csLkC9xWXhEF87aUyrLPpQ9CcI+76oXSk3gUJ
	3u7aHeQjtdb789kZxU8CagRU1a1WV6xS0ZRlxAVp5u+5dMKBEhHnkwkeF88mw7ezrCA78un6bf6
	qNiiuht1NEOluSjRJStnx7Nt4oquXQdZDTA85bL1oVYiEw==
X-Received: by 2002:a05:622a:14e:b0:530:4c96:4bf2 with SMTP id d75a77b69052e-530c8712437mr86319051cf.33.1789157629035;
        Fri, 11 Sep 2026 13:13:49 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 11/37] classes/rust-common: don't export rustlibdir
Date: Fri, 11 Sep 2026 16:12:57 -0400
Message-ID: <7664a9120415a166c6f40f8fd489992e984c75f3.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:13:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4777

From: Ross Burton <ross.burton@arm.com>

There appears to be no reason for this to be exported as it's only used
to set other variables, and does not appear in the rust source code.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 7624b1e16d2bdd4e5439d3305f0798f84b02183f)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-common.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/rust-common.bbclass b/classes-recipe/rust-common.bbclass
index 1533dff..a1d7dd2 100644
--- a/classes-recipe/rust-common.bbclass
+++ b/classes-recipe/rust-common.bbclass
@@ -8,7 +8,7 @@ inherit python3native
 inherit rust-target-config
 
 # Common variables used by all Rust builds
-export rustlibdir = "${libdir}/rustlib/${RUST_HOST_SYS}/lib"
+rustlibdir = "${libdir}/rustlib/${RUST_HOST_SYS}/lib"
 FILES:${PN} += "${rustlibdir}/*.so"
 FILES:${PN}-dev += "${rustlibdir}/*.rlib ${rustlibdir}/*.rmeta"
 FILES:${PN}-dbg += "${rustlibdir}/.debug"
-- 
2.55.0


