Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F94C87FCE
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 19:05:59 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.web10.23090.1753297551650844799
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 12:05:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=uCZ3ovjd;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7dfd667e539so23384785a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753297550; x=1753902350; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmGJcPkyotvF91l+TYaFICa5FE2r9kk9/3hDOrgLK00=;
        b=uCZ3ovjdB/fqb7hQFvroH6d9N3A2G4ouqqJhdvDYbIa8/rfnlCRIYsi+fT8OrX71F6
         4qfKusnGfmppD9RGe6UYzfHJwcpPuIN3FkU0XpBj2hmN/A4ztMzIaaS65ghwoI1pWUrS
         JpK1kEqIp4fDA0lmGg29HRpGiI+C0D1G6ijjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297550; x=1753902350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmGJcPkyotvF91l+TYaFICa5FE2r9kk9/3hDOrgLK00=;
        b=wym41N8jaoreSMxlfJmZjjCUYJKwXi9cKOqQ3HwyJtL5a3s8EBNxyF9N1/q5d6fgy7
         WdUeuFqsoje6F4CR/wC2BgWhCaSzOiemvx6HQtEZYQyKVnSqz5UvvAwKMIqqXZKMjT0S
         AOB2Oo6cSycLCrWJwohWEl30aW3iySsV3yYqQlYkSTD6oMC1K5uly6ywTk+iFQ0sGMyr
         4l4MGITOwkI0tcsjxAIc3cPhu6sj9Ftfb+rFlt2EE0r9n+cz9oRAxSlnVSZDBdDALfnq
         vSB2CvHXyB/aGX5xjHKc/aGbFZwKN+OhVnSJuhylf2wMBslYBOpJyX5wx/ubGi2b3pFP
         oSkg==
X-Gm-Message-State: AOJu0YyQbRGgfPtu4jJs/cE96ebpi7pt9F3vH7BX24mdE2CqDod2EpZa
	LhqllzurbALw//NxKuvzbF5f0DaNb5DponPNFh1naToh/pOFuHABv688ySNchz0oe6zm+iWps2f
	B3Szo
X-Gm-Gg: ASbGnctLWFqcJmXRmpUgLLLewGhbK8L7O6t9i/ZaXfUbWq3v/1N0/fImiVhVKHUguc2
	AhDr8lABeGmZe3jj3Mh/xLSP2ew29VVaBgJELVYtzFDkuMkymOGfY5KC3mseiyI03gULDj8fFQ4
	DBIqOKd7J9RW3NLNg5OIO8+aCg+D5etsyraKd0hQWOk+J0xYDma+q3GRvBczL+D2iaKIOBtepCa
	qA7vjC7uIXKPiUu04+Gjv/mKH7OJ+/VvLFdrc+79WsRJtvkbf06CecqGTdsDAq2YbZKeO2W2z7B
	yQ2tsGu4HE9RqrJ2O4JIgZx7O7rXiFFKP8EqPfNsdGXIMjqQpCfd65hMuUeZpa+uOBJk/zfUWM8
	vd1DBYyim3GRm0viwCCbskUIGsorAiJ83aKp5uk4tey02hCqjCCEEhnqrrCDGF88WwlM6ycgS5g
	==
X-Google-Smtp-Source: AGHT+IGpgMVBOSQA3DqQNOdL6sMWN8zlj6WW2qeuHHSy56ro0jAASYLtLIrg0cxZbYWqEF5reu0NyQ==
X-Received: by 2002:a05:620a:7086:b0:7e0:d294:bc98 with SMTP id af79cd13be357-7e62a0ff733mr519536685a.26.1753297550015;
        Wed, 23 Jul 2025 12:05:50 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm703576085a.84.2025.07.23.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:05:49 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: soumya.sambu@windriver.com
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 04/13] rust: Use patchelf in place of chrpath to edit rpaths
Date: Wed, 23 Jul 2025 15:05:23 -0400
Message-ID: <f7e08c340c87f4c8aadba12ae39f1715749c5ae2.1753296167.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753296167.git.scott.murray@konsulko.com>
References: <cover.1753296167.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 19:05:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1845

