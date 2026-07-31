Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36171C5516D
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:45 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4600.1785497620402088822
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fLMLOEoY;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92f03daaa97so48732285a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497619; x=1786102419; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pxsotr1kjxHG9WHPneDDdRhKz5OmROvNhDIUiR84sk4=;
        b=fLMLOEoYgvRTWIeXD7Mvmc+RD2nWVHN3gCaDI/HMCmbzAcx3zTwZ0iEaUp1oebYsdr
         36uXTe039A4OeGIaXR7v1aYjDOnnVQAsTiC1LzawTJrZZT08nvJDZDW5srRICbVYfNn7
         +nmF1+SX4vB03c6Lnod8l6XBcWrnwZNIeDbjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497619; x=1786102419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pxsotr1kjxHG9WHPneDDdRhKz5OmROvNhDIUiR84sk4=;
        b=ZvWhflRFI08RXw6TO1aPZM30u2bezvD8DKzonplH+3Y7ACQC8VEcXafi9ZY/r1xmM4
         qo94vzxD5Y0oj/kCz5lLCY+a9e6+wFbP8N9d/3sxBl23O3Bv4nuxNE+zim8WgfRQkYIc
         UViJJZVK/UxL7+aFbnxANPpWiOFhG+bp/B5rEUeHnIPb0Euc2YkY/gxu4XeXIBKTTXrY
         72Ha7BB568DzviwrXVlyLV6ouJIUK4MrANfAHN7ypAh2+OKvxQR8YUWD9MPOppihHvT9
         OHBJn8dVMqHUkQujB+Tb7BHdqMz3XNFdVxDIneN4Ypa8oWRUDg9Sd7vL9A7YF+ua4+Gx
         rK1g==
X-Gm-Message-State: AOJu0Yy9moaX3x/fSZfL2oL+8WidMp1yjOTm7O+Ku8w/dDwN6fC5OkOF
	9c4qJXRDTa/RdolgLTHkeW1JFNb06/bVkAQTmPUOFsQeOfLa14XW14Q/r6LUYAr7q6CIXt/wnp3
	5ZaE3
X-Gm-Gg: AR+sD12sZ32jXBBT77JphepueJQ2bB9pT4IzZvnyXZBjM27lctmY3NkxtUwvNJtMu9x
	EhdUTQ/0O7O2Sr2zxoYLt2JroPrGBzQcUdDETwjNnOLETOfCe4wDx21ALfSqJVORbaivt+bXBj8
	RE6t+luMN2M+cjxNwzatm9u2wp0ntA2MbhV7ZU8EwQnZorCwdLI2ZwX+bbm9V+Phv89JY9GhbeL
	ZmDbWnYDKEG17bR+Zf31ltVi9YzbArvTYio9g8H458mbilHE4OHXN4ZEuUA6Vu1ZFoNOlQF0s43
	OwGP2UfUBhBuw3a6EQg+YKLWkmRIuSlIS5mO6PeX7mstC3plFGP1fuUk6OBFip8JZm0TSgrkEzF
	ADeNenUmNVndvRqDKE7ddoamav5OW8/HjlAioKqThkyeMs4qEDPwRH6C1sdI6zeNaBv/6cxv0ul
	kQNxspM0POW1xMj7+NBVaugjWAgNkJsEsVwBFnkX4qMaYfWGhP9E96IJ71gq/ImcvYlRBQCLFdL
	xer6+c5ZXnlsUsafD2J9oAZ6q4oO/NewI3w0WtK6DbEveRoFwNeVFpDECyURoUAk2WEkzlaWLjV
	MeKv1Zvsncpl24OZ5LEqLbNLOg==
X-Received: by 2002:ae9:ec12:0:b0:934:9a66:67ca with SMTP id af79cd13be357-9349a66929amr136281785a.23.1785497619191;
        Fri, 31 Jul 2026 04:33:39 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:38 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 27/35] rust: export CARGO_BUILD_TARGET
Date: Fri, 31 Jul 2026 07:32:57 -0400
Message-ID: <17484a886539be488f687c7e6f819e45b8f61987.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4603

From: Jesse Van Gavere <jesse.vangavere@teledyne.com>

To cross compile a rust project with the SDK one currently has to know
the associated target sys and run cargo build with it, by setting
CARGO_BUILD_TARGET to the rust target sys, running cargo build after
sourcing the SDK will immediately have the correct target.
See https://doc.rust-lang.org/cargo/reference/config.html#buildtarget

Signed-off-by: Adam Duskett <adam.duskett@amarulasolutions.com>
Signed-off-by: Jesse Van Gavere <jesse.vangavere@teledyne.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit dc1a3a439c57c59578abbc474d10779de4d42c5a)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-cross-canadian.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-devtools/rust/rust-cross-canadian.inc b/recipes-devtools/rust/rust-cross-canadian.inc
index 4478a7e..5a152bd 100644
--- a/recipes-devtools/rust/rust-cross-canadian.inc
+++ b/recipes-devtools/rust/rust-cross-canadian.inc
@@ -59,6 +59,7 @@ do_install () {
 
     cat <<- EOF > "${RUST_ENV_SETUP_SH}"
 	export CARGO_TARGET_${RUST_TARGET_TRIPLE}_RUSTFLAGS="--sysroot=\$OECORE_TARGET_SYSROOT/usr -C link-arg=--sysroot=\$OECORE_TARGET_SYSROOT"
+	export CARGO_BUILD_TARGET="${RUST_TARGET_SYS}"
 	export RUST_TARGET_PATH="\$OECORE_NATIVE_SYSROOT/usr/lib/${TARGET_SYS}/rustlib"
 	EOF
 
-- 
2.55.0


