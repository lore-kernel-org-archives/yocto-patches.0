Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D84CC6B2A
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:43 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14676.1791987160792525691
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=fFeAnMiy;
 spf=pass (domain: snapchat.com, ip: 209.85.128.51, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso32401915e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987159; x=1792591959; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XF1P7a6wgxPy3xegNwErPaqZnul6C/Jihhy6CKkCGkY=;
        b=fFeAnMiyrta3X9vaoSdpZDrmo8E6AWJOwptly9X6G0Ox9n39RGnYxF9DSK9ij4O9CA
         Nb+GpIC6ikYjdAhik9sumdlahaI84Cu8Gj+RdIXEgQOa232NYjtxyJrc0109QAXu3V4e
         2d3zQLsjYO0/YMlp5c+XFrMJ5R48paAQfIMvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987159; x=1792591959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XF1P7a6wgxPy3xegNwErPaqZnul6C/Jihhy6CKkCGkY=;
        b=qWLSLM6t4B2BOX4LNhc4Ln7VSTVhP0pAqvUJiSwNi45MhSEvmAEK5o3MTvknAQRbPu
         mDsHshdzzELnTzx24tV7ms3texpfL/n9kTdgiQUY3B8GCy1VboCXx+YRxtE/A92LR57Q
         /2UkKrGbvgksd43jCikAmCAzaj67r6ubta59Fz9uy5Bb7fS4XqNvWrYC9Ju7+cx/cit7
         LIkz5x39JbZ/gaamomM+9g4TFfd3Pv/wlgfSMj2O1JKuKQoeJ7kPnNmqWUORorLLfbhR
         fkTZTpUaZB2RthyS16N7bUy6xQQB0O3pWn3nJ4Z8tnw5OREn0i9Pno6PIf7N7mrP56fc
         hnDg==
X-Gm-Message-State: AFq9FYKLSV9F1Olu2iwg5HYJG6C4Ib6rl4hUPuw8E5Y47FLDDDNzmy7t
	i/MBAwlKj3Fox8IXBO+ulybfoE9K/3UFTpSaVxk5o7QMU1ynzm0V2rbp0zTY587L68oy2/Lp744
	vvopJoA8=
X-Gm-Gg: AYBFou1vh8vOyzy+7uGHIJzQ+VQOshq/ok3V2lRwsWkHeLyYTJ9v4H3fdNqJYyMfM5W
	cxrslMsJxE5vDMOrN3ToySCvP2b+bh75Zp382/11ST0ZMWA11gfRTusOKijLscs61PFeEzlrKhT
	spJ2+OauqA6mEs7qdeJTo/qYpJPgJR8K5Y3bHlo3fzo1HMYX1TwkITcunTFX6KsUPsaDk9oobfR
	qUyztHWtkyMMvBL7Ht6YgtXQiL7ShNG2n+lTsNNn1DtCoISmGVYplxblHedrHuSgK3hgrqLi1iq
	VsQC4QevTsY6tFo9fLbLuOf466nbsLxknS1ocVcXE1omAOqHe38YNJNehmdSw0uPFxf+Sn4gAAv
	RmFhtSZPabAnj0F8TrlnmDm5ghRmknYZ3fXdv2AZnDvaNmRkUa1s1oWRbGSvktO3mrFyH7mH+bv
	HECeQ7cITb8uN2Ra1Kgn8ec65gRz8RipCX3qSenttWOu2+a/a3P0TyKMjxowV/0ouyh/RC93KQu
	bn5stxVJ599SVevcuAsdpibkFYlMTl3r0eWJn9hXwiVMJS1FcN+
X-Received: by 2002:a05:600c:810a:b0:4a0:ec5:46d9 with SMTP id 5b1f17b1804b1-4a18e3ef100mr300809215e9.0.1791987158936;
        Wed, 14 Oct 2026 07:12:38 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:38 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 14/21] clang: disable clangd's XPC transport for the Darwin nativesdk build
Date: Wed, 14 Oct 2026 16:10:35 +0200
Message-ID: <20261014141209.488034-14-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5019

From: Etienne Cordonnier <ecordonnier@snap.com>

clangd/xpc/XPCTransport.cpp uses Apple Blocks syntax ("^{ ... }"),
a Clang-only language extension with no equivalent GCC support at
all (not fixable via any flag). CLANGD_BUILD_XPC defaults on whenever
CMAKE_SYSTEM_NAME is Darwin, regardless of which compiler is actually
doing the build. XPC is an optional IPC transport for clangd, not
needed here, so disable it instead of requiring Clang to bootstrap
itself.

AI-Generated: Claude Sonnet 5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-devtools/clang/clang_%.bbappend | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-devtools/clang/clang_%.bbappend b/recipes-devtools/clang/clang_%.bbappend
index 6efe32d..1947781 100644
--- a/recipes-devtools/clang/clang_%.bbappend
+++ b/recipes-devtools/clang/clang_%.bbappend
@@ -57,6 +57,7 @@ EXTRA_OECMAKE:remove:class-nativesdk:darwin21 = "-DPYTHON_INCLUDE_DIR=${STAGING_
 EXTRA_OECMAKE:remove:class-nativesdk:darwin21 = "-DPYTHON_EXECUTABLE='${PYTHON}'"
 EXTRA_OECMAKE:append:class-nativesdk:darwin21 = " \
     -DCMAKE_FRAMEWORK_PATH='${OSXSDK}/System/Library/Frameworks'\
+    -DCLANGD_BUILD_XPC=OFF \
     -DLLDB_USE_SYSTEM_DEBUGSERVER=ON \
     -DLLDB_INCLUDE_TESTS=OFF \
     -DLLDB_ENABLE_PYTHON=OFF \
-- 
2.43.0


