Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D005D46638
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 22:46:58 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.707.1768517216525960203
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 14:46:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nnJXiXil;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5014b671367so17419171cf.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768517215; x=1769122015; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QDydrsld/DLcstktrdiAjljG3YqXk8qSpUgPplqNBM=;
        b=nnJXiXilxj1DNGsnbBoyHLq4X+5KHjybhj9nsPUJQG3UWvxR2Tylm0UeRD+8n8RPqU
         gSCApHMUGvUVgMvT8yzHRtZqPmq0pBWRE3Y1lJq6fxRHXziNMXmay4iqbemwnip3NhBy
         ayP49VWP3+kfLRHJb4/ZMUO1f3/aU94Ta/SGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768517215; x=1769122015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2QDydrsld/DLcstktrdiAjljG3YqXk8qSpUgPplqNBM=;
        b=TgS11f2R+UmTJQ44Ae6ZKFvDTlQ1Ljx4cRDOZmS4sVa4Q/mENobZPYeU5M8/4Ce7U7
         /flI9EArKERLaxnwjPN8CYTEXNnHHUFalWvLGKzlobr5xNbrJIdrMiIHki3xaXJSGanD
         wJh8cPWgfEArMmaaylhE5SFy5WKdsjfQX2h0yzOtDZN/WlOUv8kcXtV7fdYkFeDMwT6A
         SrPLDezz6Em9CbHwJ4x6bYsOvmuc+1GNYkkh1lxD0+jrvxu7OF0J9PthMOFUiyJBX+cJ
         ZUE2b6/881DYArKrjF9ldVZ4JjtxuLrFZDZwOUUyotXcf+nRsR4tF1egGqPsxhty95RX
         5O1A==
X-Gm-Message-State: AOJu0YwK7A8jqv7twLNq8vBJbb8pe0lWC+F2PiCB/uiQv/X2cwhYGqod
	bJXhKIiIetQ6rHXTp/v3HLpKe8aSIqqrkySnNsYweJMpub+RGHh1tWSjDSP82kyMj9PI9UHLsk9
	//WBl
X-Gm-Gg: AY/fxX4Nw3teyGy6AM63WnktBWzblRHXbWfC0tgbcZwejgHegrO3d4ED0nUECXQJeCv
	Aeyo9oi1tztYIwH886mO4idZPaepx0HqdsxZXNGyrvwsyb/J5McM7FIEa4dijafSqq+6Lweh5I5
	iY7ve3Umso3KdzsqjUE57cNdohL+oTyI1wJB7D+cjEGNwNBEqCtmq/eezrSLbnf5YGf5i2ezJmX
	nPc7nJctk3EGb52PNCRsa5QUoOAv+pG5RQJa2k5z1RKCfT3eg9fNWdkwfavYr8ps5wdx6wSy7Dp
	4g9yjRsq3u6K3HLheBSNUgWwl3GfRI2Q4TVKNOn2VTqJcRGoN5m5fJ3Ua4UgxW/+8Acy27pxRwc
	dh3Vh8dn3BbU5CaHXBWN6hZ/FuQiNJdrQ2WuPBlnq0edyLQFUItsfvYqDGd5EvIt6sU3I/wZS8w
	KY/o+ywB0Jip/uCTW82bYKTlkOzH/eghByLSFbWqF8MAcnblBoBcBYy2rp8WWfti38l/Q77Lmsp
	gEVs3BHkt+NgF493S4hPjBpC/0GGKOVCdXIC/kCEUS3JRXbUHEr
X-Received: by 2002:a05:622a:1ba5:b0:4fb:f92d:bc8b with SMTP id d75a77b69052e-502a1e02b82mr13514091cf.18.1768517215318;
        Thu, 15 Jan 2026 14:46:55 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6040casm7921436d6.21.2026.01.15.14.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:46:54 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][kirkstone][PATCH 5/9] checksecurity: update to 2.0.16
