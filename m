Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9675.1795884895337079367
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:54:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZJQhzSGC;
 spf=pass (domain: konsulko.com, ip: 209.85.128.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so77634735e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884893; x=1796489693; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LZYq2G6jk+mLS6U1CmhS6Bx0pR8d8cYKJmzFGzz6A+M=;
        b=ZJQhzSGCRAWUQ+PXNQIXw5xzMXY1PDch6r++sLfukr5vtCseMmKfgsU9rbN/5jwiLp
         BqqqYICT5ANfbi5tqW1fnLhksdCT+4/z0QnPV7acwXNgTI7KfzLdKfy5G3YSZLuFP5K2
         SyxWR44kDA8u2YzMR8KNLinP4TIfElbToQlrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884893; x=1796489693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LZYq2G6jk+mLS6U1CmhS6Bx0pR8d8cYKJmzFGzz6A+M=;
        b=vxFLdTa2rbIYAVCRQqVUpM3zl1jdnUsKK8XP0HKBPmAad3uA05qgSxxN0CgYQra+zo
         B/4HLU4FTaA1Vwxa3cjSWKwDNigS1p2ZrUwRuuo4hk6/BXn3hexiBi0jQwd0yyh/KQf9
         ah2SOYGK5fRUItJmxnl8HvUvtX/uatHidpjYAm4+/oYakgU4b6GIVizVaGCHEqXhYlWe
         6zQRHm1uoVjNJzzhZ2L9PSPcP3B9sT0hG56E1yCqz/IvJZD0SJD6lAMggqW5BKSaEDAR
         hya/Taq06yMmvPY03aSUfFe88omRX3TGUAqIjQoNsBYszCxET1ipB89l4St0Id73c8hH
         TtUw==
X-Gm-Message-State: APuU4Z9wcZYi2pQ5t4DiMtOfoV8PBDD3QSgX2wTorLuPO6uspH6vCmw3
	wbLqSIvYwNvDrK6Zm32q++NGCqxQZ5mqdYGBXafZYR+g6b/cUrN1g2AgIWn+NpCFgWdur5/zGNB
	R7uUHtGE=
X-Gm-Gg: AZFdTZdR3lxvzePjXJfBKt5G6BdmRFWwtd+Yn/aiOeCdKSV8rn+GtUh28kynL2xxEFc
	HdvdHt6Ctwds4JCC9QvqppK3X8tW1vQYkPKi/ICUtgnAsVexe3gvTtbW7gLlPUgZVAL7l1eH515
	bhy7A77TDGF5GR2SmPZKWC+dviKH/i06kDPjHwvDyAzK0toiD0lJWZ5Z0cuhnwROfLSteEEJ0vE
	NcdB97TvZN2A06bjVG6/2pfxlVjTu3+dDCWwG1ctriyYl/eRyl7phyJFfwJqw5VFntA2lA1Pgpc
	3K2nf7c4ad0N1uOqil0UR3aPemJXXo6We7gQh2PLNX3L1thAAyyetrChCSUpptDKHaeDdNOZLuR
	+JWHMpvTo4eVHIyXHp0soYZadB2zKU1pSHEXodvd7W7zUZKdSpvHlBY+U2K+cBvZ0gmoUg9mJdZ
	O0iGRMjOcg7143Rpky4DdlaT0fPrxRITj4iaPAX43LoDGmL0twM8HYb7E90argyviz5SspqmYu+
	DW1A6ZwCJvMejJsf2znM4OOe0ieXaI8pYrlfFaYu1ONzS4BMmhu+QVLZQ5i5RrfKzfzLWBjdE2E
	L0/pwid76wNS4W/Mf/6L4SMMDHI/5AIqsWGM92eP/F1fMOJnwV+zDqAuGuckWr1pnV3OV2yolh1
	fmU+0Dxk5/xckbBK7Nu0GqVIe4knGE9Y=
X-Received: by 2002:a05:600c:46d0:b0:4bb:8711:fee8 with SMTP id 5b1f17b1804b1-4bb8881894amr568506735e9.20.1795884893479;
        Sat, 28 Nov 2026 08:54:53 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:53 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 08/14] parsec-tool: Fix building with Rust 1.100
Date: Sat, 28 Nov 2026 18:54:26 +0200
Message-ID: <059074762b2524f3347f7fcd6377e7fced773576.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:55:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5578
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

