Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5F0C369AC
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:05 +0000 (UTC)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
 by mx.groups.io with SMTP id smtpd.web11.59608.1744061456683830350
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HdI0i4Sq;
 spf=pass (domain: konsulko.com, ip: 209.85.166.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85e73562577so395013839f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061456; x=1744666256; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K94trmFpSxYwUN4bmu4i7H9AGAUpBrKxZFCFi+5Oy0Y=;
        b=HdI0i4SqaxKHo0BeJ5hke70i0BVUPT+AHjizu3ofy3UIfX+9yJ+vaTaucdljBs6M4G
         oMoYrv4/R0IyF523kH3HMm/T8jiuPk31kyJLD2WfyGX7N7Ft1mAzKmeVznvQAw6u0le6
         qzS2geehWYy49AXNavCuXOUP8iyJsMcmzZDw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061456; x=1744666256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K94trmFpSxYwUN4bmu4i7H9AGAUpBrKxZFCFi+5Oy0Y=;
        b=l959ZXe236qrlLG8dsp/zJmeG6r4Xjnjeq2yCPu2+4/TELX0rftoRfVuJAdYAgcPrO
         gnqCO4QlcvSkAt9xly1GURd0537/zKdwynejp5mWIVNzDW7WdFTWd+FbxlxtlPizYAxJ
         IICNTrdnT12S2mOz+EK3Ywy7X9O0i5xy8X81FrDsvaIwyKhHPXn/dAOQUvxTj43s4mmH
         8X94DtCJOj6ncVeMU69mtxNLGreo5HFHIZoEymkKrH/E24buEMMrS2xgiHgLnUikprCo
         rKnP/QXuQA0C1nnIvhWrI+j/o5ZvhowM77Ba7X/wUNfbNR/rrM3M6lZ93w2xLrZKBWtL
         woeQ==
X-Gm-Message-State: AOJu0YzAB6610Ah4dmwyiVBEzSoUgAQPQ8D1d0Zy6OJIdILiG7xoJBK/
	DcRAxxe4JxPXE7nJgFY0ETobIB0buJ5Rbce62ZhkoSJKQsE2vUrW1qw7vWMdpuPMaWOulh/Cbad
	LFZg=
X-Gm-Gg: ASbGncuYwIr7sMvSrFXwTrorgrHyxAbeUK+FqJ1w+0bN6z5goqb0yIEIQ5Nfv/94ufZ
	MlTZhlvBMIuxS7ytFUVZ1WoSgX4OajR7kwmjePHbrY+xpuv+CeHj2BM1FWz58CIrs/lSMHTmRbS
	qSYlZCbUg6zKEUeZYnb5Xl/kz1C/whV7BlLghS1fFFgn3UWkKYGn4IVF6OUb+8GiVUjtDPrArln
	6phlM918ene9HOP642Fj3SbAw5YphTFPOU4sOfYrv3RS4sQsJ0rXb6y8tYaIux1f69QYmHMfNkp
	Ed8k1t93aDTVnZ7QNiha1rVi3xF90nYeGN0BHjI/yEEt9IA9uTVGcWWNEtBWyuKqOUPqttKqVgk
	OWC4dXyYjXwYpUk/PWeEpxBiFOoyr6i0=
X-Google-Smtp-Source: AGHT+IH/I7v6XO8P3AE8B0/YJISDjyflzIxoS86OAWAnxKWmN1DQW8X3v+7zgtue0m9x4ekzPd0F2g==
X-Received: by 2002:a05:6602:400a:b0:85d:f316:fabc with SMTP id ca18e2360f4ac-8611b4655e2mr1584359239f.8.1744061455627;
        Mon, 07 Apr 2025 14:30:55 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:54 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 17/29] cargo: pass PACKAGECONFIG_CONFARGS to cargo build
Date: Mon,  7 Apr 2025 17:30:06 -0400
Message-ID: <879b54b969a7d81513bf0dd4609f9e9b713a55f7.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1317

From: Jean-Pierre Geslin <jarsoper@gmail.com>

In order to allow rust packages to define PACKAGECONFIG options, append
the contents of PACKAGECONFIG_CONFARGS to the build command.
This patch was already submitted by Bartosz Golaszewski on older
version but was never merged. It will be really usefull for Rust recipes.

Signed-off-by: Jean-Pierre Geslin <jarsoper@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 16745b20452de60ae2474433cc1a2fb1ed9f6a64)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/cargo.bbclass b/classes-recipe/cargo.bbclass
index 76a3966..461d100 100644
--- a/classes-recipe/cargo.bbclass
+++ b/classes-recipe/cargo.bbclass
@@ -48,7 +48,7 @@ oe_cargo_build () {
 	bbnote "Using rust targets from ${RUST_TARGET_PATH}"
 	bbnote "cargo = $(which ${CARGO})"
 	bbnote "${CARGO} build ${CARGO_BUILD_FLAGS} $@"
-	"${CARGO}" build ${CARGO_BUILD_FLAGS} "$@"
+	"${CARGO}" build ${CARGO_BUILD_FLAGS} ${PACKAGECONFIG_CONFARGS} "$@"
 }
 
 do_compile[progress] = "outof:\s+(\d+)/(\d+)"
-- 
2.49.0


