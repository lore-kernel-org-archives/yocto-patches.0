Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B4FCC6B2C
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:55 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14774.1791987164921090160
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=WFKXX+ty;
 spf=pass (domain: snapchat.com, ip: 209.85.128.47, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso10292895e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987163; x=1792591963; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uk08o3CHU6owgsQDx0yh6Tdb4tGCocwP5yAPNqyTRl4=;
        b=WFKXX+tyBF5eKYXXk497YKf68Ja0GDy1dFZd6KFzJDXfNuwipDVbYZ+5v73ohptT5U
         aC1D7mNn/r+2gFheqG/yFiyICnTxZ5cj2RnfpTZlKf4D31J4DitRMqBjP8cGXonyh0Xl
         eL2zuCwcnv8HMunkL/iVrxw/ys3bzHzjFCEZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987163; x=1792591963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uk08o3CHU6owgsQDx0yh6Tdb4tGCocwP5yAPNqyTRl4=;
        b=Dp5S2m0tRXGSM+2nu8WFJrksawHnSAnzsie4uCYQOGK4W4iX//adBiP0uaifqwztc0
         bdVyOx+0CuSvyM5RFUNj4U2DzJ7Q98rrE8J97urwW4Bol7AtrKSx6AOcaRz5JyjYNC8i
         vdHiWockMTRwWzWyOcS23j39gykuu9Ty795Hokl/20D11XVg2jfN99TTw0FhP+8XzOmd
         cJERAMb+bUgNAEzdEjL1GSZHTpNfr0VjIHfZm/E+TeZPpUEhmzafj38Q31HUUsIx0STh
         +i9DHtfEtRdL2SR2mA90V4N+XCKl1heBy08dHYEjM7vYw6g62w++b9KqoUPN76/uzkrJ
         00Aw==
X-Gm-Message-State: AFq9FYInqvKlMzn+t6kL2NwFd59GOg6dG0IAFn70sLdMcmm6+fq7GA/2
	QW66A+ToJfhwBQzVhi/ix1g6UjfiVKwNF3xy3+OK2ISesIC3e1MWpI/VvsbRdwPWrix7HTA68VM
	5cZjLvAI=
X-Gm-Gg: AYBFou0KxM9gQ8gmB/ISaXqRV/f28J85XjeO63S+OVfJ6l/bqUwzqlFTx/zIX2ECxiM
	d37nvxjK43CmHguCjOJNFosarrkVptLtXmDMOSY0HWgicB1H7ZZHYnDjNXDvnkzJT6P0K+wTYXu
	MITb0waOfa8XxXv5XGHuxSCJJu4cCz+eZF2eBYltE9wqxql6TvltIWJb79YRHBAiGRx59XALOFh
	BCJucMf+F2g0c3A8IeVDX7GsX8cz4U8U0ifAkW9+q3RMY5aPms7XVjx03RwdJUODI1OGTpuiqV4
	An0DQuexMTn0PaajyCM1wXhdtGvuELHupbpQH43VnYZN32Icft14rr0jt2+Nq5BIqX+J8AC1UER
	n24ZOpcNpAwOJ3MbNAYYIVg12dtIs4Pyhn5AIjmeSKNnx+5VWLFqgw0L8G8DQN+XFmqMiMmwPIB
	QICKNdffZi6su8ZHhsxv2inVhatsT/D5Rl8AsNIl4iOCRMFoUvVCjuQG0AWB/o6/xo1LOZElqn5
	rPB0pAzT4oeCo68coj99qdAltAhsIndwpYJ9h6P1Q==
X-Received: by 2002:a05:600c:4e41:b0:49f:c1a1:5222 with SMTP id 5b1f17b1804b1-4a18e4d80bdmr312207015e9.33.1791987163052;
        Wed, 14 Oct 2026 07:12:43 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:42 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 17/21] darwin-common: add the nativesdk include dir to the header search path
Date: Wed, 14 Oct 2026 16:10:38 +0200
Message-ID: <20261014141209.488034-17-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5021

From: Etienne Cordonnier <ecordonnier@snap.com>

gcc-crosssdk's built-in header search on Darwin only covers the OS SDK
tree (.../runtime/usr/include). Headers staged by our own nativesdk
recipes live one level up and are only found via an explicit -I, e.g.
nettle's gmp.h, curl's openssl/ssl.h (pkg-config drops the Cflags as a
"system" path), file's lzma.h and llvm's zstd.h.

Add -I${STAGING_INCDIR} to CPPFLAGS for every nativesdk recipe instead
of per recipe. cmake.bbclass only feeds CFLAGS/CXXFLAGS into the compile
flags, so llvm gets it through those, plus -F for the CoreFoundation
framework that dsymutil needs.

Tested by building nativesdk-nettle, nativesdk-curl, nativesdk-file and
nativesdk-llvm for x86_64-darwin.

AI-Generated: Claude Sonnet 5.5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 conf/machine-sdk/darwin-common.inc     |  6 ++++++
 recipes-devtools/clang/llvm_%.bbappend | 15 +++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 recipes-devtools/clang/llvm_%.bbappend

diff --git a/conf/machine-sdk/darwin-common.inc b/conf/machine-sdk/darwin-common.inc
index 1e3f03b..a23c605 100644
--- a/conf/machine-sdk/darwin-common.inc
+++ b/conf/machine-sdk/darwin-common.inc
@@ -91,3 +91,9 @@ fakeroot create_macos_img() {
 # every nativesdk/cross-canadian compiler command line, and those end up in
 # headers (e.g. gmp.h's __GMP_CC), libraries and binaries.
 ERROR_QA:remove = "buildpaths"
+
+# gcc's built-in header search on Darwin only covers the OS SDK include tree
+# (.../runtime/usr/include); headers staged by our own nativesdk recipes live
+# one level up and are only found via an explicit -I. Do this for every
+# nativesdk recipe instead of per recipe (see e.g. curl, nettle).
+CPPFLAGS:append:class-nativesdk = " -I${STAGING_INCDIR}"
diff --git a/recipes-devtools/clang/llvm_%.bbappend b/recipes-devtools/clang/llvm_%.bbappend
new file mode 100644
index 0000000..8565d67
--- /dev/null
+++ b/recipes-devtools/clang/llvm_%.bbappend
@@ -0,0 +1,15 @@
+# Unlike autotools recipes (nettle, curl), cmake.bbclass feeds CMAKE_C_FLAGS/
+# CMAKE_CXX_FLAGS from CFLAGS/CXXFLAGS only, not CPPFLAGS, so the usual
+# CPPFLAGS:append trick for missing nativesdk headers has no effect here.
+# zstd's headers are staged in the nested nativesdk sysroot, not the runtime
+# macOS SDK tree gcc's default search covers.
+CFLAGS:append:class-nativesdk:darwin21 = " -I${STAGING_INCDIR}"
+CXXFLAGS:append:class-nativesdk:darwin21 = " -I${STAGING_INCDIR}"
+
+# OSXSDK is only set in clang's own bbappend, which doesn't carry over to this
+# recipe's metadata, so redefine it here too.
+OSXSDK:class-nativesdk:darwin21 = "${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime"
+
+# dsymutil (tools/dsymutil/CFBundle.cpp) needs the CoreFoundation framework;
+# frameworks need -F, not -I.
+CXXFLAGS:append:class-nativesdk:darwin21 = " -F${OSXSDK}/System/Library/Frameworks"
-- 
2.43.0


