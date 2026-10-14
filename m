Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8838CC6B2C
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:43 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14673.1791987154384483234
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=SDD2zUDg;
 spf=pass (domain: snapchat.com, ip: 209.85.128.54, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so34508625e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987153; x=1792591953; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EbSMSyIhuZGM4ySkJn/+6xatpwomzPmePNQa9BKNhtQ=;
        b=SDD2zUDg2b/Dr0lUw9dw6tsNfeBYvkmZaorfoL4ZFvgEJbMiweF+BVpm40mciIrEBS
         Vom9a4+U96ik4sIrQgBmzyzgO8KivRH+hRPTu1v8X59XBICHCMgV4Q5f4I2zzbhYVpiN
         Wp2wXdl5neIHsUsKo/kf0xxWUdAKgRm2Wi8QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987153; x=1792591953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EbSMSyIhuZGM4ySkJn/+6xatpwomzPmePNQa9BKNhtQ=;
        b=F5wn7CNcQTlY6L8ZUUn9oYTdERpRIL1VDmfAJsyIZhD6iHbb1LDVX+FHosWap/0rFg
         4Cfq2OdY6ZfUc3oKQeWzacaGdDFqE1unDTGaTiPVz67iBL+TEgWmWH4BG7SgVf3ZFmHn
         2xeftD7MYg9f5it/hKS/Re9LpLOyvQeut+uEUNen960qpNNeTNQfYkGDThjFDH7+TeOP
         RB/E3lqHCahpMpDqnBrvWR57TK9ZDFWl35edkc8iAhEToRpUHlqil9KAtiby04ZooWHe
         wLtAx9T9D/BQafjRu0JKR4mdJD07SHP2+5zKw6ES9XEWLp2wqz5q4DQ+w5pypKRdBwF7
         epEA==
X-Gm-Message-State: AFq9FYI7Fw+Y+GKZ0Um1EjKlDXTibgc4NMRX0YrOK7OUnn7AbyB8v4Z3
	27qxgdOCeDQT8HF1hlzzKiPgvczK9B79WSXNf76b5OB1hc+RVrE/kLnfZ3rgVmIXtbie/JDi2Ny
	aTx5XVpE=
X-Gm-Gg: AYBFou3yk4HzVK5Mmaeq/oXAas7FnNxXGfuOhIbyuW8wMWOWk46K3m5Xxs1iXIS7sus
	7ukrcytEYgQb/3sMCkKl7wyh5xUm3w4WCejfFh0VwMW4og86gqjyOIfTkyVGQ8BRqMnBreByoeq
	hlSeLDWLza4AGLnBFHQEUeyBMJ2vDSWqwNPgziqLXVI4FGsCC6LzRGaWz/peMDtUy+fnH1MYgZO
	qoZcgebM+tdwWXQk34vgLjgrIXMYep1R5tmJn9H1aB98C15EWn1vq2PGwSgfur03I5LUuz4cruY
	VACbUrXt6I67Jeh9t4Mm3nmPYDJEIFwTGMEyRkqpzef8rRIX8xXcoz9BxfVqQeoZTCtOGPJ94fT
	Sxi+JqpZ7rHLF/E0mumA0mS9J3u80vTTBkSq9Lckce5jaSPnAaGvfOusabl9CAjG568Ph5Ogr3n
	N0EVoZWS5BMEzsY8hEjj8CSzP/9Gni5zxc3srepaoPTc/rB0il4N6Gj9vvx1GrVoZoJH5oDrsu6
	VB4sGAunug5UGkNt+nYl2NrfIbgdSsrYtjL037tvg==
X-Received: by 2002:a05:600c:6207:b0:49f:ff73:9971 with SMTP id 5b1f17b1804b1-4a18e4aff66mr308693255e9.18.1791987152471;
        Wed, 14 Oct 2026 07:12:32 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:32 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 08/21] libdispatch-native, libtapi-native, cctools-port-crosssdk: fix ineffective clang selection
Date: Wed, 14 Oct 2026 16:10:29 +0200
Message-ID: <20261014141209.488034-8-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5013

From: Etienne Cordonnier <ecordonnier@snap.com>

TOOLCHAIN:class-native / TOOLCHAIN:class-crosssdk never actually selects
clang for these recipes: native.bbclass (and cross.bbclass, inherited by
crosssdk.bbclass) unconditionally set CC/AR/AS to ${BUILD_CC}/${BUILD_AR}/
${BUILD_AS}, which come from TOOLCHAIN_NATIVE, not TOOLCHAIN. As a result
these recipes were silently compiling with plain host gcc and rejecting
all the clang-specific -W flags/module maps in their build systems.
Matches an existing fix already applied for meta-hawaii's spk-cli
recipe (see its TOOLCHAIN_NATIVE comment).

