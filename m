Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD5ACC6B1D
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:54 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14776.1791987165526955190
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=azaTqOyj;
 spf=pass (domain: snapchat.com, ip: 209.85.128.48, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a02718da81so33617275e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987164; x=1792591964; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mgpWFb3dBkfqn6x9tXkYLR3G08aYFtXV6e4x45c+sSY=;
        b=azaTqOyjYC5w+9jbDCTNo9x2K+5KTmTIi1ygnX7iwCP37rXpM+N+iY7MP44+8h2syX
         A/0VwdxrVDb1ziVHeMGcHFJ3EmTGeBOal8ncGA6FGg3C5nE1UEd2mW2MtgFyS9H0E2DU
         96YMpGQYGuRyaYHHsph2YNrm4cPIhv7upeD+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987164; x=1792591964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mgpWFb3dBkfqn6x9tXkYLR3G08aYFtXV6e4x45c+sSY=;
        b=ECj1yKGTW8EgzujqUZ+nrX3p+aqxmu+RLR78T755pvwCTIZwzrz7CBpPPH+XXD6Gni
         7+PN53gtdK9lbEvDNkT4B0jJWX655IlqTFw3Y7l5UK+il3BmggaZqx27iOrICJ/6jOOo
         fssHTogE9PoBu6MsW3OoBQ8pM5gbWvj/usE98fiXhtVFc+H09eZ1IS9IA8fH2dWWNDDd
         ZHof9MRpyvwRPLClT2R+0/YtRAwBH3LowXOnnEKSJc/xBEYAATPXfbsWfG557My3Xmg3
         +U12Cmg3D6awovsqko1SNUVHXCVn09yypJpdxfXQWxlOwCda6Sh2JEJKRjKx4bleDEgS
         VnpA==
X-Gm-Message-State: AFq9FYLzemm7nRX56MlZ9YIb2phzMFQyFCFtc7vS9POogPDbC9HexRxh
	YEMq229MccZ49Q5ZIYUMpUDE33HsJpTLZwOW9sqbDMLBMUmhlUyH7SkaqMQaj/kj05aOIAaVEfR
	jt1L0vvI=
X-Gm-Gg: AYBFou3b7cU5xJvGHQRgouyVgxXdoQT4yCnZKKIiki00aSTBMf7B+9yAUd4sGFgEtAz
	psVYX00livRU7HvSrbCRies0ipSs2MXRXGEk6Ppmz2ykqbJfWKiro2rgKzasa4WYUb9c0W0bIEd
	GDisZQOh/sYe/Pz9DFuQlrCWjh/IkatAcFdkekSmgGUC9UhjSb0mO1JZ24RDrrKTNm8Qi+o/y4F
	xyVoyCvpRPKtuW9L9eGOX84GDKz2uk7Sy69cKfXLTAZg0ZfPVq7zq3rwnjk092p0yBCcFt4fJsx
	RKWwyMkpn/int0JYL9vG/pkFSDKwXvz4E/nSGsyl17wXuCbJbBdtmYlCXWuzEYum/mGN4C+ko5W
	8WaxRZ/RK4Qs4q74+KvKBcd1pQXMenF5mYSU4yPu21M222CRFqOr+pquY0EftSNyEx6Ozt5bgH5
	c/9cKRJTqb+4XOhZqQU9fOrZ5u9zM2OcWYT8tgkNiy/l3IVK8N2OFN1U1M1L7dws/wxpOumTthi
	y+9S46bqDorzsRNvfop2fEvavD/i/h2VnGLRj/vwA==
X-Received: by 2002:a05:600c:8217:b0:49f:ce73:5e96 with SMTP id 5b1f17b1804b1-4a18e4d811fmr333788975e9.34.1791987163670;
        Wed, 14 Oct 2026 07:12:43 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:43 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 18/21] util-linux-libuuid: fix GCC ICE in uuid_time.c on Darwin nativesdk
Date: Wed, 14 Oct 2026 16:10:39 +0200
Message-ID: <20261014141209.488034-18-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5023

From: Etienne Cordonnier <ecordonnier@snap.com>

GCC's Mach-O backend ICEs in assemble_alias on the weak alias of
uuid_time in uuid_time.c. The file already has an asm-alias workaround,
but only for clang; let GCC use it too.

Tested by building nativesdk-util-linux-libuuid for x86_64-darwin.

AI-Generated: Claude Sonnet 5.5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 ...alias-for-uuid_time-on-all-Apple-com.patch | 21 +++++++++++++++++++
 .../util-linux/util-linux-libuuid_%.bbappend  |  7 +++++++
 2 files changed, 28 insertions(+)
 create mode 100644 recipes-core/util-linux/files/0001-libuuid-use-asm-alias-for-uuid_time-on-all-Apple-com.patch
 create mode 100644 recipes-core/util-linux/util-linux-libuuid_%.bbappend

diff --git a/recipes-core/util-linux/files/0001-libuuid-use-asm-alias-for-uuid_time-on-all-Apple-com.patch b/recipes-core/util-linux/files/0001-libuuid-use-asm-alias-for-uuid_time-on-all-Apple-com.patch
new file mode 100644
index 0000000..0a75554
--- /dev/null
+++ b/recipes-core/util-linux/files/0001-libuuid-use-asm-alias-for-uuid_time-on-all-Apple-com.patch
@@ -0,0 +1,21 @@
+From: Etienne Cordonnier <ecordonnier@snap.com>
+Subject: [PATCH] libuuid: use the asm alias for uuid_time on all Apple compilers
+
+The weak alias attribute ICEs GCC's Mach-O backend (in assemble_alias),
+so the clang-only asm alias workaround must also be used when building
+with GCC for Darwin.
+
+Upstream-Status: Pending
+Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
+---
+--- a/libuuid/src/uuid_time.c
++++ b/libuuid/src/uuid_time.c
+@@ -144,7 +144,7 @@
+ }
+ #if defined(__USE_TIME_BITS64) && defined(__GLIBC__)
+ extern time_t uuid_time64(const uuid_t uu, struct timeval *ret_tv) __attribute__((weak, alias("__uuid_time")));
+-#elif defined(__clang__) && defined(__APPLE__)
++#elif defined(__APPLE__)
+ __asm__(".globl _uuid_time");
+ __asm__(".set _uuid_time, ___uuid_time");
+ extern time_t uuid_time(const uuid_t uu, struct timeval *ret_tv);
diff --git a/recipes-core/util-linux/util-linux-libuuid_%.bbappend b/recipes-core/util-linux/util-linux-libuuid_%.bbappend
new file mode 100644
index 0000000..826e362
--- /dev/null
+++ b/recipes-core/util-linux/util-linux-libuuid_%.bbappend
@@ -0,0 +1,7 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
+
+# GCC's Mach-O backend ICEs on __attribute__((weak, alias())) in
+# uuid_time.c; use the asm alias path for GCC too.
+SRC_URI:append:darwin21 = " \
+    file://0001-libuuid-use-asm-alias-for-uuid_time-on-all-Apple-com.patch \
+"
-- 
2.43.0


