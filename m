Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7044EC88E5D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:04 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48526.1789157639996048625
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=r1x78x9y;
 spf=pass (domain: konsulko.com, ip: 209.85.160.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5306baf6b53so19004011cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157639; x=1789762439; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7TQMsDur/mo5Dlh8WKRz1kloP+4iEgPRa/8QL6t1Wvc=;
        b=r1x78x9yTHaBzSQYIusGTY0QaCpH3N2MHMlMv/ezqjWeJ5bJvbcxVV6SI9eP4PKPPi
         j6rwq3XMEcR3Ck2kuaygmAJzKifVJ6BEHJr7a6g9wFdT7RGeLfIAMbP05vCXoMN3up9s
         hMgwY2haSqbm6LCFpvJ6xRUv6D8ZZlc3GpLh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157639; x=1789762439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7TQMsDur/mo5Dlh8WKRz1kloP+4iEgPRa/8QL6t1Wvc=;
        b=or5EF1G+1udnkXlUKp//LAnd7OFJCwhAj64EJamXlQHRrYu6MFofwZiJmBjVti8a2d
         dGgNL5AfAeZ7TuhlB+FyJ71GU4TTFiCuUKIVIy+lqst++H9ZQvYOBz3SOLpdJJByLu+9
         U01RGsy+f6J1kOyobhsU9nrpUynAqEwQo7zn0tX7km8lRqFv94GFLmgf1i/RGycuYrxE
         TrHSzdt4xKShc5HH2DQBIj6rRkp05RnJwksBUI9CafV/cuJ8YFcrexw07XYaM0/U5XfQ
         ChLRiSuZmN60rAwyltUVGFC7y+XzkqBnZE7p54CHWmVh5bS4kwlZ8Hm8qFAS2B1wWV60
         +2eA==
X-Gm-Message-State: AFuF++nrQyLspXZLNxapUf5FhGfxqDYDF2YF0NCpSbA5CHPyV+NIg81u
	z83m1fXIUlFwD1fb/EezxUyXOsTF9Z1NWPk1hNOUKUj2S/n6PvV0Ns24giNEgQjhizCdG1m5fhj
	RahE2
X-Gm-Gg: AYBFou0eAFP2uYXCQkX2ExDoDlNxYeRHhtpQgZWBy7skYzwHeg4ruU2frSID0AJwJU6
	CC+BK8woZbIiw7uI1CNcBZXj7okwhXnhkQJNzFjiyHGUM8k3/lNozC1zKysuSdHzpt2H8rvJ688
	IiYAxc8601i0alJYCOgZV59y9/hYJOLNMZKDg31mDLTpbQEfT1+16OyswxIsDbRY61wZFli445G
	Z1HwYdHinR/QTRoFukMuqfCSgfXXBRpGsFBo//287L+UUYAewSTzoDEYBwXXl1vgSA3No+7pbow
	tGLQ+dPMqxzXZpFoL6FoKxTn3Y842Fno+SyyIMgkw7v0sBjOY2/2ltKN+CU/vheJ34s1ZonBeb/
	3YV5AfXbKt6vBHvx4j3Ma+ROdnAddPwigzNbihb7D80yeIEF+pmvFn3IKr1GUmno4ur9a+xzezq
	TJe13gQiUstbsbwLEjgkJnv6WnriqlIt3bB/SY8CH5Ojz3hQGMbkYQxfYifQMB2wn28YfUl9+wy
	f+aG8ICX+PMQAUWpm9oFgW9KhTy094jz+By6rHn+HoSnPWhKFxg0Gli3bP5+K1Mu7pKdKWepM6X
	hqNBJncis3dFS1DH9gMF5J8Fs6TXurfysF0=
X-Received: by 2002:a05:622a:1b8f:b0:52f:c0f4:8 with SMTP id d75a77b69052e-530c87132eemr87018501cf.40.1789157638695;
        Fri, 11 Sep 2026 13:13:58 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:58 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 21/37] rust: clean up dependencies
Date: Fri, 11 Sep 2026 16:13:07 -0400
Message-ID: <192e2251c2653163ff7fc6c9e93470f6f86f562f.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4787

From: Ross Burton <ross.burton@arm.com>

The rust recipe inherits cargo_common which now depends on rust-native
and cargo-native, so we can just remove those dependencies in the native
case instead of having to handle target/nativesdk.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 32c44d640af9b7dce1571986d5d37204517c2b9f)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.96.1.bb | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/recipes-devtools/rust/rust_1.96.1.bb b/recipes-devtools/rust/rust_1.96.1.bb
index a7101d5..581523a 100644
--- a/recipes-devtools/rust/rust_1.96.1.bb
+++ b/recipes-devtools/rust/rust_1.96.1.bb
@@ -12,18 +12,16 @@ inherit rust
 inherit cargo_common
 
 DEPENDS += "rust-llvm"
+
 # native rust uses cargo/rustc from binary snapshots to bootstrap
 # but everything else should use our native builds
-DEPENDS:append:class-target = " cargo-native rust-native"
-DEPENDS:append:class-nativesdk = " cargo-native rust-native"
-
-RDEPENDS:${PN}:append:class-target = " gcc g++ binutils"
-
-# Otherwise we'll depend on what we provide
+DEPENDS:remove:class-native = "cargo-native"
 INHIBIT_DEFAULT_RUST_DEPS:class-native = "1"
-# We don't need to depend on gcc-native because yocto assumes it exists
+
 PROVIDES:class-native = "virtual/${TARGET_PREFIX}rust"
 
+RDEPENDS:${PN}:append:class-target = " gcc g++ binutils"
+
 S = "${RUSTSRC}"
 # Separate build directory from the shared source tree so that multiple
 # variants (target, native, nativesdk) don't conflict in the source dir.
-- 
2.55.0


