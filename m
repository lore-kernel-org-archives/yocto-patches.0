Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447E0C3ABB2
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:02 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.web10.4592.1746132055574025732
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lgxaysHq;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5e2fe5f17so150594485a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132054; x=1746736854; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnfX9XsTkNrbOQSylDGA3q4f7Eg6bAgZxNknoYfw/iY=;
        b=lgxaysHqs3HqVwCTNmPheY27zLZsTlddmLCMhrXLbhW7HgtIj5QJuL5RGCaDr1RWUn
         kC9+ZQgAPrOo96xZBgy0RANoBynbolr2z3JVvhmrWYwdHGxYvf1oIO7Lxp6chozvKQZe
         /B+OvzttplzGU74ri4Pvu0+0uWeXnoYq+dodg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132054; x=1746736854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnfX9XsTkNrbOQSylDGA3q4f7Eg6bAgZxNknoYfw/iY=;
        b=LXdL62WsrJ8bHWD26EGZXA9mCQzslpPgOyHyimPESAi9/a0dqsNYIsXyszKpvTfSxj
         T32yYPufgoLOvtN2WUe0MQdJFXpEAbfWOqKN20wQeIRBjydnBcsilDkRxyHjJjcJX3R+
         hCEcSAiUoyOgDQYEmQVWGrIpp/SWNLZJ3DAegdqL03X2CYZQp1o3aJCUce8rSKmUj+ZR
         o87f04adm5T3zq+TThl0S5k6/wnxHhFYzjSYqieFB6UjHGlOJPGmnvhg7HnC+vLKQxiY
         baO2DIbSBOvrOWNHEXk3evVKE19JTVRi1fRt85sDdr6HllK/ITGXZDRghMRzBjGEt2vI
         EhGA==
X-Gm-Message-State: AOJu0Yz3U++l1BsmlOhFc4Y7JB77ZrtwgabdWkq14XosL58ZDS5+Hbe7
	l16vYVVQZbbpZMJHUFIPY2cveWE8w16eNBduXpsW2P8RkqIdtAuap1+B/PU/W+w06IaqaWOqPi1
	i
X-Gm-Gg: ASbGnct53uUt5QqXaKei+slL3eA8nuydsZoPob+q6PhQ7I++Phe7R2Td57kAQKybJFX
	U8rlSgvmh1yNwPigKWL2vKHJArBH5qWBvBW+tx7/cbTMwsSBiryEtdall8GCYiT2jZ1p+7KK4bR
	WUMj4SD8Ne1xpZtdrp/nvgW0Hvc9E2/tHQMs4goKeRBGCcyiccIUMsKoiV5n/gZKSvWzWCiPOPY
	mHoIcbTGFrJF/pHNWJoUcvlEntRffDTLEMgCSuFlqwY/DJP86/aJLm8i/KEr/NI8y4JR0zAhzjt
	4TYQcgyRBK6xoOQWc6lLFExTuDHurX9LFCGWlox4KQYFCGeA0IwojohANZMUlzzRVvEwhV9zAiG
	PoVxz3BZCK6lCZcYT
X-Google-Smtp-Source: AGHT+IEeJ840wtP4Fzzn8DhXBBqo15/fH/DPSg4VqNaHmtz0EsBECN19vMIv9ISU1zyL2N7qQ2JbTA==
X-Received: by 2002:ad4:5942:0:b0:6e6:684f:7f6f with SMTP id 6a1803df08f44-6f5152569c2mr11831276d6.7.1746132054349;
        Thu, 01 May 2025 13:40:54 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:53 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 20/38] cargo.bbclass: show PACKAGECONFIG_CONFARGS in bbnote
Date: Thu,  1 May 2025 16:39:56 -0400
Message-ID: <f15a06b83bc1163b927fa66f63867ba1f6f1ad4c.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1447

From: Martin Jansa <martin.jansa@gmail.com>

* PACKAGECONFIG_CONFARGS was added in:
  https://git.openembedded.org/openembedded-core/commit/?id=16745b20452de60ae2474433cc1a2fb1ed9f6a64
  but it wasn't added in bbnote above which might lead to confusing errors like I got now:

  NOTE: cargo build -v --frozen --target aarch64-webos-linux-gnu --release --manifest-path=.../git//Cargo.toml
  error: unexpected argument '--cfg' found

  Usage: cargo build --verbose... --frozen --target [<TRIPLE>] --release --manifest-path <PATH>

  and was wondering where --cfg came from.

* it was from recipe where we already use:
  RUSTFLAGS:append = " ${PACKAGECONFIG_CONFARGS}"
  it will be difficult to use PACKAGECONFIG for RUSTFLAGS and prevent
  them to be used here for cargo as well, what about the recipes which
  need them to explicitly append them to CARGO_BUILD_FLAGS ?

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 38d953b2ffd4e0cee9e77f97988e44be105023c6)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/cargo.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/cargo.bbclass b/classes/cargo.bbclass
index 461d100..2dd28e9 100644
--- a/classes/cargo.bbclass
+++ b/classes/cargo.bbclass
@@ -47,7 +47,7 @@ oe_cargo_build () {
 	export RUSTFLAGS="${RUSTFLAGS}"
 	bbnote "Using rust targets from ${RUST_TARGET_PATH}"
 	bbnote "cargo = $(which ${CARGO})"
-	bbnote "${CARGO} build ${CARGO_BUILD_FLAGS} $@"
+	bbnote "${CARGO} build ${CARGO_BUILD_FLAGS} ${PACKAGECONFIG_CONFARGS} $@"
 	"${CARGO}" build ${CARGO_BUILD_FLAGS} ${PACKAGECONFIG_CONFARGS} "$@"
 }
 
-- 
2.49.0


