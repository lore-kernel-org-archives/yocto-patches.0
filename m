Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0C0D19528
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:55:11 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36387.1769471709080251322
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:55:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=n9CFqSMk;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c655e0ee70so637445285a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471708; x=1770076508; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iR3tYLq2EUADFI3PznTXMKP12EWCdISzkwOpjfWuL8w=;
        b=n9CFqSMkFhfPieoCzyTY9n54F7H9Vt/Jgo1uON98glJZp1RYfQBfLCjFd8rK30olph
         QXBeYO78srl7jp5obk1RIQLEFtb5PHr+DDOH12j50XOHyRcmp0nTRv6nOT2bN3bKezkG
         fAdFrnzcZ55qEKhoAgDOZLEwRhd5bA6OPTWRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471708; x=1770076508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iR3tYLq2EUADFI3PznTXMKP12EWCdISzkwOpjfWuL8w=;
        b=Ep4wWG43AX+7AtB74pCUx3rxhvpX7C6qlTAzHBNRJzgHPz8iJy5dM+IIkzNBkw8xfU
         T5mcc1jFfJfvwGhLFJbvjnwBeciKKPaARY5qSNPdF+Y1CWS2U8YQG59X+I6OaXzahOGk
         fZU1fSIUgtVSRK5tUi/X9pkApGDGod+hjmnyxRGSTmRx14UHsiKV/GykGrfFOG62fv0z
         8ohp6jeY1e6+Tlvy2XmeZjVFJ9BTrOibS31PfyghoVLdhCbt7J3pg5f6DkCj4Sv6W5C1
         /JabFEE371xGK+FUb74gBxeU1If1YtqxZBiLKpYqbdKVAGH3Rk7VIbYfg5sjVUICb9Ic
         2eTA==
X-Gm-Message-State: AOJu0YzX8c5zoVJfSXkC9DKTdJO5AQEGUNHQeaiaYv2Z1Qs9WTqNs1jM
	OFrtMbEM2uPcZ6iwkbVwVbOp39MrJkc3LUvucQIbGlTnae9szhmFt/NAl1Ry+3bQuZcI7y1ANLR
	k71G85KM=
X-Gm-Gg: AZuq6aIvkDfDbWQ+k+f8HVEmbuUV76ol2YY7uHNR1WlrvKMk8ZTH0Fos2LLi1EJoTnZ
	scXDfPSIota6mwsekd1eMp2uBUsdHKQFv0St4K6IcSEZNfKIWnmF+IuU+mXh67xCWFDA2tdHj4i
	G7O/pLdX06OWMucQJmh9wqFWBOiimM+OxBHjFeMCJASroP20gI6Mt/z2Zb2P7/1L7SN+TFXPFbx
	78ZHAakpANiPA5BOeXzdEoSLdBP8GjtZ1e6QL15vTIrbaSRKHiPFlibh29CycQSV8AALIB1Cow9
	BAfZah64dczrklNihlBSMLFr3+3zztG4XlZ52liNp/DfaRNqqzef78i0ikWIOvcccpvq8xLSNGV
	lETfv5/ZYhHK3sNxz0FHQJzw9O1GXtlnvYRlQdOhQqDALGF7+07CGr4SCbfyvrh19LFc8HPRZpW
	8/QGmddsZpsuorTMZvXwdnNlrUjwoPYKclaoY8WOYjEMsMdgZWxnm0ihzwhmW1gesbLziKMCFU9
	/MKIequqKu8Mey/PXp44QFKLeZwfVqJuUIdpqMYN4STHkStuRge
X-Received: by 2002:a05:620a:3725:b0:8b2:e990:5114 with SMTP id af79cd13be357-8c6f969a47dmr756208685a.42.1769471707642;
        Mon, 26 Jan 2026 15:55:07 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061740885a.15.2026.01.26.15.55.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:55:07 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 07/10] rust: Upgrade 1.91.1 -> 1.92.0
