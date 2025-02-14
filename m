Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BE6C021AA
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 11:47:09 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web11.17840.1739528613984886192
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Feb 2025 02:23:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KJpTXL79;
 spf=pass (domain: gmail.com, ip: 209.85.208.41, mailfrom: pmi183@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de594e2555so2958260a12.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Feb 2025 02:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739528612; x=1740133412; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5eAoa3lOB8XXqyFxromEtEGjqBYL/XcujnPaqVb7834=;
        b=KJpTXL79OX1uO638Vx1pFWAREaSZjbL9ID2VefbxKYlluyLS8xloeGpjJeSji7XgQp
         fLcNXC3wTLIdaKg2GNwejWOxeRqLqc9V4aQeGP27hOPRrZzvoQuI7Yl7w49WJY3e5Zxx
         0MuwLq9oq7ALJNmNs7rRR7kiGnH7cJAzZNb8fSVawEBzb5t7kUTl3vegofJHPcek0EwB
         Ra+PtCyu3zwjC9NveDLhY9WtoN8ZlxplrtKbqkUTQZyvVPXKIAGjiAizj60OE4OLQk0K
         pBd22M+ncI3X8Hp01OtbX64L78ZUyjjIp9vF9FWuGw6J0F5GDuA32QiL6d2ZVtvnLxEk
         nxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528612; x=1740133412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eAoa3lOB8XXqyFxromEtEGjqBYL/XcujnPaqVb7834=;
        b=X8r2L0/33Wh2HjzlB/Wx5+58q3bNRDZ7aqqTAIdewWvF8K947fSS5Y4sdbxS+nYVJI
         JnUj+JQtdAsfG7Y2FZ/LTdxY4fdqG+YvUcTSEPiUDcbSbqAYh2jM5pB7n1Mqwobjxn0r
         Osu/G4N2JY806lARcCwdFz7wrepZRPqWmC4eYfd1cDeHs7shRcLwAt5MbKHcDpixB2ij
         Vt6Ky7dTkaV1RX0f5WTeLZE8peI3wJozNVp7/c3dTuEjFk+a1kYqDTWNPJUcOCPsysv0
         urSk3ZafxVR4o98fHqTLnHZO2CjYcJu2VGe3mFXSiPYLHgPqypn93GqTaS1JGS5zdv0z
         pFjQ==
X-Gm-Message-State: AOJu0YwYeEIdL0/X6ZSqXvc+Xg0WyrqkfZVae+G8Yc/QIitXE366huPC
	ToVhMbBvfk/OkQ44z2YXmQJwCWDgm6drIPpi9RZRa0dwIaPV5ypPmJ+PvA==
X-Gm-Gg: ASbGncsAQzN/PyDKRDCL5RIkCZfdzuS4Bq3PkIeznZ6jYj08Gg/0sZA5q3y7zSUC5Hc
	4tLDSewOAkAYuia5Bz9x3FYT693K79axZd9fzGwJZncuJTu43JQCF8wc7pt7QSQCfOzkzv9Y0gU
	G4Za8B3XW6F+DkhxI+US9LYtEsNpY1uJVVROFM/6OtE5XMhEp9pdYd3buYmalgKv3b5cqtlsYVa
	S8M+xWllxRvsLpw92pMbxEHE9p+3GYF0AlbxvoXvtIFzIO1S55xXR1hag0lrD46i2IbzdFnc0M0
	r98RweOsr2BFot2XLVOFYiW8tjY8crrMJBqJ/vksD8lVXg==
X-Google-Smtp-Source: AGHT+IHVaCikxPAfKD3nVxMB2w36x9asP+To/968GqoCLutiWWy4dQgKWvWGajGe2kNbztYxf7FscA==
X-Received: by 2002:a05:6402:40c1:b0:5dc:d913:f89e with SMTP id 4fb4d7f45d1cf-5deade0b204mr9801823a12.22.1739528612052;
        Fri, 14 Feb 2025 02:23:32 -0800 (PST)
Received: from LAPTOP-0FHSM1V0.criticaltechworks.com ([213.205.68.220])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dedd35b0aasm1096306a12.52.2025.02.14.02.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 02:23:31 -0800 (PST)
From: "Pedro Ferreira" <pmi183@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH] rust-common.bbclass: soft assignment for RUSTLIB path
Date: Fri, 14 Feb 2025 10:23:29 +0000
Message-Id: <20250214102329.1475075-1-pmi183@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 17 Feb 2025 11:47:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1087

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


