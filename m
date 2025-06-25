Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA91C7EE31
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 20:10:52 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.25781.1750882251658380835
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Jun 2025 13:10:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=LvWn8bLP;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fabe9446a0so4222596d6.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1750882250; x=1751487050; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRy1OqSVuT0mLM2k3CqITnPNq/MH+HGgrLHVWtBbffA=;
        b=LvWn8bLPj3WMReM8xg1CLjXmrfTMdtWaJimNZSNA6HcSi8pixfVADFmqlncwOdxEhh
         HfsReBlGkw0wSApV7BRIItP6K0UDBpNsY0c80Xk3pvv8rBfAsvTjo2LqBrBwu6p1PpcC
         ZeRqENTohwi+KuzAYKPli5HlFBqWgz7PU4+EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750882250; x=1751487050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRy1OqSVuT0mLM2k3CqITnPNq/MH+HGgrLHVWtBbffA=;
        b=cCfNP9YcK5+/KdX1yva8A3H9kGdWrAxYtj3K2EOvk0alItKRXfSAvN7Ac8jTzqzuM0
         lV7MXVZfQ/vnz66kGvorIaQkVmuSqIRovFtT9kij8Eoe5eJkMjmqOZHxis7Ti6IzcUew
         Hg8KsgHOiN0/9wv/5C0ZSmOGtwGKcuYNZ+7M0rSZihnTHOBngDv/VKtzb/hgPtf14qYO
         iiY+TCPAN8jNiNnD3V34rqzpuSZS2j5p2DrxO5nv9Cy5GU8RBzOewT18a0PpOJ5EMamT
         wOnsgNHG4WspwLF5qXboBJQtIIXKBvytd+8cTlmSSe9ZTd8PNmTUFUzpWvz9leqOIChy
         nA/Q==
X-Gm-Message-State: AOJu0Yxv9dliIoOR4YpxI1d7KzvSc1sT8ayr5ozJcCXN2whdVVuDnxtC
	tsvLvQq/aFJTO0ftsse8JTfkoJg1Y6eRBhTkKWN1MMDNQmiBXL4Zg8QoU1ws3CWFBOPkGPBYVTV
	WM6Ps
X-Gm-Gg: ASbGncv3oCkBF1OAMfzl3oFj212S1jL30bwEk73Mi8ZvUP4Mbs7FPKq86XSFGoToTx7
	UD+nDfeh0KdQN6QTrP6sXS4EC1rkidDJj+/56d2EmKDHrUAhRFeUlSpG6SixbWdLVd92xQk04Hj
	tUcKEqiKkYoZ+jlpH3no+tJmAUXftr0xTv5YeLwC14RBfVpeLqDF3KW5GCAHnDZjg+1JWHbCAPE
	pOZS89sOnBFG71+M0Qeu240JXyQtzJXNN8RtHNj19jFvkmGgyT3R9iN6ZXae7OdXrXXNRmidIOr
	tKX94l9yxx/Mb/BeRRU0rMuCrKs6mhxdU7DGgmd/ZIX95YxV3ureUMlkKc6xYSf6jXjD77MnOf2
	QuQfy9Gg779di8gAZeb+fTaflAtAQ0SspJt7JKQ==
X-Google-Smtp-Source: AGHT+IFvcxoGDgJx6s5lHf5jHVMT23gFhhnL6t6jdVo8qYn962FYHQY8XN0IAOk9aNIyGizJkO/gmw==
X-Received: by 2002:a05:6214:d0f:b0:6fd:4b21:f2bf with SMTP id 6a1803df08f44-6fd5ee846a8mr67497936d6.0.1750882250307;
        Wed, 25 Jun 2025 13:10:50 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093e0578sm72299646d6.10.2025.06.25.13.10.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:10:49 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH 2/2] Adapt to UNPACKDIR changes
Date: Wed, 25 Jun 2025 16:10:34 -0400
Message-ID: <848dd8066de86d3feeb520ef49e902548743fcdd.1750882005.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750882005.git.scott.murray@konsulko.com>
References: <cover.1750882005.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 20:10:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1694

