Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082DCC25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 09:48:29 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web11.1302.1716940144557009256
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 May 2024 16:49:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ms/KRFz0;
 spf=pass (domain: gmail.com, ip: 209.85.215.174, mailfrom: geoffhp@gmail.com)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-65c5a29f7f0so1156509a12.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 16:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716940144; x=1717544944; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0hf7yAr4LCGCs2wlrdSz/2UsCsCA+BAYkwnzyNa7Qvc=;
        b=ms/KRFz0YuTEPlGKMIigULxEqTNU8tYrFDd8BlYGtUOV4dtoYi7fjTI8jc8xrkLUd9
         DXfFiGNSjeAzc/YMLNrWn7OdCmkgImWfAKFmco8xh0SEh06w82e+aL83S8sW/1LxoriT
         BF3uQKQfPuwbbsal2YdJrpiL7F6QvgeWI+SLnXImRvHO1Fffwbe9EGiJo4Z3UB47lK2e
         HwvJ/n/3dzbnQ6fHbRyafjZPiSTC3MVv55OrRR4BbVZe+hlsbUnhxy/ty8804pWN4j0u
         lG5NimMC8HOvDTEtk6ze8V4+rYfwzC7WuRzyLJo6DRgGNIooSf56KGwpahPR+r7041Fj
         N81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716940144; x=1717544944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hf7yAr4LCGCs2wlrdSz/2UsCsCA+BAYkwnzyNa7Qvc=;
        b=pJ6yE7BF7sw2LdHov6DWbHH5sgWkrYVhA0lEmm6O0BN4eGlO8rhPfdMc/j2fL3AlED
         Gm7mM6wGBvOxih8sTr7x1P3Qq+HDdK715oRxOMQicmv0PQ2QGqnSLtqvVEX4R0Lipa4h
         HoHVDIMLWNJ+MlCUjqiZ+UtZ8XOx7ow3kyBxiHG8hW1FWT31NAVhLnxK2hAfwz0SnywN
         yAoNC9fTb1bFFwNGZPOVKexvmzponRoOc+dk1hlKcFywszJgfDSQaH9W6zWituyroziK
         BQspAo3EVv4d17bT6FOYhHoebyYkogQe3nT6n1nx+1IxFINsMQyGZRtscAq87PGeNcS+
         3k7A==
X-Gm-Message-State: AOJu0YzWR0tgWsye1EBdf4jcF1rKRdiouov3J43nr2NuJ433V49n5WNZ
	D0AEHg9hPT1T7iS8+v0V9ovuP5as+hqs2n514KwAExmIXjSoX5RWBKB3iqc7
X-Google-Smtp-Source: AGHT+IGcqb3D7nTgzfowlvMNBQdkJwbXcP6jQhIczEXdHgGY3yD6C6kZD0ii42QWHDCuahTkqmgD9g==
X-Received: by 2002:a05:6a20:d498:b0:1af:667c:38cc with SMTP id adf61e73a8af0-1b212cc76a0mr17088435637.5.1716940143512;
        Tue, 28 May 2024 16:49:03 -0700 (PDT)
Received: from localhost.localdomain (syn-023-241-067-081.res.spectrum.com. [23.241.67.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc36d274sm6939544b3a.81.2024.05.28.16.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:49:03 -0700 (PDT)
From: "Geoff Parker" <geoffhp@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Geoff Parker <geoffrey.parker@arthrex.com>,
	Geoff Parker <geoffhp@gmail.com>
Subject: [meta-java][PATCH] Yocto 5.1 (styhead): S = ${WORKDIR} no longer supported
Date: Tue, 28 May 2024 16:39:20 -0700
Message-Id: <20240528233920.464989-1-geoffhp@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 May 2024 09:48:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/246

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


