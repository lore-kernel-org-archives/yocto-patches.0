Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5279CD13DA
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 15:40:21 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14497.1777477214739674176
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 08:40:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=EikaH6hN;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d67a483d3eso1442110985a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777477213; x=1778082013; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFWsKyn4KiOLspJQA7F6/ZWt+LrLdsxRVY/1eeZU3eE=;
        b=EikaH6hNDnhTPMaL8nVaetpfJDt2B7k4uhouJRZg3+t/Cu49rAxvNtTWUi0/UbUL74
         eM6B7UIk2/9JWyqiOH5vxvO0Muz82DV5hhikYkQgCBUoYRxcDqifRD+DTDJYYBZsvLyP
         Flwf8bv9N36kHdvIG0F5F/jpTHI5tZPSIMYsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477213; x=1778082013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cFWsKyn4KiOLspJQA7F6/ZWt+LrLdsxRVY/1eeZU3eE=;
        b=MQJ6CI2+Or8F57H/M0zCzWTkGAErDxrUSGUdy4LhqcsDPu81RfF6UB6K/6c7NGD7GM
         WxI+w1Tib57ljUJcNSZNR3+aiAZ8bxvhTtMRuT9Lrta09PtjoGKsNMqBFzcARp7QrdmX
         0PCPpeo1hD/kJBDo6yGW8ztBX2aaK8LRVdgJcjS249hE/WQ++mpEHvEBkzEm9olCzOVP
         eNaD00P/E+H25R3d0rw7Ah2hwBIG+kfxaJSn3Pp3iUxA8p4ZkUpCxzq9y8v8FfRt98yz
         UmWGzYQn58zi8MBUxUwAQzfOzsbGl0ydI+G+V1KR8DSq/1cp6yVfuXmuMGv/1jCzk3Jz
         GZhg==
X-Gm-Message-State: AOJu0YwxaawkBgJj75Ez1blWNCivFCU42Vg8EJb96Icc5J3fpipgOutX
	C+W+gD0x6UfF7jvtl3/gdYCynnTTphUf3XEbEcUABA+1Q/PMhT2lg36IEyOmzmi68ekB5GuqIZB
	0O8ct
X-Gm-Gg: AeBDievnpAiuXu35bHfUq1qEaIWTXajP3v/3+grDnHgimu9fsFb9qGBAi1zgZTeHtzB
	TxXo5bVG8O2KZd9Nj/XXsJNNa195XNFCNYtxfzmWVyb/p/hkYmkI6iBaZvNuMOUmvWDlm4u8ssA
	GrcBC4srrxr2MmVEfo9GxxIbkIhPTrdIGwHGmnD2Zx335OJpa/bsBaXAUq9gJ6onGa/4BT0fzcR
	zaDqLx8rmA+sFo7KDVbWZGuzvOIzZ7tPZrKU18LwaS83Sbnns7L7WrAKFI/vzN7wdHoi8BVAZEI
	VnrKK9cU8OIf3tPYa3yvyKkaRUN3vbB5Ff9B7Xdr5xbdLuZjzoSyk0FRS62iY01U9r/8i2jrLOG
	KfoFEu7+GKZXf3nlq2OPMBDCDvIaVn9LBlrlLSshHXrMiGuCJc1OXb+n4eIHV+eW2OSiwaVRrO6
	DaD2hTPUMWkpJHKNT1/ZoT9UVpG8hsCmINR2tktDNnoSMTffWX6lJUDdSIUplAatXp9gadysmx+
	zV1Rj8Ki11nNF/F7Csvfi85tO8V/RsHiiuXLCSrG1SHFua4ONsgd9I40jDVF/y5gkjqHn0/CU0=
X-Received: by 2002:a05:620a:2916:b0:8cd:7b0d:a6a5 with SMTP id af79cd13be357-8f7d75487d4mr1159428985a.19.1777477213254;
        Wed, 29 Apr 2026 08:40:13 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940340f1csm207924185a.44.2026.04.29.08.40.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:40:12 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 04/13] aircrack-ng: Upgrade to 1.7
Date: Wed, 29 Apr 2026 11:39:34 -0400
Message-ID: <1792ae2762fc869e2762da670bb7793527dc9c89.1777476608.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777476608.git.scott.murray@konsulko.com>
References: <cover.1777476608.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 15:40:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3876

Upgrade to the latest release, 1.7, and rework recipe so that it
actually builds again.  Note that the extra scripts are no longer
installed by default as they seem somewhat stale and likely further
work is required to have any of them work.  A PACKAGECONFIG option,
"ext-scripts" has been added to enable installing them if they are
required for some reason.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...001-Remove-build-directory-reference.patch | 79 +++++++++++++++++++
 .../aircrack-ng/aircrack-ng_1.6.bb            | 36 ---------
 .../aircrack-ng/aircrack-ng_1.7.bb            | 54 +++++++++++++
 3 files changed, 133 insertions(+), 36 deletions(-)
 create mode 100644 recipes-security/aircrack-ng/aircrack-ng/0001-Remove-build-directory-reference.patch
 delete mode 100644 recipes-security/aircrack-ng/aircrack-ng_1.6.bb
 create mode 100644 recipes-security/aircrack-ng/aircrack-ng_1.7.bb

