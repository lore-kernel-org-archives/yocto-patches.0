Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09659C27C43
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 09:48:29 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
 by mx.groups.io with SMTP id smtpd.web11.1107.1716939632072223416
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 May 2024 16:40:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fsoZeefj;
 spf=pass (domain: gmail.com, ip: 209.85.160.46, mailfrom: geoffhp@gmail.com)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24cbb2b71b4so619586fac.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 16:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716939631; x=1717544431; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0hf7yAr4LCGCs2wlrdSz/2UsCsCA+BAYkwnzyNa7Qvc=;
        b=fsoZeefj1QO1bLjuHvflIKziMZza3xjFBnEZu25ztKprHb0otEDlla3LzGny9yqrFN
         mCX86ZJ7reP1o6ORMhFLQVJT8a/2GpxD8Fw0HqSkVY6RJaevBGwxxAlFMGLZUv9kVoZT
         xhzKBIPPvP/uXiSXhSeBPy1LNd8h+cGonr3fXvpgsYYVzndzjikwSFjUNCm5TsXasfi7
         hPer1cfOdL0ILzl/J9Z4Fj6SCSsn/jwsJ5Xv8N9iQLMMIi5dth5nBp+IEOv3gPHji1Ts
         LLDscccMnBkEfG5aCjOCgQm+elZ4Is9iUMNPB5aX5oeshsrREXhMfRPra+tNCm6meqiE
         LexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716939631; x=1717544431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hf7yAr4LCGCs2wlrdSz/2UsCsCA+BAYkwnzyNa7Qvc=;
        b=T0DqMWKu57+MfogS1cOhE/xhmHPTiLKJufhGQ/YqiejyvPumlXfftDTZ8Yp2ij7XYL
         0/xu6eNFyNVojHRb61zZu+g6x8ATh/XBYcFCy2Uoj9PlaWaJCOclBlPr2LC1F7m3wTF1
         MjagmbsDwhn2zv8sE/Oi/KzZZyuzFLS6hHUkhFEcK9ixvvmhLtqBeqfzx/WU9G6Vq0Do
         tngtElH9wDMZcDQvKMMR6FRxstWz/oKjBkqTbSCKIQgtRLXsfucKUEPJyrKggBB1+EAM
         A+DA3300tfswiadDSeDm5lA6JQnX8StFgNtrWDy6e0r1YX4DU/eFyeN3QE/GQqpNTJ2O
         iTMg==
X-Gm-Message-State: AOJu0Yw/y0pEYcHb9T/EWpBPUYD8Q5vxq5hqTfmW2ljnsoBmldcfOTAa
	raUCLmR9ognm+PRj6cVZlMirHzAtplrZyDSE1/SugHKCAIdb9v/X4CHwHVIm
X-Google-Smtp-Source: AGHT+IE+Kak1rAr+PrvlG6z2ZVWrca1hwgIQpPjZlmwtGC37h7KBtqTUncrlJvp6Sf9/CukFt/3Qzw==
X-Received: by 2002:a05:6870:d248:b0:24c:b93d:a4d with SMTP id 586e51a60fabf-24cb93d4c09mr12670782fac.17.1716939630915;
        Tue, 28 May 2024 16:40:30 -0700 (PDT)
