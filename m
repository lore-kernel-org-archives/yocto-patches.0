Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9701.1795884898434278224
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:54:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JiSarUqB;
 spf=pass (domain: konsulko.com, ip: 209.85.128.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so73320795e9.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884897; x=1796489697; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Tjdy6CFSBuGVpl5VVxgz2RUh1wTNWTibrNuEOwQBQek=;
        b=JiSarUqBz3N7bAoA/CwNNAu7N5ywPhCaSqc6OxhnEjBm0MgMcjkRs4gVOpKfWWcRSQ
         RLpDqJfquXRs8nKs5DcNZ/iMEkPzI8Bp8dlikwfmO2qK9vKAp39pVrsS+E2cmOgJgZbX
         AGyat1pqaTj429itNzxPcYwT3haqr/Pig2CNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884897; x=1796489697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Tjdy6CFSBuGVpl5VVxgz2RUh1wTNWTibrNuEOwQBQek=;
        b=bK6HiH0aGDYc+ug4ZWb22fdnhtxAwcsUAXd6TJErVEXR5NzolPgKb4KOtWj6/Ge4et
         5c1Eajyn6hUXX/DPkjC5aYGvCSAh3l16PvVn9p2ZMZcEEXWkMwiIYxt0ddcqMNUUGkdk
         Y2HWEXZvyNZ8RIKFsG4xSIuj1YziKjvkco5ttnGZThLyOo5WTgAD5ky0IekUjBaUc65C
         Gp36r3ZOKog/OvQb9yITT8tmZCf0jMGqle1rSkmrKVIUXhOhRblrgTHsX2B3jJ1yBRPd
         zyDxZaDfrDzJ9Fqdt6LRcincER/+SrfnrUpUxZgLSmSqjrsiCj+GuPKmT1Uy7+193goL
         JkeQ==
X-Gm-Message-State: APuU4Z/RHpPjyjG6QriauP9QfzgDzy7UlMahk4Xjc7uVOK+9SlaF4KIL
	Sg9sffBxHj/LilIoDqhW4HjhSePlEBbeORQrs5wgnf56/3z7aan9l7AMyoKXMtHBbEp407wJHCc
	xt6n1BT0=
X-Gm-Gg: AZFdTZfszfBDM+vR+A+vyaTFC8LeK7sngnaGF7kT0ZkrD6Db/dijLfgpPOvrxRPEZ+B
	v7yKQhMUALcC3ZfdoaAHh0Jjhtofx69XfEG3DDd7PTiaBUyscXfF7FYZiaxMLLOimBPq/SGPK9q
	JI2lbKZqCJGdGp5GuoXuMM+WYJBCnRA01kGyYWtYZZQfOR+mAJx9RHPXUCkvv2ZM1SGe6RVu02p
	VoGgkuMFlNIy9KEmCO12Eyf0TlJdADwgtyi0cV6+fGLFxB41rVKYs/29nmKk7cW82y98whKeZXm
	BNrm5NqW/x5urvw4EER3BwtoBnahcj9A1XNNWLTYNZim1BoIibYdsH6qXymdoIy6HqucfSP8PmW
	eHlVZmF8JSyaq/MwVyJvP5XnA5S/StQ2l5ZcnGT+NGfYFZNqDh2o1GTsCj8CGjtDGrfnd9mp6h9
	/J/BGPn1GAQHqqT2wWztgF/ydvXJd91tUyANRDQq5SDUc3obSOidxOUs2xm+cAUEz9F0JXScuxH
	Kv+WcaLXoA/thT24OgmgK36+OzMhF/APEaAfUyfuhPMBqfbQTwOnKJLlkafFPRCwXEhV1CwOHoO
	zlZ4C52gi4fGjC/tizjDhrYUpvHvlzUkQww8FknrcRAWP/YBybYDARoBEfgMALqDdbdLTHJAXZq
	9KG5n1Z5l0OJlrWnlKzR6h6uEXzJuCA==
X-Received: by 2002:a05:600d:6504:10b0:4bb:b378:a003 with SMTP id 5b1f17b1804b1-4bbb378a00bmr89801405e9.2.1795884896316;
        Sat, 28 Nov 2026 08:54:56 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:55 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 10/14] suricata: Upgrade 8.0.6 -> 8.0.8
Date: Sat, 28 Nov 2026 18:54:28 +0200
Message-ID: <8a05fc192513ff9ed5351744b7c78a8a3a364dc7.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:55:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5580
Content-Type: text/plain; charset="utf-8"

