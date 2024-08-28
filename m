Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE0C71121
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:05 +0000 (UTC)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.web11.5852.1724875802783026681
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=N3S8PLVw;
 spf=pass (domain: konsulko.com, ip: 209.85.166.47, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f8f0197abso351733839f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875802; x=1725480602; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvOIxYlgVJi8Wq7PkjTWdi1mNRVn42RFIVlc9nz3cDQ=;
        b=N3S8PLVwp+utMkh0YD59Qdl8UVAB1ATKDc4f43XNJOBIZX7+lI+oCskaYfsiHv1Zvf
         bF7148+v/BgVIM0UWyZbl2rVog3nJSFf6m0RdClJBovVZLTvsbqbS3NOpDFJFuv8PRMK
         NAI3mnLJI/AzR56TxmUcd4Hx4a1OAUg4QI22c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875802; x=1725480602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvOIxYlgVJi8Wq7PkjTWdi1mNRVn42RFIVlc9nz3cDQ=;
        b=US0VcoOzNDXuNAzfwUaULI/h9JXU7YDlN8w7F+s0lSYj4XdXMf7poF/1ODNN9R5fCU
         tveEcJSiDtGTTH7f3TMp4vs1ixcq9f7ne/84qbJdTZUIWn9WAoOYN8Y1/+IER15sPUk1
         JcAamRXL2Z9+blB1Iw9sl36KyjcoQtHJ1PTS/CempubHv5AUc4pMvIeEmc8K4iN386JR
         cYaSvmbzDb7IhOcWPVavAB2KRYQ0GGft+u16+PBecr4G2gKJ2lsAhzu9spWKGV7jkz+n
         euUTVBlhbJRlImIQbOWElZxR5N8GwXqquRg/XtkUjqZn1pFiFCP06q+UyZK3XtTjI2VA
         Q4JQ==
X-Gm-Message-State: AOJu0YxWNtiW0mlUR2Fm1qaiJy3dmfUgvm38ih/UdyN+qb8n7nH4X4uw
	Wq5WMy7TpsHppZdA08LtIBogJqvv5KWXX+qLS0CwAlOn3JA2hdplkwxKyi+9fJ3oidRyU8zI1nX
	A
X-Google-Smtp-Source: AGHT+IEGmIarNxcwjEO7b8Qe5strUtqnPhHJ5xy+ywPN3e3ldgxxSfMD4dvf0p4oF3zy03xvm4ovCg==
X-Received: by 2002:a05:6602:490:b0:825:3a02:f935 with SMTP id ca18e2360f4ac-82a110713bbmr72727339f.11.1724875801640;
        Wed, 28 Aug 2024 13:10:01 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:01 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 17/33] librsvg: upgrade to 2.57.3
Date: Wed, 28 Aug 2024 16:09:03 -0400
Message-ID: <56de7450dca8465fa89cbd47002f9779105769d6.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/584

From: Ross Burton <ross.burton@arm.com>

This is the latest point release in the 2.57.3 stable series.

Version 2.57.3
==============

- #1062 - Limit numOctaves in feTurbulence to avoid unbounded CPU consumption.
- #1064 - Don't panic when a :lang selector has an argument that is
  not a language-range (Lukáš Tyrychtr).

Version 2.57.2
==============

- #1059 - Don't panic when rendering feOffset with a too-large offset.
- #1060 - Don't panic when a decoded image has dimensions of zero.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 8a5561ea39c395716e9721aa9d98fabbac1a24ee)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch | 4 ++--
 .../librsvg/{librsvg_2.57.1.bb => librsvg_2.57.3.bb}          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-gnome/librsvg/{librsvg_2.57.1.bb => librsvg_2.57.3.bb} (96%)

diff --git a/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch b/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch
index c34a610..c08ce82 100644
--- a/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch
+++ b/recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch
@@ -1,4 +1,4 @@
-From d0f4f5b3ae900b9d092407e29b5372d93910c18c Mon Sep 17 00:00:00 2001
+From eee6c251bceb235912887a54c58a2fc2d4450216 Mon Sep 17 00:00:00 2001
 From: Alexander Kanavin <alex@linutronix.de>
 Date: Tue, 21 Sep 2021 16:27:14 +0200
 Subject: [PATCH] Makefile.am: pass rust target to cargo also when not cross
@@ -28,7 +28,7 @@ index 2a89954..4e296d3 100644
  CARGO_VERBOSE = $(cargo_verbose_$(V))
  cargo_verbose_ = $(cargo_verbose_$(AM_DEFAULT_VERBOSITY))
 diff --git a/configure.ac b/configure.ac
-index 42215cf..2499c96 100644
+index 480e27e..587c4db 100644
 --- a/configure.ac
 +++ b/configure.ac
 @@ -292,9 +292,7 @@ AC_ARG_VAR(RUST_TARGET, [Set rust target (default=$host)])
diff --git a/recipes-gnome/librsvg/librsvg_2.57.1.bb b/recipes-gnome/librsvg/librsvg_2.57.3.bb
similarity index 96%
rename from recipes-gnome/librsvg/librsvg_2.57.1.bb
rename to recipes-gnome/librsvg/librsvg_2.57.3.bb
index 81a328f..5314ef9 100644
--- a/recipes-gnome/librsvg/librsvg_2.57.1.bb
+++ b/recipes-gnome/librsvg/librsvg_2.57.3.bb
@@ -23,7 +23,7 @@ SRC_URI += " \
            file://disable-rsvg-loader-test.patch \
            "
 
-SRC_URI[archive.sha256sum] = "074671a3ed6fbcd67cae2a40e539107f4f097ca8a4ab1a894c05e2524ff340ef"
+SRC_URI[archive.sha256sum] = "1b2267082c0b77ef93b15747a5c754584eb5886baf2d5a08011cde0659c2c479"
 
 UPSTREAM_CHECK_REGEX = "librsvg-(?P<pver>\d+\.\d+\.(?!9\d+)\d+)"
 
-- 
2.46.0


