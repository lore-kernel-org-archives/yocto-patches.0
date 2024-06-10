Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E95C27C5E
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 14:33:11 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web11.21025.1718029985101672399
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Jun 2024 07:33:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Qqdkv2TI;
 spf=pass (domain: snapchat.com, ip: 209.85.208.42, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c73a3b3d7so2073058a12.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1718029983; x=1718634783; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RD8zpPUogG+bX58a0jW0bkSKZ2kwDhYSZEk1rveXt6Q=;
        b=Qqdkv2TIggpDM9kmVjcUNF3KqFj39qL91Y19iJFZOfSUmNI3a4ejXKLaROJMaVlOwA
         Xg2z4evJ5bgZBCKt79OxiNNGwVPZQU7B20r16tblzJg6wcLSqkboVWDLy11zokWAZ0Bf
         +nMXNADB4UPuRQyo6/QcOhpQOIhIAdJTIG7C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029983; x=1718634783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RD8zpPUogG+bX58a0jW0bkSKZ2kwDhYSZEk1rveXt6Q=;
        b=EEu+sSh5dQdrbNNnHOmnmjB3GQr5OFQIBv6K3M95b3mwdNTeg3nuZuTbd1AP9KW/jw
         UcvuMcpZd+Qe1zvxi92VeUPfEAeUESfHcYvbrajT3MW/FIYPcYuv+FWMokRrLXN67NiJ
         WN1UJqyEcWE6AmbsB1P9FnfrSJqC391LDo4+W/PhRuv2hhq2G+J4oICcJO1lUHtdrDom
         3CtUwoxPl/a2dZujRoQG6oggq0MiuuU5EPN/WhyN5j9jtuc3VX6yJfAnNa/Qa/zn9O7p
         oxRA1cT2SHf5gLoXQyuai+AfpXip+83H/oh+bFO9jMfmkbbLFODUEEIpgBqeszE6aU9g
         XVhA==
X-Gm-Message-State: AOJu0YylgKKJllMu4ifLjqDvGqzinPXPfxtuJa0OtUi/3eUzm/Bcbrfo
	nSH3GRslDTYp+n52b7a1djjIJ7WGwTR2g2TvW3tLfgLXj0Ji0Olq76c1grTaQegTGRCVflXLF9P
	AdLA=
X-Google-Smtp-Source: AGHT+IFLhMyVR9JlhvDRivvjQ1EIINHO6Qu42N3uGqfbE8m+XycPec+niMWVYDjpQvT9PYb3eREmXQ==
X-Received: by 2002:a50:9556:0:b0:57c:6953:2cac with SMTP id 4fb4d7f45d1cf-57c69532cbcmr3361380a12.22.1718029983193;
        Mon, 10 Jun 2024 07:33:03 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae237408sm7504233a12.93.2024.06.10.07.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:33:02 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 10/11] binutils-crosssdk -> binutils
Date: Mon, 10 Jun 2024 16:32:13 +0200
Message-Id: <20240610143214.2376414-10-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20240610143214.2376414-1-ecordonnier@snap.com>
References: <20240610143214.2376414-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 14:33:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/292

From: Etienne Cordonnier <ecordonnier@snap.com>

This was renamed in poky.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 conf/machine-sdk/x86_64-darwin.conf                            | 2 +-
 recipes-devtools/cctools-port/cctools-port-crosssdk_973.0.1.bb | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/conf/machine-sdk/x86_64-darwin.conf b/conf/machine-sdk/x86_64-darwin.conf
index c4a111d..89f3e0a 100644
--- a/conf/machine-sdk/x86_64-darwin.conf
+++ b/conf/machine-sdk/x86_64-darwin.conf
@@ -6,7 +6,7 @@ SOLIBSDEV:darwin21 = ".dylibbroken"
 
 PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-for-gcc = "nativesdk-osx-runtime"
 PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-initial = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/${SDK_PREFIX}binutils-crosssdk = "cctools-port-crosssdk"
+PREFERRED_PROVIDER_virtual/${SDK_PREFIX}binutils = "cctools-port-crosssdk"
 PREFERRED_PROVIDER_virtual/nativesdk-libc = "nativesdk-osx-runtime"
 PREFERRED_PROVIDER_virtual/nativesdk-libintl = "nativesdk-osx-runtime"
 PREFERRED_PROVIDER_virtual/nativesdk-libiconv = "nativesdk-osx-runtime"
diff --git a/recipes-devtools/cctools-port/cctools-port-crosssdk_973.0.1.bb b/recipes-devtools/cctools-port/cctools-port-crosssdk_973.0.1.bb
index 93062b1..1246d88 100644
--- a/recipes-devtools/cctools-port/cctools-port-crosssdk_973.0.1.bb
+++ b/recipes-devtools/cctools-port/cctools-port-crosssdk_973.0.1.bb
@@ -11,7 +11,7 @@ PR = "r2"
 inherit autotools crosssdk
 
 DEPENDS += "util-linux-native openssl-native xar-native libtapi-native"
-PROVIDES = "virtual/${TARGET_PREFIX}binutils-crosssdk"
+PROVIDES = "virtual/${TARGET_PREFIX}binutils"
 
 DEPENDS += "clang-native libcxx-native"
 
-- 
2.36.1.vfs.0.0