Release notes:
https://forum.suricata.io/t/suricata-8-0-7-released/6467
https://forum.suricata.io/t/suricata-8-0-8-released/6548

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/suricata/suricata-crates.inc      | 101 +++++++++---------
 .../{suricata_8.0.6.bb => suricata_8.0.8.bb}  |   2 +-
 2 files changed, 51 insertions(+), 52 deletions(-)
 rename recipes-ids/suricata/{suricata_8.0.6.bb => suricata_8.0.8.bb} (98%)

diff --git a/recipes-ids/suricata/suricata-crates.inc b/recipes-ids/suricata/suricata-crates.inc
index 357747d..5451177 100644
--- a/recipes-ids/suricata/suricata-crates.inc
+++ b/recipes-ids/suricata/suricata-crates.inc
@@ -36,7 +36,7 @@ SRC_URI += " \
     crate://crates.io/clap_builder/4.5.39 \
     crate://crates.io/clap_derive/4.5.32 \
     crate://crates.io/clap_lex/0.7.4 \
-    crate://crates.io/clipboard-win/5.4.0 \
+    crate://crates.io/clipboard-win/5.4.3 \
     crate://crates.io/cpufeatures/0.2.17 \
     crate://crates.io/crc/1.8.1 \
     crate://crates.io/crc32fast/1.4.2 \
@@ -84,7 +84,7 @@ SRC_URI += " \
     crate://crates.io/itoa/1.0.15 \
     crate://crates.io/kerberos-parser/0.8.0 \
     crate://crates.io/lazy_static/1.5.0 \
-    crate://crates.io/ldap-parser/0.5.0 \
+    crate://crates.io/ldap-parser/0.5.1 \
     crate://crates.io/libc/0.2.172 \
     crate://crates.io/libz-sys/1.1.22 \
     crate://crates.io/linux-raw-sys/0.9.4 \
@@ -130,7 +130,7 @@ SRC_URI += " \
     crate://crates.io/ppv-lite86/0.2.21 \
     crate://crates.io/proc-macro-crate/1.1.0 \
     crate://crates.io/proc-macro2/1.0.95 \
-    crate://crates.io/psl/2.1.215 \
+    crate://crates.io/psl/2.1.241 \
     crate://crates.io/psl-types/2.0.11 \
     crate://crates.io/quote/1.0.40 \
     crate://crates.io/radix_trie/0.2.1 \
@@ -253,7 +253,7 @@ SRC_URI[clap-4.5.39.sha256sum] = "fd60e63e9be68e5fb56422e397cf9baddded06dae1d2e5
 SRC_URI[clap_builder-4.5.39.sha256sum] = "89cc6392a1f72bbeb820d71f32108f61fdaf18bc526e1d23954168a67759ef51"
 SRC_URI[clap_derive-4.5.32.sha256sum] = "09176aae279615badda0765c0c0b3f6ed53f4709118af73cf4655d85d1530cd7"
 SRC_URI[clap_lex-0.7.4.sha256sum] = "f46ad14479a25103f283c0f10005961cf086d8dc42205bb44c46ac563475dca6"
-SRC_URI[clipboard-win-5.4.0.sha256sum] = "15efe7a882b08f34e38556b14f2fb3daa98769d06c7f0c1b076dfd0d983bc892"
+SRC_URI[clipboard-win-5.4.3.sha256sum] = "052af7878466feccda12ba7a6a67d019d712f296809559b47c12c8cc196d3a9a"
 SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
 SRC_URI[crc-1.8.1.sha256sum] = "d663548de7f5cca343f1e0a48d14dcfb0e9eb4e079ec58883b7251539fa10aeb"
 SRC_URI[crc32fast-1.4.2.sha256sum] = "a97769d94ddab943e4510d138150169a2758b5ef3eb191a9ee688de3e23ef7b3"
@@ -301,7 +301,7 @@ SRC_URI[ipsec-parser-0.7.0.sha256sum] = "2cf8413e5de78bcbc51880ff71f4b64105719ab
 SRC_URI[itoa-1.0.15.sha256sum] = "4a5f13b858c8d314ee3e8f639011f7ccefe71f97f96e50151fb991f267928e2c"
 SRC_URI[kerberos-parser-0.8.0.sha256sum] = "dedcd80c336b8a8dc828afe2be00fb7006c48a95c2396beb0555149fb414f321"
 SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
