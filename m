Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669F2C55172
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:34 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4585.1785497605793549823
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TGPSak7G;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-930f72317a6so45079385a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497605; x=1786102405; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AUVjCmS+DBBN8+Nngrh0sfAdaM1N6isNf4X6nZ5j/Ss=;
        b=TGPSak7G/hagDzKgpsjWcTD+RuchITrzQONLbW8PdI0Qf0c8hHbN+K9M+khkWeFicW
         nVuQzIF33ydkxEym/UtEKe/PUSYmPp6CwVAefbDv0VuB64cQTx1LZE/mLMr3ubNxHDfR
         V3WEOHtnfi/BvrtkNs0CS3rK4/TZHeWqVLmpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497605; x=1786102405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AUVjCmS+DBBN8+Nngrh0sfAdaM1N6isNf4X6nZ5j/Ss=;
        b=aidPae24xqhP6Blhe1qnxwfGwmyaSQFc0NwpLg8umzVrtco7KEqr/t3ddCO1gCYXPA
         Zodtg5egJbUfVXWp7Y4Ya/0+aV91Bx82F5nbm43D963lrOUBIYYVJJlu/JXfLheoxce3
         73LEELp4pTCgGbTCyE0QuKQxppQeIZ4XaEYTHLDOUkX42B0B4lVfCVD7Jr8mTTlL3BW5
         29ZHAlBVvsrBGzJsLuw+3PWL+vUX8ed66/fZZD5EoByqw1vqCCuh47XRC8SXnwl11Dth
         6Qi9TcPzt+Cpt8jw9iyUqYXL4xFcc4TkVHQkm0pArOMBo1fix1ZH3KWn6mzJ1IsteU75
         ssZQ==
X-Gm-Message-State: AOJu0YwTQ5jhlahg0WAIWxQ0NM1ZgAQr0IV9N2ksidj97dGfXvNILtD3
	1fwgNvBJTp8EKI7RK5o5rkPxXFPz8XB2P+LHjWlw17Jed0jHJDTg+0C3vKnjoxCInZDo5i7OXnA
	hpJ2N
X-Gm-Gg: AR+sD12GWF55+MAucbamaI6YV5cTDZlu2gC6fIwPJ3EuPy3g89ATr1xEfAAl57QXRFv
	BEJ7UzWfx7M3YXw2GiQpASHgAZG0Ordjvo1IKayMuDY+qfIqS3rIkFkwTR2m7ffW0BnwaXyY+pi
	v2662hbyif0Qvvc8r5y4OORjUTiPrwlTHtwPBSxx5Z+uNaz1M+JNjnU7u3RR6+8vdWIEUdZB6Ks
	YdL200jtz6wYEMbTsOfSkCcqvBHPxGxsmxw4Kt9RLPJ4wGT+UNHISr1s68/phV972EmmjN5cvnH
	jH1CZ50FJbDv9WgkN1X5yGvAVpyu3RD/9LBX3gxEUclLmH2Pij+7+AntiFoVzO0Mth3xwV3BHqg
	npw9qOneyryv/dFnj3xPLpzm2UlBfGhIR6QZDmuTY4FeS2lEufGnV5xRoflvBpDZE0GoKLNPbX7
	I5QfY5bH5bD10q5qIKl/INl9dLREWe8X/WFpjzQtYzdC9xYnxjqtZcmLPbS5Rq12twqtUFBkBC8
	FsBhBFyTDoJWf3vcyf8WMe3M5AX7M6ay9UJm9b7JWMAEAPuSXV6YDdGTzMA+tmrSGOvdADfG/ns
	c1TicbnFL+eumk4iiOlYDgmLpQ==
X-Received: by 2002:a05:620a:4867:b0:915:6a2b:6265 with SMTP id af79cd13be357-9349b8830d8mr107889485a.44.1785497604494;
        Fri, 31 Jul 2026 04:33:24 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.23
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:24 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 09/35] rust: install Rust library sources for 'make rustavailable' support
Date: Fri, 31 Jul 2026 07:32:39 -0400
Message-ID: <e9c304a5f6dfca0cd9c96b49de278497c5c12355.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4585

