Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBF4C71123
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:05 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
 by mx.groups.io with SMTP id smtpd.web11.5847.1724875799486512789
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:09:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XkUOpvFF;
 spf=pass (domain: konsulko.com, ip: 209.85.166.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81f96ea9ff7so355575039f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875798; x=1725480598; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1yJat48gIUeLOnMNa+eH8SNii9/c7Os6VT7O6Jfp80=;
        b=XkUOpvFFBATrlynX1Osh09fwzGaYONw/i+nhZ95pYPBJ9c7FAqOoTdl19T3UMI2wwh
         RnBpl2ZMWt7sJAn44HtuR+UNTmH9M97bzpgze7B62nMUBZ3ogsw4wcTu9h940ZjyF4vz
         d9eUDSc6KEUulUORceB4JsT891T8U2xB8ewZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875798; x=1725480598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1yJat48gIUeLOnMNa+eH8SNii9/c7Os6VT7O6Jfp80=;
        b=RaTtIZutyb74ZW6lHFu+Q9JNG0k+LrVYScmKZpIIo7p27y/guygh58CfXgRXxmehpt
         b4kiQzqcUwRwV+vkpRopHfb7fYa0YmEmyVVzr6sRnf3/vkuPaO3h+0dvrK+Jx6Bp9eiA
         bk3Hb/Ho0rjTvIwIsLshHSLcb1U7UfljkJR4JyfcTWOKe0akidjV9KbtpNL2H5Mz/vzo
         m6Xa0QOTfkcEdjfKMyVPib/Tf54WGGQ3NQERywq8p1E2lljVpKh6tnKWuQWuAxMrXApa
         yJUm26Kc5+NAQImBDE5Jy1TxJ+fC6QL4Nt970oTW2Mg3KP59mm/9sR1XT1MLFyoTqbp2
         4qGw==
X-Gm-Message-State: AOJu0YzNDcwlBQYLFFVbmBIi5JVdy6P97d/DcsPF/WMT6VqrEdU2oVx0
	B1fbql98rLkXMZtlrz4wsglRCzPOaEV+g3+2e74/7XeiDPSCGHFggKQQLuapAZNe51IfcqFpvuW
	F
X-Google-Smtp-Source: AGHT+IHLwYml7RazQ2IlmsLpxepfoB0CsWQxlP3eetiYum8N52oi9erh1Kx8QcdBEgSRTzIPjY+8Hw==
X-Received: by 2002:a05:6602:1644:b0:7fb:87d6:64b with SMTP id ca18e2360f4ac-82a110a3492mr77584139f.17.1724875798314;
        Wed, 28 Aug 2024 13:09:58 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:57 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 12/33] rust: build the default set of tools
Date: Wed, 28 Aug 2024 16:08:58 -0400
Message-ID: <90787f4e0c26a48395e4356d320d05d5d222518c.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/579

From: Alexander Kanavin <alex@linutronix.de>

Setting it explicitly replaces rust's default choice which is rustdoc
(needed for example in selftests and otherwise expected to be present
in typical rust installations):

https://github.com/rust-lang/rust/blob/master/config.example.toml#L320

This addresses some of the rust selftest failures but not all. Help
is appreciate to restore the selftest.

Unfortunately, this also breaks rust reproducibility (or rather exposes
that it was never properly fixed, as explained here:
https://lists.openembedded.org/g/openembedded-core/message/199288
)

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 58eaf2ee6c0809bf0a0d3c1d177e62bda7241651)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.75.0.bb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-devtools/rust/rust_1.75.0.bb b/recipes-devtools/rust/rust_1.75.0.bb
index e82a739..b041a5f 100644
--- a/recipes-devtools/rust/rust_1.75.0.bb
+++ b/recipes-devtools/rust/rust_1.75.0.bb
@@ -149,7 +149,6 @@ python do_configure() {
     config.add_section("build")
     config.set("build", "submodules", e(False))
     config.set("build", "docs", e(False))
-    config.set("build", "tools", ["rust-demangler",])
 
     rustc = d.getVar('RUSTC_BOOTSTRAP')
     config.set("build", "rustc", e(rustc))
-- 
2.46.0