-SRC_URI[ldap-parser-0.5.0.sha256sum] = "db3356a3bd19e90fdc8b29f32c48e21b1bb1c5d129c1df7000ce3071c6f9e6b1"
+SRC_URI[ldap-parser-0.5.1.sha256sum] = "4dee1f4925a99fde2a970d303b0a93e9a426c0a6468aa58fdd5022c5fcbb08d6"
 SRC_URI[libc-0.2.172.sha256sum] = "d750af042f7ef4f724306de029d18836c26c1765a54a6a3f094cbd23a7267ffa"
 SRC_URI[libz-sys-1.1.22.sha256sum] = "8b70e7a7df205e92a1a4cd9aaae7898dac0aa555503cc0a649494d0d60e7651d"
 SRC_URI[linux-raw-sys-0.9.4.sha256sum] = "cd945864f07fe9f5371a27ad7b52a172b4b499999f1d97574c9fa68373937e12"
@@ -347,7 +347,7 @@ SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e
 SRC_URI[ppv-lite86-0.2.21.sha256sum] = "85eae3c4ed2f50dcfe72643da4befc30deadb458a9b590d720cde2f2b1e97da9"
 SRC_URI[proc-macro-crate-1.1.0.sha256sum] = "1ebace6889caf889b4d3f76becee12e90353f2b8c7d875534a71e5742f8f6f83"
 SRC_URI[proc-macro2-1.0.95.sha256sum] = "02b3e5e68a3a1a02aad3ec490a98007cbc13c37cbe84a3cd7b8e406d76e7f778"
-SRC_URI[psl-2.1.215.sha256sum] = "caff7403e06671f170c65dc7bf475ed31d6e108c7e0d2440fb4df8ba56cfded6"
+SRC_URI[psl-2.1.241.sha256sum] = "c7319b480e204d67e759cad7886178335d26324c7c8573c126cc9dfa7350d064"
 SRC_URI[psl-types-2.0.11.sha256sum] = "33cb294fe86a74cbcf50d4445b37da762029549ebeea341421c7c70370f86cac"
 SRC_URI[quote-1.0.40.sha256sum] = "1885c039570dc00dcb4ff087a89e185fd56bae234ddc7f056a945bf36467248d"
 SRC_URI[radix_trie-0.2.1.sha256sum] = "c069c179fcdc6a2fe24d8d18305cf085fdbd4f922c041943e203685d6a1c58fd"
@@ -2073,12 +2073,12 @@ SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5
 SRC_URI += " \
     crate://crates.io/base-x/0.2.11 \
     crate://crates.io/bumpalo/3.20.3 \
-    crate://crates.io/cfg-if/1.0.4 \
+    crate://crates.io/cfg-if/1.0.5 \
     crate://crates.io/colored/2.2.0 \
     crate://crates.io/const_fn/0.4.12 \
-    crate://crates.io/crossbeam-deque/0.8.6 \
-    crate://crates.io/crossbeam-epoch/0.9.18 \
-    crate://crates.io/crossbeam-utils/0.8.21 \
+    crate://crates.io/crossbeam-deque/0.8.8 \
+    crate://crates.io/crossbeam-epoch/0.9.21 \
+    crate://crates.io/crossbeam-utils/0.8.23 \
     crate://crates.io/darling/0.10.2 \
     crate://crates.io/darling_core/0.10.2 \
     crate://crates.io/darling_macro/0.10.2 \
@@ -2086,29 +2086,29 @@ SRC_URI += " \
     crate://crates.io/derive_builder/0.9.0 \
     crate://crates.io/derive_builder_core/0.9.0 \
     crate://crates.io/discard/1.0.4 \
-    crate://crates.io/either/1.16.0 \
+    crate://crates.io/either/1.19.0 \
     crate://crates.io/fnv/1.0.7 \
     crate://crates.io/ident_case/1.0.1 \
     crate://crates.io/itoa/1.0.18 \
-    crate://crates.io/lazy_static/1.5.0 \
-    crate://crates.io/libc/0.2.186 \
-    crate://crates.io/memchr/2.8.2 \
+    crate://crates.io/lazy_static/1.5.1 \
+    crate://crates.io/libc/0.2.190 \
+    crate://crates.io/memchr/2.8.3 \
     crate://crates.io/once_cell/1.21.4 \
     crate://crates.io/proc-macro-hack/0.5.20+deprecated \
