Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AF6CA0FED
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:44:29 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web11.2990.1757443463946989553
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:44:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZN+sgo8x;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-80e2c52703bso514247385a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443463; x=1758048263; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxpcZ5xnxAFrOjcE71Kn3PJM3w+M57CO1mUrJ2CjGLE=;
        b=ZN+sgo8xO11tA2SKrFcHLAt8846SXnTPdtBYJyHCAUcTExThtNbTg657bg6spgLA94
         fXBaEXPvZLMgnYHR4oITmZ2jqGuaWNs2yAI9ysWcH/oZhaZHBP9sYZgRrSLLWqq/NtTo
         zX183x51fxxZ+YwivxwifZRgzO8K0CGjTItbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443463; x=1758048263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxpcZ5xnxAFrOjcE71Kn3PJM3w+M57CO1mUrJ2CjGLE=;
        b=QDgdQ3+3+kNZuOL+QChLgcScZtL2gLZngWpg0sMzu91qiBdHMY436thcz/+ItBxsMm
         hoIewJpmbeM733dB43tOq7WxyssEr0JMds2VM0cYs5G7p0rU3nlPJ4f1Ql2vNppyqho5
         iA5A16bt+e/6/dfMAQGX9r9SdIuwk64UrH5aiXWVKk5s/jWeTY6v/r+DFFREXIgVfjA0
         U3kCpebEw6/NS7IwGtswp3pXPjN63mKYj44BCQUc6kpYDFVxIpNsqs3CQCLQ+KyjxBzA
         IrueELnuoNaILLcWewwdomFvPoMkeOfyecJft/woSARawXc6WYNE2RHNXCmzWARNwYRB
         l7kw==
X-Gm-Message-State: AOJu0Yw9WjXiQ5cSj8As5XOkCGa7J3vhlLHIbfV0zIrU6i2Gg4LITL1O
	Vc6MYzOyAp1Vd1cCcFzYFvJgrSPyPfev8j/ZCy1QPspVKY8pOKVmGYBRDJQ/N6ruVPoJsquplds
	Lu+sh
X-Gm-Gg: ASbGnctY3wMwHNsDEUc4bujPxgHCdD7WRiDN3X8tLITCjpl19vKmHnmo6NeoqcoCvIc
	30Ao1uUo5cAcXGyUM3aModzKsP3egj5tC0w6BYTbIyxPizWNk2W+5eSV0gkxt2XUmelbVyDsEu8
	mt3WfJzRtw2YyMklcST1n4LG4+9r2qNDF58sGdhzWnXOlG4hrXYzqJfDRkLSUwiZcsLbi/+YrEX
	9IXxcahft/yZ4qWcws/qwmL8/MNG4TQlGqyg0YmlQf4ekA5NythGZBwdWdXuuCZybw0YHnYRMqz
	Vm/wIDHf+gUQojYGHL5qNVrl9/dP++sHyRI2t1z4wZ1MCdMT6sQaar99Ikapta/g5fuArWKDr63
	NtVVT5fJFwjT4uqYbKeF+eEMzKsKVrd3T3l297dZylu2PMrJzOQEAEy1rWp+UuHZ0ABuSQQdKLw
	==
X-Google-Smtp-Source: AGHT+IFDjGsAC10eOlxLNUDhBkD4TQSalcG5znTY5u+37X8+NrPJZpHqC/efkLHJwEE5078oSXtkQg==
X-Received: by 2002:a05:620a:711c:b0:80f:378c:ded7 with SMTP id af79cd13be357-813c70b42b6mr1177077985a.80.1757443462722;
        Tue, 09 Sep 2025 11:44:22 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5f715c0bsm160164985a.61.2025.09.09.11.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:44:22 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Soumya Sambu <Soumya.Sambu@windriver.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 9/9] Remove dynamic layer bbappends
Date: Tue,  9 Sep 2025 14:44:02 -0400
Message-ID: <ec37dc4b7041e0b81c7c577e541db42abbe43226.1757441699.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757441699.git.scott.murray@konsulko.com>
References: <cover.1757441699.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:44:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2165

Remove existing contributed dynamic layer bbappends since:
* mozjs-78 now does not build even with the current tweaks.
* mozjs-91 does not seem to require them in my testing.
* Wind River have indicated [1] they will not continue using the
  mixin layer, and thus there is no more maintenance of these tweaks
  expected from them.

[1] https://lists.yoctoproject.org/g/yocto-patches/message/2088

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 README.md                                          |  2 +-
 .../recipes-devtools/rust/rust_%.bbappend          |  7 -------
 .../recipes-extended/mozjs/mozjs-78_%.bbappend     | 14 --------------
 .../recipes-extended/mozjs/mozjs-91_%.bbappend     | 13 -------------
 4 files changed, 1 insertion(+), 35 deletions(-)
 delete mode 100644 dynamic-layers/meta-python/recipes-devtools/rust/rust_%.bbappend
 delete mode 100644 dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend
 delete mode 100644 dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend

diff --git a/README.md b/README.md
index f05accf..482f0cd 100644
--- a/README.md
+++ b/README.md
@@ -132,4 +132,4 @@ Layer maintainers:
 Scott Murray <scott.murray@konsulko.com>
 
 Dynamic layer support maintainers:
-Soumya Sambu <soumya.sambu@windriver.com>
+TBD
diff --git a/dynamic-layers/meta-python/recipes-devtools/rust/rust_%.bbappend b/dynamic-layers/meta-python/recipes-devtools/rust/rust_%.bbappend
deleted file mode 100644
index 9b09f9e..0000000
--- a/dynamic-layers/meta-python/recipes-devtools/rust/rust_%.bbappend
+++ /dev/null
@@ -1,7 +0,0 @@
-python do_configure:append() {
-    config.set("rust", "default-linker", e(d.expand("${RUST_BUILD_CCLD}")))
-
-    with open("config.toml", "w") as f:
-        f.write("change-id = 116881\n\n")
-        config.write(f)
-}
diff --git a/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend b/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend
deleted file mode 100644
index 8e8c24a..0000000
--- a/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend
+++ /dev/null
@@ -1,14 +0,0 @@
-EXTRA_OECONF = " \
-    --target=${RUST_TARGET_SYS} \
-    --host=${BUILD_SYS} \
-    --prefix=${prefix} \
-    --libdir=${libdir} \
-    --x-includes=${STAGING_INCDIR} \
-    --x-libraries=${STAGING_LIBDIR} \
-    --without-system-icu \
-    --disable-tests --disable-strip --disable-optimize \
-    --disable-jemalloc \
-    --with-system-icu \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', "--enable-gold", '--disable-gold', d)} \
-    ${JIT} \
-"
diff --git a/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend b/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend
deleted file mode 100644
index c0214b0..0000000
--- a/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend
+++ /dev/null
@@ -1,13 +0,0 @@
-do_configure() {
-        cd ${B}
-        python3 ${S}/configure.py \
-        --enable-project=js \
-        --target=${RUST_HOST_SYS} \
-        --host=${BUILD_SYS} \
-        --prefix=${prefix} \
-        --libdir=${libdir} \
-        --disable-jemalloc \
-        --disable-strip \
-        ${JIT} \
-        ${ICU}
-}
-- 
2.50.1


