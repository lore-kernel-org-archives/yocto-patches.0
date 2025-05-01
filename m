Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5745EC3ABB6
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:02 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web10.4594.1746132057391141243
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=pTOqKsGy;
 spf=pass (domain: konsulko.com, ip: 209.85.219.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ecfc7fb2aaso14793296d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132056; x=1746736856; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EshWwHlK6IBp3xs8DjvtiCJZH8f8OSnPMOXCdgkj9q4=;
        b=pTOqKsGyaQpxJOuo9y3YZHbAbAoYR5vFYKlpGX+8mVLO1SyGMGVf//o+rCObFyDPQM
         3sTcPFCS9J40F9WmaxZvPzuaWNMTlavwG+jnIrKKuD0DiRoox1BW3oUe4APPIUArC+Hv
         A9hBzy1JV2c+X0zn/MNiujyV5rk4GLru42bm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132056; x=1746736856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EshWwHlK6IBp3xs8DjvtiCJZH8f8OSnPMOXCdgkj9q4=;
        b=ceInPL7bwhB2kbBNGKLs8GMOhPfTLPm2UzANYXZnj6xlfcQexx8HxYmKmzt+xLp7BW
         hFBr3rhvdFsB0xwxJZjB3Zmjle1s6t/XzVvWRGp3scmsZOwLMOEQuEuhjd+e0ixrjKAu
         L4DYVrFZD5uTx2sETGKWmcbaeGLFdocONMl7KDcn6bZsVeaZaQeNKKfkxZuxp4iuuL4P
         g6eLXwQPgrxQxz4mfSMNR9E8ubNiHYV912r98yaGnuuhrLheT8fDTqIz2d0Dtxogpxsc
         OadMZokp1qJ2VLRMv96RAdTEI82GB8Qam2cQXdU+juA0tuEDvKgWvD7+RSsdTo50//Og
         S+0g==
X-Gm-Message-State: AOJu0Yx9NdBybeYiSDOcmXPPmSctKstJs9+9VK/PRsKukmo9SNaJV3d7
	KUfSpOV8QHz9VHqZwa8p5sUSi13dJL6Dpya+inUSaVUhfgjJo3sR50ZLesKafdODbrWbyfdVXUN
	1
X-Gm-Gg: ASbGnct7mZQOTZdrDbVtZQI1mrWRAgJ4q/DWCKdfNDBq6VxChOOxJXCeaqcZwvwtQte
	vGEfa9wd5p4L7FgxCGspBoTX1YtZapjDQjFp+bZUk4SBAcJm/730VE+EDtp3Js6fs+P7w1y2bNg
	HPfSuRAnu9Q1i8AqOH7JDewYn50wppKiokVilfDkiuTJASPLBK2ZhQNdAZ4KXBohuZAZbhNBo6u
	N+2ucEI4tMQLPuhqB15izaqTElWLGQrp4a0C6Vv15vOSm0Yo6sJP5xrRlBbxEzKJoDTEYI9jfRL
	/JP5Z43n/urNhvZZthPbuMSvm0R0dFNF58DcH5zmUdlGCIssd6gmxvrxhPhPpPOUyNVkrgPq8mt
	awZqBIVKZX46DegtB
X-Google-Smtp-Source: AGHT+IEdjPTcgPJu2M9q8/IfRKStpP0Vy5nLvnqx8shTTG1kGYPRFUSXgg+r3XQ26s2Z41Mfuir+Gg==
X-Received: by 2002:a05:6214:e89:b0:6f2:bcbf:101c with SMTP id 6a1803df08f44-6f5155bbcaemr11352996d6.33.1746132056053;
        Thu, 01 May 2025 13:40:56 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:55 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 22/38] rust: Fix build break because of "download-rustc" and "llvm-tools"
Date: Thu,  1 May 2025 16:39:58 -0400
Message-ID: <91730582ddd39796bbeeb0d83f0be6c73753953f.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1449

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

>From Rust 1.84, the download-rustc and llvm-tools options were set to True
(previously they were False)

https://github.com/rust-lang/rust/commit/cce6f03754f096f8a2bdfb357e3739b855e29366
(download-rustc)

https://github.com/rust-lang/rust/commit/38f0c099b2e684ea689633eb424d8737a1063a5e
(llvm-tools)

For tarball sources, the download-rustc option should be False, so it has been
reverted back to False.

Setting llvm-tools to True caused issues with finding llvm-objcopy, so this
has been changed back to False.

Upstream-Status: https://github.com/rust-lang/rust/pull/134240/

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 2eb952d839e72c24a4180a57631c77910a0da980)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.83.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/rust_1.83.0.bb b/recipes-devtools/rust/rust_1.83.0.bb
index 41efcd6..40b813b 100644
--- a/recipes-devtools/rust/rust_1.83.0.bb
+++ b/recipes-devtools/rust/rust_1.83.0.bb
@@ -137,6 +137,8 @@ python do_configure() {
     config.add_section("rust")
     config.set("rust", "rpath", e(True))
     config.set("rust", "remap-debuginfo", e(True))
+    config.set("rust", "download-rustc", e(False))
+    config.set("rust", "llvm-tools", e(False))
     config.set("rust", "channel", e(d.expand("${RUST_CHANNEL}")))
 
     # Whether or not to optimize the compiler and standard library
-- 
2.49.0


