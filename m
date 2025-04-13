Return-Path: <schonm@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6707EC3601E
	for <webhook@archiver.kernel.org>; Sun, 13 Apr 2025 12:32:25 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web11.27828.1744547538235156291
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 13 Apr 2025 05:32:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eAAPXBQ+;
 spf=pass (domain: gmail.com, ip: 209.85.128.182, mailfrom: schonm@gmail.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f768e9be1aso48704917b3.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 13 Apr 2025 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744547537; x=1745152337; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CikmmNKsh2OMbIL19gfewCTldqyNOtgxYNy32dnhR+M=;
        b=eAAPXBQ+W4l4m8f4cfYkpdQd/j4l70iwmkwqcq8Xd7/iy4PDHPyiRhjEYSejEjAQ+U
         wLgJtwfRbuK3DuWzZBHOxTPLy7vtHXp5M8reWV/HFD5wFCwQ4bs2nnr83k/X57EWKxGR
         pHXBeCXHKGzRrNvvXViNldc6KLBT/gzmoYdhW0edzXK2X509iQ0Xk5IgLgl9YtNw9wL/
         83N8wYwJ2o1KqKspoBTetk4NNUu/A0M6gh87pFgkmFpmMHCagtGLwKQHqBcuT4EJFN1K
         NGDSqpg+mm8nZ+k591i2y8w1lucoGoPXBOBDe2CRMO+hnwaHpKAo0JDitWTzpW4UeKHG
         JL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744547537; x=1745152337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CikmmNKsh2OMbIL19gfewCTldqyNOtgxYNy32dnhR+M=;
        b=qkHD60a6ay6wCq5q5HnXE0RFMKnjzg6kHqq6cpQ6zmZVmA1aEP7FExQfOQ7QFRcmqn
         4ou3SJjjl8oGMbbZdlp+YbdS0XahYoj11NV8zqIiDJxO+KSbcTvZL2GNjHixCXJq9F//
         uGt+y59+Mc4izEjpxMKBFMqyFeDzc5oRHgeALsae4o9K/h6n7Le3muuygU04LzR0q15M
         0T8kd/oHQTB3ixRz7BWvCRP6ENx9ARjvp4PQYQ2FCASYPAPizfWo06i2LwdgOswVWvdf
         fkwN1/OV/Ls3OsrZpsiM4fMKNnHK+Xd1ck9rDGfxJXkKUml4Zy24Gx1taeRYi2YeIJJA
         Zodg==
X-Gm-Message-State: AOJu0YzHVceDCwaIXmPWCQKNO5ODxYuPKfDzIIU27N8/yI3gpJKjhph5
	UA/1wWx3e1n6levaF7/gGz6zOUYF9Fo4Gh05IrjSr1nef18jWJVIqcaHsVKM
X-Gm-Gg: ASbGncuPn1rFYJL/vhlF8rJafMoe9Btgql4PugwDJPcgSNIWxfYBhCbRGyoORsX47Ut
	TEOKlmH/OTSsTI8PBxhFy6Om473MPsQxjEIu5ztPABEPLe499x9HY7N9lsJBA7QTK1YvXjVt2hg
	fK2Afyb0DgTJ0t/7lwu3fG/Y7kT1frHYUxzO17Ynlz4xL3LrzyL0DGys3t0vljYxGDWfJcRgWtc
	hAvczb5bYvPrjyiVHnW+xkfYxeSq+XYWYtOpS6nxP2Z/gYaElXryMzXbGUMLkj9sujHRWG/6JeQ
	iCinFUZXJPSPAYGuKQx/jyzdP9/CbqTi0gIjSjxw6cjLlkkEeP30ENBw
X-Google-Smtp-Source: AGHT+IGdxvOtqWLPnc8R14PvxFSIx5Z39myCGWXhvRA7Uq7O50Ats9SaJsrW9sebBkU3SS3J/MaM2Q==
X-Received: by 2002:a81:fa0f:0:b0:6fe:ade1:fa86 with SMTP id 00721157ae682-705595b610emr113493497b3.12.1744547536720;
        Sun, 13 Apr 2025 05:32:16 -0700 (PDT)
Received: from localhost.localdomain ([71.215.9.36])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e0e6065sm24909287b3.1.2025.04.13.05.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 05:32:16 -0700 (PDT)
From: Jason Schonberg <schonm@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jason Schonberg <schonm@gmail.com>
Subject: [meta-security][PATCH v2] Fix warning : lack of whitespace around assignment
Date: Sun, 13 Apr 2025 08:31:51 -0400
Message-ID: <20250413123156.314110-1-schonm@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 13 Apr 2025 12:32:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1364

v2 : also fix some typos while we are here.

Signed-off-by: Jason Schonberg <schonm@gmail.com>
---
 .../recipes-devtools/python/python3-json2html_1.3.0.bb      | 2 +-
 .../recipes-devtools/python/python3-xmldiff_2.7.0.bb        | 2 +-
 .../recipes-devtools/python/python3-yamlpath_3.8.2.bb       | 2 +-
 .../scap-security-guide/scap-security-guide_0.1.76.bb       | 6 +++---
 recipes-ids/aide/aide_0.18.8.bb                             | 2 +-
 recipes-ids/ossec/ossec-hids_3.7.0.bb                       | 2 +-
 recipes-ids/tripwire/tripwire_2.4.3.7.bb                    | 2 +-
 recipes-kernel/lkrg/lkrg-module_0.9.7.bb                    | 2 +-
 recipes-mac/ccs-tools/ccs-tools_1.8.9.bb                    | 4 ++--
 recipes-perl/perl/libwhisker2-perl_2.5.bb                   | 2 +-
 recipes-scanners/checksec/checksec_2.6.0.bb                 | 2 +-
 recipes-security/cryptmount/cryptmount_6.2.0.bb             | 2 +-
 recipes-security/sshguard/sshguard_2.4.3.bb                 | 4 ++--
 13 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-json2html_1.3.0.bb b/dynamic-layers/meta-python/recipes-devtools/python/python3-json2html_1.3.0.bb
index 3d7e897..baf3156 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-json2html_1.3.0.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-json2html_1.3.0.bb
@@ -1,4 +1,4 @@
-DESCRIPTION="Python wrapper to convert JSON into a human readable HTML Table representation."
+DESCRIPTION = "Python wrapper to convert JSON into a human readable HTML Table representation."
 LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=8065590663ea0c10aa131841ea806767"
 
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldiff_2.7.0.bb b/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldiff_2.7.0.bb
index 9d38065..a81c252 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldiff_2.7.0.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldiff_2.7.0.bb
@@ -1,4 +1,4 @@
-DESCRIPTION="Creates diffs of XML files"
+DESCRIPTION = "Creates diffs of XML files"
 LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=0d0e9e3949e163c3edd1e097b8b0ed62"
 
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.2.bb b/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.2.bb
index e2d95ae..d496e67 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.2.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.2.bb
@@ -1,4 +1,4 @@
-DESCRIPTION="YAML Path and Command-Line Tools"
+DESCRIPTION = "YAML Path and Command-Line Tools"
 LICENSE = "ISC"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=5abda174c5040dd12ed2b225e3a096f0"
 
diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
index 73bd576..25309c7 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
@@ -21,9 +21,9 @@ B = "${S}/build"
 inherit cmake pkgconfig python3native python3targetconfig ptest
 
 STAGING_OSCAP_BUILDDIR = "${TMPDIR}/work-shared/openscap/oscap-build-artifacts"
-export OSCAP_CPE_PATH="${STAGING_OSCAP_BUILDDIR}${datadir_native}/openscap/cpe"
-export OSCAP_SCHEMA_PATH="${STAGING_OSCAP_BUILDDIR}${datadir_native}/openscap/schemas"
-export OSCAP_XSLT_PATH="${STAGING_OSCAP_BUILDDIR}${datadir_native}/openscap/xsl"
+export OSCAP_CPE_PATH = "${STAGING_OSCAP_BUILDDIR}${datadir_native}/openscap/cpe"
+export OSCAP_SCHEMA_PATH = "${STAGING_OSCAP_BUILDDIR}${datadir_native}/openscap/schemas"
+export OSCAP_XSLT_PATH = "${STAGING_OSCAP_BUILDDIR}${datadir_native}/openscap/xsl"
 
 OECMAKE_GENERATOR = "Unix Makefiles"
 
diff --git a/recipes-ids/aide/aide_0.18.8.bb b/recipes-ids/aide/aide_0.18.8.bb
index e2014a1..2912cb2 100644
--- a/recipes-ids/aide/aide_0.18.8.bb
+++ b/recipes-ids/aide/aide_0.18.8.bb
@@ -16,7 +16,7 @@ UPSTREAM_CHECK_URI = "https://github.com/${BPN}/${BPN}/releases"
 
 inherit autotools pkgconfig aide-base
 
-PACKAGECONFIG ??=" gcrypt zlib e2fsattrs posix capabilities curl pthread \
+PACKAGECONFIG ??= " gcrypt zlib e2fsattrs posix capabilities curl pthread \
                  ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux audit', '', d)} \
                  ${@bb.utils.contains('DISTRO_FEATURES', 'xattr', 'xattr', '', d)} \
                  "
diff --git a/recipes-ids/ossec/ossec-hids_3.7.0.bb b/recipes-ids/ossec/ossec-hids_3.7.0.bb
index fbd1294..d9f5121 100644
--- a/recipes-ids/ossec/ossec-hids_3.7.0.bb
+++ b/recipes-ids/ossec/ossec-hids_3.7.0.bb
@@ -18,7 +18,7 @@ inherit autotools-brokensep  useradd
 S = "${UNPACKDIR}/git"
 
 
-OSSEC_DIR="/var/ossec"
+OSSEC_DIR = "/var/ossec"
 OSSEC_UID ?= "ossec"
 OSSEC_RUID ?= "ossecr"
 OSSEC_GID ?= "ossec"
diff --git a/recipes-ids/tripwire/tripwire_2.4.3.7.bb b/recipes-ids/tripwire/tripwire_2.4.3.7.bb
index e67d3c7..3c85027 100644
--- a/recipes-ids/tripwire/tripwire_2.4.3.7.bb
+++ b/recipes-ids/tripwire/tripwire_2.4.3.7.bb
@@ -1,7 +1,7 @@
 SUMMARY = "Tripwire: A system integrity assessment tool (IDS)"
 DESCRIPTION = "Open Source Tripwire® software is a security and data \
 integrity tool useful for monitoring and alerting on specific file change(s) on a range of systems"
-HOMEPAGE="http://sourceforge.net/projects/tripwire"
+HOMEPAGE = "http://sourceforge.net/projects/tripwire"
 SECTION = "security Monitor/Admin"
 LICENSE = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://COPYING;md5=1c069be8dbbe48e89b580ab4ed86c127"
diff --git a/recipes-kernel/lkrg/lkrg-module_0.9.7.bb b/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
index 751c045..20982a8 100644
--- a/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
+++ b/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
@@ -1,5 +1,5 @@
 SUMMARY = "Linux Kernel Runtime Guard"
-DESCRIPTION="LKRG performs runtime integrity checking of the Linux \
+DESCRIPTION = "LKRG performs runtime integrity checking of the Linux \
 kernel and detection of security vulnerability exploits against the kernel."
 SECTION = "security"
 HOMEPAGE = "https://www.openwall.com/lkrg/"
diff --git a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb b/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
index a746c56..3f754e9 100644
--- a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
+++ b/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
@@ -26,7 +26,7 @@ do_install(){
     oe_runmake INSTALLDIR=${D}  USRLIBDIR=${libdir} SBINDIR=${sbindir} install
 }
 
-PACKAGE="${PN} ${PN}-dbg ${PN}-doc"
+PACKAGES = "${PN} ${PN}-dbg ${PN}-doc"
 
 FILES:${PN} = "\
     ${sbindir}/* \
@@ -46,4 +46,4 @@ FILES:${PN}-dbg = "\
     /usr/src/debug/* \
 "
 
-REQUIRED_DISTRO_FEATURES ?=" tomoyo"
+REQUIRED_DISTRO_FEATURES ?= " tomoyo"
diff --git a/recipes-perl/perl/libwhisker2-perl_2.5.bb b/recipes-perl/perl/libwhisker2-perl_2.5.bb
index 2c32bfc..e16e5f2 100644
--- a/recipes-perl/perl/libwhisker2-perl_2.5.bb
+++ b/recipes-perl/perl/libwhisker2-perl_2.5.bb
@@ -15,7 +15,7 @@ S = "${UNPACKDIR}/libwhisker2-2.5"
 
 inherit cpan-base
 
-PACKAGEGROUP ??=""
+PACKAGEGROUP ??= ""
 PACKAGEGROUP[ssl] = ", , libnet-ssleay-perl, libnet-ssleay-perl"
 
 do_install() {
diff --git a/recipes-scanners/checksec/checksec_2.6.0.bb b/recipes-scanners/checksec/checksec_2.6.0.bb
index 3712e68..4767239 100644
--- a/recipes-scanners/checksec/checksec_2.6.0.bb
+++ b/recipes-scanners/checksec/checksec_2.6.0.bb
@@ -2,7 +2,7 @@ SUMMARY = "Linux system security checks"
 DESCRIPTION = "The checksec script is designed to test what standard Linux OS and PaX security features are being used."
 SECTION = "security"
 LICENSE = "BSD-3-Clause"
-HOMEPAGE="https://github.com/slimm609/checksec.sh"
+HOMEPAGE = "https://github.com/slimm609/checksec.sh"
 
 LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=879b2147c754bc040c29e9c3b84da836"
 
diff --git a/recipes-security/cryptmount/cryptmount_6.2.0.bb b/recipes-security/cryptmount/cryptmount_6.2.0.bb
index d69d88b..424ff56 100644
--- a/recipes-security/cryptmount/cryptmount_6.2.0.bb
+++ b/recipes-security/cryptmount/cryptmount_6.2.0.bb
@@ -10,7 +10,7 @@ inherit autotools-brokensep gettext pkgconfig systemd
 
 EXTRA_OECONF = " --enable-cswap --enable-fsck --enable-argv0switch"
 
-PACKAGECONFIG ?="intl luks gcrypt nls"
+PACKAGECONFIG ?= "intl luks gcrypt nls"
 PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}"
 
 PACKAGECONFIG[systemd] = "--with-systemd, --without-systemd, systemd"
diff --git a/recipes-security/sshguard/sshguard_2.4.3.bb b/recipes-security/sshguard/sshguard_2.4.3.bb
index 37b414e..de3d856 100644
--- a/recipes-security/sshguard/sshguard_2.4.3.bb
+++ b/recipes-security/sshguard/sshguard_2.4.3.bb
@@ -1,10 +1,10 @@
-SUMARRY=" Intelligently block brute-force attacks by aggregating system logs "
+SUMMARY = " Intelligently block brute-force attacks by aggregating system logs "
 HOMEPAGE = "https://www.sshguard.net/"
 LIC_FILES_CHKSUM = "file://COPYING;md5=47a33fc98cd20713882c4d822a57bf4d"
 LICENSE = "BSD-1-Clause"
 
 
-SRC_URI="https://sourceforge.net/projects/sshguard/files/sshguard/${PV}/sshguard-${PV}.tar.gz"
+SRC_URI = "https://sourceforge.net/projects/sshguard/files/sshguard/${PV}/sshguard-${PV}.tar.gz"
 
 SRC_URI[sha256sum] = "64029deff6de90fdeefb1f497d414f0e4045076693a91da1a70eb7595e97efeb"
 
-- 
2.43.0


