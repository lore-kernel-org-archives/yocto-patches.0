Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D61C88E5C
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:04 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48521.1789157634289280659
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UhrGCZm0;
 spf=pass (domain: konsulko.com, ip: 209.85.160.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5306baf6b53so19003001cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157633; x=1789762433; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HsD0NtY94Wz3HCbEqfNYh/qFKbgMGgMQWJg0EIaw2Xs=;
        b=UhrGCZm0fuJtXNgjcOgOnRxl5am0OwzK+vODecAKF6xbQGvWvNtFsMlRuKrlN0FDG3
         JNDXomKokqcEwiqmdyGqgyvKCR3v2m7g13TNq2lFPEIrWPgT3WxDFoJE55cAK4IDujNU
         HesOy6Xxsi+pgJq0X1PCflhc5uJ6ugcPQ7mzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157633; x=1789762433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HsD0NtY94Wz3HCbEqfNYh/qFKbgMGgMQWJg0EIaw2Xs=;
        b=BIeb8kq1Af+PEmg6F5O7ed7lnD52QpnvxZP9C0vH7LfJuUO81Ani72BbO6gh0nDAz8
         J4dWp/Tdt1baMknfW4iI/BTqFKFrxKoUjICorKAswnpxHC0xW9OYeHfY5e+Q3yUBg5z4
         3RFPiOdygWj1V87GMJbFu+8xirVuYrWLiTW7w42qncMtYLc2WqmCSAFMJSMQNAz+NUt/
         +yRlIjNQNAMUbxA2cVjWTpyibmtAps2yTWZO0tTqd8FpXi1Tsypa9z74YqNS3Xg5xdEY
         WKBOOuhrIZ93z8QDeqkJYiam2o7UHiPCpmFLO2hg/Sb698NKFKOyb7RGdFrXUoze15Vc
         LrDg==
X-Gm-Message-State: AFuF++lJPw3AjfcgfT7j3h8i2JpROPAi7AqeLdVfNiVLcv3jI9nQLkoB
	19xO98Dp8IId9YKnDa36GcTohdvQEU9FrsQ7J104/DzdCgl075sm0kC5fM6XLWy+1Em6/Eqj5SL
	YVdHF
X-Gm-Gg: AYBFou3u1Rqjn0Abk82Ld3CJd0mqlfiYy1ugO1is2wWAh4087ysVrRsM8uHRJWmd6i2
	L2+OQilfI5Hw1ol4bUSB2wDr7nIKdqpBZSxZtIpRXZYQAE1Ft1pecRPv17bzuZ21JGhkZOzZXYh
	0RFMXK0ptvaG1zStYtIYSs/8KUB5b6DLvyXCmIxTjfqirQNLfWtFDLzS/iGW12TI5ADD2ZNWOp9
	9GwKl+tBILUMIzcebcjCTMhnLIY92OUUV3fRDXZLJsTrzPizS61hm6pvHJHQKfkDq3x3JQIOXLT
	oz/GoE4uBcIAvEE5i/Rh/DNXktq3YEKfX6Npn+3dTfBVT0fKI+ouhBxXJ1Wnmsuhz1m4XwHSZYL
	wBVcvLe1TTb2Bd0lmMZiehkF20XVYelwxl4h5cMVHYFkbEnffoJT0wMrTZBnCOU8dVTMj4V9cIR
	v7HBml+plO5D0/7GDJp/77bXTW5OSSXtLU465sOkbB/jBWfLWWE9j6k+WLoFHii5d3jRcASFDL5
	jSugqRibJqxMHc6BTVJvMOVLBi5AQlOlNTGtdd4m7UG1eMNBeNfN+V/N59t5ZbCzD4rcQI08jtx
	P3Inv9O3mSnAkLv29hksTlIfmZ2wTuWkR3U=
X-Received: by 2002:ac8:5a0f:0:b0:530:3542:c8ad with SMTP id d75a77b69052e-530c8714513mr89069371cf.36.1789157633012;
        Fri, 11 Sep 2026 13:13:53 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:52 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 15/37] rust-target-config: set MIPS ABI in the target JSON
Date: Fri, 11 Sep 2026 16:13:01 -0400
Message-ID: <8cce072b9d48e5171ac1b954f283dd5dda6f8f44.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4781

From: WXbet <WXbet@proton.me>

rustc 1.96 (rust-lang/rust#153769) started rejecting MIPS target JSON
files that do not carry both an "abi" field and a matching "llvm-
abiname" field, aborting libstd-rs's do_compile with

  error: error loading target specification:
         invalid MIPS ABI name and `cfg(target_abi)` combination:
         ABI name: <empty>
         cfg(target_abi): <empty>

rust_gen_target() populates the target JSON from the DATA_LAYOUT /
TARGET_ENDIAN / ... varflags plus an arch-specific "abi" branch that
today only covers arm/armv7. On mips*/mipsel* neither "abi" nor
"llvm-abiname" is written, so rustc's stricter check fails.

Cover every MIPS tune shipped in meta/conf/machine/include/mips/
arch-mips.inc's AVAILTUNES:

  arch=mips / mipsel                      -> o32
  arch=mips64 / mips64el, ABIEXTENSION="" -> n64
  arch=mips64 / mips64el, ABIEXTENSION=n32 -> n32

Note that the mips64-o32 / mips64el-o32 tunes (o32 ABI on a 64-bit
MIPS CPU) get MIPSPKGSFX_BYTE="" from arch-mips.inc and therefore
TUNE_ARCH="mips[el]"; they fall into the 32-bit branch above.

Signed-off-by: WXbet <57314510+WXbet@users.noreply.github.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 8042c1652f774434a0652ff28cd074ee7984d2b9)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index 33280ed..351c2d5 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -421,6 +421,13 @@ def rust_gen_target(d, thing, wd, arch):
         elif fpu == "hard":
             tspec['abi'] = "eabihf"
             tspec['llvm-floatabi'] = "hard"
+    if arch in ["mips", "mipsel"]:
+        tspec['abi'] = "o32"
+        tspec['llvm-abiname'] = "o32"
+    elif arch in ["mips64", "mips64el"]:
+        mips_abi = "n32" if abi == "n32" else "n64"
+        tspec['abi'] = mips_abi
+        tspec['llvm-abiname'] = mips_abi
     tspec['default-uwtable'] = True
     tspec['dynamic-linking'] = True
     tspec['executables'] = True
-- 
2.55.0