Received: from localhost.localdomain (syn-023-241-067-081.res.spectrum.com. [23.241.67.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682227f1838sm8074148a12.46.2024.05.28.16.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:40:30 -0700 (PDT)
From: "Geoff Parker" <geoffhp@gmail.com>
X-Google-Original-From: geoffrey.parker@arthrex.com
To: yocto-patches@lists.yoctoproject.org
Cc: Geoff Parker <geoffrey.parker@arthrex.com>,
	Geoff Parker <geoffhp@gmail.com>
Subject: [meta-java][PATCH] Yocto 5.1 (styhead): S = ${WORKDIR} no longer supported
Date: Tue, 28 May 2024 16:30:32 -0700
Message-Id: <20240528233032.464865-1-geoffrey.parker@arthrex.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 May 2024 09:48:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/245

From: Geoff Parker <geoffrey.parker@arthrex.com>

Fix errors during parse due to S = ${WORKDIR}
https://docs.yoctoproject.org/next/migration-guides/migration-5.1.html#workdir-changes :

    S = ${WORKDIR} no longer supported

    If a recipe has S set to be WORKDIR, this is no longer supported,
    and an error will be issued. The recipe should be changed to:

    S = "${WORKDIR}/sources"
    UNPACKDIR = "${S}"

    Any WORKDIR references where files from SRC_URI are referenced
    should be changed to S. These are commonly in do_compile,
    do_compile, do_install and LIC_FILES_CHKSUM.

Signed-off-by: Geoff Parker <geoffhp@gmail.com>
---
 recipes-core/ecj/ecj-bootstrap-native.bb   | 3 ++-
 recipes-core/ecj/ecj-initial-native.bb     | 3 ++-
 recipes-core/ecj/libecj-bootstrap.inc      | 3 ++-
 recipes-core/jikes/jikes-initial-native.bb | 3 ++-
 recipes-core/jlex/jlex_1.2.6.bb            | 3 ++-
 recipes-core/junit/junit4_4.3.1.bb         | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/recipes-core/ecj/ecj-bootstrap-native.bb b/recipes-core/ecj/ecj-bootstrap-native.bb
index 874bd99..250df91 100644
--- a/recipes-core/ecj/ecj-bootstrap-native.bb
+++ b/recipes-core/ecj/ecj-bootstrap-native.bb
@@ -18,7 +18,8 @@ PROVIDES = "virtual/javac-native"
 
 SRC_URI = "file://ecj.in"
 
-S = "${WORKDIR}"
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
 
 JAR = "ecj-bootstrap.jar"
 
diff --git a/recipes-core/ecj/ecj-initial-native.bb b/recipes-core/ecj/ecj-initial-native.bb
index d75b7a0..4d1c0ea 100644
--- a/recipes-core/ecj/ecj-initial-native.bb
+++ b/recipes-core/ecj/ecj-initial-native.bb
@@ -12,7 +12,8 @@ DEPENDS = "libecj-bootstrap-native"
 
 SRC_URI = "file://ecj-initial.in"
 
-S = "${WORKDIR}"
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
 
 inherit native
 
diff --git a/recipes-core/ecj/libecj-bootstrap.inc b/recipes-core/ecj/libecj-bootstrap.inc
index 2f3cc97..266e40e 100644
--- a/recipes-core/ecj/libecj-bootstrap.inc
+++ b/recipes-core/ecj/libecj-bootstrap.inc
@@ -11,7 +11,8 @@ INC_PR = "r5"
 
 inherit java native
 
-S = "${WORKDIR}"
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
 
 JAR = "ecj-bootstrap-${PV}.jar"
 
diff --git a/recipes-core/jikes/jikes-initial-native.bb b/recipes-core/jikes/jikes-initial-native.bb
index 063525d..a5bbe12 100644
--- a/recipes-core/jikes/jikes-initial-native.bb
+++ b/recipes-core/jikes/jikes-initial-native.bb
@@ -3,7 +3,8 @@ LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
 DEPENDS = "jikes-native classpath-initial-native"
 
-S = "${WORKDIR}"
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
 
 inherit native
 
diff --git a/recipes-core/jlex/jlex_1.2.6.bb b/recipes-core/jlex/jlex_1.2.6.bb
index 48ec357..0160a2c 100644
--- a/recipes-core/jlex/jlex_1.2.6.bb
+++ b/recipes-core/jlex/jlex_1.2.6.bb
@@ -16,7 +16,8 @@ SRC_URI = "http://www.cs.princeton.edu/~appel/modern/java/JLex/Archive/${PV}/Mai
            file://jlex \
           "
 
-S = "${WORKDIR}"
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
 
 do_configure() {
   sed -i \
diff --git a/recipes-core/junit/junit4_4.3.1.bb b/recipes-core/junit/junit4_4.3.1.bb
index b2cd4d9..994c5bf 100644
--- a/recipes-core/junit/junit4_4.3.1.bb
+++ b/recipes-core/junit/junit4_4.3.1.bb
@@ -6,7 +6,8 @@ HOMEPAGE = "http://www.junit.org"
 
 SRC_URI = "http://downloads.sourceforge.net/junit/junit-${PV}-src.jar"
 
-S = "${WORKDIR}"
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
 
 inherit java-library
 
-- 
2.30.2