-    crate://crates.io/proc-macro2/1.0.106 \
+    crate://crates.io/proc-macro2/1.0.107 \
     crate://crates.io/psl-types/2.0.11 \
-    crate://crates.io/quote/1.0.46 \
+    crate://crates.io/quote/1.0.47 \
     crate://crates.io/rayon/1.12.0 \
     crate://crates.io/rayon-core/1.13.0 \
     crate://crates.io/rspec/1.0.0 \
     crate://crates.io/rustc_version/0.2.3 \
-    crate://crates.io/rustversion/1.0.22 \
+    crate://crates.io/rustversion/1.0.23 \
     crate://crates.io/semver/0.9.0 \
     crate://crates.io/semver-parser/0.7.0 \
-    crate://crates.io/serde/1.0.228 \
-    crate://crates.io/serde_core/1.0.228 \
-    crate://crates.io/serde_derive/1.0.228 \
-    crate://crates.io/serde_json/1.0.150 \
+    crate://crates.io/serde/1.0.229 \
+    crate://crates.io/serde_core/1.0.229 \
+    crate://crates.io/serde_derive/1.0.229 \
+    crate://crates.io/serde_json/1.0.151 \
     crate://crates.io/sha1/0.6.1 \
     crate://crates.io/sha1_smol/1.0.1 \
     crate://crates.io/standback/0.2.17 \
@@ -2118,16 +2118,16 @@ SRC_URI += " \
     crate://crates.io/stdweb-internal-runtime/0.1.5 \
     crate://crates.io/strsim/0.9.3 \
     crate://crates.io/syn/1.0.109 \
-    crate://crates.io/syn/2.0.118 \
+    crate://crates.io/syn/3.0.6 \
     crate://crates.io/time/0.2.27 \
     crate://crates.io/time-macros/0.1.1 \
     crate://crates.io/time-macros-impl/0.1.2 \
-    crate://crates.io/unicode-ident/1.0.24 \
+    crate://crates.io/unicode-ident/1.0.26 \
     crate://crates.io/version_check/0.9.5 \
-    crate://crates.io/wasm-bindgen/0.2.126 \
-    crate://crates.io/wasm-bindgen-macro/0.2.126 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.126 \
-    crate://crates.io/wasm-bindgen-shared/0.2.126 \
+    crate://crates.io/wasm-bindgen/0.2.129 \
+    crate://crates.io/wasm-bindgen-macro/0.2.129 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.129 \
+    crate://crates.io/wasm-bindgen-shared/0.2.129 \
     crate://crates.io/winapi/0.3.9 \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
     crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
@@ -2141,17 +2141,17 @@ SRC_URI += " \
     crate://crates.io/windows_x86_64_gnu/0.52.6 \
     crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
     crate://crates.io/windows_x86_64_msvc/0.52.6 \
-    crate://crates.io/zmij/1.0.21 \
+    crate://crates.io/zmij/1.0.23 \
 "
 
 SRC_URI[base-x-0.2.11.sha256sum] = "4cbbc9d0964165b47557570cce6c952866c2678457aca742aafc9fb771d30270"
 SRC_URI[bumpalo-3.20.3.sha256sum] = "72f5acc6cb2ba439de613abc23857ec3d78374d8ed5ac84e9d11336e87da8649"
-SRC_URI[cfg-if-1.0.4.sha256sum] = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
+SRC_URI[cfg-if-1.0.5.sha256sum] = "4e7648175b45a9a48536d676f68d918270699102aa8dab5496df06904c914600"
 SRC_URI[colored-2.2.0.sha256sum] = "117725a109d387c937a1533ce01b450cbde6b88abceea8473c4d7a85853cda3c"
 SRC_URI[const_fn-0.4.12.sha256sum] = "413d67b29ef1021b4d60f4aa1e925ca031751e213832b4b1d588fae623c05c60"