Remove or update S definitions as required to work with oe-core
S/UNPACKDIR changes. The three packagegroups test build successfully
with these changes.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/refpolicy/refpolicy_common.inc     | 2 +-
 recipes-security/selinux-scripts/selinux-initsh.inc | 3 +--
 recipes-security/selinux/checkpolicy_3.8.1.bb       | 2 --
 recipes-security/selinux/libselinux-python_3.8.1.bb | 2 +-
 recipes-security/selinux/libselinux_3.8.1.bb        | 2 --
 recipes-security/selinux/libsemanage_3.8.1.bb       | 2 --
 recipes-security/selinux/libsepol_3.8.1.bb          | 2 --
 recipes-security/selinux/mcstrans_3.8.1.bb          | 2 --
 recipes-security/selinux/policycoreutils_3.8.1.bb   | 2 --
 recipes-security/selinux/restorecond_3.8.1.bb       | 2 --
 recipes-security/selinux/secilc_3.8.1.bb            | 2 --
 recipes-security/selinux/selinux-dbus_3.8.1.bb      | 2 +-
 recipes-security/selinux/selinux-gui_3.8.1.bb       | 2 +-
 recipes-security/selinux/selinux-python_3.8.1.bb    | 2 +-
 recipes-security/selinux/selinux-sandbox_3.8.1.bb   | 2 +-
 recipes-security/selinux/selinux_common.inc         | 2 ++
 recipes-security/selinux/semodule-utils_3.8.1.bb    | 2 --
 recipes-security/setools/setools_4.5.1.bb           | 2 --
 18 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 0661e6c..736e67b 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -75,7 +75,7 @@ SRC_URI += " \
         file://0057-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         "
 
-S = "${WORKDIR}/refpolicy"
+S = "${UNPACKDIR}/refpolicy"
 
 CONFFILES:${PN} = "${sysconfdir}/selinux/config"
 FILES:${PN} += " \
diff --git a/recipes-security/selinux-scripts/selinux-initsh.inc b/recipes-security/selinux-scripts/selinux-initsh.inc
index efe7e88..1fc1ec1 100644
--- a/recipes-security/selinux-scripts/selinux-initsh.inc
+++ b/recipes-security/selinux-scripts/selinux-initsh.inc
@@ -1,5 +1,4 @@
-S ?= "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
+S = "${UNPACKDIR}"
 
 SECTION ?= "base"
 
diff --git a/recipes-security/selinux/checkpolicy_3.8.1.bb b/recipes-security/selinux/checkpolicy_3.8.1.bb
index 60f506d..7ee9269 100644
--- a/recipes-security/selinux/checkpolicy_3.8.1.bb
+++ b/recipes-security/selinux/checkpolicy_3.8.1.bb
@@ -13,8 +13,6 @@ require selinux_common.inc
 
 DEPENDS = "libsepol bison-native"
 
