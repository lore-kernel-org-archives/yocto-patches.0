Return-Path: <vasileios.anagnostopoulos@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8D8C35FFC
	for <webhook@archiver.kernel.org>; Sat, 22 Mar 2025 09:33:42 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.6504.1742636014081053282
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 22 Mar 2025 02:33:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=vasileios.anagnostopoulos@siemens.com header.s=fm1 header.b=SZO4Jwyr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1329321-20250322093331989932be7d2a4fee12-vdtftj@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250322093331989932be7d2a4fee12
        for <yocto-patches@lists.yoctoproject.org>;
        Sat, 22 Mar 2025 10:33:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=vasileios.anagnostopoulos@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=VlxtDIMBJ/byqIx5wQBuW5ye5cexifHs8Wp0udFS9go=;
 b=SZO4Jwyr+35ITRGyX8rzL/n3PUp6u1y6bUtSmSJpOjBkOwQkoF53+a3w1cawPGZ5+07trU
 3Sm+QDbUoXsXGGab6AWwydOkNHoCPgRDRpS8ux4bVcUAC+iBeKyJK+H9ue90hIQ2KbHI+lXD
 1ai27CB9LnOt1yR4vTOg6hRzsq5UU9pNRgHKrgR7flgpA2XEYDOQIbFui32FVbR5JlP+u763
 PtIrhdhvpLZWVHK1Tzm1jMNH2qul097iy7rxxg10DtnJrR7iKi78FSlzhSvdtmPQ+BZuBbtc
 28Ogk+Y/BJkLD/k0dlHCDgN0R/jMxazz7AXGaFf9xAdlJ5+SLgAEuQww==;
From: Vasileios Anagnostopoulos <vasileios.anagnostopoulos@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Vasileios Anagnostopoulos <vasileios.anagnostopoulos@siemens.com>
Subject: [meta-lts-mixins][scarthgap/rust][PATCH] rust: use 'config.toml' instead of plain 'config'
Date: Sat, 22 Mar 2025 10:32:09 +0100
Message-ID: <20250322093209.17389-1-vasileios.anagnostopoulos@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329321:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 22 Mar 2025 09:33:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1242

cargo configuration has been renamed from 'config' to
'config.toml' in rust-1.38

Using the old name is still supported but creates warnings like

| $ cargo
| warning: `/sdk.../home/cargo/config` is deprecated in favor of `config.toml`
| note: if you need to support cargo 1.38 or earlier, you can symlink `config` to `config.toml`

So use the new name to avoid the warnings

Signed-off-by: Vasileios Anagnostopoulos <vasileios.anagnostopoulos@siemens.com>
---
 classes-recipe/cargo_common.bbclass           | 20 +++++++++----------
 recipes-devtools/rust/rust-cross-canadian.inc | 14 ++++++-------
 2 files changed, 17 insertions(+), 17 deletions(-)

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
 
diff --git a/recipes-devtools/rust/rust-cross-canadian.inc b/recipes-devtools/rust/rust-cross-canadian.inc
index af9f2d6..6525525 100644
--- a/recipes-devtools/rust/rust-cross-canadian.inc
+++ b/recipes-devtools/rust/rust-cross-canadian.inc
@@ -72,13 +72,13 @@ do_install () {
 	export CARGO_HOME="\$OECORE_TARGET_SYSROOT/home/cargo"
 	mkdir -p "\$CARGO_HOME"
         # Init the default target once, it might be otherwise user modified.
-	if [ ! -f "\$CARGO_HOME/config" ]; then
-		touch "\$CARGO_HOME/config"
-		echo "[build]" >> "\$CARGO_HOME/config"
-		echo 'target = "'${RUST_TARGET_SYS}'"' >> "\$CARGO_HOME/config"
-		echo '# TARGET_SYS' >> "\$CARGO_HOME/config"
-		echo '[target.'${RUST_TARGET_SYS}']' >> "\$CARGO_HOME/config"
-		echo 'linker = "target-rust-ccld"' >> "\$CARGO_HOME/config"
+	if [ ! -f "\$CARGO_HOME/config.toml" ]; then
+		touch "\$CARGO_HOME/config.toml"
+		echo "[build]" >> "\$CARGO_HOME/config.toml"
+		echo 'target = "'${RUST_TARGET_SYS}'"' >> "\$CARGO_HOME/config.toml"
+		echo '# TARGET_SYS' >> "\$CARGO_HOME/config.toml"
+		echo '[target.'${RUST_TARGET_SYS}']' >> "\$CARGO_HOME/config.toml"
+		echo 'linker = "target-rust-ccld"' >> "\$CARGO_HOME/config.toml"
     fi
 
 	# Keep the below off as long as HTTP/2 is disabled.
-- 
2.43.0