-SRC_URI[crossbeam-deque-0.8.6.sha256sum] = "9dd111b7b7f7d55b72c0a6ae361660ee5853c9af73f70c3c2ef6858b950e2e51"
-SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
-SRC_URI[crossbeam-utils-0.8.21.sha256sum] = "d0a5c400df2834b80a4c3327b3aad3a4c4cd4de0629063962b03235697506a28"
+SRC_URI[crossbeam-deque-0.8.8.sha256sum] = "622f3fc73690be383c7214310406f28a90e6edeadc3cea882f9d71e495b9711a"
+SRC_URI[crossbeam-epoch-0.9.21.sha256sum] = "dc74980687109a3b14c72fd458107bf0baa1da1a1a805e178d15501ba9b86d9d"
+SRC_URI[crossbeam-utils-0.8.23.sha256sum] = "a31eee39dddec8330830986fcd7625edb5a24ec90ea038215273bbc3adb08ac6"
 SRC_URI[darling-0.10.2.sha256sum] = "0d706e75d87e35569db781a9b5e2416cff1236a47ed380831f959382ccd5f858"
 SRC_URI[darling_core-0.10.2.sha256sum] = "f0c960ae2da4de88a91b2d920c2a7233b400bc33cb28453a2987822d8392519b"
 SRC_URI[darling_macro-0.10.2.sha256sum] = "d9b5a2f4ac4969822c62224815d069952656cadc7084fdca9751e6d959189b72"
@@ -2159,29 +2159,29 @@ SRC_URI[derive-new-0.5.9.sha256sum] = "3418329ca0ad70234b9735dc4ceed10af4df60eff
 SRC_URI[derive_builder-0.9.0.sha256sum] = "a2658621297f2cf68762a6f7dc0bb7e1ff2cfd6583daef8ee0fed6f7ec468ec0"
 SRC_URI[derive_builder_core-0.9.0.sha256sum] = "2791ea3e372c8495c0bc2033991d76b512cd799d07491fbd6890124db9458bef"
 SRC_URI[discard-1.0.4.sha256sum] = "212d0f5754cb6769937f4501cc0e67f4f4483c8d2c3e1e922ee9edbe4ab4c7c0"
-SRC_URI[either-1.16.0.sha256sum] = "91622ff5e7162018101f2fea40d6ebf4a78bbe5a49736a2020649edf9693679e"
+SRC_URI[either-1.19.0.sha256sum] = "0e9c71c2167ca323c882b99918929403426e2373ea17242ff5653e0d5e1058be"
 SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
 SRC_URI[ident_case-1.0.1.sha256sum] = "b9e0384b61958566e926dc50660321d12159025e767c18e043daf26b70104c39"
 SRC_URI[itoa-1.0.18.sha256sum] = "8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682"
-SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
-SRC_URI[libc-0.2.186.sha256sum] = "68ab91017fe16c622486840e4c83c9a37afeff978bd239b5293d61ece587de66"
-SRC_URI[memchr-2.8.2.sha256sum] = "88904434abc2901f197fe8cc55f0445e7ded921dba5911dad2e2b39b48e663c4"
+SRC_URI[lazy_static-1.5.1.sha256sum] = "20870f649af7073d53e38067b2a84312175d56ea15217e1b15bc83506ec50afb"
+SRC_URI[libc-0.2.190.sha256sum] = "ce5d3ddc6d3fa000eb1536d85e147bfe31aacaba692ed6a876f95cb7c855be78"
+SRC_URI[memchr-2.8.3.sha256sum] = "cf8baf1c55e62ffcace7a9f06f4bd9cd3f0c4beb022d3b367256b91b87513d98"
 SRC_URI[once_cell-1.21.4.sha256sum] = "9f7c3e4beb33f85d45ae3e3a1792185706c8e16d043238c593331cc7cd313b50"
 SRC_URI[proc-macro-hack-0.5.20+deprecated.sha256sum] = "dc375e1527247fe1a97d8b7156678dfe7c1af2fc075c9a4db3690ecd2a148068"
-SRC_URI[proc-macro2-1.0.106.sha256sum] = "8fd00f0bb2e90d81d1044c2b32617f68fcb9fa3bb7640c23e9c748e53fb30934"
+SRC_URI[proc-macro2-1.0.107.sha256sum] = "985e7ec9bb745e6ce6535b544d84d6cd6f7ad8bd711c398938ae983b91a766d9"
 SRC_URI[psl-types-2.0.11.sha256sum] = "33cb294fe86a74cbcf50d4445b37da762029549ebeea341421c7c70370f86cac"
