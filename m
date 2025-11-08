Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8978CD13CF
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:20:10 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13175.1762633201226239372
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:20:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ioqYtBAm;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88246401c9eso1687796d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762633200; x=1763238000; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RceM25XY8NP0JuNbgLAa1X9q7VJa/F5jwg7OOjN3OKc=;
        b=ioqYtBAm7RU8kSekuLpvqdsob8g0U+dwbM63hs7H4sU8AgnbIu6ReUfzkKRYQuEa3e
         K2inh46fCSX0nuz0P6LEmP3X8cjEA6eOiQkITN3dYWY67xsHNuxrbNUtejePwzOQy3FX
         MY4Wx4HoclypZiksm39t7CASePsmwEYr57SaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633200; x=1763238000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RceM25XY8NP0JuNbgLAa1X9q7VJa/F5jwg7OOjN3OKc=;
        b=kufQWK9rDlj9it5PuEelSyrQm2c2xJLddh5wsqO0JbKR9EmnmEFfyqVF+JGOuGIzuY
         7uQ2o22mYKZhsRrPvr8Enqv6w8dPFhyuBbj68XrVgWcq5RX1w+6+YVlRY+CY1cpJctnQ
         7KK9vki97E+zKazU/17o/Sb/qf4nHIJS8a1OAfNPF/fFe6JepnP22zMWzY751EW+faCB
         /WwOZUDItpS8YqhCPkNSbFYcHCVBk9eYnB+QCc3DPcDnKKNaDiW+LsFsUvwYuWwqTQ4G
         fZbF8MoBkNpMOGwjhzjgn9DXyvwvrEyR1TmWy1FBiXcZBFp/PV9dbTv1DXhMHCevrYJu
         dc7w==
X-Gm-Message-State: AOJu0YzaXQv/nWbCdz/WFz5Fx0LEr31EJAAzwj824gOUN2eJ3o+U00jC
	EgOReNC5WcTvkKWUZ5BTPGVZqg5jL/FYyKNJHX2B2iOnacCyB34K6PFNJN3vjWNtsImcJ7CducB
	wW6xG
X-Gm-Gg: ASbGncuYSrtPlFS7/E4N8y747/WuX3/0H6KqlCR4+JrltkILS7viIUrIajjOabA/wDP
	T5aJxYqiMtLyoNPCSaQxx5WayqLqqn4ORaZaJe2ylrCZ5PAnsmlS/NzcqgQN4ln4R82XPRiNNno
	SYCkcKRL82XzcVJ7/QIWWxwRNPalFhJYepkVddrf+euqSmgn9WRnWR7LbL+iZQazK2MBqgiT63Y
	LSq0J+gXGGoXXTe3qKny3BDZDE02Kg0ZVKAMeL5rJrlTkk2Py2zMwN8y/udOQSFfT1j9eqUDF5j
	GjAQfF1YASiXf8MoFxEvDwsSwJ9b1rSE9X5IHc1wNXTQ/G4R+sFgjVdswtMgy9ANb6SCSDQAExV
	Pv9Wqx3u4wSjZ7sJsu4StbqdT3s54oSuUrBz7xyro/63BRCVMKm7UchO2hJp61U3V0Q1zI0ALLG
	/5Nb63bMoPpKgH+6gbsA0nat59rP2KuDtd63RDcgjVT54JySRKvj7obrIr79Xvos4=
X-Google-Smtp-Source: AGHT+IGk6CX/9RxCWi9lc5S4XzUjZV9AHpDQy2tIgzJcXUHGa3L47VUrYMufExgzohtof/x50y5YXA==
X-Received: by 2002:a05:6214:29cf:b0:878:ee25:427d with SMTP id 6a1803df08f44-882387136cdmr51658646d6.59.1762633199875;
        Sat, 08 Nov 2025 12:19:59 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238ba36d4sm19786856d6.58.2025.11.08.12.19.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:19:59 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 07/11] rust-target-config: PPC64 targets require explicit ABI selection to avoid build failures with rustc.
Date: Sat,  8 Nov 2025 15:19:42 -0500
Message-ID: <77052fec220c0cc0ad4e40abbf62bccd8573a1f2.1762633051.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762633051.git.scott.murray@konsulko.com>
References: <cover.1762633051.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2454

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
 classes-recipe/rust-target-config.bbclass | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index 0377fcd..b9198c7 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
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


