Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE2EC87FCF
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 18:40:38 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web11.23026.1753296037318520379
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 11:40:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lIAMrF5n;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e1d89fcc31so25668585a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753296036; x=1753900836; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvHZXpQLEdorX0xqqORIFGXVSgaZOrhurpYjlYBVWFY=;
        b=lIAMrF5n4dem8Sm1qsM4kgAot5Atk++jzzYl8ANacrGwJU2ST4YTcnl2lHe8OlV+PN
         /R35K80e06quYxzb0tlap+PTrVuZqWx7OpJjwi5MSrQojzgegq+onQLKZkdkm5n7ivZl
         i3V2h67HXXpufCOcLNqdbveQh9JID3/HseaMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296036; x=1753900836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvHZXpQLEdorX0xqqORIFGXVSgaZOrhurpYjlYBVWFY=;
        b=GSJD5FMwM9yClDporRzxf6LHjPID9eBtx8ruoW1FYVSh2D0m5TW5ucfCWc+H/mY0Ob
         /Ss/IoazpVID4nIW6Kbvz2qs/RzL9T32T4GZcxau2iOak6LRAm9yXgB6Z6QVwuO7mham
         CkIwPfsOofPc51rCh7eaFq8GUqeZag2XSGRK+I0SnFDp9RAetQKt+ApcXQ21sC+LSjyN
         Jja3Jw50t3FxUJY6nz8H1Z4Ae2ZM11pVn7xjuR4061pNjWSFWlYNqCdVyrmz4G2tLEYP
         Rvi7fO/WfzbhbI0vsMkXMhlUowjJ+X2icyI2tXsQxdKEFtHFmCUsSqB56+iVgD1RXxHN
         qLrQ==
X-Gm-Message-State: AOJu0Yw4GTMhginO7/uVG1Q8wxlM1i4hCtaYQqCeIms5lX/m+fAh/8CM
	Mc+3pNOksqc07VsZ1nEdc+Q0KJGK01en9pJboVYnuEEtsLF4i/td4t0rT5uRl61Ii/TiJRukNWg
	YiIVD
X-Gm-Gg: ASbGncu90JYggh4cfjGGTtua0hSXqoqFx5cZ8y5t5+DuKX6j1N4JcVjY/kpGZiV2N3l
	8uFRHrBpBEnLxVVmRaVq3n2/xaIzR2+wqBzxkCo28po3VzGnPB5W9DOKPg6AfTrE6Bvi//Xyw9C
	Umms4PRoZX3Bxa0ebnRNkp1EZFE4r9TBYcL14TkhPRzu32THcgaxFbJjhIOGLnY+sv3aFDXvltX
	bVuPozJ6xJT1hcmKh+B/h11B3I/+ODASc90fDc7UvjtQRxl6yllo0RSWcFS9rawDHVTO4czHBUF
	lVnIn3dnLwDYXusj2SB7oHD4pbsZr7zhIemPN81vinHqNu4sXlv5HEUGICoulqCsrxLmSZn4iiq
	uqwmyOxkhaPKXR4sJfprIukD+XzkScRIVHJQ3+QikRq0qLVBQuwhVbM0IVs1yKOTI7vXLKj4iAg
	==
X-Google-Smtp-Source: AGHT+IFXg6+LUFDxnsFc8HCqTlB/ninuYv7xCJ5eU234gYQ0N6u8uoFfZfCxXD6T1JVy6Vv20ztlkg==
X-Received: by 2002:a05:620a:b59:b0:7e1:9357:85df with SMTP id af79cd13be357-7e62a18b7e8mr474463985a.55.1753296035930;
        Wed, 23 Jul 2025 11:40:35 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm697255985a.85.2025.07.23.11.40.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:40:35 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 05/13] rust: remove python3-native DEPENDS
Date: Wed, 23 Jul 2025 14:40:05 -0400
Message-ID: <55bb3f651ae88e9e389dcffaa9b167189d6faa85.1753295655.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753295655.git.scott.murray@konsulko.com>
References: <cover.1753295655.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 18:40:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1832

From: Ross Burton <ross.burton@arm.com>

This dependency has always existed in the oe-core recipes but isn't
explicitly needed here: the host Python is sufficient.

Note that rust-common still inherits on python3native[1] so this doesn't
yet actually have a meaningful change to the dependency tree.

[1] oe-core 4abd6ee9d48 ("rust-common.bbclass: rewrite toolchain wrappers in (native) python")

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit aee45fc067b2ccf3e365deb94584089b60cc7d4e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.85.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/rust/rust_1.85.1.bb b/recipes-devtools/rust/rust_1.85.1.bb
index fddd9a6..90c6d5f 100644
--- a/recipes-devtools/rust/rust_1.85.1.bb
+++ b/recipes-devtools/rust/rust_1.85.1.bb
@@ -7,7 +7,7 @@ LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=9c0fae516fe8aaea2fb601db4800daf7"
 inherit rust
 inherit cargo_common
 
-DEPENDS += "file-native python3-native"
+DEPENDS += "file-native"
 DEPENDS:append:class-native = " rust-llvm-native"
 DEPENDS:append:class-nativesdk = " nativesdk-rust-llvm"
 
-- 
2.50.0


