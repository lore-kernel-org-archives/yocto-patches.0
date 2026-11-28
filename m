Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9277.1795883251411361285
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:27:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=NzWXs84u;
 spf=pass (domain: konsulko.com, ip: 209.85.128.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so73215115e9.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795883250; x=1796488050; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LZYq2G6jk+mLS6U1CmhS6Bx0pR8d8cYKJmzFGzz6A+M=;
        b=NzWXs84uFFc4dHsLicOYcYxmGOJRkb0MBRbri2a8iwQeQ1pERUtY1zoARfNTPfvzJE
         N84/X3pD+Vkh2BRZhB3xzckARq/14MD0eeblEOOhly++RBo67DDd7bcIUPY3MkrTcL32
         9gyr5r+KaliopQNnczQt85qhL6m+jP9fm01h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795883250; x=1796488050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LZYq2G6jk+mLS6U1CmhS6Bx0pR8d8cYKJmzFGzz6A+M=;
        b=e3PpKl443+lPt3DjdS8ymu/FWtq93TlhfYFtZr5TIXY2YHjP/fiUs5uoA1FvL2w+LC
         4L/jLNYenVx/WAOhS7Bkp4Vm6A/lX9Z0Lt8lRo+1kCJN1JiVyWqh7hherwrrY6+ODgZv
         /ouMXlfeKsmiCi6gjg9fXUZqi12dGki/oXO1Mx2hilU7uaN2PoBN/qibbYlseGO91iWG
         ey7pPpT4XWL237ULKUrwmov5qGRg2IEFcN6X7rVdEGYB2UEaHAhK+x4BY6yfUYLZA0fP
         mKBMF/35IA2HkItR7FNz5P8flINts+CwfmtLla814TMlWKGKvtBRVSZYzMj3g27d+gaF
         an0Q==
X-Gm-Message-State: APuU4Z+zPVooW96i9VPMWQtn/4gQCOUS/eHpQPK5BH2LzXFDe9Q8iw6d
	Jby2ZgoisHq0r7RbOcQX19FYdc8tUnb5UIini2pnxtS3IUHsASWZKJJpTfv8eoe0veK7Bufh3eN
	ORlrMhsQ=
X-Gm-Gg: AZFdTZfI7bBpZzOUJYPNSJimHO5UI+oQXibY5FmA9G53y5XCOlgw1g6l7EJCX37F6TL
	bHxlex4O6ztReudNP0z9d9spuy+87Y+ZijzAw7w8lRj1OrRKtDmHi47GLanUIQwOwwB5feaxR2I
	2jwC/qJoaFbXK18j4OkLostyWTr7Z6HZX5QNCP0gCEKhwTujkAcgDmlgRSuVhfTFPvUU00d/iJW
	4il1UhxPfeI+5bbT7SOdgvoOSA0NYZ5poVAxFlTFoBPJ8sHexFsdQMBCc+3ckWJ4xs2Qvf5THuN
	HG5h2bqOQ2BS45pUeepHjeLvf1Ae5zIufHCanNb6HJCUvzEMrs17qzi1DWpT+uxMWUrA7C3LXWj
	0RYG9ADsw1hUCr9jHL4bYETg3/J+L9vlP+jrCHHKHTWagYfyhp2CaAUD5qjGB9x1qlDbt6zQWsR
	OjLxB/7RP4UDrmC+S9d3cBcQoPne6KoLi/tvqPKc2IWF8X+tdD0JZKVVQirjLqzYleHC6E1vXL/
	V6H3SMCMsc/RWqMfNl1mV7uQF7gDiF0XDja+2dY+OpMiV2wyysELrCRkd6icjzSoLI32pO4RKxx
	X2F3GDsCb28smoMJqOUZfyGrxxVUfeNWsEO6lH4HmBzL5uRBVZ0U+EgCQ1bVe43RuvvU/sPAB1q
	hvwdeOzdG7oGApNG/S5mqqRdq9/msZeY=
X-Received: by 2002:a05:600c:4504:b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4bb888284d7mr587142885e9.31.1795883249430;
        Sat, 28 Nov 2026 08:27:29 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm529202045e9.1.2026.11.28.08.27.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:27:28 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 04/10] parsec-tool: Fix building with Rust 1.100
Date: Sat, 28 Nov 2026 18:27:07 +0200
Message-ID: <0288d7bbc6715f4cb5195e980bb73fe0335b9ee5.1795882913.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795882913.git.scott.murray@konsulko.com>
References: <cover.1795882913.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:27:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5563
Content-Type: text/plain; charset="utf-8"

Add a patch to bump the picky-asn1-x509 crate version to pick up a
fix for building with Rust 1.100.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../0001-Update-picky-asn1-x509-version.patch | 47 +++++++++++++++++++
 .../parsec-tool/parsec-tool-crates.inc        |  4 +-
 .../parsec-tool/parsec-tool_0.7.0.bb          |  1 +
 3 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 meta-parsec/recipes-parsec/parsec-tool/files/0001-Update-picky-asn1-x509-version.patch

