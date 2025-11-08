Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D4FCD13D1
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:16:10 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13109.1762632970021310219
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:16:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=cspRBNkU;
 spf=pass (domain: konsulko.com, ip: 209.85.219.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-880499b2bc7so16191116d6.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762632969; x=1763237769; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXyHrHK9GHBX36qwihuU+0fzf97/8LVKRzRkS6JJOYE=;
        b=cspRBNkUpaY5GN/JAP0KHaSOyrInkrxbTZxcrClMCTGPu4YKjQVYGmtguwTLrjFP9I
         U+vNhLzF2VLUmcC9/YXOb9a5dXr8SM1wBADtYlYOmpxU8RGA7W4b9FqbqCnA8IwvKtDF
         NXBP6OABLfQF5YIYN4Ay/hVnPKPbQOd1wbyIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632969; x=1763237769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qXyHrHK9GHBX36qwihuU+0fzf97/8LVKRzRkS6JJOYE=;
        b=n2ZUqFd+htQPpAMfXAFpy04nl6AEwZXL2Nx/DTKgSUSUliqTFIS+c3hPWsgH8WTLsw
         dMEK4A/NqzcuG9uQbOMQSp+pGu9tMnlwaIkmykUVbozeE0PEzNi5AHhr/41Fb3ikFVky
         orijKRfF2tHDpnDZK8CeU59dSC9ZmQeSmfGm2/1gVVw4gHPJiLsBCTwYDSQTB9FUtyBh
         9KpM2fvNWm7K8C/wLYbH9c0A2ss8lgllmJ+uTMOtcPht+vwweMkzuAMfo0FyVYPfqRyp
         +1C6a67QZ4qI5zJMZ7mXsPjQbf71DvlYQH3Aob9qfCl9eUEp1IK0P1cMYqgy/f6lEyth
         LeOQ==
X-Gm-Message-State: AOJu0Yx3H/qRGsCYjP269UvTP/WZzG7+f6TActDqFq5pWtvu4w2FFWhR
	4jEW9XxkT0XCRO3ITbDBDLBnIHpk5GBEdTmNaj6sKlipH6YRT0/bEydBLj5i29iFUWY/zxfP5sv
	7tizd
X-Gm-Gg: ASbGncstnDTdvhrngnJqTc+l5JgcahQ/ZDeEPH+nQywtpR/XEIuOTxr1DKAfVf4oAVF
	WM8AZ2uCa7TE/o7c++xiuJWg0/EOTWgumhefBh1Cq5A8N7IHHGMNOqAaibZbkxn6curfrHeKZZG
	/n5DYrKDwEBTZQkIQzro361n7jw5qJV/5P6rXuO8JbLkEZPvnC416XJ7fgVdPaQ/kNxuPEuCdQH
	V2rSCeCWglLAdmNjl7C5RjBBcOOLctjydXqp3GZ0oC3N/fIedXaaYV/aTSqLuh6eephSS+MQFHr
	MRrZwlHpqdphTUKSJg7Xj5MO6Ph1EyhFVlro0EDWXTtaH1Pi8Hsq6jVTsHzzDeWrns5fucSR1Z5
	BUQcWwITMekMZ1urizD/oRmE51FdLjQ5Qa7/JpS/qLaBvfutBFDvaS4fviGbgmq5BE00OkYRbPi
	Y4FYCe7ZJnAv7vzLZLlwifkED1uQaMyvN3NE/C97Gad08pj7SIwLe2h3vp4dB2Ai4=
X-Google-Smtp-Source: AGHT+IHYovV4a9Gpuo06c9elqrNq48Tbi4gQAOdywi/mMrn/Uvw+xSLx7yHy2Pel8ElRGUsxkgZ9ng==
X-Received: by 2002:ad4:4ea1:0:b0:880:22f3:335e with SMTP id 6a1803df08f44-882385a5947mr44396286d6.7.1762632968841;
        Sat, 08 Nov 2025 12:16:08 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm20001896d6.53.2025.11.08.12.16.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:16:08 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 08/11] libstd-rs: remove redundant CARGO_TARGET_DIR
Date: Sat,  8 Nov 2025 15:15:50 -0500
Message-ID: <425dc5295a6a2555f415c8118eeb41afda3a5196.1762632742.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762632742.git.scott.murray@konsulko.com>
References: <cover.1762632742.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:16:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2443

From: Ross Burton <ross.burton@arm.com>

The cargo class already sets this, so there's no need to set it again.

The value set by cargo.bbclass is actually ${B}/target, so update the
do_install task to match.

(From OE-Core rev: 3557f1c294531e7f8c34a2b0677e8c03f1b1be77)

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit ec51c22e902c2556438f1323a71a5e47ef00681e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/libstd-rs_1.90.0.bb | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/recipes-devtools/rust/libstd-rs_1.90.0.bb b/recipes-devtools/rust/libstd-rs_1.90.0.bb
index b39ec0a..8af93be 100644
--- a/recipes-devtools/rust/libstd-rs_1.90.0.bb
+++ b/recipes-devtools/rust/libstd-rs_1.90.0.bb
@@ -34,7 +34,6 @@ CARGO_BUILD_FLAGS += "--features '${CARGO_FEATURES}'"
 CARGO_VENDORING_DIRECTORY = "${RUSTSRC}/vendor"
 
 do_compile:prepend () {
-    export CARGO_TARGET_DIR="${B}"
     # For Rust 1.13.0 and newer
     export RUSTC_BOOTSTRAP="1"
 }
@@ -45,8 +44,8 @@ do_install () {
     # With the incremental build support added in 1.24, the libstd deps directory also includes dependency
     # files that get installed. Those are really only needed to incrementally rebuild the libstd library
     # itself and don't need to be installed.
-    rm -f ${B}/${RUST_TARGET_SYS}/${BUILD_DIR}/deps/*.d
-    cp ${B}/${RUST_TARGET_SYS}/${BUILD_DIR}/deps/* ${D}${rustlibdir}
+    rm -f ${B}/target/${RUST_TARGET_SYS}/${BUILD_DIR}/deps/*.d
+    cp ${B}/target/${RUST_TARGET_SYS}/${BUILD_DIR}/deps/* ${D}${rustlibdir}
 }
 
 BBCLASSEXTEND = "nativesdk"
-- 
2.51.0


