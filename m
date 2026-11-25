Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3163.1795645898739765676
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Rd2zANRv;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53634b8328eso59841441cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645898; x=1796250698; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j2qj8Z2JD907thn6Km8ybTt5Y1nB9oOiktoKC2CAJgU=;
        b=Rd2zANRvITu3GKT/Q2bzSEUuk9qkkBUsOWIQ9N6yxIU/6oD0cN+LHjsbOu1sWsBcgL
         UHgXArzYkdljQkg09pfdfVfBQi3cJuYlp35jJGWiRPWz8loWV2NxH/nUHN75HWmJQEHR
         C+n59Fhigh9I1tLftZj9Zo4pn6ufNGNS0UUP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645898; x=1796250698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=j2qj8Z2JD907thn6Km8ybTt5Y1nB9oOiktoKC2CAJgU=;
        b=egk1VacgL0a2oKKbh43U1vL3oEESKZKEFfh0hhEMC0EP4BrOyYMgrh0wFP55gtEERh
         ax+A7J2cpnE3A86OUsC0ooIOmFrCK5QOf1TGLoAtcEb/d0bEMr3xeRUQwy3AymLcBpx8
         Iy+GpNBnAUsBc4G62jNx6ICTwojSF4T5p+98d0S+W0NqZSVgwOVh7VN4dakWJG59hnJt
         L/2BwxS4r7HEW3XY9oNHvxhMVDhI8R53NM0+2LOGO0UAoE20FPGkHs1dRQUa5R/u6g+w
         An5Y/7FwuPEmKwVwP0itEoVb7ABXgZiv422vQcFjHqxLzISXernoO0NU2YpNqQNRPd/v
         ZneA==
X-Gm-Message-State: APuU4Z+hk/Sf4jt3OjRaLOi9B7kUuqsTu2yZlCWOBO0G8eFKc7uig/MO
	1RL2Uq3F/FVdvZm1A9JsFlFR0VPPorf+L5HcVDRgJ2h3fXXEM6QBYyWK2Qm9J9Lz3iT0HaVAJDq
	IyfEl
X-Gm-Gg: AZFdTZcCRV6R2UfK95vL0fMaSxLLZahgSY4qi6YIkFpscToW5Vs24JPQoAg/JBi3Yoe
	nOSF8oJPcUHylqu0aSGQ3NmXZHh880V4TjTagVawjY4YPLRBCWJ83MHZdBVSAdXGrlZlgggxK/6
	ZdAjV6Hfhi8FstslHOBr706B2GmYvM3zzJPCOYJ3DhBGMugaQNVKyfC5Yor2xHJqBkJZZkWG2GB
	TaQKxC5HPGV4lN5bZxCAGyj5rG42a9pHLSrjQm7FtvwvuSaJzhx85CUdQXwzkIwql71WGhZ7neW
	iPdCH3dRDUsIQQrctsz8huAFAy1wsfCiyajrpZESSEXmw1PZbEsnMxzi02Zmo+64d9EkJWIR43B
	HFcMwKvcqEQw1Hr/ThgCQVd/dhEk8TH/anNLkM+ZogzE4Bh+uUlDKvGBiggHKX9KSG5gvtzrAut
	wW7YpUZjxXkacZgsuCqWiesTsIKIMRnaAhBJqr/MWe04bvpkWK+icAHc1iYeUTXkM3HW0tbh7TN
	esAeSlEIFQfEPZNeEChPAdijwSU5pdhJhW0uJ+bilMDBAjUns8kQEToIitxaxFug2llknY9OJ0m
	v4ySgrFJD3a1epNHwQM93RonKM60bD2WaXLNKpe3aWqpjvceZQErE6Xw/ZWjNyGD1FwBMcKoCi1
	u0lsdqBDBGQr8/F7GKbIMmDTyN03xjjTduaRUdHL9lZRThVGxyheCOU7QvifFpEyD/tI=
X-Received: by 2002:a05:622a:4d96:b0:536:35e1:b5 with SMTP id d75a77b69052e-55d7693c2e6mr359186241cf.1.1795645897308;
        Wed, 25 Nov 2026 14:31:37 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:36 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 18/19] librsvg: upgrade 2.63.3 -> 2.63.4
Date: Wed, 25 Nov 2026 17:31:09 -0500
Message-ID: <5667ac7a59d663fafea48426f7195e4470d2768a.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5537
Content-Type: text/plain; charset="utf-8"

From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>

Version 2.63.4
==============

librsvg crate version 2.63.3
librsvg-rebind crate version 0.3.0