Date: Thu, 15 Jan 2026 17:46:26 -0500
Message-ID: <b8622b9cf3a1dd4c65e762a9f097a0a6bd9e3e76.1768515491.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768515491.git.scott.murray@konsulko.com>
References: <cover.1768515491.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 22:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2970

From: Armin Kuster <akuster808@gmail.com>

Drop setuid-log-folder.patch, using sed instead.
Refresh patch check-setuid-use-more-portable-find-args.patch

Signed-off-by: Armin Kuster <akuster808@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...rity_2.0.15.bb => checksecurity_2.0.16.bb} | 18 +++++--
 ...k-setuid-use-more-portable-find-args.patch | 16 +++---
 .../files/setuid-log-folder.patch             | 52 -------------------
 3 files changed, 21 insertions(+), 65 deletions(-)
 rename recipes-scanners/checksecurity/{checksecurity_2.0.15.bb => checksecurity_2.0.16.bb} (57%)
 delete mode 100644 recipes-scanners/checksecurity/files/setuid-log-folder.patch

diff --git a/recipes-scanners/checksecurity/checksecurity_2.0.15.bb b/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
similarity index 57%
rename from recipes-scanners/checksecurity/checksecurity_2.0.15.bb
rename to recipes-scanners/checksecurity/checksecurity_2.0.16.bb
index e053a15..8006c9f 100644
--- a/recipes-scanners/checksecurity/checksecurity_2.0.15.bb
+++ b/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
@@ -4,14 +4,22 @@ SECTION = "security"
 LICENSE = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"
 
-SRC_URI = "http://ftp.de.debian.org/debian/pool/main/c/checksecurity/checksecurity_${PV}.tar.gz \
-           file://setuid-log-folder.patch \
-           file://check-setuid-use-more-portable-find-args.patch"
+SRC_URI = "http://ftp.de.debian.org/debian/pool/main/c/checksecurity/checksecurity_${PV}+nmu1.tar.gz \
+           file://check-setuid-use-more-portable-find-args.patch \
+          "
 
-SRC_URI[md5sum] = "a30161c3e24d3be710b2fd13fcd1f32f"
-SRC_URI[sha256sum] = "67abe3d6391c96146e96f376d3fd6eb7a9418b0f7fe205b465219889791dba32"
+SRC_URI[sha256sum] = "9803b3760e9ec48e06ebaf48cec081db48c6fe72254a476224e4c5c55ed97fb0"
+
+S = "${WORKDIR}/checksecurity-${PV}+nmu1"
+
+
+# allow for anylocal, no need to patch
+LOGDIR="/etc/checksecurity"
 
 do_compile() {
+    sed -i -e "s;LOGDIR=/var/log/setuid;LOGDIR=${LOGDIR};g" ${B}/etc/check-setuid.conf
+    sed -i -e "s;LOGDIR=/var/log/setuid;LOGDIR=${LOGDIR};g" ${B}/plugins/check-setuid
+    sed -i -e "s;LOGDIR:=/var/log/setuid;LOGDIR:=${LOGDIR};g" ${B}/plugins/check-setuid
 }
 
 do_install() {
diff --git a/recipes-scanners/checksecurity/files/check-setuid-use-more-portable-find-args.patch b/recipes-scanners/checksecurity/files/check-setuid-use-more-portable-find-args.patch
index f1fe8ed..1a2f364 100644
--- a/recipes-scanners/checksecurity/files/check-setuid-use-more-portable-find-args.patch
+++ b/recipes-scanners/checksecurity/files/check-setuid-use-more-portable-find-args.patch
@@ -8,16 +8,16 @@ Signed-off-by: Christopher Larson <chris_larson@mentor.com>
  plugins/check-setuid | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)
 
-Index: checksecurity-2.0.15/plugins/check-setuid
+Index: checksecurity-2.0.16+nmu1/plugins/check-setuid
 ===================================================================