-SRC_URI[quote-1.0.46.sha256sum] = "dfbc457d0c7a0759a614551b11a6409e5951f6c7537be1f1b7682b9ae9230368"
+SRC_URI[quote-1.0.47.sha256sum] = "1fbf4db142a473a8d80c26bbf18454ed458bf8d26c8219c331daecfdbd079001"
 SRC_URI[rayon-1.12.0.sha256sum] = "fb39b166781f92d482534ef4b4b1b2568f42613b53e5b6c160e24cfbfa30926d"
 SRC_URI[rayon-core-1.13.0.sha256sum] = "22e18b0f0062d30d4230b2e85ff77fdfe4326feb054b9783a3460d8435c8ab91"
 SRC_URI[rspec-1.0.0.sha256sum] = "89389e7c690310e855df3d9b507985ca0d323e2e766b2fedf369b02671e70e0a"
 SRC_URI[rustc_version-0.2.3.sha256sum] = "138e3e0acb6c9fb258b19b67cb8abd63c00679d2851805ea151465464fe9030a"
-SRC_URI[rustversion-1.0.22.sha256sum] = "b39cdef0fa800fc44525c84ccb54a029961a8215f9619753635a9c0d2538d46d"
+SRC_URI[rustversion-1.0.23.sha256sum] = "cf54715a573b99ac80df0bc206da022bcd442c974952c7b9720069370852e21f"
 SRC_URI[semver-0.9.0.sha256sum] = "1d7eb9ef2c18661902cc47e535f9bc51b78acd254da71d375c2f6720d9a40403"
 SRC_URI[semver-parser-0.7.0.sha256sum] = "388a1df253eca08550bef6c72392cfe7c30914bf41df5269b68cbd6ff8f570a3"
-SRC_URI[serde-1.0.228.sha256sum] = "9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e"
-SRC_URI[serde_core-1.0.228.sha256sum] = "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
-SRC_URI[serde_derive-1.0.228.sha256sum] = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
-SRC_URI[serde_json-1.0.150.sha256sum] = "e8014e44b4736ed0538adeecded0fce2a272f22dc9578a7eb6b2d9993c74cfb9"
+SRC_URI[serde-1.0.229.sha256sum] = "4148590afebada386688f18773da617792bf2ef03ffc1e4cbd2b1d45b023e0ba"
+SRC_URI[serde_core-1.0.229.sha256sum] = "67dca2c9c51e58a4791a4b1ed58308b39c64224d349a935ab5039aa360942a48"
+SRC_URI[serde_derive-1.0.229.sha256sum] = "e7a5d71263a5a7d47b41f6b3f06ba276f10cc18b0931f1799f710578e2309348"
+SRC_URI[serde_json-1.0.151.sha256sum] = "c841b55ecdae098c80dcae9cf767f6f8a0c2cdb3416bbef72181df4d0fe73f14"
 SRC_URI[sha1-0.6.1.sha256sum] = "c1da05c97445caa12d05e848c4a4fcbbea29e748ac28f7e80e9b010392063770"
 SRC_URI[sha1_smol-1.0.1.sha256sum] = "bbfa15b3dddfee50a0fff136974b3e1bde555604ba463834a7eb7deb6417705d"
 SRC_URI[standback-0.2.17.sha256sum] = "e113fb6f3de07a243d434a56ec6f186dfd51cb08448239fe7bcae73f87ff28ff"
@@ -2191,16 +2191,16 @@ SRC_URI[stdweb-internal-macros-0.2.9.sha256sum] = "58fa5ff6ad0d98d1ffa8cb115892b
 SRC_URI[stdweb-internal-runtime-0.1.5.sha256sum] = "213701ba3370744dcd1a12960caa4843b3d68b4d1c0a5d575e0d65b2ee9d16c0"
 SRC_URI[strsim-0.9.3.sha256sum] = "6446ced80d6c486436db5c078dde11a9f73d42b57fb273121e160b84f63d894c"
 SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
-SRC_URI[syn-2.0.118.sha256sum] = "1b9ae57f904213ebb649ce6895b8a66c66f0203b9319718f69a5612a065b1422"
+SRC_URI[syn-3.0.6.sha256sum] = "8593e8e72159ed2257d083c7a454a85cbf854f37a0966d8d483aff8c8a3ebcee"
 SRC_URI[time-0.2.27.sha256sum] = "4752a97f8eebd6854ff91f1c1824cd6160626ac4bd44287f7f4ea2035a02a242"
 SRC_URI[time-macros-0.1.1.sha256sum] = "957e9c6e26f12cb6d0dd7fc776bb67a706312e7299aed74c8dd5b17ebb27e2f1"
 SRC_URI[time-macros-impl-0.1.2.sha256sum] = "fd3c141a1b43194f3f56a1411225df8646c55781d5f26db825b3d98507eb482f"