- #1233 - Handle EXIF orientation in images, and handle the
  image-orientation property.  Note that the only values supported
  for this property are 'from-image' (the default) and 'none'.

  Note that this will change the rendering of SVG documents which
  assume the images with EXIF orientation data are not auto-oriented
  correctly.  In this case, please add the following attribute to the
  corresponding image elemnts:

    style="image-orientation: none;"

  Special thanks to Mark de Does for providing the test files for this
  feature.

Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit d3100bf587931dc4b132a2342c757f6ca936f996)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg-crates.inc      | 76 +++++++++----------
 ...append-RUSTFLAGS-to-rustc-executable.patch |  2 +-
 ...e-care-of-deprecated-assert_cmd-Comm.patch |  2 +-
 .../{librsvg_2.63.3.bb => librsvg_2.63.4.bb}  |  2 +-
 4 files changed, 41 insertions(+), 41 deletions(-)
 rename recipes-gnome/librsvg/{librsvg_2.63.3.bb => librsvg_2.63.4.bb} (98%)

diff --git a/recipes-gnome/librsvg/librsvg-crates.inc b/recipes-gnome/librsvg/librsvg-crates.inc
index 8574ab9..25e76f0 100644
--- a/recipes-gnome/librsvg/librsvg-crates.inc
+++ b/recipes-gnome/librsvg/librsvg-crates.inc
@@ -40,7 +40,7 @@ SRC_URI += " \
     crate://crates.io/cairo-sys-rs/0.22.9 \
     crate://crates.io/cast/0.3.0 \
     crate://crates.io/cbc/0.2.1 \
-    crate://crates.io/cc/1.8.0 \
+    crate://crates.io/cc/1.10.0 \
     crate://crates.io/cfg-expr/0.20.10 \
     crate://crates.io/cfg-if/1.0.5 \
     crate://crates.io/cfg_aliases/0.2.2 \
@@ -62,7 +62,7 @@ SRC_URI += " \
     crate://crates.io/core_detect/1.0.0 \
     crate://crates.io/cpubits/0.1.1 \
     crate://crates.io/cpufeatures/0.3.1 \
-    crate://crates.io/crc32fast/1.5.2 \
+    crate://crates.io/crc32fast/1.5.3 \
     crate://crates.io/criterion/0.8.2 \
     crate://crates.io/criterion-plot/0.8.2 \
     crate://crates.io/crossbeam-deque/0.8.8 \
@@ -97,7 +97,7 @@ SRC_URI += " \
     crate://crates.io/fallible_collections/0.4.9 \
     crate://crates.io/fastrand/2.5.0 \
     crate://crates.io/fdeflate/0.3.7 \
-    crate://crates.io/find-msvc-tools/0.1.14 \
+    crate://crates.io/find-msvc-tools/0.1.15 \
     crate://crates.io/flate2/1.1.10 \
     crate://crates.io/float-cmp/0.10.0 \
     crate://crates.io/fnv/1.0.7 \
@@ -134,19 +134,19 @@ SRC_URI += " \
     crate://crates.io/hybrid-array/0.4.15 \
     crate://crates.io/iana-time-zone/0.1.65 \
     crate://crates.io/iana-time-zone-haiku/0.1.2 \
-    crate://crates.io/icu_collections/2.3.0 \
-    crate://crates.io/icu_locale_core/2.3.0 \
-    crate://crates.io/icu_normalizer/2.3.0 \
-    crate://crates.io/icu_normalizer_data/2.3.0 \
-    crate://crates.io/icu_properties/2.3.0 \
-    crate://crates.io/icu_properties_data/2.3.0 \
-    crate://crates.io/icu_provider/2.3.1 \
+    crate://crates.io/icu_collections/2.4.0 \
+    crate://crates.io/icu_locale_core/2.4.0 \
+    crate://crates.io/icu_normalizer/2.4.0 \
+    crate://crates.io/icu_normalizer_data/2.4.0 \
+    crate://crates.io/icu_properties/2.4.0 \
+    crate://crates.io/icu_properties_data/2.4.0 \
+    crate://crates.io/icu_provider/2.4.0 \
     crate://crates.io/idna/1.1.0 \
     crate://crates.io/idna_adapter/1.2.2 \
     crate://crates.io/image/0.25.10 \
     crate://crates.io/image-webp/0.2.4 \
     crate://crates.io/indexmap/2.14.2 \
-    crate://crates.io/inout/0.2.4 \
+    crate://crates.io/inout/0.2.5 \
     crate://crates.io/is_terminal_polyfill/1.70.2 \
     crate://crates.io/itertools/0.13.0 \
     crate://crates.io/itertools/0.15.0 \
