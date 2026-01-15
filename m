Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DFCD47CA4
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.845.1768520625001877068
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjo2408772;
	Thu, 15 Jan 2026 17:43:42 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 19/20] configure: Minor code quality changes
Date: Thu, 15 Jan 2026 17:43:35 -0600
Message-Id: <1768520616-7289-20-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2990

From: Mark Hatle <mark.hatle@amd.com>

AI-Generated: Suggested by GitHub Copilot (Claude Sonnet 4.5)

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 configure | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index d596a35..68c9962 100755
--- a/configure
+++ b/configure
@@ -56,17 +56,17 @@ use_maybe_rpath=true
 
 for arg
 do
-    case $arg in
+    case "$arg" in
     --disable-*)
         arg="--enable-${arg%--disable-}=no"
 	;;
     esac
-    case $arg in
+    case "$arg" in
     --)    shift; break ;;
     --prefix=*)
         opt_prefix=${arg#--prefix=}
 	if [ -d "$opt_prefix" ]; then
-		maybe_prefix=$(cd "$opt_prefix"; pwd)
+		maybe_prefix=$(cd "$opt_prefix" && pwd)
 	else
 		maybe_prefix=$opt_prefix
 	fi
@@ -169,7 +169,7 @@ do
     esac
 done
 
-case $opt_arch in
+case "$opt_arch" in
 '' | x86 | arm )
     ;;
 *)    echo >&2 "Untested arch $opt_arch."
@@ -178,7 +178,7 @@ esac
 
 if [ -z "$opt_bits" ]; then
     printf >&2 "Bit width unspecified;"
-    case $(file -L /bin/sh 2>/dev/null) in
+    case "$(file -L /bin/sh 2>/dev/null)" in
     *64-bit*)	opt_bits=64;;
     *32-bit*)	opt_bits=32;;
     esac
@@ -241,6 +241,10 @@ read t1 t2 SQLITE3_VERSION << EOF
   `grep "#define SQLITE_VERSION_NUMBER " ${opt_sqlite}/include/sqlite3.h`
 EOF
 
+if [ -z "${SQLITE3_VERSION}" ]; then
+    echo >&2 "Could not determine SQLite version from header."
+    exit 1
+fi
 echo "SQLite header for version ${SQLITE3_VERSION} found in ${opt_sqlite}."
 
 if [ "${SQLITE3_VERSION}" -lt "03006000" ]; then
@@ -292,7 +296,7 @@ fi
 
 if $opt_xattr || $opt_xattrdb; then
     if ! $xattr_runs; then
-        echo >&2 "WARNING: getfattr doesn't work, but xattr-related features requestd."
+        echo >&2 "WARNING: getfattr doesn't work, but xattr-related features requested."
     fi
 fi
 
@@ -327,6 +331,7 @@ fi
 touch port_deps.mk
 touch func_deps.mk
 
+rm -f Makefile
 sed -e '
   s,@PREFIX@,'"$opt_prefix"',g
   s,@EPOLL@,'"$EPOLL"',g
@@ -350,4 +355,4 @@ sed -e '
   s,@BITS@,'"$opt_bits"',g
 ' < Makefile.in > Makefile
 
-sed -i -e 's/\-[f]*pie//g' Makefile
+sed Makefile -e 's/\-[f]*pie//g' > Makefile.tmp && mv Makefile.tmp Makefile
-- 
2.43.0


