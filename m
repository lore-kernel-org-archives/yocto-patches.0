Return-Path: <ryosuke.saito@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F1CD49237
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 15:31:09 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.43775.1731943860822677359
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Nov 2024 07:31:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=i94Ag0Nt;
 spf=pass (domain: linaro.org, ip: 209.85.214.175, mailfrom: ryosuke.saito@linaro.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-211fcadd960so13307815ad.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 18 Nov 2024 07:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731943860; x=1732548660; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSrApo9R5UFMohez4ob4PVewVwLJKLrifKH2ctHMLnk=;
        b=i94Ag0NtOylR+iI9jkZOHOxFW5ViuDqfX5RGWO26A520G1CmtQh26BA+COAhbD/tgC
         6Gxw9gsNNMDcRJNlW27jV9IGB9FOyK+lFdr/RcPbMWuP45Nrh5Gl8jKNizdWHaJ7dIY6
         MmzqfNil5pG+7b5YU3kkjCPUYxs97dR3xy03GeE6w91f0pNhF771qt1kjNwZYAPKHg0Q
         HBVnXss8eyjuHX9U/ijAmhaPk5HDUfymHGNGo2zQidUYmo2ISTTT5UkYJ/fh0o+ioP5F
         gYOn3jfPxSg1hRXE1kNLu+Zklvhzoi3g/t0OKz5/aV5FoNtw8gS07I+0vZe0zwUfsmQt
         mJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731943860; x=1732548660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSrApo9R5UFMohez4ob4PVewVwLJKLrifKH2ctHMLnk=;
        b=sg1LtQ+/8heKNZgA6vH9Y5OyB9uyU90Fe6ga7LhU4L2fN3crc8FjWdIeMqDCO8tsfY
         XqO+DLPhzJXknB+wtH4GXesxTcxgKGWTN1Rs2zJ22vCrFw+GOw/gzeSyaaWbjJ0GKBC1
         TQKhoSaDju5d2yHCzNGryTULgE8tGshzN8CM/OxxYtTXQOj82uiV4QxVDwMa1lRNJTHO
         c5atOniClrTxaHYkZn9aUeg1VVR4k96UFUAYc7sLrAUBPwF8riAQZhlOXno+tR+GLJWV
         cSta25UJC3kEQkiT5Mc9sumGKXiW/SnKgggGc4/QrIC2z3oNB7PfJYrvy9gb2jA7x9Nv
         y9PQ==
X-Gm-Message-State: AOJu0YyRk/NCE1CVCuR2iwuZFHoGrSsdAF/mjOyOjIrc+2M/At6DJks+
	QXahVSrnKRpiuP8uzg1dkmt19NxrFDlCfV7zbphvZAQ8AQckcoRTD5Mhz3gKf4OWb++fs0NIdn4
	2
X-Google-Smtp-Source: AGHT+IEvGqd46S8pVZVamQTlOl05YlJ9nJ+zbQz3Wxl8D+Hz7BvsqufU4FvzYtlszyXm6h0068Mo9A==
X-Received: by 2002:a17:902:ea09:b0:212:deb:71f4 with SMTP id d9443c01a7336-2120deb7819mr62237965ad.4.1731943859966;
        Mon, 18 Nov 2024 07:30:59 -0800 (PST)
Received: from fedora.. ([240d:1a:3a7:a400:9a57:aa11:487a:b54f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770ee849sm6551628b3a.21.2024.11.18.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:30:59 -0800 (PST)
From: Ryosuke Saito <ryosuke.saito@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: raitosyo@gmail.com
Subject: [meta-cgl] [PATCH] recipes: Replace WORKDIR with UNPACKDIR
Date: Tue, 19 Nov 2024 00:30:56 +0900
Message-ID: <20241118153056.307379-1-ryosuke.saito@linaro.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Nov 2024 15:31:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/818

Use UNPACKDIR for file installation paths to ensure compatibility with
Yocto variable handling.

Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
---
 .../recipes-cgl/heartbeat/heartbeat_3.0.6.bb     |  4 ++--
 .../recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb |  4 ++--
 .../recipes-cgl/pacemaker/pacemaker_2.0.5.bb     |  4 ++--
 .../recipes-cgl/racoon2/racoon2_202003018.bb     |  6 +++---
 meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb | 16 ++++++++--------
 .../initrdscripts/initramfs-cgl-boot_1.0.bb      |  2 +-
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/meta-cgl-common/recipes-cgl/heartbeat/heartbeat_3.0.6.bb b/meta-cgl-common/recipes-cgl/heartbeat/heartbeat_3.0.6.bb
index 7b9e87532c70..27497f8afeb8 100644
--- a/meta-cgl-common/recipes-cgl/heartbeat/heartbeat_3.0.6.bb
+++ b/meta-cgl-common/recipes-cgl/heartbeat/heartbeat_3.0.6.bb
@@ -76,12 +76,12 @@ do_compile:prepend() {
     make clean
 }
 do_install:append () {
-    sed -i -e 's,/usr/lib/,${libdir}/,' ${WORKDIR}/heartbeat.service
+    sed -i -e 's,/usr/lib/,${libdir}/,' ${UNPACKDIR}/heartbeat.service
     if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
         install -d ${D}${libexecdir}
         install -m 0755 ${S}/${SOURCE1} ${D}${libexecdir}/heartbeat.init
         install -d ${D}${systemd_unitdir}/system
-        install -m 0644 ${WORKDIR}/heartbeat.service ${D}${systemd_unitdir}/system/
+        install -m 0644 ${UNPACKDIR}/heartbeat.service ${D}${systemd_unitdir}/system/
     fi
 }
 
diff --git a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
index 03a1333409aa..28b82c2cda94 100644
--- a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
+++ b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
@@ -101,10 +101,10 @@ do_install:append() {
 
     if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
         install -d ${D}/${systemd_system_unitdir}
-        install -m 0644 ${WORKDIR}/o2cb.service ${D}/${systemd_system_unitdir}
+        install -m 0644 ${UNPACKDIR}/o2cb.service ${D}/${systemd_system_unitdir}
         sed -i -e 's,@LIBDIR@,${libexecdir},' ${D}${systemd_system_unitdir}/o2cb.service
 
-        install -m 0644 ${WORKDIR}/ocfs2.service ${D}/${systemd_system_unitdir}
+        install -m 0644 ${UNPACKDIR}/ocfs2.service ${D}/${systemd_system_unitdir}
         sed -i -e 's,@LIBDIR@,${libexecdir},' ${D}${systemd_system_unitdir}/ocfs2.service
 
         install -d ${D}/${libexecdir}
diff --git a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb b/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
index 49d741e28d9d..fee5622eccba 100644
--- a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
+++ b/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
@@ -65,9 +65,9 @@ do_configure:prepend() {
 do_install:append() {
     install -d ${D}${sysconfdir}/default
     install -d ${D}${sysconfdir}/default/volatiles
-    install -m 0644 ${WORKDIR}/volatiles ${D}${sysconfdir}/default/volatiles/06_${BPN}
+    install -m 0644 ${UNPACKDIR}/volatiles ${D}${sysconfdir}/default/volatiles/06_${BPN}
     install -d ${D}${sysconfdir}/tmpfiles.d
-    install -m 0644 ${WORKDIR}/tmpfiles ${D}${sysconfdir}/tmpfiles.d/${BPN}.conf
+    install -m 0644 ${UNPACKDIR}/tmpfiles ${D}${sysconfdir}/tmpfiles.d/${BPN}.conf
 
     # Don't package some files
     find ${D} -name "*.pyo" -exec rm {} \;
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb b/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
index 0388afe2ac70..d0daa914a817 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
@@ -59,7 +59,7 @@ do_install:append() {
 
     rmdir ${D}${localstatedir}/run/racoon2 ${D}${localstatedir}/run ${D}${localstatedir}
     install -d ${D}${sysconfdir}/default/volatiles
-    install -m 0700 ${WORKDIR}/volatiles.99_racoon2 ${D}${sysconfdir}/default/volatiles/99_racoon2
+    install -m 0700 ${UNPACKDIR}/volatiles.99_racoon2 ${D}${sysconfdir}/default/volatiles/99_racoon2
     if ${@bb.utils.contains('DISTRO_FEATURES', 'krb5', 'false', 'true', d)}; then
         rm -f ${D}${sysconfdir}/init.d/kinkd ${D}${sysconfdir}/${BPN}/init.d/kinkd \
         ${D}${sysconfdir}/${BPN}/transport_kink.conf.sample ${D}${sysconfdir}/${BPN}/tunnel_kink.conf.sample
@@ -67,8 +67,8 @@ do_install:append() {
 
     # Install systemd service files
     install -d ${D}${systemd_system_unitdir}
-    install -m 0644 ${WORKDIR}/iked.service ${D}${systemd_system_unitdir}
-    install -m 0644 ${WORKDIR}/spmd.service ${D}${systemd_system_unitdir}
+    install -m 0644 ${UNPACKDIR}/iked.service ${D}${systemd_system_unitdir}
+    install -m 0644 ${UNPACKDIR}/spmd.service ${D}${systemd_system_unitdir}
     sed -i -e 's#@SBINDIR@#${sbindir}#g' -e 's,@BASE_BINDIR@,${base_bindir},g' \
         ${D}${systemd_system_unitdir}/*.service
 
diff --git a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb b/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
index 4109276ac6fb..d221814c0ea3 100644
--- a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
+++ b/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
@@ -46,22 +46,22 @@ do_configure:prepend() {
 
 do_install:append() {
     sed -i -e 's#\(UPSCRIPT=\).*#\1${libexecdir}/vip-up.sh#' \
-           -e 's#\(DOWNSCRIPT=\).*#\1${libexecdir}/vip-down.sh#' ${WORKDIR}/ucarp.init
+           -e 's#\(DOWNSCRIPT=\).*#\1${libexecdir}/vip-down.sh#' ${UNPACKDIR}/ucarp.init
 
-    install -D -m 0755 ${WORKDIR}/ucarp.init ${D}${sysconfdir}/init.d/ucarp
+    install -D -m 0755 ${UNPACKDIR}/ucarp.init ${D}${sysconfdir}/init.d/ucarp
 
     # For systemd
     if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
-        install -D -m 0755 ${WORKDIR}/ucarp.init ${D}${libexecdir}/ucarp
-        install -D -m 0644 ${WORKDIR}/ucarp.service ${D}${systemd_system_unitdir}/ucarp.service
+        install -D -m 0755 ${UNPACKDIR}/ucarp.init ${D}${libexecdir}/ucarp
+        install -D -m 0644 ${UNPACKDIR}/ucarp.service ${D}${systemd_system_unitdir}/ucarp.service
         sed -i -e 's,@LIBEXECDIR@,${libexecdir},g' ${D}${systemd_system_unitdir}/ucarp.service
     fi
 
     install -m 0755 -d ${D}${sysconfdir}/ucarp
-    install -m 0600 ${WORKDIR}/vip-001.conf.example ${D}${sysconfdir}/ucarp/vip-001.conf.example
-    install -m 0600 ${WORKDIR}/vip-common.conf ${D}${sysconfdir}/ucarp/vip-common.conf
+    install -m 0600 ${UNPACKDIR}/vip-001.conf.example ${D}${sysconfdir}/ucarp/vip-001.conf.example
+    install -m 0600 ${UNPACKDIR}/vip-common.conf ${D}${sysconfdir}/ucarp/vip-common.conf
 
     install -m 0755 -d ${D}${libexecdir}
-    install -m 0700 ${WORKDIR}/vip-up.sh ${D}${libexecdir}/vip-up.sh
-    install -m 0700 ${WORKDIR}/vip-down.sh ${D}${libexecdir}/vip-down.sh
+    install -m 0700 ${UNPACKDIR}/vip-up.sh ${D}${libexecdir}/vip-up.sh
+    install -m 0700 ${UNPACKDIR}/vip-down.sh ${D}${libexecdir}/vip-down.sh
 }
diff --git a/meta-cgl-common/recipes-core/initrdscripts/initramfs-cgl-boot_1.0.bb b/meta-cgl-common/recipes-core/initrdscripts/initramfs-cgl-boot_1.0.bb
index e022ad490ce7..ebe56ba181ce 100644
--- a/meta-cgl-common/recipes-core/initrdscripts/initramfs-cgl-boot_1.0.bb
+++ b/meta-cgl-common/recipes-core/initrdscripts/initramfs-cgl-boot_1.0.bb
@@ -5,7 +5,7 @@ SRC_URI = "file://init-boot.sh \
 "
 
 do_install() {
-        install -m 0755 ${WORKDIR}/init-boot.sh ${D}/init
+        install -m 0755 ${UNPACKDIR}/init-boot.sh ${D}/init
 }
 
 inherit allarch
-- 
2.47.0


