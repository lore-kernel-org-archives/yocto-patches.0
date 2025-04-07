Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D83C369A9
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:04 +0000 (UTC)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
 by mx.groups.io with SMTP id smtpd.web11.59612.1744061459651201552
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZTRM8wX1;
 spf=pass (domain: konsulko.com, ip: 209.85.166.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d46fddf43aso39055135ab.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061458; x=1744666258; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EshWwHlK6IBp3xs8DjvtiCJZH8f8OSnPMOXCdgkj9q4=;
        b=ZTRM8wX1Q/YbiUvxu+MszzqaMxvm1i90lFrHZQie2P4NEhc0SkSrwCq3EhtFqrhXox
         A28cNA4NZWZRLvbdJkrjnU2S26u9TPqy9tIkgRTCj0TQagnb43EWjGH4AuLmodH9GfvT
         W+s8d3QhuRqgew8Jwyg/1Gk0mQgE9h/4L+kcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061458; x=1744666258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EshWwHlK6IBp3xs8DjvtiCJZH8f8OSnPMOXCdgkj9q4=;
        b=U+iCBUKiPHi58WZ2bSt61sI/4cjTfMYxT1GSY7LeYTlyb1juaK1/+zfM+ad3YLWKlq
         OKvYnAyDC28BmkxK6wyjISISDLRt3l95/Au/Kac7gAsMujeW6DjRNJP1yzHYmK1WZTkV
         p1NsdTeTPvj5ZuM8LECkxydHjB5v24rxoNVLl23nslxqS+C+kdc4USWqHy6usF60dTP1
         EbZIrXUSbyd8dxQP5XjBMbwl41ts1ySkHj65FYR6dk3XUTqaCjjvvGPFOeQ8rv8xSO8a
         EZxlmV41lxjXfrMGZoRyxEYfs1+wk/Bpq6Q9una60eFRwLczhD3BkCNivGImOZy9Zgfu
         BtCg==
X-Gm-Message-State: AOJu0Yz5PQ5BfZLkwygrjzzEiPo+J40EhziAoRa2PSTOG7vRY3yT0xIa
	b5XVvNYyB0X1CpAeYg8nh3zMecTAaL+0z0/e8kH/aI7Wmp8EuJRla0Pz2s8a7fPejScsdCWUQOZ
	NO9o=
X-Gm-Gg: ASbGncuCPOdhFKfLwy+3v40ddkPSfI6dBY0C+suivpsul2+ZPx96n7FTafrDOzBkWHw
	jpmuTWwhvP7dk6lsJiaZfxg6476ozhVmTFHa9eLt2LXPdElhVqzNHY9E5h4iFnKqnQ5/d/q+yZ0
	3jNAeEXwRC9oTRUlXi5SsaBYFSiZWYnqgzWcgSg+f2HaGrb6JuL4kdAJF2unoRobU+ys/uAmgvN
	a19nL1OI9L+zHwQ0bSsBoHl2gnkzcr7OwupCav91DQ4UcCOToccKTVYcrjbWQvJOLqrTk35jgDy
	C6GD3/YSU4w9dDd++9mmkafvR9eUtdH72cV95ChFGtrYUnZTX7zsoplxthWIGDxHSOd/9mZPVgB
	KSvFTzF1hGW+8H6ckiJO+
X-Google-Smtp-Source: AGHT+IE1a3tBp+OgHzZx6IdoAxXndEunYQaPnEOMn4McL4Ft7EUb2S+63hEbEYY//KITW9weha7quw==
X-Received: by 2002:a05:6e02:156b:b0:3d3:dfc2:912f with SMTP id e9e14a558f8ab-3d6e3efbc2amr159894025ab.7.1744061458465;
        Mon, 07 Apr 2025 14:30:58 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:57 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 20/29] rust: Fix build break because of "download-rustc" and "llvm-tools"
Date: Mon,  7 Apr 2025 17:30:09 -0400
Message-ID: <4ab6c24492e5c8b5df3be19404bbe36e9d8d9684.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1320

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

>From Rust 1.84, the download-rustc and llvm-tools options were set to True
(previously they were False)

https://github.com/rust-lang/rust/commit/cce6f03754f096f8a2bdfb357e3739b855e29366
(download-rustc)

https://github.com/rust-lang/rust/commit/38f0c099b2e684ea689633eb424d8737a1063a5e
(llvm-tools)

For tarball sources, the download-rustc option should be False, so it has been
reverted back to False.

Setting llvm-tools to True caused issues with finding llvm-objcopy, so this
has been changed back to False.

Upstream-Status: https://github.com/rust-lang/rust/pull/134240/

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 2eb952d839e72c24a4180a57631c77910a0da980)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.83.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/rust_1.83.0.bb b/recipes-devtools/rust/rust_1.83.0.bb
index 41efcd6..40b813b 100644
--- a/recipes-devtools/rust/rust_1.83.0.bb
+++ b/recipes-devtools/rust/rust_1.83.0.bb
@@ -137,6 +137,8 @@ python do_configure() {
     config.add_section("rust")
     config.set("rust", "rpath", e(True))
     config.set("rust", "remap-debuginfo", e(True))
+    config.set("rust", "download-rustc", e(False))
+    config.set("rust", "llvm-tools", e(False))
     config.set("rust", "channel", e(d.expand("${RUST_CHANNEL}")))
 
     # Whether or not to optimize the compiler and standard library
-- 
2.49.0


