Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85977C369A9
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:30:54 +0000 (UTC)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
 by mx.groups.io with SMTP id smtpd.web10.60118.1744061446256213725
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UCWidb/7;
 spf=pass (domain: konsulko.com, ip: 209.85.166.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d5e2260f52so28637705ab.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061445; x=1744666245; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRJKv5Yp6VF9cBYOCtoA4/r3q10epJKh3c3tlkwYr4Y=;
        b=UCWidb/736eBf8Kx8tjocIiF1veZiLQKK+lD1F8WM8wx8m2M9M9MsgwrhLTQJsfFcQ
         1xvXQx87UajOdMR5XAzDXz/jtk+mq5jX1/bUeYZcHDsvXe8qewD6f2/h7oF95XrZgMch
         VyWtEG6POufSMZU4PTBJYiH9eiAYaSOk7dVFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061445; x=1744666245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRJKv5Yp6VF9cBYOCtoA4/r3q10epJKh3c3tlkwYr4Y=;
        b=Ylpnxy3Jlainn3cObMlB4sW++UvUY//5m6Wr6Q6LIPDlu7SLfQ/RZy4XlkQCUdjjNs
         5nAkjSVCw4wR2hYNfQgbZwsHjP+Mj+bM/FKe9ViHEIuoamQPMPM5vdc2PpefBa+Qibpx
         3bVaod2nizVcFiHAcZesQUURxXo+Xa4nzCw4JMnGHPPbhWmNWTcThSVNNxbf0vx5fmW4
         uOSsOrABUW5eJXfcuMk6ZjxAfrpjs5e6wb9o6h8FvIv37G33ifz+jdxiMPIy29gVa041
         KgoIkC23ZLq8dZP5rZt7Y6Z2HzXWBje3np7bW0G8zdbZYYQmwJiFHNZ2Nel8gTHjdTGy
         EZDQ==
X-Gm-Message-State: AOJu0YzxJn2Ji2NXgCP/ffr2Az7vkh/OnxX+Hzmxfkgfaj7SHrO4XUfN
	X/fH33xfLt9OCA/7QKrka6ELF3IaNVz0E72VGp1+RACxuzCF6YkL1XntT17rwGfFlBhF0JFBGy6
	4k7w=
X-Gm-Gg: ASbGnctGLjfrksAGyYVgUtpi/f9VJvfKxh0/LDbCwvPDkHFn9WsgY7ulA+jyQbYhrsY
	hXvhgs2ybZ25dg1i/9OcjvON6tMbXb8+DsHI1uWC5SAAna2fkqGAyK0VvZB2YR5no2k5nji4dwv
	87UgRoi1xjY92GcuRv1m62JgeMzesdOVMvX2DRKmpiEWRsHnRIreqnWWfipXulbL+8ha/j2MkRM
	JnOwrj4EUP4qJVC1UH167zPPn0EV7GV0oAmhdVBRoW6yjfU2R/RWM1mZi129LhBqF6XZ2UHN7Rn
	R5m4F/0o0uAhKNaOZ7fkrZj2XMC2sllr5bf0AeoVUZFZWn/iRt2afTAjDyiUxlih0XlW07PMF+G
	8zhTX9Ljtb8QfE+VkkaY5
X-Google-Smtp-Source: AGHT+IH+A/tpJGJcTU4AuYcHt8BcCB3TXBEJ+Gxyi+GOd8whJqIOPFriB85n0hRy001hC97KL6KpfA==
X-Received: by 2002:a05:6e02:3089:b0:3d1:7835:1031 with SMTP id e9e14a558f8ab-3d6e53181dfmr170212075ab.7.1744061445319;
        Mon, 07 Apr 2025 14:30:45 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:44 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 08/29] recipes: Drop ld-is-gold support
Date: Mon,  7 Apr 2025 17:29:57 -0400
Message-ID: <e94c07552a43158689f5097e29647d32b5096974.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:30:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1308

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Gold hasn't seen development in some time and is being dropped from binutils
releases. Drop the small number of special cases for it we were carrying.

This patch also turns off gold in the binutils recipe.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit a4addb9ab63011e7c604fc5daff95559e7d214e7)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/libstd-rs_1.81.0.bb | 5 -----
 recipes-devtools/rust/rust_1.81.0.bb      | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/recipes-devtools/rust/libstd-rs_1.81.0.bb b/recipes-devtools/rust/libstd-rs_1.81.0.bb
index fe016e7..06a2889 100644
--- a/recipes-devtools/rust/libstd-rs_1.81.0.bb
+++ b/recipes-devtools/rust/libstd-rs_1.81.0.bb
@@ -48,8 +48,3 @@ do_install () {
 }
 
 BBCLASSEXTEND = "nativesdk"
-
-# Since 1.70.0 upgrade this fails to build with gold:
-# http://errors.yoctoproject.org/Errors/Details/708194/
-# ld: error: version script assignment of  to symbol __rust_alloc_error_handler_should_panic failed: symbol not defined
-LDFLAGS:append = "${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', ' -fuse-ld=bfd', '', d)}"
diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/rust/rust_1.81.0.bb
index 8cb4558..06f48f1 100644
--- a/recipes-devtools/rust/rust_1.81.0.bb
+++ b/recipes-devtools/rust/rust_1.81.0.bb
@@ -377,8 +377,3 @@ RUSTLIB_DEP:class-nativesdk = ""
 INSANE_SKIP:${PN} = "staticdev"
 
 BBCLASSEXTEND = "native nativesdk"
-
-# Since 1.70.0 upgrade this fails to build with gold:
-# http://errors.yoctoproject.org/Errors/Details/708196/
-# ld: error: version script assignment of  to symbol __rust_alloc_error_handler_should_panic failed: symbol not defined
-LDFLAGS:append = "${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', ' -fuse-ld=bfd', '', d)}"
-- 
2.49.0