Date: Mon, 26 Jan 2026 18:54:53 -0500
Message-ID: <a0568876d6b7be166caa0e7361ba3ab38e5d9683.1769471543.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769471543.git.scott.murray@konsulko.com>
References: <cover.1769471543.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:55:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3109

From: Hemanth Kumar M D <hemanth.250302@gmail.com>

https://blog.rust-lang.org/2025/12/11/Rust-1.92.0/
Rust changes: https://github.com/rust-lang/rust/releases/tag/1.92.0
Cargo changes: https://doc.rust-lang.org/nightly/cargo/CHANGELOG.html#cargo-192-2025-12-11

Test results summary:

rust v1.92.0

+-----------+--------+---------+
| Machine   | Passed | Ignored |
+-----------+--------+---------+
| arm-32    | 30,317 |  1,687  |
| arm-64    | 30,426 |  1,617  |
| x86-32    | 30,335 |  1,664  |
| x86-64    | 30,587 |  1,414  |
| riscv-64  | 30,426 |  1,617  |
+-----------+--------+---------+

Test results difference (1.92.0-1.91.1):

+-----------+--------+---------+
| Machine   | Passed | Ignored |
+-----------+--------+---------+
| arm-32    |  +349  |  +177   |
| arm-64    |  +516  |  +170   |
| x86-32    |  +264  |  +217   |
| x86-64    |  +358  |  +167   |
| riscv-64  |  +281  |  +145   |
+-----------+--------+---------+

Note: The increase in ignored tests is not due to any additional ignores added in OE.
These are primarily upstream-defined ignores introduced in Rust 1.92.0, likely due to
architecture-specific constraints or target configuration differences. The only OE-side
ignore added is for the no_std simple-runs test on 32-bit ARM, limited to a known upstream
issue (rust-lang/rust#146996) and can be reverted once the issue is resolved.

Signed-off-by: Hemanth Kumar M D <hemanth.250302@gmail.com>
Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b665e35efdcf8fe546865f12fcedc1fefae99ff8)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                               |  2 +-
 .../rust/{cargo_1.91.1.bb => cargo_1.92.0.bb} |  0
 ...ibstd-rs_1.91.1.bb => libstd-rs_1.92.0.bb} |  0
 ....91.1.bb => rust-cross-canadian_1.92.0.bb} |  0
 ...ust-llvm_1.91.1.bb => rust-llvm_1.92.0.bb} |  2 +-
 recipes-devtools/rust/rust-snapshot.inc       | 78 +++++++++----------
 recipes-devtools/rust/rust-source.inc         |  2 +-
 .../rust/{rust_1.91.1.bb => rust_1.92.0.bb}   |  0
 8 files changed, 42 insertions(+), 42 deletions(-)
 rename recipes-devtools/rust/{cargo_1.91.1.bb => cargo_1.92.0.bb} (100%)
 rename recipes-devtools/rust/{libstd-rs_1.91.1.bb => libstd-rs_1.92.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.91.1.bb => rust-cross-canadian_1.92.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.91.1.bb => rust-llvm_1.92.0.bb} (99%)
 rename recipes-devtools/rust/{rust_1.91.1.bb => rust_1.92.0.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index 489273f..0056ff9 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,7 +15,7 @@ LAYERDEPENDS_lts-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.91.1%"
+RUSTVERSION ?= "1.92.0%"
 
 # This is not ideal, but it seems better to mask out the older oe-core
 # recipes completely since they will not work with this layer on top,
diff --git a/recipes-devtools/rust/cargo_1.91.1.bb b/recipes-devtools/rust/cargo_1.92.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.91.1.bb
rename to recipes-devtools/rust/cargo_1.92.0.bb
diff --git a/recipes-devtools/rust/libstd-rs_1.91.1.bb b/recipes-devtools/rust/libstd-rs_1.92.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.91.1.bb
rename to recipes-devtools/rust/libstd-rs_1.92.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.91.1.bb b/recipes-devtools/rust/rust-cross-canadian_1.92.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.91.1.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.92.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.91.1.bb b/recipes-devtools/rust/rust-llvm_1.92.0.bb
similarity index 99%
rename from recipes-devtools/rust/rust-llvm_1.91.1.bb
rename to recipes-devtools/rust/rust-llvm_1.92.0.bb
index b060cd5..99ae87e 100644
--- a/recipes-devtools/rust/rust-llvm_1.91.1.bb
+++ b/recipes-devtools/rust/rust-llvm_1.92.0.bb
@@ -4,7 +4,7 @@ HOMEPAGE = "http://www.rust-lang.org"
 
 # check src/llvm-project/llvm/CMakeLists.txt for llvm version in use
 #
-LLVM_RELEASE = "21.1.2"
+LLVM_RELEASE = "21.1.3"
 
 require rust-source.inc
 
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rust/rust-snapshot.inc
index c6f9031..4314734 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,56 +4,56 @@
 ## The exact (previous) version that has been used is specified in the source tarball.
 ## The version is replicated here.
 
-SNAPSHOT_VERSION = "1.90.0"
+SNAPSHOT_VERSION = "1.91.0"
 
-SRC_URI[rustc-snapshot-aarch64.sha256sum] = "4e1a9987a11d7d91f0d5afbf5333feb62f44172e4a31f33ce7246549003217f2"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] = "4952abb7d9d3ed7cea4f7ea44dcb23dc67631fae4ac44a5f059b90a4b5e9223f"
-SRC_URI[cargo-snapshot-aarch64.sha256sum] = "bd8d1da6fe88ea7e29338f24277c22156267447adbfc47d690467ad32d02c2a7"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] = "1a7f969c5712c17d960d6fba8235b33f264a9484b369dc388766a540f1ba464f"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] = "f3ea3c964b7f3b884337f2d411764032bbd1722d7f55592a547cbb29afd87c03"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] = "ff23dc81f796d64e34e866a44fd0bcae726e34014835369b8f9393a544167eca"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] = "003d7008219ca0d225ad1dfa301f7c079b123499430ee0780c85782e0878eeff"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] = "a5f8bd961fb30962144d2f68be0bdd1014cf07110323087b0d6a68251a7a4eca"
 