---- checksecurity-2.0.15.orig/plugins/check-setuid	2018-09-06 00:49:23.930934294 +0500
-+++ checksecurity-2.0.15/plugins/check-setuid	2018-09-06 00:49:49.694934757 +0500
-@@ -99,7 +99,7 @@
- ionice -t -c3 \
+--- checksecurity-2.0.16+nmu1.orig/plugins/check-setuid
++++ checksecurity-2.0.16+nmu1/plugins/check-setuid
+@@ -100,7 +100,7 @@ ionice -t -c3 \
  find `mount | grep -vE "$CHECKSECURITY_FILTER" | cut -d ' ' -f 3` \
+         -ignore_readdir_race  \
  	-xdev $PATHCHK \
--	\( -type f -perm +06000 -o \( \( -type b -o -type c \) \
-+	\( -type f \( -perm -4000 -o -perm -2000 \) -o \( \( -type b -o -type c \) \
+-	\( -type f -perm /06000 -o \( \( -type b -o -type c \) \
++    \( -type f \( -perm -4000 -o -perm -2000 \) -o \( \( -type b -o -type c \) \	
  	$DEVCHK \) \) \
-         -ignore_readdir_race  \
  	-printf "%8i %5m %3n %-10u %-10g %9s %t %h/%f\n" |
+ 	sort -k 12 >$TMPSETUID
diff --git a/recipes-scanners/checksecurity/files/setuid-log-folder.patch b/recipes-scanners/checksecurity/files/setuid-log-folder.patch
deleted file mode 100644
index 540ea9c..0000000
--- a/recipes-scanners/checksecurity/files/setuid-log-folder.patch
+++ /dev/null
@@ -1,52 +0,0 @@
-From 24dbeec135ff83f2fd35ef12fe9842f02d6fd337 Mon Sep 17 00:00:00 2001
-From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
-Date: Thu, 20 Jun 2013 15:14:55 +0300
-Subject: [PATCH] changed log folder for check-setuid
-
-check-setuid was creating logs in /var/log directory,
-which cannot be created persistently. To avoid errors
-the log folder was changed to /etc/checksecurity/.
-
-Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
----
- etc/check-setuid.conf |    2 +-
- plugins/check-setuid  |    6 +++---
- 2 files changed, 4 insertions(+), 4 deletions(-)
-
-diff --git a/etc/check-setuid.conf b/etc/check-setuid.conf
-index 621336f..e1532c0 100644
---- a/etc/check-setuid.conf
-+++ b/etc/check-setuid.conf
-@@ -116,4 +116,4 @@ CHECKSECURITY_PATHFILTER="-false"
- #
- # Location of setuid file databases. 
- #
--LOGDIR=/var/log/setuid
-+LOGDIR=/etc/checksecurity/
-diff --git a/plugins/check-setuid b/plugins/check-setuid
-index 8d6f90b..bdb21c1 100755
---- a/plugins/check-setuid
-+++ b/plugins/check-setuid
-@@ -44,8 +44,8 @@ if [ `/usr/bin/id -u` != 0 ] ; then
-    exit 1
- fi
- 
--TMPSETUID=${LOGDIR:=/var/log/setuid}/setuid.new.tmp
--TMPDIFF=${LOGDIR:=/var/log/setuid}/setuid.diff.tmp
-+TMPSETUID=${LOGDIR:=/etc/checksecurity/}/setuid.new.tmp
-+TMPDIFF=${LOGDIR:=/etc/checksecurity/}/setuid.diff.tmp
- 
- #
- # Check for NFS/AFS mounts that are not nosuid/nodev
-@@ -75,7 +75,7 @@ if [ "$CHECKSECURITY_NOFINDERRORS" = "TRUE" ] ; then
- fi
- 
- # Guard against undefined vars
--[ -z "$LOGDIR" ] && LOGDIR=/var/log/setuid
-+[ -z "$LOGDIR" ] && LOGDIR=/etc/checksecurity/
- if [ ! -e "$LOGDIR" ] ; then
-     echo "ERROR: Log directory $LOGDIR does not exist"
-     exit 1
--- 
-1.7.9.5
-
-- 
2.51.0


