Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C94CD1297
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:16:10 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13113.1762632969229872385
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:16:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WA0b864y;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so17667046d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762632968; x=1763237768; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exBiYf+5X7PmDCvzxqT+kDHBlv4aEMOvyPWG8JWZV00=;
        b=WA0b864y4pX0F1pYi/Qf0HxsaMwHUltCwi0s9lREKNJmlJftp8EEJMBEfWGzeFXwYu
         tr90l6wR/ta5bVysmlp3MX4NWNIDLB29Q6UiSut0xGkEEOXviesWweh1YfR5wtcKIvXG
         gjsRukQapDkTNBdl3QiDfhr0w+amMQLSBzZZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632968; x=1763237768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=exBiYf+5X7PmDCvzxqT+kDHBlv4aEMOvyPWG8JWZV00=;
        b=EXC4tkIAnlxRESWuuwNvRSKKD9FZXFTcjXK8b1mV6uOLI4pVnjxqIMXYdufvc6SXDF
         0PHbRNNa0I40vnjzA9Glvkvke6lYQ4ykbpYpdX2whHSByGTKZrOlTODvPNYylrOGBE4u
         nq9xIqZLYIUvcJgtg4SqefTN4o+l6dS9fHTfFpP3P6UOtuvBYTj8Qg4ysDktGrOJZtJ2
         4myOMN+OrwrmhFxDBAEu6l/PicqPA+WyMnns4Ojmxzm1SPPSCpj8M0oZHMo0lZUgrxXW
         tBaH6Tzj5tOpmxV+rAG4RAbc70b+ckb0DDV/2/0JVHVS/gBH9a7RgxH404618ffczNcp
         Ej2Q==
X-Gm-Message-State: AOJu0Yy1cozcH4JnQDSvUpUgcarM8S8vCaJDZZ/CJ0nG+aHwRsRcbwXK
	GTF20mJZ5v907B0fi2Ofy3NXNhCViOUdoyLduiSSWifq2vvuubUN9GuLjvDncNxj8807WZoYOvv
	zymqA
X-Gm-Gg: ASbGncvgWGSMysLCetoJXdykpubwMw0s9LSwNfWFwAnbWdQNxwzfuKZ1KEKJDZtjnkO
	xaZCBiwHG+BKE/DiNr9qxCUBILOs9FGodDQIpniNIASBTSrI+51RbHt2n+SIHdXmumJ2alzWUoJ
	G1X5U4LXdG3pbyln8jxwAFBVnwSIr8KkZGNoIyVPo3aNqN3Zxj8MHOApfXjdAm4eUMlbbnl4Ude
	ZJKY3J9Mg/7Z8qc8feD48psqAJVRr1rsnuHud7pLm/nbI/3Tg+trxPZtf6U8nRNtgP7Zro5bLzu
	lqCw9JZDkqwg7Yv2W/EAn45b3GB1MEQ0E42fKmb7OkgCwGBnmpwiJUqDgFV8w5YVi2p2SJWERM+
	O0imj7e+SGYH7zQ7dw0F36anhl7Kjz62lCFyZyTWfBM9DtibOVxkNxJboYlj3SCCzN7ES5Od04R
	4w67hB/zu5xz/PENohSejCwKMuCaHrkcFyqSEcloZ/hXqj3LjFahmaLX4OVHtexJQ=
X-Google-Smtp-Source: AGHT+IGWpMm2/TnQTnO1YVA4PGfkRyMGFbBw/hbA5QQjxQ+MOz2fAi0nLISbGgGwUUVs11ud8yFhgg==
X-Received: by 2002:a05:6214:242a:b0:87d:f969:6aac with SMTP id 6a1803df08f44-882377ff506mr49984366d6.0.1762632967921;
        Sat, 08 Nov 2025 12:16:07 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm20001896d6.53.2025.11.08.12.16.07
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:16:07 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 07/11] rust-target-config: PPC64 targets require explicit ABI selection to avoid build failures with rustc.
Date: Sat,  8 Nov 2025 15:15:49 -0500
Message-ID: <5310fa2143a00878a2e1e411d8a05e59295662e1.1762632742.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762632742.git.scott.murray@konsulko.com>
References: <cover.1762632742.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:16:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2441

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Without a specified ABI, rustc panics with the following error:
|   thread 'rustc' panicked at compiler/rustc_codegen_ssa/src/back/metadata.rs:394:21:
|   No ABI specified for this PPC64 ELF target.

This issue was occuring because of the following Rust commit:
https://github.com/rust-lang/rust/commit/9c1180b6238d163fc384d60d85647385d9210343

As noted in the upstream changes:
If the flags do not correctly indicate the ABI,
linkers such as ld.lld assume that the ppc64 object files are always ELFv2,
which leads to broken binaries if ELFv1 is used for the object files.

Because of this, it is now required to explicitly specify the ABI for PPC64 targets
using one of the following:
"elfv1" => EF_PPC64_ABI_ELF_V1,
"elfv2" => EF_PPC64_ABI_ELF_V2,

If no ABI is specified, the Rust compiler will panic with the error:
No ABI specified for this PPC64 ELF target

To address this:
- Set 'elfv2' for powerpc64le (little-endian), which mandates ELFv2 ABI.
- Set 'elfv1' for powerpc64 (big-endian), which defaults to ELFv1 ABI.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 6cee30b7941c22eef52011b6bac0d3c0d7944abe)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index 63c7e8c..a81532e 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -386,6 +386,10 @@ def rust_gen_target(d, thing, wd, arch):
         tspec['llvm-abiname'] = "ilp32d"
     if "loongarch64" in tspec['llvm-target']:
         tspec['llvm-abiname'] = "lp64d"
+    if "powerpc64le" in tspec['llvm-target']:
+        tspec['llvm-abiname'] = "elfv2"
+    if "powerpc64" in tspec['llvm-target']:
+        tspec['llvm-abiname'] = "elfv1"
     tspec['vendor'] = "unknown"
     tspec['target-family'] = "unix"
     tspec['linker'] = "{}{}gcc".format(d.getVar('CCACHE'), prefix)
-- 
2.51.0