-SRC_URI[rustc-snapshot-i686.sha256sum] = "3b33cef77f9a57d592beb5117d933134bc76258006e6d4f9aed2969d20c75742"
-SRC_URI[rust-std-snapshot-i686.sha256sum] = "dc4bffa768326e0cc47d6b129bcb891af6e7b7bf09ec92bca45e49420b9837bd"
-SRC_URI[cargo-snapshot-i686.sha256sum] = "c1e9b24bbfa95550b5dba9de2045a4c906bea108625781758692b2a407428391"
-SRC_URI[clippy-snapshot-i686.sha256sum] = "3e902971ef6b44ccb804af73aba5dc8c6199ed09a76f178b0eed6f53f7f56eab"
+SRC_URI[rustc-snapshot-i686.sha256sum] = "bf718b184d6ace8fab0012835d129130a6dd6a8d78f4f742ae9308a86b96dfc5"
+SRC_URI[rust-std-snapshot-i686.sha256sum] = "059fe4b9802c3cb64b539cc501ff5e64f8d750573009c3004fd0b583b3f50d39"
+SRC_URI[cargo-snapshot-i686.sha256sum] = "92486e31c070667681328ad57dd3bd4ca1e3d37958540d622b2afda9b67fbe3d"
+SRC_URI[clippy-snapshot-i686.sha256sum] = "14cae2980accb8536ae700bb7ec6a3b540a06d84e7a4c71db1c7f05a17b1edbd"
 
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] = "aca7ee7f0d98e34dafa367cef9c35626d37cf8334f356498aa2bda2fc02206b3"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] = "cb779575cec151223c3c144bc9ca957530fa510e36b32bc9f35bbb1b7dde9e2f"
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] = "6ae37dc8eb3ff4655053a39d5f973613a82a8a8e2fff42c423ca33d8cf19e6c1"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] = "847b3d4bd3d2be23bafbb90cd2ed5e1bf1aacb2e7152e7d2f99bee1078aa0eaa"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] = "04bdbb954f48fcd0b125fbddbf3e59841ec81c58ff858471f7977c8343d9a73c"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] = "cb0c3c2704add4d1271713ff87e1b7a8a4f756b4dc9f580b62953532efd0f7b9"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] = "9437727091d30d73a987e2c56463a2de4f01fb69cfd229617e2f8a7d8de5c05a"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] = "060a0eb3ee236e8a3bfb2cad9495165d755ea60d32e62ce85f12ad17c26afedf"
 
