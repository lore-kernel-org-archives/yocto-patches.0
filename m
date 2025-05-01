Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74214C3ABBC
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:02 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web11.4661.1746132062080237677
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:41:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=D6Revz99;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f0ad74483fso17599376d6.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132060; x=1746736860; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXE7fQxuYWlnZ8Yw7gEE3QdEGm6uMlWQ5DJE7YqFOcA=;
        b=D6Revz99l9+8zW/KnZlZFgMkHl5RGTDamryO65oiUPezf8vsST4yggkGkT5CjLCFYn
         UB/kJyzKYwazuP7iTvfxHTIi+81N2h+uvtxM5cFkMbymULE8abKyR8dlnZNzIMk75AcM
         /5WrbauV0pn5QNX7qfjZiezEPxdcAm/7NdBMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132060; x=1746736860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXE7fQxuYWlnZ8Yw7gEE3QdEGm6uMlWQ5DJE7YqFOcA=;
        b=regOEXl3FaO69AUoWuqfR3ITrwK7zo2/9ogu2UZgJ7gbCBcKQuuMaa3E2/UCCEPIx0
         c8MJbV8qWk3EjD4U2l0cGKxZS2TrVmpwzL6irnkj5gfwdMPo4i5s7SmUdEMXvXNKa3pE
         OqVjzFnxfLU9V8osvhnQsAA6eSyN1wIVFWyRoZp5uI3N3ezwHWdtdinFJdyCfMK8yt97
         0fpCo++L1j/Rdo3zwIZl/sWBRrbg4yEg7lTGIQ4CYt7NrIl4ZEqNB/AKxjkMocKoDsq5
         1A3Zw7QtIzP1VPIz/VhQsvayU3uthav05ZUULPkdT08IHv4B22Vy3AoAf5qDizSdxRD4
         MNAQ==
X-Gm-Message-State: AOJu0YxunAoUHCaGop+rDfRZjx1Q0JVd038ONjYpNFvGNgQsYM0uiOL5
	0vEeIgHuQ9skRR5WIBiSdvY/vXc1OaS76Hbw+XOG1yLk5azmuDmHyrf6GSxUiKMgbBc+k2+l7VF
	C
X-Gm-Gg: ASbGncvUDBdOYrKf4VTGLztf7KnXtDvox8W9r6b0dt+6pciwQDbzhKqh5+KTtLB2Esm
	DZJD7uaHjSfqRU5MpE367sFkUaWIyJq2c1/olRUyPrbvBOmCSsor3FMpF+w/1vO3M+/yMTuKJCF
	ZOZx8j1hkOMWJxPpSIcbsp5ybck6WjU1Duk+AhHOQLG1Uf8vuc+qe/Gd761StxnKxLAEzlz4c8f
	UzYYAoCIel0fN+cN+zCk5tPD3Gv/QSulmba1rGxdcj3HSDVoTjpT8CvDTTCk8fo6FMIefdLozFp
	E4GS1A8bow4SsIPrvoDlJWRsvTMOuznI2QjQ+RRtgHDU4EgY1yusPj5KqgIYS+/PnRO5pVcyMyD
	25Pqsy1QFQA6rEjMl
X-Google-Smtp-Source: AGHT+IFCe/+5TcLXllAj7GSfpmLohS+1/qA8CwmUKabKUUZv0vbQWk7vNxYRw9hOq0qVW1R5WOeQPQ==
X-Received: by 2002:ad4:5d42:0:b0:6e4:4484:f35b with SMTP id 6a1803df08f44-6f5155f3deemr9828256d6.30.1746132060612;
        Thu, 01 May 2025 13:41:00 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:41:00 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 26/38] rust-source: Fix remove_gcc_directory
Date: Thu,  1 May 2025 16:40:02 -0400
Message-ID: <283e7ba99036eabcb6c8a00c0544f57df5606a28.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1453

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
index e4df87a..f9ef7c0 100644
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


