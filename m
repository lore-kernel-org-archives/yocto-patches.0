Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AB2C36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:14 +0000 (UTC)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web11.59618.1744061464934499623
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:31:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UgPNfI9d;
 spf=pass (domain: konsulko.com, ip: 209.85.166.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85b42db7b69so66051539f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061464; x=1744666264; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4/8K/8u43+AS5THUnbTJbzZ1b68JJNBopEoyi0NNRs=;
        b=UgPNfI9dtzMK/Medf61UKrGnhbKyATJZVqI5tDu57mz6xdpjDtEO9edfQbv3DJqci+
         m9JALghaCfXTRRdhUA7C7tGfRzsGsLqlsR81ezPMsGZAT+GfTWVaujxmNApEIT1uZNfV
         ox6A7nsZ8yDikiQXSrosCxAfNtBNh4EXJ8YcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061464; x=1744666264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4/8K/8u43+AS5THUnbTJbzZ1b68JJNBopEoyi0NNRs=;
        b=J6heyIEknwmpZ1gpbvlx/I6IB9K/sADAfuMJRbF9anjDlh++07c+ITEltnj4UZafjm
         rqSfOKk93hnjDtTm/t13D7JQUX2IXyUo6NXvMahyj1aFPcKxwB5KzDvqEsFMN4/RD3LD
         abiu87B9MTnTivT1gSM4gbKMuGUSID16gTucrP6JyA7r+iUdvPBbljRMCVJPbNKxSeEU
         0IgmMa8+KuhVAirZfhatffKHwANDvzOwSrLFsaYiiCz2PjglZcUFx1ovGErhB4FSjkch
         EeBfAvmz2I/v+gGU2UuGlno85dKVRguAMZWLWvqW88/41aCkiuHpg9FG7Dp88/y0VL1p
         CG9w==
X-Gm-Message-State: AOJu0YzOx7PzKNqHLz2qK6LItL9klGcIAWQ/07FrZoopzmtllUEUqvjs
	tkP2nZryUXSZzXzUhvT1ryyVrUh6VHdE/Yaqq6g/wYQShUjqoXCn3lkb2hV2A9S6yKM6xwRFMGw
	jrAo=
X-Gm-Gg: ASbGncvTWQC3UkikdQbuSUPo7dMwooAoM4qVpArZyCKDBJRazLa1qQCa8zAfAA7cN1K
	60SmavUUnTl5wNzru0CUqjt1p0Qc3FWOtv1j4f7m+P8Nmy8UWhxYOhEocBa+C99f++QYncMxzpR
	z9z+V7kl2jW70Sxtn9pY7eQ2eX+jSGeQzMfkhUsWafqYsw9dyZQC3pWb6kXRdZiYSLHFiB0Y/Py
	FLbu/glOKGiFYAQMfGCuRYuuJan6sMT1gH1GfjAJUkm8WSKusaD23FbpasHV241mU2XHa3sV10G
	nbO89E6d8rDW9x9p5Qh7sOWxcczzCM6/CtJv7v+zKJ8CvlpbrIL7YnfS34ePoIVWTmULqZtedSi
	Bm59TgaHf9fQ0ThXP2jwU
X-Google-Smtp-Source: AGHT+IFXpyL89sJGEUzgzhaIgFdaSKB7vw4T0G4v8AN55YBGxhnx5uzkvuQJ1WPNVkNq5/osfMVHvg==
X-Received: by 2002:a05:6602:3791:b0:85d:a173:324c with SMTP id ca18e2360f4ac-8611b577263mr1675945839f.12.1744061463836;
        Mon, 07 Apr 2025 14:31:03 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.31.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:31:03 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 25/29] rust-llvm: Compile llvm to use dynamic libraries
Date: Mon,  7 Apr 2025 17:30:14 -0400
Message-ID: <acdbb91283ec3dc45719db34269d2fc67ef2d2d4.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1325

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Our main llvm recipe uses dynamic linking already but rust-llvm does not.
Enabling this significanly reduces the size of llvm-rust to about a third
of what it was, which is a bettter configuration for us leading to smaller
TMPDIR and sstate objects.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 2b6a6d4199e4eed65f20351d077a04a7cf9da460)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-llvm_1.84.1.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/rust-llvm_1.84.1.bb b/recipes-devtools/rust/rust-llvm_1.84.1.bb
index 6a4d295..566348c 100644
--- a/recipes-devtools/rust/rust-llvm_1.84.1.bb
+++ b/recipes-devtools/rust/rust-llvm_1.84.1.bb
@@ -44,6 +44,8 @@ EXTRA_OECMAKE = " \
     -DLLVM_ENABLE_FFI=OFF \
     -DLLVM_INSTALL_UTILS=ON \
     -DLLVM_BUILD_EXAMPLES=OFF \
+    -DLLVM_BUILD_LLVM_DYLIB=ON \
+    -DLLVM_LINK_LLVM_DYLIB=ON \
     -DLLVM_INCLUDE_EXAMPLES=OFF \
     -DLLVM_BUILD_TESTS=OFF \
     -DLLVM_INCLUDE_TESTS=OFF \
-- 
2.49.0


