Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4011C3DA49
	for <webhook@archiver.kernel.org>; Tue, 23 Jul 2024 12:02:41 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
 by mx.groups.io with SMTP id smtpd.web10.42391.1721736161149053688
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jul 2024 05:02:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=K2GnhWuq;
 spf=pass (domain: gmail.com, ip: 209.85.128.179, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-66599ca3470so54526007b3.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jul 2024 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721736160; x=1722340960; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8da1gnf4pljZTkxzNpXb49GyBxsM6SiMvNP9jld3tE4=;
        b=K2GnhWuqu4FBaIB4ozr7u5m7HIjKVZ7zSYWss9gV+lLBTsMOMHMxtIS/uCBiqL7y2+
         Knqo8hw4exSe8uIj4H+E+jn+7BzM8Rc2lLEEReilXeKDTfchxit7u7L7MhRv8VoSa+kH
         Z5ijejsAuyIhtLfYUda8XA77o0OujUdbZfzK0TwTBUvvYK9G3DpXwZgLejXbX2nNQTIS
         6jwBug0MOrSd/+pyJzPEe9A/lA3VGTI6+TlT6i/H5kjkZ473l2o7QiunCaEEFq0+kXjI
         S9lP6FoXN4EQ9w1sAMxHJTGIhzbh8NuRz+MfKtZMXcbivi4RgjUmZidhn7ev/Q062Z+K
         fdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721736160; x=1722340960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8da1gnf4pljZTkxzNpXb49GyBxsM6SiMvNP9jld3tE4=;
        b=TCrGrB0oozLqjG8RE5N7wiQckmMorup8fG0/OJhd8m5awcwHYi23D5P1+esauPtNzw
         mxpmRRMIVT3hK9afMTFMPK9Yvb8tBkuagRz9pthEYbUqoqSxNc3JzdYXqVKBqtiKVk+X
         imFG8XSUAWDVbeCunXmGETopEHYSf30A4KCDkhHlbDgEwqgjV/kVIFrSLvsh+p9RBYCM
         VaG611FQ+QgwK4d9cX5cjPumORkZAMtu0kVzABn0h9hwWTWTbzjQ7MayoV/sy7tuYNQF
         7SdMOnw6djLxCdrenJ3VqrTsWPhaneih91OgorSG5dDLKvoP38wbhhBl8Y8kZK9Akooo
         NwUA==
X-Gm-Message-State: AOJu0YwrOnYJV1UgC7ry00aKKdg+X3l5XtcRzWwYWCbn+jmSc0fY0Dg4
	schuQ6+mfanTUaDaqKH7ZhKd6HHELeUFsXuHILF4U9hCe2UFnEwOplc85A==
X-Google-Smtp-Source: AGHT+IFnrp6kzicFueb0kOlFL/bR4KXffM1aVTtLkcACgzM7kNOvmyadQzrVC7vifym0u9jgS/xTAA==
X-Received: by 2002:a05:690c:4244:b0:646:ebea:1da2 with SMTP id 00721157ae682-66a688a53b5mr111345937b3.38.1721736159240;
        Tue, 23 Jul 2024 05:02:39 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66953bd4f9csm19650427b3.103.2024.07.23.05.02.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 05:02:38 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] recipes-*: convert WORKDIR->UNPACKDIR