-SRC_URI[rustc-snapshot-powerpc.sha256sum] = "c5d898ca92063d634011525557f2acabc65d4ea268022e7005f99b6ba917357b"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] = "756d1bbd66ebb0d4d575b650a8a94d52546f6892bd2f864410411f6027ed879f"
-SRC_URI[cargo-snapshot-powerpc.sha256sum] = "5b160a2bf0e6f470b83c5988db5b6f02b6d65d3d97a9b965acbfe940b4143b34"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] = "42ac7480dcac12a843803f5ee398d2a42389359178774cab20c66eda4f6927a5"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] = "c625de10cbfd21031f71fa6fdd50ccaffd449744614ef1f57ee3cefe80c57792"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] = "d5ecd84b78eefaf30fb65ec169af1806bd06d0b5bbe166bf010b058c9c59d27f"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] = "1f8f0ac1b05acb7cc50592ca39ec78e374093a0701405e8ea1894bb64a7422cd"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] = "425e5a1a72cc20c476416682cb5df4222c0b9c28fbb9818d4d8f505ccea578e3"
 
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] = "7adbc3c317a73b7d504e171d65a2b0e93953e3e572dab99acabe91140101f81d"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] = "16daac5dc6994c03ab3b8c4e6e5e52c41f5fc5846acea08f4fdf0759cc273aa2"
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] = "fdf90d22476c88d5b9cf8a3ac0937d0b9c6b7dafbf6b3afde369c2f5b8faec88"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] = "071e06a50d5b2975905bb2d6211f2d2372ab0dbd50b7b0097168cb64e77a4bb0"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] = "139a077f72197ce73031dae7cd2156fb6718b09fe9a3f4008266d34fb8d09ae6"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] = "ac046a72a957bf9fd1213e95d46d7ca431a6704f63e99c759ccdd9ae7c07f7d9"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] = "abc14cced999e0d5f0ec75f10af33998dcaef39fab27b8e2c63b93ca0b79f2ab"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] = "b8129667c5b30963698466b7edeef4c5a1c869e78b5f9218fcf1426defa5cea9"
 
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] = "e87b8eb926a65211a99f6712ff376c5950b4b11c67ed7f92019da27a34ae7085"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] = "eac29f92ccd335c51553c362c7a6d3de2eb7071b5ae3839470e351a6a3ebdb77"
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] = "f029151dfeed6570b8b347e04a5bb7dcb9c59d8e5454c535c05bb5069c216354"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] = "12d19dbec34c5a35cd285fe74dcd0226563c0b25be5d041479744060e9374c98"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] = "c526302dcf4f1627525b0eef3ef4181bea801f119c4a0963c3675b390cba164f"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] = "c79c071fd14ef094c1a2e750f19795e7e162f4237bf92299885c0d56fa6017fe"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] = "704bfa80ffeeafacb8f13043873e20e1b9c4a5e785ee6c5e7d0e5828fc1f0c8b"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] = "1571b18b39f97d808b9f10ed2697b9d87bc3959abf858bfcd3baf9eaf8d5d548"
 
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] = "11ae522969c6b18ad4b5a1ae229473de59406af7ab2e831acb43ee247a16b58d"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] = "675dc5556d9d879101d2401b693fcf79edac8f00a49249e2e0f19cecd172ce51"
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] = "8a09de014f7cec749b338c6636d190a1b73fd377bab6a223eb715d3c76c49e79"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] = "02338e25b3d2b61d9dbee7bee4c9ed148f18e2d010c6297ffd36df98042f41a2"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] = "7c3d4ceaa630ddb45bcd538c687637a349b2c3e18634a2b944178a7b4b42a4cc"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] = "7486237c83844d48ac96b67241ef0c1f4f702ceb74c44721f6f8660c3068dede"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] = "8946ea952e5a516e8bb6fd859d9798902877e01bd4508b717f8b9fd915019ad5"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] = "97feb6d6b2158b410a83c40d7eeba1e97220e505eae6666aa09d112665cc8dc1"
 