@@ -160,7 +160,7 @@ SRC_URI += " \
     crate://crates.io/js-sys/0.3.106 \
     crate://crates.io/language-tags/0.3.2 \
     crate://crates.io/lazy_static/1.5.1 \
-    crate://crates.io/libc/0.2.190 \
+    crate://crates.io/libc/0.2.191 \
     crate://crates.io/libfuzzer-sys/0.4.13 \
     crate://crates.io/libloading/0.8.9 \
     crate://crates.io/linux-raw-sys/0.12.1 \
@@ -273,7 +273,7 @@ SRC_URI += " \
     crate://crates.io/simdutf8/0.1.5 \
     crate://crates.io/siphasher/1.0.4 \
     crate://crates.io/slab/0.4.12 \
-    crate://crates.io/smallvec/1.16.3 \
+    crate://crates.io/smallvec/1.16.4 \
     crate://crates.io/stable_deref_trait/1.2.1 \
     crate://crates.io/static_assertions/1.1.0 \
     crate://crates.io/string_cache/0.9.0 \
@@ -285,7 +285,7 @@ SRC_URI += " \
     crate://crates.io/syn/3.0.9 \
     crate://crates.io/synstructure/0.14.0 \
     crate://crates.io/system-deps/7.0.8 \
-    crate://crates.io/system-deps/9.0.0 \
+    crate://crates.io/system-deps/9.0.1 \
     crate://crates.io/target-lexicon/0.13.5 \
     crate://crates.io/tempfile/3.27.0 \
     crate://crates.io/tendril/0.5.1 \
@@ -295,7 +295,7 @@ SRC_URI += " \
     crate://crates.io/time/0.3.55 \
     crate://crates.io/time-core/0.1.9 \
     crate://crates.io/time-macros/0.2.32 \
-    crate://crates.io/tinystr/0.8.4 \
+    crate://crates.io/tinystr/0.8.5 \
     crate://crates.io/tinytemplate/1.2.1 \
     crate://crates.io/tinyvec/1.13.3 \
     crate://crates.io/toml/1.1.8+spec-1.1.0 \
@@ -307,7 +307,7 @@ SRC_URI += " \
     crate://crates.io/unarray/0.1.4 \
     crate://crates.io/unicode-bidi/0.3.18 \
     crate://crates.io/unicode-ident/1.0.27 \
-    crate://crates.io/unicode-normalization/0.1.25 \
+    crate://crates.io/unicode-normalization/0.1.26 \
     crate://crates.io/unicode-properties/0.1.4 \
     crate://crates.io/url/2.5.8 \
     crate://crates.io/utf8_iter/1.0.4 \
@@ -341,15 +341,15 @@ SRC_URI += " \
     crate://crates.io/xml5ever/0.39.0 \
     crate://crates.io/yansi/1.0.1 \
     crate://crates.io/yeslogic-fontconfig-sys/6.0.1 \
-    crate://crates.io/yoke/0.8.3 \
+    crate://crates.io/yoke/0.8.4 \
     crate://crates.io/yoke-derive/0.8.4 \
     crate://crates.io/zerocopy/0.8.63 \
     crate://crates.io/zerocopy-derive/0.8.63 \
     crate://crates.io/zerofrom/0.1.8 \
     crate://crates.io/zerofrom-derive/0.1.8 \
     crate://crates.io/zerotrie/0.2.5 \
-    crate://crates.io/zerovec/0.11.8 \
-    crate://crates.io/zerovec-derive/0.11.6 \
+    crate://crates.io/zerovec/0.11.9 \
+    crate://crates.io/zerovec-derive/0.11.7 \
     crate://crates.io/zlib-rs/0.6.8 \
     crate://crates.io/zmij/1.0.23 \
     crate://crates.io/zune-core/0.5.3 \
@@ -394,7 +394,7 @@ SRC_URI[cairo-rs-0.22.9.sha256sum] = "df683f1d30b457964673a5541a4603208ef95ab687
 SRC_URI[cairo-sys-rs-0.22.9.sha256sum] = "ee548131103ad8f698c6725669647b9c757b3b66992dd6a026037596417bee21"
 SRC_URI[cast-0.3.0.sha256sum] = "37b2a672a2cb129a2e41c10b1224bb368f9f37a2b16b612598138befd7b37eb5"
 SRC_URI[cbc-0.2.1.sha256sum] = "ce2dc9ee5f88d11e0beb842c88b33c8a5cf0d1329c4b19494af42b07dbfe8896"