COMPILER_RT:class-* and LIBCPLUSPLUS:class-* are also not real
variables consumed anywhere in OE-core - dead code left over from the
same misunderstanding. clang-native.bbclass already unconditionally
forces --rtlib=libgcc --unwindlib=libgcc, but nothing turns on
-stdlib=libc++ automatically, so libtapi-native and cctools-port-crosssdk
(both C++) need it set directly via CXXFLAGS/LDFLAGS.

Keep only the short, non-obvious warning in the recipe comments
(TOOLCHAIN:class-* has no effect, use TOOLCHAIN_NATIVE); the full
mechanism explanation belongs here, not in comments that will drift as
the toolchain evolves.

Actually exercising clang for these recipes for the first time surfaces
two more build breaks, fixed here too:

- libdispatch-native's src/event/event_epoll.c does
  "dmn->dmn_events & ~dmn->dmn_disarmed_events" returning uint32_t;
  harmless under -Wsign-conversion but fatal under this recipe's
  -Werror.
- cctools/include/stuff/bool.h declares "enum bool { FALSE, TRUE };",
  which fails to parse under C23 (bool is a reserved keyword there, not
  a macro). clang's default C dialect defaults to gnu23 absent an
  explicit -std=, which is what surfaces this now that
  cctools-port-crosssdk actually builds with clang.

AI-Generated: Claude Sonnet 5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../cctools-port/cctools-port-crosssdk_1010.6.bb   | 14 +++++++++++---
 .../libdispatch/libdispatch-native_git.bb          |  9 ++++++++-
 .../libtapi/libtapi-native_1300.6.5.bb             |  8 +++++---
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb b/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb
index 3abeb02..dcd5d01 100644
--- a/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb
+++ b/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb
@@ -23,9 +23,17 @@ DEPENDS += " \
     libcxx-native \
 "
 
-TOOLCHAIN:class-crosssdk = "clang"
-COMPILER_RT:class-crosssdk = "-rtlib=libgcc --unwindlib=libgcc"
-LIBCPLUSPLUS:class-crosssdk = "-stdlib=libc++ -lc++abi"
+# Selects clang for the native build; TOOLCHAIN:class-crosssdk has no effect here.
+# -stdlib=libc++ isn't added automatically, so this is C++ and needs it set directly.
+TOOLCHAIN_NATIVE = "clang"
+CXXFLAGS:append:class-crosssdk = " -stdlib=libc++"
+LDFLAGS:append:class-crosssdk = " -stdlib=libc++"
+
+# cctools' own include/stuff/bool.h declares "enum bool { FALSE, TRUE };",
+# which is a hard syntax error under C23, where bool is a reserved keyword
+# rather than a macro. Pin the C dialect to a pre-C23 standard rather than
+# relying on clang's default (gnu23 as of this clang version).
+CFLAGS:append:class-crosssdk = " -std=gnu17"
 
 EXTRA_OECONF:append = " \
     --with-llvm-config=${STAGING_DIR_NATIVE}/usr/bin/llvm-config \
diff --git a/recipes-devtools/libdispatch/libdispatch-native_git.bb b/recipes-devtools/libdispatch/libdispatch-native_git.bb
index c7dadd0..a3a1b2e 100644
--- a/recipes-devtools/libdispatch/libdispatch-native_git.bb
+++ b/recipes-devtools/libdispatch/libdispatch-native_git.bb
@@ -19,4 +19,11 @@ DEPENDS += " \
 "
 
 TC_CXX_RUNTIME:class-native = "llvm"
-TOOLCHAIN:class-native = "clang"
+
+# Selects clang for the native build; TOOLCHAIN:class-native has no effect here.
+TOOLCHAIN_NATIVE = "clang"
+
+# src/event/event_epoll.c (the Linux epoll port) hits a benign sign-conversion
+# warning on a plain bitmask op; upstream's own -Werror -Wsign-conversion
+# combo doesn't exempt it.
+CFLAGS:append:class-native = " -Wno-error=sign-conversion"
diff --git a/recipes-devtools/libtapi/libtapi-native_1300.6.5.bb b/recipes-devtools/libtapi/libtapi-native_1300.6.5.bb
index 5442f39..545aa59 100644
--- a/recipes-devtools/libtapi/libtapi-native_1300.6.5.bb
+++ b/recipes-devtools/libtapi/libtapi-native_1300.6.5.bb
@@ -24,9 +24,11 @@ DEPENDS += " \
     libcxx-native \
 "
 
-TOOLCHAIN:class-native = "clang"
-COMPILER_RT:class-native = "-rtlib=libgcc --unwindlib=libgcc"
-LIBCPLUSPLUS:class-native = "-stdlib=libc++ -lc++abi"
+# Selects clang for the native build; TOOLCHAIN:class-native has no effect here.
+# -stdlib=libc++ isn't added automatically, so this is C++ and needs it set directly.
+TOOLCHAIN_NATIVE = "clang"
+CXXFLAGS:append:class-native = " -stdlib=libc++"
+LDFLAGS:append:class-native = " -stdlib=libc++"
 
 CXXFLAGS += " \
     -I${S}/projects/clang/include \
-- 
2.43.0


