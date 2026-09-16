Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1406C982D2
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:58:50 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26510.1789595926781635562
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GUsYLjpi;
 spf=pass (domain: konsulko.com, ip: 74.125.230.205, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939eb3249c1so12791485a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595926; x=1790200726; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vowGy4BNm6oyfzFzuMPz+8aQ16m1l758us61TKFCSYw=;
        b=GUsYLjpi34EOb9pUpzwYAxSkR0FEXwpSVFQHUXc/Sz36Km8WCZyEhsf+/HjE7w26Er
         +Vy55D6U13KF2fPF5cpfRHkx5xZ1W1/YOVBI6/LsDSxdxzjSqK/bHe64Cme+H2o8tAUl
         WimVWOc9BR7Hlg2f9SHkRyCmLoTBPBkdTSd50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595926; x=1790200726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vowGy4BNm6oyfzFzuMPz+8aQ16m1l758us61TKFCSYw=;
        b=WMiJmXMzeGIdk62UXtJo9sLiyPFPE4OVFiDbDIMNgSUIqPWYNyrTErSS5U84PEItX2
         3efFuu5hu1T+7PoC/ZYTT1EMUlok26ZNqakbSHop9i+VRN0z+B9z/+P1qzZNePa92Wxb
         Tzyv/rt5Vq1pge2vI4Ay2EXBdMQjcPVQmgSV5rt3qRUhopdnakoxtEUwBeQMPOEztPFA
         jC74UhWXT1MRoaM46G2NfNT0jtfoTnDlTZRzv8ysRBdDez5mRM4fcQQQFWZmioRR7Ddh
         r1pEImKkqBTmWPXxtpPq2ghf7rsy19t6NlE/9O0CmvKPt77yHPxGieS9ifne4m3SLE3I
         xnVw==
X-Gm-Message-State: AFuF++mFAwZth2nrzDl4RaEatFSrgPlivKvgW3ttnxpsRGUUF4cf8dMz
	D8H2DaMQ/Yb5uQEHBSYIIynAL7tBaVEJm79u17cDa/uIfRraHJgX+JN7FEfKg4hB5mtaUxzyDbw
	Nnmpn
X-Gm-Gg: AYBFou0vhzndhsKLlmWiPkWo2NfnmS9/D9OL36VVjd6s2rCDGH+NccEw5cola4nk4SZ
	XfOgpb0wrxAtgXAIJmg9Fppef58kW8z1Gd8Mr5SyRtDK3nDJ1RNJpkIi+xUlJneWLfYucwis+nV
	NUt1y+vmt561tV25M387VnxIF3lgc2nmQ4YGHIKSMxr1f3Z47cbQpOq/c4Zsgy55In0fEdJLEhN
	lcce44B62QexHhV9r8VL1JZ1OGpiDMUM7N3KLeljoiDHspXj95j8CfYrxjm6Za5HYOTfaZJ3Vau
	zDSxm6dzuCPZ5N45+zJAWK0BM9FIwF5zX0sNPqoFI656uP9s7thRONWUlZSueOvGDSAvjIhF514
	ZQc4zz5Z/DhADvca2zdB5ssxsHFBBiP3fW43dENxAV2blmXcSkuI1hobhRuWvQB6hPTlw5IZ5K2
	/f5DFabGkeHa/BmhdO+aoScvYJh2DidemiYqvqsTvlOFlKe5BDCGznBPQUwKyZwXmoA3dO2hQWV
	e6ylghUGFBrQVIEi6Ihe8fjXqRa8YRxaFuy6IYq+0mO/G4Y5q/k1e8oScvAxJHPbEpmpnE/XJD/
	CwL01QdQ8gCjvJNxDxUtyGt7ZvxmObaVSQBD
X-Received: by 2002:a05:620a:438e:b0:93a:13aa:1b6 with SMTP id af79cd13be357-93bb79aac6dmr921558685a.51.1789595922537;
        Wed, 16 Sep 2026 14:58:42 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:41 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 05/19] krill: upgrade 0.12.3 -> 0.16.0
Date: Wed, 16 Sep 2026 17:58:05 -0400
Message-ID: <494a4a0d856484524e346e3b6a345957268ea4ec.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:58:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4863

Upgrade to 0.16.0, and add a patch to refresh Cargo.lock to pick
up openssl-sys >= 0.9.114, which adds OpenSSL 4.0 support.

Release notes:
https://github.com/NLnetLabs/krill/releases/tag/v0.13.0
https://github.com/NLnetLabs/krill/releases/tag/v0.13.1
https://github.com/NLnetLabs/krill/releases/tag/v0.14.0
https://github.com/NLnetLabs/krill/releases/tag/v0.14.1
https://github.com/NLnetLabs/krill/releases/tag/v0.14.2
https://github.com/NLnetLabs/krill/releases/tag/v0.14.3
https://github.com/NLnetLabs/krill/releases/tag/v0.14.4
https://github.com/NLnetLabs/krill/releases/tag/v0.14.5
https://github.com/NLnetLabs/krill/releases/tag/v0.14.6
https://github.com/NLnetLabs/krill/releases/tag/v0.15.0
https://github.com/NLnetLabs/krill/releases/tag/v0.15.1
https://github.com/NLnetLabs/krill/releases/tag/v0.16.0

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../files/0001-Disable-abort-on-panic.patch   |   24 +
 .../0002-Update-crate-dependencies.patch      | 3177 +++++++++++++++++
 .../krill/files/panic_workaround.patch        |   16 -
 recipes-security/krill/krill-crates.inc       | 1298 ++++---
 .../{krill_0.12.3.bb => krill_0.16.0.bb}      |    9 +-
 5 files changed, 3989 insertions(+), 535 deletions(-)
 create mode 100644 recipes-security/krill/files/0001-Disable-abort-on-panic.patch
 create mode 100644 recipes-security/krill/files/0002-Update-crate-dependencies.patch
 delete mode 100644 recipes-security/krill/files/panic_workaround.patch
 rename recipes-security/krill/{krill_0.12.3.bb => krill_0.16.0.bb} (87%)