-SRC_URI[rustc-snapshot-s390x.sha256sum] = "274daef5a69c8812411248a4afea4f58a096c978dffba6b1198da8e3b5a02de7"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] = "e3e7e3dbc65616eebc69e642d9042363ec38d7f50393ef816cc5238ec475f3f5"
-SRC_URI[cargo-snapshot-s390x.sha256sum] = "468ace270ee4edac0a10185ea876ea555e41bacc0137ff08985d2155fe8cc777"
-SRC_URI[clippy-snapshot-s390x.sha256sum] = "bb0a9483a36fdbdab08b433613b374c036779d247a8d508e31265193c3759a8d"
+SRC_URI[rustc-snapshot-s390x.sha256sum] = "073c3817f91ff425ffa141a6db215d54b50db5a8abe08fed593b7597687bdf94"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] = "454ecc9a53dda63762f3d1d92b7e4f4459c58c89d39a4178cce1fd9fd0ce09b5"
+SRC_URI[cargo-snapshot-s390x.sha256sum] = "3af10597a739402d6ecb3db85abaf62e12f7b298d2df6377c3c80e09a54f91b6"
+SRC_URI[clippy-snapshot-s390x.sha256sum] = "8d3bb8aa79abcfe5c24a37651d09dd356f994663699e65e7dd9978514a5ebf31"
 
-SRC_URI[rustc-snapshot-x86_64.sha256sum] = "48c2a42de9e92fcae8c24568f5fe40d5734696a6f80e83cc6d46eef1a78f13c9"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] = "663f4ab7945b392d5e5294dec1b050a66820a20e86f084ec37eeb0f2f7ff5569"
-SRC_URI[cargo-snapshot-x86_64.sha256sum] = "9853db03d68578a30972e2755c89c66aec035fec641cf8f3a7117c81eec2578d"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] = "5b6466419693a05365827378145014a37ae74fb2948fab390d5210a524792ed8"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] = "a7169e8cb6174af2f45717703370363d8de82ce55f6ccba185893045b9370874"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] = "89e6520b16c12b43526440298d2da0dcb70747c5cc2d0b8e47d39b5da9aeef49"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] = "7103c03fb8abe85b23307005a9dfe4f01c826a89945d84b96fa2d03fd4d2d138"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] = "0087c3d58d2fdeafa89830c299b1026c9f981b49835db89c922b3c6a299b3225"
 
-SRC_URI[rust-std-snapshot-i586.sha256sum] = "46eab5c41bf9160a31a53560ff5fc43308c0998cde952533e76fadef66799553"
+SRC_URI[rust-std-snapshot-i586.sha256sum] = "47e91cba208b1f87348e7b6a49274ebb4364651a4191fa67e6850e7813e26ad5"
 
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] = "c204ecb424090cc6c0100cef3013f8636d29f288db99c037578aee7d2672a711"
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] = "4f7bffb09cf5a0c25dda9b51811c60996eb1ae06a277c1e836980c21b3a44766"
 
 SRC_URI += " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=rust-std-snapshot-${RUST_BUILD_ARCH};subdir=rust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 14f74a9..6a9b922 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -9,7 +9,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "66401bb815e236cc6b2aacbbe23b61b286c1fe27a67902e7c0222cfe77b3dbab"
+SRC_URI[rust.sha256sum] = "ebee170bfe4c4dfc59521a101de651e5534f4dae889756a5c97ca9ea40d0c307"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust_1.91.1.bb b/recipes-devtools/rust/rust_1.92.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.91.1.bb
rename to recipes-devtools/rust/rust_1.92.0.bb
-- 
2.51.0