-SRC_URI[cc-1.8.0.sha256sum] = "6651c9ed80effdc7db0ff72512157f901af5e3549e341e24b1dd4887d836d838"
+SRC_URI[cc-1.10.0.sha256sum] = "86e055fa6e3e40ad6187ba25b6855eeb635d5271f8e0f0e1e9a5826b8d75bea0"
 SRC_URI[cfg-expr-0.20.10.sha256sum] = "9ba9e9ec16c447027685b1f897b720e18e9a8afd00bd7332c483537e38086c9f"
 SRC_URI[cfg-if-1.0.5.sha256sum] = "4e7648175b45a9a48536d676f68d918270699102aa8dab5496df06904c914600"
 SRC_URI[cfg_aliases-0.2.2.sha256sum] = "f079e83a288787bcd14a6aea84cee5c87a67c5a3e660c30f557a3d24761b3527"
@@ -416,7 +416,7 @@ SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f28077744574
 SRC_URI[core_detect-1.0.0.sha256sum] = "7f8f80099a98041a3d1622845c271458a2d73e688351bf3cb999266764b81d48"
 SRC_URI[cpubits-0.1.1.sha256sum] = "15b85f9c39137c3a891689859392b1bd49812121d0d61c9caf00d46ed5ce06ae"
 SRC_URI[cpufeatures-0.3.1.sha256sum] = "5ca28b0ae3115b884660db4118d803791fd6756b6e88f39c0f3f7859060d7566"
-SRC_URI[crc32fast-1.5.2.sha256sum] = "01a7799fd6b852db0e61728dde9a204c423b44d689dbd432522543614b490e78"
+SRC_URI[crc32fast-1.5.3.sha256sum] = "0ba106e844045ddc02c20768ac4b0b7cb45f2cc2ecbd833ac9f5dacb183c2055"
 SRC_URI[criterion-0.8.2.sha256sum] = "950046b2aa2492f9a536f5f4f9a3de7b9e2476e575e05bd6c333371add4d98f3"
 SRC_URI[criterion-plot-0.8.2.sha256sum] = "d8d80a2f4f5b554395e47b5d8305bc3d27813bacb73493eb1001e8f76dae29ea"
 SRC_URI[crossbeam-deque-0.8.8.sha256sum] = "622f3fc73690be383c7214310406f28a90e6edeadc3cea882f9d71e495b9711a"
@@ -451,7 +451,7 @@ SRC_URI[errno-0.3.14.sha256sum] = "39cab71617ae0d63f51a36d69f866391735b51691dbda
 SRC_URI[fallible_collections-0.4.9.sha256sum] = "a88c69768c0a15262df21899142bc6df9b9b823546d4b4b9a7bc2d6c448ec6fd"
 SRC_URI[fastrand-2.5.0.sha256sum] = "da7c62ceae207dd37ea5b845da6a0696c799f85e97da1ab5b7910be3c1c80223"
 SRC_URI[fdeflate-0.3.7.sha256sum] = "1e6853b52649d4ac5c0bd02320cddc5ba956bdb407c4b75a2c6b75bf51500f8c"
-SRC_URI[find-msvc-tools-0.1.14.sha256sum] = "aedcfb3409746eddb02b9e19ebda1c3394f759a152e48ee875a0844d1b955484"
+SRC_URI[find-msvc-tools-0.1.15.sha256sum] = "1c66915cc5391097de7a2b0b972e8505aa33c0df401fd3a6811dbdb32881ba48"
 SRC_URI[flate2-1.1.10.sha256sum] = "6e634e2e0ebac1ee034020da1ca582e17ffe4e0f5e985823721e168928136dcb"
 SRC_URI[float-cmp-0.10.0.sha256sum] = "b09cf3155332e944990140d967ff5eceb70df778b34f77d8075db46e4704e6d8"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
@@ -488,19 +488,19 @@ SRC_URI[heck-0.5.0.sha256sum] = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7
 SRC_URI[hybrid-array-0.4.15.sha256sum] = "27f864f10dfb56725ce5ce5472bc52252c8f93a4ab86327122cebf62c5f59a17"
 SRC_URI[iana-time-zone-0.1.65.sha256sum] = "e31bc9ad994ba00e440a8aa5c9ef0ec67d5cb5e5cb0cc7f8b744a35b389cc470"
 SRC_URI[iana-time-zone-haiku-0.1.2.sha256sum] = "f31827a206f56af32e590ba56d5d2d085f558508192593743f16b2306495269f"
