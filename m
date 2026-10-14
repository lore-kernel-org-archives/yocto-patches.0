Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A11CC6B1A
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:43 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14672.1791987153628209928
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=EO1Dxkkv;
 spf=pass (domain: snapchat.com, ip: 209.85.128.44, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so25730865e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987152; x=1792591952; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+Hqw8AXLhClCOz5PmSTsx88ITnL+KobmWm6ONCsFaU=;
        b=EO1Dxkkv3M3P1YxKLshQQ5dlknTiRA8yCFPK40+6EavBcVOfUZiAKH8mH0FY+PKHqo
         NnRXrS8QS4zcGlVpvwpeh4afITEouAuN5OkwGqEYKTXn10xpqNUmUuboV2oAejEWVscQ
         POJ7uVasTHMc14LFZYKBwzsEd41KdGJOAGXW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987152; x=1792591952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r+Hqw8AXLhClCOz5PmSTsx88ITnL+KobmWm6ONCsFaU=;
        b=1SR1NF4hOx6irgY8LQsB0XoGXL2JN0MkHnPoxbMBiXL3f7uwAnYxoB+7NaaTYjl6/X
         bLVcicbAxi2Ef2ad/rmRDbGXTqr+9xgTW5RKVQK5riOCs3ZDR3Ah5vicB/plEV7mKEaD
         hDuX8gk0HxaQKlYDPFcBnR7vurS2ODZURWSVyoeAum9X4/NZICSCu78xsv0o7jOVL+rE
         zEEk48kuPdra0qRHmHenErE9B3HVEs4JDvhKzgsX85lzNn6r+nlBdBVRNZtI1cZhwaAp
         D+qYVTpLmDbxVHnQ16G1rg3gkT2pSc07MBvl13W2ZUOrbSX7r9SOB/PlCN5Uf/NUOHWg
         NigQ==
X-Gm-Message-State: AFq9FYI8ccyx1liZFxjn8cy+bDfrqM/J0D2+5AmsLIN6j43JRtJgc5yp
	sUcQ+MUmbo6xBDTp4iD0bnR0PANgB+yKtyc52bMAi2WjsWRFpHxIgZ96uPITnqpqlyU+/yO1hKE
	CMTmLYZs=
X-Gm-Gg: AYBFou2PO4YvXBeqjvXEf7c5ifM2CEExvgOqSR5J4sX1TqB00DqPlkTjTDYxTERp36R
	m3nADauuPwi+T6VCRB8hVUIf1+4qHMAsK+NYKxQdbDJL6X+jhnfKX42NHcPqDP0W+cC7mfQRPnA
	p4rFsep1zUNscEdy5okIjNCFZZLqj5UGcIiS0qtArI24axol4DFqfTqlRH7oec3tTeC+R85kHp2
	y+meKiS6TfHZBoBSuT5nbkHk4BuTZ6Mhn5mNiRKsjHnlDxntdq3hbtz4tBwuAOlw9pSRSFjSirS
	djCQ9G1QbhJxdjsyFGIdWHIJOW++upkZr9kf0VNkWBPJ4wvHKMo8D892qVzB091ya9IktfY0CuC
	M4xPwfo8tM9Ub2hIY45evTor18doDPGldFw7B8je/VRnbrhpl8rFSi2qsdpFMZTcSh4MN4JsfzP
	R5hJmH8Ik79ezo7NmKv/0uChVtUO3VUI53YZDmYddab2wx2uUNBP2Gi6bADSLCcE2qzt2POocrw
	FN5p7pfoEUJ7l8j0qwICuigsBKg23JPagc7OADbnQ==
X-Received: by 2002:a05:600c:3e0a:b0:49e:6050:9fbe with SMTP id 5b1f17b1804b1-4a18e49c52bmr308168835e9.15.1791987151788;
        Wed, 14 Oct 2026 07:12:31 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:30 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 07/21] cctools-port-crosssdk: fix stale virtual/binutils provider name
Date: Wed, 14 Oct 2026 16:10:28 +0200
Message-ID: <20261014141209.488034-7-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5012

From: Etienne Cordonnier <ecordonnier@snap.com>

Upstream OE-core commit 4ccc3bc826 ("classes/recipes: Switch
virtual/XXX-gcc to virtual/cross-cc (and c++/binutils)", Jan 2025)
renamed the parameterized virtual/${TARGET_PREFIX}binutils and
virtual/${SDK_PREFIX}binutils to fixed literals virtual/cross-binutils
and virtual/nativesdk-cross-binutils. binutils-crosssdk and
gcc-crosssdk.inc were updated upstream to the new name, but
cctools-port-crosssdk's own PROVIDES and the darwin-common.inc
PREFERRED_PROVIDER override still used the old, now-unmatched name, so
cctools-port-crosssdk silently stopped being selected as the
binutils/as/ld provider for the darwin crosssdk toolchain (gcc, clang,
go). Builds fell back to plain GNU binutils-crosssdk instead, which
has no working Mach-O assembler/linker, causing gcc-crosssdk's
target-libgcc configure to fail with "as: $original is unset".

Confirmed against hawaii/sources/yocto-docs's own migration-5.2.rst,
which documents this exact rename.

AI-Generated: Claude Sonnet 5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 conf/machine-sdk/darwin-common.inc                            | 2 +-
 recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/conf/machine-sdk/darwin-common.inc b/conf/machine-sdk/darwin-common.inc
index 3dec2b4..632c6b0 100644
--- a/conf/machine-sdk/darwin-common.inc
+++ b/conf/machine-sdk/darwin-common.inc
@@ -5,7 +5,7 @@ SOLIBSDEV:darwin21 = ".dylibbroken"
 
 PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-for-gcc = "nativesdk-osx-runtime"
 PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-initial = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/${SDK_PREFIX}binutils = "cctools-port-crosssdk"
+PREFERRED_PROVIDER_virtual/nativesdk-cross-binutils = "cctools-port-crosssdk"
 PREFERRED_PROVIDER_virtual/nativesdk-libc = "nativesdk-osx-runtime"
 PREFERRED_PROVIDER_virtual/nativesdk-libintl = "nativesdk-osx-runtime"
 PREFERRED_PROVIDER_virtual/nativesdk-libiconv = "nativesdk-osx-runtime"
diff --git a/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb b/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb
index 0053585..3abeb02 100644
--- a/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb
+++ b/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb
@@ -16,7 +16,7 @@ DEPENDS += " \
     libdispatch-native \
 "
 
-PROVIDES = "virtual/${TARGET_PREFIX}binutils"
+PROVIDES = "virtual/nativesdk-cross-binutils"
 
 DEPENDS += " \
     clang-native \
-- 
2.43.0


