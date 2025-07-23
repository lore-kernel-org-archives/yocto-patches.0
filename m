Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959F8C83F17
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 18:40:38 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web10.22556.1753296037809759375
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 11:40:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UVCccB84;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e050bd078cso20894485a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753296037; x=1753900837; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5FCzfo20k9vwR4BRIgNILtghJf2+lKEtKiWlGJxzmc=;
        b=UVCccB84xCnJSNTvmQdmlE6R1R+K9qpkPo9FzQWOIV3v6DZ5ytmkfFKN8QUPQjImfh
         pOB12bAmc+7YAxIBPUBR9n5Zjjav+LwE55YPmKpDsRIs71fmXDbgCQyTe+kuNiyhtzFb
         iNbMP+CNh2Sf4D3dyj7ARLcywP1IMGXhjacao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296037; x=1753900837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5FCzfo20k9vwR4BRIgNILtghJf2+lKEtKiWlGJxzmc=;
        b=BGUTuoo+okJoMzJbXmFvDLPO3yDjhsqvXdAGMwE+dXQEpB3KXjZscM5U6+A1k1VtdK
         rLDO3IhOKY/+HdAGSZlNG/2IHss7G5tOySz4iCTfrHGAmgQI0mnxuJ9rDrXlwFxpYX8L
         rG8LAIIfLlzxGf0hqIZe2Jtvou+70HgKJ9NS1gsh/L7EWG+5w+SS3qzSE2cZwrkObTSV
         5FxAh3oDwzkjLrEj6GhJSnfNtT5TzEv6vwxmtMjRpy4vVsijcti3DHuvPpYHMdEkJAIS
         CrYSSldokgUbPeRd0GxOHM07EZHdbvapgK4J7pqYqmRK4gdvEu2tVuGR9SFJc3UHrMIe
         RpNQ==
X-Gm-Message-State: AOJu0YyWJZ0qoqYonTfdDP0hnr5CtboK0h27wM8mi4B8esuG+GxhRsl5
	4b1BQu+6r9Vq9vWr3VRhMOurtFjQyufF+NtvVHfl8e2VbDBnxeO0ieGZjTGL9gFTIMvpZAengV5
	D7I61
X-Gm-Gg: ASbGncv3gmrg6YKltrsnEAnjhP3Q5jio1wSmbj747wC4vVfshAP+g4UIBu+oEDQgp3G
	1G/wj7BPYNztY2yCak3CqL3xzd6oqiQihhf1WL3ENQJqfGMT798G72k4wlkuQ/r16irRfBuDJpE
	U62LiM83mHBzPw2/fjUQ4VZZ91F8L7bWRytoR4H8K4ldiDa9fCwRmdxXsjD8W5XTB7MNN8+uc6q
	1yNywqGE6/vjsRqagQpr7bl/r529Djs2CQsVNaneH42aEjCZHlPCZs9KTjXgYBTdOIyD2oRLMxC
	pwNsh7qPUO5ogpiFFy4yP6gw6GmpAK3HvdfYs5Lfoa7xrL/4HwpN7NLoNznPvLnxfVaUGJvUS6K
	GPhPWQsw4i0ZQAgXZgqMd4x5Wm5C2jjEyRtU4m6h6xhNP4ckLyrYjKXU/sY0mW3sVlYnkyjMQi9
	QWfGn8KTQT
X-Google-Smtp-Source: AGHT+IHHBVSYQmh9xoZWj3Rwfw+fx+9JdI/US26Xczpigq4QBN6cCjTl8gRpKL5QR0SRkH+aovMVWg==
X-Received: by 2002:a05:620a:935b:b0:7df:dea8:6384 with SMTP id af79cd13be357-7e62a1bc975mr404390885a.47.1753296036610;
        Wed, 23 Jul 2025 11:40:36 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm697255985a.85.2025.07.23.11.40.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:40:36 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 06/13] rust: consolidate rust-llvm dependencies
Date: Wed, 23 Jul 2025 14:40:06 -0400
Message-ID: <5d81ab70d9cfd78654cfb1b6bb9dcdfb0235d852.1753295655.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753295655.git.scott.murray@konsulko.com>
References: <cover.1753295655.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 18:40:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1833

From: Ross Burton <ross.burton@arm.com>

There's no need to have multiple overrides for this, as BBCLASSEXTEND
will automatically map the dependencies as needed.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit ffa699332551fbbb95a0e388385667dc2706da6a)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.85.1.bb | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/recipes-devtools/rust/rust_1.85.1.bb b/recipes-devtools/rust/rust_1.85.1.bb
index 90c6d5f..085fd3f 100644
--- a/recipes-devtools/rust/rust_1.85.1.bb
+++ b/recipes-devtools/rust/rust_1.85.1.bb
@@ -7,17 +7,12 @@ LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=9c0fae516fe8aaea2fb601db4800daf7"
 inherit rust
 inherit cargo_common
 
-DEPENDS += "file-native"
-DEPENDS:append:class-native = " rust-llvm-native"
-DEPENDS:append:class-nativesdk = " nativesdk-rust-llvm"
-
+DEPENDS += "file-native rust-llvm"
 # native rust uses cargo/rustc from binary snapshots to bootstrap
 # but everything else should use our native builds
 DEPENDS:append:class-target = " cargo-native rust-native"
 DEPENDS:append:class-nativesdk = " cargo-native rust-native"
 
-DEPENDS += "rust-llvm (=${PV})"
-
 RDEPENDS:${PN}:append:class-target = " gcc g++ binutils"
 
 # Otherwise we'll depend on what we provide
-- 
2.50.0