-SRC_URI[icu_collections-2.3.0.sha256sum] = "fa68d21081c4a05d5a901a1c62add574c77048b6a1c67be3b50ce0b60d4ca513"
-SRC_URI[icu_locale_core-2.3.0.sha256sum] = "d56e28588da92eee5c3201a6eff33fabdd49b62269c8938d4ff050ce4d900deb"
-SRC_URI[icu_normalizer-2.3.0.sha256sum] = "12f9cf5f235641ed274641dd81c3f28d870e276763d0797aeeab72317b1c646f"
-SRC_URI[icu_normalizer_data-2.3.0.sha256sum] = "1563da1ed3e0b3bf3d74c9b85917ac9c56464d2f57242270c09c9e752f8021a0"
-SRC_URI[icu_properties-2.3.0.sha256sum] = "7e7ca276ad3145661a65914e6daf131ca5120cd3dcee8f8f3214b8875184a148"
-SRC_URI[icu_properties_data-2.3.0.sha256sum] = "e590f038c1464a96894fd6d10127e90a8be4509f56ff7ecef851b15cee0b7caa"
-SRC_URI[icu_provider-2.3.1.sha256sum] = "d27bbb9d3abbefac45d55f647c9de1d44aafcd1186eb91879afef17c396c3e73"
+SRC_URI[icu_collections-2.4.0.sha256sum] = "fe090a42a0d3140fed8c63263ed1fecc02422cb2f4bfe55cd8de2de1b8e105dd"
+SRC_URI[icu_locale_core-2.4.0.sha256sum] = "25d29b57c17c6528d0dc4c2141cfa2d08200465acb537a3909c8b9b8a4a984c0"
+SRC_URI[icu_normalizer-2.4.0.sha256sum] = "404a3b8c486f205c87fe7f23ab6894d84a4ad76d6e4671ae1981ba7def87c599"
+SRC_URI[icu_normalizer_data-2.4.0.sha256sum] = "20f0088bfb7441f7a37fa0c9e20cb1e9cba1cac6b9ce8cd2a6dc44294f8e8cbc"
+SRC_URI[icu_properties-2.4.0.sha256sum] = "2ea83d991c56158f7cf898bf86436c1dfe7c07ee82fe88951f2695c9f37a379f"
+SRC_URI[icu_properties_data-2.4.0.sha256sum] = "b98f29af82d02b163fe50161388350e743bb3107cc8e8c2f7314cb505faddfcf"
+SRC_URI[icu_provider-2.4.0.sha256sum] = "413099315636c588ee8f011190b329b971a09a8fae9d157e01dcae8379468514"
 SRC_URI[idna-1.1.0.sha256sum] = "3b0875f23caa03898994f6ddc501886a45c7d3d62d04d2d90788d47be1b1e4de"
 SRC_URI[idna_adapter-1.2.2.sha256sum] = "cb68373c0d6620ef8105e855e7745e18b0d00d3bdb07fb532e434244cdb9a714"
 SRC_URI[image-0.25.10.sha256sum] = "85ab80394333c02fe689eaf900ab500fbd0c2213da414687ebf995a65d5a6104"
 SRC_URI[image-webp-0.2.4.sha256sum] = "525e9ff3e1a4be2fbea1fdf0e98686a6d98b4d8f937e1bf7402245af1909e8c3"
 SRC_URI[indexmap-2.14.2.sha256sum] = "cc4e190f5d26ca7051642629da2c52fc03bde85a03197c99408dcd291734c855"
-SRC_URI[inout-0.2.4.sha256sum] = "3ce983bb6fb399067d101fbfc9e74174e07e9f29a2bc679efefeb8c645819c3f"
+SRC_URI[inout-0.2.5.sha256sum] = "3b5cf4372d022092674a83b8febf5865f7a573cc0c5baec5e49c879b6a20978f"
 SRC_URI[is_terminal_polyfill-1.70.2.sha256sum] = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
 SRC_URI[itertools-0.13.0.sha256sum] = "413ee7dfc52ee1a4949ceeb7dbc8a33f2d6c088194d9f922fb8318faf1f01186"
 SRC_URI[itertools-0.15.0.sha256sum] = "8b4baf93f58d4425749ca49a51c50ebab072c5df6994d08fed93541c331481dc"
