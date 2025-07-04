Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE8CC83F09
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 17:12:08 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web11.1107.1751649118287495016
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:11:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bFvXBFES;
 spf=pass (domain: konsulko.com, ip: 209.85.160.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a44b9b2af8so6691771cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 10:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751649117; x=1752253917; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzBOAP0wooPATnmkWbdqygk3pa5qIz7QrMIxoB6/zY0=;
        b=bFvXBFESyyKbpArysPeQMgdb9DdMT5q7HjbvCukMwJVRmlueKCMS70nZjYdA5pLEzt
         TRkSGxDjwVajf6xCnoC0SVeFRURVen4XkyT4ySo6Be/rT6dSIZmEfN7yCms48DF5+mRU
         FPTYP0fXBCp81CA8IzzvJD1UAJjnO3C16NL2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649117; x=1752253917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzBOAP0wooPATnmkWbdqygk3pa5qIz7QrMIxoB6/zY0=;
        b=Htsh2nySqWWJW1ht53rhEKw1PW1kggwAi8OVDy53Rj1L2Y5wdSD9UFNYQlODyXMxbz
         cNoqKUjr6K1LHu1wT1m1JokVUfdVYGx98QJ/Ke73PJ4qFMZ1tbI2Z3U82fJBdZud7nzc
         xz4Z5TOlZMdWYDlCrFsKCPSUTP1CRP/zO3frvC9Q092xmUG4hmvM4NzVsHQRjLMfn0Wg
         DpIWrnm5GBHol+sWODNty7SXxPxbBdRzItOPc8/0rC4iJyD55j925E/lmK3r8mqneGcb
         6qEOAg3E7tkkgUN+Q0ONfwO9jcCV6tQJSWzpC0a1nMJbaVrvZ7Uzufg2zPEtOrrHuVZv
         M9yQ==
X-Gm-Message-State: AOJu0YynzHFXvl5twSVhh6ZLCbRJX1yLHagJCkkFSyOZhi1fvTEs0XGP
	J3pddZEzCLfaI+gxk7Ozeb2/hioREUs/OTbEgWm4k9cqfMyKOpdljUdVcf8JJtq0T3ABZWf9x+y
	9hkDR
X-Gm-Gg: ASbGncsQjUdxYtIi4KqQlqLh/eLFo/JCP3idP4fkqExS/uqfMRyuYOubLP4hMPm2RlL
	L/8DB8fPdampZ4i4ZHuUmPKVxsKg7jphaqUh1SX+UXabwHlGCd1UERpv2OsK2v04gDJ51CMXuY4
	iXV79k967ZBHxgUk9ckHJHdS5NqHzNI2rxKhZfqEj96fMbYOwMT/SGIA5CRV/Jh9Gy/cbm+LFB3
	qPb2lnCTZdhiV0Kv6cMPJHblGxgfcUKbOjL0JSRbsfePe4UqoTkTn5TM7jjLC1wp949TW/42RlT
	HM3qMrnHCll69gj2SQLFZJDs4UNCuAUmwdCuv0ZuZK0x5dco7JC98DFO42pSjo/2nKLvGmbDHKD
	WQtge2gGSypRz5t5N9JHvgTSBh+kppSRyVN7q2Q==
X-Google-Smtp-Source: AGHT+IEsKfVTTzn8Tw7O3+pICOQ64l37OgR+q94MF/evG2nLqKXujovuEV+QB62Mr95zuc/4O7oxSw==
X-Received: by 2002:a05:622a:6088:b0:4a4:3766:3180 with SMTP id d75a77b69052e-4a99887a536mr41585431cf.47.1751649116791;
        Fri, 04 Jul 2025 10:11:56 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949f99dcsm17249611cf.19.2025.07.04.10.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:11:56 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Scott Murray <scott.murray@konsulko.com>
Subject: [meta-security][PATCH 08/12] libhoth: update to latest
Date: Fri,  4 Jul 2025 13:11:12 -0400
Message-ID: <d1d23b0c5c1567ab07571e845a16a06f07ffc5fc.1751647559.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751647559.git.scott.murray@konsulko.com>
References: <cover.1751647559.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:12:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1760

Update libhoth SRCREV to its latest commit, and add patches to fix
gcc 15 and build dependency issues.  Since the last update was
so long ago, the changelog is longer than seems reasonable to
include here, please refer to:

https://github.com/google/libhoth/commits/main/?since=2024-01-16&until=2025-07-03

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../0001-Fix-building-with-gcc-15.patch       | 151 ++++++++++++++++++
 ...02-Fix-building-without-dbus-backend.patch |  36 +++++
 meta-tpm/recipes-tpm1/hoth/libhoth_git.bb     |  11 +-
 3 files changed, 196 insertions(+), 2 deletions(-)
 create mode 100644 meta-tpm/recipes-tpm1/hoth/libhoth/0001-Fix-building-with-gcc-15.patch
 create mode 100644 meta-tpm/recipes-tpm1/hoth/libhoth/0002-Fix-building-without-dbus-backend.patch

diff --git a/meta-tpm/recipes-tpm1/hoth/libhoth/0001-Fix-building-with-gcc-15.patch b/meta-tpm/recipes-tpm1/hoth/libhoth/0001-Fix-building-with-gcc-15.patch
new file mode 100644
index 0000000..5004c66
--- /dev/null
+++ b/meta-tpm/recipes-tpm1/hoth/libhoth/0001-Fix-building-with-gcc-15.patch
@@ -0,0 +1,151 @@
+From 59dfffdb03654e004d848e8f6639ba066f7786a1 Mon Sep 17 00:00:00 2001
+From: Scott Murray <scott.murray@konsulko.com>
+Date: Thu, 3 Jul 2025 17:41:16 -0400
+Subject: [PATCH 1/2] Fix building with gcc 15
+
+Correct function signatures of a few of the htool command functions
+to fix gcc 15 errors from incompatible function pointer types.
+
+Upstream-Status: Pending
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ examples/htool_key_rotation.c   | 6 +++---
+ examples/htool_key_rotation.h   | 6 +++---
+ examples/htool_payload.c        | 2 +-
+ examples/htool_payload.h        | 2 +-
+ examples/htool_payload_update.c | 2 +-
+ examples/htool_payload_update.h | 2 +-
+ examples/htool_statistics.c     | 2 +-
+ examples/htool_statistics.h     | 3 ++-
+ 8 files changed, 13 insertions(+), 12 deletions(-)
+
+diff --git a/examples/htool_key_rotation.c b/examples/htool_key_rotation.c
+index af7ef59..3b938cd 100644
+--- a/examples/htool_key_rotation.c
++++ b/examples/htool_key_rotation.c
+@@ -43,7 +43,7 @@ static const char *get_validation_method_string(uint32_t validation_method) {
+   }
+ }
+ 
+-int htool_key_rotation_get_status(void) {
++int htool_key_rotation_get_status(const struct htool_invocation* inv) {
+   struct libhoth_device *dev = htool_libhoth_device();
+   if (!dev) {
+     return -1;
+@@ -65,7 +65,7 @@ int htool_key_rotation_get_status(void) {
+   return 0;
+ }
+ 
+-int htool_key_rotation_get_version(void) {
++int htool_key_rotation_get_version(const struct htool_invocation* inv) {
+   struct libhoth_device *dev = htool_libhoth_device();
+   if (!dev) {
+     return -1;
+@@ -161,7 +161,7 @@ int htool_key_rotation_update(const struct htool_invocation *inv) {
+   return result;
+ }
+ 
+-int htool_key_rotation_payload_status() {
++int htool_key_rotation_payload_status(const struct htool_invocation* inv) {
+   struct libhoth_device *dev = htool_libhoth_device();
+   if (!dev) {
+     return -1;
+diff --git a/examples/htool_key_rotation.h b/examples/htool_key_rotation.h
+index 1dbfc02..cbcde98 100644
+--- a/examples/htool_key_rotation.h
++++ b/examples/htool_key_rotation.h
+@@ -23,9 +23,9 @@ extern "C" {
+ #endif
+ 
+ struct htool_invocation;
+-int htool_key_rotation_get_status();
+-int htool_key_rotation_get_version();
+-int htool_key_rotation_payload_status();
++int htool_key_rotation_get_status(const struct htool_invocation* inv);
++int htool_key_rotation_get_version(const struct htool_invocation* inv);
++int htool_key_rotation_payload_status(const struct htool_invocation* inv);
+ int htool_key_rotation_read(const struct htool_invocation* inv);
+ int htool_key_rotation_read_chunk_type(const struct htool_invocation* inv);
+ int htool_key_rotation_update(const struct htool_invocation* inv);
+diff --git a/examples/htool_payload.c b/examples/htool_payload.c
+index cada560..5a87660 100644
+--- a/examples/htool_payload.c
++++ b/examples/htool_payload.c
+@@ -29,7 +29,7 @@
+ #include "protocol/payload_info.h"
+ #include "protocol/payload_status.h"
+ 
+-int htool_payload_status() {
++int htool_payload_status(const struct htool_invocation* inv) {
+   struct libhoth_device* dev = htool_libhoth_device();
+   if (!dev) {
+     return -1;
+diff --git a/examples/htool_payload.h b/examples/htool_payload.h
+index f218034..82c77ac 100644
+--- a/examples/htool_payload.h
++++ b/examples/htool_payload.h
+@@ -24,7 +24,7 @@
+ extern "C" {
+ #endif
+ 
+-int htool_payload_status();
++int htool_payload_status(const struct htool_invocation* inv);
+ int htool_payload_info(const struct htool_invocation* inv);
+ 
+ #ifdef __cplusplus
+diff --git a/examples/htool_payload_update.c b/examples/htool_payload_update.c
+index 8e3beb3..6cf44f1 100644
+--- a/examples/htool_payload_update.c
++++ b/examples/htool_payload_update.c
+@@ -125,7 +125,7 @@ const char *payload_update_getstatus_half_string(uint8_t h) {
+   }
+ }
+ 
+-int htool_payload_update_getstatus() {
++int htool_payload_update_getstatus(const struct htool_invocation* inv) {
+   struct libhoth_device *dev = htool_libhoth_device();
+   if (!dev) {
+     return -1;
+diff --git a/examples/htool_payload_update.h b/examples/htool_payload_update.h
+index f87c5e7..55c6b44 100644
+--- a/examples/htool_payload_update.h
++++ b/examples/htool_payload_update.h
+@@ -24,7 +24,7 @@ extern "C" {
+ 
+ struct htool_invocation;
+ int htool_payload_update(const struct htool_invocation* inv);
+-int htool_payload_update_getstatus();
++int htool_payload_update_getstatus(const struct htool_invocation* inv);
+ 
+ #ifdef __cplusplus
+ }
+diff --git a/examples/htool_statistics.c b/examples/htool_statistics.c
+index 4c5b536..6bca31a 100644
+--- a/examples/htool_statistics.c
++++ b/examples/htool_statistics.c
+@@ -178,7 +178,7 @@ const char* PayloadUpdateErrorToString(uint16_t reason) {
+   }
+ }
+ 
+-int htool_statistics() {
++int htool_statistics(const struct htool_invocation* inv) {
+   struct libhoth_device* dev = htool_libhoth_device();
+   if (!dev) {
+     return -1;
+diff --git a/examples/htool_statistics.h b/examples/htool_statistics.h
+index 2dd59b6..fe54eda 100644
+--- a/examples/htool_statistics.h
++++ b/examples/htool_statistics.h
+@@ -19,7 +19,8 @@
+ extern "C" {
+ #endif
+ 
+-int htool_statistics();
++struct htool_invocation;
++int htool_statistics(const struct htool_invocation* inv);
+ 
+ #ifdef __cplusplus
+ }
+-- 
+2.50.0
+
diff --git a/meta-tpm/recipes-tpm1/hoth/libhoth/0002-Fix-building-without-dbus-backend.patch b/meta-tpm/recipes-tpm1/hoth/libhoth/0002-Fix-building-without-dbus-backend.patch
new file mode 100644
index 0000000..ca98609
--- /dev/null
+++ b/meta-tpm/recipes-tpm1/hoth/libhoth/0002-Fix-building-without-dbus-backend.patch
@@ -0,0 +1,36 @@
+From ee75dcb0ea9818a10a6f7f85a3b5ee37572a3b08 Mon Sep 17 00:00:00 2001
+From: Scott Murray <scott.murray@konsulko.com>
+Date: Thu, 3 Jul 2025 17:41:50 -0400
+Subject: [PATCH 2/2] Fix building without dbus backend
+
+Move libsystemd and libcap dependencies into conditional logic for
+dbus_backend option so that building without the backend works when
+libsystemd and libcap are not available in the build environment.
+This situation occurs when building with OpenEmbedded.
+
+Upstream-Status: Pending
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ transports/meson.build | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/transports/meson.build b/transports/meson.build
+index e9f30d4..5abd103 100644
+--- a/transports/meson.build
++++ b/transports/meson.build
+@@ -9,10 +9,10 @@ transport_srcs = [
+ 
+ incdir = include_directories('..')
+ libusb = dependency('libusb-1.0')
+-libsystemd = dependency('libsystemd')
+-libcap = dependency('libcap')
+ 
+ if get_option('dbus_backend')
++    libsystemd = dependency('libsystemd')
++    libcap = dependency('libcap')
+     libhoth_dbus = static_library(
+         'hoth_dbus',
+         'libhoth_dbus.c',
+-- 
+2.50.0
+
diff --git a/meta-tpm/recipes-tpm1/hoth/libhoth_git.bb b/meta-tpm/recipes-tpm1/hoth/libhoth_git.bb
index 9d29f78..2608acf 100644
--- a/meta-tpm/recipes-tpm1/hoth/libhoth_git.bb
+++ b/meta-tpm/recipes-tpm1/hoth/libhoth_git.bb
@@ -6,10 +6,17 @@ HOMEPAGE = "https://github.com/google/libhoth"
 LICENSE = "Apache-2.0"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
 
-SRC_URI = "git://github.com/google/libhoth;protocol=https;branch=main"
-SRCREV = "e4827163741e0804f12ac96c81b8e97649be6795"
+SRC_URI = "git://github.com/google/libhoth;protocol=https;branch=main \
+           file://0001-Fix-building-with-gcc-15.patch \
+           file://0002-Fix-building-without-dbus-backend.patch \
+"
+SRCREV = "69661d3ea542604353c48a00beee9a6247b27686"
 
 DEPENDS += "libusb1"
 
 inherit pkgconfig meson
 
+PACKAGECONFIG ?= "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'dbus', '', d)}"
+
+PACKAGECONFIG[dbus] = "-Ddbus_backend=true,-Ddbus_backend=false,systemd libcap"
+
-- 
2.50.0