diff --git a/recipes-security/krill/files/0001-Disable-abort-on-panic.patch b/recipes-security/krill/files/0001-Disable-abort-on-panic.patch
new file mode 100644
index 0000000..34943ee
--- /dev/null
+++ b/recipes-security/krill/files/0001-Disable-abort-on-panic.patch
@@ -0,0 +1,24 @@
+From 2ab05412b6c4abf21c1eec11fb62b28068e5ea81 Mon Sep 17 00:00:00 2001
+From: Armin Kuster <akuster808@gmail.com>
+Date: Tue, 27 Jul 2021 08:06:43 -0700
+Subject: [PATCH] Disable abort on panic
+
+Upstream-Status: Inappropriate [OE specific]
+Signed-off-by: Armin Kuster <akuster808@gmail.com>
+---
+ Cargo.toml | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/Cargo.toml b/Cargo.toml
+index 8e37e968..92e6fb9a 100644
+--- a/Cargo.toml
++++ b/Cargo.toml
+@@ -107,7 +107,7 @@ urlparse  = "0.7"
+ # Make sure that Krill crashes on panics, rather than losing threads and
+ # limping on in a bad state.
+ [profile.release]
+-panic = "abort"
++#panic = "abort"
+ 
+ # ------------------------------------------------------------------------------
+ # START DEBIAN PACKAGING
diff --git a/recipes-security/krill/files/0002-Update-crate-dependencies.patch b/recipes-security/krill/files/0002-Update-crate-dependencies.patch
new file mode 100644
index 0000000..960a725
--- /dev/null
+++ b/recipes-security/krill/files/0002-Update-crate-dependencies.patch
@@ -0,0 +1,3177 @@
+From d16fb906b9a498bc8f363c6616bdf8b8386e1781 Mon Sep 17 00:00:00 2001
+From: Scott Murray <scott.murray@konsulko.com>
+Date: Sun, 13 Sep 2026 20:45:14 +0300
+Subject: [PATCH] Update crate dependencies
+
+Upstream-Status: Inappropriate [OE specific]
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ Cargo.lock | 1508 +++++++++++++++++++++++-----------------------------
+ 1 file changed, 670 insertions(+), 838 deletions(-)
+
+diff --git a/Cargo.lock b/Cargo.lock
+index 440bb548..3561da01 100644
+--- a/Cargo.lock
++++ b/Cargo.lock
+@@ -10,9 +10,9 @@ checksum = "aae1277d39aeec15cb388266ecc24b11c80469deae6067e17a1a7aa9e5c1f234"
+ 
+ [[package]]
+ name = "aho-corasick"
+-version = "1.1.4"
++version = "1.1.5"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "ddd31a130427c27518df266943a5308ed92d4b226cc639f5a8f1002816174301"
++checksum = "c982642fa9e8606056828ee9a8505737230110bb1099153c79efe865c59d12ba"
+ dependencies = [
+  "memchr",
+ ]
+@@ -25,18 +25,18 @@ checksum = "683d7910e743518b0e34f1186f92494becacb047c7b6bf616c96772180fef923"
+ 
+ [[package]]
+ name = "android_system_properties"
+-version = "0.1.5"
++version = "0.1.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
++checksum = "ae221649c9976a6f6c56ae1facf410f3ddb33cc661c4b7b61020a912d4237fbc"
+ dependencies = [
+  "libc",
+ ]
+ 
+ [[package]]
+ name = "anstream"
+-version = "0.6.21"
++version = "1.0.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "43d5b281e737544384e969a5ccad3f1cdd24b48086a0fc1b2a5262a26b8f4f4a"
++checksum = "824a212faf96e9acacdbd09febd34438f8f711fb84e09a8916013cd7815ca28d"
+ dependencies = [
+  "anstyle",
+  "anstyle-parse",
+@@ -49,15 +49,15 @@ dependencies = [
+ 
+ [[package]]
+ name = "anstyle"
+-version = "1.0.13"
++version = "1.0.14"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "5192cca8006f1fd4f7237516f40fa183bb07f8fbdfedaa0036de5ea9b0b45e78"
++checksum = "940b3a0ca603d1eade50a4846a2afffd5ef57a9feac2c0e2ec2e14f9ead76000"
+ 
+ [[package]]
+ name = "anstyle-parse"
+-version = "0.2.7"
++version = "1.0.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "4e7644824f0aa2c7b9384579234ef10eb7efb6a0deb83f9630a49594dd9c15c2"
++checksum = "52ce7f38b242319f7cabaa6813055467063ecdc9d355bbb4ce0c68908cd8130e"
+ dependencies = [
+  "utf8parse",
+ ]
+@@ -82,17 +82,11 @@ dependencies = [
+  "windows-sys 0.61.2",
+ ]
+ 
+-[[package]]
+-name = "anyhow"
+-version = "1.0.101"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "5f0e0fee31ef5ed1ba1316088939cea399010ed7731dba877ed44aeb407a75ea"
+-
+ [[package]]
+ name = "arc-swap"
+-version = "1.8.2"
++version = "1.9.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "f9f3647c145568cec02c42054e07bdf9a5a698e15b466fb2341bfc393cd24aa5"
++checksum = "c049c0be4daef0b145cb3555416b3b8ef5b7888a38aea1a3a155801fe7b0810b"
+ dependencies = [
+  "rustversion",
+ ]
+@@ -114,15 +108,15 @@ checksum = "1505bd5d3d116872e7271a6d4e16d81d0c8570876c8de68093a09ac269d8aac0"
+ 
+ [[package]]
+ name = "autocfg"
+-version = "1.5.0"
++version = "1.5.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "c08606f8c3cbf4ce6ec8e28fb0014a2c086708fe954eaa885384a6165172e7e8"
++checksum = "f2032f911046de80f0a198e0901378627c33f59ea0ac00e363d481118bd70a53"
+ 
+ [[package]]
+ name = "aws-lc-rs"
+-version = "1.15.4"
++version = "1.18.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "7b7b6141e96a8c160799cc2d5adecd5cbbe5054cb8c7c4af53da0f83bb7ad256"
++checksum = "b281d307588d634de920874890732659e2e7672f72b5e10e81badc1a8a83621e"
+ dependencies = [
+  "aws-lc-sys",
+  "zeroize",
+@@ -130,14 +124,15 @@ dependencies = [
+ 
+ [[package]]
+ name = "aws-lc-sys"
+-version = "0.37.1"
++version = "0.45.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b092fe214090261288111db7a2b2c2118e5a7f30dc2569f1732c4069a6840549"
++checksum = "9bff6c3b54fad79a2e60b8102caf565819711497c1f5f092f49508e2f5c31b27"
+ dependencies = [
+  "cc",
+  "cmake",
+  "dunce",
+  "fs_extra",
++ "pkg-config",
+ ]
+ 
+ [[package]]
+@@ -148,7 +143,7 @@ checksum = "b62ddb9cb1ec0a098ad4bbf9344d0713fa193ae1a80af55febcff2627b6a00c1"
+ dependencies = [
+  "getrandom 0.2.17",
+  "instant",
+- "rand 0.8.5",
++ "rand 0.8.8",
+ ]
+ 
+ [[package]]
+@@ -169,6 +164,12 @@ version = "0.22.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
+ 
++[[package]]
++name = "base64"
++version = "0.23.1"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "ac07cdecf99051d9a5238b80f35af32cdeba5b336e55d957b318b50137e18da5"
++
+ [[package]]
+ name = "base64ct"
+ version = "1.8.3"
+@@ -188,9 +189,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "bcder"
+-version = "0.7.6"
++version = "0.7.7"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "1f7c42c9913f68cf9390a225e81ad56a5c515347287eb98baa710090ca1de86d"
++checksum = "b593e5aeaf7992d388c08a9831c921cd703718064b3e50ba8e6d666d6cf86ca7"
+ dependencies = [
+  "bytes",
+  "smallvec",
+@@ -213,9 +214,15 @@ checksum = "349f9b6a179ed607305526ca489b34ad0a41aed5f7980fa90eb03160b69598fb"
+ 
+ [[package]]
+ name = "bitflags"
+-version = "2.11.0"
++version = "1.3.2"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
++
++[[package]]
++name = "bitflags"
++version = "2.13.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "843867be96c8daad0d758b57df9392b6d8d271134fce549de6ce169ff98a92af"
++checksum = "3ded4057c258ba199e2d26386d3af3780957ecaee6c4ef4041c6b4b8b97c0b06"
+ 
+ [[package]]
+ name = "block-buffer"
+@@ -226,23 +233,32 @@ dependencies = [
+  "generic-array",
+ ]
+ 
++[[package]]
++name = "bs58"
++version = "0.5.1"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "bf88ba1141d185c399bee5288d850d63b8369520c1eafc32a0430b5b6c287bf4"
++dependencies = [
++ "tinyvec",
++]
++
+ [[package]]
+ name = "bumpalo"
+-version = "3.19.1"
++version = "3.20.3"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "5dd9dc738b7a8311c7ade152424974d8115f2cdad61e8dab8dac9f2362298510"
++checksum = "72f5acc6cb2ba439de613abc23857ec3d78374d8ed5ac84e9d11336e87da8649"
+ 
+ [[package]]
+ name = "bytes"
+-version = "1.11.1"
++version = "1.12.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "1e748733b7cbc798e1434b6ac524f0c1ff2ab456fe201501e6497c8417a4fc33"
++checksum = "fc652a48c352aef3ea3aed32080501cf3ef6ed5da78602a020c991775b0aff04"
+ 
+ [[package]]
+ name = "cc"
+-version = "1.2.56"
++version = "1.4.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "aebf35691d1bfb0ac386a69bac2fde4dd276fb618cf8bf4f5318fe285e821bb2"
++checksum = "a3eb0f42d6c360dc3f8a821f6bf2fdea7f72bfd36b3076eb0e6d1e9e0752fff4"
+ dependencies = [
+  "find-msvc-tools",
+  "jobserver",
+@@ -250,12 +266,6 @@ dependencies = [
+  "shlex",
+ ]
+ 
+-[[package]]
+-name = "cesu8"
+-version = "1.1.0"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "6d43a04d8753f35258c91f8ec639f792891f748a1edbd759cf1dcea3382ad83c"
+-
+ [[package]]
+ name = "cfg-if"
+ version = "1.0.4"
+@@ -264,26 +274,26 @@ checksum = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
+ 
+ [[package]]
+ name = "cfg_aliases"
+-version = "0.2.1"
++version = "0.2.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "613afe47fcd5fac7ccf1db93babcb082c5994d996f20b8b159f2ad1658eb5724"
++checksum = "f079e83a288787bcd14a6aea84cee5c87a67c5a3e660c30f557a3d24761b3527"
+ 
+ [[package]]
+ name = "chacha20"
+-version = "0.10.0"
++version = "0.10.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "6f8d983286843e49675a4b7a2d174efe136dc93a18d69130dd18198a6c167601"
++checksum = "65c35e4b699c7e15ccbe7ee35c005e4fc0a278d22238a2857e6ce2dadeda1b06"
+ dependencies = [
+  "cfg-if",
+- "cpufeatures 0.3.0",
+- "rand_core 0.10.0",
++ "cpufeatures 0.3.1",
++ "rand_core 0.10.1",
+ ]
+ 
+ [[package]]
+ name = "chrono"
+-version = "0.4.43"
++version = "0.4.45"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "fac4744fb15ae8337dc853fee7fb3f4e48c0fbaa23d0afe49c447b4fab126118"
++checksum = "1aa79e62e7697b8e29b513a68abacf485adcd1fe8284a4316c5ae868e6633327"
+ dependencies = [
+  "iana-time-zone",
+  "js-sys",
+@@ -305,9 +315,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "clap"
+-version = "4.5.59"
++version = "4.6.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "c5caf74d17c3aec5495110c34cc3f78644bfa89af6c8993ed4de2790e49b6499"
++checksum = "473c7e07f409a8d772161724aa8db6a765a2532a70f9667eeb7b49d3d02fbdca"
+ dependencies = [
+  "clap_builder",
+  "clap_derive",
+@@ -315,9 +325,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "clap_builder"
+-version = "4.5.59"
++version = "4.6.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "370daa45065b80218950227371916a1633217ae42b2715b2287b606dcd618e24"
++checksum = "7b48fea5a88e9ae728a2dcbedbfc0e730f7d60da42e1cb049a83c9fb8b789889"
+ dependencies = [
+  "anstream",
+  "anstyle",
+@@ -328,42 +338,42 @@ dependencies = [
+ 
+ [[package]]
+ name = "clap_derive"
+-version = "4.5.55"
++version = "4.6.4"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "a92793da1a46a5f2a02a6f4c46c6496b28c43638adea8306fcb0caa1634f24e5"
++checksum = "d012d2b9d65aca7f18f4d9878a045bc17899bba951561ba5ec3c2ba1eed9a061"
+ dependencies = [
+  "heck",
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 3.0.5",
+ ]
+ 
+ [[package]]
+ name = "clap_lex"
+-version = "1.0.0"
++version = "1.1.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "3a822ea5bc7590f9d40f1ba12c0dc3c2760f3482c6984db1573ad11031420831"
++checksum = "c8d4a3bb8b1e0c1050499d1815f5ab16d04f0959b233085fb31653fbfc9d98f9"
+ 
+ [[package]]
+ name = "cmake"
+-version = "0.1.57"
++version = "0.1.58"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "75443c44cd6b379beb8c5b45d85d0773baf31cce901fe7bb252f4eff3008ef7d"
++checksum = "c0f78a02292a74a88ac736019ab962ece0bc380e3f977bf72e376c5d78ff0678"
+ dependencies = [
+  "cc",
+ ]
+ 
+ [[package]]
+ name = "colorchoice"
+-version = "1.0.4"
++version = "1.0.5"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b05b61dc5112cbb17e4b6cd61790d9845d13888356391624cbe7e41efeac1e75"
++checksum = "1d07550c9036bf2ae0c684c4297d503f838287c83c53686d05370d0e139ae570"
+ 
+ [[package]]
+ name = "combine"
+-version = "4.6.7"
++version = "4.6.8"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "ba5a308b75df32fe02788e748662718f03fde005016435c444eea572398219fd"
++checksum = "cfc320937d09e6de266b31b9afb480f197d7a861be86be7cb2ea7e5d1bfffc5e"
+ dependencies = [
+  "bytes",
+  "memchr",
+@@ -402,13 +412,10 @@ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
+ 
+ [[package]]
+-name = "core2"
+-version = "0.4.0"
++name = "core_detect"
++version = "1.0.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b49ba7ef1ad6107f8824dbe97de947cbaac53c44e7f9756a1fba0d37c1eec505"
+-dependencies = [
+- "memchr",
+-]
++checksum = "7f8f80099a98041a3d1622845c271458a2d73e688351bf3cb999266764b81d48"
+ 
+ [[package]]
+ name = "cpufeatures"
+@@ -421,18 +428,18 @@ dependencies = [
+ 
+ [[package]]
+ name = "cpufeatures"
+-version = "0.3.0"
++version = "0.3.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "8b2a41393f66f16b0823bb79094d54ac5fbd34ab292ddafb9a0456ac9f87d201"
++checksum = "5ca28b0ae3115b884660db4118d803791fd6756b6e88f39c0f3f7859060d7566"
+ dependencies = [
+  "libc",
+ ]
+ 
+ [[package]]
+ name = "crc32fast"
+-version = "1.5.0"
++version = "1.5.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "9481c1c90cbf2ac953f07c8d4a58aa3945c425b7185c9154d67a65e4230da511"
++checksum = "01a7799fd6b852db0e61728dde9a204c423b44d689dbd432522543614b490e78"
+ dependencies = [
+  "cfg-if",
+ ]
+@@ -471,7 +478,7 @@ version = "0.12.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "ff765b99fc49f3116c9a908484486a2b92fd73c48da45c3a69716471c6cc56c6"
+ dependencies = [
+- "bitflags",
++ "bitflags 2.13.2",
+  "cryptoki-sys",
+  "libloading",
+  "log",
+@@ -511,14 +518,14 @@ checksum = "f46882e17999c6cc590af592290432be3bce0428cb0d5f8b6715e4dc7b383eb3"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 2.0.119",
+ ]
+ 
+ [[package]]
+ name = "darling"
+-version = "0.21.3"
++version = "0.24.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "9cdf337090841a411e2a7f3deb9187445851f91b309c0c0a29e05f74a00a48c0"
++checksum = "ed17f5901b6630b993ca003def43f2f8ef4014fc13b047b57aad617ff32bc2ec"
+ dependencies = [
+  "darling_core",
+  "darling_macro",
+@@ -526,34 +533,64 @@ dependencies = [
+ 
+ [[package]]
+ name = "darling_core"
+-version = "0.21.3"
++version = "0.24.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "1247195ecd7e3c85f83c8d2a366e4210d588e802133e1e355180a9870b517ea4"
++checksum = "6837e2cf7485aaae18f86181d2f0e9a7ed297a025e220aeabf63fdebd3a2ddff"
+ dependencies = [
+- "fnv",
+  "ident_case",
+  "proc-macro2",
+  "quote",
+  "strsim",
+- "syn 2.0.116",
++ "syn 3.0.5",
+ ]
+ 
+ [[package]]
+ name = "darling_macro"
+-version = "0.21.3"
++version = "0.24.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "d38308df82d1080de0afee5d069fa14b0326a88c14f15c5ccda35b4a6c414c81"
++checksum = "2ac7135c3ef02b2f7833bbeb1be5ba7f966dcde8a87c6b87f65a778d71a02785"
+ dependencies = [
+  "darling_core",
+  "quote",
+- "syn 2.0.116",
++ "syn 3.0.5",
+ ]
+ 
+ [[package]]
+ name = "dary_heap"
+-version = "0.3.8"
++version = "0.3.9"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "8b1e3a325bc115f096c8b77bbf027a7c2592230e70be2d985be950d3d5e60ebe"
++
++[[package]]
++name = "defmt"
++version = "1.1.1"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "e2953bfe4f93bbd20cc71198842756f77d161884c99ebbabc41d80231ded88d1"
++dependencies = [
++ "bitflags 1.3.2",
++ "defmt-macros",
++]
++
++[[package]]
++name = "defmt-macros"
++version = "1.1.1"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "bad9c72e7ca2137e0dc3813245a0d282fd6daad32fd800af018306a9169b5fe8"
++dependencies = [
++ "defmt-parser",
++ "proc-macro2",
++ "quote",
++ "syn 2.0.119",
++]
++
++[[package]]
++name = "defmt-parser"
++version = "1.0.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "06d2e3287df1c007e74221c49ca10a95d557349e54b3a75dc2fb14712c751f04"
++checksum = "10d60334b3b2e7c9d91ef8150abfb6fa4c1c39ebbcf4a81c2e346aad939fee3e"
++dependencies = [
++ "thiserror 2.0.20",
++]
+ 
+ [[package]]
+ name = "der"
+@@ -568,11 +605,10 @@ dependencies = [
+ 
+ [[package]]
+ name = "deranged"
+-version = "0.5.6"
++version = "0.5.8"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "cc3dc5ad92c2e2d1c193bbbbdf2ea477cb81331de4f3103f267ca18368b988c4"
++checksum = "7cd812cc2bc1d69d4764bd80df88b4317eaef9e773c75226407d9bc0876b211c"
+ dependencies = [
+- "powerfmt",
+  "serde_core",
+ ]
+ 
+@@ -611,13 +647,13 @@ dependencies = [
+ 
+ [[package]]
+ name = "displaydoc"
+-version = "0.2.5"
++version = "0.2.7"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "97369cbbc041bc366949bc74d34658d6cda5621039731c6310521892a3a20ae0"
++checksum = "c6232dd377dcc64799954cbd3a9bb882e9cdc1308ccd87b1c098f1fb2eaf82a8"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 3.0.5",
+ ]
+ 
+ [[package]]
+@@ -672,9 +708,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "either"
+-version = "1.15.0"
++version = "1.18.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "48c757948c5ede0e46177b7add2e67155f70e33c07fea8284df6576da70b3719"
++checksum = "252afb9ae5eaa683babdc6a068b3f5726eb19e05070c731f9b2a23a7c3e8ed34"
+ 
+ [[package]]
+ name = "elliptic-curve"
+@@ -708,11 +744,17 @@ dependencies = [
+ 
+ [[package]]
+ name = "encoding_rs"
+-version = "0.8.35"
++version = "0.8.41"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "75030f3c4f45dafd7586dd6780965a8c7e8e285a5ecb86713e63a79c5b2766f3"
++checksum = "7b5ef0006ac9ab233c38522f5ae99cae3625151de8f706cacee1cba4b8e2832a"
+ dependencies = [
+  "cfg-if",
++ "core_detect",
++ "multiversion",
++ "multiversion_no_op",
++ "rustversion",
++ "scopeguard",
++ "simdutf8",
+ ]
+ 
+ [[package]]
+@@ -755,9 +797,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "fastrand"
+-version = "2.3.0"
++version = "2.5.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "37909eebbb50d72f9059c3b6d82c0463f2ff062c9e95845c43a6c9c0355411be"
++checksum = "da7c62ceae207dd37ea5b845da6a0696c799f85e97da1ab5b7910be3c1c80223"
+ 
+ [[package]]
+ name = "fd-lock"
+@@ -798,20 +840,19 @@ checksum = "28dea519a9695b9977216879a3ebfddf92f1c08c05d984f8996aecd6ecdc811d"
+ 
+ [[package]]
+ name = "filetime"
+-version = "0.2.27"
++version = "0.2.29"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "f98844151eee8917efc50bd9e8318cb963ae8b297431495d3f758616ea5c57db"
++checksum = "5c287a33c7f0a620c38e641e7f60827713987b3c0f26e8ddc9462cc69cf75759"
+ dependencies = [
+  "cfg-if",
+  "libc",
+- "libredox",
+ ]
+ 
+ [[package]]
+ name = "find-msvc-tools"
+-version = "0.1.9"
++version = "0.1.12"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "5baebc0774151f905a1a2cc41989300b1e6fbb29aff0ceffa1064fdd3088d582"
++checksum = "3e0f1c7c3a72c66fd80abe965175f7523475c0489a87d3ff9d6e8c87d87a9d2d"
+ 
+ [[package]]
+ name = "fixedbitset"
+@@ -825,12 +866,6 @@ version = "1.0.7"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
+ 
+-[[package]]
+-name = "foldhash"
+-version = "0.1.5"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "d9c4f5dac5e15c24eb999c26181a6ca40b39fe946cbe4c263c7209467bc83af2"
+-
+ [[package]]
+ name = "foldhash"
+ version = "0.2.0"
+@@ -869,47 +904,47 @@ checksum = "42703706b716c37f96a77aea830392ad231f44c9e9a67872fa5548707e11b11c"
+ 
+ [[package]]
+ name = "futures-channel"
+-version = "0.3.32"
++version = "0.3.34"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "07bbe89c50d7a535e539b8c17bc0b49bdb77747034daa8087407d655f3f7cc1d"
++checksum = "b1f9e3d69d39e4862ffed03ed071a76f9a13ba1d9109d355b0f0aa6b15e393c4"
+ dependencies = [
+  "futures-core",
+ ]
+ 
+ [[package]]
+ name = "futures-core"
+-version = "0.3.32"
++version = "0.3.34"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "7e3450815272ef58cec6d564423f6e755e25379b217b0bc688e295ba24df6b1d"
++checksum = "92d699e522242e69e3003b94ecc1f960f3a5e015aa7c5d7486e65ad01dd94f5e"
+ 
+ [[package]]
+ name = "futures-macro"
+-version = "0.3.32"
++version = "0.3.34"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "e835b70203e41293343137df5c0664546da5745f82ec9b84d40be8336958447b"
++checksum = "9fb9654ba8355388abeb8dcb4fc62f511300867002afc858860463bdd9fe0c44"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 3.0.5",
+ ]
+ 
+ [[package]]
+ name = "futures-sink"
+-version = "0.3.32"
++version = "0.3.34"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "c39754e157331b013978ec91992bde1ac089843443c49cbc7f46150b0fad0893"
++checksum = "1944426bf7d03f1d14f708785e4b33efd750b36d48a157b836b3efc15ede8e1d"
+ 
+ [[package]]
+ name = "futures-task"
+-version = "0.3.32"
++version = "0.3.34"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "037711b3d59c33004d3856fbdc83b99d4ff37a24768fa1be9ce3538a1cde4393"
++checksum = "cd417de3d1d015fc3bfd2b1ea46dfc7bab72ef86f1cc7cc9c78e728b34a6d1fd"
+ 
+ [[package]]
+ name = "futures-util"
+-version = "0.3.32"
++version = "0.3.34"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "389ca41296e6190b48053de0321d02a77f32f8a5d2461dd38762c0593805c6d6"
++checksum = "0d50a92467f8ba5dd6e3ee5d4bd04d73ab2e4e1c44474a0674821dfce14b79bc"
+ dependencies = [
+  "futures-core",
+  "futures-macro",
+@@ -944,32 +979,18 @@ dependencies = [
+ 
+ [[package]]
+ name = "getrandom"
+-version = "0.3.4"
++version = "0.4.3"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "899def5c37c4fd7b2664648c28120ecec138e4d395b459e5ca34f9cce2dd77fd"
++checksum = "300e883d756b2e4ec94e02791f39b04b522276138852cfc41d9fb7e904106099"
+ dependencies = [
+  "cfg-if",
+  "js-sys",
+  "libc",
+  "r-efi",
+- "wasip2",
++ "rand_core 0.10.1",
+  "wasm-bindgen",
+ ]
+ 
+-[[package]]
+-name = "getrandom"
+-version = "0.4.1"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "139ef39800118c7683f2fd3c98c1b23c09ae076556b435f8e9064ae108aaeeec"
+-dependencies = [
+- "cfg-if",
+- "libc",
+- "r-efi",
+- "rand_core 0.10.0",
+- "wasip2",
+- "wasip3",
+-]
+-
+ [[package]]
+ name = "group"
+ version = "0.13.0"
+@@ -983,9 +1004,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "h2"
+-version = "0.4.13"
++version = "0.4.19"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "2f44da3a8150a6703ed5d34e164b875fd14c2cdab9af1252a9a1020bde2bdc54"
++checksum = "ef8e5e5a340588f4452631496976cf8636d4a7ecf600239fdc27615d2530bc16"
+ dependencies = [
+  "atomic-waker",
+  "bytes",
+@@ -993,7 +1014,7 @@ dependencies = [
+  "futures-core",
+  "futures-sink",
+  "http",
+- "indexmap 2.13.0",
++ "indexmap 2.14.2",
+  "slab",
+  "tokio",
+  "tokio-util",
+@@ -1006,15 +1027,6 @@ version = "0.12.3"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
+ 
+-[[package]]
+-name = "hashbrown"
+-version = "0.15.5"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "9229cfe53dfd69f0609a49f65461bd93001ea1ef889cd5529dd176593f5338a1"
+-dependencies = [
+- "foldhash 0.1.5",
+-]
+-
+ [[package]]
+ name = "hashbrown"
+ version = "0.16.1"
+@@ -1023,9 +1035,15 @@ checksum = "841d1cc9bed7f9236f321df977030373f4a4163ae1a7dbfe1a51a2c1a51d9100"
+ dependencies = [
+  "allocator-api2",
+  "equivalent",
+- "foldhash 0.2.0",
++ "foldhash",
+ ]
+ 
++[[package]]
++name = "hashbrown"
++version = "0.17.1"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "ed5909b6e89a2db4456e54cd5f673791d7eca6732202bbf2a9cc504fe2f9b84a"
++
+ [[package]]
+ name = "heck"
+ version = "0.5.0"
+@@ -1034,9 +1052,9 @@ checksum = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
+ 
+ [[package]]
+ name = "hermit-abi"
+-version = "0.5.2"
++version = "0.5.3"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "fc0fef456e4baa96da950455cd02c081ca953b141298e41db3fc7e36b1da849c"
++checksum = "e17592d60ebacc7d5e169f4663c5f84f9161cc90328abcfe8456f41e4dfcb284"
+ 
+ [[package]]
+ name = "hex"
+@@ -1075,9 +1093,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "http"
+-version = "1.4.0"
++version = "1.5.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "e3ba2a386d7f85a81f119ad7498ebe444d2e22c2af0b86b069416ace48b3311a"
++checksum = "918d3568bebf352712bc2ef3d46a8bcf1a75b373be6539de198e9105cbbf9ce0"
+ dependencies = [
+  "bytes",
+  "itoa",
+@@ -1085,9 +1103,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "http-body"
+-version = "1.0.1"
++version = "1.1.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "1efedce1fb8e6913f23e0c92de8e62cd5b772a67e7b3946df930a62566c93184"
++checksum = "ca2a8f2913ee65f60facd6a5905613afaa448497a0230cc41ce022d93290bc2c"
+ dependencies = [
+  "bytes",
+  "http",
+@@ -1095,9 +1113,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "http-body-util"
+-version = "0.1.3"
++version = "0.1.5"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b021d93e26becf5dc7e1b75b1bed1fd93124b374ceb73f43d4d4eafec896a64a"
++checksum = "23169fe34a5fbcdd3f3862e78fb9b6fccd5f02a6dc6f732547005d45631ce71c"
+ dependencies = [
+  "bytes",
+  "futures-core",
+@@ -1120,9 +1138,9 @@ checksum = "df3b46402a9d5adb4c86a0cf463f42e19994e3ee891101b1841f30a545cb49a9"
+ 
+ [[package]]
+ name = "hyper"
+-version = "1.8.1"
++version = "1.11.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "2ab2d4f250c3d7b1c9fcdff1cece94ea4e2dfbec68614f7b87cb205f24ca9d11"
++checksum = "27b501faa50e7a26c3d3560ca625132f4078a17771f4810baf70475ae48cbe43"
+ dependencies = [
+  "atomic-waker",
+  "bytes",
+@@ -1135,7 +1153,6 @@ dependencies = [
+  "httpdate",
+  "itoa",
+  "pin-project-lite",
+- "pin-utils",
+  "smallvec",
+  "tokio",
+  "want",
+@@ -1143,15 +1160,14 @@ dependencies = [
+ 
+ [[package]]
+ name = "hyper-rustls"
+-version = "0.27.7"
++version = "0.27.9"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "e3c93eb611681b207e1fe55d5a71ecf91572ec8a6705cdb6857f7d8d5242cf58"
++checksum = "33ca68d021ef39cf6463ab54c1d0f5daf03377b70561305bb89a8f83aab66e0f"
+ dependencies = [
+  "http",
+  "hyper",
+  "hyper-util",
+  "rustls",
+- "rustls-pki-types",
+  "tokio",
+  "tokio-rustls",
+  "tower-service",
+@@ -1208,12 +1224,13 @@ dependencies = [
+ 
+ [[package]]
+ name = "icu_collections"
+-version = "2.1.1"
++version = "2.3.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "4c6b649701667bbe825c3b7e6388cb521c23d88644678e83c0c4d0a621a34b43"
++checksum = "fa68d21081c4a05d5a901a1c62add574c77048b6a1c67be3b50ce0b60d4ca513"
+ dependencies = [
+  "displaydoc",
+  "potential_utf",
++ "utf8_iter",
+  "yoke",
+  "zerofrom",
+  "zerovec",
+@@ -1221,9 +1238,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "icu_locale_core"
+-version = "2.1.1"
++version = "2.3.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "edba7861004dd3714265b4db54a3c390e880ab658fec5f7db895fae2046b5bb6"
++checksum = "d56e28588da92eee5c3201a6eff33fabdd49b62269c8938d4ff050ce4d900deb"
+ dependencies = [
+  "displaydoc",
+  "litemap",
+@@ -1234,9 +1251,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "icu_normalizer"
+-version = "2.1.1"
++version = "2.3.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "5f6c8828b67bf8908d82127b2054ea1b4427ff0230ee9141c54251934ab1b599"
++checksum = "12f9cf5f235641ed274641dd81c3f28d870e276763d0797aeeab72317b1c646f"
+ dependencies = [
+  "icu_collections",
+  "icu_normalizer_data",
+@@ -1248,16 +1265,17 @@ dependencies = [
+ 
+ [[package]]
+ name = "icu_normalizer_data"
+-version = "2.1.1"
++version = "2.3.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "7aedcccd01fc5fe81e6b489c15b247b8b0690feb23304303a9e560f37efc560a"
++checksum = "1563da1ed3e0b3bf3d74c9b85917ac9c56464d2f57242270c09c9e752f8021a0"
+ 
+ [[package]]
+ name = "icu_properties"
+-version = "2.1.2"
++version = "2.3.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "020bfc02fe870ec3a66d93e677ccca0562506e5872c650f893269e08615d74ec"
++checksum = "7e7ca276ad3145661a65914e6daf131ca5120cd3dcee8f8f3214b8875184a148"
+ dependencies = [
++ "displaydoc",
+  "icu_collections",
+  "icu_locale_core",
+  "icu_properties_data",
+@@ -1268,15 +1286,15 @@ dependencies = [
+ 
+ [[package]]
+ name = "icu_properties_data"
+-version = "2.1.2"
++version = "2.3.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "616c294cf8d725c6afcd8f55abc17c56464ef6211f9ed59cccffe534129c77af"
++checksum = "e590f038c1464a96894fd6d10127e90a8be4509f56ff7ecef851b15cee0b7caa"
+ 
+ [[package]]
+ name = "icu_provider"
+-version = "2.1.1"
++version = "2.3.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "85962cf0ce02e1e0a629cc34e7ca3e373ce20dda4c4d7294bbd0bf1fdb59e614"
++checksum = "d27bbb9d3abbefac45d55f647c9de1d44aafcd1186eb91879afef17c396c3e73"
+ dependencies = [
+  "displaydoc",
+  "icu_locale_core",
+@@ -1287,12 +1305,6 @@ dependencies = [
+  "zerovec",
+ ]
+ 
+-[[package]]
+-name = "id-arena"
+-version = "2.3.0"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "3d3067d79b975e8844ca9eb072e16b31c3c1c36928edf9c6789548c524d0d954"
+-
+ [[package]]
+ name = "ident_case"
+ version = "1.0.1"
+@@ -1312,9 +1324,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "idna_adapter"
+-version = "1.2.1"
++version = "1.2.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "3acae9609540aa318d1bc588455225fb2085b9ed0c4f6bd0d9d5bcd86f1a0344"
++checksum = "cb68373c0d6620ef8105e855e7745e18b0d00d3bdb07fb532e434244cdb9a714"
+ dependencies = [
+  "icu_normalizer",
+  "icu_properties",
+@@ -1333,12 +1345,12 @@ dependencies = [
+ 
+ [[package]]
+ name = "indexmap"
+-version = "2.13.0"
++version = "2.14.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "7714e70437a7dc3ac8eb7e6f8df75fd8eb422675fc7678aff7364301092b1017"
++checksum = "cc4e190f5d26ca7051642629da2c52fc03bde85a03197c99408dcd291734c855"
+ dependencies = [
+  "equivalent",
+- "hashbrown 0.16.1",
++ "hashbrown 0.17.1",
+  "serde",
+  "serde_core",
+ ]
+@@ -1372,19 +1384,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "ipnet"
+-version = "2.11.0"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "469fb0b9cefa57e3ef31275ee7cacb78f2fdca44e4765491884a2b119d4eb130"
+-
+-[[package]]
+-name = "iri-string"
+-version = "0.7.10"
++version = "2.12.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "c91338f0783edbd6195decb37bae672fd3b165faffb89bf7b9e6942f8b1a731a"
+-dependencies = [
+- "memchr",
+- "serde",
+-]
++checksum = "791930b43c0d5973160d90a8f3894509f2b273430f5c5c73b668636d0287c5c0"
+ 
+ [[package]]
+ name = "is-terminal"
+@@ -1423,49 +1425,131 @@ dependencies = [
+ 
+ [[package]]
+ name = "itoa"
+-version = "1.0.17"
++version = "1.0.18"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682"
++
++[[package]]
++name = "jiff"
++version = "0.2.37"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "0ab1baf72f08796de0260609515130699b890ac25f30e610ad894bc5856cafdb"
++dependencies = [
++ "defmt",
++ "jiff-core",
++ "jiff-static",
++ "jiff-tzdb-platform",
++ "log",
++ "portable-atomic",
++ "portable-atomic-util",
++ "serde_core",
++ "windows-link",
++]
++
++[[package]]
++name = "jiff-core"
++version = "0.1.1"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "5e52fe76043ccecc9005d2305ebaadf7d7fc0cc89ca6baa10a94d6bc68c7128c"
++dependencies = [
++ "defmt",
++ "log",
++]
++
++[[package]]
++name = "jiff-static"
++version = "0.2.37"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "378268a1116ad67ae6228701118ac9f491d78fda38a40a1f1a9e1348de6f7212"
++dependencies = [
++ "jiff-core",
++ "proc-macro2",
++ "quote",
++ "syn 2.0.119",
++]
++
++[[package]]
++name = "jiff-tzdb"
++version = "0.1.8"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "142bd39932ad231f10513df9ab62661fead8719872150b7ad02a2df79f4e141e"
++
++[[package]]
++name = "jiff-tzdb-platform"
++version = "0.1.3"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "92ecc6618181def0457392ccd0ee51198e065e016d1d527a7ac1b6dc7c1f09d2"
++checksum = "875a5a69ac2bab1a891711cf5eccbec1ce0341ea805560dcd90b7a2e925132e8"
++dependencies = [
++ "jiff-tzdb",
++]
+ 
+ [[package]]
+ name = "jni"
+-version = "0.21.1"
++version = "0.22.4"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "1a87aa2bb7d2af34197c04845522473242e1aa17c12f4935d5856491a7fb8c97"
++checksum = "5efd9a482cf3a427f00d6b35f14332adc7902ce91efb778580e180ff90fa3498"
+ dependencies = [
+- "cesu8",
+  "cfg-if",
+  "combine",
++ "jni-macros",
+  "jni-sys",
+  "log",
+- "thiserror 1.0.69",
++ "simd_cesu8",
++ "thiserror 2.0.20",
+  "walkdir",
+- "windows-sys 0.45.0",
++ "windows-link",
++]
++
++[[package]]
++name = "jni-macros"
++version = "0.22.4"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "a00109accc170f0bdb141fed3e393c565b6f5e072365c3bd58f5b062591560a3"
++dependencies = [
++ "proc-macro2",
++ "quote",
++ "rustc_version",
++ "simd_cesu8",
++ "syn 2.0.119",
+ ]
+ 
+ [[package]]
+ name = "jni-sys"
+-version = "0.3.0"
++version = "0.4.1"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "c6377a88cb3910bee9b0fa88d4f42e1d2da8e79915598f65fb0c7ee14c878af2"
++dependencies = [
++ "jni-sys-macros",
++]
++
++[[package]]
++name = "jni-sys-macros"
++version = "0.4.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "8eaf4bc02d17cbdd7ff4c7438cafcdf7fb9a4613313ad11b4f8fefe7d3fa0130"
++checksum = "38c0b942f458fe50cdac086d2f946512305e5631e720728f2a61aabcd47a6264"
++dependencies = [
++ "quote",
++ "syn 2.0.119",
++]
+ 
+ [[package]]
+ name = "jobserver"
+-version = "0.1.34"
++version = "0.1.35"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "9afb3de4395d6b3e67a780b6de64b51c978ecf11cb9a462c66be7d4ca9039d33"
++checksum = "1c00acbd29eabad4a2392fa0e921c874934dbbf4194312ad20f04a0ed67a3cb3"
+ dependencies = [
+- "getrandom 0.3.4",
++ "getrandom 0.4.3",
+  "libc",
+ ]
+ 
+ [[package]]
+ name = "js-sys"
+-version = "0.3.85"
++version = "0.3.105"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "8c942ebf8e95485ca0d52d97da7c5a2c387d0e7f0ba4c35e93bfcaee045955b3"
++checksum = "ce57d20d1ea864ce2ac172ab472d409214f4fd359f0b2a2775abdf522e2af99e"
+ dependencies = [
+- "once_cell",
++ "cfg-if",
++ "futures-util",
+  "wasm-bindgen",
+ ]
+ 
+@@ -1533,7 +1617,7 @@ dependencies = [
+  "percent-encoding",
+  "pin-project-lite",
+  "r2d2",
+- "rand 0.10.0",
++ "rand 0.10.2",
+  "regex",
+  "reqwest",
+  "rpassword",
+@@ -1596,39 +1680,33 @@ dependencies = [
+  "spin",
+ ]
+ 
+-[[package]]
+-name = "leb128fmt"
+-version = "0.1.0"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "09edd9e8b54e49e587e4f6295a7d29c3ea94d469cb40ab8ca70b288248a81db2"
+-
+ [[package]]
+ name = "libc"
+-version = "0.2.180"
++version = "0.2.189"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "bcc35a38544a891a5f7c865aca548a982ccb3b8650a5b06d0fd33a10283c56fc"
++checksum = "3eaf3ede3fee6db1a4c2ee091bf8a8b4dccdc6d17f656fb07896ee72867612f2"
+ 
+ [[package]]
+ name = "libflate"
+-version = "2.2.1"
++version = "2.3.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "e3248b8d211bd23a104a42d81b4fa8bb8ac4a3b75e7a43d85d2c9ccb6179cd74"
++checksum = "561a8da1a50e1428d3c51321dafeca849df992a5bb67720c386131234caba82e"
+ dependencies = [
+  "adler32",
+- "core2",
+  "crc32fast",
+  "dary_heap",
+  "libflate_lz77",
++ "no_std_io2",
+ ]
+ 
+ [[package]]
+ name = "libflate_lz77"
+-version = "2.2.0"
++version = "2.3.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "a599cb10a9cd92b1300debcef28da8f70b935ec937f44fcd1b70a7c986a11c5c"
++checksum = "ff7a10e427698aef6eef269482776debfef63384d30f13aad39a1a95e0e098fd"
+ dependencies = [
+- "core2",
+  "hashbrown 0.16.1",
++ "no_std_io2",
+  "rle-decode-fast",
+ ]
+ 
+@@ -1650,26 +1728,24 @@ checksum = "b6d2cec3eae94f9f509c767b45932f1ada8350c4bdb85af2fcab4a3c14807981"
+ 
+ [[package]]
+ name = "libredox"
+-version = "0.1.12"
++version = "0.1.24"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "3d0b95e02c851351f877147b7deea7b1afb1df71b63aa5f8270716e0c5720616"
++checksum = "6480ccc157a1389bb2e4891b24751b0f798ba640d22386f23143fbcc89da195a"
+ dependencies = [
+- "bitflags",
+  "libc",
+- "redox_syscall 0.7.1",
+ ]
+ 
+ [[package]]
+ name = "linux-raw-sys"
+-version = "0.11.0"
++version = "0.12.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "df1d3c3b53da64cf5760482273a98e575c651a67eec7f77df96b5b642de8f039"
++checksum = "32a66949e030da00e8c7d4434b251670a91556f4144941d37452769c25d58a53"
+ 
+ [[package]]
+ name = "litemap"
+-version = "0.8.1"
++version = "0.8.3"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "6373607a59f0be73a39b6fe456b8192fcc3585f602af20751600e974dd455e77"
++checksum = "47d9d19d1d6efa0109d2f65ff4c85cddd50bd572e5a00127ab10987290bcefae"
+ 
+ [[package]]
+ name = "lock_api"
+@@ -1682,9 +1758,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "log"
+-version = "0.4.29"
++version = "0.4.34"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "5e5032e24019045c762d3c0f28f5b6b8bbf38563a65908389bf7978758920897"
++checksum = "f9f8bd3e56ce4dfc153cf470fffbfa98c7620958b312ca5c3a4b8d5181fd13c6"
+ 
+ [[package]]
+ name = "lru-slab"
+@@ -1694,20 +1770,20 @@ checksum = "112b39cec0b298b6c1999fee3e31427f74f676e4cb9879ed1a121b43661a4154"
+ 
+ [[package]]
+ name = "maybe-async"
+-version = "0.2.10"
++version = "0.2.11"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "5cf92c10c7e361d6b99666ec1c6f9805b0bea2c3bd8c78dc6fe98ac5bd78db11"
++checksum = "746873a384ad60adc5db74471dfaba74bd278afbdcfd81db93fafcdfc8b5ca0c"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 2.0.119",
+ ]
+ 
+ [[package]]
+ name = "memchr"
+-version = "2.8.0"
++version = "2.8.3"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "f8ca58f447f06ed17d5fc4043ce1b10dd205e060fb3ce5b979b8ed8e59ff3f79"
++checksum = "cf8baf1c55e62ffcace7a9f06f4bd9cd3f0c4beb022d3b367256b91b87513d98"
+ 
+ [[package]]
+ name = "mime"
+@@ -1717,15 +1793,42 @@ checksum = "6877bb514081ee2a7ff5ef9de3281f14a4dd4bceac4c09388074a6b5df8a139a"
+ 
+ [[package]]
+ name = "mio"
+-version = "1.1.1"
++version = "1.2.3"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "a69bcab0ad47271a0234d9422b131806bf3968021e5dc9328caf2d4cd58557fc"
++checksum = "4b18443e9c262bfe8fa82f51666e2642c53393f7e5c27b3e1aeab922cff5b9d8"
+ dependencies = [
+  "libc",
+  "wasi",
+  "windows-sys 0.61.2",
+ ]
+ 
++[[package]]
++name = "multiversion"
++version = "0.9.0"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "b4ca4bea16ffc3f443cf7d866912118196bfef4c6a1556ca00f9f9b00bb43f7c"
++dependencies = [
++ "multiversion-macros",
++]
++
++[[package]]
++name = "multiversion-macros"
++version = "0.9.0"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "0d416831a7317ef4b08bee00b69cbbb9c8763da7959a7026244d6266869f9c83"
++dependencies = [
++ "proc-macro2",
++ "quote",
++ "rustversion",
++ "syn 3.0.5",
++]
++
++[[package]]
++name = "multiversion_no_op"
++version = "1.0.0"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "743fb55ba31b18fb1ecef6bdc9aa2743314978ac084044301a7eee33fb99a20d"
++
+ [[package]]
+ name = "new_debug_unreachable"
+ version = "1.0.6"
+@@ -1734,16 +1837,25 @@ checksum = "650eef8c711430f1a879fdd01d4745a7deea475becfb90269c06775983bbf086"
+ 
+ [[package]]
+ name = "nix"
+-version = "0.31.1"
++version = "0.31.3"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "225e7cfe711e0ba79a68baeddb2982723e4235247aefce1482f2f16c27865b66"
++checksum = "cf20d2fde8ff38632c426f1165ed7436270b44f199fc55284c38276f9db47c3d"
+ dependencies = [
+- "bitflags",
++ "bitflags 2.13.2",
+  "cfg-if",
+  "cfg_aliases",
+  "libc",
+ ]
+ 
++[[package]]
++name = "no_std_io2"
++version = "0.9.4"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "418abd1b6d34fbf6cae440dc874771b0525a604428704c76e48b29a5e67b8003"
++dependencies = [
++ "memchr",
++]
++
+ [[package]]
+ name = "num-bigint-dig"
+ version = "0.8.6"
+@@ -1755,33 +1867,32 @@ dependencies = [
+  "num-integer",
+  "num-iter",
+  "num-traits",
+- "rand 0.8.5",
++ "rand 0.8.8",
+  "smallvec",
+  "zeroize",
+ ]
+ 
+ [[package]]
+ name = "num-conv"
+-version = "0.2.0"
++version = "0.2.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "cf97ec579c3c42f953ef76dbf8d55ac91fb219dde70e49aa4a6b7d74e9919050"
++checksum = "521739c6d2bac4aa25192232afe6841231376b2b26d4d9fae5ecf8ca5772e441"
+ 
+ [[package]]
+ name = "num-integer"
+-version = "0.1.46"
++version = "0.1.47"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "7969661fd2958a5cb096e56c8e1ad0444ac2bbcd0061bd28660485a44879858f"
++checksum = "7ce2d95d4b3734dc35aa2f45e1aa22cd416814592a4f9d9205e11affd5b8e10b"
+ dependencies = [
+  "num-traits",
+ ]
+ 
+ [[package]]
+ name = "num-iter"
+-version = "0.1.45"
++version = "0.1.46"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "1429034a0490724d0075ebb2bc9e875d6503c3cf69e235a8941aa757d83ef5bf"
++checksum = "c92800bd69a1eac91786bcfe9da64a897eb72911b8dc3095decbd07429e8048b"
+ dependencies = [
+- "autocfg",
+  "num-integer",
+  "num-traits",
+ ]
+@@ -1815,7 +1926,7 @@ dependencies = [
+  "chrono",
+  "getrandom 0.2.17",
+  "http",
+- "rand 0.8.5",
++ "rand 0.8.8",
+  "serde",
+  "serde_json",
+  "serde_path_to_error",
+@@ -1826,9 +1937,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "once_cell"
+-version = "1.21.3"
++version = "1.21.4"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "42f5e15c9953c5e4ccceeb2e7382a716482c34515315f7b03532b8b4e8393d2d"
++checksum = "9f7c3e4beb33f85d45ae3e3a1792185706c8e16d043238c593331cc7cd313b50"
+ 
+ [[package]]
+ name = "once_cell_polyfill"
+@@ -1853,7 +1964,7 @@ dependencies = [
+  "oauth2",
+  "p256",
+  "p384",
+- "rand 0.8.5",
++ "rand 0.8.8",
+  "rsa",
+  "serde",
+  "serde-value",
+@@ -1869,15 +1980,14 @@ dependencies = [
+ 
+ [[package]]
+ name = "openssl"
+-version = "0.10.75"
++version = "0.10.81"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "08838db121398ad17ab8531ce9de97b244589089e290a384c900cb9ff7434328"
++checksum = "77823a27f0babb03091cb9ed9ef80af3b39dbc82f97e8fa530374b7dafd87a45"
+ dependencies = [
+- "bitflags",
++ "bitflags 2.13.2",
+  "cfg-if",
+  "foreign-types",
+  "libc",
+- "once_cell",
+  "openssl-macros",
+  "openssl-sys",
+ ]
+@@ -1890,7 +2000,7 @@ checksum = "a948666b637a0f465e8564c73e89d4dde00d72d4d473cc972f390fc3dcee7d9c"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 2.0.119",
+ ]
+ 
+ [[package]]
+@@ -1901,9 +2011,9 @@ checksum = "7c87def4c32ab89d880effc9e097653c8da5d6ef28e6b539d313baaacfbafcbe"
+ 
+ [[package]]
+ name = "openssl-sys"
+-version = "0.9.111"
++version = "0.9.117"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "82cab2d520aa75e3c58898289429321eb788c3106963d0dc886ec7a5f4adc321"
++checksum = "b47e7e6bb2c38cd930d25a23b40fa52e068c10e85f3e03a7f5ba5aaca5713695"
+ dependencies = [
+  "cc",
+  "libc",
+@@ -1962,7 +2072,7 @@ checksum = "2621685985a2ebf1c516881c026032ac7deafcda1a2c9b7850dc81e3dfcb64c1"
+ dependencies = [
+  "cfg-if",
+  "libc",
+- "redox_syscall 0.5.18",
++ "redox_syscall",
+  "smallvec",
+  "windows-link",
+ ]
+@@ -1999,7 +2109,7 @@ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "b4c5cc86750666a3ed20bdaf5ca2a0344f9c67674cae0515bec2da16fbaa47db"
+ dependencies = [
+  "fixedbitset",
+- "indexmap 2.13.0",
++ "indexmap 2.14.2",
+ ]
+ 
+ [[package]]
+@@ -2019,15 +2129,9 @@ checksum = "5be167a7af36ee22fe3115051bc51f6e6c7054c9348e28deb4f49bd6f705a315"
+ 
+ [[package]]
+ name = "pin-project-lite"
+-version = "0.2.16"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "3b3cff922bd51709b605d9ead9aa71031d81447142d828eb4a6eba76fe619f9b"
+-
+-[[package]]
+-name = "pin-utils"
+-version = "0.1.0"
++version = "0.2.17"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "8b870d8c151b6f2fb93e84a13146138f05d02ed11c7e7c54f8826aaaf7c9f184"
++checksum = "a89322df9ebe1c1578d689c92318e070967d1042b512afbe49518723f4e6d5cd"
+ 
+ [[package]]
+ name = "pkcs1"
+@@ -2052,15 +2156,30 @@ dependencies = [
+ 
+ [[package]]
+ name = "pkg-config"
+-version = "0.3.32"
++version = "0.3.34"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "f6b464fbc74e149a392436b17d523f769e057cb6877f6a5c4618bc6f11800548"
++
++[[package]]
++name = "portable-atomic"
++version = "1.15.0"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "05c8b63e8d9609db387f0324918f81d68fe27748f084ef092fb35954d0539a85"
++
++[[package]]
++name = "portable-atomic-util"
++version = "0.2.8"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
++checksum = "10ab3eb7f3becc3a1cbc4f2c6f20267996cfc1a6467a873763411b136a122715"
++dependencies = [
++ "portable-atomic",
++]
+ 
+ [[package]]
+ name = "potential_utf"
+-version = "0.1.4"
++version = "0.1.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b73949432f5e2a09657003c25bca5e19a0e9c84f8058ca374f49e0ebe605af77"
++checksum = "d83eb9bc6d8e5cf568e7a1101d60ee05e81ed50ea106026f3d18deeb046d7661"
+ dependencies = [
+  "zerovec",
+ ]
+@@ -2087,18 +2206,8 @@ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "925383efa346730478fb4838dbe9137d2a47675ad789c546d150a6e1dd4ab31c"
+ 
+ [[package]]
+-name = "prettyplease"
+-version = "0.2.37"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "479ca8adacdd7ce8f1fb39ce9ecccbfe93a3f1344b3d0d97f20bc0196208f62b"
+-dependencies = [
+- "proc-macro2",
+- "syn 2.0.116",
+-]
+-
+-[[package]]
+-name = "primeorder"
+-version = "0.13.6"
++name = "primeorder"
++version = "0.13.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "353e1ca18966c16d9deb1c69278edbc5f194139612772bd9537af60ac231e1e6"
+ dependencies = [
+@@ -2107,27 +2216,27 @@ dependencies = [
+ 
+ [[package]]
+ name = "proc-macro2"
+-version = "1.0.106"
++version = "1.0.107"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "8fd00f0bb2e90d81d1044c2b32617f68fcb9fa3bb7640c23e9c748e53fb30934"
++checksum = "985e7ec9bb745e6ce6535b544d84d6cd6f7ad8bd711c398938ae983b91a766d9"
+ dependencies = [
+  "unicode-ident",
+ ]
+ 
+ [[package]]
+ name = "quick-xml"
+-version = "0.39.1"
++version = "0.39.4"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "bd58c6a1fc307e1092aa0bb23d204ca4d1f021764142cd0424dccc84d2d5d106"
++checksum = "cdcc8dd4e2f670d309a5f0e83fe36dfdc05af317008fea29144da1a2ac858e5e"
+ dependencies = [
+  "memchr",
+ ]
+ 
+ [[package]]
+ name = "quinn"
+-version = "0.11.9"
++version = "0.11.11"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b9e20a958963c291dc322d98411f541009df2ced7b5a4f2bd52337638cfccf20"
++checksum = "0c1a41e437b6bbd489372cd4971de128e85c855f56c57f283d20ff016cf7c0a8"
+ dependencies = [
+  "bytes",
+  "cfg_aliases",
+@@ -2137,7 +2246,7 @@ dependencies = [
+  "rustc-hash",
+  "rustls",
+  "socket2",
+- "thiserror 2.0.18",
++ "thiserror 2.0.20",
+  "tokio",
+  "tracing",
+  "web-time",
+@@ -2145,21 +2254,22 @@ dependencies = [
+ 
+ [[package]]
+ name = "quinn-proto"
+-version = "0.11.13"
++version = "0.11.17"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "f1906b49b0c3bc04b5fe5d86a77925ae6524a19b816ae38ce1e426255f1d8a31"
++checksum = "04759210543be93709136e28212294a659ef5001836ff4eab4d663e4529bba83"
+ dependencies = [
+  "aws-lc-rs",
+  "bytes",
+- "getrandom 0.3.4",
++ "getrandom 0.4.3",
+  "lru-slab",
+- "rand 0.9.2",
++ "rand 0.10.2",
++ "rand_pcg",
+  "ring",
+  "rustc-hash",
+  "rustls",
+  "rustls-pki-types",
+  "slab",
+- "thiserror 2.0.18",
++ "thiserror 2.0.20",
+  "tinyvec",
+  "tracing",
+  "web-time",
+@@ -2167,32 +2277,32 @@ dependencies = [
+ 
+ [[package]]
+ name = "quinn-udp"
+-version = "0.5.14"
++version = "0.5.15"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "addec6a0dcad8a8d96a771f815f0eaf55f9d1805756410b39f5fa81332574cbd"
++checksum = "35a133f956daabe89a61a685c2649f13d82d5aa4bd5d12d1277e1072a21c0694"
+ dependencies = [
+  "cfg_aliases",
+  "libc",
+  "once_cell",
+  "socket2",
+  "tracing",
+- "windows-sys 0.60.2",
++ "windows-sys 0.61.2",
+ ]
+ 
+ [[package]]
+ name = "quote"
+-version = "1.0.44"
++version = "1.0.47"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "21b2ebcf727b7760c461f091f9f0f539b77b8e87f2fd88131e7f1b433b3cece4"
++checksum = "1fbf4db142a473a8d80c26bbf18454ed458bf8d26c8219c331daecfdbd079001"
+ dependencies = [
+  "proc-macro2",
+ ]
+ 
+ [[package]]
+ name = "r-efi"
+-version = "5.3.0"
++version = "6.0.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "69cdb34c158ceb288df11e18b4bd39de994f6657d83847bdffdbd7f346754b0f"
++checksum = "f8dcc9c7d52a811697d2151c701e0d08956f92b0e24136cf4cf27b57a6a0d9bf"
+ 
+ [[package]]
+ name = "r2d2"
+@@ -2207,34 +2317,24 @@ dependencies = [
+ 
+ [[package]]
+ name = "rand"
+-version = "0.8.5"
++version = "0.8.8"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
++checksum = "e058c7de0b26af77780c769414d6257830bb240f3c38477dbc2c16e5f54d6d4c"
+ dependencies = [
+  "libc",
+- "rand_chacha 0.3.1",
++ "rand_chacha",
+  "rand_core 0.6.4",
+ ]
+ 
+ [[package]]
+ name = "rand"
+-version = "0.9.2"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "6db2770f06117d490610c7488547d543617b21bfa07796d7a12f6f1bd53850d1"
+-dependencies = [
+- "rand_chacha 0.9.0",
+- "rand_core 0.9.5",
+-]
+-
+-[[package]]
+-name = "rand"
+-version = "0.10.0"
++version = "0.10.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "bc266eb313df6c5c09c1c7b1fbe2510961e5bcd3add930c1e31f7ed9da0feff8"
++checksum = "c7f5fa3a058cd35567ef9bfa5e75732bee0f9e4c55fa90477bef2dfcdbc4be80"
+ dependencies = [
+  "chacha20",
+- "getrandom 0.4.1",
+- "rand_core 0.10.0",
++ "getrandom 0.4.3",
++ "rand_core 0.10.1",
+ ]
+ 
+ [[package]]
+@@ -2247,16 +2347,6 @@ dependencies = [
+  "rand_core 0.6.4",
+ ]
+ 
+-[[package]]
+-name = "rand_chacha"
+-version = "0.9.0"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "d3022b5f1df60f26e1ffddd6c66e8aa15de382ae63b3a0c1bfc0e4d3e3f325cb"
+-dependencies = [
+- "ppv-lite86",
+- "rand_core 0.9.5",
+-]
+-
+ [[package]]
+ name = "rand_core"
+ version = "0.6.4"
+@@ -2268,35 +2358,26 @@ dependencies = [
+ 
+ [[package]]
+ name = "rand_core"
+-version = "0.9.5"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "76afc826de14238e6e8c374ddcc1fa19e374fd8dd986b0d2af0d02377261d83c"
+-dependencies = [
+- "getrandom 0.3.4",
+-]
+-
+-[[package]]
+-name = "rand_core"
+-version = "0.10.0"
++version = "0.10.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "0c8d0fd677905edcbeedbf2edb6494d676f0e98d54d5cf9bda0b061cb8fb8aba"
++checksum = "63b8176103e19a2643978565ca18b50549f6101881c443590420e4dc998a3c69"
+ 
+ [[package]]
+-name = "redox_syscall"
+-version = "0.5.18"
++name = "rand_pcg"
++version = "0.10.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "ed2bf2547551a7053d6fdfafda3f938979645c44812fbfcda098faae3f1a362d"
++checksum = "caa0f4137e1c0a72f4c651489402276c8e8e1cf081f3b0ba156d2cbeef09e86a"
+ dependencies = [
+- "bitflags",
++ "rand_core 0.10.1",
+ ]
+ 
+ [[package]]
+ name = "redox_syscall"
+-version = "0.7.1"
++version = "0.5.18"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "35985aa610addc02e24fc232012c86fd11f14111180f902b67e2d5331f8ebf2b"
++checksum = "ed2bf2547551a7053d6fdfafda3f938979645c44812fbfcda098faae3f1a362d"
+ dependencies = [
+- "bitflags",
++ "bitflags 2.13.2",
+ ]
+ 
+ [[package]]
+@@ -2312,29 +2393,29 @@ dependencies = [
+ 
+ [[package]]
+ name = "ref-cast"
+-version = "1.0.25"
++version = "1.0.27"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "f354300ae66f76f1c85c5f84693f0ce81d747e2c3f21a45fef496d89c960bf7d"
++checksum = "7e440fb4e4b4147295338efb76001ab9e4efc0e5839df2c47fc5ac2381d365c3"
+ dependencies = [
+  "ref-cast-impl",
+ ]
+ 
+ [[package]]
+ name = "ref-cast-impl"
+-version = "1.0.25"
++version = "1.0.27"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b7186006dcb21920990093f30e3dea63b7d6e977bf1256be20c3563a5db070da"
++checksum = "92ecd8964f8453721699a1ed72037b0db49ce2f5a5138486ee89bed6f67cdf3a"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 3.0.5",
+ ]
+ 
+ [[package]]
+ name = "regex"
+-version = "1.12.3"
++version = "1.13.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "e10754a14b9137dd7b1e3e5b0493cc9171fdd105e0ab477f51b72e7f3ac0e276"
++checksum = "f020237b6c8eed93db2e2cb53c00c60a8e1bc73da7d073199a1180401450218d"
+ dependencies = [
+  "aho-corasick",
+  "memchr",
+@@ -2344,9 +2425,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "regex-automata"
+-version = "0.4.14"
++version = "0.4.18"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "6e1dd4122fc1595e8162618945476892eefca7b88c52820e74af6262213cae8f"
++checksum = "ad8553b9b26413251cbf30e620595c7a41b3887f03da04579c0e6b0d6a06b4b2"
+ dependencies = [
+  "aho-corasick",
+  "memchr",
+@@ -2355,17 +2436,17 @@ dependencies = [
+ 
+ [[package]]
+ name = "regex-syntax"
+-version = "0.8.9"
++version = "0.8.11"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "a96887878f22d7bad8a3b6dc5b7440e0ada9a245242924394987b21cf2210a4c"
++checksum = "d6f6ff9a378485b298a5286656da665ba74413d36db0979633275d2e708145d4"
+ 
+ [[package]]
+ name = "reqwest"
+-version = "0.13.2"
++version = "0.13.5"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "ab3f43e3283ab1488b624b44b0e988d0acea0b3214e694730a055cb6b2efa801"
++checksum = "16a1cfa75cc186dd73d5818e510e042e40927bccc9c236b061cea97e1eb08029"
+ dependencies = [
+- "base64 0.22.1",
++ "base64 0.23.1",
+  "bytes",
+  "encoding_rs",
+  "futures-core",
+@@ -2431,20 +2512,20 @@ checksum = "3582f63211428f83597b51b2ddb88e2a91a9d52d12831f9d08f5e624e8977422"
+ 
+ [[package]]
+ name = "rpassword"
+-version = "7.4.0"
++version = "7.5.4"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "66d4c8b64f049c6721ec8ccec37ddfc3d641c4a7fca57e8f2a89de509c73df39"
++checksum = "2da316a15f47e3d053de9cb2c439650bd8fa4aaeb9365f2e5f27f492ff73c196"
+ dependencies = [
+  "libc",
+  "rtoolbox",
+- "windows-sys 0.59.0",
++ "windows-sys 0.61.2",
+ ]
+ 
+ [[package]]
+ name = "rpki"
+-version = "0.19.2"
++version = "0.19.3"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "99010980abb0aee7a5c4b1c04d0f42f74f57ac168adb5d38a99b3517a4d72df9"
++checksum = "9157a0b503ef5d3821bae79d2d4f44e1f5655eacdcc1b67623dd4403cd9ee302"
+ dependencies = [
+  "base64 0.22.1",
+  "bcder",
+@@ -2480,19 +2561,19 @@ dependencies = [
+ 
+ [[package]]
+ name = "rtoolbox"
+-version = "0.0.3"
++version = "0.0.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "a7cc970b249fbe527d6e02e0a227762c9108b2f49d81094fe357ffc6d14d7f6f"
++checksum = "9a1efe12a1469752d0e6ff5ebec0b6ef4924cc5c4c71046b0ec730040535819d"
+ dependencies = [
+  "libc",
+- "windows-sys 0.52.0",
++ "windows-sys 0.61.2",
+ ]
+ 
+ [[package]]
+ name = "rustc-hash"
+-version = "2.1.1"
++version = "2.1.3"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "357703d41365b4b27c590e3ed91eabb1b663f07c4c084095e60cbed4362dff0d"
++checksum = "6b1e7f9a428571be2dc5bc0505c13fb6bf936822b894ec87abf8a08a4e51742d"
+ 
+ [[package]]
+ name = "rustc_version"
+@@ -2505,11 +2586,11 @@ dependencies = [
+ 
+ [[package]]
+ name = "rustix"
+-version = "1.1.3"
++version = "1.1.4"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "146c9e247ccc180c1f61615433868c99f3de3ae256a30a43b49f67c2d9171f34"
++checksum = "b6fe4565b9518b83ef4f91bb47ce29620ca828bd32cb7e408f0062e9930ba190"
+ dependencies = [
+- "bitflags",
++ "bitflags 2.13.2",
+  "errno",
+  "libc",
+  "linux-raw-sys",
+@@ -2518,9 +2599,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "rustls"
+-version = "0.23.36"
++version = "0.23.44"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "c665f33d38cea657d9614f766881e4d510e0eda4239891eea56b4cadcf01801b"
++checksum = "6725596c3f2c3a0aef021139e145d4eafe314a6623e4680ca83852b2c67ab2ba"
+ dependencies = [
+  "aws-lc-rs",
+  "log",
+@@ -2533,9 +2614,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "rustls-native-certs"
+-version = "0.8.3"
++version = "0.8.4"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "612460d5f7bea540c490b2b6395d8e34a953e52b491accd6c86c8164c5932a63"
++checksum = "dab5152771c58876a2146916e53e35057e1a4dfa2b9df0f0305b07f611fdea4d"
+ dependencies = [
+  "openssl-probe",
+  "rustls-pki-types",
+@@ -2554,9 +2635,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "rustls-pki-types"
+-version = "1.14.0"
++version = "1.15.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "be040f8b0a225e40375822a563fa9524378b9d63112f53e19ffff34df5d33fdd"
++checksum = "2f4925028c7eb5d1fcdaf196971378ed9d2c1c4efc7dc5d011256f76c99c0a96"
+ dependencies = [
+  "web-time",
+  "zeroize",
+@@ -2564,9 +2645,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "rustls-platform-verifier"
+-version = "0.6.2"
++version = "0.7.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "1d99feebc72bae7ab76ba994bb5e121b8d83d910ca40b36e0921f53becc41784"
++checksum = "26d1e2536ce4f35f4846aa13bff16bd0ff40157cdb14cc056c7b14ba41233ba0"
+ dependencies = [
+  "core-foundation 0.10.1",
+  "core-foundation-sys",
+@@ -2591,9 +2672,9 @@ checksum = "f87165f0995f63a9fbeea62b64d10b4d9d8e78ec6d7d51fb2125fda7bb36788f"
+ 
+ [[package]]
+ name = "rustls-webpki"
+-version = "0.103.9"
++version = "0.103.15"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "d7df23109aa6c1567d1c575b9952556388da57401e4ace1d15f79eedad0d8f53"
++checksum = "f3c3cf1d8b1e7d4927e2d154c3fcb02979afb9939629c62cd9048d4f07b60ac2"
+ dependencies = [
+  "aws-lc-rs",
+  "ring",
+@@ -2603,9 +2684,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "rustversion"
+-version = "1.0.22"
++version = "1.0.23"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b39cdef0fa800fc44525c84ccb54a029961a8215f9619753635a9c0d2538d46d"
++checksum = "cf54715a573b99ac80df0bc206da022bcd442c974952c7b9720069370852e21f"
+ 
+ [[package]]
+ name = "salsa20"
+@@ -2627,9 +2708,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "schannel"
+-version = "0.1.28"
++version = "0.1.29"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "891d81b926048e76efe18581bf793546b4c0eaf8448d72be8de2bbee5fd166e1"
++checksum = "91c1b7e4904c873ef0710c1f407dde2e6287de2bebc1bbbf7d430bb7cbffd939"
+ dependencies = [
+  "windows-sys 0.61.2",
+ ]
+@@ -2657,9 +2738,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "schemars"
+-version = "1.2.1"
++version = "1.2.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "a2b42f36aa1cd011945615b92222f6bf73c599a102a300334cd7f8dbeec726cc"
++checksum = "687274d293b6cdc6e73e0fee520bf2049650090d7164f87672d212a3c530cf4a"
+ dependencies = [
+  "dyn-clone",
+  "ref-cast",
+@@ -2710,11 +2791,11 @@ dependencies = [
+ 
+ [[package]]
+ name = "security-framework"
+-version = "3.6.0"
++version = "3.7.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "d17b898a6d6948c3a8ee4372c17cb384f90d2e6e912ef00895b14fd7ab54ec38"
++checksum = "b7f4bc775c73d9a02cde8bf7b2ec4c9d12743edf609006c7facc23998404cd1d"
+ dependencies = [
+- "bitflags",
++ "bitflags 2.13.2",
+  "core-foundation 0.10.1",
+  "core-foundation-sys",
+  "libc",
+@@ -2723,9 +2804,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "security-framework-sys"
+-version = "2.16.0"
++version = "2.17.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "321c8673b092a9a42605034a9879d73cb79101ed5fd117bc9a597b89b4e9e61a"
++checksum = "6ce2691df843ecc5d231c0b14ece2acc3efb62c0a398c7e1d875f3983ce020e3"
+ dependencies = [
+  "core-foundation-sys",
+  "libc",
+@@ -2733,15 +2814,15 @@ dependencies = [
+ 
+ [[package]]
+ name = "semver"
+-version = "1.0.27"
++version = "1.0.28"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "d767eb0aabc880b29956c35734170f26ed551a859dbd361d140cdbeca61ab1e2"
++checksum = "8a7852d02fc848982e0c167ef163aaff9cd91dc640ba85e263cb1ce46fae51cd"
+ 
+ [[package]]
+ name = "serde"
+-version = "1.0.228"
++version = "1.0.229"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e"
++checksum = "4148590afebada386688f18773da617792bf2ef03ffc1e4cbd2b1d45b023e0ba"
+ dependencies = [
+  "serde_core",
+  "serde_derive",
+@@ -2769,29 +2850,29 @@ dependencies = [
+ 
+ [[package]]
+ name = "serde_core"
+-version = "1.0.228"
++version = "1.0.229"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
++checksum = "67dca2c9c51e58a4791a4b1ed58308b39c64224d349a935ab5039aa360942a48"
+ dependencies = [
+  "serde_derive",
+ ]
+ 
+ [[package]]
+ name = "serde_derive"
+-version = "1.0.228"
++version = "1.0.229"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
++checksum = "e7a5d71263a5a7d47b41f6b3f06ba276f10cc18b0931f1799f710578e2309348"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 3.0.5",
+ ]
+ 
+ [[package]]
+ name = "serde_json"
+-version = "1.0.149"
++version = "1.0.151"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "83fc039473c5595ace860d8c4fafa220ff474b3fc6bfdb4293327f1a37e94d86"
++checksum = "c841b55ecdae098c80dcae9cf767f6f8a0c2cdb3416bbef72181df4d0fe73f14"
+ dependencies = [
+  "itoa",
+  "memchr",
+@@ -2822,26 +2903,28 @@ dependencies = [
+ 
+ [[package]]
+ name = "serde_spanned"
+-version = "1.0.4"
++version = "1.1.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "f8bbf91e5a4d6315eee45e704372590b30e260ee83af6639d64557f51b067776"
++checksum = "6662b5879511e06e8999a8a235d848113e942c9124f211511b16466ee2995f26"
+ dependencies = [
+  "serde_core",
+ ]
+ 
+ [[package]]
+ name = "serde_with"
+-version = "3.16.1"
++version = "3.23.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "4fa237f2807440d238e0364a218270b98f767a00d3dada77b1c53ae88940e2e7"
++checksum = "935177bb8c0cd8ca1a4e6d1a2ac8988bea69cab4f9d3a31311e012ad27868ea4"
+ dependencies = [
+- "base64 0.22.1",
++ "base64 0.23.1",
++ "bs58",
+  "chrono",
+  "hex",
+  "indexmap 1.9.3",
+- "indexmap 2.13.0",
++ "indexmap 2.14.2",
++ "jiff",
+  "schemars 0.9.0",
+- "schemars 1.2.1",
++ "schemars 1.2.2",
+  "serde_core",
+  "serde_json",
+  "serde_with_macros",
+@@ -2850,14 +2933,14 @@ dependencies = [
+ 
+ [[package]]
+ name = "serde_with_macros"
+-version = "3.16.1"
++version = "3.23.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "52a8e3ca0ca629121f70ab50f95249e5a6f925cc0f6ffe8256c45b728875706c"
++checksum = "1d607aa01a3cb0ad757d6fd216136910db3c97b102fe686585689615a02dbcdc"
+ dependencies = [
+  "darling",
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 3.0.5",
+ ]
+ 
+ [[package]]
+@@ -2873,9 +2956,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "shlex"
+-version = "1.3.0"
++version = "2.0.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
++checksum = "f8fadd59c855ef2080decdef8ff161eb6661b86933c9d82e5ba29dc602a55aba"
+ 
+ [[package]]
+ name = "signal-hook-registry"
+@@ -2897,11 +2980,27 @@ dependencies = [
+  "rand_core 0.6.4",
+ ]
+ 
++[[package]]
++name = "simd_cesu8"
++version = "1.2.0"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "11031e251abf8611c80f460e19dbdeb54a66db918e49c65a7065b46ac7aec520"
++dependencies = [
++ "rustc_version",
++ "simdutf8",
++]
++
++[[package]]
++name = "simdutf8"
++version = "0.1.5"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "e3a9fe34e3e7a50316060351f37187a3f546bce95496156754b601a5fa71b76e"
++
+ [[package]]
+ name = "siphasher"
+-version = "1.0.2"
++version = "1.0.3"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b2aa850e253778c88a04c3d7323b043aeda9d3e30d5971937c1855769763678e"
++checksum = "8ee5873ec9cce0195efcb7a4e9507a04cd49aec9c83d0389df45b1ef7ba2e649"
+ 
+ [[package]]
+ name = "slab"
+@@ -2911,25 +3010,25 @@ checksum = "0c790de23124f9ab44544d7ac05d60440adc586479ce501c1d6d7da3cd8c9cf5"
+ 
+ [[package]]
+ name = "smallvec"
+-version = "1.15.1"
++version = "1.16.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03"
++checksum = "ba467056f1b547ed52077911161fc86985becbc60e8e1857c8a144dab0def891"
+ 
+ [[package]]
+ name = "socket2"
+-version = "0.6.2"
++version = "0.6.5"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "86f4aa3ad99f2088c990dfa82d367e19cb29268ed67c574d10d0a4bfe71f07e0"
++checksum = "c3d1e2c7f27f8d4cb10542a02c49005dbd6e93095799d6f3be745fae9f8fedd4"
+ dependencies = [
+  "libc",
+- "windows-sys 0.60.2",
++ "windows-sys 0.61.2",
+ ]
+ 
+ [[package]]
+ name = "spin"
+-version = "0.9.8"
++version = "0.9.9"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "6980e8d7511241f8acf4aebddbb1ff938df5eebe98691418c4468d0b72a96a67"
++checksum = "3763264f6b73151db08c50ff20d7d8a0b8796e021cdea7ceedad07b80155fa0e"
+ 
+ [[package]]
+ name = "spki"
+@@ -2997,9 +3096,20 @@ dependencies = [
+ 
+ [[package]]
+ name = "syn"
+-version = "2.0.116"
++version = "2.0.119"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "3df424c70518695237746f84cede799c9c58fcb37450d7b23716568cc8bc69cb"
++checksum = "872831b642d1a07999a962a351ed35b955ea2cfc8f3862091e2a240a84f17297"
++dependencies = [
++ "proc-macro2",
++ "quote",
++ "unicode-ident",
++]
++
++[[package]]
++name = "syn"
++version = "3.0.5"
++source = "registry+https://github.com/rust-lang/crates.io-index"
++checksum = "12df2e0110f65b775f769bb17ef989067a1d931b2eb822bd4346631eeada89f9"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+@@ -3023,7 +3133,7 @@ checksum = "728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 2.0.119",
+ ]
+ 
+ [[package]]
+@@ -3044,7 +3154,7 @@ version = "0.7.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "a13f3d0daba03132c0aa9767f98351b3488edc2c100cda2d2ec2b04f3d8d3c8b"
+ dependencies = [
+- "bitflags",
++ "bitflags 2.13.2",
+  "core-foundation 0.9.4",
+  "system-configuration-sys",
+ ]
+@@ -3061,9 +3171,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "tar"
+-version = "0.4.44"
++version = "0.4.46"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "1d863878d212c87a19c1a610eb53bb01fe12951c0501cf5a0d65f724914a667a"
++checksum = "3f6221d9a6003c78398e3b239969f352578258df48c8eb051caadae0015bc840"
+ dependencies = [
+  "filetime",
+  "libc",
+@@ -3072,12 +3182,12 @@ dependencies = [
+ 
+ [[package]]
+ name = "tempfile"
+-version = "3.25.0"
++version = "3.27.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "0136791f7c95b1f6dd99f9cc786b91bb81c3800b639b3478e561ddb7be95e5f1"
++checksum = "32497e9a4c7b38532efcdebeef879707aa9f794296a4f0244f6f69e9bc8574bd"
+ dependencies = [
+  "fastrand",
+- "getrandom 0.4.1",
++ "getrandom 0.4.3",
+  "once_cell",
+  "rustix",
+  "windows-sys 0.61.2",
+@@ -3105,12 +3215,12 @@ dependencies = [
+ 
+ [[package]]
+ name = "terminal_size"
+-version = "0.4.3"
++version = "0.4.4"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "60b8cb979cb11c32ce1603f8137b22262a9d131aaa5c37b5678025f22b8becd0"
++checksum = "230a1b821ccbd75b185820a1f1ff7b14d21da1e442e22c0863ea5f08771a8874"
+ dependencies = [
+  "rustix",
+- "windows-sys 0.60.2",
++ "windows-sys 0.61.2",
+ ]
+ 
+ [[package]]
+@@ -3124,11 +3234,11 @@ dependencies = [
+ 
+ [[package]]
+ name = "thiserror"
+-version = "2.0.18"
++version = "2.0.20"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "4288b5bcbc7920c07a1149a35cf9590a2aa808e0bc1eafaade0b80947865fbc4"
++checksum = "ec86235f5fcc2a73650310756d2ac5b138a5780bbbdfae3eeccec992c435ba4f"
+ dependencies = [
+- "thiserror-impl 2.0.18",
++ "thiserror-impl 2.0.20",
+ ]
+ 
+ [[package]]
+@@ -3139,37 +3249,36 @@ checksum = "4fee6c4efc90059e10f81e6d42c60a18f76588c3d74cb83a0b242a2b6c7504c1"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 2.0.119",
+ ]
+ 
+ [[package]]
+ name = "thiserror-impl"
+-version = "2.0.18"
++version = "2.0.20"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "ebc4ee7f67670e9b64d05fa4253e753e016c6c95ff35b89b7941d6b856dec1d5"
++checksum = "bc04cd3e1236dd4a98afca4569f2deb3f120e5422a4023be2cb683f8486292af"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 3.0.5",
+ ]
+ 
+ [[package]]
+ name = "thread_local"
+-version = "1.1.9"
++version = "1.1.10"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "f60246a4944f24f6e018aa17cdeffb7818b76356965d03b07d6a9886e8962185"
++checksum = "1ad99c4c6d32803332c548b1af0540b357b3f5fc0be8f6c6bfe8b2e6ae784070"
+ dependencies = [
+  "cfg-if",
+ ]
+ 
+ [[package]]
+ name = "time"
+-version = "0.3.47"
++version = "0.3.55"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "743bd48c283afc0388f9b8827b976905fb217ad9e647fae3a379a9283c4def2c"
++checksum = "cdb87b95ec50ddfa440816d227a17b2ccbdda963a316a727fda0fc4334f7d134"
+ dependencies = [
+  "deranged",
+- "itoa",
+  "libc",
+  "num-conv",
+  "num_threads",
+@@ -3181,15 +3290,15 @@ dependencies = [
+ 
+ [[package]]
+ name = "time-core"
+-version = "0.1.8"
++version = "0.1.9"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "7694e1cfe791f8d31026952abf09c69ca6f6fa4e1a1229e18988f06a04a12dca"
++checksum = "9e1c906769ad99c88eaa54e728060edef082f8e358ff32030cb7c7d315e81109"
+ 
+ [[package]]
+ name = "time-macros"
+-version = "0.2.27"
++version = "0.2.32"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "2e70e4c5a0e0a8a4823ad65dfe1a6930e4f4d756dcd9dd7939022b5e8c501215"
++checksum = "7e689342a48d2ea927c87ea50cabf8594854bf940e9310208848d680d668ed85"
+ dependencies = [
+  "num-conv",
+  "time-core",
+@@ -3206,9 +3315,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "tinystr"
+-version = "0.8.2"
++version = "0.8.4"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "42d3e9c45c09de15d06dd8acf5f4e0e399e85927b7f00711024eb7ae10fa4869"
++checksum = "b1e27c91459209c2986af3dcf603a5a74a4368754ce37414f59acc971167f643"
+ dependencies = [
+  "displaydoc",
+  "zerovec",
+@@ -3216,9 +3325,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "tinyvec"
+-version = "1.10.0"
++version = "1.13.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "bfa5fdc3bce6191a1dbc8c02d5c8bffcf557bafa17c124c5264a458f1b0613fa"
++checksum = "4cf0ded5c4e56918d8f8a339e1bb67d038d3bc6d144ac407904015ba2e4cde9b"
+ dependencies = [
+  "tinyvec_macros",
+ ]
+@@ -3231,9 +3340,9 @@ checksum = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
+ 
+ [[package]]
+ name = "tokio"
+-version = "1.49.0"
++version = "1.53.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "72a2903cd7736441aac9df9d7688bd0ce48edccaadf181c3b90be801e81d3d86"
++checksum = "202caea871b69668250d242070849eb495be178ed697a3e98aebce5bc81a0bed"
+ dependencies = [
+  "bytes",
+  "libc",
+@@ -3247,20 +3356,20 @@ dependencies = [
+ 
+ [[package]]
+ name = "tokio-macros"
+-version = "2.6.0"
++version = "2.7.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "af407857209536a95c8e56f8231ef2c2e2aff839b22e07a1ffcbc617e9db9fa5"
++checksum = "78773a2a397f451582ce068015985c33193cf6dea8b74d2a639fe457b2f07b0e"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 3.0.5",
+ ]
+ 
+ [[package]]
+ name = "tokio-rustls"
+-version = "0.26.4"
++version = "0.26.5"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "1729aa945f29d91ba541258c8df89027d5792d85a8841fb65e8bf0f4ede4ef61"
++checksum = "b0c85f2c3ef0b1cd58b36682f4b17aaa995f0e5db534d85692b4903abce21f67"
+ dependencies = [
+  "rustls",
+  "tokio",
+@@ -3268,13 +3377,14 @@ dependencies = [
+ 
+ [[package]]
+ name = "tokio-util"
+-version = "0.7.18"
++version = "0.7.19"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "9ae9cec805b01e8fc3fd2fe289f89149a9b66dd16786abd8b19cfa7b48cb0098"
++checksum = "494815d09bf52b5548659851081238f0ca39ff638363907596da739561c62c52"
+ dependencies = [
+  "bytes",
+  "futures-core",
+  "futures-sink",
++ "libc",
+  "pin-project-lite",
+  "tokio",
+ ]
+@@ -3285,13 +3395,13 @@ version = "0.9.12+spec-1.1.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "cf92845e79fc2e2def6a5d828f0801e29a2f8acc037becc5ab08595c7d5e9863"
+ dependencies = [
+- "indexmap 2.13.0",
++ "indexmap 2.14.2",
+  "serde_core",
+  "serde_spanned",
+  "toml_datetime",
+  "toml_parser",
+  "toml_writer",
+- "winnow",
++ "winnow 0.7.15",
+ ]
+ 
+ [[package]]
+@@ -3305,18 +3415,18 @@ dependencies = [
+ 
+ [[package]]
+ name = "toml_parser"
+-version = "1.0.9+spec-1.1.0"
++version = "1.1.3+spec-1.1.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "702d4415e08923e7e1ef96cd5727c0dfed80b4d2fa25db9647fe5eb6f7c5a4c4"
++checksum = "1d38ac1cf9b95face32296c0a3ede1fdc270627c9d9c02a7274dd6d960dc4d56"
+ dependencies = [
+- "winnow",
++ "winnow 1.0.4",
+ ]
+ 
+ [[package]]
+ name = "toml_writer"
+-version = "1.0.6+spec-1.1.0"
++version = "1.1.2+spec-1.1.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "ab16f14aed21ee8bfd8ec22513f7287cd4a91aa92e44edfe2c17ddd004e92607"
++checksum = "7d56353a2a665ad0f41a421187180aab746c8c325620617ad883a99a1cbe66d2"
+ 
+ [[package]]
+ name = "tower"
+@@ -3335,20 +3445,20 @@ dependencies = [
+ 
+ [[package]]
+ name = "tower-http"
+-version = "0.6.8"
++version = "0.6.11"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "d4e6559d53cc268e5031cd8429d05415bc4cb4aefc4aa5d6cc35fbf5b924a1f8"
++checksum = "4cfcf7e2740e6fc6d4d688b4ef00650406bb94adf4731e43c096c3a19fe40840"
+ dependencies = [
+- "bitflags",
++ "bitflags 2.13.2",
+  "bytes",
+  "futures-util",
+  "http",
+  "http-body",
+- "iri-string",
+  "pin-project-lite",
+  "tower",
+  "tower-layer",
+  "tower-service",
++ "url",
+ ]
+ 
+ [[package]]
+@@ -3401,9 +3511,9 @@ checksum = "e421abadd41a4225275504ea4d6566923418b7f05506fbc9c0fe86ba7396114b"
+ 
+ [[package]]
+ name = "typenum"
+-version = "1.19.0"
++version = "1.20.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "562d481066bde0658276a35467c4af00bdc6ee726305698a55b86e61d7ad82bb"
++checksum = "b6f5e870be6c3b371b77fe0ee0bafb859fa4964b4404c27de1d380043c4dda20"
+ 
+ [[package]]
+ name = "unicode-ident"
+@@ -3465,11 +3575,11 @@ checksum = "06abde3611657adf66d383f00b093d7faecc7fa57071cce2578660c9f1010821"
+ 
+ [[package]]
+ name = "uuid"
+-version = "1.21.0"
++version = "1.26.1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b672338555252d43fd2240c714dc444b8c6fb0a5c5335e65a07bba7742735ddb"
++checksum = "2ef6dac1e96601b4fb3acccccff2139741fcb757cb9a36089bf5be91cfb285ce"
+ dependencies = [
+- "getrandom 0.4.1",
++ "getrandom 0.4.3",
+  "js-sys",
+  "serde_core",
+  "wasm-bindgen",
+@@ -3512,29 +3622,11 @@ version = "0.11.1+wasi-snapshot-preview1"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "ccf3ec651a847eb01de73ccad15eb7d99f80485de043efb2f370cd654f4ea44b"
+ 
+-[[package]]
+-name = "wasip2"
+-version = "1.0.2+wasi-0.2.9"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "9517f9239f02c069db75e65f174b3da828fe5f5b945c4dd26bd25d89c03ebcf5"
+-dependencies = [
+- "wit-bindgen",
+-]
+-
+-[[package]]
+-name = "wasip3"
+-version = "0.4.0+wasi-0.3.0-rc-2026-01-06"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "5428f8bf88ea5ddc08faddef2ac4a67e390b88186c703ce6dbd955e1c145aca5"
+-dependencies = [
+- "wit-bindgen",
+-]
+-
+ [[package]]
+ name = "wasm-bindgen"
+-version = "0.2.108"
++version = "0.2.128"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "64024a30ec1e37399cf85a7ffefebdb72205ca1c972291c51512360d90bd8566"
++checksum = "aecb87a33d3b0c5e3b7aa46336eaf486cffafbd281b195e4c8b80d50df2351bf"
+ dependencies = [
+  "cfg-if",
+  "once_cell",
+@@ -3545,23 +3637,19 @@ dependencies = [
+ 
+ [[package]]
+ name = "wasm-bindgen-futures"
+-version = "0.4.58"
++version = "0.4.78"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "70a6e77fd0ae8029c9ea0063f87c46fde723e7d887703d74ad2616d792e51e6f"
++checksum = "6ef4c5d3d2cdf5c54f4231181768f5510842e350db025faf1f7163b1030ed928"
+ dependencies = [
+- "cfg-if",
+- "futures-util",
+  "js-sys",
+- "once_cell",
+  "wasm-bindgen",
+- "web-sys",
+ ]
+ 
+ [[package]]
+ name = "wasm-bindgen-macro"
+-version = "0.2.108"
++version = "0.2.128"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "008b239d9c740232e71bd39e8ef6429d27097518b6b30bdf9086833bd5b6d608"
++checksum = "a690d511e3c1a8b3a55e33511e3c2c00c78415cd23650f32b808627f5696b9ed"
+ dependencies = [
+  "quote",
+  "wasm-bindgen-macro-support",
+@@ -3569,65 +3657,31 @@ dependencies = [
+ 
+ [[package]]
+ name = "wasm-bindgen-macro-support"
+-version = "0.2.108"
++version = "0.2.128"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "5256bae2d58f54820e6490f9839c49780dff84c65aeab9e772f15d5f0e913a55"
++checksum = "411e4887f0071ef2d2164a9d5fdf2d20efbef78fccd3a78b0c10a1dc5295e48a"
+ dependencies = [
+  "bumpalo",
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 3.0.5",
+  "wasm-bindgen-shared",
+ ]
+ 
+ [[package]]
+ name = "wasm-bindgen-shared"
+-version = "0.2.108"
++version = "0.2.128"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "1f01b580c9ac74c8d8f0c0e4afb04eeef2acf145458e52c03845ee9cd23e3d12"
++checksum = "81941cd78d0c92026c33e5e01312845a4cb1e9af3407f9134b100dd03144103e"
+ dependencies = [
+  "unicode-ident",
+ ]
+ 
+-[[package]]
+-name = "wasm-encoder"
+-version = "0.244.0"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "990065f2fe63003fe337b932cfb5e3b80e0b4d0f5ff650e6985b1048f62c8319"
+-dependencies = [
+- "leb128fmt",
+- "wasmparser",
+-]
+-
+-[[package]]
+-name = "wasm-metadata"
+-version = "0.244.0"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "bb0e353e6a2fbdc176932bbaab493762eb1255a7900fe0fea1a2f96c296cc909"
+-dependencies = [
+- "anyhow",
+- "indexmap 2.13.0",
+- "wasm-encoder",
+- "wasmparser",
+-]
+-
+-[[package]]
+-name = "wasmparser"
+-version = "0.244.0"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "47b807c72e1bac69382b3a6fb3dbe8ea4c0ed87ff5629b8685ae6b9a611028fe"
+-dependencies = [
+- "bitflags",
+- "hashbrown 0.15.5",
+- "indexmap 2.13.0",
+- "semver",
+-]
+-
+ [[package]]
+ name = "web-sys"
+-version = "0.3.85"
++version = "0.3.105"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "312e32e551d92129218ea9a2452120f4aabc03529ef03e4d0d82fb2780608598"
++checksum = "9fbddc4a036f00ec4f18c83445bd3115cb306a91da554919a099d9222fe4a7f8"
+ dependencies = [
+  "js-sys",
+  "wasm-bindgen",
+@@ -3645,9 +3699,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "webpki-root-certs"
+-version = "1.0.6"
++version = "1.0.9"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "804f18a4ac2676ffb4e8b5b5fa9ae38af06df08162314f96a68d2a363e21a8ca"
++checksum = "b96554aa2acc8ccdb7e1c9a58a7a68dd5d13bccc69cd124cb09406db612a1c9b"
+ dependencies = [
+  "rustls-pki-types",
+ ]
+@@ -3704,7 +3758,7 @@ checksum = "053e2e040ab57b9dc951b72c264860db7eb3b0200ba345b4e4c3b14f67855ddf"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 2.0.119",
+ ]
+ 
+ [[package]]
+@@ -3715,7 +3769,7 @@ checksum = "3f316c4a2570ba26bbec722032c4099d8c8bc095efccdc15688708623367e358"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 2.0.119",
+ ]
+ 
+ [[package]]
+@@ -3753,22 +3807,13 @@ dependencies = [
+  "windows-link",
+ ]
+ 
+-[[package]]
+-name = "windows-sys"
+-version = "0.45.0"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "75283be5efb2831d37ea142365f009c02ec203cd29a3ebecbc093d52315b66d0"
+-dependencies = [
+- "windows-targets 0.42.2",
+-]
+-
+ [[package]]
+ name = "windows-sys"
+ version = "0.52.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
+ dependencies = [
+- "windows-targets 0.52.6",
++ "windows-targets",
+ ]
+ 
+ [[package]]
+@@ -3777,16 +3822,7 @@ version = "0.59.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
+ dependencies = [
+- "windows-targets 0.52.6",
+-]
+-
+-[[package]]
+-name = "windows-sys"
+-version = "0.60.2"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "f2f500e4d28234f72040990ec9d39e3a6b950f9f22d3dba18416c35882612bcb"
+-dependencies = [
+- "windows-targets 0.53.5",
++ "windows-targets",
+ ]
+ 
+ [[package]]
+@@ -3798,291 +3834,87 @@ dependencies = [
+  "windows-link",
+ ]
+ 
+-[[package]]
+-name = "windows-targets"
+-version = "0.42.2"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "8e5180c00cd44c9b1c88adb3693291f1cd93605ded80c250a75d472756b4d071"
+-dependencies = [
+- "windows_aarch64_gnullvm 0.42.2",
+- "windows_aarch64_msvc 0.42.2",
+- "windows_i686_gnu 0.42.2",
+- "windows_i686_msvc 0.42.2",
+- "windows_x86_64_gnu 0.42.2",
+- "windows_x86_64_gnullvm 0.42.2",
+- "windows_x86_64_msvc 0.42.2",
+-]
+-
+ [[package]]
+ name = "windows-targets"
+ version = "0.52.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
+ dependencies = [
+- "windows_aarch64_gnullvm 0.52.6",
+- "windows_aarch64_msvc 0.52.6",
+- "windows_i686_gnu 0.52.6",
+- "windows_i686_gnullvm 0.52.6",
+- "windows_i686_msvc 0.52.6",
+- "windows_x86_64_gnu 0.52.6",
+- "windows_x86_64_gnullvm 0.52.6",
+- "windows_x86_64_msvc 0.52.6",
++ "windows_aarch64_gnullvm",
++ "windows_aarch64_msvc",
++ "windows_i686_gnu",
++ "windows_i686_gnullvm",
++ "windows_i686_msvc",
++ "windows_x86_64_gnu",
++ "windows_x86_64_gnullvm",
++ "windows_x86_64_msvc",
+ ]
+ 
+-[[package]]
+-name = "windows-targets"
+-version = "0.53.5"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "4945f9f551b88e0d65f3db0bc25c33b8acea4d9e41163edf90dcd0b19f9069f3"
+-dependencies = [
+- "windows-link",
+- "windows_aarch64_gnullvm 0.53.1",
+- "windows_aarch64_msvc 0.53.1",
+- "windows_i686_gnu 0.53.1",
+- "windows_i686_gnullvm 0.53.1",
+- "windows_i686_msvc 0.53.1",
+- "windows_x86_64_gnu 0.53.1",
+- "windows_x86_64_gnullvm 0.53.1",
+- "windows_x86_64_msvc 0.53.1",
+-]
+-
+-[[package]]
+-name = "windows_aarch64_gnullvm"
+-version = "0.42.2"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "597a5118570b68bc08d8d59125332c54f1ba9d9adeedeef5b99b02ba2b0698f8"
+-
+ [[package]]
+ name = "windows_aarch64_gnullvm"
+ version = "0.52.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
+ 
+-[[package]]
+-name = "windows_aarch64_gnullvm"
+-version = "0.53.1"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "a9d8416fa8b42f5c947f8482c43e7d89e73a173cead56d044f6a56104a6d1b53"
+-
+-[[package]]
+-name = "windows_aarch64_msvc"
+-version = "0.42.2"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "e08e8864a60f06ef0d0ff4ba04124db8b0fb3be5776a5cd47641e942e58c4d43"
+-
+ [[package]]
+ name = "windows_aarch64_msvc"
+ version = "0.52.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
+ 
+-[[package]]
+-name = "windows_aarch64_msvc"
+-version = "0.53.1"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b9d782e804c2f632e395708e99a94275910eb9100b2114651e04744e9b125006"
+-
+-[[package]]
+-name = "windows_i686_gnu"
+-version = "0.42.2"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "c61d927d8da41da96a81f029489353e68739737d3beca43145c8afec9a31a84f"
+-
+ [[package]]
+ name = "windows_i686_gnu"
+ version = "0.52.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
+ 
+-[[package]]
+-name = "windows_i686_gnu"
+-version = "0.53.1"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "960e6da069d81e09becb0ca57a65220ddff016ff2d6af6a223cf372a506593a3"
+-
+ [[package]]
+ name = "windows_i686_gnullvm"
+ version = "0.52.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
+ 
+-[[package]]
+-name = "windows_i686_gnullvm"
+-version = "0.53.1"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "fa7359d10048f68ab8b09fa71c3daccfb0e9b559aed648a8f95469c27057180c"
+-
+-[[package]]
+-name = "windows_i686_msvc"
+-version = "0.42.2"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "44d840b6ec649f480a41c8d80f9c65108b92d89345dd94027bfe06ac444d1060"
+-
+ [[package]]
+ name = "windows_i686_msvc"
+ version = "0.52.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
+ 
+-[[package]]
+-name = "windows_i686_msvc"
+-version = "0.53.1"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "1e7ac75179f18232fe9c285163565a57ef8d3c89254a30685b57d83a38d326c2"
+-
+-[[package]]
+-name = "windows_x86_64_gnu"
+-version = "0.42.2"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "8de912b8b8feb55c064867cf047dda097f92d51efad5b491dfb98f6bbb70cb36"
+-
+ [[package]]
+ name = "windows_x86_64_gnu"
+ version = "0.52.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
+ 
+-[[package]]
+-name = "windows_x86_64_gnu"
+-version = "0.53.1"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "9c3842cdd74a865a8066ab39c8a7a473c0778a3f29370b5fd6b4b9aa7df4a499"
+-
+-[[package]]
+-name = "windows_x86_64_gnullvm"
+-version = "0.42.2"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "26d41b46a36d453748aedef1486d5c7a85db22e56aff34643984ea85514e94a3"
+-
+ [[package]]
+ name = "windows_x86_64_gnullvm"
+ version = "0.52.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
+ 
+-[[package]]
+-name = "windows_x86_64_gnullvm"
+-version = "0.53.1"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "0ffa179e2d07eee8ad8f57493436566c7cc30ac536a3379fdf008f47f6bb7ae1"
+-
+-[[package]]
+-name = "windows_x86_64_msvc"
+-version = "0.42.2"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "9aec5da331524158c6d1a4ac0ab1541149c0b9505fde06423b02f5ef0106b9f0"
+-
+ [[package]]
+ name = "windows_x86_64_msvc"
+ version = "0.52.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+ checksum = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
+ 
+-[[package]]
+-name = "windows_x86_64_msvc"
+-version = "0.53.1"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "d6bbff5f0aada427a1e5a6da5f1f98158182f26556f345ac9e04d36d0ebed650"
+-
+ [[package]]
+ name = "winnow"
+-version = "0.7.14"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "5a5364e9d77fcdeeaa6062ced926ee3381faa2ee02d3eb83a5c27a8825540829"
+-
+-[[package]]
+-name = "wit-bindgen"
+-version = "0.51.0"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "d7249219f66ced02969388cf2bb044a09756a083d0fab1e566056b04d9fbcaa5"
+-dependencies = [
+- "wit-bindgen-rust-macro",
+-]
+-
+-[[package]]
+-name = "wit-bindgen-core"
+-version = "0.51.0"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "ea61de684c3ea68cb082b7a88508a8b27fcc8b797d738bfc99a82facf1d752dc"
+-dependencies = [
+- "anyhow",
+- "heck",
+- "wit-parser",
+-]
+-
+-[[package]]
+-name = "wit-bindgen-rust"
+-version = "0.51.0"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b7c566e0f4b284dd6561c786d9cb0142da491f46a9fbed79ea69cdad5db17f21"
+-dependencies = [
+- "anyhow",
+- "heck",
+- "indexmap 2.13.0",
+- "prettyplease",
+- "syn 2.0.116",
+- "wasm-metadata",
+- "wit-bindgen-core",
+- "wit-component",
+-]
+-
+-[[package]]
+-name = "wit-bindgen-rust-macro"
+-version = "0.51.0"
++version = "0.7.15"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "0c0f9bfd77e6a48eccf51359e3ae77140a7f50b1e2ebfe62422d8afdaffab17a"
+-dependencies = [
+- "anyhow",
+- "prettyplease",
+- "proc-macro2",
+- "quote",
+- "syn 2.0.116",
+- "wit-bindgen-core",
+- "wit-bindgen-rust",
+-]
++checksum = "df79d97927682d2fd8adb29682d1140b343be4ac0f08fd68b7765d9c059d3945"
+ 
+ [[package]]
+-name = "wit-component"
+-version = "0.244.0"
++name = "winnow"
++version = "1.0.4"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "9d66ea20e9553b30172b5e831994e35fbde2d165325bec84fc43dbf6f4eb9cb2"
+-dependencies = [
+- "anyhow",
+- "bitflags",
+- "indexmap 2.13.0",
+- "log",
+- "serde",
+- "serde_derive",
+- "serde_json",
+- "wasm-encoder",
+- "wasm-metadata",
+- "wasmparser",
+- "wit-parser",
+-]
+-
+-[[package]]
+-name = "wit-parser"
+-version = "0.244.0"
+-source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "ecc8ac4bc1dc3381b7f59c34f00b67e18f910c2c0f50015669dde7def656a736"
+-dependencies = [
+- "anyhow",
+- "id-arena",
+- "indexmap 2.13.0",
+- "log",
+- "semver",
+- "serde",
+- "serde_derive",
+- "serde_json",
+- "unicode-xid",
+- "wasmparser",
+-]
++checksum = "23b97319f7b8343df12cc98938e5c3eb436064524c8d2b4e30a1d3a36eecdf81"
+ 
+ [[package]]
+ name = "writeable"
+-version = "0.6.2"
++version = "0.6.4"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "9edde0db4769d2dc68579893f2306b26c6ecfbe0ef499b013d731b7b9247e0b9"
++checksum = "3ad82d2a33cdc9674dc7465672f271e096168fcdbe0f799d9e6db8c5892679dc"
+ 
+ [[package]]
+ name = "xattr"
+@@ -4096,9 +3928,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "yoke"
+-version = "0.8.1"
++version = "0.8.3"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "72d6e5c6afb84d73944e5cedb052c4680d5657337201555f9f2a16b7406d4954"
++checksum = "709fe23a0424b6a435d82152b1bd3fdfb0833487d5fa90d05d42762a9891fef5"
+ dependencies = [
+  "stable_deref_trait",
+  "yoke-derive",
+@@ -4107,68 +3939,68 @@ dependencies = [
+ 
+ [[package]]
+ name = "yoke-derive"
+-version = "0.8.1"
++version = "0.8.2"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b659052874eb698efe5b9e8cf382204678a0086ebf46982b79d6ca3182927e5d"
++checksum = "de844c262c8848816172cef550288e7dc6c7b7814b4ee56b3e1553f275f1858e"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 2.0.119",
+  "synstructure",
+ ]
+ 
+ [[package]]
+ name = "zerocopy"
+-version = "0.8.39"
++version = "0.8.57"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "db6d35d663eadb6c932438e763b262fe1a70987f9ae936e60158176d710cae4a"
++checksum = "d35102a9f36d089ccae9e4c6802bc118be4487b80aaffc0ab4e0cf5ce92d2873"
+ dependencies = [
+  "zerocopy-derive",
+ ]
+ 
+ [[package]]
+ name = "zerocopy-derive"
+-version = "0.8.39"
++version = "0.8.57"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "4122cd3169e94605190e77839c9a40d40ed048d305bfdc146e7df40ab0f3e517"
++checksum = "146c01f5ab44258da43cf276c74a2763db2ff3969c9c652c3f2de07041d0b2bc"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 2.0.119",
+ ]
+ 
+ [[package]]
+ name = "zerofrom"
+-version = "0.1.6"
++version = "0.1.8"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "50cc42e0333e05660c3587f3bf9d0478688e15d870fab3346451ce7f8c9fbea5"
++checksum = "0ec05a11813ea801ff6d75110ad09cd0824ddba17dfe17128ea0d5f68e6c5272"
+ dependencies = [
+  "zerofrom-derive",
+ ]
+ 
+ [[package]]
+ name = "zerofrom-derive"
+-version = "0.1.6"
++version = "0.1.7"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "d71e5d6e06ab090c67b5e44993ec16b72dcbaabc526db883a360057678b48502"
++checksum = "11532158c46691caf0f2593ea8358fed6bbf68a0315e80aae9bd41fbade684a1"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 2.0.119",
+  "synstructure",
+ ]
+ 
+ [[package]]
+ name = "zeroize"
+-version = "1.8.2"
++version = "1.9.0"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b97154e67e32c85465826e8bcc1c59429aaaf107c1e4a9e53c8d8ccd5eff88d0"
++checksum = "e13c156562582aa81c60cb29407084cdb54c4164760106ab78e6c5b0858cf64e"
+ 
+ [[package]]
+ name = "zerotrie"
+-version = "0.2.3"
++version = "0.2.5"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "2a59c17a5562d507e4b54960e8569ebee33bee890c70aa3fe7b97e85a9fd7851"
++checksum = "4ea269c3bd32f0a32c321907a2ae912ba6f4649bb0fc764a15627e99a7095a3f"
+ dependencies = [
+  "displaydoc",
+  "yoke",
+@@ -4177,9 +4009,9 @@ dependencies = [
+ 
+ [[package]]
+ name = "zerovec"
+-version = "0.11.5"
++version = "0.11.8"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "6c28719294829477f525be0186d13efa9a3c602f7ec202ca9e353d310fb9a002"
++checksum = "bb0464e17806c1d976d5cba29399c7f08e516e279e2ba493f63123b5fca67dd8"
+ dependencies = [
+  "yoke",
+  "zerofrom",
+@@ -4188,17 +4020,17 @@ dependencies = [
+ 
+ [[package]]
+ name = "zerovec-derive"
+-version = "0.11.2"
++version = "0.11.6"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "eadce39539ca5cb3985590102671f2567e659fca9666581ad3411d59207951f3"
++checksum = "34df6fc39dbd26ddc9c10e6a2984476e13acce22e64e4487636ef494369225da"
+ dependencies = [
+  "proc-macro2",
+  "quote",
+- "syn 2.0.116",
++ "syn 3.0.5",
+ ]
+ 
+ [[package]]
+ name = "zmij"
+-version = "1.0.21"
++version = "1.0.23"
+ source = "registry+https://github.com/rust-lang/crates.io-index"
+-checksum = "b8848ee67ecc8aedbaf3e4122217aff892639231befc6a1b58d29fff4c2cabaa"
++checksum = "29666d0abbfad1e3dc4dcf6144730dd3a3ab225bbbdac83319345b1b44ccfc1b"
diff --git a/recipes-security/krill/files/panic_workaround.patch b/recipes-security/krill/files/panic_workaround.patch
deleted file mode 100644
index f63169f..0000000
--- a/recipes-security/krill/files/panic_workaround.patch
+++ /dev/null
@@ -1,16 +0,0 @@
-Upstream-Status: Inappropriate [OE specific]
-Signed-off-by: Armin Kuster <akuster808@gmail.com>
-
-Index: git/Cargo.toml
-===================================================================
---- git.orig/Cargo.toml
-+++ git/Cargo.toml
-@@ -91,7 +91,7 @@ hsm-tests-pkcs11 = [ "hsm" ]
- # Make sure that Krill crashes on panics, rather than losing threads and
- # limping on in a bad state.
- [profile.release]
--panic = "abort"
-+#panic = "abort"
- 
- [dev-dependencies]
- regex     = "1.5.5"
diff --git a/recipes-security/krill/krill-crates.inc b/recipes-security/krill/krill-crates.inc
index 85830ec..89541ab 100644
--- a/recipes-security/krill/krill-crates.inc
+++ b/recipes-security/krill/krill-crates.inc
@@ -2,549 +2,817 @@
 
 # from Cargo.lock
 SRC_URI += " \
-    crate://crates.io/addr2line/0.17.0;name=addr2line-0.17.0 \
-    crate://crates.io/adler/1.0.2;name=adler-1.0.2 \
-    crate://crates.io/adler32/1.2.0;name=adler32-1.2.0 \
-    crate://crates.io/aho-corasick/0.7.18;name=aho-corasick-0.7.18 \
-    crate://crates.io/android_system_properties/0.1.5;name=android_system_properties-0.1.5 \
-    crate://crates.io/ansi_term/0.12.1;name=ansi_term-0.12.1 \
-    crate://crates.io/ascii/1.0.0;name=ascii-1.0.0 \
-    crate://crates.io/ascii-canvas/3.0.0;name=ascii-canvas-3.0.0 \
-    crate://crates.io/atty/0.2.14;name=atty-0.2.14 \
-    crate://crates.io/autocfg/1.1.0;name=autocfg-1.1.0 \
-    crate://crates.io/backoff/0.3.0;name=backoff-0.3.0 \
-    crate://crates.io/backtrace/0.3.66;name=backtrace-0.3.66 \
-    crate://crates.io/base64/0.13.0;name=base64-0.13.0 \
-    crate://crates.io/basic-cookies/0.1.4;name=basic-cookies-0.1.4 \
-    crate://crates.io/bcder/0.7.0;name=bcder-0.7.0 \
-    crate://crates.io/bit-set/0.5.2;name=bit-set-0.5.2 \
-    crate://crates.io/bit-vec/0.6.3;name=bit-vec-0.6.3 \
-    crate://crates.io/bitflags/1.3.2;name=bitflags-1.3.2 \
-    crate://crates.io/block-buffer/0.9.0;name=block-buffer-0.9.0 \
-    crate://crates.io/block-buffer/0.10.2;name=block-buffer-0.10.2 \
-    crate://crates.io/bumpalo/3.10.0;name=bumpalo-3.10.0 \
-    crate://crates.io/bytes/1.1.0;name=bytes-1.1.0 \
-    crate://crates.io/cc/1.0.73;name=cc-1.0.73 \
-    crate://crates.io/cfg-if/1.0.0;name=cfg-if-1.0.0 \
-    crate://crates.io/chrono/0.4.22;name=chrono-0.4.22 \
-    crate://crates.io/chunked_transfer/1.4.0;name=chunked_transfer-1.4.0 \
-    crate://crates.io/cipher/0.2.5;name=cipher-0.2.5 \
-    crate://crates.io/clap/2.34.0;name=clap-2.34.0 \
-    crate://crates.io/codespan-reporting/0.11.1;name=codespan-reporting-0.11.1 \
-    crate://crates.io/core-foundation/0.9.3;name=core-foundation-0.9.3 \
-    crate://crates.io/core-foundation-sys/0.8.3;name=core-foundation-sys-0.8.3 \
-    crate://crates.io/cpufeatures/0.2.2;name=cpufeatures-0.2.2 \
-    crate://crates.io/crc32fast/1.3.2;name=crc32fast-1.3.2 \
-    crate://crates.io/crunchy/0.2.2;name=crunchy-0.2.2 \
-    crate://crates.io/crypto-common/0.1.6;name=crypto-common-0.1.6 \
-    crate://crates.io/crypto-mac/0.10.1;name=crypto-mac-0.10.1 \
-    crate://crates.io/cryptoki/0.3.0;name=cryptoki-0.3.0 \
-    crate://crates.io/cryptoki-sys/0.1.4;name=cryptoki-sys-0.1.4 \
-    crate://crates.io/ctrlc/3.2.2;name=ctrlc-3.2.2 \
-    crate://crates.io/cxx/1.0.79;name=cxx-1.0.79 \
-    crate://crates.io/cxx-build/1.0.79;name=cxx-build-1.0.79 \
-    crate://crates.io/cxxbridge-flags/1.0.79;name=cxxbridge-flags-1.0.79 \
-    crate://crates.io/cxxbridge-macro/1.0.79;name=cxxbridge-macro-1.0.79 \
-    crate://crates.io/derivative/2.2.0;name=derivative-2.2.0 \
-    crate://crates.io/deunicode/0.4.3;name=deunicode-0.4.3 \
-    crate://crates.io/diff/0.1.13;name=diff-0.1.13 \
-    crate://crates.io/digest/0.9.0;name=digest-0.9.0 \
-    crate://crates.io/digest/0.10.3;name=digest-0.10.3 \
-    crate://crates.io/dirs-next/2.0.0;name=dirs-next-2.0.0 \
-    crate://crates.io/dirs-sys-next/0.1.2;name=dirs-sys-next-0.1.2 \
-    crate://crates.io/either/1.7.0;name=either-1.7.0 \
-    crate://crates.io/ena/0.14.0;name=ena-0.14.0 \
-    crate://crates.io/encoding_rs/0.8.31;name=encoding_rs-0.8.31 \
-    crate://crates.io/enum-display-derive/0.1.1;name=enum-display-derive-0.1.1 \
-    crate://crates.io/enum-flags/0.1.8;name=enum-flags-0.1.8 \
-    crate://crates.io/error-chain/0.11.0;name=error-chain-0.11.0 \
-    crate://crates.io/fastrand/1.7.0;name=fastrand-1.7.0 \
-    crate://crates.io/fern/0.5.9;name=fern-0.5.9 \
-    crate://crates.io/fixedbitset/0.4.2;name=fixedbitset-0.4.2 \
-    crate://crates.io/fnv/1.0.7;name=fnv-1.0.7 \
-    crate://crates.io/foreign-types/0.3.2;name=foreign-types-0.3.2 \
-    crate://crates.io/foreign-types-shared/0.1.1;name=foreign-types-shared-0.1.1 \
-    crate://crates.io/form_urlencoded/1.0.1;name=form_urlencoded-1.0.1 \
-    crate://crates.io/fslock/0.2.1;name=fslock-0.2.1 \
-    crate://crates.io/futures/0.3.21;name=futures-0.3.21 \
-    crate://crates.io/futures-channel/0.3.21;name=futures-channel-0.3.21 \
-    crate://crates.io/futures-core/0.3.21;name=futures-core-0.3.21 \
-    crate://crates.io/futures-executor/0.3.21;name=futures-executor-0.3.21 \
-    crate://crates.io/futures-io/0.3.21;name=futures-io-0.3.21 \
-    crate://crates.io/futures-macro/0.3.21;name=futures-macro-0.3.21 \
-    crate://crates.io/futures-sink/0.3.21;name=futures-sink-0.3.21 \
-    crate://crates.io/futures-task/0.3.21;name=futures-task-0.3.21 \
-    crate://crates.io/futures-util/0.3.21;name=futures-util-0.3.21 \
-    crate://crates.io/generic-array/0.14.5;name=generic-array-0.14.5 \
-    crate://crates.io/getrandom/0.2.7;name=getrandom-0.2.7 \
-    crate://crates.io/gimli/0.26.2;name=gimli-0.26.2 \
-    crate://crates.io/h2/0.3.13;name=h2-0.3.13 \
-    crate://crates.io/hashbrown/0.12.3;name=hashbrown-0.12.3 \
-    crate://crates.io/hermit-abi/0.1.19;name=hermit-abi-0.1.19 \
-    crate://crates.io/hex/0.4.3;name=hex-0.4.3 \
-    crate://crates.io/hmac/0.10.1;name=hmac-0.10.1 \
-    crate://crates.io/http/0.2.8;name=http-0.2.8 \
-    crate://crates.io/http-body/0.4.5;name=http-body-0.4.5 \
-    crate://crates.io/httparse/1.7.1;name=httparse-1.7.1 \
-    crate://crates.io/httpdate/1.0.2;name=httpdate-1.0.2 \
-    crate://crates.io/hyper/0.14.20;name=hyper-0.14.20 \
-    crate://crates.io/hyper-tls/0.5.0;name=hyper-tls-0.5.0 \
-    crate://crates.io/iana-time-zone/0.1.51;name=iana-time-zone-0.1.51 \
-    crate://crates.io/iana-time-zone-haiku/0.1.1;name=iana-time-zone-haiku-0.1.1 \
-    crate://crates.io/idna/0.2.3;name=idna-0.2.3 \
-    crate://crates.io/impl-trait-for-tuples/0.2.2;name=impl-trait-for-tuples-0.2.2 \
-    crate://crates.io/indexmap/1.9.1;name=indexmap-1.9.1 \
-    crate://crates.io/instant/0.1.12;name=instant-0.1.12 \
-    crate://crates.io/intervaltree/0.2.7;name=intervaltree-0.2.7 \
-    crate://crates.io/ipnet/2.5.0;name=ipnet-2.5.0 \
-    crate://crates.io/itertools/0.10.3;name=itertools-0.10.3 \
-    crate://crates.io/itoa/1.0.2;name=itoa-1.0.2 \
-    crate://crates.io/jmespatch/0.3.0;name=jmespatch-0.3.0 \
-    crate://crates.io/js-sys/0.3.58;name=js-sys-0.3.58 \
-    crate://crates.io/kmip-protocol/0.4.2;name=kmip-protocol-0.4.2 \
-    crate://crates.io/kmip-ttlv/0.3.3;name=kmip-ttlv-0.3.3 \
-    crate://crates.io/lalrpop/0.19.8;name=lalrpop-0.19.8 \
-    crate://crates.io/lalrpop-util/0.19.8;name=lalrpop-util-0.19.8 \
-    crate://crates.io/lazy_static/1.4.0;name=lazy_static-1.4.0 \
-    crate://crates.io/libc/0.2.126;name=libc-0.2.126 \
-    crate://crates.io/libflate/1.2.0;name=libflate-1.2.0 \
-    crate://crates.io/libflate_lz77/1.1.0;name=libflate_lz77-1.1.0 \
-    crate://crates.io/libloading/0.7.3;name=libloading-0.7.3 \
-    crate://crates.io/link-cplusplus/1.0.7;name=link-cplusplus-1.0.7 \
-    crate://crates.io/lock_api/0.4.7;name=lock_api-0.4.7 \
-    crate://crates.io/log/0.4.17;name=log-0.4.17 \
-    crate://crates.io/maplit/1.0.2;name=maplit-1.0.2 \
-    crate://crates.io/matchers/0.0.1;name=matchers-0.0.1 \
-    crate://crates.io/matches/0.1.9;name=matches-0.1.9 \
-    crate://crates.io/maybe-async/0.2.6;name=maybe-async-0.2.6 \
-    crate://crates.io/memchr/2.5.0;name=memchr-2.5.0 \
-    crate://crates.io/mime/0.3.16;name=mime-0.3.16 \
-    crate://crates.io/miniz_oxide/0.5.3;name=miniz_oxide-0.5.3 \
-    crate://crates.io/mio/0.8.4;name=mio-0.8.4 \
-    crate://crates.io/native-tls/0.2.10;name=native-tls-0.2.10 \
-    crate://crates.io/new_debug_unreachable/1.0.4;name=new_debug_unreachable-1.0.4 \
-    crate://crates.io/nix/0.24.2;name=nix-0.24.2 \
-    crate://crates.io/num-bigint/0.4.3;name=num-bigint-0.4.3 \
-    crate://crates.io/num-integer/0.1.45;name=num-integer-0.1.45 \
-    crate://crates.io/num-traits/0.2.15;name=num-traits-0.2.15 \
-    crate://crates.io/num_cpus/1.13.1;name=num_cpus-1.13.1 \
-    crate://crates.io/oauth2/4.2.3;name=oauth2-4.2.3 \
-    crate://crates.io/object/0.29.0;name=object-0.29.0 \
-    crate://crates.io/once_cell/1.13.0;name=once_cell-1.13.0 \
-    crate://crates.io/opaque-debug/0.3.0;name=opaque-debug-0.3.0 \
-    crate://crates.io/openidconnect/2.3.2;name=openidconnect-2.3.2 \
-    crate://crates.io/openssl/0.10.41;name=openssl-0.10.41 \
-    crate://crates.io/openssl-macros/0.1.0;name=openssl-macros-0.1.0 \
-    crate://crates.io/openssl-probe/0.1.5;name=openssl-probe-0.1.5 \
-    crate://crates.io/openssl-src/111.25.0+1.1.1t;name=openssl-src-111.25.0+1.1.1t \
-    crate://crates.io/openssl-sys/0.9.75;name=openssl-sys-0.9.75 \
-    crate://crates.io/ordered-float/2.10.0;name=ordered-float-2.10.0 \
-    crate://crates.io/oso/0.12.4;name=oso-0.12.4 \
-    crate://crates.io/parking_lot/0.12.1;name=parking_lot-0.12.1 \
-    crate://crates.io/parking_lot_core/0.9.3;name=parking_lot_core-0.9.3 \
-    crate://crates.io/pbkdf2/0.7.5;name=pbkdf2-0.7.5 \
-    crate://crates.io/percent-encoding/2.1.0;name=percent-encoding-2.1.0 \
-    crate://crates.io/petgraph/0.6.2;name=petgraph-0.6.2 \
-    crate://crates.io/phf_shared/0.10.0;name=phf_shared-0.10.0 \
-    crate://crates.io/pico-args/0.4.2;name=pico-args-0.4.2 \
-    crate://crates.io/pin-project-lite/0.2.9;name=pin-project-lite-0.2.9 \
-    crate://crates.io/pin-utils/0.1.0;name=pin-utils-0.1.0 \
-    crate://crates.io/pkg-config/0.3.25;name=pkg-config-0.3.25 \
-    crate://crates.io/polar-core/0.12.4;name=polar-core-0.12.4 \
-    crate://crates.io/ppv-lite86/0.2.16;name=ppv-lite86-0.2.16 \
-    crate://crates.io/precomputed-hash/0.1.1;name=precomputed-hash-0.1.1 \
-    crate://crates.io/priority-queue/1.2.2;name=priority-queue-1.2.2 \
-    crate://crates.io/proc-macro2/1.0.40;name=proc-macro2-1.0.40 \
-    crate://crates.io/quick-xml/0.23.0;name=quick-xml-0.23.0 \
-    crate://crates.io/quote/1.0.20;name=quote-1.0.20 \
-    crate://crates.io/r2d2/0.8.10;name=r2d2-0.8.10 \
-    crate://crates.io/rand/0.8.5;name=rand-0.8.5 \
-    crate://crates.io/rand_chacha/0.3.1;name=rand_chacha-0.3.1 \
-    crate://crates.io/rand_core/0.6.3;name=rand_core-0.6.3 \
-    crate://crates.io/redox_syscall/0.2.13;name=redox_syscall-0.2.13 \
-    crate://crates.io/redox_users/0.4.3;name=redox_users-0.4.3 \
-    crate://crates.io/regex/1.6.0;name=regex-1.6.0 \
-    crate://crates.io/regex-automata/0.1.10;name=regex-automata-0.1.10 \
-    crate://crates.io/regex-syntax/0.6.27;name=regex-syntax-0.6.27 \
-    crate://crates.io/remove_dir_all/0.5.3;name=remove_dir_all-0.5.3 \
-    crate://crates.io/reqwest/0.11.11;name=reqwest-0.11.11 \
-    crate://crates.io/ring/0.16.20;name=ring-0.16.20 \
-    crate://crates.io/rle-decode-fast/1.0.3;name=rle-decode-fast-1.0.3 \
-    crate://crates.io/routecore/0.2.0;name=routecore-0.2.0 \
-    crate://crates.io/rpassword/5.0.1;name=rpassword-5.0.1 \
-    crate://crates.io/rpki/0.15.8;name=rpki-0.15.8 \
-    crate://crates.io/rustc-demangle/0.1.21;name=rustc-demangle-0.1.21 \
-    crate://crates.io/rustc_version/0.4.0;name=rustc_version-0.4.0 \
-    crate://crates.io/rustls/0.19.1;name=rustls-0.19.1 \
-    crate://crates.io/rustversion/1.0.8;name=rustversion-1.0.8 \
-    crate://crates.io/ryu/1.0.10;name=ryu-1.0.10 \
-    crate://crates.io/salsa20/0.7.2;name=salsa20-0.7.2 \
-    crate://crates.io/schannel/0.1.20;name=schannel-0.1.20 \
-    crate://crates.io/scheduled-thread-pool/0.2.6;name=scheduled-thread-pool-0.2.6 \
-    crate://crates.io/scopeguard/1.1.0;name=scopeguard-1.1.0 \
-    crate://crates.io/scratch/1.0.2;name=scratch-1.0.2 \
-    crate://crates.io/scrypt/0.6.5;name=scrypt-0.6.5 \
-    crate://crates.io/sct/0.6.1;name=sct-0.6.1 \
-    crate://crates.io/security-framework/2.6.1;name=security-framework-2.6.1 \
-    crate://crates.io/security-framework-sys/2.6.1;name=security-framework-sys-2.6.1 \
-    crate://crates.io/semver/1.0.12;name=semver-1.0.12 \
-    crate://crates.io/serde/1.0.139;name=serde-1.0.139 \
-    crate://crates.io/serde-value/0.7.0;name=serde-value-0.7.0 \
-    crate://crates.io/serde_bytes/0.11.6;name=serde_bytes-0.11.6 \
-    crate://crates.io/serde_derive/1.0.139;name=serde_derive-1.0.139 \
-    crate://crates.io/serde_json/1.0.82;name=serde_json-1.0.82 \
-    crate://crates.io/serde_path_to_error/0.1.7;name=serde_path_to_error-0.1.7 \
-    crate://crates.io/serde_urlencoded/0.7.1;name=serde_urlencoded-0.7.1 \
-    crate://crates.io/sha2/0.9.9;name=sha2-0.9.9 \
-    crate://crates.io/sha2/0.10.2;name=sha2-0.10.2 \
-    crate://crates.io/sharded-slab/0.1.4;name=sharded-slab-0.1.4 \
-    crate://crates.io/signal-hook-registry/1.4.0;name=signal-hook-registry-1.4.0 \
-    crate://crates.io/siphasher/0.3.10;name=siphasher-0.3.10 \
-    crate://crates.io/slab/0.4.6;name=slab-0.4.6 \
-    crate://crates.io/slug/0.1.4;name=slug-0.1.4 \
-    crate://crates.io/smallvec/1.9.0;name=smallvec-1.9.0 \
-    crate://crates.io/socket2/0.4.4;name=socket2-0.4.4 \
-    crate://crates.io/spin/0.5.2;name=spin-0.5.2 \
-    crate://crates.io/string_cache/0.8.4;name=string_cache-0.8.4 \
-    crate://crates.io/strsim/0.8.0;name=strsim-0.8.0 \
-    crate://crates.io/subtle/2.4.1;name=subtle-2.4.1 \
-    crate://crates.io/syn/1.0.98;name=syn-1.0.98 \
-    crate://crates.io/syslog/4.0.1;name=syslog-4.0.1 \
-    crate://crates.io/target-lexicon/0.12.4;name=target-lexicon-0.12.4 \
-    crate://crates.io/tempfile/3.3.0;name=tempfile-3.3.0 \
-    crate://crates.io/term/0.7.0;name=term-0.7.0 \
-    crate://crates.io/termcolor/1.1.3;name=termcolor-1.1.3 \
-    crate://crates.io/textwrap/0.11.0;name=textwrap-0.11.0 \
-    crate://crates.io/thiserror/1.0.31;name=thiserror-1.0.31 \
-    crate://crates.io/thiserror-impl/1.0.31;name=thiserror-impl-1.0.31 \
-    crate://crates.io/thread_local/1.1.4;name=thread_local-1.1.4 \
-    crate://crates.io/time/0.1.44;name=time-0.1.44 \
-    crate://crates.io/tiny-keccak/2.0.2;name=tiny-keccak-2.0.2 \
-    crate://crates.io/tiny_http/0.8.2;name=tiny_http-0.8.2 \
-    crate://crates.io/tinyvec/1.6.0;name=tinyvec-1.6.0 \
-    crate://crates.io/tinyvec_macros/0.1.0;name=tinyvec_macros-0.1.0 \
-    crate://crates.io/tokio/1.20.4;name=tokio-1.20.4 \
-    crate://crates.io/tokio-macros/1.8.0;name=tokio-macros-1.8.0 \
-    crate://crates.io/tokio-native-tls/0.3.0;name=tokio-native-tls-0.3.0 \
-    crate://crates.io/tokio-rustls/0.22.0;name=tokio-rustls-0.22.0 \
-    crate://crates.io/tokio-util/0.7.3;name=tokio-util-0.7.3 \
-    crate://crates.io/toml/0.5.9;name=toml-0.5.9 \
-    crate://crates.io/tower-service/0.3.2;name=tower-service-0.3.2 \
-    crate://crates.io/tracing/0.1.35;name=tracing-0.1.35 \
-    crate://crates.io/tracing-attributes/0.1.22;name=tracing-attributes-0.1.22 \
-    crate://crates.io/tracing-core/0.1.28;name=tracing-core-0.1.28 \
-    crate://crates.io/tracing-log/0.1.3;name=tracing-log-0.1.3 \
-    crate://crates.io/tracing-serde/0.1.3;name=tracing-serde-0.1.3 \
-    crate://crates.io/tracing-subscriber/0.2.25;name=tracing-subscriber-0.2.25 \
-    crate://crates.io/trait-set/0.2.0;name=trait-set-0.2.0 \
-    crate://crates.io/try-lock/0.2.3;name=try-lock-0.2.3 \
-    crate://crates.io/typenum/1.15.0;name=typenum-1.15.0 \
-    crate://crates.io/unicode-bidi/0.3.8;name=unicode-bidi-0.3.8 \
-    crate://crates.io/unicode-ident/1.0.2;name=unicode-ident-1.0.2 \
-    crate://crates.io/unicode-normalization/0.1.21;name=unicode-normalization-0.1.21 \
-    crate://crates.io/unicode-width/0.1.9;name=unicode-width-0.1.9 \
-    crate://crates.io/unicode-xid/0.2.3;name=unicode-xid-0.2.3 \
-    crate://crates.io/untrusted/0.7.1;name=untrusted-0.7.1 \
-    crate://crates.io/url/2.2.2;name=url-2.2.2 \
-    crate://crates.io/urlparse/0.7.3;name=urlparse-0.7.3 \
-    crate://crates.io/uuid/1.1.2;name=uuid-1.1.2 \
-    crate://crates.io/valuable/0.1.0;name=valuable-0.1.0 \
-    crate://crates.io/vcpkg/0.2.15;name=vcpkg-0.2.15 \
-    crate://crates.io/vec_map/0.8.2;name=vec_map-0.8.2 \
-    crate://crates.io/version_check/0.9.4;name=version_check-0.9.4 \
-    crate://crates.io/want/0.3.0;name=want-0.3.0 \
-    crate://crates.io/wasi/0.10.0+wasi-snapshot-preview1;name=wasi-0.10.0+wasi-snapshot-preview1 \
-    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1;name=wasi-0.11.0+wasi-snapshot-preview1 \
-    crate://crates.io/wasm-bindgen/0.2.81;name=wasm-bindgen-0.2.81 \
-    crate://crates.io/wasm-bindgen-backend/0.2.81;name=wasm-bindgen-backend-0.2.81 \
-    crate://crates.io/wasm-bindgen-futures/0.4.31;name=wasm-bindgen-futures-0.4.31 \
-    crate://crates.io/wasm-bindgen-macro/0.2.81;name=wasm-bindgen-macro-0.2.81 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.81;name=wasm-bindgen-macro-support-0.2.81 \
-    crate://crates.io/wasm-bindgen-shared/0.2.81;name=wasm-bindgen-shared-0.2.81 \
-    crate://crates.io/web-sys/0.3.58;name=web-sys-0.3.58 \
-    crate://crates.io/webpki/0.21.4;name=webpki-0.21.4 \
-    crate://crates.io/winapi/0.3.9;name=winapi-0.3.9 \
-    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0;name=winapi-i686-pc-windows-gnu-0.4.0 \
-    crate://crates.io/winapi-util/0.1.5;name=winapi-util-0.1.5 \
-    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0;name=winapi-x86_64-pc-windows-gnu-0.4.0 \
-    crate://crates.io/windows-sys/0.36.1;name=windows-sys-0.36.1 \
-    crate://crates.io/windows_aarch64_msvc/0.36.1;name=windows_aarch64_msvc-0.36.1 \
-    crate://crates.io/windows_i686_gnu/0.36.1;name=windows_i686_gnu-0.36.1 \
-    crate://crates.io/windows_i686_msvc/0.36.1;name=windows_i686_msvc-0.36.1 \
-    crate://crates.io/windows_x86_64_gnu/0.36.1;name=windows_x86_64_gnu-0.36.1 \
-    crate://crates.io/windows_x86_64_msvc/0.36.1;name=windows_x86_64_msvc-0.36.1 \
-    crate://crates.io/winreg/0.10.1;name=winreg-0.10.1 \
+    crate://crates.io/adler32/1.2.0 \
+    crate://crates.io/aho-corasick/1.1.5 \
+    crate://crates.io/allocator-api2/0.2.21 \
+    crate://crates.io/android_system_properties/0.1.6 \
+    crate://crates.io/anstream/1.0.0 \
+    crate://crates.io/anstyle/1.0.14 \
+    crate://crates.io/anstyle-parse/1.0.0 \
+    crate://crates.io/anstyle-query/1.1.5 \
+    crate://crates.io/anstyle-wincon/3.0.11 \
+    crate://crates.io/arc-swap/1.9.2 \
+    crate://crates.io/ascii-canvas/3.0.0 \
+    crate://crates.io/atomic-waker/1.1.2 \
+    crate://crates.io/autocfg/1.5.1 \
+    crate://crates.io/aws-lc-rs/1.18.1 \
+    crate://crates.io/aws-lc-sys/0.45.0 \
+    crate://crates.io/backoff/0.4.0 \
+    crate://crates.io/base16ct/0.2.0 \
+    crate://crates.io/base64/0.21.7 \
+    crate://crates.io/base64/0.22.1 \
+    crate://crates.io/base64/0.23.1 \
+    crate://crates.io/base64ct/1.8.3 \
+    crate://crates.io/basic-cookies/0.1.5 \
+    crate://crates.io/bcder/0.7.7 \
+    crate://crates.io/bit-set/0.5.3 \
+    crate://crates.io/bit-vec/0.6.3 \
+    crate://crates.io/bitflags/1.3.2 \
+    crate://crates.io/bitflags/2.13.2 \
+    crate://crates.io/block-buffer/0.10.4 \
+    crate://crates.io/bs58/0.5.1 \
+    crate://crates.io/bumpalo/3.20.3 \
+    crate://crates.io/bytes/1.12.1 \
+    crate://crates.io/cc/1.4.6 \
+    crate://crates.io/cfg-if/1.0.4 \
+    crate://crates.io/cfg_aliases/0.2.2 \
+    crate://crates.io/chacha20/0.10.2 \
+    crate://crates.io/chrono/0.4.45 \
+    crate://crates.io/cipher/0.4.4 \
+    crate://crates.io/clap/4.6.6 \
+    crate://crates.io/clap_builder/4.6.6 \
+    crate://crates.io/clap_derive/4.6.4 \
+    crate://crates.io/clap_lex/1.1.0 \
+    crate://crates.io/cmake/0.1.58 \
+    crate://crates.io/colorchoice/1.0.5 \
+    crate://crates.io/combine/4.6.8 \
+    crate://crates.io/const-oid/0.9.6 \
+    crate://crates.io/core-foundation/0.9.4 \
+    crate://crates.io/core-foundation/0.10.1 \
+    crate://crates.io/core-foundation-sys/0.8.7 \
+    crate://crates.io/core_detect/1.0.0 \
+    crate://crates.io/cpufeatures/0.2.17 \
+    crate://crates.io/cpufeatures/0.3.1 \
+    crate://crates.io/crc32fast/1.5.2 \
+    crate://crates.io/crunchy/0.2.4 \
+    crate://crates.io/crypto-bigint/0.5.5 \
+    crate://crates.io/crypto-common/0.1.7 \
+    crate://crates.io/cryptoki/0.12.0 \
+    crate://crates.io/cryptoki-sys/0.5.0 \
+    crate://crates.io/curve25519-dalek/4.1.3 \
+    crate://crates.io/curve25519-dalek-derive/0.1.1 \
+    crate://crates.io/darling/0.24.1 \
+    crate://crates.io/darling_core/0.24.1 \
+    crate://crates.io/darling_macro/0.24.1 \
+    crate://crates.io/dary_heap/0.3.9 \
+    crate://crates.io/defmt/1.1.1 \
+    crate://crates.io/defmt-macros/1.1.1 \
+    crate://crates.io/defmt-parser/1.0.0 \
+    crate://crates.io/der/0.7.10 \
+    crate://crates.io/deranged/0.5.8 \
+    crate://crates.io/digest/0.10.7 \
+    crate://crates.io/dirs-next/2.0.0 \
+    crate://crates.io/dirs-sys-next/0.1.2 \
+    crate://crates.io/displaydoc/0.2.7 \
+    crate://crates.io/dunce/1.0.5 \
+    crate://crates.io/dyn-clone/1.0.20 \
+    crate://crates.io/ecdsa/0.16.9 \
+    crate://crates.io/ed25519/2.2.3 \
+    crate://crates.io/ed25519-dalek/2.2.0 \
+    crate://crates.io/either/1.18.0 \
+    crate://crates.io/elliptic-curve/0.13.8 \
+    crate://crates.io/ena/0.14.4 \
+    crate://crates.io/encoding_rs/0.8.41 \
+    crate://crates.io/enum-display-derive/0.1.1 \
+    crate://crates.io/enum-flags/0.1.8 \
+    crate://crates.io/equivalent/1.0.2 \
+    crate://crates.io/errno/0.3.14 \
+    crate://crates.io/fastrand/2.5.0 \
+    crate://crates.io/fd-lock/4.0.4 \
+    crate://crates.io/fern/0.7.1 \
+    crate://crates.io/ff/0.13.1 \
+    crate://crates.io/fiat-crypto/0.2.9 \
+    crate://crates.io/filetime/0.2.29 \
+    crate://crates.io/find-msvc-tools/0.1.12 \
+    crate://crates.io/fixedbitset/0.4.2 \
+    crate://crates.io/fnv/1.0.7 \
+    crate://crates.io/foldhash/0.2.0 \
+    crate://crates.io/foreign-types/0.3.2 \
+    crate://crates.io/foreign-types-shared/0.1.1 \
+    crate://crates.io/form_urlencoded/1.2.2 \
+    crate://crates.io/fs_extra/1.3.0 \
+    crate://crates.io/futures-channel/0.3.34 \
+    crate://crates.io/futures-core/0.3.34 \
+    crate://crates.io/futures-macro/0.3.34 \
+    crate://crates.io/futures-sink/0.3.34 \
+    crate://crates.io/futures-task/0.3.34 \
+    crate://crates.io/futures-util/0.3.34 \
+    crate://crates.io/generic-array/0.14.7 \
+    crate://crates.io/getrandom/0.2.17 \
+    crate://crates.io/getrandom/0.4.3 \
+    crate://crates.io/group/0.13.0 \
+    crate://crates.io/h2/0.4.19 \
+    crate://crates.io/hashbrown/0.12.3 \
+    crate://crates.io/hashbrown/0.16.1 \
+    crate://crates.io/hashbrown/0.17.1 \
+    crate://crates.io/heck/0.5.0 \
+    crate://crates.io/hermit-abi/0.5.3 \
+    crate://crates.io/hex/0.4.3 \
+    crate://crates.io/hkdf/0.12.4 \
+    crate://crates.io/hmac/0.12.1 \
+    crate://crates.io/hostname/0.4.2 \
+    crate://crates.io/http/1.5.0 \
+    crate://crates.io/http-body/1.1.0 \
+    crate://crates.io/http-body-util/0.1.5 \
+    crate://crates.io/httparse/1.10.1 \
+    crate://crates.io/httpdate/1.0.3 \
+    crate://crates.io/hyper/1.11.1 \
+    crate://crates.io/hyper-rustls/0.27.9 \
+    crate://crates.io/hyper-util/0.1.20 \
+    crate://crates.io/iana-time-zone/0.1.65 \
+    crate://crates.io/iana-time-zone-haiku/0.1.2 \
+    crate://crates.io/icu_collections/2.3.0 \
+    crate://crates.io/icu_locale_core/2.3.0 \
+    crate://crates.io/icu_normalizer/2.3.0 \
+    crate://crates.io/icu_normalizer_data/2.3.0 \
+    crate://crates.io/icu_properties/2.3.0 \
+    crate://crates.io/icu_properties_data/2.3.0 \
+    crate://crates.io/icu_provider/2.3.1 \
+    crate://crates.io/ident_case/1.0.1 \
+    crate://crates.io/idna/1.1.0 \
+    crate://crates.io/idna_adapter/1.2.2 \
+    crate://crates.io/indexmap/1.9.3 \
+    crate://crates.io/indexmap/2.14.2 \
+    crate://crates.io/inout/0.1.4 \
+    crate://crates.io/instant/0.1.13 \
+    crate://crates.io/intervaltree/0.2.7 \
+    crate://crates.io/ipnet/2.12.2 \
+    crate://crates.io/is-terminal/0.4.17 \
+    crate://crates.io/is_terminal_polyfill/1.70.2 \
+    crate://crates.io/itertools/0.10.5 \
+    crate://crates.io/itertools/0.11.0 \
+    crate://crates.io/itoa/1.0.18 \
+    crate://crates.io/jiff/0.2.37 \
+    crate://crates.io/jiff-core/0.1.1 \
+    crate://crates.io/jiff-static/0.2.37 \
+    crate://crates.io/jiff-tzdb/0.1.8 \
+    crate://crates.io/jiff-tzdb-platform/0.1.3 \
+    crate://crates.io/jni/0.22.4 \
+    crate://crates.io/jni-macros/0.22.4 \
+    crate://crates.io/jni-sys/0.4.1 \
+    crate://crates.io/jni-sys-macros/0.4.1 \
+    crate://crates.io/jobserver/0.1.35 \
+    crate://crates.io/js-sys/0.3.105 \
+    crate://crates.io/kmip-protocol/0.4.3 \
+    crate://crates.io/kmip-ttlv/0.3.5 \
+    crate://crates.io/lalrpop/0.20.2 \
+    crate://crates.io/lalrpop-util/0.20.2 \
+    crate://crates.io/lazy_static/1.5.0 \
+    crate://crates.io/libc/0.2.189 \
+    crate://crates.io/libflate/2.3.2 \
+    crate://crates.io/libflate_lz77/2.3.0 \
+    crate://crates.io/libloading/0.8.9 \
+    crate://crates.io/libm/0.2.16 \
+    crate://crates.io/libredox/0.1.24 \
+    crate://crates.io/linux-raw-sys/0.12.1 \
+    crate://crates.io/litemap/0.8.3 \
+    crate://crates.io/lock_api/0.4.14 \
+    crate://crates.io/log/0.4.34 \
+    crate://crates.io/lru-slab/0.1.2 \
+    crate://crates.io/maybe-async/0.2.11 \
+    crate://crates.io/memchr/2.8.3 \
+    crate://crates.io/mime/0.3.17 \
+    crate://crates.io/mio/1.2.3 \
+    crate://crates.io/multiversion/0.9.0 \
+    crate://crates.io/multiversion-macros/0.9.0 \
+    crate://crates.io/multiversion_no_op/1.0.0 \
+    crate://crates.io/new_debug_unreachable/1.0.6 \
+    crate://crates.io/nix/0.31.3 \
+    crate://crates.io/no_std_io2/0.9.4 \
+    crate://crates.io/num-bigint-dig/0.8.6 \
+    crate://crates.io/num-conv/0.2.2 \
+    crate://crates.io/num-integer/0.1.47 \
+    crate://crates.io/num-iter/0.1.46 \
+    crate://crates.io/num-traits/0.2.19 \
+    crate://crates.io/num_threads/0.1.7 \
+    crate://crates.io/oauth2/5.0.0 \
+    crate://crates.io/once_cell/1.21.4 \
+    crate://crates.io/once_cell_polyfill/1.70.2 \
+    crate://crates.io/openidconnect/4.0.1 \
+    crate://crates.io/openssl/0.10.81 \
+    crate://crates.io/openssl-macros/0.1.1 \
+    crate://crates.io/openssl-probe/0.2.1 \
+    crate://crates.io/openssl-sys/0.9.117 \
+    crate://crates.io/ordered-float/2.10.1 \
+    crate://crates.io/p256/0.13.2 \
+    crate://crates.io/p384/0.13.1 \
+    crate://crates.io/parking_lot/0.12.5 \
+    crate://crates.io/parking_lot_core/0.9.12 \
+    crate://crates.io/pbkdf2/0.12.2 \
+    crate://crates.io/pem-rfc7468/0.7.0 \
+    crate://crates.io/percent-encoding/2.3.2 \
+    crate://crates.io/petgraph/0.6.5 \
+    crate://crates.io/phf_shared/0.11.3 \
+    crate://crates.io/pico-args/0.5.0 \
+    crate://crates.io/pin-project-lite/0.2.17 \
+    crate://crates.io/pkcs1/0.7.5 \
+    crate://crates.io/pkcs8/0.10.2 \
+    crate://crates.io/pkg-config/0.3.34 \
+    crate://crates.io/portable-atomic/1.15.0 \
+    crate://crates.io/portable-atomic-util/0.2.8 \
+    crate://crates.io/potential_utf/0.1.6 \
+    crate://crates.io/powerfmt/0.2.0 \
+    crate://crates.io/ppv-lite86/0.2.21 \
+    crate://crates.io/precomputed-hash/0.1.1 \
+    crate://crates.io/primeorder/0.13.6 \
+    crate://crates.io/proc-macro2/1.0.107 \
+    crate://crates.io/quick-xml/0.39.4 \
+    crate://crates.io/quinn/0.11.11 \
+    crate://crates.io/quinn-proto/0.11.17 \
+    crate://crates.io/quinn-udp/0.5.15 \
+    crate://crates.io/quote/1.0.47 \
+    crate://crates.io/r-efi/6.0.0 \
+    crate://crates.io/r2d2/0.8.10 \
+    crate://crates.io/rand/0.8.8 \
+    crate://crates.io/rand/0.10.2 \
+    crate://crates.io/rand_chacha/0.3.1 \
+    crate://crates.io/rand_core/0.6.4 \
+    crate://crates.io/rand_core/0.10.1 \
+    crate://crates.io/rand_pcg/0.10.2 \
+    crate://crates.io/redox_syscall/0.5.18 \
+    crate://crates.io/redox_users/0.4.6 \
+    crate://crates.io/ref-cast/1.0.27 \
+    crate://crates.io/ref-cast-impl/1.0.27 \
+    crate://crates.io/regex/1.13.1 \
+    crate://crates.io/regex-automata/0.4.18 \
+    crate://crates.io/regex-syntax/0.8.11 \
+    crate://crates.io/reqwest/0.13.5 \
+    crate://crates.io/rfc6979/0.4.0 \
+    crate://crates.io/ring/0.17.14 \
+    crate://crates.io/rle-decode-fast/1.0.3 \
+    crate://crates.io/rpassword/7.5.4 \
+    crate://crates.io/rpki/0.19.3 \
+    crate://crates.io/rsa/0.9.10 \
+    crate://crates.io/rtoolbox/0.0.6 \
+    crate://crates.io/rustc-hash/2.1.3 \
+    crate://crates.io/rustc_version/0.4.1 \
+    crate://crates.io/rustix/1.1.4 \
+    crate://crates.io/rustls/0.23.44 \
+    crate://crates.io/rustls-native-certs/0.8.4 \
+    crate://crates.io/rustls-pemfile/2.2.0 \
+    crate://crates.io/rustls-pki-types/1.15.1 \
+    crate://crates.io/rustls-platform-verifier/0.7.0 \
+    crate://crates.io/rustls-platform-verifier-android/0.1.1 \
+    crate://crates.io/rustls-webpki/0.103.15 \
+    crate://crates.io/rustversion/1.0.23 \
+    crate://crates.io/salsa20/0.10.2 \
+    crate://crates.io/same-file/1.0.6 \
+    crate://crates.io/schannel/0.1.29 \
+    crate://crates.io/scheduled-thread-pool/0.2.7 \
+    crate://crates.io/schemars/0.9.0 \
+    crate://crates.io/schemars/1.2.2 \
+    crate://crates.io/scopeguard/1.2.0 \
+    crate://crates.io/scrypt/0.11.0 \
+    crate://crates.io/sec1/0.7.3 \
+    crate://crates.io/secrecy/0.10.3 \
+    crate://crates.io/security-framework/3.7.0 \
+    crate://crates.io/security-framework-sys/2.17.0 \
+    crate://crates.io/semver/1.0.28 \
+    crate://crates.io/serde/1.0.229 \
+    crate://crates.io/serde-value/0.7.0 \
+    crate://crates.io/serde_bytes/0.11.19 \
+    crate://crates.io/serde_core/1.0.229 \
+    crate://crates.io/serde_derive/1.0.229 \
+    crate://crates.io/serde_json/1.0.151 \
+    crate://crates.io/serde_path_to_error/0.1.20 \
+    crate://crates.io/serde_plain/1.0.2 \
+    crate://crates.io/serde_spanned/1.1.1 \
+    crate://crates.io/serde_with/3.23.0 \
+    crate://crates.io/serde_with_macros/3.23.0 \
+    crate://crates.io/sha2/0.10.9 \
+    crate://crates.io/shlex/2.0.1 \
+    crate://crates.io/signal-hook-registry/1.4.8 \
+    crate://crates.io/signature/2.2.0 \
+    crate://crates.io/simd_cesu8/1.2.0 \
+    crate://crates.io/simdutf8/0.1.5 \
+    crate://crates.io/siphasher/1.0.3 \
+    crate://crates.io/slab/0.4.12 \
+    crate://crates.io/smallvec/1.16.1 \
+    crate://crates.io/socket2/0.6.5 \
+    crate://crates.io/spin/0.9.9 \
+    crate://crates.io/spki/0.7.3 \
+    crate://crates.io/stable_deref_trait/1.2.1 \
+    crate://crates.io/stderrlog/0.6.0 \
+    crate://crates.io/string_cache/0.8.9 \
+    crate://crates.io/strsim/0.11.1 \
+    crate://crates.io/subtle/2.6.1 \
+    crate://crates.io/syn/1.0.109 \
+    crate://crates.io/syn/2.0.119 \
+    crate://crates.io/syn/3.0.5 \
+    crate://crates.io/sync_wrapper/1.0.2 \
+    crate://crates.io/synstructure/0.13.2 \
+    crate://crates.io/syslog/7.0.0 \
+    crate://crates.io/system-configuration/0.7.0 \
+    crate://crates.io/system-configuration-sys/0.6.0 \
+    crate://crates.io/tar/0.4.46 \
+    crate://crates.io/tempfile/3.27.0 \
+    crate://crates.io/term/0.7.0 \
+    crate://crates.io/termcolor/1.1.3 \
+    crate://crates.io/terminal_size/0.4.4 \
+    crate://crates.io/thiserror/1.0.69 \
+    crate://crates.io/thiserror/2.0.20 \
+    crate://crates.io/thiserror-impl/1.0.69 \
+    crate://crates.io/thiserror-impl/2.0.20 \
+    crate://crates.io/thread_local/1.1.10 \
+    crate://crates.io/time/0.3.55 \
+    crate://crates.io/time-core/0.1.9 \
+    crate://crates.io/time-macros/0.2.32 \
+    crate://crates.io/tiny-keccak/2.0.2 \
+    crate://crates.io/tinystr/0.8.4 \
+    crate://crates.io/tinyvec/1.13.2 \
+    crate://crates.io/tinyvec_macros/0.1.1 \
+    crate://crates.io/tokio/1.53.1 \
+    crate://crates.io/tokio-macros/2.7.2 \
+    crate://crates.io/tokio-rustls/0.26.5 \
+    crate://crates.io/tokio-util/0.7.19 \
+    crate://crates.io/toml/0.9.12+spec-1.1.0 \
+    crate://crates.io/toml_datetime/0.7.5+spec-1.1.0 \
+    crate://crates.io/toml_parser/1.1.3+spec-1.1.0 \
+    crate://crates.io/toml_writer/1.1.2+spec-1.1.0 \
+    crate://crates.io/tower/0.5.3 \
+    crate://crates.io/tower-http/0.6.11 \
+    crate://crates.io/tower-layer/0.3.3 \
+    crate://crates.io/tower-service/0.3.3 \
+    crate://crates.io/tracing/0.1.44 \
+    crate://crates.io/tracing-core/0.1.36 \
+    crate://crates.io/trait-set/0.2.0 \
+    crate://crates.io/try-lock/0.2.5 \
+    crate://crates.io/typenum/1.20.1 \
+    crate://crates.io/unicode-ident/1.0.24 \
+    crate://crates.io/unicode-normalization/0.1.25 \
+    crate://crates.io/unicode-xid/0.2.6 \
+    crate://crates.io/untrusted/0.9.0 \
+    crate://crates.io/url/2.5.8 \
+    crate://crates.io/urlparse/0.7.3 \
+    crate://crates.io/utf8_iter/1.0.4 \
+    crate://crates.io/utf8parse/0.2.2 \
+    crate://crates.io/uuid/1.26.1 \
+    crate://crates.io/vcpkg/0.2.15 \
+    crate://crates.io/version_check/0.9.5 \
+    crate://crates.io/walkdir/2.5.0 \
+    crate://crates.io/want/0.3.1 \
+    crate://crates.io/wasi/0.11.1+wasi-snapshot-preview1 \
+    crate://crates.io/wasm-bindgen/0.2.128 \
+    crate://crates.io/wasm-bindgen-futures/0.4.78 \
+    crate://crates.io/wasm-bindgen-macro/0.2.128 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.128 \
+    crate://crates.io/wasm-bindgen-shared/0.2.128 \
+    crate://crates.io/web-sys/0.3.105 \
+    crate://crates.io/web-time/1.1.0 \
+    crate://crates.io/webpki-root-certs/1.0.9 \
+    crate://crates.io/winapi/0.3.9 \
+    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+    crate://crates.io/winapi-util/0.1.11 \
+    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+    crate://crates.io/windows-core/0.62.2 \
+    crate://crates.io/windows-implement/0.60.2 \
+    crate://crates.io/windows-interface/0.59.3 \
+    crate://crates.io/windows-link/0.2.1 \
+    crate://crates.io/windows-registry/0.6.1 \
+    crate://crates.io/windows-result/0.4.1 \
+    crate://crates.io/windows-strings/0.5.1 \
+    crate://crates.io/windows-sys/0.52.0 \
+    crate://crates.io/windows-sys/0.59.0 \
+    crate://crates.io/windows-sys/0.61.2 \
+    crate://crates.io/windows-targets/0.52.6 \
+    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
+    crate://crates.io/windows_aarch64_msvc/0.52.6 \
+    crate://crates.io/windows_i686_gnu/0.52.6 \
+    crate://crates.io/windows_i686_gnullvm/0.52.6 \
+    crate://crates.io/windows_i686_msvc/0.52.6 \
+    crate://crates.io/windows_x86_64_gnu/0.52.6 \
+    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
+    crate://crates.io/windows_x86_64_msvc/0.52.6 \
+    crate://crates.io/winnow/0.7.15 \
+    crate://crates.io/winnow/1.0.4 \
+    crate://crates.io/writeable/0.6.4 \
+    crate://crates.io/xattr/1.6.1 \
+    crate://crates.io/yoke/0.8.3 \
+    crate://crates.io/yoke-derive/0.8.2 \
+    crate://crates.io/zerocopy/0.8.57 \
+    crate://crates.io/zerocopy-derive/0.8.57 \
+    crate://crates.io/zerofrom/0.1.8 \
+    crate://crates.io/zerofrom-derive/0.1.7 \
+    crate://crates.io/zeroize/1.9.0 \
+    crate://crates.io/zerotrie/0.2.5 \
+    crate://crates.io/zerovec/0.11.8 \
+    crate://crates.io/zerovec-derive/0.11.6 \
+    crate://crates.io/zmij/1.0.23 \
 "
 
-SRC_URI[addr2line-0.17.0.sha256sum] = "b9ecd88a8c8378ca913a680cd98f0f13ac67383d35993f86c90a70e3f137816b"
-SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
 SRC_URI[adler32-1.2.0.sha256sum] = "aae1277d39aeec15cb388266ecc24b11c80469deae6067e17a1a7aa9e5c1f234"
-SRC_URI[aho-corasick-0.7.18.sha256sum] = "1e37cfd5e7657ada45f742d6e99ca5788580b5c529dc78faf11ece6dc702656f"
-SRC_URI[android_system_properties-0.1.5.sha256sum] = "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
-SRC_URI[ansi_term-0.12.1.sha256sum] = "d52a9bb7ec0cf484c551830a7ce27bd20d67eac647e1befb56b0be4ee39a55d2"
-SRC_URI[ascii-1.0.0.sha256sum] = "bbf56136a5198c7b01a49e3afcbef6cf84597273d298f54432926024107b0109"
+SRC_URI[aho-corasick-1.1.5.sha256sum] = "c982642fa9e8606056828ee9a8505737230110bb1099153c79efe865c59d12ba"
+SRC_URI[allocator-api2-0.2.21.sha256sum] = "683d7910e743518b0e34f1186f92494becacb047c7b6bf616c96772180fef923"
+SRC_URI[android_system_properties-0.1.6.sha256sum] = "ae221649c9976a6f6c56ae1facf410f3ddb33cc661c4b7b61020a912d4237fbc"
+SRC_URI[anstream-1.0.0.sha256sum] = "824a212faf96e9acacdbd09febd34438f8f711fb84e09a8916013cd7815ca28d"
+SRC_URI[anstyle-1.0.14.sha256sum] = "940b3a0ca603d1eade50a4846a2afffd5ef57a9feac2c0e2ec2e14f9ead76000"
+SRC_URI[anstyle-parse-1.0.0.sha256sum] = "52ce7f38b242319f7cabaa6813055467063ecdc9d355bbb4ce0c68908cd8130e"
+SRC_URI[anstyle-query-1.1.5.sha256sum] = "40c48f72fd53cd289104fc64099abca73db4166ad86ea0b4341abe65af83dadc"
+SRC_URI[anstyle-wincon-3.0.11.sha256sum] = "291e6a250ff86cd4a820112fb8898808a366d8f9f58ce16d1f538353ad55747d"
+SRC_URI[arc-swap-1.9.2.sha256sum] = "c049c0be4daef0b145cb3555416b3b8ef5b7888a38aea1a3a155801fe7b0810b"
 SRC_URI[ascii-canvas-3.0.0.sha256sum] = "8824ecca2e851cec16968d54a01dd372ef8f95b244fb84b84e70128be347c3c6"
-SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8"
-SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
-SRC_URI[backoff-0.3.0.sha256sum] = "9fe17f59a06fe8b87a6fc8bf53bb70b3aba76d7685f432487a68cd5552853625"
-SRC_URI[backtrace-0.3.66.sha256sum] = "cab84319d616cfb654d03394f38ab7e6f0919e181b1b57e1fd15e7fb4077d9a7"
-SRC_URI[base64-0.13.0.sha256sum] = "904dfeac50f3cdaba28fc6f57fdcddb75f49ed61346676a78c4ffe55877802fd"
-SRC_URI[basic-cookies-0.1.4.sha256sum] = "cb53b6b315f924c7f113b162e53b3901c05fc9966baf84d201dfcc7432a4bb38"
-SRC_URI[bcder-0.7.0.sha256sum] = "f007d8acfb8ef7d219911c7164c025a6d3504735120fc5df59c3c479ab84ea51"
-SRC_URI[bit-set-0.5.2.sha256sum] = "6e11e16035ea35e4e5997b393eacbf6f63983188f7a2ad25bfb13465f5ad59de"
+SRC_URI[atomic-waker-1.1.2.sha256sum] = "1505bd5d3d116872e7271a6d4e16d81d0c8570876c8de68093a09ac269d8aac0"
+SRC_URI[autocfg-1.5.1.sha256sum] = "f2032f911046de80f0a198e0901378627c33f59ea0ac00e363d481118bd70a53"
+SRC_URI[aws-lc-rs-1.18.1.sha256sum] = "b281d307588d634de920874890732659e2e7672f72b5e10e81badc1a8a83621e"
+SRC_URI[aws-lc-sys-0.45.0.sha256sum] = "9bff6c3b54fad79a2e60b8102caf565819711497c1f5f092f49508e2f5c31b27"
+SRC_URI[backoff-0.4.0.sha256sum] = "b62ddb9cb1ec0a098ad4bbf9344d0713fa193ae1a80af55febcff2627b6a00c1"
+SRC_URI[base16ct-0.2.0.sha256sum] = "4c7f02d4ea65f2c1853089ffd8d2787bdbc63de2f0d29dedbcf8ccdfa0ccd4cf"
+SRC_URI[base64-0.21.7.sha256sum] = "9d297deb1925b89f2ccc13d7635fa0714f12c87adce1c75356b39ca9b7178567"
+SRC_URI[base64-0.22.1.sha256sum] = "72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
+SRC_URI[base64-0.23.1.sha256sum] = "ac07cdecf99051d9a5238b80f35af32cdeba5b336e55d957b318b50137e18da5"
+SRC_URI[base64ct-1.8.3.sha256sum] = "2af50177e190e07a26ab74f8b1efbfe2ef87da2116221318cb1c2e82baf7de06"
+SRC_URI[basic-cookies-0.1.5.sha256sum] = "67bd8fd42c16bdb08688243dc5f0cc117a3ca9efeeaba3a345a18a6159ad96f7"
+SRC_URI[bcder-0.7.7.sha256sum] = "b593e5aeaf7992d388c08a9831c921cd703718064b3e50ba8e6d666d6cf86ca7"
+SRC_URI[bit-set-0.5.3.sha256sum] = "0700ddab506f33b20a03b13996eccd309a48e5ff77d0d95926aa0210fb4e95f1"
 SRC_URI[bit-vec-0.6.3.sha256sum] = "349f9b6a179ed607305526ca489b34ad0a41aed5f7980fa90eb03160b69598fb"
 SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[block-buffer-0.9.0.sha256sum] = "4152116fd6e9dadb291ae18fc1ec3575ed6d84c29642d97890f4b4a3417297e4"
-SRC_URI[block-buffer-0.10.2.sha256sum] = "0bf7fe51849ea569fd452f37822f606a5cabb684dc918707a0193fd4664ff324"
-SRC_URI[bumpalo-3.10.0.sha256sum] = "37ccbd214614c6783386c1af30caf03192f17891059cecc394b4fb119e363de3"
-SRC_URI[bytes-1.1.0.sha256sum] = "c4872d67bab6358e59559027aa3b9157c53d9358c51423c17554809a8858e0f8"
-SRC_URI[cc-1.0.73.sha256sum] = "2fff2a6927b3bb87f9595d67196a70493f627687a71d87a0d692242c33f58c11"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[chrono-0.4.22.sha256sum] = "bfd4d1b31faaa3a89d7934dbded3111da0d2ef28e3ebccdb4f0179f5929d1ef1"
-SRC_URI[chunked_transfer-1.4.0.sha256sum] = "fff857943da45f546682664a79488be82e69e43c1a7a2307679ab9afb3a66d2e"
-SRC_URI[cipher-0.2.5.sha256sum] = "12f8e7987cbd042a63249497f41aed09f8e65add917ea6566effbc56578d6801"
-SRC_URI[clap-2.34.0.sha256sum] = "a0610544180c38b88101fecf2dd634b174a62eef6946f84dfc6a7127512b381c"
-SRC_URI[codespan-reporting-0.11.1.sha256sum] = "3538270d33cc669650c4b093848450d380def10c331d38c768e34cac80576e6e"
-SRC_URI[core-foundation-0.9.3.sha256sum] = "194a7a9e6de53fa55116934067c844d9d749312f75c6f6d0980e8c252f8c2146"
-SRC_URI[core-foundation-sys-0.8.3.sha256sum] = "5827cebf4670468b8772dd191856768aedcb1b0278a04f989f7766351917b9dc"
-SRC_URI[cpufeatures-0.2.2.sha256sum] = "59a6001667ab124aebae2a495118e11d30984c3a653e99d86d58971708cf5e4b"
-SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
-SRC_URI[crunchy-0.2.2.sha256sum] = "7a81dae078cea95a014a339291cec439d2f232ebe854a9d672b796c6afafa9b7"
-SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
-SRC_URI[crypto-mac-0.10.1.sha256sum] = "bff07008ec701e8028e2ceb8f83f0e4274ee62bd2dbdc4fefff2e9a91824081a"
-SRC_URI[cryptoki-0.3.0.sha256sum] = "503aa2bd88796da9bc6baf2c47696da40f135721b3d6680c7c6cee0b7d1f7a59"
-SRC_URI[cryptoki-sys-0.1.4.sha256sum] = "1e4895bb04269df9a14f2692c6499dc2769e9a93caa33ef37c4df134f76956d2"
-SRC_URI[ctrlc-3.2.2.sha256sum] = "b37feaa84e6861e00a1f5e5aa8da3ee56d605c9992d33e082786754828e20865"
-SRC_URI[cxx-1.0.79.sha256sum] = "3f83d0ebf42c6eafb8d7c52f7e5f2d3003b89c7aa4fd2b79229209459a849af8"
-SRC_URI[cxx-build-1.0.79.sha256sum] = "07d050484b55975889284352b0ffc2ecbda25c0c55978017c132b29ba0818a86"
-SRC_URI[cxxbridge-flags-1.0.79.sha256sum] = "99d2199b00553eda8012dfec8d3b1c75fce747cf27c169a270b3b99e3448ab78"
-SRC_URI[cxxbridge-macro-1.0.79.sha256sum] = "dcb67a6de1f602736dd7eaead0080cf3435df806c61b24b13328db128c58868f"
-SRC_URI[derivative-2.2.0.sha256sum] = "fcc3dd5e9e9c0b295d6e1e4d811fb6f157d5ffd784b8d202fc62eac8035a770b"
-SRC_URI[deunicode-0.4.3.sha256sum] = "850878694b7933ca4c9569d30a34b55031b9b139ee1fc7b94a527c4ef960d690"
-SRC_URI[diff-0.1.13.sha256sum] = "56254986775e3233ffa9c4d7d3faaf6d36a2c09d30b20687e9f88bc8bafc16c8"
-SRC_URI[digest-0.9.0.sha256sum] = "d3dd60d1080a57a05ab032377049e0591415d2b31afd7028356dbf3cc6dcb066"
-SRC_URI[digest-0.10.3.sha256sum] = "f2fb860ca6fafa5552fb6d0e816a69c8e49f0908bf524e30a90d97c85892d506"
+SRC_URI[bitflags-2.13.2.sha256sum] = "3ded4057c258ba199e2d26386d3af3780957ecaee6c4ef4041c6b4b8b97c0b06"
+SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
+SRC_URI[bs58-0.5.1.sha256sum] = "bf88ba1141d185c399bee5288d850d63b8369520c1eafc32a0430b5b6c287bf4"
+SRC_URI[bumpalo-3.20.3.sha256sum] = "72f5acc6cb2ba439de613abc23857ec3d78374d8ed5ac84e9d11336e87da8649"
+SRC_URI[bytes-1.12.1.sha256sum] = "fc652a48c352aef3ea3aed32080501cf3ef6ed5da78602a020c991775b0aff04"
+SRC_URI[cc-1.4.6.sha256sum] = "a3eb0f42d6c360dc3f8a821f6bf2fdea7f72bfd36b3076eb0e6d1e9e0752fff4"
+SRC_URI[cfg-if-1.0.4.sha256sum] = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
+SRC_URI[cfg_aliases-0.2.2.sha256sum] = "f079e83a288787bcd14a6aea84cee5c87a67c5a3e660c30f557a3d24761b3527"
+SRC_URI[chacha20-0.10.2.sha256sum] = "65c35e4b699c7e15ccbe7ee35c005e4fc0a278d22238a2857e6ce2dadeda1b06"
+SRC_URI[chrono-0.4.45.sha256sum] = "1aa79e62e7697b8e29b513a68abacf485adcd1fe8284a4316c5ae868e6633327"
+SRC_URI[cipher-0.4.4.sha256sum] = "773f3b9af64447d2ce9850330c473515014aa235e6a783b02db81ff39e4a3dad"
+SRC_URI[clap-4.6.6.sha256sum] = "473c7e07f409a8d772161724aa8db6a765a2532a70f9667eeb7b49d3d02fbdca"
+SRC_URI[clap_builder-4.6.6.sha256sum] = "7b48fea5a88e9ae728a2dcbedbfc0e730f7d60da42e1cb049a83c9fb8b789889"
+SRC_URI[clap_derive-4.6.4.sha256sum] = "d012d2b9d65aca7f18f4d9878a045bc17899bba951561ba5ec3c2ba1eed9a061"
+SRC_URI[clap_lex-1.1.0.sha256sum] = "c8d4a3bb8b1e0c1050499d1815f5ab16d04f0959b233085fb31653fbfc9d98f9"
+SRC_URI[cmake-0.1.58.sha256sum] = "c0f78a02292a74a88ac736019ab962ece0bc380e3f977bf72e376c5d78ff0678"
+SRC_URI[colorchoice-1.0.5.sha256sum] = "1d07550c9036bf2ae0c684c4297d503f838287c83c53686d05370d0e139ae570"
+SRC_URI[combine-4.6.8.sha256sum] = "cfc320937d09e6de266b31b9afb480f197d7a861be86be7cb2ea7e5d1bfffc5e"
+SRC_URI[const-oid-0.9.6.sha256sum] = "c2459377285ad874054d797f3ccebf984978aa39129f6eafde5cdc8315b612f8"
+SRC_URI[core-foundation-0.9.4.sha256sum] = "91e195e091a93c46f7102ec7818a2aa394e1e1771c3ab4825963fa03e45afb8f"
+SRC_URI[core-foundation-0.10.1.sha256sum] = "b2a6cd9ae233e7f62ba4e9353e81a88df7fc8a5987b8d445b4d90c879bd156f6"
+SRC_URI[core-foundation-sys-0.8.7.sha256sum] = "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b"
+SRC_URI[core_detect-1.0.0.sha256sum] = "7f8f80099a98041a3d1622845c271458a2d73e688351bf3cb999266764b81d48"
+SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
+SRC_URI[cpufeatures-0.3.1.sha256sum] = "5ca28b0ae3115b884660db4118d803791fd6756b6e88f39c0f3f7859060d7566"
+SRC_URI[crc32fast-1.5.2.sha256sum] = "01a7799fd6b852db0e61728dde9a204c423b44d689dbd432522543614b490e78"
+SRC_URI[crunchy-0.2.4.sha256sum] = "460fbee9c2c2f33933d720630a6a0bac33ba7053db5344fac858d4b8952d77d5"
+SRC_URI[crypto-bigint-0.5.5.sha256sum] = "0dc92fb57ca44df6db8059111ab3af99a63d5d0f8375d9972e319a379c6bab76"
+SRC_URI[crypto-common-0.1.7.sha256sum] = "78c8292055d1c1df0cce5d180393dc8cce0abec0a7102adb6c7b1eef6016d60a"
+SRC_URI[cryptoki-0.12.0.sha256sum] = "ff765b99fc49f3116c9a908484486a2b92fd73c48da45c3a69716471c6cc56c6"
+SRC_URI[cryptoki-sys-0.5.0.sha256sum] = "f1fd850498411e4057f1cba79e6e2bc7cbe960544c1046ab46d4685c403a1121"
+SRC_URI[curve25519-dalek-4.1.3.sha256sum] = "97fb8b7c4503de7d6ae7b42ab72a5a59857b4c937ec27a3d4539dba95b5ab2be"
+SRC_URI[curve25519-dalek-derive-0.1.1.sha256sum] = "f46882e17999c6cc590af592290432be3bce0428cb0d5f8b6715e4dc7b383eb3"
+SRC_URI[darling-0.24.1.sha256sum] = "ed17f5901b6630b993ca003def43f2f8ef4014fc13b047b57aad617ff32bc2ec"
+SRC_URI[darling_core-0.24.1.sha256sum] = "6837e2cf7485aaae18f86181d2f0e9a7ed297a025e220aeabf63fdebd3a2ddff"
+SRC_URI[darling_macro-0.24.1.sha256sum] = "2ac7135c3ef02b2f7833bbeb1be5ba7f966dcde8a87c6b87f65a778d71a02785"
+SRC_URI[dary_heap-0.3.9.sha256sum] = "8b1e3a325bc115f096c8b77bbf027a7c2592230e70be2d985be950d3d5e60ebe"
+SRC_URI[defmt-1.1.1.sha256sum] = "e2953bfe4f93bbd20cc71198842756f77d161884c99ebbabc41d80231ded88d1"
+SRC_URI[defmt-macros-1.1.1.sha256sum] = "bad9c72e7ca2137e0dc3813245a0d282fd6daad32fd800af018306a9169b5fe8"
+SRC_URI[defmt-parser-1.0.0.sha256sum] = "10d60334b3b2e7c9d91ef8150abfb6fa4c1c39ebbcf4a81c2e346aad939fee3e"
+SRC_URI[der-0.7.10.sha256sum] = "e7c1832837b905bbfb5101e07cc24c8deddf52f93225eee6ead5f4d63d53ddcb"
+SRC_URI[deranged-0.5.8.sha256sum] = "7cd812cc2bc1d69d4764bd80df88b4317eaef9e773c75226407d9bc0876b211c"
+SRC_URI[digest-0.10.7.sha256sum] = "9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
 SRC_URI[dirs-next-2.0.0.sha256sum] = "b98cf8ebf19c3d1b223e151f99a4f9f0690dca41414773390fc824184ac833e1"
 SRC_URI[dirs-sys-next-0.1.2.sha256sum] = "4ebda144c4fe02d1f7ea1a7d9641b6fc6b580adcfa024ae48797ecdeb6825b4d"
-SRC_URI[either-1.7.0.sha256sum] = "3f107b87b6afc2a64fd13cac55fe06d6c8859f12d4b14cbcdd2c67d0976781be"
-SRC_URI[ena-0.14.0.sha256sum] = "d7402b94a93c24e742487327a7cd839dc9d36fec9de9fb25b09f2dae459f36c3"
-SRC_URI[encoding_rs-0.8.31.sha256sum] = "9852635589dc9f9ea1b6fe9f05b50ef208c85c834a562f0c6abb1c475736ec2b"
+SRC_URI[displaydoc-0.2.7.sha256sum] = "c6232dd377dcc64799954cbd3a9bb882e9cdc1308ccd87b1c098f1fb2eaf82a8"
+SRC_URI[dunce-1.0.5.sha256sum] = "92773504d58c093f6de2459af4af33faa518c13451eb8f2b5698ed3d36e7c813"
+SRC_URI[dyn-clone-1.0.20.sha256sum] = "d0881ea181b1df73ff77ffaaf9c7544ecc11e82fba9b5f27b262a3c73a332555"
+SRC_URI[ecdsa-0.16.9.sha256sum] = "ee27f32b5c5292967d2d4a9d7f1e0b0aed2c15daded5a60300e4abb9d8020bca"
+SRC_URI[ed25519-2.2.3.sha256sum] = "115531babc129696a58c64a4fef0a8bf9e9698629fb97e9e40767d235cfbcd53"
+SRC_URI[ed25519-dalek-2.2.0.sha256sum] = "70e796c081cee67dc755e1a36a0a172b897fab85fc3f6bc48307991f64e4eca9"
+SRC_URI[either-1.18.0.sha256sum] = "252afb9ae5eaa683babdc6a068b3f5726eb19e05070c731f9b2a23a7c3e8ed34"
+SRC_URI[elliptic-curve-0.13.8.sha256sum] = "b5e6043086bf7973472e0c7dff2142ea0b680d30e18d9cc40f267efbf222bd47"
+SRC_URI[ena-0.14.4.sha256sum] = "eabffdaee24bd1bf95c5ef7cec31260444317e72ea56c4c91750e8b7ee58d5f1"
+SRC_URI[encoding_rs-0.8.41.sha256sum] = "7b5ef0006ac9ab233c38522f5ae99cae3625151de8f706cacee1cba4b8e2832a"
 SRC_URI[enum-display-derive-0.1.1.sha256sum] = "f16ef37b2a9b242295d61a154ee91ae884afff6b8b933b486b12481cc58310ca"
 SRC_URI[enum-flags-0.1.8.sha256sum] = "3682d2328e61f5529088a02cd20bb0a9aeaeeeb2f26597436dd7d75d1340f8f5"
-SRC_URI[error-chain-0.11.0.sha256sum] = "ff511d5dc435d703f4971bc399647c9bc38e20cb41452e3b9feb4765419ed3f3"
-SRC_URI[fastrand-1.7.0.sha256sum] = "c3fcf0cee53519c866c09b5de1f6c56ff9d647101f81c1964fa632e148896cdf"
-SRC_URI[fern-0.5.9.sha256sum] = "e69ab0d5aca163e388c3a49d284fed6c3d0810700e77c5ae2756a50ec1a4daaa"
+SRC_URI[equivalent-1.0.2.sha256sum] = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
+SRC_URI[errno-0.3.14.sha256sum] = "39cab71617ae0d63f51a36d69f866391735b51691dbda63cf6f96d042b63efeb"
+SRC_URI[fastrand-2.5.0.sha256sum] = "da7c62ceae207dd37ea5b845da6a0696c799f85e97da1ab5b7910be3c1c80223"
+SRC_URI[fd-lock-4.0.4.sha256sum] = "0ce92ff622d6dadf7349484f42c93271a0d49b7cc4d466a936405bacbe10aa78"
+SRC_URI[fern-0.7.1.sha256sum] = "4316185f709b23713e41e3195f90edef7fb00c3ed4adc79769cf09cc762a3b29"
+SRC_URI[ff-0.13.1.sha256sum] = "c0b50bfb653653f9ca9095b427bed08ab8d75a137839d9ad64eb11810d5b6393"
+SRC_URI[fiat-crypto-0.2.9.sha256sum] = "28dea519a9695b9977216879a3ebfddf92f1c08c05d984f8996aecd6ecdc811d"
+SRC_URI[filetime-0.2.29.sha256sum] = "5c287a33c7f0a620c38e641e7f60827713987b3c0f26e8ddc9462cc69cf75759"
+SRC_URI[find-msvc-tools-0.1.12.sha256sum] = "3e0f1c7c3a72c66fd80abe965175f7523475c0489a87d3ff9d6e8c87d87a9d2d"
 SRC_URI[fixedbitset-0.4.2.sha256sum] = "0ce7134b9999ecaf8bcd65542e436736ef32ddca1b3e06094cb6ec5755203b80"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
+SRC_URI[foldhash-0.2.0.sha256sum] = "77ce24cb58228fbb8aa041425bb1050850ac19177686ea6e0f41a70416f56fdb"
 SRC_URI[foreign-types-0.3.2.sha256sum] = "f6f339eb8adc052cd2ca78910fda869aefa38d22d5cb648e6485e4d3fc06f3b1"
 SRC_URI[foreign-types-shared-0.1.1.sha256sum] = "00b0228411908ca8685dba7fc2cdd70ec9990a6e753e89b6ac91a84c40fbaf4b"
-SRC_URI[form_urlencoded-1.0.1.sha256sum] = "5fc25a87fa4fd2094bffb06925852034d90a17f0d1e05197d4956d3555752191"
-SRC_URI[fslock-0.2.1.sha256sum] = "04412b8935272e3a9bae6f48c7bfff74c2911f60525404edfdd28e49884c3bfb"
-SRC_URI[futures-0.3.21.sha256sum] = "f73fe65f54d1e12b726f517d3e2135ca3125a437b6d998caf1962961f7172d9e"
-SRC_URI[futures-channel-0.3.21.sha256sum] = "c3083ce4b914124575708913bca19bfe887522d6e2e6d0952943f5eac4a74010"
-SRC_URI[futures-core-0.3.21.sha256sum] = "0c09fd04b7e4073ac7156a9539b57a484a8ea920f79c7c675d05d289ab6110d3"
-SRC_URI[futures-executor-0.3.21.sha256sum] = "9420b90cfa29e327d0429f19be13e7ddb68fa1cccb09d65e5706b8c7a749b8a6"
-SRC_URI[futures-io-0.3.21.sha256sum] = "fc4045962a5a5e935ee2fdedaa4e08284547402885ab326734432bed5d12966b"
-SRC_URI[futures-macro-0.3.21.sha256sum] = "33c1e13800337f4d4d7a316bf45a567dbcb6ffe087f16424852d97e97a91f512"
-SRC_URI[futures-sink-0.3.21.sha256sum] = "21163e139fa306126e6eedaf49ecdb4588f939600f0b1e770f4205ee4b7fa868"
-SRC_URI[futures-task-0.3.21.sha256sum] = "57c66a976bf5909d801bbef33416c41372779507e7a6b3a5e25e4749c58f776a"
-SRC_URI[futures-util-0.3.21.sha256sum] = "d8b7abd5d659d9b90c8cba917f6ec750a74e2dc23902ef9cd4cc8c8b22e6036a"
-SRC_URI[generic-array-0.14.5.sha256sum] = "fd48d33ec7f05fbfa152300fdad764757cbded343c1aa1cff2fbaf4134851803"
-SRC_URI[getrandom-0.2.7.sha256sum] = "4eb1a864a501629691edf6c15a593b7a51eebaa1e8468e9ddc623de7c9b58ec6"
-SRC_URI[gimli-0.26.2.sha256sum] = "22030e2c5a68ec659fde1e949a745124b48e6fa8b045b7ed5bd1fe4ccc5c4e5d"
-SRC_URI[h2-0.3.13.sha256sum] = "37a82c6d637fc9515a4694bbf1cb2457b79d81ce52b3108bdeea58b07dd34a57"
+SRC_URI[form_urlencoded-1.2.2.sha256sum] = "cb4cb245038516f5f85277875cdaa4f7d2c9a0fa0468de06ed190163b1581fcf"
+SRC_URI[fs_extra-1.3.0.sha256sum] = "42703706b716c37f96a77aea830392ad231f44c9e9a67872fa5548707e11b11c"
+SRC_URI[futures-channel-0.3.34.sha256sum] = "b1f9e3d69d39e4862ffed03ed071a76f9a13ba1d9109d355b0f0aa6b15e393c4"
+SRC_URI[futures-core-0.3.34.sha256sum] = "92d699e522242e69e3003b94ecc1f960f3a5e015aa7c5d7486e65ad01dd94f5e"
+SRC_URI[futures-macro-0.3.34.sha256sum] = "9fb9654ba8355388abeb8dcb4fc62f511300867002afc858860463bdd9fe0c44"
+SRC_URI[futures-sink-0.3.34.sha256sum] = "1944426bf7d03f1d14f708785e4b33efd750b36d48a157b836b3efc15ede8e1d"
+SRC_URI[futures-task-0.3.34.sha256sum] = "cd417de3d1d015fc3bfd2b1ea46dfc7bab72ef86f1cc7cc9c78e728b34a6d1fd"
+SRC_URI[futures-util-0.3.34.sha256sum] = "0d50a92467f8ba5dd6e3ee5d4bd04d73ab2e4e1c44474a0674821dfce14b79bc"
+SRC_URI[generic-array-0.14.7.sha256sum] = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
+SRC_URI[getrandom-0.2.17.sha256sum] = "ff2abc00be7fca6ebc474524697ae276ad847ad0a6b3faa4bcb027e9a4614ad0"
+SRC_URI[getrandom-0.4.3.sha256sum] = "300e883d756b2e4ec94e02791f39b04b522276138852cfc41d9fb7e904106099"
+SRC_URI[group-0.13.0.sha256sum] = "f0f9ef7462f7c099f518d754361858f86d8a07af53ba9af0fe635bbccb151a63"
+SRC_URI[h2-0.4.19.sha256sum] = "ef8e5e5a340588f4452631496976cf8636d4a7ecf600239fdc27615d2530bc16"
 SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
-SRC_URI[hermit-abi-0.1.19.sha256sum] = "62b467343b94ba476dcb2500d242dadbb39557df889310ac77c5d99100aaac33"
+SRC_URI[hashbrown-0.16.1.sha256sum] = "841d1cc9bed7f9236f321df977030373f4a4163ae1a7dbfe1a51a2c1a51d9100"
+SRC_URI[hashbrown-0.17.1.sha256sum] = "ed5909b6e89a2db4456e54cd5f673791d7eca6732202bbf2a9cc504fe2f9b84a"
+SRC_URI[heck-0.5.0.sha256sum] = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
+SRC_URI[hermit-abi-0.5.3.sha256sum] = "e17592d60ebacc7d5e169f4663c5f84f9161cc90328abcfe8456f41e4dfcb284"
 SRC_URI[hex-0.4.3.sha256sum] = "7f24254aa9a54b5c858eaee2f5bccdb46aaf0e486a595ed5fd8f86ba55232a70"
-SRC_URI[hmac-0.10.1.sha256sum] = "c1441c6b1e930e2817404b5046f1f989899143a12bf92de603b69f4e0aee1e15"
-SRC_URI[http-0.2.8.sha256sum] = "75f43d41e26995c17e71ee126451dd3941010b0514a81a9d11f3b341debc2399"
-SRC_URI[http-body-0.4.5.sha256sum] = "d5f38f16d184e36f2408a55281cd658ecbd3ca05cce6d6510a176eca393e26d1"
-SRC_URI[httparse-1.7.1.sha256sum] = "496ce29bb5a52785b44e0f7ca2847ae0bb839c9bd28f69acac9b99d461c0c04c"
-SRC_URI[httpdate-1.0.2.sha256sum] = "c4a1e36c821dbe04574f602848a19f742f4fb3c98d40449f11bcad18d6b17421"
-SRC_URI[hyper-0.14.20.sha256sum] = "02c929dc5c39e335a03c405292728118860721b10190d98c2a0f0efd5baafbac"
-SRC_URI[hyper-tls-0.5.0.sha256sum] = "d6183ddfa99b85da61a140bea0efc93fdf56ceaa041b37d553518030827f9905"
-SRC_URI[iana-time-zone-0.1.51.sha256sum] = "f5a6ef98976b22b3b7f2f3a806f858cb862044cfa66805aa3ad84cb3d3b785ed"
-SRC_URI[iana-time-zone-haiku-0.1.1.sha256sum] = "0703ae284fc167426161c2e3f1da3ea71d94b21bedbcc9494e92b28e334e3dca"
-SRC_URI[idna-0.2.3.sha256sum] = "418a0a6fab821475f634efe3ccc45c013f742efe03d853e8d3355d5cb850ecf8"
-SRC_URI[impl-trait-for-tuples-0.2.2.sha256sum] = "11d7a9f6330b71fea57921c9b61c47ee6e84f72d394754eff6163ae67e7395eb"
-SRC_URI[indexmap-1.9.1.sha256sum] = "10a35a97730320ffe8e2d410b5d3b69279b98d2c14bdb8b70ea89ecf7888d41e"
-SRC_URI[instant-0.1.12.sha256sum] = "7a5bbe824c507c5da5956355e86a746d82e0e1464f65d862cc5e71da70e94b2c"
+SRC_URI[hkdf-0.12.4.sha256sum] = "7b5f8eb2ad728638ea2c7d47a21db23b7b58a72ed6a38256b8a1849f15fbbdf7"
+SRC_URI[hmac-0.12.1.sha256sum] = "6c49c37c09c17a53d937dfbb742eb3a961d65a994e6bcdcf37e7399d0cc8ab5e"
+SRC_URI[hostname-0.4.2.sha256sum] = "617aaa3557aef3810a6369d0a99fac8a080891b68bd9f9812a1eeda0c0730cbd"
+SRC_URI[http-1.5.0.sha256sum] = "918d3568bebf352712bc2ef3d46a8bcf1a75b373be6539de198e9105cbbf9ce0"
+SRC_URI[http-body-1.1.0.sha256sum] = "ca2a8f2913ee65f60facd6a5905613afaa448497a0230cc41ce022d93290bc2c"
+SRC_URI[http-body-util-0.1.5.sha256sum] = "23169fe34a5fbcdd3f3862e78fb9b6fccd5f02a6dc6f732547005d45631ce71c"
+SRC_URI[httparse-1.10.1.sha256sum] = "6dbf3de79e51f3d586ab4cb9d5c3e2c14aa28ed23d180cf89b4df0454a69cc87"
+SRC_URI[httpdate-1.0.3.sha256sum] = "df3b46402a9d5adb4c86a0cf463f42e19994e3ee891101b1841f30a545cb49a9"
+SRC_URI[hyper-1.11.1.sha256sum] = "27b501faa50e7a26c3d3560ca625132f4078a17771f4810baf70475ae48cbe43"
+SRC_URI[hyper-rustls-0.27.9.sha256sum] = "33ca68d021ef39cf6463ab54c1d0f5daf03377b70561305bb89a8f83aab66e0f"
+SRC_URI[hyper-util-0.1.20.sha256sum] = "96547c2556ec9d12fb1578c4eaf448b04993e7fb79cbaad930a656880a6bdfa0"
+SRC_URI[iana-time-zone-0.1.65.sha256sum] = "e31bc9ad994ba00e440a8aa5c9ef0ec67d5cb5e5cb0cc7f8b744a35b389cc470"
+SRC_URI[iana-time-zone-haiku-0.1.2.sha256sum] = "f31827a206f56af32e590ba56d5d2d085f558508192593743f16b2306495269f"
+SRC_URI[icu_collections-2.3.0.sha256sum] = "fa68d21081c4a05d5a901a1c62add574c77048b6a1c67be3b50ce0b60d4ca513"
+SRC_URI[icu_locale_core-2.3.0.sha256sum] = "d56e28588da92eee5c3201a6eff33fabdd49b62269c8938d4ff050ce4d900deb"
+SRC_URI[icu_normalizer-2.3.0.sha256sum] = "12f9cf5f235641ed274641dd81c3f28d870e276763d0797aeeab72317b1c646f"
+SRC_URI[icu_normalizer_data-2.3.0.sha256sum] = "1563da1ed3e0b3bf3d74c9b85917ac9c56464d2f57242270c09c9e752f8021a0"
+SRC_URI[icu_properties-2.3.0.sha256sum] = "7e7ca276ad3145661a65914e6daf131ca5120cd3dcee8f8f3214b8875184a148"
+SRC_URI[icu_properties_data-2.3.0.sha256sum] = "e590f038c1464a96894fd6d10127e90a8be4509f56ff7ecef851b15cee0b7caa"
+SRC_URI[icu_provider-2.3.1.sha256sum] = "d27bbb9d3abbefac45d55f647c9de1d44aafcd1186eb91879afef17c396c3e73"
+SRC_URI[ident_case-1.0.1.sha256sum] = "b9e0384b61958566e926dc50660321d12159025e767c18e043daf26b70104c39"
+SRC_URI[idna-1.1.0.sha256sum] = "3b0875f23caa03898994f6ddc501886a45c7d3d62d04d2d90788d47be1b1e4de"
+SRC_URI[idna_adapter-1.2.2.sha256sum] = "cb68373c0d6620ef8105e855e7745e18b0d00d3bdb07fb532e434244cdb9a714"
+SRC_URI[indexmap-1.9.3.sha256sum] = "bd070e393353796e801d209ad339e89596eb4c8d430d18ede6a1cced8fafbd99"
+SRC_URI[indexmap-2.14.2.sha256sum] = "cc4e190f5d26ca7051642629da2c52fc03bde85a03197c99408dcd291734c855"
+SRC_URI[inout-0.1.4.sha256sum] = "879f10e63c20629ecabbb64a8010319738c66a5cd0c29b02d63d272b03751d01"
+SRC_URI[instant-0.1.13.sha256sum] = "e0242819d153cba4b4b05a5a8f2a7e9bbf97b6055b2a002b395c96b5ff3c0222"
 SRC_URI[intervaltree-0.2.7.sha256sum] = "270bc34e57047cab801a8c871c124d9dc7132f6473c6401f645524f4e6edd111"
-SRC_URI[ipnet-2.5.0.sha256sum] = "879d54834c8c76457ef4293a689b2a8c59b076067ad77b15efafbb05f92a592b"
-SRC_URI[itertools-0.10.3.sha256sum] = "a9a9d19fa1e79b6215ff29b9d6880b706147f16e9b1dbb1e4e5947b5b02bc5e3"
-SRC_URI[itoa-1.0.2.sha256sum] = "112c678d4050afce233f4f2852bb2eb519230b3cf12f33585275537d7e41578d"
-SRC_URI[jmespatch-0.3.0.sha256sum] = "7acf91a732ade34d8eda2dee9500a051833f14f0d3d10d77c149845d6ac6a5f0"
-SRC_URI[js-sys-0.3.58.sha256sum] = "c3fac17f7123a73ca62df411b1bf727ccc805daa070338fda671c86dac1bdc27"
-SRC_URI[kmip-protocol-0.4.2.sha256sum] = "396744d490b405f4ff293057bae5625e03dcf8be70fd4ba8c6346a54e78fd837"
-SRC_URI[kmip-ttlv-0.3.3.sha256sum] = "1aa943fd7166db2cc2deaea17bd5c2862ccf68eef9ce15576bcee9e4b494685c"
-SRC_URI[lalrpop-0.19.8.sha256sum] = "b30455341b0e18f276fa64540aff54deafb54c589de6aca68659c63dd2d5d823"
-SRC_URI[lalrpop-util-0.19.8.sha256sum] = "bcf796c978e9b4d983414f4caedc9273aa33ee214c5b887bd55fde84c85d2dc4"
-SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[libc-0.2.126.sha256sum] = "349d5a591cd28b49e1d1037471617a32ddcda5731b99419008085f72d5a53836"
-SRC_URI[libflate-1.2.0.sha256sum] = "05605ab2bce11bcfc0e9c635ff29ef8b2ea83f29be257ee7d730cac3ee373093"
-SRC_URI[libflate_lz77-1.1.0.sha256sum] = "39a734c0493409afcd49deee13c006a04e3586b9761a03543c6272c9c51f2f5a"
-SRC_URI[libloading-0.7.3.sha256sum] = "efbc0f03f9a775e9f6aed295c6a1ba2253c5757a9e03d55c6caa46a681abcddd"
-SRC_URI[link-cplusplus-1.0.7.sha256sum] = "9272ab7b96c9046fbc5bc56c06c117cb639fe2d509df0c421cad82d2915cf369"
-SRC_URI[lock_api-0.4.7.sha256sum] = "327fa5b6a6940e4699ec49a9beae1ea4845c6bab9314e4f84ac68742139d8c53"
-SRC_URI[log-0.4.17.sha256sum] = "abb12e687cfb44aa40f41fc3978ef76448f9b6038cad6aef4259d3c095a2382e"
-SRC_URI[maplit-1.0.2.sha256sum] = "3e2e65a1a2e43cfcb47a895c4c8b10d1f4a61097f9f254f183aee60cad9c651d"
-SRC_URI[matchers-0.0.1.sha256sum] = "f099785f7595cc4b4553a174ce30dd7589ef93391ff414dbb67f62392b9e0ce1"
-SRC_URI[matches-0.1.9.sha256sum] = "a3e378b66a060d48947b590737b30a1be76706c8dd7b8ba0f2fe3989c68a853f"
-SRC_URI[maybe-async-0.2.6.sha256sum] = "6007f9dad048e0a224f27ca599d669fca8cfa0dac804725aab542b2eb032bce6"
-SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
-SRC_URI[mime-0.3.16.sha256sum] = "2a60c7ce501c71e03a9c9c0d35b861413ae925bd979cc7a4e30d060069aaac8d"
-SRC_URI[miniz_oxide-0.5.3.sha256sum] = "6f5c75688da582b8ffc1f1799e9db273f32133c49e048f614d22ec3256773ccc"
-SRC_URI[mio-0.8.4.sha256sum] = "57ee1c23c7c63b0c9250c339ffdc69255f110b298b901b9f6c82547b7b87caaf"
-SRC_URI[native-tls-0.2.10.sha256sum] = "fd7e2f3618557f980e0b17e8856252eee3c97fa12c54dff0ca290fb6266ca4a9"
-SRC_URI[new_debug_unreachable-1.0.4.sha256sum] = "e4a24736216ec316047a1fc4252e27dabb04218aa4a3f37c6e7ddbf1f9782b54"
-SRC_URI[nix-0.24.2.sha256sum] = "195cdbc1741b8134346d515b3a56a1c94b0912758009cfd53f99ea0f57b065fc"
-SRC_URI[num-bigint-0.4.3.sha256sum] = "f93ab6289c7b344a8a9f60f88d80aa20032336fe78da341afc91c8a2341fc75f"
-SRC_URI[num-integer-0.1.45.sha256sum] = "225d3389fb3509a24c93f5c29eb6bde2586b98d9f016636dff58d7c6f7569cd9"
-SRC_URI[num-traits-0.2.15.sha256sum] = "578ede34cf02f8924ab9447f50c28075b4d3e5b269972345e7e0372b38c6cdcd"
-SRC_URI[num_cpus-1.13.1.sha256sum] = "19e64526ebdee182341572e50e9ad03965aa510cd94427a4549448f285e957a1"
-SRC_URI[oauth2-4.2.3.sha256sum] = "6d62c436394991641b970a92e23e8eeb4eb9bca74af4f5badc53bcd568daadbd"
-SRC_URI[object-0.29.0.sha256sum] = "21158b2c33aa6d4561f1c0a6ea283ca92bc54802a93b263e910746d679a7eb53"
-SRC_URI[once_cell-1.13.0.sha256sum] = "18a6dbe30758c9f83eb00cbea4ac95966305f5a7772f3f42ebfc7fc7eddbd8e1"
-SRC_URI[opaque-debug-0.3.0.sha256sum] = "624a8340c38c1b80fd549087862da4ba43e08858af025b236e509b6649fc13d5"
-SRC_URI[openidconnect-2.3.2.sha256sum] = "e26afc60b2bf11b9a039db1f3a3c0d5fe201eebdbe646a8ecb8342c8240e3271"
-SRC_URI[openssl-0.10.41.sha256sum] = "618febf65336490dfcf20b73f885f5651a0c89c64c2d4a8c3662585a70bf5bd0"
-SRC_URI[openssl-macros-0.1.0.sha256sum] = "b501e44f11665960c7e7fcf062c7d96a14ade4aa98116c004b2e37b5be7d736c"
-SRC_URI[openssl-probe-0.1.5.sha256sum] = "ff011a302c396a5197692431fc1948019154afc178baf7d8e37367442a4601cf"
-SRC_URI[openssl-src-111.25.0+1.1.1t.sha256sum] = "3173cd3626c43e3854b1b727422a276e568d9ec5fe8cec197822cf52cfb743d6"
-SRC_URI[openssl-sys-0.9.75.sha256sum] = "e5f9bd0c2710541a3cda73d6f9ac4f1b240de4ae261065d309dbe73d9dceb42f"
-SRC_URI[ordered-float-2.10.0.sha256sum] = "7940cf2ca942593318d07fcf2596cdca60a85c9e7fab408a5e21a4f9dcd40d87"
-SRC_URI[oso-0.12.4.sha256sum] = "aec41e2da1ce3a82eb807396f802c172f08aa03e1be31e5df49592a04e12c8c7"
-SRC_URI[parking_lot-0.12.1.sha256sum] = "3742b2c103b9f06bc9fff0a37ff4912935851bee6d36f3c02bcc755bcfec228f"
-SRC_URI[parking_lot_core-0.9.3.sha256sum] = "09a279cbf25cb0757810394fbc1e359949b59e348145c643a939a525692e6929"
-SRC_URI[pbkdf2-0.7.5.sha256sum] = "bf916dd32dd26297907890d99dc2740e33f6bd9073965af4ccff2967962f5508"
-SRC_URI[percent-encoding-2.1.0.sha256sum] = "d4fd5641d01c8f18a23da7b6fe29298ff4b55afcccdf78973b24cf3175fee32e"
-SRC_URI[petgraph-0.6.2.sha256sum] = "e6d5014253a1331579ce62aa67443b4a658c5e7dd03d4bc6d302b94474888143"
-SRC_URI[phf_shared-0.10.0.sha256sum] = "b6796ad771acdc0123d2a88dc428b5e38ef24456743ddb1744ed628f9815c096"
-SRC_URI[pico-args-0.4.2.sha256sum] = "db8bcd96cb740d03149cbad5518db9fd87126a10ab519c011893b1754134c468"
-SRC_URI[pin-project-lite-0.2.9.sha256sum] = "e0a7ae3ac2f1173085d398531c705756c94a4c56843785df85a60c1a0afac116"
-SRC_URI[pin-utils-0.1.0.sha256sum] = "8b870d8c151b6f2fb93e84a13146138f05d02ed11c7e7c54f8826aaaf7c9f184"
-SRC_URI[pkg-config-0.3.25.sha256sum] = "1df8c4ec4b0627e53bdf214615ad287367e482558cf84b109250b37464dc03ae"
-SRC_URI[polar-core-0.12.4.sha256sum] = "53d2b6ee5b5ff6312ca55e2ba75fbd438c72bc041c799055388d815726eca69b"
-SRC_URI[ppv-lite86-0.2.16.sha256sum] = "eb9f9e6e233e5c4a35559a617bf40a4ec447db2e84c20b55a6f83167b7e57872"
+SRC_URI[ipnet-2.12.2.sha256sum] = "791930b43c0d5973160d90a8f3894509f2b273430f5c5c73b668636d0287c5c0"
+SRC_URI[is-terminal-0.4.17.sha256sum] = "3640c1c38b8e4e43584d8df18be5fc6b0aa314ce6ebf51b53313d4306cca8e46"
+SRC_URI[is_terminal_polyfill-1.70.2.sha256sum] = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
+SRC_URI[itertools-0.10.5.sha256sum] = "b0fd2260e829bddf4cb6ea802289de2f86d6a7a690192fbe91b3f46e0f2c8473"
+SRC_URI[itertools-0.11.0.sha256sum] = "b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57"
+SRC_URI[itoa-1.0.18.sha256sum] = "8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682"
+SRC_URI[jiff-0.2.37.sha256sum] = "0ab1baf72f08796de0260609515130699b890ac25f30e610ad894bc5856cafdb"
+SRC_URI[jiff-core-0.1.1.sha256sum] = "5e52fe76043ccecc9005d2305ebaadf7d7fc0cc89ca6baa10a94d6bc68c7128c"
+SRC_URI[jiff-static-0.2.37.sha256sum] = "378268a1116ad67ae6228701118ac9f491d78fda38a40a1f1a9e1348de6f7212"
+SRC_URI[jiff-tzdb-0.1.8.sha256sum] = "142bd39932ad231f10513df9ab62661fead8719872150b7ad02a2df79f4e141e"
+SRC_URI[jiff-tzdb-platform-0.1.3.sha256sum] = "875a5a69ac2bab1a891711cf5eccbec1ce0341ea805560dcd90b7a2e925132e8"
+SRC_URI[jni-0.22.4.sha256sum] = "5efd9a482cf3a427f00d6b35f14332adc7902ce91efb778580e180ff90fa3498"
+SRC_URI[jni-macros-0.22.4.sha256sum] = "a00109accc170f0bdb141fed3e393c565b6f5e072365c3bd58f5b062591560a3"
+SRC_URI[jni-sys-0.4.1.sha256sum] = "c6377a88cb3910bee9b0fa88d4f42e1d2da8e79915598f65fb0c7ee14c878af2"
+SRC_URI[jni-sys-macros-0.4.1.sha256sum] = "38c0b942f458fe50cdac086d2f946512305e5631e720728f2a61aabcd47a6264"
+SRC_URI[jobserver-0.1.35.sha256sum] = "1c00acbd29eabad4a2392fa0e921c874934dbbf4194312ad20f04a0ed67a3cb3"
+SRC_URI[js-sys-0.3.105.sha256sum] = "ce57d20d1ea864ce2ac172ab472d409214f4fd359f0b2a2775abdf522e2af99e"
+SRC_URI[kmip-protocol-0.4.3.sha256sum] = "aa5c6e91a4f36736ef47f650dc90d327b8be65f4acaf401bad389ce81c53ded5"
+SRC_URI[kmip-ttlv-0.3.5.sha256sum] = "13cdaafff68ae98da73fd6dff927095849646c6eeee44bdd0a983d30192cdeb1"
+SRC_URI[lalrpop-0.20.2.sha256sum] = "55cb077ad656299f160924eb2912aa147d7339ea7d69e1b5517326fdcec3c1ca"
+SRC_URI[lalrpop-util-0.20.2.sha256sum] = "507460a910eb7b32ee961886ff48539633b788a36b65692b95f225b844c82553"
+SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
+SRC_URI[libc-0.2.189.sha256sum] = "3eaf3ede3fee6db1a4c2ee091bf8a8b4dccdc6d17f656fb07896ee72867612f2"
+SRC_URI[libflate-2.3.2.sha256sum] = "561a8da1a50e1428d3c51321dafeca849df992a5bb67720c386131234caba82e"
+SRC_URI[libflate_lz77-2.3.0.sha256sum] = "ff7a10e427698aef6eef269482776debfef63384d30f13aad39a1a95e0e098fd"
+SRC_URI[libloading-0.8.9.sha256sum] = "d7c4b02199fee7c5d21a5ae7d8cfa79a6ef5bb2fc834d6e9058e89c825efdc55"
+SRC_URI[libm-0.2.16.sha256sum] = "b6d2cec3eae94f9f509c767b45932f1ada8350c4bdb85af2fcab4a3c14807981"
+SRC_URI[libredox-0.1.24.sha256sum] = "6480ccc157a1389bb2e4891b24751b0f798ba640d22386f23143fbcc89da195a"
+SRC_URI[linux-raw-sys-0.12.1.sha256sum] = "32a66949e030da00e8c7d4434b251670a91556f4144941d37452769c25d58a53"
+SRC_URI[litemap-0.8.3.sha256sum] = "47d9d19d1d6efa0109d2f65ff4c85cddd50bd572e5a00127ab10987290bcefae"
+SRC_URI[lock_api-0.4.14.sha256sum] = "224399e74b87b5f3557511d98dff8b14089b3dadafcab6bb93eab67d3aace965"
+SRC_URI[log-0.4.34.sha256sum] = "f9f8bd3e56ce4dfc153cf470fffbfa98c7620958b312ca5c3a4b8d5181fd13c6"
+SRC_URI[lru-slab-0.1.2.sha256sum] = "112b39cec0b298b6c1999fee3e31427f74f676e4cb9879ed1a121b43661a4154"
+SRC_URI[maybe-async-0.2.11.sha256sum] = "746873a384ad60adc5db74471dfaba74bd278afbdcfd81db93fafcdfc8b5ca0c"
+SRC_URI[memchr-2.8.3.sha256sum] = "cf8baf1c55e62ffcace7a9f06f4bd9cd3f0c4beb022d3b367256b91b87513d98"
+SRC_URI[mime-0.3.17.sha256sum] = "6877bb514081ee2a7ff5ef9de3281f14a4dd4bceac4c09388074a6b5df8a139a"
+SRC_URI[mio-1.2.3.sha256sum] = "4b18443e9c262bfe8fa82f51666e2642c53393f7e5c27b3e1aeab922cff5b9d8"
+SRC_URI[multiversion-0.9.0.sha256sum] = "b4ca4bea16ffc3f443cf7d866912118196bfef4c6a1556ca00f9f9b00bb43f7c"
+SRC_URI[multiversion-macros-0.9.0.sha256sum] = "0d416831a7317ef4b08bee00b69cbbb9c8763da7959a7026244d6266869f9c83"
+SRC_URI[multiversion_no_op-1.0.0.sha256sum] = "743fb55ba31b18fb1ecef6bdc9aa2743314978ac084044301a7eee33fb99a20d"
+SRC_URI[new_debug_unreachable-1.0.6.sha256sum] = "650eef8c711430f1a879fdd01d4745a7deea475becfb90269c06775983bbf086"
+SRC_URI[nix-0.31.3.sha256sum] = "cf20d2fde8ff38632c426f1165ed7436270b44f199fc55284c38276f9db47c3d"
+SRC_URI[no_std_io2-0.9.4.sha256sum] = "418abd1b6d34fbf6cae440dc874771b0525a604428704c76e48b29a5e67b8003"
+SRC_URI[num-bigint-dig-0.8.6.sha256sum] = "e661dda6640fad38e827a6d4a310ff4763082116fe217f279885c97f511bb0b7"
+SRC_URI[num-conv-0.2.2.sha256sum] = "521739c6d2bac4aa25192232afe6841231376b2b26d4d9fae5ecf8ca5772e441"
+SRC_URI[num-integer-0.1.47.sha256sum] = "7ce2d95d4b3734dc35aa2f45e1aa22cd416814592a4f9d9205e11affd5b8e10b"
+SRC_URI[num-iter-0.1.46.sha256sum] = "c92800bd69a1eac91786bcfe9da64a897eb72911b8dc3095decbd07429e8048b"
+SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
+SRC_URI[num_threads-0.1.7.sha256sum] = "5c7398b9c8b70908f6371f47ed36737907c87c52af34c268fed0bf0ceb92ead9"
+SRC_URI[oauth2-5.0.0.sha256sum] = "51e219e79014df21a225b1860a479e2dcd7cbd9130f4defd4bd0e191ea31d67d"
+SRC_URI[once_cell-1.21.4.sha256sum] = "9f7c3e4beb33f85d45ae3e3a1792185706c8e16d043238c593331cc7cd313b50"
+SRC_URI[once_cell_polyfill-1.70.2.sha256sum] = "384b8ab6d37215f3c5301a95a4accb5d64aa607f1fcb26a11b5303878451b4fe"
+SRC_URI[openidconnect-4.0.1.sha256sum] = "0d8c6709ba2ea764bbed26bce1adf3c10517113ddea6f2d4196e4851757ef2b2"
+SRC_URI[openssl-0.10.81.sha256sum] = "77823a27f0babb03091cb9ed9ef80af3b39dbc82f97e8fa530374b7dafd87a45"
+SRC_URI[openssl-macros-0.1.1.sha256sum] = "a948666b637a0f465e8564c73e89d4dde00d72d4d473cc972f390fc3dcee7d9c"
+SRC_URI[openssl-probe-0.2.1.sha256sum] = "7c87def4c32ab89d880effc9e097653c8da5d6ef28e6b539d313baaacfbafcbe"
+SRC_URI[openssl-sys-0.9.117.sha256sum] = "b47e7e6bb2c38cd930d25a23b40fa52e068c10e85f3e03a7f5ba5aaca5713695"
+SRC_URI[ordered-float-2.10.1.sha256sum] = "68f19d67e5a2795c94e73e0bb1cc1a7edeb2e28efd39e2e1c9b7a40c1108b11c"
+SRC_URI[p256-0.13.2.sha256sum] = "c9863ad85fa8f4460f9c48cb909d38a0d689dba1f6f6988a5e3e0d31071bcd4b"
+SRC_URI[p384-0.13.1.sha256sum] = "fe42f1670a52a47d448f14b6a5c61dd78fce51856e68edaa38f7ae3a46b8d6b6"
+SRC_URI[parking_lot-0.12.5.sha256sum] = "93857453250e3077bd71ff98b6a65ea6621a19bb0f559a85248955ac12c45a1a"
+SRC_URI[parking_lot_core-0.9.12.sha256sum] = "2621685985a2ebf1c516881c026032ac7deafcda1a2c9b7850dc81e3dfcb64c1"
+SRC_URI[pbkdf2-0.12.2.sha256sum] = "f8ed6a7761f76e3b9f92dfb0a60a6a6477c61024b775147ff0973a02653abaf2"
+SRC_URI[pem-rfc7468-0.7.0.sha256sum] = "88b39c9bfcfc231068454382784bb460aae594343fb030d46e9f50a645418412"
+SRC_URI[percent-encoding-2.3.2.sha256sum] = "9b4f627cb1b25917193a259e49bdad08f671f8d9708acfd5fe0a8c1455d87220"
+SRC_URI[petgraph-0.6.5.sha256sum] = "b4c5cc86750666a3ed20bdaf5ca2a0344f9c67674cae0515bec2da16fbaa47db"
+SRC_URI[phf_shared-0.11.3.sha256sum] = "67eabc2ef2a60eb7faa00097bd1ffdb5bd28e62bf39990626a582201b7a754e5"
+SRC_URI[pico-args-0.5.0.sha256sum] = "5be167a7af36ee22fe3115051bc51f6e6c7054c9348e28deb4f49bd6f705a315"
+SRC_URI[pin-project-lite-0.2.17.sha256sum] = "a89322df9ebe1c1578d689c92318e070967d1042b512afbe49518723f4e6d5cd"
+SRC_URI[pkcs1-0.7.5.sha256sum] = "c8ffb9f10fa047879315e6625af03c164b16962a5368d724ed16323b68ace47f"
+SRC_URI[pkcs8-0.10.2.sha256sum] = "f950b2377845cebe5cf8b5165cb3cc1a5e0fa5cfa3e1f7f55707d8fd82e0a7b7"
+SRC_URI[pkg-config-0.3.34.sha256sum] = "f6b464fbc74e149a392436b17d523f769e057cb6877f6a5c4618bc6f11800548"
+SRC_URI[portable-atomic-1.15.0.sha256sum] = "05c8b63e8d9609db387f0324918f81d68fe27748f084ef092fb35954d0539a85"
+SRC_URI[portable-atomic-util-0.2.8.sha256sum] = "10ab3eb7f3becc3a1cbc4f2c6f20267996cfc1a6467a873763411b136a122715"
+SRC_URI[potential_utf-0.1.6.sha256sum] = "d83eb9bc6d8e5cf568e7a1101d60ee05e81ed50ea106026f3d18deeb046d7661"
+SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
+SRC_URI[ppv-lite86-0.2.21.sha256sum] = "85eae3c4ed2f50dcfe72643da4befc30deadb458a9b590d720cde2f2b1e97da9"
 SRC_URI[precomputed-hash-0.1.1.sha256sum] = "925383efa346730478fb4838dbe9137d2a47675ad789c546d150a6e1dd4ab31c"
-SRC_URI[priority-queue-1.2.2.sha256sum] = "de9cde7493f5f5d2d163b174be9f9a72d756b79b0f6ed85654128d238c347c1e"
-SRC_URI[proc-macro2-1.0.40.sha256sum] = "dd96a1e8ed2596c337f8eae5f24924ec83f5ad5ab21ea8e455d3566c69fbcaf7"
-SRC_URI[quick-xml-0.23.0.sha256sum] = "9279fbdacaad3baf559d8cabe0acc3d06e30ea14931af31af79578ac0946decc"
-SRC_URI[quote-1.0.20.sha256sum] = "3bcdf212e9776fbcb2d23ab029360416bb1706b1aea2d1a5ba002727cbcab804"
+SRC_URI[primeorder-0.13.6.sha256sum] = "353e1ca18966c16d9deb1c69278edbc5f194139612772bd9537af60ac231e1e6"
+SRC_URI[proc-macro2-1.0.107.sha256sum] = "985e7ec9bb745e6ce6535b544d84d6cd6f7ad8bd711c398938ae983b91a766d9"
+SRC_URI[quick-xml-0.39.4.sha256sum] = "cdcc8dd4e2f670d309a5f0e83fe36dfdc05af317008fea29144da1a2ac858e5e"
+SRC_URI[quinn-0.11.11.sha256sum] = "0c1a41e437b6bbd489372cd4971de128e85c855f56c57f283d20ff016cf7c0a8"
+SRC_URI[quinn-proto-0.11.17.sha256sum] = "04759210543be93709136e28212294a659ef5001836ff4eab4d663e4529bba83"
+SRC_URI[quinn-udp-0.5.15.sha256sum] = "35a133f956daabe89a61a685c2649f13d82d5aa4bd5d12d1277e1072a21c0694"
+SRC_URI[quote-1.0.47.sha256sum] = "1fbf4db142a473a8d80c26bbf18454ed458bf8d26c8219c331daecfdbd079001"
+SRC_URI[r-efi-6.0.0.sha256sum] = "f8dcc9c7d52a811697d2151c701e0d08956f92b0e24136cf4cf27b57a6a0d9bf"
 SRC_URI[r2d2-0.8.10.sha256sum] = "51de85fb3fb6524929c8a2eb85e6b6d363de4e8c48f9e2c2eac4944abc181c93"
-SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
+SRC_URI[rand-0.8.8.sha256sum] = "e058c7de0b26af77780c769414d6257830bb240f3c38477dbc2c16e5f54d6d4c"
+SRC_URI[rand-0.10.2.sha256sum] = "c7f5fa3a058cd35567ef9bfa5e75732bee0f9e4c55fa90477bef2dfcdbc4be80"
 SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
-SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
-SRC_URI[redox_syscall-0.2.13.sha256sum] = "62f25bc4c7e55e0b0b7a1d43fb893f4fa1361d0abe38b9ce4f323c2adfe6ef42"
-SRC_URI[redox_users-0.4.3.sha256sum] = "b033d837a7cf162d7993aded9304e30a83213c648b6e389db233191f891e5c2b"
-SRC_URI[regex-1.6.0.sha256sum] = "4c4eb3267174b8c6c2f654116623910a0fef09c4753f8dd83db29c48a0df988b"
-SRC_URI[regex-automata-0.1.10.sha256sum] = "6c230d73fb8d8c1b9c0b3135c5142a8acee3a0558fb8db5cf1cb65f8d7862132"
-SRC_URI[regex-syntax-0.6.27.sha256sum] = "a3f87b73ce11b1619a3c6332f45341e0047173771e8b8b73f87bfeefb7b56244"
-SRC_URI[remove_dir_all-0.5.3.sha256sum] = "3acd125665422973a33ac9d3dd2df85edad0f4ae9b00dafb1a05e43a9f5ef8e7"
-SRC_URI[reqwest-0.11.11.sha256sum] = "b75aa69a3f06bbcc66ede33af2af253c6f7a86b1ca0033f60c580a27074fbf92"
-SRC_URI[ring-0.16.20.sha256sum] = "3053cf52e236a3ed746dfc745aa9cacf1b791d846bdaf412f60a8d7d6e17c8fc"
+SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
+SRC_URI[rand_core-0.10.1.sha256sum] = "63b8176103e19a2643978565ca18b50549f6101881c443590420e4dc998a3c69"
+SRC_URI[rand_pcg-0.10.2.sha256sum] = "caa0f4137e1c0a72f4c651489402276c8e8e1cf081f3b0ba156d2cbeef09e86a"
+SRC_URI[redox_syscall-0.5.18.sha256sum] = "ed2bf2547551a7053d6fdfafda3f938979645c44812fbfcda098faae3f1a362d"
+SRC_URI[redox_users-0.4.6.sha256sum] = "ba009ff324d1fc1b900bd1fdb31564febe58a8ccc8a6fdbb93b543d33b13ca43"
+SRC_URI[ref-cast-1.0.27.sha256sum] = "7e440fb4e4b4147295338efb76001ab9e4efc0e5839df2c47fc5ac2381d365c3"
+SRC_URI[ref-cast-impl-1.0.27.sha256sum] = "92ecd8964f8453721699a1ed72037b0db49ce2f5a5138486ee89bed6f67cdf3a"
+SRC_URI[regex-1.13.1.sha256sum] = "f020237b6c8eed93db2e2cb53c00c60a8e1bc73da7d073199a1180401450218d"
+SRC_URI[regex-automata-0.4.18.sha256sum] = "ad8553b9b26413251cbf30e620595c7a41b3887f03da04579c0e6b0d6a06b4b2"
+SRC_URI[regex-syntax-0.8.11.sha256sum] = "d6f6ff9a378485b298a5286656da665ba74413d36db0979633275d2e708145d4"
+SRC_URI[reqwest-0.13.5.sha256sum] = "16a1cfa75cc186dd73d5818e510e042e40927bccc9c236b061cea97e1eb08029"
+SRC_URI[rfc6979-0.4.0.sha256sum] = "f8dd2a808d456c4a54e300a23e9f5a67e122c3024119acbfd73e3bf664491cb2"
+SRC_URI[ring-0.17.14.sha256sum] = "a4689e6c2294d81e88dc6261c768b63bc4fcdb852be6d1352498b114f61383b7"
 SRC_URI[rle-decode-fast-1.0.3.sha256sum] = "3582f63211428f83597b51b2ddb88e2a91a9d52d12831f9d08f5e624e8977422"
-SRC_URI[routecore-0.2.0.sha256sum] = "9afd872857e85411c0ba7d18dfe650fc4864b292c02cde997e86c511314fdfc3"
-SRC_URI[rpassword-5.0.1.sha256sum] = "ffc936cf8a7ea60c58f030fd36a612a48f440610214dc54bc36431f9ea0c3efb"
-SRC_URI[rpki-0.15.8.sha256sum] = "46970b82ec6bfec47c88addaaef3d345cec2a5cf9cb89039ef904123e65ba41a"
-SRC_URI[rustc-demangle-0.1.21.sha256sum] = "7ef03e0a2b150c7a90d01faf6254c9c48a41e95fb2a8c2ac1c6f0d2b9aefc342"
-SRC_URI[rustc_version-0.4.0.sha256sum] = "bfa0f585226d2e68097d4f95d113b15b83a82e819ab25717ec0590d9584ef366"
-SRC_URI[rustls-0.19.1.sha256sum] = "35edb675feee39aec9c99fa5ff985081995a06d594114ae14cbe797ad7b7a6d7"
-SRC_URI[rustversion-1.0.8.sha256sum] = "24c8ad4f0c00e1eb5bc7614d236a7f1300e3dbd76b68cac8e06fb00b015ad8d8"
-SRC_URI[ryu-1.0.10.sha256sum] = "f3f6f92acf49d1b98f7a81226834412ada05458b7364277387724a237f062695"
-SRC_URI[salsa20-0.7.2.sha256sum] = "399f290ffc409596022fce5ea5d4138184be4784f2b28c62c59f0d8389059a15"
-SRC_URI[schannel-0.1.20.sha256sum] = "88d6731146462ea25d9244b2ed5fd1d716d25c52e4d54aa4fb0f3c4e9854dbe2"
-SRC_URI[scheduled-thread-pool-0.2.6.sha256sum] = "977a7519bff143a44f842fd07e80ad1329295bd71686457f18e496736f4bf9bf"
-SRC_URI[scopeguard-1.1.0.sha256sum] = "d29ab0c6d3fc0ee92fe66e2d99f700eab17a8d57d1c1d3b748380fb20baa78cd"
-SRC_URI[scratch-1.0.2.sha256sum] = "9c8132065adcfd6e02db789d9285a0deb2f3fcb04002865ab67d5fb103533898"
-SRC_URI[scrypt-0.6.5.sha256sum] = "19230d10daad7f163d8c1fc8edf84fbe52ac71c2ebe5adf3f763aa1557b843e3"
-SRC_URI[sct-0.6.1.sha256sum] = "b362b83898e0e69f38515b82ee15aa80636befe47c3b6d3d89a911e78fc228ce"
-SRC_URI[security-framework-2.6.1.sha256sum] = "2dc14f172faf8a0194a3aded622712b0de276821addc574fa54fc0a1167e10dc"
-SRC_URI[security-framework-sys-2.6.1.sha256sum] = "0160a13a177a45bfb43ce71c01580998474f556ad854dcbca936dd2841a5c556"
-SRC_URI[semver-1.0.12.sha256sum] = "a2333e6df6d6598f2b1974829f853c2b4c5f4a6e503c10af918081aa6f8564e1"
-SRC_URI[serde-1.0.139.sha256sum] = "0171ebb889e45aa68b44aee0859b3eede84c6f5f5c228e6f140c0b2a0a46cad6"
+SRC_URI[rpassword-7.5.4.sha256sum] = "2da316a15f47e3d053de9cb2c439650bd8fa4aaeb9365f2e5f27f492ff73c196"
+SRC_URI[rpki-0.19.3.sha256sum] = "9157a0b503ef5d3821bae79d2d4f44e1f5655eacdcc1b67623dd4403cd9ee302"
+SRC_URI[rsa-0.9.10.sha256sum] = "b8573f03f5883dcaebdfcf4725caa1ecb9c15b2ef50c43a07b816e06799bb12d"
+SRC_URI[rtoolbox-0.0.6.sha256sum] = "9a1efe12a1469752d0e6ff5ebec0b6ef4924cc5c4c71046b0ec730040535819d"
+SRC_URI[rustc-hash-2.1.3.sha256sum] = "6b1e7f9a428571be2dc5bc0505c13fb6bf936822b894ec87abf8a08a4e51742d"
+SRC_URI[rustc_version-0.4.1.sha256sum] = "cfcb3a22ef46e85b45de6ee7e79d063319ebb6594faafcf1c225ea92ab6e9b92"
+SRC_URI[rustix-1.1.4.sha256sum] = "b6fe4565b9518b83ef4f91bb47ce29620ca828bd32cb7e408f0062e9930ba190"
+SRC_URI[rustls-0.23.44.sha256sum] = "6725596c3f2c3a0aef021139e145d4eafe314a6623e4680ca83852b2c67ab2ba"
+SRC_URI[rustls-native-certs-0.8.4.sha256sum] = "dab5152771c58876a2146916e53e35057e1a4dfa2b9df0f0305b07f611fdea4d"
+SRC_URI[rustls-pemfile-2.2.0.sha256sum] = "dce314e5fee3f39953d46bb63bb8a46d40c2f8fb7cc5a3b6cab2bde9721d6e50"
+SRC_URI[rustls-pki-types-1.15.1.sha256sum] = "2f4925028c7eb5d1fcdaf196971378ed9d2c1c4efc7dc5d011256f76c99c0a96"
+SRC_URI[rustls-platform-verifier-0.7.0.sha256sum] = "26d1e2536ce4f35f4846aa13bff16bd0ff40157cdb14cc056c7b14ba41233ba0"
+SRC_URI[rustls-platform-verifier-android-0.1.1.sha256sum] = "f87165f0995f63a9fbeea62b64d10b4d9d8e78ec6d7d51fb2125fda7bb36788f"
+SRC_URI[rustls-webpki-0.103.15.sha256sum] = "f3c3cf1d8b1e7d4927e2d154c3fcb02979afb9939629c62cd9048d4f07b60ac2"
+SRC_URI[rustversion-1.0.23.sha256sum] = "cf54715a573b99ac80df0bc206da022bcd442c974952c7b9720069370852e21f"
+SRC_URI[salsa20-0.10.2.sha256sum] = "97a22f5af31f73a954c10289c93e8a50cc23d971e80ee446f1f6f7137a088213"
+SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
+SRC_URI[schannel-0.1.29.sha256sum] = "91c1b7e4904c873ef0710c1f407dde2e6287de2bebc1bbbf7d430bb7cbffd939"
+SRC_URI[scheduled-thread-pool-0.2.7.sha256sum] = "3cbc66816425a074528352f5789333ecff06ca41b36b0b0efdfbb29edc391a19"
+SRC_URI[schemars-0.9.0.sha256sum] = "4cd191f9397d57d581cddd31014772520aa448f65ef991055d7f61582c65165f"
+SRC_URI[schemars-1.2.2.sha256sum] = "687274d293b6cdc6e73e0fee520bf2049650090d7164f87672d212a3c530cf4a"
+SRC_URI[scopeguard-1.2.0.sha256sum] = "94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
+SRC_URI[scrypt-0.11.0.sha256sum] = "0516a385866c09368f0b5bcd1caff3366aace790fcd46e2bb032697bb172fd1f"
+SRC_URI[sec1-0.7.3.sha256sum] = "d3e97a565f76233a6003f9f5c54be1d9c5bdfa3eccfb189469f11ec4901c47dc"
+SRC_URI[secrecy-0.10.3.sha256sum] = "e891af845473308773346dc847b2c23ee78fe442e0472ac50e22a18a93d3ae5a"
+SRC_URI[security-framework-3.7.0.sha256sum] = "b7f4bc775c73d9a02cde8bf7b2ec4c9d12743edf609006c7facc23998404cd1d"
+SRC_URI[security-framework-sys-2.17.0.sha256sum] = "6ce2691df843ecc5d231c0b14ece2acc3efb62c0a398c7e1d875f3983ce020e3"
+SRC_URI[semver-1.0.28.sha256sum] = "8a7852d02fc848982e0c167ef163aaff9cd91dc640ba85e263cb1ce46fae51cd"
+SRC_URI[serde-1.0.229.sha256sum] = "4148590afebada386688f18773da617792bf2ef03ffc1e4cbd2b1d45b023e0ba"
 SRC_URI[serde-value-0.7.0.sha256sum] = "f3a1a3341211875ef120e117ea7fd5228530ae7e7036a779fdc9117be6b3282c"
-SRC_URI[serde_bytes-0.11.6.sha256sum] = "212e73464ebcde48d723aa02eb270ba62eff38a9b732df31f33f1b4e145f3a54"
-SRC_URI[serde_derive-1.0.139.sha256sum] = "dc1d3230c1de7932af58ad8ffbe1d784bd55efd5a9d84ac24f69c72d83543dfb"
-SRC_URI[serde_json-1.0.82.sha256sum] = "82c2c1fdcd807d1098552c5b9a36e425e42e9fbd7c6a37a8425f390f781f7fa7"
-SRC_URI[serde_path_to_error-0.1.7.sha256sum] = "d7868ad3b8196a8a0aea99a8220b124278ee5320a55e4fde97794b6f85b1a377"
-SRC_URI[serde_urlencoded-0.7.1.sha256sum] = "d3491c14715ca2294c4d6a88f15e84739788c1d030eed8c110436aafdaa2f3fd"
-SRC_URI[sha2-0.9.9.sha256sum] = "4d58a1e1bf39749807d89cf2d98ac2dfa0ff1cb3faa38fbb64dd88ac8013d800"
-SRC_URI[sha2-0.10.2.sha256sum] = "55deaec60f81eefe3cce0dc50bda92d6d8e88f2a27df7c5033b42afeb1ed2676"
-SRC_URI[sharded-slab-0.1.4.sha256sum] = "900fba806f70c630b0a382d0d825e17a0f19fcd059a2ade1ff237bcddf446b31"
-SRC_URI[signal-hook-registry-1.4.0.sha256sum] = "e51e73328dc4ac0c7ccbda3a494dfa03df1de2f46018127f60c693f2648455b0"
-SRC_URI[siphasher-0.3.10.sha256sum] = "7bd3e3206899af3f8b12af284fafc038cc1dc2b41d1b89dd17297221c5d225de"
-SRC_URI[slab-0.4.6.sha256sum] = "eb703cfe953bccee95685111adeedb76fabe4e97549a58d16f03ea7b9367bb32"
-SRC_URI[slug-0.1.4.sha256sum] = "b3bc762e6a4b6c6fcaade73e77f9ebc6991b676f88bb2358bddb56560f073373"
-SRC_URI[smallvec-1.9.0.sha256sum] = "2fd0db749597d91ff862fd1d55ea87f7855a744a8425a64695b6fca237d1dad1"
-SRC_URI[socket2-0.4.4.sha256sum] = "66d72b759436ae32898a2af0a14218dbf55efde3feeb170eb623637db85ee1e0"
-SRC_URI[spin-0.5.2.sha256sum] = "6e63cff320ae2c57904679ba7cb63280a3dc4613885beafb148ee7bf9aa9042d"
-SRC_URI[string_cache-0.8.4.sha256sum] = "213494b7a2b503146286049378ce02b482200519accc31872ee8be91fa820a08"
-SRC_URI[strsim-0.8.0.sha256sum] = "8ea5119cdb4c55b55d432abb513a0429384878c15dde60cc77b1c99de1a95a6a"
-SRC_URI[subtle-2.4.1.sha256sum] = "6bdef32e8150c2a081110b42772ffe7d7c9032b606bc226c8260fd97e0976601"
-SRC_URI[syn-1.0.98.sha256sum] = "c50aef8a904de4c23c788f104b7dddc7d6f79c647c7c8ce4cc8f73eb0ca773dd"
-SRC_URI[syslog-4.0.1.sha256sum] = "a0641142b4081d3d44beffa4eefd7346a228cdf91ed70186db2ca2cef762d327"
-SRC_URI[target-lexicon-0.12.4.sha256sum] = "c02424087780c9b71cc96799eaeddff35af2bc513278cda5c99fc1f5d026d3c1"
-SRC_URI[tempfile-3.3.0.sha256sum] = "5cdb1ef4eaeeaddc8fbd371e5017057064af0911902ef36b39801f67cc6d79e4"
+SRC_URI[serde_bytes-0.11.19.sha256sum] = "a5d440709e79d88e51ac01c4b72fc6cb7314017bb7da9eeff678aa94c10e3ea8"
+SRC_URI[serde_core-1.0.229.sha256sum] = "67dca2c9c51e58a4791a4b1ed58308b39c64224d349a935ab5039aa360942a48"
+SRC_URI[serde_derive-1.0.229.sha256sum] = "e7a5d71263a5a7d47b41f6b3f06ba276f10cc18b0931f1799f710578e2309348"
+SRC_URI[serde_json-1.0.151.sha256sum] = "c841b55ecdae098c80dcae9cf767f6f8a0c2cdb3416bbef72181df4d0fe73f14"
+SRC_URI[serde_path_to_error-0.1.20.sha256sum] = "10a9ff822e371bb5403e391ecd83e182e0e77ba7f6fe0160b795797109d1b457"
+SRC_URI[serde_plain-1.0.2.sha256sum] = "9ce1fc6db65a611022b23a0dec6975d63fb80a302cb3388835ff02c097258d50"
+SRC_URI[serde_spanned-1.1.1.sha256sum] = "6662b5879511e06e8999a8a235d848113e942c9124f211511b16466ee2995f26"
+SRC_URI[serde_with-3.23.0.sha256sum] = "935177bb8c0cd8ca1a4e6d1a2ac8988bea69cab4f9d3a31311e012ad27868ea4"
+SRC_URI[serde_with_macros-3.23.0.sha256sum] = "1d607aa01a3cb0ad757d6fd216136910db3c97b102fe686585689615a02dbcdc"
+SRC_URI[sha2-0.10.9.sha256sum] = "a7507d819769d01a365ab707794a4084392c824f54a7a6a7862f8c3d0892b283"
+SRC_URI[shlex-2.0.1.sha256sum] = "f8fadd59c855ef2080decdef8ff161eb6661b86933c9d82e5ba29dc602a55aba"
+SRC_URI[signal-hook-registry-1.4.8.sha256sum] = "c4db69cba1110affc0e9f7bcd48bbf87b3f4fc7c61fc9155afd4c469eb3d6c1b"
+SRC_URI[signature-2.2.0.sha256sum] = "77549399552de45a898a580c1b41d445bf730df867cc44e6c0233bbc4b8329de"
+SRC_URI[simd_cesu8-1.2.0.sha256sum] = "11031e251abf8611c80f460e19dbdeb54a66db918e49c65a7065b46ac7aec520"
+SRC_URI[simdutf8-0.1.5.sha256sum] = "e3a9fe34e3e7a50316060351f37187a3f546bce95496156754b601a5fa71b76e"
+SRC_URI[siphasher-1.0.3.sha256sum] = "8ee5873ec9cce0195efcb7a4e9507a04cd49aec9c83d0389df45b1ef7ba2e649"
+SRC_URI[slab-0.4.12.sha256sum] = "0c790de23124f9ab44544d7ac05d60440adc586479ce501c1d6d7da3cd8c9cf5"
+SRC_URI[smallvec-1.16.1.sha256sum] = "ba467056f1b547ed52077911161fc86985becbc60e8e1857c8a144dab0def891"
+SRC_URI[socket2-0.6.5.sha256sum] = "c3d1e2c7f27f8d4cb10542a02c49005dbd6e93095799d6f3be745fae9f8fedd4"
+SRC_URI[spin-0.9.9.sha256sum] = "3763264f6b73151db08c50ff20d7d8a0b8796e021cdea7ceedad07b80155fa0e"
+SRC_URI[spki-0.7.3.sha256sum] = "d91ed6c858b01f942cd56b37a94b3e0a1798290327d1236e4d9cf4eaca44d29d"
+SRC_URI[stable_deref_trait-1.2.1.sha256sum] = "6ce2be8dc25455e1f91df71bfa12ad37d7af1092ae736f3a6cd0e37bc7810596"
+SRC_URI[stderrlog-0.6.0.sha256sum] = "61c910772f992ab17d32d6760e167d2353f4130ed50e796752689556af07dc6b"
+SRC_URI[string_cache-0.8.9.sha256sum] = "bf776ba3fa74f83bf4b63c3dcbbf82173db2632ed8452cb2d891d33f459de70f"
+SRC_URI[strsim-0.11.1.sha256sum] = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70948a3f0b778838c5fb4f"
+SRC_URI[subtle-2.6.1.sha256sum] = "13c2bddecc57b384dee18652358fb23172facb8a2c51ccc10d74c157bdea3292"
+SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
+SRC_URI[syn-2.0.119.sha256sum] = "872831b642d1a07999a962a351ed35b955ea2cfc8f3862091e2a240a84f17297"
+SRC_URI[syn-3.0.5.sha256sum] = "12df2e0110f65b775f769bb17ef989067a1d931b2eb822bd4346631eeada89f9"
+SRC_URI[sync_wrapper-1.0.2.sha256sum] = "0bf256ce5efdfa370213c1dabab5935a12e49f2c58d15e9eac2870d3b4f27263"
+SRC_URI[synstructure-0.13.2.sha256sum] = "728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2"
+SRC_URI[syslog-7.0.0.sha256sum] = "019f1500a13379b7d051455df397c75770de6311a7a188a699499502704d9f10"
+SRC_URI[system-configuration-0.7.0.sha256sum] = "a13f3d0daba03132c0aa9767f98351b3488edc2c100cda2d2ec2b04f3d8d3c8b"
+SRC_URI[system-configuration-sys-0.6.0.sha256sum] = "8e1d1b10ced5ca923a1fcb8d03e96b8d3268065d724548c0211415ff6ac6bac4"
+SRC_URI[tar-0.4.46.sha256sum] = "3f6221d9a6003c78398e3b239969f352578258df48c8eb051caadae0015bc840"
+SRC_URI[tempfile-3.27.0.sha256sum] = "32497e9a4c7b38532efcdebeef879707aa9f794296a4f0244f6f69e9bc8574bd"
 SRC_URI[term-0.7.0.sha256sum] = "c59df8ac95d96ff9bede18eb7300b0fda5e5d8d90960e76f8e14ae765eedbf1f"
 SRC_URI[termcolor-1.1.3.sha256sum] = "bab24d30b911b2376f3a13cc2cd443142f0c81dda04c118693e35b3835757755"
-SRC_URI[textwrap-0.11.0.sha256sum] = "d326610f408c7a4eb6f51c37c330e496b08506c9457c9d34287ecc38809fb060"
-SRC_URI[thiserror-1.0.31.sha256sum] = "bd829fe32373d27f76265620b5309d0340cb8550f523c1dda251d6298069069a"
-SRC_URI[thiserror-impl-1.0.31.sha256sum] = "0396bc89e626244658bef819e22d0cc459e795a5ebe878e6ec336d1674a8d79a"
-SRC_URI[thread_local-1.1.4.sha256sum] = "5516c27b78311c50bf42c071425c560ac799b11c30b31f87e3081965fe5e0180"
-SRC_URI[time-0.1.44.sha256sum] = "6db9e6914ab8b1ae1c260a4ae7a49b6c5611b40328a735b21862567685e73255"
+SRC_URI[terminal_size-0.4.4.sha256sum] = "230a1b821ccbd75b185820a1f1ff7b14d21da1e442e22c0863ea5f08771a8874"
+SRC_URI[thiserror-1.0.69.sha256sum] = "b6aaf5339b578ea85b50e080feb250a3e8ae8cfcdff9a461c9ec2904bc923f52"
+SRC_URI[thiserror-2.0.20.sha256sum] = "ec86235f5fcc2a73650310756d2ac5b138a5780bbbdfae3eeccec992c435ba4f"
+SRC_URI[thiserror-impl-1.0.69.sha256sum] = "4fee6c4efc90059e10f81e6d42c60a18f76588c3d74cb83a0b242a2b6c7504c1"
+SRC_URI[thiserror-impl-2.0.20.sha256sum] = "bc04cd3e1236dd4a98afca4569f2deb3f120e5422a4023be2cb683f8486292af"
+SRC_URI[thread_local-1.1.10.sha256sum] = "1ad99c4c6d32803332c548b1af0540b357b3f5fc0be8f6c6bfe8b2e6ae784070"
+SRC_URI[time-0.3.55.sha256sum] = "cdb87b95ec50ddfa440816d227a17b2ccbdda963a316a727fda0fc4334f7d134"
+SRC_URI[time-core-0.1.9.sha256sum] = "9e1c906769ad99c88eaa54e728060edef082f8e358ff32030cb7c7d315e81109"
+SRC_URI[time-macros-0.2.32.sha256sum] = "7e689342a48d2ea927c87ea50cabf8594854bf940e9310208848d680d668ed85"
 SRC_URI[tiny-keccak-2.0.2.sha256sum] = "2c9d3793400a45f954c52e73d068316d76b6f4e36977e3fcebb13a2721e80237"
-SRC_URI[tiny_http-0.8.2.sha256sum] = "9ce51b50006056f590c9b7c3808c3bd70f0d1101666629713866c227d6e58d39"
-SRC_URI[tinyvec-1.6.0.sha256sum] = "87cc5ceb3875bb20c2890005a4e226a4651264a5c75edb2421b52861a0a0cb50"
-SRC_URI[tinyvec_macros-0.1.0.sha256sum] = "cda74da7e1a664f795bb1f8a87ec406fb89a02522cf6e50620d016add6dbbf5c"
-SRC_URI[tokio-1.20.4.sha256sum] = "eb78f30e4b41e98ca4cce5acb51168a033839a7af9e42b380355808e14e98ee0"
-SRC_URI[tokio-macros-1.8.0.sha256sum] = "9724f9a975fb987ef7a3cd9be0350edcbe130698af5b8f7a631e23d42d052484"
-SRC_URI[tokio-native-tls-0.3.0.sha256sum] = "f7d995660bd2b7f8c1568414c1126076c13fbb725c40112dc0120b78eb9b717b"
-SRC_URI[tokio-rustls-0.22.0.sha256sum] = "bc6844de72e57df1980054b38be3a9f4702aba4858be64dd700181a8a6d0e1b6"
-SRC_URI[tokio-util-0.7.3.sha256sum] = "cc463cd8deddc3770d20f9852143d50bf6094e640b485cb2e189a2099085ff45"
-SRC_URI[toml-0.5.9.sha256sum] = "8d82e1a7758622a465f8cee077614c73484dac5b836c02ff6a40d5d1010324d7"
-SRC_URI[tower-service-0.3.2.sha256sum] = "b6bc1c9ce2b5135ac7f93c72918fc37feb872bdc6a5533a8b85eb4b86bfdae52"
-SRC_URI[tracing-0.1.35.sha256sum] = "a400e31aa60b9d44a52a8ee0343b5b18566b03a8321e0d321f695cf56e940160"
-SRC_URI[tracing-attributes-0.1.22.sha256sum] = "11c75893af559bc8e10716548bdef5cb2b983f8e637db9d0e15126b61b484ee2"
-SRC_URI[tracing-core-0.1.28.sha256sum] = "7b7358be39f2f274f322d2aaed611acc57f382e8eb1e5b48cb9ae30933495ce7"
-SRC_URI[tracing-log-0.1.3.sha256sum] = "78ddad33d2d10b1ed7eb9d1f518a5674713876e97e5bb9b7345a7984fbb4f922"
-SRC_URI[tracing-serde-0.1.3.sha256sum] = "bc6b213177105856957181934e4920de57730fc69bf42c37ee5bb664d406d9e1"
-SRC_URI[tracing-subscriber-0.2.25.sha256sum] = "0e0d2eaa99c3c2e41547cfa109e910a68ea03823cccad4a0525dcbc9b01e8c71"
+SRC_URI[tinystr-0.8.4.sha256sum] = "b1e27c91459209c2986af3dcf603a5a74a4368754ce37414f59acc971167f643"
+SRC_URI[tinyvec-1.13.2.sha256sum] = "4cf0ded5c4e56918d8f8a339e1bb67d038d3bc6d144ac407904015ba2e4cde9b"
+SRC_URI[tinyvec_macros-0.1.1.sha256sum] = "1f3ccbac311fea05f86f61904b462b55fb3df8837a366dfc601a0161d0532f20"
+SRC_URI[tokio-1.53.1.sha256sum] = "202caea871b69668250d242070849eb495be178ed697a3e98aebce5bc81a0bed"
+SRC_URI[tokio-macros-2.7.2.sha256sum] = "78773a2a397f451582ce068015985c33193cf6dea8b74d2a639fe457b2f07b0e"
+SRC_URI[tokio-rustls-0.26.5.sha256sum] = "b0c85f2c3ef0b1cd58b36682f4b17aaa995f0e5db534d85692b4903abce21f67"
+SRC_URI[tokio-util-0.7.19.sha256sum] = "494815d09bf52b5548659851081238f0ca39ff638363907596da739561c62c52"
+SRC_URI[toml-0.9.12+spec-1.1.0.sha256sum] = "cf92845e79fc2e2def6a5d828f0801e29a2f8acc037becc5ab08595c7d5e9863"
+SRC_URI[toml_datetime-0.7.5+spec-1.1.0.sha256sum] = "92e1cfed4a3038bc5a127e35a2d360f145e1f4b971b551a2ba5fd7aedf7e1347"
+SRC_URI[toml_parser-1.1.3+spec-1.1.0.sha256sum] = "1d38ac1cf9b95face32296c0a3ede1fdc270627c9d9c02a7274dd6d960dc4d56"
+SRC_URI[toml_writer-1.1.2+spec-1.1.0.sha256sum] = "7d56353a2a665ad0f41a421187180aab746c8c325620617ad883a99a1cbe66d2"
+SRC_URI[tower-0.5.3.sha256sum] = "ebe5ef63511595f1344e2d5cfa636d973292adc0eec1f0ad45fae9f0851ab1d4"
+SRC_URI[tower-http-0.6.11.sha256sum] = "4cfcf7e2740e6fc6d4d688b4ef00650406bb94adf4731e43c096c3a19fe40840"
+SRC_URI[tower-layer-0.3.3.sha256sum] = "121c2a6cda46980bb0fcd1647ffaf6cd3fc79a013de288782836f6df9c48780e"
+SRC_URI[tower-service-0.3.3.sha256sum] = "8df9b6e13f2d32c91b9bd719c00d1958837bc7dec474d94952798cc8e69eeec3"
+SRC_URI[tracing-0.1.44.sha256sum] = "63e71662fa4b2a2c3a26f570f037eb95bb1f85397f3cd8076caed2f026a6d100"
+SRC_URI[tracing-core-0.1.36.sha256sum] = "db97caf9d906fbde555dd62fa95ddba9eecfd14cb388e4f491a66d74cd5fb79a"
 SRC_URI[trait-set-0.2.0.sha256sum] = "875c4c873cc824e362fa9a9419ffa59807244824275a44ad06fec9684fff08f2"
-SRC_URI[try-lock-0.2.3.sha256sum] = "59547bce71d9c38b83d9c0e92b6066c4253371f15005def0c30d9657f50c7642"
-SRC_URI[typenum-1.15.0.sha256sum] = "dcf81ac59edc17cc8697ff311e8f5ef2d99fcbd9817b34cec66f90b6c3dfd987"
-SRC_URI[unicode-bidi-0.3.8.sha256sum] = "099b7128301d285f79ddd55b9a83d5e6b9e97c92e0ea0daebee7263e932de992"
-SRC_URI[unicode-ident-1.0.2.sha256sum] = "15c61ba63f9235225a22310255a29b806b907c9b8c964bcbd0a2c70f3f2deea7"
-SRC_URI[unicode-normalization-0.1.21.sha256sum] = "854cbdc4f7bc6ae19c820d44abdc3277ac3e1b2b93db20a636825d9322fb60e6"
-SRC_URI[unicode-width-0.1.9.sha256sum] = "3ed742d4ea2bd1176e236172c8429aaf54486e7ac098db29ffe6529e0ce50973"
-SRC_URI[unicode-xid-0.2.3.sha256sum] = "957e51f3646910546462e67d5f7599b9e4fb8acdd304b087a6494730f9eebf04"
-SRC_URI[untrusted-0.7.1.sha256sum] = "a156c684c91ea7d62626509bce3cb4e1d9ed5c4d978f7b4352658f96a4c26b4a"
-SRC_URI[url-2.2.2.sha256sum] = "a507c383b2d33b5fc35d1861e77e6b383d158b2da5e14fe51b83dfedf6fd578c"
+SRC_URI[try-lock-0.2.5.sha256sum] = "e421abadd41a4225275504ea4d6566923418b7f05506fbc9c0fe86ba7396114b"
+SRC_URI[typenum-1.20.1.sha256sum] = "b6f5e870be6c3b371b77fe0ee0bafb859fa4964b4404c27de1d380043c4dda20"
+SRC_URI[unicode-ident-1.0.24.sha256sum] = "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
+SRC_URI[unicode-normalization-0.1.25.sha256sum] = "5fd4f6878c9cb28d874b009da9e8d183b5abc80117c40bbd187a1fde336be6e8"
+SRC_URI[unicode-xid-0.2.6.sha256sum] = "ebc1c04c71510c7f702b52b7c350734c9ff1295c464a03335b00bb84fc54f853"
+SRC_URI[untrusted-0.9.0.sha256sum] = "8ecb6da28b8a351d773b68d5825ac39017e680750f980f3a1a85cd8dd28a47c1"
+SRC_URI[url-2.5.8.sha256sum] = "ff67a8a4397373c3ef660812acab3268222035010ab8680ec4215f38ba3d0eed"
 SRC_URI[urlparse-0.7.3.sha256sum] = "110352d4e9076c67839003c7788d8604e24dcded13e0b375af3efaa8cf468517"
-SRC_URI[uuid-1.1.2.sha256sum] = "dd6469f4314d5f1ffec476e05f17cc9a78bc7a27a6a857842170bdf8d6f98d2f"
-SRC_URI[valuable-0.1.0.sha256sum] = "830b7e5d4d90034032940e4ace0d9a9a057e7a45cd94e6c007832e39edb82f6d"
+SRC_URI[utf8_iter-1.0.4.sha256sum] = "b6c140620e7ffbb22c2dee59cafe6084a59b5ffc27a8859a5f0d494b5d52b6be"
+SRC_URI[utf8parse-0.2.2.sha256sum] = "06abde3611657adf66d383f00b093d7faecc7fa57071cce2578660c9f1010821"
+SRC_URI[uuid-1.26.1.sha256sum] = "2ef6dac1e96601b4fb3acccccff2139741fcb757cb9a36089bf5be91cfb285ce"
 SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
-SRC_URI[vec_map-0.8.2.sha256sum] = "f1bddf1187be692e79c5ffeab891132dfb0f236ed36a43c7ed39f1165ee20191"
-SRC_URI[version_check-0.9.4.sha256sum] = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
-SRC_URI[want-0.3.0.sha256sum] = "1ce8a968cb1cd110d136ff8b819a556d6fb6d919363c61534f6860c7eb172ba0"
-SRC_URI[wasi-0.10.0+wasi-snapshot-preview1.sha256sum] = "1a143597ca7c7793eff794def352d41792a93c481eb1042423ff7ff72ba2c31f"
-SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
-SRC_URI[wasm-bindgen-0.2.81.sha256sum] = "7c53b543413a17a202f4be280a7e5c62a1c69345f5de525ee64f8cfdbc954994"
-SRC_URI[wasm-bindgen-backend-0.2.81.sha256sum] = "5491a68ab4500fa6b4d726bd67408630c3dbe9c4fe7bda16d5c82a1fd8c7340a"
-SRC_URI[wasm-bindgen-futures-0.4.31.sha256sum] = "de9a9cec1733468a8c657e57fa2413d2ae2c0129b95e87c5b72b8ace4d13f31f"
-SRC_URI[wasm-bindgen-macro-0.2.81.sha256sum] = "c441e177922bc58f1e12c022624b6216378e5febc2f0533e41ba443d505b80aa"
-SRC_URI[wasm-bindgen-macro-support-0.2.81.sha256sum] = "7d94ac45fcf608c1f45ef53e748d35660f168490c10b23704c7779ab8f5c3048"
-SRC_URI[wasm-bindgen-shared-0.2.81.sha256sum] = "6a89911bd99e5f3659ec4acf9c4d93b0a90fe4a2a11f15328472058edc5261be"
-SRC_URI[web-sys-0.3.58.sha256sum] = "2fed94beee57daf8dd7d51f2b15dc2bcde92d7a72304cdf662a4371008b71b90"
-SRC_URI[webpki-0.21.4.sha256sum] = "b8e38c0608262c46d4a56202ebabdeb094cef7e560ca7a226c6bf055188aa4ea"
+SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
+SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
+SRC_URI[want-0.3.1.sha256sum] = "bfa7760aed19e106de2c7c0b581b509f2f25d3dacaf737cb82ac61bc6d760b0e"
+SRC_URI[wasi-0.11.1+wasi-snapshot-preview1.sha256sum] = "ccf3ec651a847eb01de73ccad15eb7d99f80485de043efb2f370cd654f4ea44b"
+SRC_URI[wasm-bindgen-0.2.128.sha256sum] = "aecb87a33d3b0c5e3b7aa46336eaf486cffafbd281b195e4c8b80d50df2351bf"
+SRC_URI[wasm-bindgen-futures-0.4.78.sha256sum] = "6ef4c5d3d2cdf5c54f4231181768f5510842e350db025faf1f7163b1030ed928"
+SRC_URI[wasm-bindgen-macro-0.2.128.sha256sum] = "a690d511e3c1a8b3a55e33511e3c2c00c78415cd23650f32b808627f5696b9ed"
+SRC_URI[wasm-bindgen-macro-support-0.2.128.sha256sum] = "411e4887f0071ef2d2164a9d5fdf2d20efbef78fccd3a78b0c10a1dc5295e48a"
+SRC_URI[wasm-bindgen-shared-0.2.128.sha256sum] = "81941cd78d0c92026c33e5e01312845a4cb1e9af3407f9134b100dd03144103e"
+SRC_URI[web-sys-0.3.105.sha256sum] = "9fbddc4a036f00ec4f18c83445bd3115cb306a91da554919a099d9222fe4a7f8"
+SRC_URI[web-time-1.1.0.sha256sum] = "5a6580f308b1fad9207618087a65c04e7a10bc77e02c8e84e9b00dd4b12fa0bb"
+SRC_URI[webpki-root-certs-1.0.9.sha256sum] = "b96554aa2acc8ccdb7e1c9a58a7a68dd5d13bccc69cd124cb09406db612a1c9b"
 SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
-SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
+SRC_URI[winapi-util-0.1.11.sha256sum] = "c2a7b1c03c876122aa43f3020e6c3c3ee5c05081c9a00739faf7503aeba10d22"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-SRC_URI[windows-sys-0.36.1.sha256sum] = "ea04155a16a59f9eab786fe12a4a450e75cdb175f9e0d80da1e17db09f55b8d2"
-SRC_URI[windows_aarch64_msvc-0.36.1.sha256sum] = "9bb8c3fd39ade2d67e9874ac4f3db21f0d710bee00fe7cab16949ec184eeaa47"
-SRC_URI[windows_i686_gnu-0.36.1.sha256sum] = "180e6ccf01daf4c426b846dfc66db1fc518f074baa793aa7d9b9aaeffad6a3b6"
-SRC_URI[windows_i686_msvc-0.36.1.sha256sum] = "e2e7917148b2812d1eeafaeb22a97e4813dfa60a3f8f78ebe204bcc88f12f024"
-SRC_URI[windows_x86_64_gnu-0.36.1.sha256sum] = "4dcd171b8776c41b97521e5da127a2d86ad280114807d0b2ab1e462bc764d9e1"
-SRC_URI[windows_x86_64_msvc-0.36.1.sha256sum] = "c811ca4a8c853ef420abd8592ba53ddbbac90410fab6903b3e79972a631f7680"
-SRC_URI[winreg-0.10.1.sha256sum] = "80d0f4e272c85def139476380b12f9ac60926689dd2e01d4923222f40580869d"
+SRC_URI[windows-core-0.62.2.sha256sum] = "b8e83a14d34d0623b51dce9581199302a221863196a1dde71a7663a4c2be9deb"
+SRC_URI[windows-implement-0.60.2.sha256sum] = "053e2e040ab57b9dc951b72c264860db7eb3b0200ba345b4e4c3b14f67855ddf"
+SRC_URI[windows-interface-0.59.3.sha256sum] = "3f316c4a2570ba26bbec722032c4099d8c8bc095efccdc15688708623367e358"
+SRC_URI[windows-link-0.2.1.sha256sum] = "f0805222e57f7521d6a62e36fa9163bc891acd422f971defe97d64e70d0a4fe5"
+SRC_URI[windows-registry-0.6.1.sha256sum] = "02752bf7fbdcce7f2a27a742f798510f3e5ad88dbe84871e5168e2120c3d5720"
+SRC_URI[windows-result-0.4.1.sha256sum] = "7781fa89eaf60850ac3d2da7af8e5242a5ea78d1a11c49bf2910bb5a73853eb5"
+SRC_URI[windows-strings-0.5.1.sha256sum] = "7837d08f69c77cf6b07689544538e017c1bfcf57e34b4c0ff58e6c2cd3b37091"
+SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
+SRC_URI[windows-sys-0.59.0.sha256sum] = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
+SRC_URI[windows-sys-0.61.2.sha256sum] = "ae137229bcbd6cdf0f7b80a31df61766145077ddf49416a728b02cb3921ff3fc"
+SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
+SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
+SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
+SRC_URI[windows_i686_gnu-0.52.6.sha256sum] = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
+SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
+SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
+SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
+SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
+SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
+SRC_URI[winnow-0.7.15.sha256sum] = "df79d97927682d2fd8adb29682d1140b343be4ac0f08fd68b7765d9c059d3945"
+SRC_URI[winnow-1.0.4.sha256sum] = "23b97319f7b8343df12cc98938e5c3eb436064524c8d2b4e30a1d3a36eecdf81"
+SRC_URI[writeable-0.6.4.sha256sum] = "3ad82d2a33cdc9674dc7465672f271e096168fcdbe0f799d9e6db8c5892679dc"
+SRC_URI[xattr-1.6.1.sha256sum] = "32e45ad4206f6d2479085147f02bc2ef834ac85886624a23575ae137c8aa8156"
+SRC_URI[yoke-0.8.3.sha256sum] = "709fe23a0424b6a435d82152b1bd3fdfb0833487d5fa90d05d42762a9891fef5"
+SRC_URI[yoke-derive-0.8.2.sha256sum] = "de844c262c8848816172cef550288e7dc6c7b7814b4ee56b3e1553f275f1858e"
+SRC_URI[zerocopy-0.8.57.sha256sum] = "d35102a9f36d089ccae9e4c6802bc118be4487b80aaffc0ab4e0cf5ce92d2873"
+SRC_URI[zerocopy-derive-0.8.57.sha256sum] = "146c01f5ab44258da43cf276c74a2763db2ff3969c9c652c3f2de07041d0b2bc"
+SRC_URI[zerofrom-0.1.8.sha256sum] = "0ec05a11813ea801ff6d75110ad09cd0824ddba17dfe17128ea0d5f68e6c5272"
+SRC_URI[zerofrom-derive-0.1.7.sha256sum] = "11532158c46691caf0f2593ea8358fed6bbf68a0315e80aae9bd41fbade684a1"
+SRC_URI[zeroize-1.9.0.sha256sum] = "e13c156562582aa81c60cb29407084cdb54c4164760106ab78e6c5b0858cf64e"
+SRC_URI[zerotrie-0.2.5.sha256sum] = "4ea269c3bd32f0a32c321907a2ae912ba6f4649bb0fc764a15627e99a7095a3f"
+SRC_URI[zerovec-0.11.8.sha256sum] = "bb0464e17806c1d976d5cba29399c7f08e516e279e2ba493f63123b5fca67dd8"
+SRC_URI[zerovec-derive-0.11.6.sha256sum] = "34df6fc39dbd26ddc9c10e6a2984476e13acce22e64e4487636ef494369225da"
+SRC_URI[zmij-1.0.23.sha256sum] = "29666d0abbfad1e3dc4dcf6144730dd3a3ab225bbbdac83319345b1b44ccfc1b"
diff --git a/recipes-security/krill/krill_0.12.3.bb b/recipes-security/krill/krill_0.16.0.bb
similarity index 87%
rename from recipes-security/krill/krill_0.12.3.bb
rename to recipes-security/krill/krill_0.16.0.bb
index 2a10584..e1693d4 100644
--- a/recipes-security/krill/krill_0.12.3.bb
+++ b/recipes-security/krill/krill_0.16.0.bb
@@ -5,10 +5,11 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=9741c346eef56131163e13b9db1241b3"
 
 DEPENDS = "openssl"
 
-# SRC_URI += "crate://crates.io/krill/0.9.1"
-SRC_URI = "git://github.com/NLnetLabs/krill.git;protocol=https;branch=main"
-SRCREV = "e92098419c7ad82939e0483bc76df21eff705b80"
-SRC_URI += "file://panic_workaround.patch"
+SRC_URI = "git://github.com/NLnetLabs/krill.git;protocol=https;branch=main \
+           file://0001-Disable-abort-on-panic.patch \
+           file://0002-Update-crate-dependencies.patch \
+"
+SRCREV = "b2a26cd9f44a385d8a62a0199b082f44e5062039"
 
 include krill-crates.inc
 
-- 
2.55.0


