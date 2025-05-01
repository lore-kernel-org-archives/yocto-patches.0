Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E600C3ABB7
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:52 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web10.4586.1746132049202978508
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gz/kcW8N;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c59e7039eeso188296685a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132048; x=1746736848; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suy+5oed4TuglzacxhyEXek+ZLUow1GRUtLnKQE2bfA=;
        b=gz/kcW8Ngmcxv8G+CNvf+6ljidtR51bVsG7Os37vhsIoDjFAwUprlju+kn/thV3UFK
         GSnp5/lKZKfdE6EpRo3z/pc5PFIMGg/rVO8/RR1dUxzEaSlLPJTssIo15JE9yV7Z1gy/
         yPeeElCM1J3jCIppX5SQQav9xBg1kuZ4jyWc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132048; x=1746736848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suy+5oed4TuglzacxhyEXek+ZLUow1GRUtLnKQE2bfA=;
        b=Fub7c6M/Jc9v0cTudYk7WavzM2Z3SqXlwBioVkaHxV6/O8WE6G13AyPakewa6HCFCl
         HniouW/sHR5kesie8RsRPOLpvaERFa2BZgza0on0gXaEiOcNbojGm1poLM4meSEsQNLJ
         odm3dBTDn7Z9sVNe8WFQtbwGT6gh9YN24urZe8deSfS5ZYNk17N/UqfkCGHTzvpV874U
         3iK40B9olDRFX8LaNOtxsJ/h2Oj4IwEgOqFOzabZa6R6FHqYCICb0O/+AXHOS4Gv5BsO
         t/+6JDWIGoCEtyjKvMS1E4lZBADPAuN4Vg77SBTwfRkQLPDHqv7nz/18Ao+g4GVw1PO2
         vtrw==
X-Gm-Message-State: AOJu0YwbtQlmXkcPC5DGzECryzX1T5GALaS2Z8dqxtI0BKRIzWDna+0s
	Y5Wdswwe7XU+Atu6+fTQWkbSgGOg0gMpqqd4EqtVjtElIimA7R+vKv1VCyK/afuP+5YxldKPkWl
	y
X-Gm-Gg: ASbGnct3TKGdWmKLhu8qZ1LYEPue5YRM/5ppXV5nMFNFAEIjR5hToA1ZBie+Y2V2Mqc
	GZVTZtuYaK2NsrgjPzOgelJvzof7hHfgi7SlDsqXub/tI65iByFDuWR9OlY2EGhQ8CfsdzF6tmy
	zF15ojurMqldEHY7iQiI5TFLf4IAZX6oG06QCpyTYKb+6jiKmhv0H0uqQKksidIKnPr/dY+rL7d
	JhM7Np2Xle28vkQElGybsZrOvIqxG8uNGNRMb7OvadBXIVaWEZpfrpV+BjD+dknCYzHXyTLjxQH
	FFRXl/Qp+bVhi6+2VV3hFIPVOrWRNMfA/QV+VymsZcWPg8g9mnmbSzvRC2t7K3/IzmMgUQbqqI/
	zE4gCKZXSWQrLC/0q
X-Google-Smtp-Source: AGHT+IFb9z7tropobX176dfKfBcgHIOKly4OZG1isggqQkBC1/k9jkmFWgQcapnjFFQcfEQhQuRKAg==
X-Received: by 2002:a05:6214:212e:b0:6f4:f162:ce24 with SMTP id 6a1803df08f44-6f515642314mr9277856d6.44.1746132047891;
        Thu, 01 May 2025 13:40:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:47 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 13/38] cargo_common: use 'config.toml' instead of plain 'config'
Date: Thu,  1 May 2025 16:39:49 -0400
Message-ID: <0b677b733a1d88ec92c9f7a2d5d11b8f9bf3b75f.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1440

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
 classes/cargo_common.bbclass | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/classes/cargo_common.bbclass b/classes/cargo_common.bbclass
index 15f848c..e417214 100644
--- a/classes/cargo_common.bbclass
+++ b/classes/cargo_common.bbclass
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


