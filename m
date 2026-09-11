Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D5AC88E4D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:15:29 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48564.1789157723185254219
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:15:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=KxeWukgx;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530de452c33so3301751cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157722; x=1789762522; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zXixsP/xMjD9AiBgxF3ZZZcEo5D+l8HT/HD38ULqKOg=;
        b=KxeWukgxAkIRancMR5XQoxF9yWQP+k9plOS7+aLvDrKougPKd4lyeqxaL6Sl7jf3MG
         iJcoC09NqlJQPWLg9jnFCtvnM8qW8FSRDHCNPBS5B6j7mdEyFcOz8DR8dgPWysomA22r
         8wrqcLGWJATYJ6X8BGQ3jk0NSyPJDPsgZ1sCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157722; x=1789762522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zXixsP/xMjD9AiBgxF3ZZZcEo5D+l8HT/HD38ULqKOg=;
        b=GOjavSdd95Ln3l0QRODNBQAp3ra/Xt0a4dask6GE3RX0HLIZDNKDq+qUkvGIqPs8o0
         WhzaFC2Pn50wXt6OJNX1Haf1f3KAGCUlRInGmSAEmJdpAT1VQzhRcO++IFYKeO9pT7nu
         ZXBZ2szjIzfMgUPqBFy/PcT30X0a0v2g2e+VqjFnNTYcHmrgm5Ws75pOa39EbEaierMT
         KdavIvOs2bCms+O4VfVWnSCQoqg2YttOoShs/mEF4DtQfrOJ6IuidBWZlnVNjOb5XrS6
         dBRNqtf/HQRzB3jlclg+fkTee18JWZGuwFIS7OyTOEiLo/sZ6MpVjVRktS+mwvv+J5Cg
         IIGg==
X-Gm-Message-State: AFuF++lBa/xG0PV0WI1dXRgLo5pqDpqO3YA/QZp0JDlQdbLh1Cg+GX+7
	FH8lbUKF2wobfXeiANIvHRugkHHdJrC4Hx+0tRqTEPIZjjcCNnOZUa9jB1aPxYhDoCkjFExuCiB
	wwA5O
X-Gm-Gg: AYBFou0pBbs12d/AhywQb1ByS47oJ3Lt90GsHCqn27t+BcNfyeXNZP/e1ykRu7xg5Yn
	Em/icAW05M6+bp9ViqcJXGpbmg+iWm6fxBo+i3+IfdqvdpiY66kH6rPDJOnUFONXOWiOawRJHJB
	Z1F2iSlS4AVKwL3uvHARTblonyFjICCD7Xaxx5BGO0BrERLuucoBjDH/uPgrVmPB7aMxo8bJo/W
	fazE9jIb+2q97UcPUgUundQzt2TXy5wbbvLy9AJeGhMP/JaV/brsHUQyU/10tJDfcgkmy/NXCaW
	1SIWrUPARXW3Nm/+kIqE9ddGZ+v2d1eEGPpRhq29H0NUSFAukLr72iTt2XH2r7+GziixEkfVsbt
	iI3IApfNSVA0xBoMF5ox5dNFf+B/TX3/8hqkx+jqz/+butSanMVdvW+/c2QfKmNBqeLR7irhEsI
	sSAX1tvkex8ISdNCD1fuh1ba4+G13wgONvisChLh/rINHRZB+zzTfq+tdShSN+vG8b3MlB1EaHl
	zy2hWf3aUyuCcWAOMW9DLHgheUNrWXZkKJq4KCPbjC9bSogFOV7FYfuqNRstsAGsZzPcZjGJSi6
	0HIVnfQ5XdM5Z6SeznUE4LEVA7I307+3ArIZD7BnlisW9g==
X-Received: by 2002:ac8:5d56:0:b0:530:743f:d51 with SMTP id d75a77b69052e-530c852abf2mr88715191cf.10.1789157721815;
        Fri, 11 Sep 2026 13:15:21 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4b699bsm28930706d6.37.2026.09.11.13.15.21
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:15:21 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 01/11] rust: patch uninative loader into snapshot's self-contained lld
Date: Fri, 11 Sep 2026 16:15:05 -0400
Message-ID: <a53cc17b0ff0fb6aedd30eebef75d106f2e27f24.1789155804.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789155804.git.scott.murray@konsulko.com>
References: <cover.1789155804.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:15:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4805

From: Markus Volk <f_l_k@t-online.de>

Since Rust 1.90, rustc defaults to using the self-contained lld
linker (lib/rustlib/<triple>/bin/gcc-ld/ld.lld, which execs
rust-lld) on x86_64-unknown-linux-gnu.

https://blog.rust-lang.org/2025/09/01/rust-lld-on-1.90.0-stable/

This applies to the snapshot compiler used to bootstrap the target
rustc, before the rust.lld/use-lld settings in the config.toml we
generate for the target compiler can take effect. Without patching
these too, they fail to exec on build hosts without a /lib64
compatibility path.

collect2: fatal error: posix_spawnp: No such file or directory
|           compilation terminated.
|
|
| error: linking with
`/home/flk/bitbake/bitbake-builds/master/build/tmp/work/x86_64-linux/rust-native/1.96.1/wrapper/target-rust-ccld`
failed: exit status: 1

Signed-off-by: Markus Volk <f_l_k@t-online.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 9db020032ee1f328bfab7ca7842d7725777e487e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.96.1.bb | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/recipes-devtools/rust/rust_1.96.1.bb b/recipes-devtools/rust/rust_1.96.1.bb
index 177ea32..a5bfc25 100644
--- a/recipes-devtools/rust/rust_1.96.1.bb
+++ b/recipes-devtools/rust/rust_1.96.1.bb
@@ -69,8 +69,12 @@ do_rust_setup_snapshot () {
     # Need to use uninative's loader if enabled/present since the library paths
     # are used internally by rust and result in symbol mismatches if we don't
     if [ ! -z "${UNINATIVE_LOADER}" -a -e "${UNINATIVE_LOADER}" ]; then
-        for bin in cargo rustc rustdoc; do
-            patchelf ${WORKDIR}/rust-snapshot/bin/$bin --set-interpreter ${UNINATIVE_LOADER}
+        for bin in ${WORKDIR}/rust-snapshot/bin/cargo \
+                   ${WORKDIR}/rust-snapshot/bin/rustc \
+                   ${WORKDIR}/rust-snapshot/bin/rustdoc \
+                   ${WORKDIR}/rust-snapshot/lib/rustlib/*/bin/rust-lld \
+                   ${WORKDIR}/rust-snapshot/lib/rustlib/*/bin/gcc-ld/*; do
+            [ -f "$bin" ] && patchelf "$bin" --set-interpreter ${UNINATIVE_LOADER}
         done
     fi
 }
-- 
2.55.0


