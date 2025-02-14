Return-Path: <pmi183@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C70C02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 11:43:18 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.19292.1739533395006399750
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Feb 2025 03:43:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XK3FXvL2;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: pmi183@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so2671006a12.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Feb 2025 03:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533393; x=1740138193; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+q5z22AvKLUm/vzNbyx5G10/qZXO09rUf8CT9dIJXok=;
        b=XK3FXvL2pxdh7KhAmE1PnsQsAKW9Nb9CddWpSZ6ZdxB1Gt6OyC//VtxYb2+xocLMLd
         TJfnjhrJZtGILh72R4QW+v/LQw1B/fll6Ew/ohvJWwS035b5U0zgW0V9ua5qOsRs//z4
         RqYUVH0GyglVpzQAeZXCn0GXLAc7ShkqBKg/aVI77f3ULYaVzT2uDEYO4wWHxJWYShvh
         aMvWYuyGLPZGr4qPkxP2r8WRuu+XS3SDjNsbkoGrw8UHqUyogT6OsfV0QR6qPKPiW+k/
         tcna8bQDwqqGop2XagO8MeCaFA0Jj1YY7iF+tbMTAbBlCEvV3XPDXOW7JmGo/wzZ1UFF
         /w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533393; x=1740138193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+q5z22AvKLUm/vzNbyx5G10/qZXO09rUf8CT9dIJXok=;
        b=vq9PnSdJRSUB1q27ySBj+VMd3IdTPfXsz/N81YJFRj+RAhDdbW0x7kaXp1eZ7JKFqx
         cVq4Ru/b+qPGAsGvtDK2MjPTjmVNO+JFZqKO20eF2PmBLm6ahWHyOlBuAsOoPskFROt5
         V7EVx4i04r5RZIilGnCiDuolSUYa8/F9HBXpYlCIX5woC9ivOp6j3JnPBCQ0YlWDWe3R
         1C7NdOl8ZM+4p+ZiZbGyxH2MJdL84qwJRmzR/3Zn3MshH+268jpFlhcYBeDJbm+1bHBA
         V8Me6qfjVJjcfHlWtFOUGFUEvpMZ/DBbFdh+in9fsBs6z5Fz6KBKsNsWOkZQXGpUYu7j
         3eUw==
X-Gm-Message-State: AOJu0Yz8LSN1+ZqvXPgzzwuif7FFOQ8Gq34NqW3FHhJo4838iwKrvbJe
	dKRusEuy3aCO+k55if93h8uy9gP8cTknw9yNhWzKOiWU5lqS1YPmvMTNBQ==
X-Gm-Gg: ASbGnctDG5wlxPbavMKdsrTgGU/Mk/lOEdUFWk81I7Db49BQzxUVDSzXuKTRtEj3GAB
	Kl6eX5bAzoGZwJbYt1oE2mCijpkr7aiL7OF6lN7JS5JhvTet7g4O/Ik9DIdM0F3j5ekO5l3WdJT
	rMmBbZ2p5EPk4VntFeyZr63qikyqBBX310rK4YXtDAR7fz6LLMp7f0tXuZ0RNswwhWJZ8KjvVM5
	LZ+n/sq567geIMpBWevRk0znfmgfSh1UtepPhcY0IH/DbMyTpolROixBklJbxNc0A/bryU1Dbyh
	qlFaOivIjm5OaqjNaMdTeegr7vBFNvXcDXl1BHchNKm8NQ==
X-Google-Smtp-Source: AGHT+IH4bCMiOw62MfKrrUFX9ixV5Sihsmdlk1TdPK03dOegmebtYAutog0vl0XPW+Mwb1UBdLlLcA==
X-Received: by 2002:a05:6402:2087:b0:5de:bcdf:bf50 with SMTP id 4fb4d7f45d1cf-5debcdfca34mr6861946a12.31.1739533393118;
        Fri, 14 Feb 2025 03:43:13 -0800 (PST)
Received: from LAPTOP-0FHSM1V0.criticaltechworks.com ([213.205.68.220])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d367dsm2847739a12.44.2025.02.14.03.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:43:12 -0800 (PST)
From: Pedro Ferreira <pmi183@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
Subject: [meta-lts-mixins][scarthgap/rust][PATCH] rust-common.bbclass: soft assignment for RUSTLIB path
Date: Fri, 14 Feb 2025 11:43:08 +0000
Message-Id: <20250214114308.1553448-1-pmi183@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Feb 2025 11:43:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1086

From: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>

As a user i want to override `RUSTLIB` path on a bbclass, lets
call it `XYZ.bbclass`.

If a certain recipe inherits `cargo.bbclass` and `XYZ.bbclass` the
value of `RUSTLIB` is dependent on the order of the inherit.

If `cargo.bbclass` is inherit before `XYZ.bbclass` this will reflect
the desired value of `RUSTLIB`, on the oposite, if the `XYZ.bbclass`
is inherit before `cargo.bbclass` then the `RUSTLIB` defined on
`rust-common.bbclass` will prevail.

Changed definition of `RUSTLIB` to soft assignment to make it overridable.

Signed-off-by: Pedro Silva Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
(adapted from oe-core commit 6eeb832f73ffb48f5f05dc47191f60e4599e640f)
---
 classes-recipe/rust-common.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/rust-common.bbclass b/classes-recipe/rust-common.bbclass
index baa3869c47..31331c7a26 100644
--- a/classes-recipe/rust-common.bbclass
+++ b/classes-recipe/rust-common.bbclass
@@ -13,7 +13,7 @@ FILES:${PN} += "${rustlibdir}/*.so"
 FILES:${PN}-dev += "${rustlibdir}/*.rlib ${rustlibdir}/*.rmeta"
 FILES:${PN}-dbg += "${rustlibdir}/.debug"
 
-RUSTLIB = "-L ${STAGING_DIR_HOST}${rustlibdir}"
+RUSTLIB ?= "-L ${STAGING_DIR_HOST}${rustlibdir}"
 RUST_DEBUG_REMAP = "--remap-path-prefix=${WORKDIR}=${TARGET_DBGSRC_DIR}"
 RUSTFLAGS += "${RUSTLIB} ${RUST_DEBUG_REMAP}"
 RUSTLIB_DEP ??= "libstd-rs"
-- 
2.34.1