From: Harish Sadineni <Harish.Sadineni@windriver.com>

The `make rustavailable` process (1) expects the Rust standard library source files (e.g., `lib.rs`)
to be present in the `library/` directory under `rustlib/src/rust/`.

This patch ensures the required sources are available by:
- Installing the `library/` directory (of size ~50MB) into `${D}${libdir}/rustlib/src/rust` for
  making them available during `make rustavailable` for native, target & sdk.
- packaging `${libdir}/rustlib/src/rust` sepearately with `${PN}-src-lib`.

1) See the kernel tree for Documentation/rust/quick-start.rst in the section: Requirements: Building

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/rust/quick-start.rst#n145

Signed-off-by: Harish Sadineni <Harish.Sadineni@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 2912ca3b341a5c5f6a658cde332ccd87368bd39d)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.94.0.bb | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/recipes-devtools/rust/rust_1.94.0.bb b/recipes-devtools/rust/rust_1.94.0.bb
index 8cfc2bd..2b907c7 100644
--- a/recipes-devtools/rust/rust_1.94.0.bb
+++ b/recipes-devtools/rust/rust_1.94.0.bb
@@ -237,10 +237,11 @@ do_test_compile () {
 
 ALLOW_EMPTY:${PN} = "1"
 
-PACKAGES =+ "${PN}-rustdoc ${PN}-tools-clippy ${PN}-tools-rustfmt"
+PACKAGES =+ "${PN}-rustdoc ${PN}-tools-clippy ${PN}-tools-rustfmt ${PN}-src-lib"
 FILES:${PN}-rustdoc = "${bindir}/rustdoc"
 FILES:${PN}-tools-clippy = "${bindir}/cargo-clippy ${bindir}/clippy-driver"
 FILES:${PN}-tools-rustfmt = "${bindir}/rustfmt"
+FILES:${PN}-src-lib = "${libdir}/rustlib/src/rust"
 
 RDEPENDS:${PN}-rustdoc = "${PN}"
 RDEPENDS:${PN}-tools-clippy = "${PN}"
@@ -257,6 +258,12 @@ rust_do_install() {
     rust_runx install
 }
 
+rust_do_install:append:class-native() {
+    install -d ${D}${libdir}/rustlib/src/rust
+    cp -r ${S}/library ${D}${libdir}/rustlib/src/rust
+    find ${D}${libdir}/rustlib/src/rust/ -name "*.sh" -type f -delete
+}
+
 rust_do_install:class-nativesdk() {
     export PSEUDO_UNLOAD=1
     rust_runx install
@@ -287,6 +294,11 @@ rust_do_install:class-nativesdk() {
 	export CARGO_TARGET_${RUST_HOST_TRIPLE}_RUNNER="\$OECORE_NATIVE_SYSROOT/lib/${SDKLOADER}"
 	export CC_$RUST_HOST_CC="${CCACHE}${HOST_PREFIX}gcc"
 	EOF
+
+    install -d ${D}${libdir}/rustlib/src/rust
+    cp -r ${S}/library ${D}${libdir}/rustlib/src/rust
+    find ${D}${libdir}/rustlib/src/rust/ -name "*.sh" -type f -delete
+
 }
 
 FILES:${PN} += "${base_prefix}/environment-setup.d"
@@ -307,6 +319,11 @@ rust_do_install:class-target() {
 
     install -d ${D}${libdir}/rustlib/${RUST_HOST_SYS}
     install -m 0644 ${WORKDIR}/rust-targets/${RUST_HOST_SYS}.json ${D}${libdir}/rustlib/${RUST_HOST_SYS}/target.json
+    install -d ${D}${libdir}/rustlib/src/rust
+    cp -r ${S}/library ${D}${libdir}/rustlib/src/rust
+    find ${D}${libdir}/rustlib/src/rust -name "*.sh" -type f -delete
+    install -m 0644 ${WORKDIR}/rust-targets/${RUST_HOST_SYS}.json ${D}${libdir}/rustlib/${RUST_HOST_SYS}/${RUST_HOST_SYS}.json
+
 
     chown root:root ${D}/ -R
     rm ${D}${libdir}/rustlib/uninstall.sh
-- 
2.55.0


