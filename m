Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B21CC369A4
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:30:54 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web10.60121.1744061451236476252
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sGypMuk4;
 spf=pass (domain: konsulko.com, ip: 209.85.166.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85b40a5120eso116378039f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061450; x=1744666250; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6ezu+2hGCU4c8UfKLqhaBCKXcACKeQOkocpoR85gHw=;
        b=sGypMuk4Iju4jnHjgc1KCR6vu1mDORxxWmXVXaYVJ9W/scNjaj43mJ/iLXH8W/1jDB
         N6mxmqpbrRsc294AUIGX4Isu0JQmVc2PzWjT/j6HbMYR+L3olsBk0QNHOg8+uM2n0pjf
         zmQoKO/X5DVwihi1zRkg7zggzrlidiSRl+2a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061450; x=1744666250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6ezu+2hGCU4c8UfKLqhaBCKXcACKeQOkocpoR85gHw=;
        b=rs6fs28v5JcoJjo5Sc4JtEc7kf2r7CVFuUUTqQX1eAjx4P3vYFLhaTl/ZPAK8vGIlS
         216XEnHM4vKY+LT/GWaqAdLvhJRtBZGI3p6wQBusjv3kNTqbAMajxs8cRCYsTalyHMJj
         4qGoVrrugrsc0xu0RHkWl5RhDNi5l2JhSfQ9s0jHzHAllyrdjYE1j3rh/idTwYeWQnr1
         eJwK2X98nNHs8x9oDh2va68jP1yKt5BnGKoEt5lbuPf/Jcy/avvKT8P/LXpONrdYNdk/
         fyucKF0LkRCCtNG8hCCBgiNDkYEAB2Q9BJI4JebqJkf6Wkffqo0hvTO8mCOjsBON+ne6
         PMvQ==
X-Gm-Message-State: AOJu0YzzwlwEzUs/tSUtwWfNILlFugf4ZkmKgEro30QkGrWsgOmCrsLU
	SmYiqIYHTk7dLSULsdTj0bQVMY4GZjUbSptWweAmh2oEEysldWj1V5uRVzKboOfNG7TN7SAB3sb
	cmvw=
X-Gm-Gg: ASbGncuQ5Z+CVz2mKhFbg6/1nO3qdSY97EDBjpxXsL38B0w+eSJBt+TDiARf4dgIiu9
	v7z3rqTUohS/C4+JAx5pIujoa2QgeV9QWSB94+D+l34S26hUl9jNDTgctOhpYkUFhuS/gQQ0xFS
	acGzktHFryRdMNBvUdsM/PP+ftJz5xnvObr2e7jiSulk+GchFux1lxsNorJpHaQ4w0vn6PHDw+T
	DZ6ZBiHZroILW6KKhtt3X9VH4kEfdUH0TYP//uD13160mHBrr5qEujoSWecro0DAwOvzpI3Mw5b
	Yn1J8SIaUCT6GLbDH6JTnA6WWzCTZfCUqG1NgICObg69ceG4EORtc4T9ksKb7RIacuAAE35a5/J
	WF/lTKhqypYcLrnBWadid
X-Google-Smtp-Source: AGHT+IFTOvDc6mFgk/nnpAR4h+91/55gnqKS4QoyR9PKSDbdsCRqKYzpU0DxO41V3uUXEutkAJff8A==
X-Received: by 2002:a05:6602:4c87:b0:85b:4941:3fe2 with SMTP id ca18e2360f4ac-8611b465a37mr1533502339f.7.1744061449824;
        Mon, 07 Apr 2025 14:30:49 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:49 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 12/29] cargo_common: use 'config.toml' instead of plain 'config'
Date: Mon,  7 Apr 2025 17:30:01 -0400
Message-ID: <1589af24ef0f0cae625bb8f0f033ed7528cf3aa4.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:30:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1312

From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>

cargo configuration has been renamed from plain 'config' to
'config.toml' in rust-1.38.

Using the old name is still supported but creates warnings like

| $ cargo
| warning: `/sdk.../home/cargo/config` is deprecated in favor of `config.toml`
| note: if you need to support cargo 1.38 or earlier, you can symlink `config` to `config.toml`