Date: Tue, 23 Jul 2024 08:02:37 -0400
Message-Id: <20240723120237.1550700-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jul 2024 12:02:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/446

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 recipes-compliance/lynis/lynis_3.1.1.bb            |  2 +-
 recipes-compliance/openscap/openscap_1.3.10.bb     |  2 +-
 .../scap-security-guide_0.1.73.bb                  |  4 ++--
 recipes-ids/aide/aide_0.17.4.bb                    |  4 ++--
 recipes-ids/crowdsec/crowdsec_1.1.1.bb             |  2 +-
 recipes-ids/ossec/ossec-hids_3.7.0.bb              |  2 +-
 recipes-ids/samhain/samhain.inc                    |  4 ++--
 recipes-ids/suricata/libhtp_0.5.45.bb              |  4 ++--
 recipes-ids/suricata/suricata_7.0.0.bb             |  4 ++--
 recipes-ids/tripwire/tripwire_2.4.3.7.bb           | 14 +++++++-------
 recipes-kernel/lkrg/lkrg-module_0.9.7.bb           |  2 +-
 recipes-mac/AppArmor/apparmor_3.1.3.bb             |  2 +-
 recipes-mac/ccs-tools/ccs-tools_1.8.9.bb           |  2 +-
 recipes-perl/perl/lib-perl_0.63.bb                 |  2 +-
 recipes-perl/perl/libwhisker2-perl_2.5.bb          |  2 +-
 recipes-scanners/arpwatch/arpwatch_3.3.bb          |  6 +++---
 .../buck-security/buck-security_0.7.bb             |  2 +-
 recipes-scanners/checksec/checksec_2.6.0.bb        |  2 +-
 recipes-scanners/clamav/clamav_0.104.4.bb          | 10 +++++-----
 recipes-security/Firejail/firejail_0.9.72.bb       |  2 +-
 recipes-security/chipsec/chipsec_1.9.1.bb          |  2 +-
 recipes-security/fscrypt/fscrypt_1.1.0.bb          |  4 ++--
 recipes-security/fscryptctl/fscryptctl_1.1.0.bb    |  2 +-
 recipes-security/glome/glome_git.bb                |  2 +-
 .../google-authenticator-libpam_1.09.bb            |  2 +-
 recipes-security/isic/isic_0.07.bb                 |  2 +-
 recipes-security/krill/krill_0.12.3.bb             |  2 +-
 recipes-security/libest/libest_3.2.0.bb            |  2 +-
 recipes-security/libmhash/libmhash_0.9.9.9.bb      |  2 +-
 recipes-security/libmspack/libmspack_1.11.bb       |  2 +-
 recipes-security/ncrack/ncrack_0.7.bb              |  2 +-
 31 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/recipes-compliance/lynis/lynis_3.1.1.bb b/recipes-compliance/lynis/lynis_3.1.1.bb
index b69f4df..f6fddd0 100644
--- a/recipes-compliance/lynis/lynis_3.1.1.bb
+++ b/recipes-compliance/lynis/lynis_3.1.1.bb
@@ -12,7 +12,7 @@ SRC_URI[sha256sum] = "d72f4ee7325816bb8dbfcf31eb104207b9fe58a2493c2a875373746a71
 
 #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
 
-S = "${WORKDIR}/${BPN}"
+S = "${UNPACKDIR}/${BPN}"
 
 inherit autotools-brokensep
 
diff --git a/recipes-compliance/openscap/openscap_1.3.10.bb b/recipes-compliance/openscap/openscap_1.3.10.bb
index c439d71..5433573 100644
--- a/recipes-compliance/openscap/openscap_1.3.10.bb
+++ b/recipes-compliance/openscap/openscap_1.3.10.bb
@@ -15,7 +15,7 @@ SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=maint-1.3;protocol=http
            file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
           "
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 inherit cmake pkgconfig python3native python3targetconfig perlnative systemd
 
diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
index 539b6cf..0396b0f 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
@@ -15,7 +15,7 @@ SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=
 
 DEPENDS = "openscap-native python3-pyyaml-native python3-jinja2-native libxml2-native expat-native coreutils-native"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 B = "${S}/build"
 
 inherit cmake pkgconfig python3native python3targetconfig ptest