-SRC_URI[unicode-ident-1.0.24.sha256sum] = "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
+SRC_URI[unicode-ident-1.0.26.sha256sum] = "d245f478577f809a851594d02313b640fb437e0bb33866753cff937863096954"
 SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
-SRC_URI[wasm-bindgen-0.2.126.sha256sum] = "4b067c0c11094aef6b7a801c1e34a26affafdf3d051dba08456b868789aaf9a4"
-SRC_URI[wasm-bindgen-macro-0.2.126.sha256sum] = "167ce5e579f6bcf889c4f7175a8a5a585de84e8ff93976ce393efa5f2837aab1"
-SRC_URI[wasm-bindgen-macro-support-0.2.126.sha256sum] = "f3997c7839262f4ef12cf90b818d6340c18e80f263f1a94bf157d0ec4420380e"
-SRC_URI[wasm-bindgen-shared-0.2.126.sha256sum] = "dc1b4cb0cc549fcf58d7dfc081778139b3d283a081644e833e84682ad71cea24"
+SRC_URI[wasm-bindgen-0.2.129.sha256sum] = "9bb54f33acc68fd454578d9820b0bde1a1a3d17aa17bb7b6595806d02886d409"
+SRC_URI[wasm-bindgen-macro-0.2.129.sha256sum] = "2e29d0c35b16e224a7eeb5cd2d25e3e1968fbd65604117b44d3b789d00ee8535"
+SRC_URI[wasm-bindgen-macro-support-0.2.129.sha256sum] = "6f501a8bc3719dba86ef8ae4728879c08001bea749eb1333ac5b91e040e2a6b7"
+SRC_URI[wasm-bindgen-shared-0.2.129.sha256sum] = "23f0c9c52aa7cd7d77769a4cfe2a9adb1b331f489a41d912ce14513d5ab995c6"
 SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
@@ -2214,7 +2214,7 @@ SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffc
 SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
 SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
 SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
-SRC_URI[zmij-1.0.21.sha256sum] = "b8848ee67ecc8aedbaf3e4122217aff892639231befc6a1b58d29fff4c2cabaa"
+SRC_URI[zmij-1.0.23.sha256sum] = "29666d0abbfad1e3dc4dcf6144730dd3a3ab225bbbdac83319345b1b44ccfc1b"
 # from rust/vendor/valuable/Cargo.lock
 SRC_URI += " \
     crate://crates.io/aho-corasick/1.1.3 \
@@ -3148,4 +3148,3 @@ SRC_URI[wasm-bindgen-shared-0.2.68.sha256sum] = "1d649a3145108d7d3fbcde896a468d1
 SRC_URI[web-sys-0.3.45.sha256sum] = "4bf6ef87ad7ae8008e15a355ce696bed26012b7caa21605188cfd8214ab51e2d"
 SRC_URI[winapi-0.2.8.sha256sum] = "167dc9d6949a9b857f3451275e911c3f44255842c1f7a76f33c55103a909087a"
 SRC_URI[winapi-build-0.1.1.sha256sum] = "2d315eee3b34aca4797b2da6b13ed88266e6d612562a0c46390af8299fc699bc"
-
diff --git a/recipes-ids/suricata/suricata_8.0.6.bb b/recipes-ids/suricata/suricata_8.0.8.bb
similarity index 98%
rename from recipes-ids/suricata/suricata_8.0.6.bb
rename to recipes-ids/suricata/suricata_8.0.8.bb
index 29f259b..3aa2a31 100644
--- a/recipes-ids/suricata/suricata_8.0.6.bb
+++ b/recipes-ids/suricata/suricata_8.0.8.bb
@@ -5,7 +5,7 @@ require suricata.inc
 LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=c70d8d3310941dcdfcd1e02800a1f548"
 
 SRC_URI = "http://www.openinfosecfoundation.org/download/suricata-${PV}.tar.gz"
-SRC_URI[sha256sum] = "b264584edda4a3b2b462050099c7c54f4f35ac0c7164e41084be9b216c090f8c"
+SRC_URI[sha256sum] = "bb56bbaeb4da81b4c90e61148f93b789ea924412207388bc9cba0a7ac6a24a8f"
 
 DEPENDS = "jansson lz4"
 DEPENDS:append:libc-musl = " libunwind"
-- 
2.47.3

