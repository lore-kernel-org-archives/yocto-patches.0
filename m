Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C6CC369A4
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:04 +0000 (UTC)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
 by mx.groups.io with SMTP id smtpd.web10.60126.1744061454462454431
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dAS0/3k7;
 spf=pass (domain: konsulko.com, ip: 209.85.166.52, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85e15dc8035so125851239f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061453; x=1744666253; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GynVCE9keBQk1dKDqQYBl4NeZ8S255moG90twPqKWQY=;
        b=dAS0/3k7cScHr/8mifzvdh/1zBjGdXropQ+yuzo6NLcPVIjN2GikGqDnNMVd+b3pBq
         8isp2wOWiXfYEp417+gqsATcn7yDj+QjStEeruiLu7vUGkg+ZC8ENBZBg4HBQu+kAQ1i
         wFsq/V7GH3m8dVbztnquepPUxjDPUwKoBAMp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061453; x=1744666253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GynVCE9keBQk1dKDqQYBl4NeZ8S255moG90twPqKWQY=;
        b=CKdPlFe32RnY+6Qv7Y6qDuWYQCAuYSPTPlctcLWm1FtyTvkDlKUnrlH7jf9qMYcKuO
         4vARCjPfuDPhqguc68p4PMUnRZQOjDTKiVSVVIExJ6LoRDkhO+7hCQUvxD55sAd6f4q7
         LXMLOT5sWnYLa6r955YCM0k8vShr9GU1gmLL7NRHH92m8IBLNhpavJEi4F4S1GY8DoEF
         iJhhbAvbWo5sWTjzTk/WDbEGLazZK4GxzXk1hGpzQ7kTP9J5HAF+9ZlNVlLmr1IDPJ8j
         W+mF0W1qa92RqN8IOBxUWVVua/vtqrEuJpnbfY5vwmpnkidJ2K/KlWpioC/3hTfoXbND
         8ksg==
X-Gm-Message-State: AOJu0YxuGqQVuqIWJ8tzbuDfP6v3vL95jN45ES2OARulOiXiIZ9GVjw5
	7PZHBeABTVnAyK/cveofSVhoHa1PgYRyQF1SCnF+AKJOMJPL3IAGYbMKtq4S0+jRkrtYAlPEPP1
	C6LA=
X-Gm-Gg: ASbGncvxjHYbypNq3CH7jPHM0/O5WBWEY7pfF9TGIBNmvT7NhHdSBzJDsGKydHaL/vn
	ePHeby3LR4GiJ72T7nFvj5UN+Lha1dTR+BavjZ0zETEhV23alUk4/11+3qtU+ZnZjKXd6z9XUTb
	I7DWTzj5VKJZ0TPTvMY+2Yt+zt6s3644Gjhtu9ePoEi6KPiE9W+C0LFJgorci6tUDOIrkXFW2eI
	eGtGfY7j7tcyR7trtWEvU+W6L+7ykG9RUHbV/SV04de2nO30aLs4f08+wJIp8TbLOHy2An1ieZF
	xuOqRSrys9E4cpy0D9GFViMiixdU6NnDI2g0G/RuvcYprAQWULyg8QEwRo1CBtvnIb/5ts1vuXG
	i2tKHauNRf+jb0sYOqcPl
X-Google-Smtp-Source: AGHT+IFjTIkeguwkGPtDdcNscUhBUDvUm92HQ7FRxBnMgkxL1JVvy5sXYBmLx9hxm6e7Q3ekgsDhTQ==
X-Received: by 2002:a05:6602:4801:b0:85b:45c4:571e with SMTP id ca18e2360f4ac-8611b4e0648mr1627403239f.9.1744061453475;
        Mon, 07 Apr 2025 14:30:53 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:53 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 15/29] rust: Fix build break because of download-ci-llvm
Date: Mon,  7 Apr 2025 17:30:04 -0400
Message-ID: <a6ff10b32cbf0fe4cf38935598f7d7479f9de7ce.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1314

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Previously, download-ci-llvm was set to false. However, with the following commit:
https://github.com/rust-lang/rust/commit/7d579046c80d3de3143dcb8b2db5640f95b5383c ,
which has been present from rust_1.83, it was changed to true. As a result, after
updating to rust_1.83, we encountered the following error during the build:

-------------------------------------------------------------------------------
| thread 'main' panicked at src/core/config/config.rs:2047:13:
| setting build-target.llvm-config is incompatible with download-ci-llvm.
| note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
-------------------------------------------------------------------------------

To resolve this issue, we are setting download-ci-llvm back to false.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit d43424cba7e93ee30b410d0a024be441e2336dbd)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.83.0.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-devtools/rust/rust_1.83.0.bb b/recipes-devtools/rust/rust_1.83.0.bb
index 06f48f1..41efcd6 100644
--- a/recipes-devtools/rust/rust_1.83.0.bb
+++ b/recipes-devtools/rust/rust_1.83.0.bb
@@ -129,6 +129,7 @@ python do_configure() {
     # [llvm]
     config.add_section("llvm")
     config.set("llvm", "static-libstdcpp", e(False))
+    config.set("llvm", "download-ci-llvm", e(False))
     if "llvm" in (d.getVar('TC_CXX_RUNTIME') or ""):
         config.set("llvm", "use-libcxx", e(True))
 
-- 
2.49.0


