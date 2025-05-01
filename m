Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC6EC3ABAC
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:51 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web11.4641.1746132045112700891
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=mrXVjlSo;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c55500d08cso152132985a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132044; x=1746736844; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRJKv5Yp6VF9cBYOCtoA4/r3q10epJKh3c3tlkwYr4Y=;
        b=mrXVjlSowCFeeGj4YMUTOTTAqKX+fw1VyzXXw7JM3l7dJ4wDk7oAo5iHYxuOalV/xQ
         Jdvu6yYChgq5clhbEV7AkGXHPwNI6lDusKhiPXU6vFyyrql2xtnvXfRuA77quwn1Joy3
         87gXBvOyvz9+2Suww4k4Yjupaea3j+FObzMtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132044; x=1746736844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRJKv5Yp6VF9cBYOCtoA4/r3q10epJKh3c3tlkwYr4Y=;
        b=tsNSWg6RMKr/eUu5M0hUyuVsjBcYYvTeFUqQiNqtoojc0WHx/Lr0+SHH6XPtEvwWtU
         S+2xGiXjQt+NGrI7GgSr4PrI3QtZC2JqE8eXH8fnSJC11my4h3uPwVYlc58KgrGLZLi9
         DiqtOglXC2M48ta/OWykZFvjRa6+N6cVw8ectYtAT8vu9FtwU8inXRusR9t/M3SjbSNd
         1BXTiRtphWKh7D4Q8vsxhMzdFAOyn9+S79Y/Nw/WSIWMJ97l3RxlGbBq9FA2RTE287HV
         uQVj3YFs7ciJQbi9HmOtdA+6MW3tOTrEJIBFOVUvlG0CR2d4rPbjWbXEM8CbN1iJwdyF
         wGLw==
X-Gm-Message-State: AOJu0YzrA+j+jjhPEzTSibSQjILP8UbY+gvwbHlBEAo6/ADk0n13al1X
	Alv7KSRlYIo0GzWYX80nsUAKjGM5R8iAIhjT/S2e4LtdGwlvuy2V5dXJyWyFNesyMwQuetMq4xz
	A
X-Gm-Gg: ASbGnctccj+ewkLoGQ4YwHWEnyPs2acpgKSu462hbqI8DW/TQzsZ8RbGQ5KK6rwbeMc
	zBbERXWFSyoEg4nERXINWqOP5ljmqY3NtVXCxu4ebjip2JtakHO6GQe/XSsR7e4i+Iv+CzHvcb8
	4Rv4ZewEzMVYaR5ucejNPcQIB2AK0jZnC5ecsGmcolyjJtT5SOeCwWPPNbdTHY3NLggSDq5mkfe
	2XjSWOgF9o8lJg1CNtBVgjnXcFxnYvTxb1Zg0W6RnzKkOoZBqJQcSgiOyeUp/2TvmvZ7XPUkv/L
	dOdZdErITH6cCUdij+JWnXzvTYtqzkgcQioAovRAnuSeY3cE6aROMOiQAYYxC+gh9ot1esLtYo2
	UWfHYexzx+OFvx/HG
X-Google-Smtp-Source: AGHT+IF7zOfkejEESayy9ODIROHlJeuo8gqY3YSRW0A/PBmSYQaLBrHjaBcUVGlj0fPALsqFneNreg==
X-Received: by 2002:a05:6214:1d27:b0:6d8:99cf:d2db with SMTP id 6a1803df08f44-6f515623bcemr12832706d6.38.1746132043668;
        Thu, 01 May 2025 13:40:43 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:43 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 09/38] recipes: Drop ld-is-gold support
Date: Thu,  1 May 2025 16:39:45 -0400
Message-ID: <2561b4d70559f34492e8b41f70e09867ba2d8f7b.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1436

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


