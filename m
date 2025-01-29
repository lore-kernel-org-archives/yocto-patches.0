Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309B6C0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 18:09:38 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
 by mx.groups.io with SMTP id smtpd.web11.19383.1738174170563015873
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jan 2025 10:09:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=rXAw+VWT;
 spf=pass (domain: konsulko.com, ip: 209.85.167.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb9bbcc936so4322890b6e.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 10:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1738174169; x=1738778969; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yG1Ft8KA2VXaEd8o6SOzkJpSvc2ThVPiZ/DF8s61Z0=;
        b=rXAw+VWT3ifd8aUg1S1R0zBqdkbxl76GPx2eC8+a/meD9+LG8dsLnMuSdtcdnV8L/W
         cFgbL5jOsfBOJrOEWv6DNO0EH5vfZfogB4dF89I2QlIA2SJFr64ANdgkN+Lz8iOhIicL
         J9t6eDtex08SAKWgiW+lqTxSx9s6/7wWm51oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174169; x=1738778969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yG1Ft8KA2VXaEd8o6SOzkJpSvc2ThVPiZ/DF8s61Z0=;
        b=GKjdiFvf7kOiuNiYhKGQf9Y4XFV3vVkFDZPahQ8WrmGz/tKZPvkuebS05qfwJWVplU
         pxhi+FUdR07j4uk8wM17DwPNqYtGPBkcmkyffPPuPDC0cwIEjpqMbC8yXogE019opq0D
         vX02CvIm3swMm6rGm1UqwPO4/EqQoU7bdO7/5KOsJH60qDizikRj99x8R2HHF8QUzpQH
         u1KE897Uoh5GHUm9U3XRZDSJkzmX38IOtb5V6nDhm18jT+hUUNo2XSiA1DhOAngRCYaI
         8kbysXVzhQ1gp76hP6iYUCPPHDzbBfEuUq537TJvfD672ZeorKFFrTfDtcdPwg7jA5HG
         CPAw==
X-Gm-Message-State: AOJu0YyypbcM1U01Xuxz4i1w2VeOIBsSC4cBatyGajvXnx2/mLg0wuw/
	G7LRp8eYciVnBZ2XRyU8utF+n1omCmJhffN+FDb782MXreGgJdFmX52vsddFwST8bPgUyjlzaXb
	E
X-Gm-Gg: ASbGnct+fAs0jzzoozmZCR7g+aAkfF2ke8c+mZN36mP/ocsSPeKBuRx0bC1NyvpxGok
	0L2scNsX4GO+NA6pzVXkq/S43I+3VbQaxcDI734S/BM7KvZf8+9tu5A+bKuZ3BpS3rPnzsjumei
	o837ijSU1WzxmYIvwLoIKe1dk8TpbwmYqZPqcAjaRD51SHr/DzoMN1G9Txb785VVDuzd3ZGUuGy
	neAke90jLPzOr0pqYqCHfQwHud+qWOW6isqfAZR7v132OefN7H/CMlaeN2oO55qPKDOfBHYUMIk
	cWMZ63NnDh6/40KJ1GOKpWUuL8tuiDE+F7FfdWL/waCtvRoeSyZBIUMEM/nwx8uZZkE=
X-Google-Smtp-Source: AGHT+IG+mIBxVbup01GDyoOfOgeGXd7W/qTncocTSCQ7n604SSAVxGDmgWcmcs/DpntCfl1k2e5BgQ==
X-Received: by 2002:a05:6e02:b:b0:3ce:7cca:7c0d with SMTP id e9e14a558f8ab-3cffe3d93edmr41215675ab.12.1738174159114;
        Wed, 29 Jan 2025 10:09:19 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1da4462asm3903034173.55.2025.01.29.10.09.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:09:18 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 6/9] rust: Fix for duplicate libstd.so
Date: Wed, 29 Jan 2025 13:08:57 -0500
Message-ID: <dab9a7300ded07788082ddebc718b1e272082e9a.1738173519.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738173519.git.scott.murray@konsulko.com>
References: <cover.1738173519.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 18:09:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1022

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

During the Rust build process, multiple copies of libstd-*.so are generated, as Rust copies the
required files from the stage2 build artifacts to the target image directory. When these build
binaries are copied to the image, Yocto's do_package step encounters an error. To resolve this,
the redundant libstd-*.so files are removed during the do_install step.

-----------------------------------------------------------------------------------------------
ERROR: rust-1.81.0-r0 do_package: rust: Multiple shlib providers for libstd-20c3de2d9292cd03.so:..
....
-----------------------------------------------------------------------------------------------

Multiple copies of libstd-*.so are generated during the Rust build process.
The redundant files are removed during the do_install step.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit effd4ba4c23cbf53b01116b5cc81d6a29ca3b1a6)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.80.1.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/rust_1.80.1.bb b/recipes-devtools/rust/rust_1.80.1.bb
index 396ea9c..cc00053 100644
--- a/recipes-devtools/rust/rust_1.80.1.bb
+++ b/recipes-devtools/rust/rust_1.80.1.bb
@@ -271,6 +271,7 @@ rust_do_install:class-nativesdk() {
     rm ${D}${libdir}/rustlib/uninstall.sh
     rm ${D}${libdir}/rustlib/install.log
     rm ${D}${libdir}/rustlib/manifest*
+    rm ${D}${libdir}/rustlib/${RUST_HOST_SYS}/lib/libstd*.so
 }
 
 EXTRA_TOOLS ?= "cargo-clippy clippy-driver rustfmt"
@@ -294,6 +295,7 @@ rust_do_install:class-target() {
     rm ${D}${libdir}/rustlib/uninstall.sh
     rm ${D}${libdir}/rustlib/install.log
     rm ${D}${libdir}/rustlib/manifest*
+    rm ${D}${libdir}/rustlib/${RUST_HOST_SYS}/lib/libstd*.so
 }
 
 addtask do_update_snapshot after do_patch
-- 
2.48.1


