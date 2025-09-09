Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BABCA0FED
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:50:30 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web11.3159.1757443828704980060
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:50:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fR5kY5WD;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b61161c35cso34567501cf.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443827; x=1758048627; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfOz9GGchmsANetZ4RIRYAvSosFDaZYm6jK3yBWfw1w=;
        b=fR5kY5WDILw39TeabrIaqgdI1TQHGbCgrLApMUlS76cCmBMsa8qtNLLXxS/oKy3i1o
         KKUDlWe7a3vAH1FOeP9xP1dEHujvmNe94NMoAaL627YUvWo7rTMAaVbj20Rschws1TCD
         wlex53lB+OWyelSpxx/hiC72zopPUKaokZ1JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443827; x=1758048627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfOz9GGchmsANetZ4RIRYAvSosFDaZYm6jK3yBWfw1w=;
        b=kiGIfHLcBMFh+G3nfvh+LzI+A9GlYb5jhJD869OJ+c7F7gFa/ZTJCWwCkJRQcrSJSO
         5ORNDtYzWLQXPHu38dxdgix7FpE2Fa9SAPLk48rltU7Sm46u7y4PkN3cSonE6ifBoOPs
         fspDGWb8GQofExvcoatTeSzggDVrqnubGnG2FUzXaUJjpX/iJ5a7bz9VTXFduSylOBJm
         Dh1vUPFfoZJ+2ATKouMtrqowWQ9GRrPALPb/XnZtRmbTD5GjL3pGesb7avUwBMprvnI7
         drUYpsquQv+4Ir5Kq+dqecNVz1rwRWcLa2c0vGFlP5GBNFKPL5fRDN0pULvcquLscDWh
         7UKg==
X-Gm-Message-State: AOJu0YyCqUqr5Bz9T4Typ4vaSpClNwXKk+2yb9xZCm/fXBnC9zJ7bRZk
	4OLU8+0Fp1SvwH6gmQ7kusDssq4pw96641EO9UabAmd+NU1rPI+J6QtjmmSuu+Wot7mrV5KScJC
	CHVu4
X-Gm-Gg: ASbGncspIW1H6WJnO7A5RZfwqH6pc1l5imOH0UuEbruSpmn8e5MuyjGzNHz8tOumXBZ
	WCWSiEXJ7hr7MDg6Vl2EyxQirBMERE7zVIwzx9Bq32VfDaXYpx96CygYFiqT5KbXtIq8INFYyZS
	IBRwCt0Mv+kVGNbmYau/H4thcJD7j7XkNqJ/yDCIhes4YIBxh9tiBVdJf7Ci64TEZrfw8DWNzhG
	IKjI0y49ZQn9hW1ITZm4knLw9vbAR16BUlPsyN0+xMfohvZx797aeNBVfQ07ca8sWRCVavE7l7y
	8NYCB0vtLWgx9BJy2dxnTyu9UMZZGsNX5DaV3lTNaiVeOPHWSu4mzByA4MsoBVIXw6f/garMNoS
	mcOhrzV0KnlZyRYVNxD/XNxliiyN33fk/Q9UjrCOayGs0CNDWzw32bPwk6QOBu/3/WzDBdPC9AA
	==
X-Google-Smtp-Source: AGHT+IGLvbEM0ClNkTdAw4x2OgPebcfzuzTTs2VuEQalXPxBilCtPbkacfl0dbHrW0o2Kv/ld8rlgg==
X-Received: by 2002:a05:622a:181c:b0:4b0:77a3:2b12 with SMTP id d75a77b69052e-4b5f83b0e1amr118976111cf.28.1757443827316;
        Tue, 09 Sep 2025 11:50:27 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ec7d3c8sm161168685a.46.2025.09.09.11.50.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:50:26 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 9/9]  rust-target-config.bbclass: move target generation before do_configure
Date: Tue,  9 Sep 2025 14:49:57 -0400
Message-ID: <a0705b87e7c1a257dafb089063f3302ed49c87d3.1757443674.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757443674.git.scott.murray@konsulko.com>
References: <cover.1757443674.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:50:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2176

From: Gyorgy Sarvari <skandigraun@gmail.com>

The rust_get_targets task from the rust-target-config class generates some
Rust compiler configurations for different the target and host machine, which
is used by Rust during compiling a recipe. These configurations supposed to
be available by the time the Rust compiler is used for the first time.

By default, this task is executed "before do_compile" - it assumes that
this is the first task that would use this configuration.

However this is not always the case, especially with projects which are not
pure Cargo projects, rather Cargo/Rust is called by a different build system.
As an example librsvg uses meson, and during the do_configure step Meson probes
the Rust compiler, trying to gather some library info from Rust. In case the
rust_gen_targets task was executed before the do_configure task, then
everything works. However this is not always the case - sometimes the job is
executed between the configure and compile steps, in which case the configuration
fails.

To avoid such problems, generate these targets before the do_configure step.

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 1d3c02553122982daedfe32c6ce09fac9e091952)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index bbadd6c..c8acf81 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -426,7 +426,7 @@ python do_rust_gen_targets () {
     rust_gen_target(d, 'TARGET', wd, d.getVar('TARGET_ARCH'))
 }
 
-addtask rust_gen_targets after do_patch before do_compile
+addtask rust_gen_targets after do_patch before do_configure
 do_rust_gen_targets[dirs] += "${RUST_TARGETS_DIR}"
 
 # For building target C dependecies use only compiler parameters defined in OE
-- 
2.50.1


