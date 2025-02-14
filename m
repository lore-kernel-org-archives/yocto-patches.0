Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F5BC021A9
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 11:47:09 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web10.17908.1739528062356887676
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Feb 2025 02:14:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BK0PqYuB;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: pmi183@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7c14b880dso14303766b.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Feb 2025 02:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739528061; x=1740132861; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+q5z22AvKLUm/vzNbyx5G10/qZXO09rUf8CT9dIJXok=;
        b=BK0PqYuBGsMujM0NkLEusiJ5//gl5xHtLFtbuft1bIkYKc08RD4s0TKe4Ee6H3KQ3k
         7Yn4GFHa9OceMUmsxIClgu52iOVoeuoUpC25WPa2ZJAROfrKBUVLiRDd7OVyudPYg+WX
         ZvCYIy0o2MuJMoL7bq65ZmIWSH1eUZ8Z5iyoIzOr118hfoz8hgtzwoI5ST4khZwW9jsF
         dVWwr7jRV7NZyklGQh6m2Unit2Dc8kjoqHixr3zdNuF6bij9+7c6SEfkdbsHOoAWl9Ca
         Qbw5yOlRYS61gKWEch45yqiIo7zoNGHi/MacmCddTm+mHBKjqt13Qf8a0NYss3anngrt
         7xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528061; x=1740132861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+q5z22AvKLUm/vzNbyx5G10/qZXO09rUf8CT9dIJXok=;
        b=NTO1VapzuFeQsdaph/0XwEBTlTR11hxwd/F52BOI9+YmNu6ckcW2gvwWxtzfANEBwz
         nbC79+ljgBl0sb1F6JpPFvJL0F6LNz/1CfS9HAeQ+eR0WGcdTpBK4ZAhJSTk0rb8aqXl
         T0Nc0hNw2hI13DXQcMEpfi+36FkR7HzVkCFRJil3/Bs8Fr1oTt5+9We9DI9O0AF7zCHS
         svN/PognawKNifEKn/+IdGMapsevEaI9i9QPGvJcIDw+kM7gvX+3H4pHHZ0w1Jvs3gmI
         MQRJ7fZ7e40s4Bg/0q8CfxO13C5TflHa51C4mIUDJgnrBjDHgJnPEMGK+8E52q6st3gG
         2A8g==
X-Gm-Message-State: AOJu0YwaLXvTsK/dbOHtgAGXv7ATPMsoVA841AuwfuLv8khHukZ4BMBv
	GKTguC9Wr9PJOD/PgyGCnVupXV07ERsrYIu4l2r7M9uClm6Np2s84gnf7Q==
X-Gm-Gg: ASbGncv+6MwGPoHGCmpBXP0LfDruUIdZz19AeRjqVOa1pPEKqfFaYyFbSY1sO/AOe+K
	K+mYd7lU207obT4g8Xt5rnNOTVGO+JBu/PWiyHxy0/BBJYHOi7WE/cRaHUNPUOM8HB2L/sS+AcD
	Z6nfXUoYuzyYd4+KmPEGp5CmeFtcumpazziNE2+ds2Gxlf8WNo96qrLVDiIkVd0YGtmYGz2W5fz
	ttGh+Dfh+VU4IxRJOBR/SHnn0EwQXYpvEdtYV7TViJcZpkimJ2HANos4qcqmgNVmQ2zBUpcYyd6
	qlRVN6Eg7IrkOIgJXHxElvKFc8da/AucWYQpoxrM9AHfIg==
X-Google-Smtp-Source: AGHT+IFuV6u8zf0bjJUffkjuPEYUvAGyRtqgMz9G7wIkTF4SIjEJz581EjTvNAl352GIEBY8Hjz9xQ==
X-Received: by 2002:a17:906:eecd:b0:ab7:ec84:10af with SMTP id a640c23a62f3a-ab7f3765675mr1081434066b.16.1739528060536;
        Fri, 14 Feb 2025 02:14:20 -0800 (PST)
Received: from LAPTOP-0FHSM1V0.criticaltechworks.com ([213.205.68.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5328404esm307950366b.86.2025.02.14.02.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 02:14:20 -0800 (PST)
From: "Pedro Ferreira" <pmi183@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
Subject: [meta-lts-mixins][scarthgap/rust][PATCH] rust-common.bbclass: soft assignment for RUSTLIB path
Date: Fri, 14 Feb 2025 10:14:13 +0000
Message-Id: <20250214101413.1142937-1-pmi183@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 17 Feb 2025 11:47:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1088

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


