Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC4ECC6B2E
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:43 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14772.1791987160101298802
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Cxrz2W/m;
 spf=pass (domain: snapchat.com, ip: 209.85.128.53, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so35720475e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987158; x=1792591958; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GoT/nB3SMKbE6XSzoyhbYqbC/JKFDAvPVy99SZQ3/Vc=;
        b=Cxrz2W/meXLZC31FqZK2/SMmVezuosiakpKx0yrbJu+RbOay1q2CDyATcELJY+QYhw
         Ab6Sp76UYsf1vovhX2Ljw9MdInYrcR3n8zdDNKF49qsULrbloOcxwxI1U8x/nQC4vC93
         4b01fguL8cA6u9p46V5GNEYamx6oQ34Se4oAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987158; x=1792591958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GoT/nB3SMKbE6XSzoyhbYqbC/JKFDAvPVy99SZQ3/Vc=;
        b=TeKZkqnF4yLHeDT4v/ctn+KNq7j1opAciCy4yVs0gvckbox1SIBaaJ6WfFLBvYY6kO
         4yNraSSyzn3LaYGWGK2g1UFvcX8B+mW1ZkQyl/DvSndEVB7raGfvKe1HP2vxieE9ZEqt
         lJBi6nXhdJWWV4susFUD798azlUkFI4rQ13fPXeSy4C9XckJdqr1QgcIredXxkIr3vPw
         Hp7pP4+HLvkufnqldLhuS89b++qbkK2lSTSXmlx9SOrJiCFmI0A/V4Gh11yikweeAsqR
         1//MIHPnx83rytE/nF3uYisIxzNuagotMZL+Bi3Rb2TnXuTVNjUNJ9Fm3gk51LSGUEc3
         jenw==
X-Gm-Message-State: AFq9FYIa9gwAWx35cRZ1ltuLUPamkZjO7SOwVTyKQK7Kji+yLbJFj5GI
	Qws7ueHb1vawQwhWYXXy20OB/ohmxZEEpxQ586KAblPrY4+OAcGmaj37Tum/Y/krIeLi8l2f60w
	GkWbCTQs=
X-Gm-Gg: AYBFou1VU7ZtByqbHoO9LrTskdSVNSSJl/26xGHxHtXNNm6DMFs5V0WMSKb+xThtOjH
	l7s7SOnRuIpXr+toK4v4Fv2Voo3SM3RLrmij4IPu+F43B6Oj3VGWev7Q6DAUxpM3wXF8aJNi0r9
	OjAfBVM7k2oL/y/33Zkuz8arlqHApwesfvgcssvv68UEA+oNNDWINsUi7/8IFQXO/xcElvhm5rg
	Zcses25gJWLd/2ME8/rMK2KIyg44xapuBaM1p7wE4tETt0lM8d7PlaC9yr4eq403d+2KJu5MEsI
	O2MNltjwF1m2KaZhaeVmjhn3IOJg/z8Lk3SqDTJFdLvq7Yt7orqX51XR5omhHpFKEhZ/uiq9Ayn
	fLkJeAz2mvpjw08p6vG5Odl0+4zJeJDgsj82Pd1/Bu46EN31uM6DhHv4UzroYdOG6WUZ8UnllBp
	7Pk+wUIx5IvcpDGL61BPfYWuYGEZF9tU5QXHsNBgUbptB8rJSy8h8abshwbCWqKEjK1rEyF4b3J
	eQJz+sGawwu2mtMtCfvR4Wt9sPdg8cnt5ZKI12X8qK91Z0AVZTI
X-Received: by 2002:a05:600c:3111:b0:4a1:811c:8069 with SMTP id 5b1f17b1804b1-4a18e49d640mr313178985e9.8.1791987158218;
        Wed, 14 Oct 2026 07:12:38 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:37 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 13/21] clang: scope -femulated-tls/-Wno-elaborated-enum-base to toolchain-clang
Date: Wed, 14 Oct 2026 16:10:34 +0200
Message-ID: <20261014141209.488034-13-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5018

From: Etienne Cordonnier <ecordonnier@snap.com>

CFLAGS:append/CXXFLAGS:append:class-nativesdk:darwin21 applied these
clang-only flags unconditionally, even though nativesdk-clang on this
target bootstraps with GCC by default (PREFERRED_TOOLCHAIN_SDK ??=
"gcc") - the same file's own COMPILER_RT/LIBCPLUSPLUS/LDFLAGS lines
already correctly gate their clang-only bits behind :toolchain-clang,
this pair of lines just didn't. GCC rejects -femulated-tls outright,
failing CMake's compiler-works check.

AI-Generated: Claude Sonnet 5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-devtools/clang/clang_%.bbappend | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/recipes-devtools/clang/clang_%.bbappend b/recipes-devtools/clang/clang_%.bbappend
index 9aa2c83..6efe32d 100644
--- a/recipes-devtools/clang/clang_%.bbappend
+++ b/recipes-devtools/clang/clang_%.bbappend
@@ -39,19 +39,18 @@ LDFLAGS:remove:toolchain-clang:class-nativesdk:x86:darwin21 = " -Wl,-dynamic-lin
 LDFLAGS:remove:toolchain-clang:class-nativesdk:aarch64:darwin21 = " -Wl,-dynamic-linker,${base_libdir}/ld-linux-aarch64.so.1"
 
 CFLAGS:append:class-nativesdk:darwin21 = " \
-    -femulated-tls \
     -I${OSXSDK}/usr/include \
     -include TargetConditionals.h \
 "
+CFLAGS:append:class-nativesdk:toolchain-clang:darwin21 = " -femulated-tls"
 
 CXXFLAGS:append:class-nativesdk:darwin21 = " \
-    -femulated-tls \
-    -Wno-elaborated-enum-base \
     -I${OSXSDK}/usr/include \
     -include TargetConditionals.h \
     -F${OSXSDK}/System/Library/Frameworks \
     -F${OSXSDK}/System/Library/Frameworks/CoreServices.framework/Frameworks \
 "
+CXXFLAGS:append:class-nativesdk:toolchain-clang:darwin21 = " -femulated-tls -Wno-elaborated-enum-base"
 
 EXTRA_OECMAKE:remove:class-nativesdk:darwin21 = "-DPYTHON_LIBRARY=${STAGING_LIBDIR}/lib${PYTHON_DIR}${PYTHON_ABI}.so"
 EXTRA_OECMAKE:remove:class-nativesdk:darwin21 = "-DPYTHON_INCLUDE_DIR=${STAGING_INCDIR}/${PYTHON_DIR}${PYTHON_ABI}"
-- 
2.43.0