diff --git a/recipes-security/aircrack-ng/aircrack-ng/0001-Remove-build-directory-reference.patch b/recipes-security/aircrack-ng/aircrack-ng/0001-Remove-build-directory-reference.patch
new file mode 100644
index 0000000..335a420
--- /dev/null
+++ b/recipes-security/aircrack-ng/aircrack-ng/0001-Remove-build-directory-reference.patch
@@ -0,0 +1,79 @@
+From 3101dcd56c19112c6b6e4378886cdfdae7001304 Mon Sep 17 00:00:00 2001
+From: Scott Murray <scott.murray@konsulko.com>
+Date: Sun, 26 Apr 2026 02:10:06 +0300
+Subject: [PATCH] Remove build directory reference
+
+Remove logic in crypto engine loader code that tries to detect
+running inside a build tree to remove the resulting reference
+to the absolute build directoy path in the binary.
+
+Upstream-Status: Inappropriate [OE-specific]
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ lib/libac/support/crypto_engine_loader.c | 40 +++++-------------------
+ 1 file changed, 7 insertions(+), 33 deletions(-)
+
+diff --git a/lib/libac/support/crypto_engine_loader.c b/lib/libac/support/crypto_engine_loader.c
+index 0ec02e7..f9f9cfd 100644
+--- a/lib/libac/support/crypto_engine_loader.c
++++ b/lib/libac/support/crypto_engine_loader.c
+@@ -251,26 +251,13 @@ EXPORT int ac_crypto_engine_loader_get_available(void)
+ #endif
+ 	REQUIRE(working_directory != NULL);
+ 
+-	if (strncmp(working_directory, ABS_TOP_BUILDDIR, strlen(ABS_TOP_BUILDDIR))
+-		== 0)
+-	{
+-		// use development paths
+-		snprintf(library_path,
+-				 sizeof(library_path) - 1,
+-				 "%s%s",
+-				 LIBAIRCRACK_CE_WPA_PATH,
+-				 LT_OBJDIR);
+-	}
+-	else
+-	{
+ #if defined(WIN32_PORTABLE)
+-		// use the current directory
+-		snprintf(library_path, sizeof(library_path) - 1, working_directory);
++	// use the current directory
++	snprintf(library_path, sizeof(library_path) - 1, working_directory);
+ #else
+-		// use installation paths
+-		snprintf(library_path, sizeof(library_path) - 1, "%s", LIBDIR);
++	// use installation paths
++	snprintf(library_path, sizeof(library_path) - 1, "%s", LIBDIR);
+ #endif
+-	}
+ 	free(working_directory);
+ 
+ 	// enumerate all DSOs in folder, opening, searching symbols, and testing
+@@ -353,22 +340,9 @@ EXPORT char * ac_crypto_engine_loader_best_library_for(int simd_features)
+ 		= get_current_working_directory(); // or the binary's path?
+ 	REQUIRE(working_directory != NULL);
+ 
+-	if (strncmp(
+-			working_directory, ABS_TOP_BUILDDIR, sizeof(ABS_TOP_BUILDDIR) - 1)
+-		== 0)
+-	{
+-		// use development paths
+-		snprintf(library_path,
+-				 sizeof(library_path) - 1,
+-				 "%s%s",
+-				 LIBAIRCRACK_CE_WPA_PATH,
+-				 LT_OBJDIR);
+-	}
+-	else
+-	{
+-		// use installation paths
+-		snprintf(library_path, sizeof(library_path) - 1, "%s", LIBDIR);
+-	}
++	// use installation paths
++	snprintf(library_path, sizeof(library_path) - 1, "%s", LIBDIR);
++
+ 	free(working_directory);
+ 
+ #if defined(WIN32_PORTABLE)
+-- 
+2.47.3
+
diff --git a/recipes-security/aircrack-ng/aircrack-ng_1.6.bb b/recipes-security/aircrack-ng/aircrack-ng_1.6.bb
deleted file mode 100644
index d3722c0..0000000
--- a/recipes-security/aircrack-ng/aircrack-ng_1.6.bb
+++ /dev/null
@@ -1,36 +0,0 @@
-SUMMARY = "Aircrack-ng is a set of tools for auditing wireless networks"
-DESCRIPTION = "Aircrack-ng is an 802.11 WEP and WPA-PSK keys cracking program that can recover keys once enough data packets have been captured. It implements the standard FMS attack along with some optimizations like KoreK attacks, as well as the PTW attack, thus making the attack much faster compared to other WEP cracking tools."
-SECTION = "security"
-LICENSE = "GPL-2.0-only"
-
-LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=1fbd81241fe252ec0f5658a521ab7dd8"
-
-DEPENDS = "libnl openssl sqlite3 libpcre libpcap"
-
-SRC_URI = "http://download.aircrack-ng.org/${BP}.tar.gz"
-
-SRC_URI[md5sum] = "22ddc85549b51ed0da0931d01ef215e5"
-SRC_URI[sha256sum] = "4f0bfd486efc6ea7229f7fbc54340ff8b2094a0d73e9f617e0a39f878999a247"
-
-inherit autotools-brokensep pkgconfig
-
-PACKAGECONFIG ?= ""
-CFLAGS += " -I${S}/src/include"
-
-OEMAKE_EXTRA = "sqlite=true experimental=true pcre=true \
-                prefix=${prefix} \
-                "
-
-do_compile () {
-    make ${OEMAKE_EXTRA} TOOL_PREFIX=${TARGET_SYS}-
-}
-
-do_install () {
-    make DESTDIR=${D} ${OEMAKE_EXTRA} ext_scripts=true install
-}
-
-FILES:${PN} += "${libdir}/*.so"
-FILES_SOLIBSDEV = ""
-INSANE_SKIP:${PN} += "dev-so"
-
-RDEPENDS:${PN} = "libpcap"
diff --git a/recipes-security/aircrack-ng/aircrack-ng_1.7.bb b/recipes-security/aircrack-ng/aircrack-ng_1.7.bb
new file mode 100644
index 0000000..c2144be
--- /dev/null
+++ b/recipes-security/aircrack-ng/aircrack-ng_1.7.bb
@@ -0,0 +1,54 @@
+SUMMARY = "Aircrack-ng is a set of tools for auditing wireless networks"
+DESCRIPTION = "Aircrack-ng is an 802.11 WEP and WPA-PSK keys cracking program that can recover keys once enough data packets have been captured. It implements the standard FMS attack along with some optimizations like KoreK attacks, as well as the PTW attack, thus making the attack much faster compared to other WEP cracking tools."
+SECTION = "security"
+LICENSE = "GPL-2.0-only"
+
+LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=1fbd81241fe252ec0f5658a521ab7dd8"
+
+DEPENDS = "libnl openssl libpcap"
+
+SRC_URI = "http://download.aircrack-ng.org/${BP}.tar.gz \
+           file://0001-Remove-build-directory-reference.patch \
+"
+SRC_URI[sha256sum] = "05a704e3c8f7792a17315080a21214a4448fd2452c1b0dd5226a3a55f90b58c3"
+
+inherit autotools-brokensep pkgconfig python3targetconfig
+
+PACKAGECONFIG ??= "pcre sqlite3 experimental"
+
+PACKAGECONFIG[pcre] = ",,libpcre"
+PACKAGECONFIG[sqlite3] = "--with-sqlite3=${STAGING_DIR_HOST}${prefix},--with-sqlite3=no,sqlite3"
+PACKAGECONFIG[experimental] = "--with-experimental=yes,--with-experimental=no"
+PACKAGECONFIG[ext-scripts] = "--with-ext-scripts=yes,--with-ext-scripts=no,python3-setuptools-native,ethtool python3 python3-requests"
+
+# pcap is theoretically optional, but is not unless the configure script is modified
+EXTRA_OECONF = " \
+    --with-libpcap-include=${STAGING_INCDIR}/pcap \
+    ac_cv_prog_ETHTOOL=${bindir}/ethtool \
+"
+
+EXTRA_OEMAKE = "pkgpythondir=${PYTHON_SITEPACKAGES_DIR}"
+
+do_install:append() {
+    # Remove to avoid TMPDIR leakage
+    rm -f ${D}${PYTHON_SITEPACKAGES_DIR}/airdrop-ng-install_files.txt
+    rm -f ${D}${PYTHON_SITEPACKAGES_DIR}/airgraph-ng-install_files.txt
+    rm -rf ${D}${PYTHON_SITEPACKAGES_DIR}/airdrop/__pycache__/
+    rm -rf ${D}${PYTHON_SITEPACKAGES_DIR}/airgraphviz/__pycache__/
+
+    # Fix up Python paths for target
+    for f in airdrop-ng airgraph-ng airodump-join; do
+        if [ -f "${D}${bindir}/$f" ]; then
+            sed -i -e 's,${PYTHON},/usr/bin/env python3,g' ${D}${bindir}/$f
+        fi
+    done
+
+}
+
+FILES:${PN} += " \
+    ${libdir}/*.so \
+    ${datadir}/airgraph-ng/ \
+    ${PYTHON_SITEPACKAGES_DIR} \
+"
+FILES_SOLIBSDEV = ""
+INSANE_SKIP:${PN} += "dev-so"
-- 
2.53.0