@@ -54,7 +54,7 @@ do_install_ptest() {
     do
        sed -e 's#${HOSTTOOLS_DIR}/##g' \
            -e 's#${RECIPE_SYSROOT_NATIVE}##g' \
-           -e 's#${WORKDIR}#${PTEST_PATH}#g' \
+           -e 's#${UNPACKDIR}#${PTEST_PATH}#g' \
            -e 's#/.*/xmllint#/usr/bin/xmllint#g' \
            -e 's#/.*/oscap#/usr/bin/oscap#g' \
            -e 's#/python3-native##g' \
diff --git a/recipes-ids/aide/aide_0.17.4.bb b/recipes-ids/aide/aide_0.17.4.bb
index 52ddc43..9d998cc 100644
--- a/recipes-ids/aide/aide_0.17.4.bb
+++ b/recipes-ids/aide/aide_0.17.4.bb
@@ -35,7 +35,7 @@ do_install[nostamp] = "1"
 do_install:append () {
     install -d ${D}${libdir}/${PN}/logs   
     install -d ${D}${sysconfdir}   
-    install ${WORKDIR}/aide.conf ${D}${sysconfdir}/
+    install ${UNPACKDIR}/aide.conf ${D}${sysconfdir}/
 
     for dir in ${AIDE_INCLUDE_DIRS}; do
         echo "${dir} NORMAL" >> ${D}${sysconfdir}/aide.conf
@@ -50,7 +50,7 @@ do_install:class-native () {
     install -d ${STAGING_AIDE_DIR}/lib/logs
 
     install ${B}/aide ${STAGING_AIDE_DIR}/bin
-    install ${WORKDIR}/aide.conf ${STAGING_AIDE_DIR}/
+    install ${UNPACKDIR}/aide.conf ${STAGING_AIDE_DIR}/
 
     sed -i -s "s:\@\@define DBDIR.*:\@\@define DBDIR ${STAGING_AIDE_DIR}/lib:" ${STAGING_AIDE_DIR}/aide.conf
     sed -i -e "s:\@\@define LOGDIR.*:\@\@define LOGDIR ${STAGING_AIDE_DIR}/lib/logs:" ${STAGING_AIDE_DIR}/aide.conf
diff --git a/recipes-ids/crowdsec/crowdsec_1.1.1.bb b/recipes-ids/crowdsec/crowdsec_1.1.1.bb
index 81f2b8f..deccecf 100644
--- a/recipes-ids/crowdsec/crowdsec_1.1.1.bb
+++ b/recipes-ids/crowdsec/crowdsec_1.1.1.bb
@@ -12,7 +12,7 @@ GO_IMPORT = "import"
 
 inherit go
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 do_compile() {
     export GOARCH="${TARGET_GOARCH}"
diff --git a/recipes-ids/ossec/ossec-hids_3.7.0.bb b/recipes-ids/ossec/ossec-hids_3.7.0.bb
index 829715b..fbd1294 100644
--- a/recipes-ids/ossec/ossec-hids_3.7.0.bb
+++ b/recipes-ids/ossec/ossec-hids_3.7.0.bb
@@ -15,7 +15,7 @@ UPSTREAM_CHECK_COMMITS = "1"
 
 inherit autotools-brokensep  useradd
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 
 OSSEC_DIR="/var/ossec"
diff --git a/recipes-ids/samhain/samhain.inc b/recipes-ids/samhain/samhain.inc
index 61ec0da..65e6734 100644
--- a/recipes-ids/samhain/samhain.inc
+++ b/recipes-ids/samhain/samhain.inc
@@ -26,7 +26,7 @@ SRC_URI[sha256sum] = "ae6ee8eff3cb111b7fc14a57bcc258443dd0bcf1bfacfdf229935ed053
 UPSTREAM_CHECK_URI = "https://www.la-samhna.de/samhain/archive.html"
 UPSTREAM_CHECK_REGEX = "samhain_signed-(?P<pver>(\d+(\.\d+)+))\.tar"
 
-S = "${WORKDIR}/samhain-${PV}"
+S = "${UNPACKDIR}/samhain-${PV}"
 
 inherit autotools-brokensep update-rc.d pkgconfig systemd
 
@@ -65,7 +65,7 @@ EXTRA_OEMAKE:append:mips64 = " CPPFLAGS+=-DCONFIG_ARCH_MIPS64=1"
 
 do_unpack_samhain() {
     cd ${UNPACKDIR}
-    tar -xzvf samhain-${PV}.tar.gz -C ${WORKDIR}
+    tar -xzvf samhain-${PV}.tar.gz -C ${UNPACKDIR}
 }
 
 python do_unpack:append() {
diff --git a/recipes-ids/suricata/libhtp_0.5.45.bb b/recipes-ids/suricata/libhtp_0.5.45.bb
index cc8285c..4273e78 100644
--- a/recipes-ids/suricata/libhtp_0.5.45.bb
+++ b/recipes-ids/suricata/libhtp_0.5.45.bb
@@ -13,9 +13,9 @@ inherit autotools-brokensep pkgconfig
 
 CFLAGS += "-D_DEFAULT_SOURCE"
 
-#S = "${WORKDIR}/suricata-${VER}/${BPN}"
+#S = "${UNPACKDIR}/suricata-${VER}/${BPN}"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 do_configure () {
     cd ${S}
diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index 1f3b694..a137498 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -96,7 +96,7 @@ do_install () {
 
     if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
         install -d ${D}${sysconfdir}/tmpfiles.d
-        install -m 0644 ${WORKDIR}/tmpfiles.suricata ${D}${sysconfdir}/tmpfiles.d/suricata.conf
+        install -m 0644 ${UNPACKDIR}/tmpfiles.suricata ${D}${sysconfdir}/tmpfiles.d/suricata.conf
 
         install -d ${D}${systemd_unitdir}/system
         sed  -e s:/etc:${sysconfdir}:g \
@@ -105,7 +105,7 @@ do_install () {
              -e s:/usr/bin:${bindir}:g \
              -e s:/bin/kill:${base_bindir}/kill:g \
              -e s:/usr/lib:${libdir}:g \
-             ${WORKDIR}/suricata.service > ${D}${systemd_unitdir}/system/suricata.service
+             ${UNPACKDIR}/suricata.service > ${D}${systemd_unitdir}/system/suricata.service
     fi
 
     # Remove /var/run as it is created on startup
diff --git a/recipes-ids/tripwire/tripwire_2.4.3.7.bb b/recipes-ids/tripwire/tripwire_2.4.3.7.bb
index 9149e89..e67d3c7 100644
--- a/recipes-ids/tripwire/tripwire_2.4.3.7.bb
+++ b/recipes-ids/tripwire/tripwire_2.4.3.7.bb
@@ -19,7 +19,7 @@ SRC_URI = "\
 	file://run-ptest \
        "
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 inherit autotools-brokensep update-rc.d ptest
 
@@ -43,11 +43,11 @@ do_install () {
     install -m 0755 ${S}/bin/* ${D}${sbindir}
     install -m 0644 ${S}/lib/* ${D}${base_libdir}
     install -m 0644 ${S}/lib/* ${D}${localstatedir}/lib/${PN}
-    install -m 0755 ${WORKDIR}/tripwire.cron ${D}${sysconfdir}
-    install -m 0755 ${WORKDIR}/tripwire.sh ${D}${sysconfdir}/init.d/tripwire
-    install -m 0755 ${WORKDIR}/twinstall.sh ${D}${sysconfdir}/${PN}
-    install -m 0644 ${WORKDIR}/twpol-yocto.txt ${D}${sysconfdir}/${PN}/twpol.txt
-    install -m 0644 ${WORKDIR}/twcfg.txt ${D}${sysconfdir}/${PN}
+    install -m 0755 ${UNPACKDIR}/tripwire.cron ${D}${sysconfdir}
+    install -m 0755 ${UNPACKDIR}/tripwire.sh ${D}${sysconfdir}/init.d/tripwire
+    install -m 0755 ${UNPACKDIR}/twinstall.sh ${D}${sysconfdir}/${PN}
+    install -m 0644 ${UNPACKDIR}/twpol-yocto.txt ${D}${sysconfdir}/${PN}/twpol.txt
+    install -m 0644 ${UNPACKDIR}/twcfg.txt ${D}${sysconfdir}/${PN}
 
     install -m 0644 ${S}/man/man4/* ${D}${mandir}/man4
     install -m 0644 ${S}/man/man5/* ${D}${mandir}/man5
@@ -57,7 +57,7 @@ do_install () {
     install -m 0644 ${S}/policy/*txt ${D}${docdir}/${BPN}
     install -m 0644 ${S}/COPYING ${D}${docdir}/${BPN}
     install -m 0644 ${S}/TRADEMARK ${D}${docdir}/${BPN}
-    install -m 0644 ${WORKDIR}/tripwire.txt ${D}${docdir}/${BPN}
+    install -m 0644 ${UNPACKDIR}/tripwire.txt ${D}${docdir}/${BPN}
 }
 
 do_install_ptest:append () {
diff --git a/recipes-kernel/lkrg/lkrg-module_0.9.7.bb b/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
index 020c3a1..751c045 100644
--- a/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
+++ b/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
@@ -13,7 +13,7 @@ SRC_URI = "git://github.com/lkrg-org/lkrg.git;protocol=https;branch=main"
 
 SRCREV = "5dc5cfea1f4dc8febdd5274d99e277c17df06acc"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 inherit module kernel-module-split
 
diff --git a/recipes-mac/AppArmor/apparmor_3.1.3.bb b/recipes-mac/AppArmor/apparmor_3.1.3.bb
index fd649e4..27c518c 100644
--- a/recipes-mac/AppArmor/apparmor_3.1.3.bb
+++ b/recipes-mac/AppArmor/apparmor_3.1.3.bb
@@ -22,7 +22,7 @@ SRC_URI = " \
     "
 
 SRCREV = "e69cb5047946818e6a9df326851483bb075a5cfe"
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 PARALLEL_MAKE = ""
 
diff --git a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb b/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
index 8185e51..a746c56 100644
--- a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
+++ b/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
@@ -12,7 +12,7 @@ SRC_URI = "http://osdn.dl.sourceforge.jp/tomoyo/49693/${BPN}-${PV}-${DS}.tar.gz"
 
 SRC_URI[sha256sum] = "7900126cf2dd8706c42c2c1ef7a37fd8b50f1505abd7d9c3d653dc390fb4d620"
 
-S = "${WORKDIR}/${BPN}"
+S = "${UNPACKDIR}/${BPN}"
 
 inherit features_check
 
diff --git a/recipes-perl/perl/lib-perl_0.63.bb b/recipes-perl/perl/lib-perl_0.63.bb
index 25d0890..6fc44e4 100644
--- a/recipes-perl/perl/lib-perl_0.63.bb
+++ b/recipes-perl/perl/lib-perl_0.63.bb
@@ -16,7 +16,7 @@ SRC_URI = "http://www.cpan.org/authors/id/S/SM/SMUELLER/lib-${PV}.tar.gz"
 SRC_URI[md5sum] = "8607ac4e0d9d43585ec28312f52df67c"
 SRC_URI[sha256sum] = "72f63db9220098e834d7a38231626bd0c9b802c1ec54a628e2df35f3818e5a00"
 
-S = "${WORKDIR}/lib-${PV}"
+S = "${UNPACKDIR}/lib-${PV}"
 
 EXTRA_CPANFLAGS = "EXPATLIBPATH=${STAGING_LIBDIR} EXPATINCPATH=${STAGING_INCDIR}"
 
diff --git a/recipes-perl/perl/libwhisker2-perl_2.5.bb b/recipes-perl/perl/libwhisker2-perl_2.5.bb
index c58d883..2c32bfc 100644
--- a/recipes-perl/perl/libwhisker2-perl_2.5.bb
+++ b/recipes-perl/perl/libwhisker2-perl_2.5.bb
@@ -11,7 +11,7 @@ SRC_URI = "http://sourceforge.net/projects/whisker/files/libwhisker/${PV}/libwhi
 SRC_URI[md5sum] = "7cc1718dddde8f9a439d5622ae2f37eb"
 SRC_URI[sha256sum] = "f45a1cf2ad2637b29dd1b13d7221ea12e3923ea09d107ced446400f19070a42f"
 
-S = "${WORKDIR}/libwhisker2-2.5"
+S = "${UNPACKDIR}/libwhisker2-2.5"
 
 inherit cpan-base
 
diff --git a/recipes-scanners/arpwatch/arpwatch_3.3.bb b/recipes-scanners/arpwatch/arpwatch_3.3.bb
index e547938..cacfea7 100644
--- a/recipes-scanners/arpwatch/arpwatch_3.3.bb
+++ b/recipes-scanners/arpwatch/arpwatch_3.3.bb
@@ -60,9 +60,9 @@ do_install () {
     install -d ${D}/var/lib/arpwatch
 
     oe_runmake install DESTDIR=${D}
-    install -m 644 ${WORKDIR}/arpwatch.conf  ${D}${sysconfdir}
-    install -m 655 ${WORKDIR}/arpwatch_init  ${D}${sysconfdir}/init.d/arpwatch
-    install -m 644 ${WORKDIR}/arpwatch.default  ${D}${sysconfdir}/default
+    install -m 644 ${UNPACKDIR}/arpwatch.conf  ${D}${sysconfdir}
+    install -m 655 ${UNPACKDIR}/arpwatch_init  ${D}${sysconfdir}/init.d/arpwatch
+    install -m 644 ${UNPACKDIR}/arpwatch.default  ${D}${sysconfdir}/default
 }
 
 INITSCRIPT_NAME = "arpwatch"
diff --git a/recipes-scanners/buck-security/buck-security_0.7.bb b/recipes-scanners/buck-security/buck-security_0.7.bb
index 85884a7..5d4de10 100644
--- a/recipes-scanners/buck-security/buck-security_0.7.bb
+++ b/recipes-scanners/buck-security/buck-security_0.7.bb
@@ -10,7 +10,7 @@ SRC_URI = "http://sourceforge.net/projects/buck-security/files/buck-security/buc
 SRC_URI[md5sum] = "611a3e9bb7ed8a8270aa15216c321c53"
 SRC_URI[sha256sum] = "c533c6631ec3554dd8d39d2d1c3ed44badbbf50810ebb75469c74639fa294b01"
 
-S = "${WORKDIR}/${BPN}_${PV}"
+S = "${UNPACKDIR}/${BPN}_${PV}"
 
 do_configure[noexec] = "1"
 do_compile[noexec] = "1"
diff --git a/recipes-scanners/checksec/checksec_2.6.0.bb b/recipes-scanners/checksec/checksec_2.6.0.bb
index 1ba3721..3712e68 100644
--- a/recipes-scanners/checksec/checksec_2.6.0.bb
+++ b/recipes-scanners/checksec/checksec_2.6.0.bb
@@ -9,7 +9,7 @@ LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=879b2147c754bc040c29e9c3b84da836"
 SRCREV = "2753ebb89fcdc96433ae8a4c4e5a49214a845be2"
 SRC_URI = "git://github.com/slimm609/checksec.sh;branch=main;protocol=https"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 do_install() {
     install -d ${D}${bindir}
diff --git a/recipes-scanners/clamav/clamav_0.104.4.bb b/recipes-scanners/clamav/clamav_0.104.4.bb
index 102f267..48cc75c 100644
--- a/recipes-scanners/clamav/clamav_0.104.4.bb
+++ b/recipes-scanners/clamav/clamav_0.104.4.bb
@@ -21,7 +21,7 @@ SRC_URI = "git://github.com/Cisco-Talos/clamav;branch=rel/0.104;protocol=https \
     file://headers_fixup.patch \
     file://oe_cmake_fixup.patch \
 "
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 LEAD_SONAME = "libclamav.so"
 SO_VER = "9.6.0"
@@ -58,9 +58,9 @@ do_install:append () {
     install -d -o ${PN} -g ${CLAMAV_GID} ${D}/${localstatedir}/lib/clamav
     install -d ${D}${sysconfdir}/clamav ${D}${sysconfdir}/default/volatiles
 
-    install -m 644 ${WORKDIR}/clamd.conf ${D}/${prefix}/${sysconfdir}
-    install -m 644 ${WORKDIR}/freshclam.conf ${D}/${prefix}/${sysconfdir}
-    install -m 0644 ${WORKDIR}/volatiles.03_clamav  ${D}${sysconfdir}/default/volatiles/03_clamav
+    install -m 644 ${UNPACKDIR}/clamd.conf ${D}/${prefix}/${sysconfdir}
+    install -m 644 ${UNPACKDIR}/freshclam.conf ${D}/${prefix}/${sysconfdir}
+    install -m 0644 ${UNPACKDIR}/volatiles.03_clamav  ${D}${sysconfdir}/default/volatiles/03_clamav
     sed -i -e 's#${STAGING_DIR_HOST}##g' ${D}${libdir}/pkgconfig/libclamav.pc
     rm ${D}/${libdir}/libclamav.so
     if [ "${INSTALL_CLAMAV_CVD}" = "1" ]; then
@@ -71,7 +71,7 @@ do_install:append () {
 
     if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)};then
         install -d ${D}${sysconfdir}/tmpfiles.d
-        install -m 0644 ${WORKDIR}/tmpfiles.clamav ${D}${sysconfdir}/tmpfiles.d/clamav.conf
+        install -m 0644 ${UNPACKDIR}/tmpfiles.clamav ${D}${sysconfdir}/tmpfiles.d/clamav.conf
     fi
     oe_multilib_header clamav-types.h
 }
diff --git a/recipes-security/Firejail/firejail_0.9.72.bb b/recipes-security/Firejail/firejail_0.9.72.bb
index 5713f46..10023c1 100644
--- a/recipes-security/Firejail/firejail_0.9.72.bb
+++ b/recipes-security/Firejail/firejail_0.9.72.bb
@@ -16,7 +16,7 @@ SRC_URI = "git://github.com/netblue30/firejail.git;protocol=https;branch=master
 
 DEPENDS = "libseccomp"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 inherit autotools-brokensep pkgconfig bash-completion features_check
 
diff --git a/recipes-security/chipsec/chipsec_1.9.1.bb b/recipes-security/chipsec/chipsec_1.9.1.bb
index 9fbdaa7..24451f8 100644
--- a/recipes-security/chipsec/chipsec_1.9.1.bb
+++ b/recipes-security/chipsec/chipsec_1.9.1.bb
@@ -12,7 +12,7 @@ DEPENDS = "virtual/kernel nasm-native"
 SRC_URI = "git://github.com/chipsec/chipsec.git;branch=main;protocol=https"
 SRCREV = "d8c2a606bf440c32196c6289a7a458f3ae3107cc"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 inherit module setuptools3
 
diff --git a/recipes-security/fscrypt/fscrypt_1.1.0.bb b/recipes-security/fscrypt/fscrypt_1.1.0.bb
index ea9593b..c620c6e 100644
--- a/recipes-security/fscrypt/fscrypt_1.1.0.bb
+++ b/recipes-security/fscrypt/fscrypt_1.1.0.bb
@@ -20,12 +20,12 @@ inherit go goarch features_check
 
 REQUIRED_DISTRO_FEATURES = "pam"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 do_compile() {
 	export GOARCH=${TARGET_GOARCH}
 	export GOROOT="${STAGING_LIBDIR_NATIVE}/${TARGET_SYS}/go"
-	export GOPATH="${WORKDIR}/git"
+	export GOPATH="${UNPACKDIR}/git"
 
 	# Pass the needed cflags/ldflags so that cgo
 	# can find the needed headers files and libraries
diff --git a/recipes-security/fscryptctl/fscryptctl_1.1.0.bb b/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
index 3de2bfa..cf03a18 100644
--- a/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
+++ b/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
@@ -12,7 +12,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
 SRCREV = "7c80c73c084ce9ea49a03b814dac7a82fd7b4c23"
 SRC_URI = "git://github.com/google/fscryptctl.git;branch=master;protocol=https"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 do_compile:prepend() {
     sed -i 's/fscryptctl\.1//g' ${S}/Makefile
diff --git a/recipes-security/glome/glome_git.bb b/recipes-security/glome/glome_git.bb
index 8787ddc..b99239e 100644
--- a/recipes-security/glome/glome_git.bb
+++ b/recipes-security/glome/glome_git.bb
@@ -10,7 +10,7 @@ inherit meson pkgconfig
 
 DEPENDS += "openssl"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 SRC_URI = "git://github.com/google/glome.git;branch=master;protocol=https"
 SRCREV = "48d28f82bd51ae4bccc84fbbee93c375b026596b"
 
diff --git a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
index 8a0b1ee..ba0531c 100644
--- a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
+++ b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
@@ -8,7 +8,7 @@ SRCREV = "962f353aac6cfc7b804547319db40f8b804f0b6c"
 
 DEPENDS = "libpam"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 inherit autotools features_check
 
diff --git a/recipes-security/isic/isic_0.07.bb b/recipes-security/isic/isic_0.07.bb
index 28153e3..3e56091 100644
--- a/recipes-security/isic/isic_0.07.bb
+++ b/recipes-security/isic/isic_0.07.bb
@@ -17,7 +17,7 @@ SRC_URI = "http://prdownloads.sourceforge.net/isic/${BPN}-${PV}.tgz \
 SRC_URI[md5sum] = "29f70c9bde9aa9128b8f7e66a315f9a4"
 SRC_URI[sha256sum] = "e033c53e03e26a4c72b723e2a5a1c433ee70eb4d23a1ba0d7d7e14ee1a80429d"
 
-S="${WORKDIR}/${BPN}-${PV}"
+S="${UNPACKDIR}/${BPN}-${PV}"
 
 inherit autotools-brokensep
 
diff --git a/recipes-security/krill/krill_0.12.3.bb b/recipes-security/krill/krill_0.12.3.bb
index ee959c2..2e200dd 100644
--- a/recipes-security/krill/krill_0.12.3.bb
+++ b/recipes-security/krill/krill_0.12.3.bb
@@ -15,7 +15,7 @@ include krill-crates.inc
 UPSTREAM_CHECK_URI = "https://github.com/NLnetLabs/${BPN}/releases"
 UPSTREAM_CHECK_GITTAGREGEX = "v(?P<pver>\d+(\.\d+)+)"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 CARGO_SRC_DIR = ""
 
 inherit pkgconfig useradd systemd cargo cargo-update-recipe-crates
diff --git a/recipes-security/libest/libest_3.2.0.bb b/recipes-security/libest/libest_3.2.0.bb
index b4c6165..04bfcee 100644
--- a/recipes-security/libest/libest_3.2.0.bb
+++ b/recipes-security/libest/libest_3.2.0.bb
@@ -20,7 +20,7 @@ EXTRA_OECONF = "--disable-pthreads --with-ssl-dir=${STAGING_LIBDIR}"
 CFLAGS += "-fcommon"
 LDFLAGS:append:libc-musl = " -lexecinfo"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 PACKAGES = "${PN} ${PN}-dbg ${PN}-dev"
 
diff --git a/recipes-security/libmhash/libmhash_0.9.9.9.bb b/recipes-security/libmhash/libmhash_0.9.9.9.bb
index f725a26..f5518d2 100644
--- a/recipes-security/libmhash/libmhash_0.9.9.9.bb
+++ b/recipes-security/libmhash/libmhash_0.9.9.9.bb
@@ -10,7 +10,7 @@ HOMEPAGE = "http://mhash.sourceforge.net/"
 LICENSE = "LGPL-2.0-only"
 LIC_FILES_CHKSUM = "file://COPYING;md5=3bf50002aefd002f49e7bb854063f7e7"
 
-S = "${WORKDIR}/mhash-${PV}"
+S = "${UNPACKDIR}/mhash-${PV}"
 
 SECTION = "libs"
 
diff --git a/recipes-security/libmspack/libmspack_1.11.bb b/recipes-security/libmspack/libmspack_1.11.bb
index 59df84b..338701e 100644
--- a/recipes-security/libmspack/libmspack_1.11.bb
+++ b/recipes-security/libmspack/libmspack_1.11.bb
@@ -11,6 +11,6 @@ SRC_URI = "git://github.com/kyz/libmspack.git;branch=master;protocol=https"
 
 inherit autotools
 
-S = "${WORKDIR}/git/${BPN}"
+S = "${UNPACKDIR}/git/${BPN}"
 
 inherit autotools
diff --git a/recipes-security/ncrack/ncrack_0.7.bb b/recipes-security/ncrack/ncrack_0.7.bb
index 8e6b444..881ee38 100644
--- a/recipes-security/ncrack/ncrack_0.7.bb
+++ b/recipes-security/ncrack/ncrack_0.7.bb
@@ -13,6 +13,6 @@ DEPENDS = "openssl zlib"
 
 inherit autotools-brokensep
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 INSANE_SKIP:${PN} = "already-stripped"
-- 
2.34.1


