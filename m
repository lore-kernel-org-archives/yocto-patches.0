Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845B4C36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:04 +0000 (UTC)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
 by mx.groups.io with SMTP id smtpd.web11.59617.1744061464122472432
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:31:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UbEqB1O4;
 spf=pass (domain: konsulko.com, ip: 209.85.166.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d6d6d82633so14399155ab.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061463; x=1744666263; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0FXbiGvtqONuDC1lYezRqUJRaM76ZoROCEWBfTSLdk=;
        b=UbEqB1O4JQAb1dJ1Hvrzux1Ijx+oO3Q82FstxQZl7TAadNIhIC0XhQe2U0pVJsec5P
         FDBhtVff5KrKHJ6MBmVGOa1M2LIUm/PqWxYkEKu6z5O4v/NNwTl2FjuKmJnUYEuNZJZ4
         b50BAz2FO7y0mZhEzkIGmJU8e1WEbRaGu5o+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061463; x=1744666263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0FXbiGvtqONuDC1lYezRqUJRaM76ZoROCEWBfTSLdk=;
        b=w8SAgYC/dCGI0znBUwZaMFw0/b9EQ1cTx6vLR6Z++mQJZpiBj3znuaB8Z6LXbON9t1
         K52Hqk8WrO1hrM2w+eIT3YhYsCuVhpiQML1U0vu4JCMTZLaDAmJ6c23zxdMAkMo7QA7J
         MVtmQizOrK0TZz8Pikf7lVKWR3pyQE/5grgpC/VgiX6hRc2DBh2RtOZTP+h9s2u51bzT
         0hgiHYebzffBOv4rn/8gEplbnPzN7RoiuPlDWnlFN4nz/2+8Fbqr37C48+PJBtl5bOKc
         uyJ17x/gMo0g57pXGtUJEowt7GySnYOphyQZcFHPfxBZrORR8TmUM9e0g3Y2EmOOxkiv
         0CMg==
X-Gm-Message-State: AOJu0YwNw9SdcXFmlX/ylLyUXtr8cX9sEsc4+fqrziKSPAlB4uxT+Zo2
	NiRNUx28A01bWZ1uXuQ+W4wA66LVRwF3kGAZ0QhdVOsnHMj9ooQaOlAY2zUkzbIUAyoeyuuss/e
	+LxQ=
X-Gm-Gg: ASbGncsu85l8AuhKngQ8YQiGTl71l1k5DmKG9fW9cLvLaTygqxF+gWcVWMp0yh+elL4
	pf3XbybA049dkGu5vTnIbfNsrKqnLfcxEDTuL96OwnPTQ2fnzw8h6tCmSveQkey/RRVuJvck6C2
	hdPSRA2UZn/5djw7iueX3Xj2fJxrE6cYJJW0SUGuPl4ZE4W+Kln11sYBdxrB+Lq+04UieDsac/d
	HSSVps+Rx3V/KNjb0CD2dGJvTtpM49+FKw4fFqFbrlGLoiE0VQ4DXOGto3lkpwRXsLYJ6nLpfpF
	hf/Jc2PRKqY4ewJ30fKtZPuB7noNQSSmMxvrbV4jCH9xci81G4udjOlOx3pJE3kmuFmuf4naeJh
	SjBRjJOMKSfCBeIURvjHT
X-Google-Smtp-Source: AGHT+IH3khGIgVK7zwnvkHKx56grRbN9egu9v2WAtTJjsxChi7al6vt02VTEZylDr/mJlY3IQpHZEg==
X-Received: by 2002:a05:6e02:180a:b0:3d6:d838:8ba9 with SMTP id e9e14a558f8ab-3d6ec5252a3mr116675195ab.1.1744061462828;
        Mon, 07 Apr 2025 14:31:02 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.31.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:31:02 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 24/29] rust-source: Fix remove_gcc_directory
Date: Mon,  7 Apr 2025 17:30:13 -0400
Message-ID: <a3bcc50d7b3c6c074c702d6f0e92a69d80897606.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1324

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The patch works for rust-native but not other recipes which change ${S}.
Set it to use the correct path so it works for llvm-rust, cargo and others,
maximising the space saving.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 1aee0bc109c1457159440c279ddc1fe5a8d89586)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-source.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 92bb5e4..820cdc1 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -17,7 +17,7 @@ RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 #After updating to Rust 1.85 we can revert this removal of "src/gcc"
 remove_gcc_directory() {
     # Ensure the gcc directory exists
-    gcc_dir="${S}/src/gcc"
+    gcc_dir="${RUSTSRC}/src/gcc"
     if [ -d "$gcc_dir" ]; then
         rm -rf "$gcc_dir"
     fi
-- 
2.49.0


