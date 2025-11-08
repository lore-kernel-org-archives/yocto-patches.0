Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9662CCCFA1A
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:20:10 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13178.1762633201909814534
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:20:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bPahXpb1;
 spf=pass (domain: konsulko.com, ip: 209.85.219.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88056cab4eeso12088636d6.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762633201; x=1763238001; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVkQsCcoGXJ3IT5LR78eYMudST+oUeNJz+wQmPsKUCk=;
        b=bPahXpb1Z5fXxkBTh1tnyW2kZwWdx0K2hd3xd7Oj+pZH/R3xgubUAGLUsGxCQBetA6
         Bya28aHMcIQDuaOWD7wA2FQbkXQNQnriPiisg3Baq9AJK9MldZiVGoxXXbmvf75kdBx3
         LuwQ3vm/0tX54A8eCA4hM5c2PVgIzP9Inj78U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633201; x=1763238001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dVkQsCcoGXJ3IT5LR78eYMudST+oUeNJz+wQmPsKUCk=;
        b=H04u5h/UkIXek3s3alJUZs/UMarpUltPGbGM2mAYSwHL07UmfWU92YsmDAmxbGP78c
         tEDHJKDuDAOK+8Age6u/zGnZ92IxjeKWlgbTQEMi4r7UXRUiTl3n94/7sdb8UNx9H6RZ
         ytk9I6yGZivIOqQGucJ4cSlIMdkiwxolVlGW1FOTb04Scb+5cuJkViJWmGpNic6p/EKe
         ltiGbu7874mZbPS5/fhmfIIXJJMnnBz3iK8wMOgm36snPy5eFfvgerezR/RIVd35LASF
         2rCetIFTeF9+LRT73FzcLZUo7OdMhOBpkl7HxbDXXLDuc40Hth8qb4nVZZZcWsyg3uNn
         35bw==
X-Gm-Message-State: AOJu0Yy+P6MTHfBCYnJZAJDTvBDEWB8JUOW5+0aiY/WV0ZJN8N20EBoc
	/wfa02cLVGaPkawhSlmVV/u1xAv2LEnZn70c+DTVj6BHfF+1tlgRjBLA2vtcPFsTmlB2DVV483q
	UP8W6
X-Gm-Gg: ASbGnctaAunSfaZ2fTwzA91LwupKoEZ/Xt+7bYd37zYBjHryNrtdRMhT0RHUbx91i1Z
	fgmxitPi2hQzh09SNXVTAmpJSQdQ+BFN+LVmH9NoHpbWL3dD8vgcJRa5soARyi/DeVCnwY9JmsI
	4N4QNAbu8N1GW4pJ7Tnuax7lG1/1iLa8artBLONZVb4/sD0Ib6o5djB9OCH/9x843t09zVuGHCu
	jkU6tanFuq+JyJhtWz1rq0E67fU8B+0I2GIc7Luxf6aWKetSjfaOHDQ85rU6BNbebBVU0cjODRe
	Jcvp9VLTc3i9zNHxQ6/rHFvzDtZLbnfwE9dT+tHP36pgW4GxF22/MqXV+qRICL5CIPZN5gPQ5AS
	kisWyG0hbkHbB/duVrz0bXc+hoJoirrLoflHe8+WGPSMDiipaSfiBYsaJEaH/rL3aS+R9MOdo5n
	9N+4520JcyNGq4gVkd7XN9dz9HYA67ZdLx71IO2p8FiSNmTxQHFM/DtDOyvCpwZT9WtxLcBiUwX
	A==
X-Google-Smtp-Source: AGHT+IHTQgFYIwPOaV3Cn/Ph+49h0hXIKyUULmXeuGvZnEfGUPkCAtNuUwfCTmjOQsUi0z7jwdJ3uQ==
X-Received: by 2002:a05:6214:f2c:b0:880:2254:36a2 with SMTP id 6a1803df08f44-88238714e7emr40441316d6.64.1762633200502;
        Sat, 08 Nov 2025 12:20:00 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238ba36d4sm19786856d6.58.2025.11.08.12.20.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:20:00 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 08/11] libstd-rs: remove redundant CARGO_TARGET_DIR
Date: Sat,  8 Nov 2025 15:19:43 -0500
Message-ID: <fcbed109606d1ab19f4116aed99e95e76a72f2d0.1762633051.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762633051.git.scott.murray@konsulko.com>
References: <cover.1762633051.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2455

From: Ross Burton <ross.burton@arm.com>

The cargo class already sets this, so there's no need to set it again.

The value set by cargo.bbclass is actually ${B}/target, so update the
do_install task to match.

(From OE-Core rev: 3557f1c294531e7f8c34a2b0677e8c03f1b1be77)

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 9b0a3484626ecb5e58004572caac7a8e8f86980c)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/libstd-rs_1.90.0.bb | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/recipes-devtools/rust/libstd-rs_1.90.0.bb b/recipes-devtools/rust/libstd-rs_1.90.0.bb
index b39ec0a..8af93be 100644
--- a/recipes-devtools/rust/libstd-rs_1.90.0.bb
+++ b/recipes-devtools/rust/libstd-rs_1.90.0.bb
@@ -34,7 +34,6 @@ CARGO_BUILD_FLAGS += "--features '${CARGO_FEATURES}'"
 CARGO_VENDORING_DIRECTORY = "${RUSTSRC}/vendor"
 
 do_compile:prepend () {
-    export CARGO_TARGET_DIR="${B}"
     # For Rust 1.13.0 and newer
     export RUSTC_BOOTSTRAP="1"
 }
@@ -45,8 +44,8 @@ do_install () {
     # With the incremental build support added in 1.24, the libstd deps directory also includes dependency
     # files that get installed. Those are really only needed to incrementally rebuild the libstd library
     # itself and don't need to be installed.
-    rm -f ${B}/${RUST_TARGET_SYS}/${BUILD_DIR}/deps/*.d
-    cp ${B}/${RUST_TARGET_SYS}/${BUILD_DIR}/deps/* ${D}${rustlibdir}
+    rm -f ${B}/target/${RUST_TARGET_SYS}/${BUILD_DIR}/deps/*.d
+    cp ${B}/target/${RUST_TARGET_SYS}/${BUILD_DIR}/deps/* ${D}${rustlibdir}
 }
 
 BBCLASSEXTEND = "nativesdk"
-- 
2.51.0


