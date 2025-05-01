Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6705DC369DC
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:12 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.4602.1746132062932051635
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:41:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TGBQkFrX;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so20780606d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132062; x=1746736862; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4/8K/8u43+AS5THUnbTJbzZ1b68JJNBopEoyi0NNRs=;
        b=TGBQkFrXiHcmGlTQ6ZyczoTiDI3yv3z4JE00TEm9Q6AHpNrniiskHsNJTC9hOW1uZP
         5Ku6Ki3pW2slb5bh4eoX28UB1cbh0rTv7RMuHOlJeePBj4d/LoRBUgHi98xpoKOjliXV
         XMC0urAF2wqTOcUY90JjmJ5ySzTF+jiGib3aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132062; x=1746736862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4/8K/8u43+AS5THUnbTJbzZ1b68JJNBopEoyi0NNRs=;
        b=iqFiH5g7RkR+evyfT1nF5/OB4JIeyNWUJjIkS05bSs4YeaiPpErwCwMoPAKYQOJ06H
         8LO5br4VHzIlVMa99yNkGgymBWbD3LI5iFhOYZtAgCAZaou3ZyRd3dNYbbHZzzxlkQ2k
         dPRtSRcRnLFkXyDiTI+87rU89R0oaG5alM4jnG5/Y71L39xXM7/KwqWWdp4G/+mn/Ttm
         NDxr3MUPLS+dhHVXSyJjQtdNhHlWaSZds1U0Ber0nH7GqAO8N3zTjI930gTZLkXv+KCF
         ROU/KKZmV56A437ydDoduw68sfMGgz/vku0oBqLVijoTcEHhFnpnTW2GfAwesAstWNyW
         4Uaw==
X-Gm-Message-State: AOJu0YwSoeh8yuEmbXp8od28Ze5TtNYqF+ZKiYeN/lrkBT27gpiojffp
	C6ai7ckXhnetm1TvLKVZRTLHhB4H3ROnde/OWIbx2qrJWyxoTmX761FLnp9CMYeYqRzMsFlN2Jk
	I
X-Gm-Gg: ASbGnctDWkjFNogK8gnfO0TQ3cKdWpjTe56MJ8RiiWTv3vCElNBfgFHfKYtwM0dyqWT
	QP3uNhevW8BlanNVFj6t0glTXZDgvZhBDWezBRYUQhXDa12s/DPWnIsO3JEjrI1FvrmDeUeKpEq
	MobG+H60Vk8fuy96xQOSmBN7cVeypYmw6bZT+g79l5K+pUTJHZjzxLtvEt4oZe638UJRe2h85g+
	YQxThbYDpW6yVtM1o0T7R0myZJdXUGtjrnHWlB0e7RZLwOfR23gnOV0QKHtRCaByMSX96uqI3jJ
	boVVNdw8LahaYnplzDKbHMVZvOCkx4EltwZ3fCuZa61s+dy6ILV542yPQmxKyxhoSAt4+hZId0t
	A8x49fMI25HVO4oXKXU3CM0lp5Rc=
X-Google-Smtp-Source: AGHT+IFr6DK+BJdX7ikR9NPytlyEFI0RQ6dGdsNOx9VvUHzbxqFchLHRbrTRNEUm+I9MMhg+YLNCsg==
X-Received: by 2002:a05:6214:c2e:b0:6e8:fbd9:169a with SMTP id 6a1803df08f44-6f515277ff0mr9961386d6.11.1746132061622;
        Thu, 01 May 2025 13:41:01 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.41.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:41:00 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 27/38] rust-llvm: Compile llvm to use dynamic libraries
Date: Thu,  1 May 2025 16:40:03 -0400
Message-ID: <fec703942a923cc98e8fa5e6c6201479ecd0eb34.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1454

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Our main llvm recipe uses dynamic linking already but rust-llvm does not.
Enabling this significanly reduces the size of llvm-rust to about a third
of what it was, which is a bettter configuration for us leading to smaller
TMPDIR and sstate objects.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 2b6a6d4199e4eed65f20351d077a04a7cf9da460)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-llvm_1.84.1.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/rust-llvm_1.84.1.bb b/recipes-devtools/rust/rust-llvm_1.84.1.bb
index 6a4d295..566348c 100644
--- a/recipes-devtools/rust/rust-llvm_1.84.1.bb
+++ b/recipes-devtools/rust/rust-llvm_1.84.1.bb
@@ -44,6 +44,8 @@ EXTRA_OECMAKE = " \
     -DLLVM_ENABLE_FFI=OFF \
     -DLLVM_INSTALL_UTILS=ON \
     -DLLVM_BUILD_EXAMPLES=OFF \
+    -DLLVM_BUILD_LLVM_DYLIB=ON \
+    -DLLVM_LINK_LLVM_DYLIB=ON \
     -DLLVM_INCLUDE_EXAMPLES=OFF \
     -DLLVM_BUILD_TESTS=OFF \
     -DLLVM_INCLUDE_TESTS=OFF \
-- 
2.49.0


