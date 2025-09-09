Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F292ACAC583
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:44:29 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web11.2992.1757443464972055238
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:44:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gd8iC2mg;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-80c45a0b023so566532985a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443464; x=1758048264; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkW6Ub/+E2ocEDYma8s5N5zcHCCbs/+7PyKwaj1QMNk=;
        b=gd8iC2mgrGPIH8BuXrkSKnWWHM8GBgm8PPNH5W0YcZmarMT+UZFwH2Dp2Y+m0aOIYE
         dTe6TSub3GFoR1nVMnj22VQMH6shk3oDrpWfARpd5z9fniTeC3LDSfYB0tiBa2UO6L9F
         Cv90coD1sW8YoIaNUJhNPsQVJYUaXRd62iLHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443464; x=1758048264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkW6Ub/+E2ocEDYma8s5N5zcHCCbs/+7PyKwaj1QMNk=;
        b=jq1s394q6b1xDI1lRUGank2LXpV0s21adH++idpvogHp/y+SDqHB0CpzbSam1o/css
         buM1XNVsKNU2+9VFWxXG2cUvfTc23pwcuQKsm4Cv2zru67s5x+vM5y2HEf8OIwWbA+YL
         cf/V5if86TuBnUy0j2xZDCYiyQSFMXo6n3lDhgLd/wykkwQyK0iufqF7q7yntyo5XmaI
         nOTSwVbMjhDTvc5Xw3Y4ZHrTvCNCyp/gyyapeEFPiItvFPS3DrMqAGbG3RzmyoqkhAoF
         56QiuHft5sY+Ds+lWf4Ox0QDQZAncW1oR7xCnDEO3v62XinTQr6KCC0yCtmYAMDKr0Iv
         JMzw==
X-Gm-Message-State: AOJu0YyTXgMC0rHaoPtuYJ7Yn2xiKwC3OcQlSLdC6XCk0b/TeixiLN3n
	3wfJagSmEs9uJyTebzr+kWzi3UtQENXo8tdGhr3NeY8t8h+HmYPzLdmcQJvJFWPxlTZCFH3E4Iv
	UMXJQ
X-Gm-Gg: ASbGncu1Yzs5i/QOIS0aDNbdMyn+DN73p2EWhzb6/x2T1Lxo/0+mZ1yAFbyyD8eaSEi
	GdHNoBSFFmANrinfcV8dX2Fzrsk8iA/sE6gQTyT3sM5Fet9sXSTN5qgWXmsM9R4CzMQNgyRIB1x
	lRMt/CmcHmQUiX4fl9s0RrwpOLYKqEhM8mFkNFkyunX1hMQaiyCbPOhqnBtjhRlkvA/MWnxoTdP
	U6RVUY4oHFwulO+rk+ccfgCeamjITdnoFLtjDibs62fz10w8FLBBoBq9cUd9OQbdym+qXWLyIH7
	/8ibYqtjaIYRuteq7kQtAQ6n/+nQufDcAhlya2hdjHn9nxUoL/oukLIlatKzMsu1nIvk3ev+6SV
	MB1aCb6+x0AzfQCauYD/03heRt/ccCEYYnzUQHmfZV/fQb3vOXr1N6D2rO9MzpKeazbTXgO+eAg
	==
X-Google-Smtp-Source: AGHT+IG5CC1AZ9veFttG0pSvKIEL3X9k9qYp8f6ng0y+2KTVOE0NN8e8QdoJIPQ8+meVWo+GdZ/9lQ==
X-Received: by 2002:a05:620a:1aaa:b0:7e6:9c12:f0ce with SMTP id af79cd13be357-813c283b455mr1146490785a.66.1757443461818;
        Tue, 09 Sep 2025 11:44:21 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5f715c0bsm160164985a.61.2025.09.09.11.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:44:21 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Soumya Sambu <Soumya.Sambu@windriver.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 8/9]  rust-target-config.bbclass: move target generation before do_configure
Date: Tue,  9 Sep 2025 14:44:01 -0400
Message-ID: <cf323970775e2bb5f1ebcafab3915b810b6956a7.1757441699.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757441699.git.scott.murray@konsulko.com>
References: <cover.1757441699.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:44:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2166

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
 classes/rust-target-config.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index b027dd5..d45a932 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -426,7 +426,7 @@ python do_rust_gen_targets () {
     rust_gen_target(d, 'TARGET', wd, d.getVar('TARGET_ARCH'))
 }
 
-addtask rust_gen_targets after do_patch before do_compile
+addtask rust_gen_targets after do_patch before do_configure
 do_rust_gen_targets[dirs] += "${RUST_TARGETS_DIR}"
 
 # For building target C dependecies use only compiler parameters defined in OE
-- 
2.50.1


