Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC62C3ABB5
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:02 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web11.4653.1746132054764915056
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DdjnwFHM;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c559b3eb0bso96954485a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132053; x=1746736853; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enyqtqMbKlBLtsqYmhiaoZTro0Yt70ZDGFGGezjiCME=;
        b=DdjnwFHM0JCfchNi2KCGjBb+PsEHZm3/23w6E+dMsv01Wtl/RrHNjcd7dd5dCI5fWG
         WghWLlmqMQKX7WPHtRORrf1y/Ft9tKegwAKp0WiZ30jS4ICllHHL6Oq5BRzwNywSfncZ
         oGGm3edDW56bT4+AVsosPO1iNPVA7O4Vh7gKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132053; x=1746736853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enyqtqMbKlBLtsqYmhiaoZTro0Yt70ZDGFGGezjiCME=;
        b=RCuKPyfahAEDvz6w88NMF9UKz+NhBsPWtxsxzRt3FsnejQuLQ9deG30vNB5j+tzxW3
         QVevxqJ/7mlxWlCKRR7eIYd9ffzEaVl6N3lfFpMjGGfP7xuKC3zBXAmvlUletoQ8xlq9
         nCjI75/o7ucfozTG56yVha6g3//eQ7n6cvEuk7DyhaO9Bssak9AQaFe5AbSPjfFK+c6D
         dpnZAuV8o+qCfDI4ac3uZMlVGVeRCdWYNioSP0qbtW//PtHO3Z+kxp1o2YAbY//bEh1k
         nHcxKvk4WpX79eIvFuvfrHLxRAiCQTbrpkcX4mgZZ2SDLK3V4RoeqoL5xniGoV1/HfN5
         XNGA==
X-Gm-Message-State: AOJu0YwkwBZZaVvP9EGIqpkq+ZZ4curUarDtGBV+y9RoH/beJ82JoJVu
	aYvSkyLrfiuq/CprFtpdJqIhFmvmYzz5z6RkvXTirCLn4Ab9Q5yaDtEtRbv8pcLFGUSEgCvewXe
	T
X-Gm-Gg: ASbGncuNmrmy1rguGpiUWGmLUJ4sjTEd+IoTdwiRgagulz/7YHTNMixmvq4i+ZNT/2m
	UG/Dnh+J6ISYA8fstk/AwvJXIRVjnOYL4FwGKzNxXg/viKlYVeXL8ev/L0yb/zwOspg75EcVqmd
	7vKwToSGgE+T6TVPrcP/wYG6EeACIS2EiTzvdnPIsmbkVBdWem/opUdmjRZgkC9lpaRXEGottGN
	LbZ463NQx2K+GOdN/aeUHD8Y0iNQkH80zmAJltMPvaBC9A/dWxh9JI8moOsqTAztKRTbanIQumf
	1EE9Oq+slNNbfIs1x3bg7ECBTbnigLi5dckqH0ikCvvyr64qD0XsMksbwOXKZosytxPv8LQ4NR0
	ioigQp3KD932ZMzGW
X-Google-Smtp-Source: AGHT+IEV5NxXyCxVgJuMAaWNg6ODssz7Fm/HV2kLzVmlYLTw8h8zvAdJCUDx4X2774VxE0mtLeVJaQ==
X-Received: by 2002:a05:620a:319e:b0:7c5:5d6b:6848 with SMTP id af79cd13be357-7cad5b4a729mr64330185a.26.1746132053528;
        Thu, 01 May 2025 13:40:53 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:53 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 19/38] cargo: pass PACKAGECONFIG_CONFARGS to cargo build
Date: Thu,  1 May 2025 16:39:55 -0400
Message-ID: <e5d4f65414368beed7b69e2c94482075aa2a0d81.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1446

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
 classes/cargo.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/cargo.bbclass b/classes/cargo.bbclass
index 76a3966..461d100 100644
--- a/classes/cargo.bbclass
+++ b/classes/cargo.bbclass
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


