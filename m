Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70CED19534
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:51:40 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36299.1769471496591145695
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:51:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ukeZ3BbT;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c53198a65fso523984785a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471495; x=1770076295; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVujn9XOYAHAbFCK9gxUaHhjkFqqZB+uMO//Z+xjUE4=;
        b=ukeZ3BbTViaR7v4hY021itXhqEaufxYdB5I9AmsyyOjQ7iY5IUb20W5S6EO+wYmDiJ
         m9hBG4mw2XOasJuqfTRKyVs3EeWk/PGnahOCgXsDySk+HMzUhlYOWYRIZx+xX66ru4d4
         eefSLPFciWgrsZtaRNknYAxCGrFeUsonoJsnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471495; x=1770076295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MVujn9XOYAHAbFCK9gxUaHhjkFqqZB+uMO//Z+xjUE4=;
        b=W3m66ubicLOR1EtM6CRA43Mc/vCVrj5WWeUC5RMpM/qECSGIfta8iVujHuNqeWXV9n
         CsqPQY/M90UUgW2uuos5oW9l2NfgMca1Xw+yKMkOawPSHHdDLV35W/ASyUtwjovdXGbU
         +iJOZRIg9yWRd5uf+64XkIorfC31f2YPzk9KSCvHg8laaYWi51zdkhHSdRfhJLAE5lyD
         uTFKcKeSZ7QzgU27CDPFHOPmbHXJlv2jUSIKHJjofkoKODmyJxNi8ETuqynNp4e/B/N1
         8vyfWQTLoQLpzql+3tUMTUYpg50Wu+noGxzzU1XC0e1onBadzc1QAlndjrBtQXFavzto
         IDKQ==
X-Gm-Message-State: AOJu0YynFuWDfglO9kMzGG469WNPmk+vef1fbcFPhW8CphnTOl7pW2qm
	xZx+B6FF/tstbm3fRx1QXpq6z6+Bi8DyZ1cevYaChtL/drMzpuZm3Lrn4afntURAQqWm3EMDZk5
	TZbO/K5g=
X-Gm-Gg: AZuq6aJ+iDc68GDLvDCIiw4di2eKONurbNav9Di/cCyfypzwjAmYk9eTTyaTJw2NPA+
	xZOJzy7TFe3jemWx6/t8/+ChWIGb7pxpXo8/xTu9OKTceWcbLtvXEBVJ4+HexjGOVTlV1SAowqQ
	hu5MlqBmHRUtFy8yaHyRFpryiRuCaMVeap4JvcP3sgKpKaODNrNhpArN2mXZpZdv2TaWn6WbgTU
	41oBDFC0KzuGwZVPtM0AlupON33WZhtYjrGIyviy8A8846DsW/bCiYdXC8qM7cAbzBptu7zx9NM
	4ZmhPLhVYShE/FB9SQX7r5y3mIR0dl7c4zZAj4CKOUgqgIfUumX1jTDYEnfTUojHvbsL+PZuWPh
	LRQHw3IH9KNhZZ/c2M1YYjC86gcmt7oY/ux18/lq9UumskMxjAwxYBSU05MYq39XHv+ewNt9tdw
	qDsyBuPUvssrwgSxB9+eI0ckuHIShF4ejYCBsObfi756CIwQaL1Ux1vK8EP1FEzCvjqbSA+BSY1
	Zz5SPZeJ5QH/dLh5poX93P3t3EDcobA+ANRlT3VehsXqktGgn3x
X-Received: by 2002:a05:620a:2236:b0:8b2:e827:14bc with SMTP id af79cd13be357-8c6f963ba17mr554372385a.56.1769471495423;
        Mon, 26 Jan 2026 15:51:35 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061293885a.15.2026.01.26.15.51.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:51:35 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 08/11] rust: enable default uwtable and ignore arm no_std test
Date: Mon, 26 Jan 2026 18:51:12 -0500
Message-ID: <dfb1147d77a3af857a89f575d0928cdc3a72de1e.1769470900.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769470900.git.scott.murray@konsulko.com>
References: <cover.1769470900.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:51:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3098

From: Hemanth Kumar M D <hemanth.250302@gmail.com>

Rust 1.92.0 adds new test that require unwind table support to be
enabled by default. Set `default-uwtable = true` in the generated
target spec to match upstream behavior.

ref:https://github.com/rust-lang/rust/commit/fe66eaa67acc47525db6f13cf97d54780d87b805

Also ignore the no_std simple-runs UI test on ARM targets. The test
fails with panic=abort due to a known unwind table issue on 32-bit ARM

https://github.com/rust-lang/rust/issues/146996

Signed-off-by: Hemanth Kumar M D <hemanth.250302@gmail.com>
Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit f38b4e8b35d6ce2dba9c1f933e3b22b22c065574)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass          |  1 +
 recipes-devtools/rust/files/rust-oe-selftest.patch | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index 1f3b071..41e5362 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -401,6 +401,7 @@ def rust_gen_target(d, thing, wd, arch):
         tspec['llvm-floatabi'] = "soft"
     elif fpu == "hard":
         tspec['llvm-floatabi'] = "hard"
+    tspec['default-uwtable'] = True
     tspec['dynamic-linking'] = True
     tspec['executables'] = True
     tspec['linker-is-gnu'] = True
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index b39b326..d1fba81 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -254,3 +254,15 @@ index a3562f2fd93..d4e52ed91be 100644
      fn linux_hwcap2_aarch64() {
          let file =
              concat!(env!("CARGO_MANIFEST_DIR"), "/src/detect/test_data/linux-hwcap2-aarch64.auxv");
+diff --git a/tests/ui/no_std/simple-runs.rs b/tests/ui/no_std/simple-runs.rs
+index af44dfe..e6674e5 100644
+--- a/tests/ui/no_std/simple-runs.rs
++++ b/tests/ui/no_std/simple-runs.rs
+@@ -2,6 +2,7 @@
+ 
+ //@ run-pass
+ //@ compile-flags: -Cpanic=abort
++//@ ignore-arm FIXME(#146996)
+ //@ ignore-wasm different `main` convention
+ 
+ #![feature(lang_items)]
-- 
2.51.0