@@ -514,7 +514,7 @@ SRC_URI[jobserver-0.1.35.sha256sum] = "1c00acbd29eabad4a2392fa0e921c874934dbbf41
 SRC_URI[js-sys-0.3.106.sha256sum] = "7883d941dae510fb2d978fc3fe018c71c9e2892fd38854de3e8b92c2e5ad9cc5"
 SRC_URI[language-tags-0.3.2.sha256sum] = "d4345964bb142484797b161f473a503a434de77149dd8c7427788c6e13379388"
 SRC_URI[lazy_static-1.5.1.sha256sum] = "20870f649af7073d53e38067b2a84312175d56ea15217e1b15bc83506ec50afb"
-SRC_URI[libc-0.2.190.sha256sum] = "ce5d3ddc6d3fa000eb1536d85e147bfe31aacaba692ed6a876f95cb7c855be78"
+SRC_URI[libc-0.2.191.sha256sum] = "65cd87c9a6d60536580b316ad985726104730a5151c99845f2490428ef91240a"
 SRC_URI[libfuzzer-sys-0.4.13.sha256sum] = "a9fd2f41a1cba099f79a0b6b6c35656cf7c03351a7bae8ff0f28f25270f929d2"
 SRC_URI[libloading-0.8.9.sha256sum] = "d7c4b02199fee7c5d21a5ae7d8cfa79a6ef5bb2fc834d6e9058e89c825efdc55"
 SRC_URI[linux-raw-sys-0.12.1.sha256sum] = "32a66949e030da00e8c7d4434b251670a91556f4144941d37452769c25d58a53"
@@ -627,7 +627,7 @@ SRC_URI[simd-adler32-0.3.10.sha256sum] = "3a219298ac11a56ea9a6d2120044824d6f01ae
 SRC_URI[simdutf8-0.1.5.sha256sum] = "e3a9fe34e3e7a50316060351f37187a3f546bce95496156754b601a5fa71b76e"
 SRC_URI[siphasher-1.0.4.sha256sum] = "33f4fe9184a62d842c9ef383018f3306d8ba224fd9d836f56d7288308847c256"
 SRC_URI[slab-0.4.12.sha256sum] = "0c790de23124f9ab44544d7ac05d60440adc586479ce501c1d6d7da3cd8c9cf5"
-SRC_URI[smallvec-1.16.3.sha256sum] = "5b3dc8af474f516a851ff4bd12db780f948b9250ad37211e4eec0bccea54e01b"
+SRC_URI[smallvec-1.16.4.sha256sum] = "d0d5d4b1981b8bbbb7aed204cae5726d683d5d6ac7e74ec54122ea28f315e7c8"
 SRC_URI[stable_deref_trait-1.2.1.sha256sum] = "6ce2be8dc25455e1f91df71bfa12ad37d7af1092ae736f3a6cd0e37bc7810596"
 SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
 SRC_URI[string_cache-0.9.0.sha256sum] = "a18596f8c785a729f2819c0f6a7eae6ebeebdfffbfe4214ae6b087f690e31901"
@@ -639,7 +639,7 @@ SRC_URI[syn-2.0.119.sha256sum] = "872831b642d1a07999a962a351ed35b955ea2cfc8f3862
 SRC_URI[syn-3.0.9.sha256sum] = "d78c8dee4c7bf0e14673097256fed6142ce9d3b85a408189d07482442145823b"
 SRC_URI[synstructure-0.14.0.sha256sum] = "901704edd0dfe137f1987838ee4f259e4e063c31371bdb423f7ae38ec6f77f02"
 SRC_URI[system-deps-7.0.8.sha256sum] = "396a35feb67335377e0251fcbc1092fc85c484bd4e3a7a54319399da127796e7"
-SRC_URI[system-deps-9.0.0.sha256sum] = "8a0dae2cbca1f0ff93795713cfe0a4c02f760e3c0b8ae2ab4ec4045808ff429f"
+SRC_URI[system-deps-9.0.1.sha256sum] = "db551ad38aac61d5e0343e0eeeb0163be3115c4e23b6a025959570ee0c03c67d"
 SRC_URI[target-lexicon-0.13.5.sha256sum] = "adb6935a6f5c20170eeceb1a3835a49e12e19d792f6dd344ccc76a985ca5a6ca"
 SRC_URI[tempfile-3.27.0.sha256sum] = "32497e9a4c7b38532efcdebeef879707aa9f794296a4f0244f6f69e9bc8574bd"
 SRC_URI[tendril-0.5.1.sha256sum] = "5fed54709c5b3a53d09bb1c113ea4f5ceafd1e772ddcb0030a82e1d56c087b08"
