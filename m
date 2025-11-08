Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47833CD1292
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:16:10 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13111.1762632968648157932
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:16:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sWOsTAKb;
 spf=pass (domain: konsulko.com, ip: 209.85.219.41, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88245cc8c92so1065146d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762632967; x=1763237767; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRBbinreIDdxZaLbPrqXMTAs6me8siCR2HoeeR3FAE8=;
        b=sWOsTAKbXuo5nuVoqU1tSm19U+f32AhUpHv/GipPJpLqTxAJkmFMHVUr53bcttxr4F
         CsC2GiKbnwXKo0HfSapJltV6S5ZMcNoKg4IKKOCkjWAYxNCfpuqUW8MtpTnofUWz7OMJ
         YJsitRuFcFZRbS7izu2ybV2f83pfjYklqq/90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632967; x=1763237767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fRBbinreIDdxZaLbPrqXMTAs6me8siCR2HoeeR3FAE8=;
        b=ZxFcSVQ+iZPatc652cJKxnvDfF8N05uUpOElPQaF6RoUJXwFWUaJbGYKmsGOYKwe02
         /NhkuXoktqJR0GtHhJs6c/8qrEl3kYtVphh0yQnSxuqhous6hVGERvnyBG+H3uwSJx9s
         NpvUcy+1PQP0b3rDGmXglT7vlR1UbV3yAWc6QXdaPFBN3SLaIOX6bcEhGe4UYSMh4Hiq
         qRyKtLAi+lN7m4A6oVJKKm8ExITEUYR/Lm0LK/Qjnh3aFmzHsqsNjTPbDKKjhIyvPKS2
         /h1fMGbFOgyd+dCdoHKKSyxGLafkzv1E7rYXzGxYy0nMVecmKYeawHBdr2wo7w+94jBw
         J8cg==
X-Gm-Message-State: AOJu0Yxc4+ti4pCgFdJAYmKAAtG5KVaFEkRYgz/0CGJ7OPxqwsmw/FsH
	79FEe4frPvDrTaCDbYOYY5ZooA7BFKsG+VBnR3OXE9Kkf1BLDQ8ORYSo/uWsrEUHKcKdH+vq+PG
	Fj0kA
X-Gm-Gg: ASbGnctHLVsYQSVQDGp44k5YIhPH6ztD9Oq3eavDJzE0J+6mdR/BMPGKk3UEpbaaCiB
	RIshEasJpOMqd6NEKqVPsitkwhqr9V785CYBoLVOURgVHNAI2H1pSWVbuqFjES9u9Ic0ySS2TWo
	/1I/Gs6v6hrBdMaC2zKeg/3x/UGKs3sF2nJWXoEFbbt8kgjMJl2MNexZ8Ss6YS+bBF1QBxDpB1S
	XCy/v/925WVgttysFji8eZrYnzco9zWtk7yUaYSrnAPO1yHizXbsVZVn8fkmXlvU4JxeuvVEyD4
	Nzdt/YjgFCqsviW+qRMnKnnXtVmBCPWcfkkwlnptKCc2wcGzIkoTolLWLrYbJ11pw/7B40L/Fs7
	JoTpiXaILLM8ouPBjVmXdQmVoSd4L/NoY50JpPRyiPjWWD8KPZ0O3D/uKjRtXHQBGpN4NW5axPC
	jkZanikaeOhXAXFgcgYYngQ8HmqAjJK0Ia2XTWZC4YunqNvsIRShbOUwm5Ho4LlZT3TDETF6s9s
	g==
X-Google-Smtp-Source: AGHT+IFO2gQiW7ubfRaQSC6NcqraWXyOa25LTSIg5odKjIR7gMu0tByoZaIbpjIFF12RRxedAq3ZPA==
X-Received: by 2002:a05:6214:2303:b0:87c:2c7e:37cf with SMTP id 6a1803df08f44-882386ec1a0mr50650616d6.58.1762632967242;
        Sat, 08 Nov 2025 12:16:07 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm20001896d6.53.2025.11.08.12.16.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:16:06 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 06/11] cargo-c: fix debug symbols containing TMPDIR references
Date: Sat,  8 Nov 2025 15:15:48 -0500
Message-ID: <52e78812c83904cdff682aa39f2261161fafaf08.1762632742.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762632742.git.scott.murray@konsulko.com>
References: <cover.1762632742.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:16:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2440

From: Yash Shinde <Yash.Shinde@windriver.com>

When building cargo-c with DEBUG mode, QA checks fail due to
absolute paths from the build environment (TMPDIR) being embedded into
the debug symbols/binaries. This causes issues such as:

  ERROR: do_package_qa: File /usr/bin/.debug/cargo-capi contains reference to TMPDIR [buildpaths]
  ERROR: do_package_qa: File /usr/bin/.debug/cargo-cinstall contains reference to TMPDIR [buildpaths]
  ERROR: do_package_qa: File /usr/bin/.debug/cargo-cbuild contains reference to TMPDIR [buildpaths]
  ERROR: do_package_qa: File /usr/bin/.debug/cargo-ctest contains reference to TMPDIR [buildpaths]

To fix this, pass an additional -ffile-prefix-map option to DEBUG_PREFIX_MAP to
ensure that paths under `${CARGO_HOME}` are remapped to `${TARGET_DBGSRC_DIR}`.
This ensures debug info is reproducible and does not leak host-specific paths.

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 3239961e35434592c06ec2cae2885ab464d35744)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/cargo-c_0.10.16+cargo-0.91.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/cargo-c_0.10.16+cargo-0.91.0.bb b/recipes-devtools/rust/cargo-c_0.10.16+cargo-0.91.0.bb
index 9cad277..d61a382 100644
--- a/recipes-devtools/rust/cargo-c_0.10.16+cargo-0.91.0.bb
+++ b/recipes-devtools/rust/cargo-c_0.10.16+cargo-0.91.0.bb
@@ -11,6 +11,8 @@ SRC_URI = "crate://crates.io/cargo-c/${PV} \
 "
 SRC_URI[cargo-c.sha256sum] = "17d431789b050b0fcf678455dfd5ceb7e5b45cd806140f8fe03b16b995d6cbff"
 
+DEBUG_PREFIX_MAP += "-ffile-prefix-map=${CARGO_HOME}=${TARGET_DBGSRC_DIR}"
+
 inherit cargo cargo-update-recipe-crates pkgconfig
 
 DEPENDS = "openssl curl"
-- 
2.51.0