From: Khem Raj <raj.khem@gmail.com>

chrpath has limitations e.g. the original rpath in ELF have to bigger in size
than the one being edited into it by chrpath, some toolchains do not use RPATH
but emit the RUNPATHs into ELF files and chrpath is not able to handle the
runpaths, this is the case with mips and pp32 build of rust, especially
when using clang compiler to build them.

patchelf can do more:

Modify RUNPATH entries
Add RPATH/RUNPATH where none existed
Set longer paths than the original
Convert between RPATH and RUNPATH

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 22b903f6620455e142e836412d3f7f6a4f03bea7)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.85.1.bb | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/recipes-devtools/rust/rust_1.85.1.bb b/recipes-devtools/rust/rust_1.85.1.bb
index 16b7ea2..fddd9a6 100644
--- a/recipes-devtools/rust/rust_1.85.1.bb
+++ b/recipes-devtools/rust/rust_1.85.1.bb
@@ -64,7 +64,7 @@ do_rust_setup_snapshot () {
     # are used internally by rust and result in symbol mismatches if we don't
     if [ ! -z "${UNINATIVE_LOADER}" -a -e "${UNINATIVE_LOADER}" ]; then
         for bin in cargo rustc rustdoc; do
-            patchelf-uninative ${WORKDIR}/rust-snapshot/bin/$bin --set-interpreter ${UNINATIVE_LOADER}
+            patchelf ${WORKDIR}/rust-snapshot/bin/$bin --set-interpreter ${UNINATIVE_LOADER}
         done
     fi
 }
@@ -72,6 +72,7 @@ addtask rust_setup_snapshot after do_unpack before do_configure
 addtask do_test_compile after do_configure do_rust_gen_targets
 do_rust_setup_snapshot[dirs] += "${WORKDIR}/rust-snapshot"
 do_rust_setup_snapshot[vardepsexclude] += "UNINATIVE_LOADER"
+do_rust_setup_snapshot[depends] += "patchelf-native:do_populate_sysroot"
 
 RUSTC_BOOTSTRAP = "${STAGING_BINDIR_NATIVE}/rustc"
 CARGO_BOOTSTRAP = "${STAGING_BINDIR_NATIVE}/cargo"
@@ -207,9 +208,9 @@ rust_runx () {
         mkdir -p `dirname ${RUST_ALTERNATE_EXE_PATH}`
         cp ${RUST_ALTERNATE_EXE_PATH_NATIVE} ${RUST_ALTERNATE_EXE_PATH}
         if [ -e ${STAGING_LIBDIR_NATIVE}/libc++.so.1 ]; then
-            chrpath -r \$ORIGIN/../../../../../`basename ${STAGING_DIR_NATIVE}`${libdir_native} ${RUST_ALTERNATE_EXE_PATH}
+            patchelf --set-rpath \$ORIGIN/../../../../../`basename ${STAGING_DIR_NATIVE}`${libdir_native} ${RUST_ALTERNATE_EXE_PATH}
         else
-            chrpath -d ${RUST_ALTERNATE_EXE_PATH}
+            patchelf --remove-rpath ${RUST_ALTERNATE_EXE_PATH}
         fi
     fi
 
@@ -266,7 +267,7 @@ rust_do_install:class-nativesdk() {
     install -d ${D}${bindir}
     for i in cargo-clippy clippy-driver rustfmt; do
         cp build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
-        chrpath -r "\$ORIGIN/../lib" ${D}${bindir}/$i
+        patchelf --set-rpath "\$ORIGIN/../lib" ${D}${bindir}/$i
     done
 
     chown root:root ${D}/ -R
@@ -301,7 +302,7 @@ rust_do_install:class-target() {
     install -d ${D}${bindir}
     for i in ${EXTRA_TOOLS}; do
         cp build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
-        chrpath -r "\$ORIGIN/../lib" ${D}${bindir}/$i
+        patchelf --set-rpath "\$ORIGIN/../lib" ${D}${bindir}/$i
     done
 
     install -d ${D}${libdir}/rustlib/${RUST_HOST_SYS}
-- 
2.50.0