@@ -649,7 +649,7 @@ SRC_URI[thiserror-impl-2.0.21.sha256sum] = "fe5197923287db20a58125f0bc85c062f7f2
 SRC_URI[time-0.3.55.sha256sum] = "cdb87b95ec50ddfa440816d227a17b2ccbdda963a316a727fda0fc4334f7d134"
 SRC_URI[time-core-0.1.9.sha256sum] = "9e1c906769ad99c88eaa54e728060edef082f8e358ff32030cb7c7d315e81109"
 SRC_URI[time-macros-0.2.32.sha256sum] = "7e689342a48d2ea927c87ea50cabf8594854bf940e9310208848d680d668ed85"
-SRC_URI[tinystr-0.8.4.sha256sum] = "b1e27c91459209c2986af3dcf603a5a74a4368754ce37414f59acc971167f643"
+SRC_URI[tinystr-0.8.5.sha256sum] = "abc840c238154d58f9e86b2792261edfde565a17696e1cda1a449de27979801a"
 SRC_URI[tinytemplate-1.2.1.sha256sum] = "be4d6b5f19ff7664e8c98d03e2139cb510db9b0a60b55f8e8709b689d939b6bc"
 SRC_URI[tinyvec-1.13.3.sha256sum] = "fd3ca314f692efd6c868f8408f53fe444634a845f96c028b97d35f6a1f79f0ee"
 SRC_URI[toml-1.1.8+spec-1.1.0.sha256sum] = "20489e00e4d8741d6be680764cc12e270655e375a20d1011e844a9c3379e678d"
@@ -661,7 +661,7 @@ SRC_URI[typenum-1.20.1.sha256sum] = "b6f5e870be6c3b371b77fe0ee0bafb859fa4964b440
 SRC_URI[unarray-0.1.4.sha256sum] = "eaea85b334db583fe3274d12b4cd1880032beab409c0d774be044d4480ab9a94"
 SRC_URI[unicode-bidi-0.3.18.sha256sum] = "5c1cb5db39152898a79168971543b1cb5020dff7fe43c8dc468b0885f5e29df5"
 SRC_URI[unicode-ident-1.0.27.sha256sum] = "a2c754d6c33795a1c324727428e5a7dedb5b06195f9890bdbcba760d3e246563"
-SRC_URI[unicode-normalization-0.1.25.sha256sum] = "5fd4f6878c9cb28d874b009da9e8d183b5abc80117c40bbd187a1fde336be6e8"
+SRC_URI[unicode-normalization-0.1.26.sha256sum] = "75cd3fb03d5288b3ba9a1ee103ac7e9cbb59f0b03d64f8ddfcc04dd42758a85d"
 SRC_URI[unicode-properties-0.1.4.sha256sum] = "7df058c713841ad818f1dc5d3fd88063241cc61f49f5fbea4b951e8cf5a8d71d"
 SRC_URI[url-2.5.8.sha256sum] = "ff67a8a4397373c3ef660812acab3268222035010ab8680ec4215f38ba3d0eed"
 SRC_URI[utf8_iter-1.0.4.sha256sum] = "b6c140620e7ffbb22c2dee59cafe6084a59b5ffc27a8859a5f0d494b5d52b6be"
@@ -695,15 +695,15 @@ SRC_URI[writeable-0.6.4.sha256sum] = "3ad82d2a33cdc9674dc7465672f271e096168fcdbe
 SRC_URI[xml5ever-0.39.0.sha256sum] = "5ab627f34ff61b80d756180d556f9c68801d836d271b3b8c094504ceca69d221"
 SRC_URI[yansi-1.0.1.sha256sum] = "cfe53a6657fd280eaa890a3bc59152892ffa3e30101319d168b781ed6529b049"
 SRC_URI[yeslogic-fontconfig-sys-6.0.1.sha256sum] = "1d8b8abf912b9a29ff112e1671c97c33636903d13a69712037190e6805af4f76"
-SRC_URI[yoke-0.8.3.sha256sum] = "709fe23a0424b6a435d82152b1bd3fdfb0833487d5fa90d05d42762a9891fef5"
+SRC_URI[yoke-0.8.4.sha256sum] = "417ef3fcf6c300b7dbd25c85531a746931c02ad536f3cf4786ed1e88223340b3"
 SRC_URI[yoke-derive-0.8.4.sha256sum] = "ec8ebde2db3681e8c9980cc27822030e68752690ddfa9473e739aeb4dbde6d71"
 SRC_URI[zerocopy-0.8.63.sha256sum] = "e5fe1f8f1b06191a00962174c61aa5005e0bb391a6d80d07e24d115c01a92ed8"
 SRC_URI[zerocopy-derive-0.8.63.sha256sum] = "863ad3ac83293fb4d740aedbfdc9240dd8d1a50c1099acd76ce80ce7c7230c7f"
 SRC_URI[zerofrom-0.1.8.sha256sum] = "0ec05a11813ea801ff6d75110ad09cd0824ddba17dfe17128ea0d5f68e6c5272"
 SRC_URI[zerofrom-derive-0.1.8.sha256sum] = "f75b4683f6c7f45248d4d64056a24298c6281e0993356d7d1b4a1a962ef10d4a"
 SRC_URI[zerotrie-0.2.5.sha256sum] = "4ea269c3bd32f0a32c321907a2ae912ba6f4649bb0fc764a15627e99a7095a3f"
