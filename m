Return-Path: <pmi183@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E067AC02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 11:36:58 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.19215.1739533015263338499
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Feb 2025 03:36:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NyI6yvr1;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: pmi183@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaedd529ba1so243151566b.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Feb 2025 03:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533013; x=1740137813; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5eAoa3lOB8XXqyFxromEtEGjqBYL/XcujnPaqVb7834=;
        b=NyI6yvr18oZuu03kGYWKrLA+TTOqS+5DOv3WvyDs2skwB8cmSPIMMR5pmxfDiwoiPa
         Yq/3k/B5NnDaFl3jhRU9kv7sAyJyqvSnfcqt+ETVtuUu1RerdCFrP46ImLPcnoJ6chOu
         /vOeZrrML/iNwCaIwcbpu1jvRva4q4X5zU7T/+idYA2v6NhAEJaIT818WN2oN3dCCRba
         s67YwOdTz7zDoqftClkcuha1OELTjGsoRXPUS9PHyoC2tdB9Z4iPX4QGMY93GWCG184s
         k/IWstBpv3gXw6wBi0fqddu1EE/JseTcWX4Uh+vEgQdsE9bMQVGbCno3w3Mf+Ykhrgvh
         PVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533013; x=1740137813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eAoa3lOB8XXqyFxromEtEGjqBYL/XcujnPaqVb7834=;
        b=rt2l08Dcas9myQ751l7J0hPGq4FH+5yW89qc5J4jUk9n9ltC4efjSyMJyf5oPqxTYT
         TSll0dbJVcomWuBwM7H3v/clwIt5VtA+xE1gympt1SXX14H74lZLXnMCd8GdfJNOrODM
         Yu4ViiwXUq33/rwFRGCfiI9oFNdnkcf/pviUWaH3bNYg498Jl2A9eVVqjk6q7bYltxRd
         mMSpJBa+MtYH6YRwaH/x8bnMjtk7rH1IX0f2mGMN4p8wcwdBa19cuQZAVrYThNv0/oY3
         KdCXfhzWsB5HBuawCkR1v5t6TOFrX+PgM9d8gK/UbIov+cw1pjGndVnixlgrPpbMGOyK
         rRcQ==
X-Gm-Message-State: AOJu0Yy8lmNuFYJPj2x8GtJCTID8ErIl5fi/HVmht6r4R3LD4A1XVkYH
	fTnSgaFd/jrBZIcKCZwtrwtpLudTlWU/GmJpIit5uQ7M6cobB41StUnW7A==
X-Gm-Gg: ASbGncuqmt9RilUikopTowF0TosLOMBx7mDzrM8fiGFayuBn9HxeeiuFIxaD/eSAAZk
	Nom3IncKDI3EqhbSRQ0S9Hj+eERRDG3qzOUmpqrx0h/x2XG7A9ojGPUVahY3YZ8cHZsNyTC/DF/
	oI8TrqGq7Z6+cGrKCUuhnXQHUDTvlZ9WaFCUn+LmozG5Jwzcw6+R7y5XBVeTr1kucz3HvEZaB9L
	McqIBv/SBMZVSs6w9FfOd0W+iWqRAVJYLuDyJVS+DhVtwwQcAmGH43LXOZ9ww28RgoAR40kzgYI
	og/uHRiLDkEzVTNt9nNgehThxmOle5BNch/f3YC/q/gtgQ==
X-Google-Smtp-Source: AGHT+IF+vAUU3VnSYfvUrhrlU5+QNZt2vdZTUQ6Y4INmkbU5iPXKmnmrpZDGl65fhJ4N2KjNpk7vIQ==
X-Received: by 2002:a05:6402:358f:b0:5dc:74fd:abf1 with SMTP id 4fb4d7f45d1cf-5dec9d4a36cmr14643372a12.15.1739533013176;
        Fri, 14 Feb 2025 03:36:53 -0800 (PST)
Received: from LAPTOP-0FHSM1V0.criticaltechworks.com ([213.205.68.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376ad1sm327347966b.90.2025.02.14.03.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:36:52 -0800 (PST)
From: Pedro Ferreira <pmi183@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH] rust-common.bbclass: soft assignment for RUSTLIB path
Date: Fri, 14 Feb 2025 11:36:49 +0000
Message-Id: <20250214113649.1549474-1-pmi183@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Feb 2025 11:36:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1085

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
 classes/rust-common.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/rust-common.bbclass b/classes/rust-common.bbclass
index 910d6adac3..033b7da518 100644
--- a/classes/rust-common.bbclass
+++ b/classes/rust-common.bbclass
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


