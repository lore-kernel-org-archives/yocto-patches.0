Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB0DC3601E
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 13:54:01 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.35100.1744293235232695360
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Apr 2025 06:53:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=euaP/CA6;
 spf=pass (domain: snapchat.com, ip: 209.85.221.48, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c266c1389so502382f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1744293233; x=1744898033; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw84VvN8gNqDWDovI4uXj5Q0/jhn+AN7DYV2qE7Y1xk=;
        b=euaP/CA6U4+coKQHkDIjd3aqAArsNx6sjh6Sz3VSzVn5fE7zMlE77AJbSuJso5Z68b
         yp2L+mllpdkNMh7trqZVPlXOX9dMmjp9I187tAP9vCywfC35c16szZoSXLuNLfdMnbtZ
         qWyh+hbCVBDxgjhV20d5TivNpfqmaMzokpR0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744293233; x=1744898033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cw84VvN8gNqDWDovI4uXj5Q0/jhn+AN7DYV2qE7Y1xk=;
        b=m28JShwfaveJ/FVrquXL3PIwbY/1Bjze2jK+adiQzOgpCkdP73xoArsUttnJu6l4oG
         55GGmg3JlMOuS5DcgZBUFr0QbaFoTtwb7Cwy5JH4aO9LzZdnA2ZRoqvry0qxMEtaZG06
         OJs6JTdF5E9sIHPcpp8aHQ8zUSreItU+cLOUgW/qPkVbCpeWMb9eeWYEU+fGvu71w7XB
         vEA9fu8EvSlVXkupJaWLFkt6AOG3ejH9EplYorcid1kELdpbkuj5oWumDn83JorlHSrr
         ZWhmDaGYhoolY4BmqX4bqOHg8HzgjBjNbnGOVFR1HXmSzn4QhA68/5bXld8yCdHfV9Rg
         Fk6g==
X-Gm-Message-State: AOJu0YyrOjE1U0IMdsAGtAoRvNQDAovMxwf8ChtO42S9BEUPT6uuJz5m
	mqVLWDILRzdSdDGSeyBGtLNrABeKe2Z26zi8+5eERHYKL8r98NwxKE1X3hD/jhDwKcPRL9mMcuJ
	4FbM=
X-Gm-Gg: ASbGncuYtO9jG4erJ25GIvafrx7Y0gFXxIhX6yOd797ioPI9zC1BASxJvIkE5wlW3vA
	ecYOtEBzek0GVTvxDOT5jhynynSIlz8TrPn2vcSmjzHVlB50OQlT/IjRxQWm5itaHwhDG8+ykMS
	kXtXHNxNaMhWL5Oze2R5RdsF+nL1N7xoelJKqoCo3OVWIG5DIHEZGcv3WXFluTaGDkXype+OGk9
	AjnpXKPjxGT8frf/tyOvq0OUyZkqj1og/Xc9ImNZnxni5iyP354EgTN+rnr/gzRwOj0Ekjr5fIg
	bWHF8+b0Oc7yUKazEgzEYkR92FBQG2WGtKpSudlGvWKO2NqbU48gO+xTewDEARwPYIFgDZ+UFT0
	A8AepatQMXTLY63f3lbQ=
X-Google-Smtp-Source: AGHT+IGKFlx6vbC6Tqa/8Djhn5VPYD4Z6Gwvtuk5Bv75W9uvdpxYTLONFE9m56dn673/3WecJTaJJQ==
X-Received: by 2002:a05:6000:1ac5:b0:39c:2688:6904 with SMTP id ffacd0b85a97d-39d8fd8b801mr2302171f8f.39.1744293232941;
        Thu, 10 Apr 2025 06:53:52 -0700 (PDT)
Received: from localhost.localdomain (80-108-196-96.cable.dynamic.surfer.at. [80.108.196.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5e90sm52354385e9.38.2025.04.10.06.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:53:52 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dominik Schnitzer <dominik@snap.com>,
	Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 3/3] arm64-darwin: add new arm64 machine
Date: Thu, 10 Apr 2025 15:53:23 +0200
Message-ID: <20250410135336.20372-3-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410135336.20372-1-ecordonnier@snap.com>
References: <20250410135336.20372-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 13:54:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1355

From: Dominik Schnitzer <dominik@snap.com>

Adds a machine for initial Apple Silicon support

Signed-off-by: Dominik Schnitzer <dominik@snap.com>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 conf/machine-sdk/arm64-darwin.conf  |  3 +++
 conf/machine-sdk/darwin-common.inc  | 37 +++++++++++++++++++++++++++
 conf/machine-sdk/x86_64-darwin.conf | 39 +----------------------------
 3 files changed, 41 insertions(+), 38 deletions(-)
 create mode 100644 conf/machine-sdk/arm64-darwin.conf
 create mode 100644 conf/machine-sdk/darwin-common.inc

diff --git a/conf/machine-sdk/arm64-darwin.conf b/conf/machine-sdk/arm64-darwin.conf
new file mode 100644
index 0000000..d91a78f
--- /dev/null
+++ b/conf/machine-sdk/arm64-darwin.conf
@@ -0,0 +1,3 @@
+SDK_ARCH = "aarch64"
+
+require darwin-common.inc
diff --git a/conf/machine-sdk/darwin-common.inc b/conf/machine-sdk/darwin-common.inc
new file mode 100644
index 0000000..cec76a5
--- /dev/null
+++ b/conf/machine-sdk/darwin-common.inc
@@ -0,0 +1,37 @@
+SDK_OS = "darwin21"
+
+SOLIBS:darwin21 = ".dylib"
+SOLIBSDEV:darwin21 = ".dylibbroken"
+
+PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-for-gcc = "nativesdk-osx-runtime"
+PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-initial = "nativesdk-osx-runtime"
+PREFERRED_PROVIDER_virtual/${SDK_PREFIX}binutils = "cctools-port-crosssdk"
+PREFERRED_PROVIDER_virtual/nativesdk-libc = "nativesdk-osx-runtime"
+PREFERRED_PROVIDER_virtual/nativesdk-libintl = "nativesdk-osx-runtime"
+PREFERRED_PROVIDER_virtual/nativesdk-libiconv = "nativesdk-osx-runtime"
+
+SDKUSE_NLS = "no"
+SDKIMAGE_LINGUAS = ""
+SDK_DEPENDS:remove = "nativesdk-glibc-locale nativesdk-qemuwrapper-cross"
+
+SDKPKGSUFFIX = "nativesdk-darwin"
+
+OSX_TOOLCHAIN_OPTIONS = " \
+    -mmacosx-version-min=12.3 \
+    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/usr/lib \
+    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime/usr/lib \
+    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime/usr/lib/system \
+"
+
+TOOLCHAIN_OPTIONS:append:darwin21 = " \
+    ${OSX_TOOLCHAIN_OPTIONS}"
+TOOLCHAIN_OPTIONS:append:class-cross-canadian = " \
+    ${OSX_TOOLCHAIN_OPTIONS}"
+
+# Remove -rpath-link
+BUILDSDK_LDFLAGS = " \
+    -L${STAGING_LIBDIR} \
+    -Wl,-rpath,${libdir} \
+"
+
+MACHINEOVERRIDES .= ":darwinsdk"
diff --git a/conf/machine-sdk/x86_64-darwin.conf b/conf/machine-sdk/x86_64-darwin.conf
index 89f3e0a..199cab7 100644
--- a/conf/machine-sdk/x86_64-darwin.conf
+++ b/conf/machine-sdk/x86_64-darwin.conf
@@ -1,40 +1,3 @@
 SDK_ARCH = "x86_64"
-SDK_OS = "darwin21"
 
-SOLIBS:darwin21 = ".dylib"
-SOLIBSDEV:darwin21 = ".dylibbroken"
-
-PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-for-gcc = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-initial = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/${SDK_PREFIX}binutils = "cctools-port-crosssdk"
-PREFERRED_PROVIDER_virtual/nativesdk-libc = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/nativesdk-libintl = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/nativesdk-libiconv = "nativesdk-osx-runtime"
-
-SDKUSE_NLS = "no"
-SDKIMAGE_LINGUAS = ""
-SDK_DEPENDS:remove = "nativesdk-glibc-locale nativesdk-qemuwrapper-cross"
-
-SDKPKGSUFFIX = "nativesdk-darwin"
-
-OSX_TOOLCHAIN_OPTIONS = " \
-    -mmacosx-version-min=12.3 \
-    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/usr/lib \
-    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime/usr/lib \
-    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime/usr/lib/system \
-"
-
-TOOLCHAIN_OPTIONS:append:darwin21 = " \
-    ${OSX_TOOLCHAIN_OPTIONS}"
-TOOLCHAIN_OPTIONS:append:class-cross-canadian = " \
-    ${OSX_TOOLCHAIN_OPTIONS}"
-
-# Remove -rpath-link
-BUILDSDK_LDFLAGS = " \
-    -L${STAGING_LIBDIR} \
-    -Wl,-rpath,${libdir} \
-    -L${STAGING_DIR_HOST}${base_libdir} \
-    -Wl,-rpath,${base_libdir} \
-"
-
-MACHINEOVERRIDES .= ":darwinsdk"
+require darwin-common.inc
-- 
2.43.0