-SRC_URI[zerovec-0.11.8.sha256sum] = "bb0464e17806c1d976d5cba29399c7f08e516e279e2ba493f63123b5fca67dd8"
-SRC_URI[zerovec-derive-0.11.6.sha256sum] = "34df6fc39dbd26ddc9c10e6a2984476e13acce22e64e4487636ef494369225da"
+SRC_URI[zerovec-0.11.9.sha256sum] = "f58a2799cfe9a1670c7ea8edbd52ef8edb93cb37a7f83bf31ba9e35d9dae6a40"
+SRC_URI[zerovec-derive-0.11.7.sha256sum] = "c3743ddbf47738d929cd1ae2e199d40d0162979dfe31aef8ae646d2bf00bf97a"
 SRC_URI[zlib-rs-0.6.8.sha256sum] = "b268e58e7c693d7c271f93ffc4ba3b380412554231c85bf61ca7af91042a4112"
 SRC_URI[zmij-1.0.23.sha256sum] = "29666d0abbfad1e3dc4dcf6144730dd3a3ab225bbbdac83319345b1b44ccfc1b"
 SRC_URI[zune-core-0.5.3.sha256sum] = "d56377fd46368984a170bc5aac5567e52ca5da874caa60bea39fcbca78fb658b"
diff --git a/recipes-gnome/librsvg/librsvg/0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch b/recipes-gnome/librsvg/librsvg/0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch
index d9a7fbf..a0a6d09 100644
--- a/recipes-gnome/librsvg/librsvg/0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch
+++ b/recipes-gnome/librsvg/librsvg/0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch
@@ -1,4 +1,4 @@
-From faa062c4bbd9f3678997a90c85ec4efa05156c07 Mon Sep 17 00:00:00 2001
+From 31483d73f4a46f18bb18b149532d89c3b9a7ad11 Mon Sep 17 00:00:00 2001
 From: Gyorgy Sarvari <skandigraun@gmail.com>
 Date: Sat, 2 Aug 2025 20:57:49 +0200
 Subject: [PATCH] query-rustc: append RUSTFLAGS to rustc executable
diff --git a/recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch b/recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch
index 35ae9a7..22e0f6c 100644
--- a/recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch
+++ b/recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch
@@ -1,4 +1,4 @@
-From 5fca1f7d88ce817cb532e6b7e7168d3beb1a86f4 Mon Sep 17 00:00:00 2001
+From fe9e7305af55f4f24fa026cb7d4c3925ab6a75d9 Mon Sep 17 00:00:00 2001
 From: Alexander Kanavin <alex@linutronix.de>
 Date: Thu, 18 Dec 2025 18:43:20 +0100
 Subject: [PATCH] tests: revert 'Take care of deprecated
diff --git a/recipes-gnome/librsvg/librsvg_2.63.3.bb b/recipes-gnome/librsvg/librsvg_2.63.4.bb
similarity index 98%
rename from recipes-gnome/librsvg/librsvg_2.63.3.bb
rename to recipes-gnome/librsvg/librsvg_2.63.4.bb
index 4f55d78..78fac72 100644
--- a/recipes-gnome/librsvg/librsvg_2.63.3.bb
+++ b/recipes-gnome/librsvg/librsvg_2.63.4.bb
@@ -26,7 +26,7 @@ require ${BPN}-crates.inc
 SRC_URI += "file://0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch \
             file://0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch \
             file://run-ptest"
-SRC_URI[archive.sha256sum] = "55311c2293612e4a2e38cd9bdb6160a1c85c158adc7c97e423e1e65949afb6a4"
+SRC_URI[archive.sha256sum] = "31f07d9350dad3f8964fd613c31309ac160fdef13dfac59df6fd082de78d6e8f"
 
 UPSTREAM_CHECK_REGEX = "librsvg-(?P<pver>\d+\.\d+\.(?!9\d+)\d+)"
 
-- 
2.56.1

