Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD35C88E5E
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:04 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48524.1789157636541962099
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hLfBuXKY;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5306c3ed04eso16927791cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157635; x=1789762435; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1GFlI69hSTwrqgjvX01u5jdtGXBfcDeL6Ju5g4iZ3ZU=;
        b=hLfBuXKYc3ns6s55XzPsc5bOI9lvRqB4gTb88gHxYLeWkfyLq8VPK6HLPHVJamDAfx
         hkzoI0Q+YHaxPhTIu6RqDpnqx+2nXKDjHtEw1P+au0A9v1GfDYAEq3p2j/v4Fpd39kVp
         E7y0qjBl+pTtj+Z2AUk1vBFGkFkXRCjmxOcxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157635; x=1789762435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1GFlI69hSTwrqgjvX01u5jdtGXBfcDeL6Ju5g4iZ3ZU=;
        b=WRWr/BwtyU/PTgsK1Yw2WNHw5bWgnBhutrlJlBG2oilEZIfZiaGVt0yGoaoBA1FQK+
         do9nz0tPS7NrdViZ89j7SosGGRDcoQNW7ro1MxoPdPW+zw86R1g0lKnCmDdEr8TxiiEo
         S7p0e258R1Iw8eW8f//rJgmnwcdTXKzk1MeL5PxShUEI8MCRupeTPiMqVJQH7ydozgpL
         xDJdKmSTstOJpyEYRDik7YOawqUuRezrvAwGFRfIkOVg47+tq5TOWwjHxvUrC8k09RHa
         eMHEn8uvurMj1CoIT/t8irtmltNwlOs4kJiiBXgUEgOAvIIUu0Ggy43D1u1fGn6tzPZj
         u+0g==
X-Gm-Message-State: AFuF++mXKvdnMZDWPSaXNlFAbNLIAuV9UUb432GQova0GxLsO1Q7QRwM
	Pn0Zig2+1epacGF2WyWNkLRJiwCkxwSRI9MWjSpIh5ryYqVu9i12LsaZ+JOdc/aTn9GeI8JejU/
	FFyzE
X-Gm-Gg: AYBFou0vg0BOrbUK8DBKubUi951FuPMI0BOjsGb1pRokSAp2ptKRoHl8l6Va0Vk9sFF
	fJA/Qgxjx55M8Zk9od1YTVAO+Rf39LPbbgK2YsEa5ZRE1mglJQKfvUQRv4q001CfZPOBho4h3el
	22KT4cpvBexuszbPSsQQRKLiLOXGG8w57vrAFkrVuFe7Ex8DlVBafL1W2ZS8hbd/2IQFf6fMvNK
	t2Jr6mESO8y1G+f0JJy5cMhpJeYcWAhk8LfcFGma6nSlZMmhWsW622qx5I8NHPUb53OjE9Plno/
	cLkQPAsckqSpIQvfKOKgI1fn22oJ0Pcucn+3jqQbwOMMFxWSKaZO9KpZzmF0JfUXSbc9i2zP1qw
	lo7CuMujySjHcIpt2eEDfODbhvuLhmiDZffLc8yaAnSgjEVMWhATaysHq2mwWLE0nitL0HqkWhc
	EQGJ/f1+wuoLBN8CKjN17icYtg2xJINqPmh19csdM/DntUxwMFRReyp9WUiSIf/KFO/7XvUQhf9
	RnOq7QyBa6Ceris1N6GpjPxRk0xrV/4RjzD/3uqsc6zHEJNaGPxh135OG+jdmYq0YY34SLutdSi
	3K3LqIuxaZE/h46v5tZEKnrhwJ6qFC36bKE=
X-Received: by 2002:a05:622a:1818:b0:530:31a:a222 with SMTP id d75a77b69052e-530c86893afmr88486691cf.29.1789157635313;
        Fri, 11 Sep 2026 13:13:55 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:54 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 17/37] classes/cargo_common: move PKG_CONFIG_ALLOW_CROSS export to oe_cargo_fix_env
Date: Fri, 11 Sep 2026 16:13:03 -0400
Message-ID: <1a7e9ae54beceba8ac185359b39f311f4799c822.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4783

From: Ross Burton <ross.burton@arm.com>

This export is used to tell the pkg-config-rs crate how to behave, so is
only needed at build time.  Move the export to oe_cargo_fix_env() along
with the other variables so that the exports are localised and not
global.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b20adb82ec4e367bc775f9621a5ce96f761831d6)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo_common.bbclass | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/classes-recipe/cargo_common.bbclass b/classes-recipe/cargo_common.bbclass
index 7ff2351..998c6cb 100644
--- a/classes-recipe/cargo_common.bbclass
+++ b/classes-recipe/cargo_common.bbclass
@@ -20,11 +20,6 @@ inherit rust-common
 # Where we download our registry and dependencies to
 export CARGO_HOME = "${WORKDIR}/cargo_home"
 
-# The pkg-config-rs library used by cargo build scripts disables itself when
-# cross compiling unless this is defined. We set up pkg-config appropriately
-# for cross compilation, so tell it we know better than it.
-export PKG_CONFIG_ALLOW_CROSS = "1"
-
 # Don't instruct cargo to use crates downloaded by bitbake. Some rust packages,
 # for example the rust compiler itself, come with their own vendored sources.
 # Specifying two [source.crates-io] will not work.
@@ -241,11 +236,15 @@ oe_cargo_fix_env () {
 	# openssl-sys
 	export OPENSSL_NO_VENDOR="1"
 
-	# pkg-config-rs. Crates can still override the dynamic linking
-	# but try to dynamically link to system libraries.
+	# pkg-config-rs.
 	# https://docs.rs/pkg-config/latest/pkg_config/
-	export SYSTEM_DEPS_BUILD_INTERNAL="never"
+	# In cross pkg-config-rs disables itself unless this is defined to tell it
+	# we have set up sysroots appropriately.
+	export PKG_CONFIG_ALLOW_CROSS="1"
+	# Crates can still override the dynamic linking but try to dynamically link
+	# to system libraries.
 	export PKG_CONFIG_ALL_DYNAMIC="1"
+	export SYSTEM_DEPS_BUILD_INTERNAL="never"
 
 	# zstd-sys
 	export ZSTD_SYS_USE_PKG_CONFIG="1"
-- 
2.55.0


