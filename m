Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D8C369AB
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:04 +0000 (UTC)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
 by mx.groups.io with SMTP id smtpd.web11.59610.1744061457654740034
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=j35CIOvg;
 spf=pass (domain: konsulko.com, ip: 209.85.166.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso24787955ab.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061456; x=1744666256; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3etoFcX11M0iqLknPPES97780jw7YwzDFy0Y5hPH4B4=;
        b=j35CIOvg2NzVifJVIiTtg8mJ/iH0rthnnclwxvFVaUcZKWBMO95b0ilBjpSOiTOrnw
         ss6dR2DfmhIBuDRHJVGkwya+dqQxcsvHsrE95RDFNHC+gUGeJqEKfVeKuZmbLqHEaCG2
         l/zzBSjDMkUwTXLuTmiLN19EZ0z7OyOfvIbQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061456; x=1744666256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3etoFcX11M0iqLknPPES97780jw7YwzDFy0Y5hPH4B4=;
        b=Y3cvc7Q8R7ubHBaoI5Y7Krfqko7bgGFmkziDKPXO+SCF8pZ6zwjzM+sjGRiMN/EBrs
         IDe/NqzcF8OJrWAL5UUmsUN9kk/z1E8GBCZcEED7RMAVLznpRx5DGOuBnPQPByQZ3Lro
         qkBVYTZeNRq/12aCFX8fXvJx/t6mn4VWZwYqpH3QQ9uOKTrqnHBSkT9sdG7joQfti6+z
         1uvoqQTtTmyosiqk4r5Wz9LYM20xlP/49WO/LtHP1RO3f3FcGQdLQOualFJLFupdBYS9
         yqra8eUFs3MASNS9odt0iYhRUqUH6JMcRdRsUQeezcsTCGfnMU2AFhVRnpU74fFRN6nv
         NDeA==
X-Gm-Message-State: AOJu0Yx3ASPYNzsHjmJwQhuxdu88KfA7wWaQrKpKANAFUJvjTVmzkp6T
	Y84vwg0YIsuEHAOtcKCWrslDWpCUKrNUOQz+e1x8Wx4i6gGul/xdG+N+m3RVh7qkopW9LHBc0Dt
	fDP4=
X-Gm-Gg: ASbGnculp/7DPx0vHrJpD5D7M3IYOhML3QuIKl1vGu2UKouFYqBjSc38N3JdjoK/cVX
	6nXppgoMptomsjQoIBYciVda1SYquSHM9OAOdToElF8NT4P2tS7GKzt20j/4Xdi/BnUIJ/RedCv
	vF8uUnyg1lIA9o5Aey8cl280IPfX+luzT+Sio2zJfkcM0LeBdnRBnn6PnWkmpVbhnRp2a/rB/Pi
	GPszdIvPKmHSmPCDhLUTQ0bTG1JgECdtLFHR4r9Tzmfs3KOjf4j19ajdESSb6LA2NG95lD92rPT
	7QrHKmgvSoT6p+tq/H1/p4pv42MPeFIeIpJJTojg4HuMKgSHsN7QiYoKpARh6FeFf2koxYrJRYM
	QDqqP3QKocTD2MMMfx6aC
X-Google-Smtp-Source: AGHT+IG96aXhozY1hDevmCaOjJ/uWbMnvMon9RdzmkPqDTZPyHB9hCkOmN4JFxhIB7O2ZX98h65jLA==
X-Received: by 2002:a05:6e02:3e91:b0:3d3:fcff:edae with SMTP id e9e14a558f8ab-3d6e3eea6ddmr163081645ab.3.1744061456613;
        Mon, 07 Apr 2025 14:30:56 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:55 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 18/29] cargo.bbclass: show PACKAGECONFIG_CONFARGS in bbnote
Date: Mon,  7 Apr 2025 17:30:07 -0400
Message-ID: <0ba2fc4d879b179d73a81f899bce2c639eea5787.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1318

From: Martin Jansa <martin.jansa@gmail.com>

* PACKAGECONFIG_CONFARGS was added in:
  https://git.openembedded.org/openembedded-core/commit/?id=16745b20452de60ae2474433cc1a2fb1ed9f6a64
  but it wasn't added in bbnote above which might lead to confusing errors like I got now:

  NOTE: cargo build -v --frozen --target aarch64-webos-linux-gnu --release --manifest-path=.../git//Cargo.toml
  error: unexpected argument '--cfg' found

  Usage: cargo build --verbose... --frozen --target [<TRIPLE>] --release --manifest-path <PATH>

  and was wondering where --cfg came from.

* it was from recipe where we already use:
  RUSTFLAGS:append = " ${PACKAGECONFIG_CONFARGS}"
  it will be difficult to use PACKAGECONFIG for RUSTFLAGS and prevent
  them to be used here for cargo as well, what about the recipes which
  need them to explicitly append them to CARGO_BUILD_FLAGS ?

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 38d953b2ffd4e0cee9e77f97988e44be105023c6)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/cargo.bbclass b/classes-recipe/cargo.bbclass
index 461d100..2dd28e9 100644
--- a/classes-recipe/cargo.bbclass
+++ b/classes-recipe/cargo.bbclass
@@ -47,7 +47,7 @@ oe_cargo_build () {
 	export RUSTFLAGS="${RUSTFLAGS}"
 	bbnote "Using rust targets from ${RUST_TARGET_PATH}"
 	bbnote "cargo = $(which ${CARGO})"
-	bbnote "${CARGO} build ${CARGO_BUILD_FLAGS} $@"
+	bbnote "${CARGO} build ${CARGO_BUILD_FLAGS} ${PACKAGECONFIG_CONFARGS} $@"
 	"${CARGO}" build ${CARGO_BUILD_FLAGS} ${PACKAGECONFIG_CONFARGS} "$@"
 }
 
-- 
2.49.0


