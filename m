Return-Path: <schonm@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DF6C369B2
	for <webhook@archiver.kernel.org>; Tue, 15 Apr 2025 02:25:00 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
 by mx.groups.io with SMTP id smtpd.web10.11340.1744683896989181487
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Apr 2025 19:24:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=K47bN/Pp;
 spf=pass (domain: gmail.com, ip: 209.85.128.180, mailfrom: schonm@gmail.com)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fedefb1c9cso42992577b3.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 14 Apr 2025 19:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744683896; x=1745288696; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Iu+PnML96ipRauArFUPlL1aQIsdmqeJrbfl95boz9Q=;
        b=K47bN/PpvG85Dg4uYqwx1W0PxK2RoS11MKXe6rlfmI42zwc979vGJxbpufA0o5eABk
         TbpQQxiQDPSg3gZZoAqOn+5wDkIYSI+3BccXbLFS3s9D597IOKWLfEnCp1PAAgRRG+ep
         d0eUn7uYPgeMRvfwMRSNHzX1X1tU7ADqsyngKMYIP8ep3LhMl6MeaKJk/owqtJVfqKdj
         x0lrJBethmEJ34mO/eeaSvc5G1X6Qv4b+6zgV6jnO2hzigwXTbW3ZPOI8UTRh+GfCIxh
         KMFCGe30M3pv8X2GW5ELIDUrGJy29KI8RfJhUG1bIn1+WvS3oAcqT4DceG9uiEh95o7G
         FSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744683896; x=1745288696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Iu+PnML96ipRauArFUPlL1aQIsdmqeJrbfl95boz9Q=;
        b=mh301UWvJ7tHZCTNPIu4MzH4mn5Houh45Z4DTrMSePReSXoX8Kdv7HKfVm5qIqdYmA
         y09nbLhj1Ed/fTChW10yXFMytSeVegY8iD2HUsywxE8z5+45/d9X5obxX2dH4qBEzBo5
         z5vRnpyf/Ffvg00vsQT2HD49F/InTCXgbXW39o2UOEtBk4DEXl8zK89c9TzyP0F5segf
         nGWDUCIm3K66wUrxvXzqbn3Ehpj3lJUs2w+GmAijGmn/VenrA3sbsQqXS4ptLNPbsTIJ
         Iop6yPjUW4qHdJNOqrxOUabwb7DBYu59xF+6rJTmZcEs+u9rYnP60FtmYnTdGSjcSIWC
         g44g==
X-Gm-Message-State: AOJu0YzcaSD7WAulz+UxNr7XdBTp0NZcG+05SSMNkWge3zJpsUDnVVAK
	He4cmDf/W+t4gkTWYnSFETWSRhC0iH5SqpDWgji5TSV7wC/jg6Xq2Q57jQft
X-Gm-Gg: ASbGncsTaZVbN86YJm57hzlc+7TNTG2Lu2MlQDoGZol7XSfHMqQlFK+cf6gsCEgZBhD
	VDwZAwkk0H3oRamNYCZ0X1ciiNoPVntIScJiCiRWv2oIrJRb5R6S3YtKXXTMKZpCkcAvAy9X+SY
	H223M0vpf12ELO9EnH/01MnyRRGI8XPNWMRbhiq8NYX8HYVWjq9aKxVfuBAx+cyZs9DadDS34ls
	h3Bp/V6qlpzdX084L33E0wBnOESdPKCXYW2E4hjD283ZVgpHonuyeVwfk6kw44/5m9xTOf4lOCe
	bdhJMrDM521WMpMId06E5RfmFCAzfn153ZR9fSAKdBpdKadW/70ikETB
X-Google-Smtp-Source: AGHT+IEf7fKDJCMSldoJSHYp/OuCP5biStlVmU269oT2UkoHloSXPbZcns/7/tmTmaHHqpafryCIuw==
X-Received: by 2002:a05:690c:67c4:b0:6f9:7fe6:9d48 with SMTP id 00721157ae682-705599a6529mr218445887b3.7.1744683895537;
        Mon, 14 Apr 2025 19:24:55 -0700 (PDT)
Received: from localhost.localdomain ([71.215.9.36])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e137cbfsm34116267b3.50.2025.04.14.19.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 19:24:55 -0700 (PDT)
From: Jason Schonberg <schonm@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jason Schonberg <schonm@gmail.com>
Subject: [meta-security][PATCH v3] Fix warning : lack of whitespace around assignment
Date: Mon, 14 Apr 2025 22:24:03 -0400
Message-ID: <20250415022440.549142-1-schonm@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 15 Apr 2025 02:25:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1366

v2 : also fix some typos while we are here.
v3 : add fixes for isic and checksecurity

Signed-off-by: Jason Schonberg <schonm@gmail.com>
---
 .../recipes-scanners/checksecurity/checksecurity_2.0.16.bb  | 2 +-
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
 recipes-security/isic/isic_0.07.bb                          | 2 +-
 recipes-security/sshguard/sshguard_2.4.3.bb                 | 4 ++--
 15 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
index 8006c9f..bc146a9 100644
--- a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
+++ b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
@@ -14,7 +14,7 @@ S = "${WORKDIR}/checksecurity-${PV}+nmu1"
 
 
 # allow for anylocal, no need to patch
-LOGDIR="/etc/checksecurity"
+LOGDIR = "/etc/checksecurity"
 
 do_compile() {
     sed -i -e "s;LOGDIR=/var/log/setuid;LOGDIR=${LOGDIR};g" ${B}/etc/check-setuid.conf
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
diff --git a/recipes-security/isic/isic_0.07.bb b/recipes-security/isic/isic_0.07.bb
index d39184e..8e0f5ce 100644
--- a/recipes-security/isic/isic_0.07.bb
+++ b/recipes-security/isic/isic_0.07.bb
@@ -17,7 +17,7 @@ SRC_URI = "http://prdownloads.sourceforge.net/isic/${BPN}-${PV}.tgz \
 SRC_URI[md5sum] = "29f70c9bde9aa9128b8f7e66a315f9a4"
 SRC_URI[sha256sum] = "e033c53e03e26a4c72b723e2a5a1c433ee70eb4d23a1ba0d7d7e14ee1a80429d"
 
-S="${UNPACKDIR}/${BPN}-${PV}"
+S = "${UNPACKDIR}/${BPN}-${PV}"
 
 inherit autotools-brokensep
 
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