diff --git a/meta-parsec/recipes-parsec/parsec-tool/files/0001-Update-picky-asn1-x509-version.patch b/meta-parsec/recipes-parsec/parsec-tool/files/0001-Update-picky-asn1-x509-version.patch
new file mode 100644
index 0000000..9ec5da1
--- /dev/null
+++ b/meta-parsec/recipes-parsec/parsec-tool/files/0001-Update-picky-asn1-x509-version.patch
@@ -0,0 +1,47 @@
+From 95cd36a79846d55a74b8ab6f23c15aad52dcd115 Mon Sep 17 00:00:00 2001
+From: Scott Murray <scott.murray@konsulko.com>
+Date: Thu, 26 Nov 2026 23:28:16 +0200
+Subject: [PATCH] Update picky-asn1-x509 version
+
+Update picky-asn1-x509 from 0.12.0 to 0.12.1 to pick up its fix
+for Rust 1.100.
+
+Upstream-Status: Pending
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ Cargo.lock | 4 ++--
+ Cargo.toml | 2 +-
+ 2 files changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/Cargo.lock b/Cargo.lock
+index 89af22d..6a6185d 100644
+--- a/Cargo.lock
++++ b/Cargo.lock
+@@ -881,9 +881,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "picky-asn1-x509"
+-version = "0.12.0"
++version = "0.12.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "2c5f20f71a68499ff32310f418a6fad8816eac1a2859ed3f0c5c741389dd6208"
++checksum = "afc9118855ef6387a31b86ceb6e7871cd0149309531df64efc41857b9915b3f5"
+ dependencies = [
+  "base64 0.21.4",
+  "oid",
+diff --git a/Cargo.toml b/Cargo.toml
+index 2237b3a..b6079d3 100644
+--- a/Cargo.toml
++++ b/Cargo.toml
+@@ -63,7 +63,7 @@ version = "0.8.0"
+ version = "0.4.1"
+ 
+ [dependencies.picky-asn1-x509]
+-version = "0.12.0"
++version = "0.12.1"
+ 
+ [dependencies.rcgen]
+ version = "0.9.2"
+-- 
+2.47.3
+
diff --git a/meta-parsec/recipes-parsec/parsec-tool/parsec-tool-crates.inc b/meta-parsec/recipes-parsec/parsec-tool/parsec-tool-crates.inc
index 6cfd123..b040cc3 100644
--- a/meta-parsec/recipes-parsec/parsec-tool/parsec-tool-crates.inc
+++ b/meta-parsec/recipes-parsec/parsec-tool/parsec-tool-crates.inc
@@ -92,7 +92,7 @@ SRC_URI += " \
     crate://crates.io/percent-encoding/2.3.0 \
     crate://crates.io/picky-asn1/0.8.0 \
     crate://crates.io/picky-asn1-der/0.4.1 \
-    crate://crates.io/picky-asn1-x509/0.12.0 \
+    crate://crates.io/picky-asn1-x509/0.12.1 \
     crate://crates.io/pin-project-lite/0.2.13 \
     crate://crates.io/pin-utils/0.1.0 \
     crate://crates.io/pkcs8/0.8.0 \
@@ -274,7 +274,7 @@ SRC_URI[pem-1.1.1.sha256sum] = "a8835c273a76a90455d7344889b0964598e3316e2a79ede8
 SRC_URI[percent-encoding-2.3.0.sha256sum] = "9b2a4787296e9989611394c33f193f676704af1686e70b8f8033ab5ba9a35a94"
 SRC_URI[picky-asn1-0.8.0.sha256sum] = "295eea0f33c16be21e2a98b908fdd4d73c04dd48c8480991b76dbcf0cb58b212"
 SRC_URI[picky-asn1-der-0.4.1.sha256sum] = "5df7873a9e36d42dadb393bea5e211fe83d793c172afad5fb4ec846ec582793f"
-SRC_URI[picky-asn1-x509-0.12.0.sha256sum] = "2c5f20f71a68499ff32310f418a6fad8816eac1a2859ed3f0c5c741389dd6208"
+SRC_URI[picky-asn1-x509-0.12.1.sha256sum] = "afc9118855ef6387a31b86ceb6e7871cd0149309531df64efc41857b9915b3f5"
 SRC_URI[pin-project-lite-0.2.13.sha256sum] = "8afb450f006bf6385ca15ef45d71d2288452bc3683ce2e2cacc0d18e4be60b58"
 SRC_URI[pin-utils-0.1.0.sha256sum] = "8b870d8c151b6f2fb93e84a13146138f05d02ed11c7e7c54f8826aaaf7c9f184"
 SRC_URI[pkcs8-0.8.0.sha256sum] = "7cabda3fb821068a9a4fab19a683eac3af12edf0f34b94a8be53c4972b8149d0"
diff --git a/meta-parsec/recipes-parsec/parsec-tool/parsec-tool_0.7.0.bb b/meta-parsec/recipes-parsec/parsec-tool/parsec-tool_0.7.0.bb
index af0d362..432b5c0 100644
--- a/meta-parsec/recipes-parsec/parsec-tool/parsec-tool_0.7.0.bb
+++ b/meta-parsec/recipes-parsec/parsec-tool/parsec-tool_0.7.0.bb
@@ -7,6 +7,7 @@ inherit cargo cargo-update-recipe-crates
 
 SRC_URI += "\
   crate://crates.io/parsec-tool/${PV} \
+  file://0001-Update-picky-asn1-x509-version.patch \
   file://0001-parsec-cli-tests.sh-adapt-to-new-serialNumber-output.patch \
 "
 SRC_URI[parsec-tool-0.7.0.sha256sum] = "76afb4416d04c5af9f81285dfff390b09c6926aabd6b4ee20dc07470a9698732"
-- 
2.47.3