Use the new name.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 94b7d1a6cdb44949f8a96213ff2e45fafd759442)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo_common.bbclass | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/classes-recipe/cargo_common.bbclass b/classes-recipe/cargo_common.bbclass
index 26de947..c0f6544 100644
--- a/classes-recipe/cargo_common.bbclass
+++ b/classes-recipe/cargo_common.bbclass
@@ -47,14 +47,14 @@ CARGO_RUST_TARGET_CCLD ??= "${RUST_TARGET_CCLD}"
 cargo_common_do_configure () {
 	mkdir -p ${CARGO_HOME}/bitbake
 
-	cat <<- EOF > ${CARGO_HOME}/config
+	cat <<- EOF > ${CARGO_HOME}/config.toml
 	# EXTRA_OECARGO_PATHS
 	paths = [
 	$(for p in ${EXTRA_OECARGO_PATHS}; do echo \"$p\",; done)
 	]
 	EOF
 
-	cat <<- EOF >> ${CARGO_HOME}/config
+	cat <<- EOF >> ${CARGO_HOME}/config.toml
 
 	# Local mirror vendored by bitbake
 	[source.bitbake]
@@ -62,7 +62,7 @@ cargo_common_do_configure () {
 	EOF
 
 	if [ ${CARGO_DISABLE_BITBAKE_VENDORING} = "0" ]; then
-		cat <<- EOF >> ${CARGO_HOME}/config
+		cat <<- EOF >> ${CARGO_HOME}/config.toml
 
 		[source.crates-io]
 		replace-with = "bitbake"
@@ -70,7 +70,7 @@ cargo_common_do_configure () {
 		EOF
 	fi
 
-	cat <<- EOF >> ${CARGO_HOME}/config
+	cat <<- EOF >> ${CARGO_HOME}/config.toml
 
 	[http]
 	# Multiplexing can't be enabled because http2 can't be enabled
@@ -82,7 +82,7 @@ cargo_common_do_configure () {
 
 	EOF
 
-	cat <<- EOF >> ${CARGO_HOME}/config
+	cat <<- EOF >> ${CARGO_HOME}/config.toml
 
 	# HOST_SYS
 	[target.${RUST_HOST_SYS}]
@@ -90,7 +90,7 @@ cargo_common_do_configure () {
 	EOF
 
 	if [ "${RUST_HOST_SYS}" != "${RUST_BUILD_SYS}" ]; then
-		cat <<- EOF >> ${CARGO_HOME}/config
+		cat <<- EOF >> ${CARGO_HOME}/config.toml
 
 		# BUILD_SYS
 		[target.${RUST_BUILD_SYS}]
@@ -99,7 +99,7 @@ cargo_common_do_configure () {
 	fi
 
 	if [ "${RUST_TARGET_SYS}" != "${RUST_BUILD_SYS}" -a "${RUST_TARGET_SYS}" != "${RUST_HOST_SYS}" ]; then
-		cat <<- EOF >> ${CARGO_HOME}/config
+		cat <<- EOF >> ${CARGO_HOME}/config.toml
 
 		# TARGET_SYS
 		[target.${RUST_TARGET_SYS}]
@@ -110,7 +110,7 @@ cargo_common_do_configure () {
 	# Put build output in build directory preferred by bitbake instead of
 	# inside source directory unless they are the same
 	if [ "${B}" != "${S}" ]; then
-		cat <<- EOF >> ${CARGO_HOME}/config
+		cat <<- EOF >> ${CARGO_HOME}/config.toml
 
 		[build]
 		# Use out of tree build destination to avoid polluting the source tree
@@ -118,7 +118,7 @@ cargo_common_do_configure () {
 		EOF
 	fi
 
-	cat <<- EOF >> ${CARGO_HOME}/config
+	cat <<- EOF >> ${CARGO_HOME}/config.toml
 
 	[term]
 	progress.when = 'always'
@@ -129,7 +129,7 @@ cargo_common_do_configure () {
 python cargo_common_do_patch_paths() {
     import shutil
 
-    cargo_config = os.path.join(d.getVar("CARGO_HOME"), "config")
+    cargo_config = os.path.join(d.getVar("CARGO_HOME"), "config.toml")
     if not os.path.exists(cargo_config):
         return
 
-- 
2.49.0


