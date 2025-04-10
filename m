Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A7AC3601E
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 13:48:11 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.34585.1744292883085394485
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Apr 2025 06:48:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=e8uvVBvU;
 spf=pass (domain: snapchat.com, ip: 209.85.128.47, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso7547565e9.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1744292881; x=1744897681; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI8MKZVaqzrLpnC8oymQ3Tciyp8WA4kRGu9jNheDSWY=;
        b=e8uvVBvUS6PqbC7qxgKPM7bplXCA9e5cJe03CKc2x5m0fnrCO4ao/6dKBxt6GRVJWE
         v/vZvM91GagHT9hQkT0jWdeD8m7po6v7Rd+529h7NXttDOMnbAvW6jZLvkXLdvATgsCm
         OIzxIpnSyXrKCQzdW75IqRFRnggkVQkU+/U+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292881; x=1744897681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI8MKZVaqzrLpnC8oymQ3Tciyp8WA4kRGu9jNheDSWY=;
        b=DxyUMJL58XBZp4xyfCiK5rmpg+I7ojEGwfH48WRNlIm8kUWGm0H1mn7ckVNwbPZ93N
         ME9M+uToGGJsG2SQuZnfl1/Yg0n7RchxL/UzjjJ0HP6OV2YU99coVtejwgeJeY20bxp0
         UVST9lU8efJGhsFV0RCda8EhlKnVb0WDjOpScJrFoElqMSRi9JtzZLUqrIi2yNKfBhH0
         mkPrbkMXadtpbysBugZVhNTm1WpKC6L4PMk8q+CUc3ltmmKPXi+EAMEmu0+ZV3FlfDNz
         W5xwxZh9HK2wXiayyPe5PRccy08x5SreBrXBg2OPnq+X3gvobdGzcmfoIzUR0eNvRhap
         N6SA==
X-Gm-Message-State: AOJu0Ywg7GAwmzlr4uWwAt9/kbY268qIMMds8EYbddjtYp0kxleObZQK
	0EuCrjrc/rPeTNKcsLUJz2qZ+JmisdK1nDeoreWuTNeHVv+Y9+2U3TW+3D+x0nRqOHb+y+Qk7hR
	8370=
X-Gm-Gg: ASbGncuIeNglP0PYPLWgyIhj3pqd791FHoPbfNTzdt+WSOO7jSnQ0Q0Usl+2VObOU9E
	8b38v71asaBqSiK1B5rann4rBjtUI1AjAygFJ2kTfHYEv+acvd/jwk/pAtMeIsHbXl9pdh8cEbZ
	6eiJ9GpKxwFVc2Uumc6h/RweZgJfTBmIA6a1RPMwVhBFboPf+B4Hw6Wra//I3mS1uaknkpxbf25
	Cz8sh+fxb9XngIzUuphGe5s8dl0vg+EiTZzQOIIRkq+hVjmFbxL9TgtKr4zfx6pL9e1sTaXO3bN
	2axlbEZIZtea5/OODHDu5tgjtQP1Q8bORI1MqbCDusgRJj9rxQ/jHtGPcCAUsI6/2r6oa8RzFQM
	QZ8QNtrIjzJ13dzeMN0s=
X-Google-Smtp-Source: AGHT+IGnNDNWTGSAliAOKI/aDDrcvQWB4hoL3z0aAcO9M9Boj1LeWlIN66G0DAJde98yPbf+uQmNyQ==
X-Received: by 2002:a05:6000:1a8e:b0:39a:c832:4f46 with SMTP id ffacd0b85a97d-39d8f4715f5mr2747991f8f.26.1744292880635;
        Thu, 10 Apr 2025 06:48:00 -0700 (PDT)
Received: from localhost.localdomain (80-108-196-96.cable.dynamic.surfer.at. [80.108.196.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89378daasm4886996f8f.38.2025.04.10.06.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:48:00 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dominik Schnitzer <dominik@snap.com>,
	Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 4/4] libdispatch: add apple-libdispatch 1.3
Date: Thu, 10 Apr 2025 15:45:10 +0200
Message-ID: <20250410134510.17001-4-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410134510.17001-1-ecordonnier@snap.com>
References: <20250410134510.17001-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 13:48:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1351

From: Dominik Schnitzer <dominik@snap.com>

Signed-off-by: Dominik Schnitzer <dominik@snap.com>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../libdispatch/libdispatch_git.bb            | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 recipes-devtools/libdispatch/libdispatch_git.bb

diff --git a/recipes-devtools/libdispatch/libdispatch_git.bb b/recipes-devtools/libdispatch/libdispatch_git.bb
new file mode 100644
index 0000000..05b309d
--- /dev/null
+++ b/recipes-devtools/libdispatch/libdispatch_git.bb
@@ -0,0 +1,27 @@
+# Copyright (C) 2025, Snap Inc.
+# SPDX-License-Identifier: MIT
+
+SUMMARY = "Apple Grand Central Dispatch (libdispatch)"
+HOMEPAGE = "https://github.com/tpoechtrager/apple-libdispatch"
+LICENSE = "Apache-2.0"
+LIC_FILES_CHKSUM = "file://${WORKDIR}/git/LICENSE;md5=1cd73afe3fb82e8d5c899b9d926451d0"
+
+SECTION = "devel"
+
+SRCREV = "e85f6a0d5c9ea1f32f5013c3fa34e4fc146cd0eb"
+SRC_URI = "git://github.com/swiftlang/swift-corelibs-libdispatch.git;nobranch=1;protocol=https"
+
+inherit cmake
+
+BBCLASSEXTEND = "native"
+
+S = "${WORKDIR}/git"
+B = "${WORKDIR}/build"
+
+DEPENDS += " \
+    clang-native \
+    libcxx-native \
+"
+
+TC_CXX_RUNTIME:class-native = "llvm"
+TOOLCHAIN:class-native = "clang"
-- 
2.43.0


