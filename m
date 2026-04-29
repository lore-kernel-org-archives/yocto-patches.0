Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEB8CD13D3
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 15:40:21 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14500.1777477215842022524
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 08:40:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nW1W3JkE;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8eab809593cso1122695385a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777477215; x=1778082015; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ur2L057CLZLmKvyLrCI7h7LYWz1220hgJLt1KPobrfA=;
        b=nW1W3JkEKdbHzbIOkzs4SeEtzGRMW53CRUcR/6Sy8037MW0LCn6tr3OxX14AT+Em/w
         OAtxCCoD7Za3aHfd6BAcXt+fQIUm7v5FjvKWNvmgOUIdhT31W6Dhho89ErVwSryUtOJZ
         VQqjs4Emrf1OlZt6FnKJa1QpeR27xMZBaVScM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477215; x=1778082015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ur2L057CLZLmKvyLrCI7h7LYWz1220hgJLt1KPobrfA=;
        b=WfWqWZew+kPgjWoexpuu+SxzVAVoB+OwqHqLaQmbh/+rJMUyTRg1v4Gb9mehJUFDLP
         9gYxVZelyXtfYBVa9Z5FfyKuTZ8AlSbGqWRE/8JwAwHnPhWcWRepXdarhToloDk4DTCH
         FV2JNJF3b8N7+Q0tnEr7pXn2ynIcULxVQLcrWMd3rzKH81n0kUoON1ep+b6d8hIqQKW5
         slYwtvWu6w7w5nMEqTE/oek5MJq7CFf8t/Z1VozzxRE+KgUH4Q31e++49h1IYqYvTjim
         BmdLhEPOJo1hjDatVZDDwSb66GitHNyc3x8uxuU9t60Jk8GAxDm8SUyucHCe+tm2/CLZ
         QlgQ==
X-Gm-Message-State: AOJu0Yx1RCjT2lB15qFJPVd3r6lvFjTQZ7cSra61USxNmD1S7jj8bFc+
	0pJeOY/saxYg+PRYy5F1kbzARu/COruB4N7nB7Lcp93P6HXuMoHdiC4q/GSMarcXIWixeyKqcM2
	9t1vU
X-Gm-Gg: AeBDieuK5PKFZcwHHqVyDWW0dnXBjKdRWoiIRBmrU1cYpan8LN2iSp3UpgnNdTS+rNz
	dKOUr7jXehVh8BCi50hSbigZgpdYn0swOSYzia9HGN8JN5l1H9d6lUqeq/bI2YZKfXQVnQRe9EV
	SiC3rLLmaEvF8/b/unBcdg/PqVUnV94UvoQ2J+r5mbTUMskCqPwGSFgZi5Urnsv0w4WiYeCdhHC
	s4CqwccxbCkdKgWsRQirUm9TsJv4cdoCQtJ25BAum7OYxOPJZwhvZ8Q7JvQVKpDJxOoFcHblFMQ
	BAgETDmcZh/202kMMdqLrowmxKF+u74HSQm+KahGWm72uwpXbeh4pqFKedrTXGSlqQEEaTduN8l
	XBrv5SV/jxbW8vEGy8R3ls5sIYmNFVgdKaarmkA+yQGyRhzdb0+0TfmnhrZkGdr2n7X2hQ65Pkz
	SNzbq8jPnjEcumJbCaaXHoeZsKhRnNUiG6sCdDiabKZIF08G+WNmoApDdzxQ2h1Ae/VxL8tQVK/
	ylEmivt6pVg6/NY9smQ5wWb0o0w5ChDbpc1SW/k4aSIBDtbEWUSPXhne/OoQ+59NIRuaz5vHbI=
X-Received: by 2002:a05:620a:404b:b0:8c3:7f27:a65d with SMTP id af79cd13be357-8f7d92080b2mr1127030585a.28.1777477214595;
        Wed, 29 Apr 2026 08:40:14 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940340f1csm207924185a.44.2026.04.29.08.40.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:40:14 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 06/13] libmspack: Remove
Date: Wed, 29 Apr 2026 11:39:36 -0400
Message-ID: <d0386f2844c1f0b83f9a99e72a863c3bc2ac6372.1777476608.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777476608.git.scott.murray@konsulko.com>
References: <cover.1777476608.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 15:40:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3880

Remove libmspack recipe, and remove it from clamav's DEPENDS.
clamav now vendors its own substantially modified copy, so there's
no reason to carry a recipe for it.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../distro/include/maintainers-meta-security.inc |  1 -
 recipes-scanners/clamav/clamav_1.4.3.bb          |  2 +-
 recipes-security/libmspack/libmspack_1.11.bb     | 16 ----------------
 3 files changed, 1 insertion(+), 18 deletions(-)
 delete mode 100644 recipes-security/libmspack/libmspack_1.11.bb

diff --git a/conf/distro/include/maintainers-meta-security.inc b/conf/distro/include/maintainers-meta-security.inc
index 6f13ea9..8bde7bd 100644
--- a/conf/distro/include/maintainers-meta-security.inc
+++ b/conf/distro/include/maintainers-meta-security.inc
@@ -38,7 +38,6 @@ RECIPE_MAINTAINER:pn-libaes-siv = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-libgssglue = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-libhtp = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-libmhash = "Scott Murray <scott.murray@konsulko.com>"
-RECIPE_MAINTAINER:pn-libmspack = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-lib-perl = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-libseccomp = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-libwhisker2-perl = "Scott Murray <scott.murray@konsulko.com>"
diff --git a/recipes-scanners/clamav/clamav_1.4.3.bb b/recipes-scanners/clamav/clamav_1.4.3.bb
index f123512..312a398 100644
--- a/recipes-scanners/clamav/clamav_1.4.3.bb
+++ b/recipes-scanners/clamav/clamav_1.4.3.bb
@@ -13,7 +13,7 @@ LIC_FILES_CHKSUM = "file://COPYING.txt;md5=2c0b5770a62017a3121c69bb9f680b0c \
                     file://COPYING/COPYING.curl;md5=be5d9e1419c4363f4b32037a2d3b7ffa \
                     "
 
-DEPENDS = "glibc llvm libtool db openssl zlib curl libxml2 bison pcre2 json-c libcheck rust-native cargo-native libmspack"
+DEPENDS = "glibc llvm libtool db openssl zlib curl libxml2 bison pcre2 json-c libcheck rust-native cargo-native"
 
 SRC_URI = "git://github.com/Cisco-Talos/clamav;branch=rel/1.4;protocol=https \
            file://clamd.conf \
diff --git a/recipes-security/libmspack/libmspack_1.11.bb b/recipes-security/libmspack/libmspack_1.11.bb
deleted file mode 100644
index 7203dee..0000000
--- a/recipes-security/libmspack/libmspack_1.11.bb
+++ /dev/null
@@ -1,16 +0,0 @@
-SUMMARY = "A library for Microsoft compression formats"
-HOMEPAGE = "http://www.cabextract.org.uk/libmspack/"
-SECTION = "lib"
-LICENSE = "LGPL-2.1-only"
-DEPENDS = ""
-
-LIC_FILES_CHKSUM = "file://COPYING.LIB;beginline=1;endline=2;md5=5b1fd1f66ef926b3c8a5bb00a72a28dd"
-
-SRCREV = "305907723a4e7ab2018e58040059ffb5e77db837"
-SRC_URI = "git://github.com/kyz/libmspack.git;branch=master;protocol=https"
-
-inherit autotools
-
-S = "${UNPACKDIR}/${BP}/${BPN}"
-
-inherit autotools
-- 
2.53.0