-S = "${WORKDIR}/git/checkpolicy"
-
 do_install:append() {
     install test/dismod ${D}/${bindir}/sedismod
     install test/dispol ${D}/${bindir}/sedispol
diff --git a/recipes-security/selinux/libselinux-python_3.8.1.bb b/recipes-security/selinux/libselinux-python_3.8.1.bb
index 3c5c489..dd0ccd2 100644
--- a/recipes-security/selinux/libselinux-python_3.8.1.bb
+++ b/recipes-security/selinux/libselinux-python_3.8.1.bb
@@ -17,7 +17,7 @@ SRC_URI += "\
         file://0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch \
         "
 
-S = "${WORKDIR}/git/libselinux"
+S = "${UNPACKDIR}/${BP}/libselinux"
 
 DEPENDS = "libsepol libpcre2 swig-native python3-setuptools-scm-native"
 DEPENDS:append:libc-musl = " fts"
diff --git a/recipes-security/selinux/libselinux_3.8.1.bb b/recipes-security/selinux/libselinux_3.8.1.bb
index b0dcde6..d58d646 100644
--- a/recipes-security/selinux/libselinux_3.8.1.bb
+++ b/recipes-security/selinux/libselinux_3.8.1.bb
@@ -15,8 +15,6 @@ SRC_URI += "\
         file://0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch \
         "
 
-S = "${WORKDIR}/git/libselinux"
-
 DEPENDS = "libsepol libpcre2"
 DEPENDS:append:libc-musl = " fts"
 
diff --git a/recipes-security/selinux/libsemanage_3.8.1.bb b/recipes-security/selinux/libsemanage_3.8.1.bb
index ef22957..9f825cd 100644
--- a/recipes-security/selinux/libsemanage_3.8.1.bb
+++ b/recipes-security/selinux/libsemanage_3.8.1.bb
@@ -20,8 +20,6 @@ DEPENDS = "libsepol libselinux python3 bison-native swig-native"
 
 DEPENDS:append:class-target = " audit"
 
-S = "${WORKDIR}/git/libsemanage"
-
 EXTRA_OEMAKE:class-native = "DISABLE_AUDIT=y"
 
 PACKAGES =+ "${PN}-python"
diff --git a/recipes-security/selinux/libsepol_3.8.1.bb b/recipes-security/selinux/libsepol_3.8.1.bb
index 0c28e9b..0423a2a 100644
--- a/recipes-security/selinux/libsepol_3.8.1.bb
+++ b/recipes-security/selinux/libsepol_3.8.1.bb
@@ -11,8 +11,6 @@ require selinux_common.inc
 
 inherit lib_package
 
-S = "${WORKDIR}/git/libsepol"
-
 DEPENDS = "flex-native"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-security/selinux/mcstrans_3.8.1.bb b/recipes-security/selinux/mcstrans_3.8.1.bb
index 4c8aed3..964a566 100644
--- a/recipes-security/selinux/mcstrans_3.8.1.bb
+++ b/recipes-security/selinux/mcstrans_3.8.1.bb
@@ -22,8 +22,6 @@ EXTRA_OEMAKE = "SBINDIR=${base_sbindir} \
                 SYSTEMDDIR=${systemd_unitdir} \
                "
 
-S = "${WORKDIR}/git/mcstrans"
-
 do_install:append() {
     install -d ${D}${sbindir}
     install -m 755 utils/untranscon ${D}${sbindir}/
diff --git a/recipes-security/selinux/policycoreutils_3.8.1.bb b/recipes-security/selinux/policycoreutils_3.8.1.bb
index 9e59c4b..5a67c3b 100644
--- a/recipes-security/selinux/policycoreutils_3.8.1.bb
+++ b/recipes-security/selinux/policycoreutils_3.8.1.bb
@@ -21,8 +21,6 @@ PAM_SRC_URI = "file://pam.d/newrole \
 DEPENDS = "libsepol libselinux libsemanage gettext-native"
 DEPENDS:append:class-target = " libcap-ng"
 
-S = "${WORKDIR}/git/policycoreutils"
-
 inherit selinux python3native
 
 RDEPENDS:${PN}-fixfiles = "\
diff --git a/recipes-security/selinux/restorecond_3.8.1.bb b/recipes-security/selinux/restorecond_3.8.1.bb
index 8e57283..e3746b6 100644
--- a/recipes-security/selinux/restorecond_3.8.1.bb
+++ b/recipes-security/selinux/restorecond_3.8.1.bb
@@ -18,8 +18,6 @@ EXTRA_OEMAKE = "SYSTEMDSYSTEMUNITDIR=${systemd_system_unitdir} \
                  SYSTEMDUSERUNITDIR=${systemd_user_unitdir} \
                 "
 
-S = "${WORKDIR}/git/restorecond"
-
 FILES:${PN} += "${datadir}/dbus-1/services/org.selinux.Restorecond.service \
                 ${systemd_user_unitdir}/* \
                "
diff --git a/recipes-security/selinux/secilc_3.8.1.bb b/recipes-security/selinux/secilc_3.8.1.bb
index 5e0da3f..efe046b 100644
--- a/recipes-security/selinux/secilc_3.8.1.bb
+++ b/recipes-security/selinux/secilc_3.8.1.bb
@@ -10,6 +10,4 @@ require selinux_common.inc
 
 DEPENDS = "libsepol xmlto-native"
 
-S = "${WORKDIR}/git/secilc"
-
 BBCLASSEXTEND = "native"
diff --git a/recipes-security/selinux/selinux-dbus_3.8.1.bb b/recipes-security/selinux/selinux-dbus_3.8.1.bb
index b1198af..972f36a 100644
--- a/recipes-security/selinux/selinux-dbus_3.8.1.bb
+++ b/recipes-security/selinux/selinux-dbus_3.8.1.bb
@@ -7,7 +7,7 @@ LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=393a5ca445f6965873eca0259a17f833"
 
 require selinux_common.inc
 
-S = "${WORKDIR}/git/dbus"
+S = "${UNPACKDIR}/${BP}/dbus"
 
 RDEPENDS:${PN} = "python3-core selinux-python-sepolicy"
 
diff --git a/recipes-security/selinux/selinux-gui_3.8.1.bb b/recipes-security/selinux/selinux-gui_3.8.1.bb
index fbd5e70..22175cc 100644
--- a/recipes-security/selinux/selinux-gui_3.8.1.bb
+++ b/recipes-security/selinux/selinux-gui_3.8.1.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=393a5ca445f6965873eca0259a17f833"
 
 require selinux_common.inc
 
-S = "${WORKDIR}/git/gui"
+S = "${UNPACKDIR}/${BP}/gui"
 
 DEPENDS = "gettext-native"
 RDEPENDS:${PN} = "python3-core"
diff --git a/recipes-security/selinux/selinux-python_3.8.1.bb b/recipes-security/selinux/selinux-python_3.8.1.bb
index e2dc932..5a4e2d6 100644
--- a/recipes-security/selinux/selinux-python_3.8.1.bb
+++ b/recipes-security/selinux/selinux-python_3.8.1.bb
@@ -14,7 +14,7 @@ SRC_URI += "file://fix-sepolicy-install-path.patch \
             file://0001-sepolicy-set-conf.substitutions-releasever-to-empty-.patch \
            "
 
-S = "${WORKDIR}/git/python"
+S = "${UNPACKDIR}/${BP}/python"
 
 DEPENDS = "libsepol libselinux gettext-native python3-setuptools-scm-native"
 
diff --git a/recipes-security/selinux/selinux-sandbox_3.8.1.bb b/recipes-security/selinux/selinux-sandbox_3.8.1.bb
index 2cb55d6..d0db69b 100644
--- a/recipes-security/selinux/selinux-sandbox_3.8.1.bb
+++ b/recipes-security/selinux/selinux-sandbox_3.8.1.bb
@@ -12,7 +12,7 @@ require selinux_common.inc
 SRC_URI += "file://sandbox-de-bashify.patch \
            "
 
-S = "${WORKDIR}/git/sandbox"
+S = "${UNPACKDIR}/${BP}/sandbox"
 
 DEPENDS = "libselinux libcap-ng gettext-native"
 
diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security/selinux/selinux_common.inc
index 63b048b..c2aa3b8 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -3,6 +3,8 @@ HOMEPAGE = "https://github.com/SELinuxProject"
 SRC_URI = "git://github.com/SELinuxProject/selinux.git;branch=main;protocol=https"
 SRCREV = "8e9157bbeea1899b7b8b257e7eaa71efef3fffed"
 
+S = "${UNPACKDIR}/${BP}/${BPN}"
+
 UPSTREAM_CHECK_GITTAGREGEX = "(?P<pver>\d+(\.\d+)+)"
 
 do_compile() {
diff --git a/recipes-security/selinux/semodule-utils_3.8.1.bb b/recipes-security/selinux/semodule-utils_3.8.1.bb
index 0c1c189..2015811 100644
--- a/recipes-security/selinux/semodule-utils_3.8.1.bb
+++ b/recipes-security/selinux/semodule-utils_3.8.1.bb
@@ -10,8 +10,6 @@ require selinux_common.inc
 
 DEPENDS = "libsepol"
 
-S = "${WORKDIR}/git/semodule-utils"
-
 PACKAGES =+ "\
         ${PN}-semodule-expand \
         ${PN}-semodule-link \
diff --git a/recipes-security/setools/setools_4.5.1.bb b/recipes-security/setools/setools_4.5.1.bb
index 723eeb0..c9d0bb3 100644
--- a/recipes-security/setools/setools_4.5.1.bb
+++ b/recipes-security/setools/setools_4.5.1.bb
@@ -14,8 +14,6 @@ LIC_FILES_CHKSUM = "file://${S}/COPYING;md5=69a7b68f0a4a570d7c0c43465333ecbc \
                     file://${S}/COPYING.GPL;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
                     file://${S}/COPYING.LGPL;md5=4fbd65380cdd255951079008b364516c"
 
-S = "${WORKDIR}/git"
-
 DEPENDS = "libsepol libselinux"
 
 RDEPENDS:${PN} = "python3-networkx python3-logging libselinux-python"
-- 
2.49.0


