Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68326C83038
	for <webhook@archiver.kernel.org>; Tue,  1 Jul 2025 12:27:43 +0000 (UTC)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
 by mx.groups.io with SMTP id smtpd.web10.6573.1751364020399040729
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 01 Jul 2025 03:00:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=K0Wec7vo;
 spf=pass (domain: fujitsu.com, ip: 139.138.36.223, mailfrom: liuyd.fnst@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1751364020; x=1782900020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iN9A7zf3Tcj9lsFnl3ibKZoD4xw7wgqo7zRQMACoeU4=;
  b=K0Wec7voY5z0EsVfI4qEOyB6DdMtgkW63mRG/9H8yAqgyM//lxKjwrcc
   CIB0YR4Nvku/3/29cDSDdRI5d1ufiD478Qk26m4XdSprPWpgNJUDejbug
   HYjWlRBv4bl6wfO+esKzN3lZk3x2j9IFCK4LSEl/YW/SIiBNI3mtJFqG0
   CN+zwelMj2fm0T4irVO7Q/op//ZQb5Cn+ZGcbbsmft/4BRafQzgUXk3QL
   CuZ6Y7eIEwN+U2KXeUuoiEZe2YeX5qEu6yxmlF1LBipbZSYZkfb3V4KLw
   pfrlsIMwRvGxerKIqQCzhF6pF806xBbmbkycaBs46SR5IAQRHkK9EFZ5/
   w==;
X-CSE-ConnectionGUID: H+JOiwK0S7itLybfF4vddA==
X-CSE-MsgGUID: hvBFDAJWRc2LWpdB+es3Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="193286290"
X-IronPort-AV: E=Sophos;i="6.16,279,1744038000"; 
   d="scan'208";a="193286290"
Received: from unknown (HELO az2nlsmgr4.o.css.fujitsu.com) ([51.138.80.169])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 19:00:18 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr4.o.css.fujitsu.com (Postfix) with ESMTPS id 7292142A326
	for <yocto-patches@lists.yoctoproject.org>; Tue,  1 Jul 2025 10:00:19 +0000 (UTC)
Received: from oym-m1.gw.nic.fujitsu.com (oym-m1.gw.nic.fujitsu.com [10.85.9.161])
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTP id A3DDD1C001A0
	for <yocto-patches@lists.yoctoproject.org>; Tue,  1 Jul 2025 10:00:18 +0000 (UTC)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E4CABB4E26
	for <yocto-patches@lists.yoctoproject.org>; Tue,  1 Jul 2025 19:00:16 +0900 (JST)
Received: from G08FNSTD190088.g08.fujitsu.local (unknown [10.193.160.53])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6B2721A0073;
	Tue,  1 Jul 2025 18:00:16 +0800 (CST)
From: "Yiding Liu (Fujitsu)" <liuyd.fnst@fujitsu.com>
To: yocto-patches@lists.yoctoproject.org
Cc: maxj.fnst@fujitsu.com,
	Liu Yiding <liuyd.fnst@fujitsu.com>
Subject: [meta-security][PATCH 2/2] global: drop unneeded S assignment and update WORKDIR/UNPACKDIR
Date: Tue,  1 Jul 2025 18:00:12 +0800
Message-ID: <20250701100013.826-2-liuyd.fnst@fujitsu.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250701100013.826-1-liuyd.fnst@fujitsu.com>
References: <20250701100013.826-1-liuyd.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 01 Jul 2025 12:27:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1731

The series [1] changed the way sources are fetched/unpacked and
S needs to follow that.

[1] https://lore.kernel.org/openembedded-core/20250616095000.2918921-1-alex.kanavin@gmail.com/

Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
---
 .../recipes-scanners/checksecurity/checksecurity_2.0.16.bb     | 2 +-
 .../meta-perl/recipes-security/bastille/bastille_3.2.1.bb      | 2 +-
 dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb | 2 +-
 meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb                  | 1 -
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb                     | 2 --
 meta-tpm/recipes-tpm1/hoth/libhoth_git.bb                      | 2 --
 .../openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb             | 2 --
 meta-tpm/recipes-tpm1/pcr-extend/pcr-extend_git.bb             | 2 --
 meta-tpm/recipes-tpm1/tpm-quote-tools/tpm-quote-tools_1.0.4.bb | 1 -
 meta-tpm/recipes-tpm1/trousers/trousers_git.bb                 | 2 --
 meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_183-2024-03-27.bb    | 2 +-
 meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb           | 1 -
 meta-tpm/recipes-tpm2/tpm2-tcti-uefi/tpm2-tcti-uefi_0.9.9.bb   | 2 --
 meta-tpm/recipes-tpm2/tpm2-totp/tpm2-totp_0.3.0.bb             | 1 -
 recipes-mac/smack/mmap-smack-test_1.0.bb                       | 3 +--
 recipes-mac/smack/smack-test_1.0.bb                            | 3 +--
 recipes-mac/smack/smack_1.3.1.bb                               | 2 --
 recipes-mac/smack/tcp-smack-test_1.0.bb                        | 3 +--
 recipes-mac/smack/udp-smack-test_1.0.bb                        | 3 +--
 recipes-security/libgssglue/libgssglue_0.9.bb                  | 2 --
 recipes-security/redhat-security/redhat-security_1.0.bb        | 3 +--
 21 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
index 8006c9f..7bd796f 100644
--- a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
+++ b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
@@ -10,7 +10,7 @@ SRC_URI = "http://ftp.de.debian.org/debian/pool/main/c/checksecurity/checksecuri
 
 SRC_URI[sha256sum] = "9803b3760e9ec48e06ebaf48cec081db48c6fe72254a476224e4c5c55ed97fb0"
 
-S = "${WORKDIR}/checksecurity-${PV}+nmu1"
+S = "${UNPACKDIR}/checksecurity-${PV}+nmu1"
 
 
 # allow for anylocal, no need to patch
diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
index 7074f68..b95ec2d 100644
--- a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
+++ b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
@@ -35,7 +35,7 @@ SRC_URI = "http://sourceforge.net/projects/bastille-linux/files/bastille-linux/3
 SRC_URI[md5sum] = "df803f7e38085aa5da79f85d0539f91b"
 SRC_URI[sha256sum] = "0ea25191b1dc1c8f91e1b6f8cb5436a3aa1e57418809ef902293448efed5021a"
 
-S = "${WORKDIR}/Bastille"
+S = "${UNPACKDIR}/Bastille"
 
 do_install () {
 	install -d ${D}${sbindir}
diff --git a/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb b/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
index 8c21b30..6d83265 100644
--- a/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
+++ b/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
@@ -10,7 +10,7 @@ SRCREV = "f1bbd1a8756c076c8fd4f4dd0bc34a8ef215ae79"
 SRC_URI = "git://github.com/sullo/nikto.git;branch=master;protocol=https \
            file://location.patch"
 
-S = "${WORKDIR}/git/program"
+S = "${UNPACKDIR}/${BP}/program"
 
 do_install() {
     install -d ${D}${bindir}
diff --git a/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb b/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
index 55a4c01..3727bb3 100644
--- a/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
@@ -7,7 +7,6 @@ SRC_URI = "git://github.com/stefanberger/libtpms.git;branch=stable-0.10;protocol
 
 PE = "2"
 
-S = "${WORKDIR}/git"
 inherit autotools-brokensep pkgconfig perlnative
 
 PACKAGECONFIG ?= "openssl"
diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
index c7159e0..d5470f4 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
@@ -10,8 +10,6 @@ SRCREV = "54f4bb1e702a8b80d990ca00b6f72d5031dd131a"
 SRC_URI = "git://github.com/stefanberger/swtpm.git;branch=stable-0.10;protocol=https"
 PE = "2"
 
-S = "${WORKDIR}/git"
-
 PARALLEL_MAKE = ""
 inherit autotools pkgconfig perlnative
 
diff --git a/meta-tpm/recipes-tpm1/hoth/libhoth_git.bb b/meta-tpm/recipes-tpm1/hoth/libhoth_git.bb
index df1dc04..9d29f78 100644
--- a/meta-tpm/recipes-tpm1/hoth/libhoth_git.bb
+++ b/meta-tpm/recipes-tpm1/hoth/libhoth_git.bb
@@ -11,7 +11,5 @@ SRCREV = "e4827163741e0804f12ac96c81b8e97649be6795"
 
 DEPENDS += "libusb1"
 
-S = "${WORKDIR}/git"
-
 inherit pkgconfig meson
 
diff --git a/meta-tpm/recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb b/meta-tpm/recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb
index e3e643e..b792151 100644
--- a/meta-tpm/recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb
+++ b/meta-tpm/recipes-tpm1/openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb
@@ -17,8 +17,6 @@ SRC_URI = "\
 "
 SRCREV = "b28de5065e6eb9aa5d5afe2276904f7624c2cbaf"
 
-S = "${WORKDIR}/git"
-
 inherit autotools-brokensep pkgconfig
 
 # The definitions below are used to decrypt the srk password.
diff --git a/meta-tpm/recipes-tpm1/pcr-extend/pcr-extend_git.bb b/meta-tpm/recipes-tpm1/pcr-extend/pcr-extend_git.bb
index 2e5814b..efd8181 100644
--- a/meta-tpm/recipes-tpm1/pcr-extend/pcr-extend_git.bb
+++ b/meta-tpm/recipes-tpm1/pcr-extend/pcr-extend_git.bb
@@ -14,8 +14,6 @@ SRC_URI = "git://github.com/flihp/pcr-extend.git;branch=master;protocol=https \
 
 inherit autotools
 
-S = "${WORKDIR}/git"
-
 do_configure[noexec] = "1"
 
 do_compile() {
diff --git a/meta-tpm/recipes-tpm1/tpm-quote-tools/tpm-quote-tools_1.0.4.bb b/meta-tpm/recipes-tpm1/tpm-quote-tools/tpm-quote-tools_1.0.4.bb
index 4672bba..4b82faf 100644
--- a/meta-tpm/recipes-tpm1/tpm-quote-tools/tpm-quote-tools_1.0.4.bb
+++ b/meta-tpm/recipes-tpm1/tpm-quote-tools/tpm-quote-tools_1.0.4.bb
@@ -18,5 +18,4 @@ DEPENDS = "libtspi tpm-tools"
 SRC_URI = "git://git.code.sf.net/p/tpmquotetools/tpm-quote-tools;branch=master"
 SRCREV = "4511874d5c9b4504bb96e94f8a14bd6c39a36295"
 
-S = "${WORKDIR}/git"
 inherit autotools
diff --git a/meta-tpm/recipes-tpm1/trousers/trousers_git.bb b/meta-tpm/recipes-tpm1/trousers/trousers_git.bb
index 44a4ee6..abbb436 100644
--- a/meta-tpm/recipes-tpm1/trousers/trousers_git.bb
+++ b/meta-tpm/recipes-tpm1/trousers/trousers_git.bb
@@ -18,8 +18,6 @@ SRC_URI = " \
         file://0001-build-don-t-override-localstatedir-mandir-sysconfdir.patch \
     	"
 
-S = "${WORKDIR}/git"
-
 inherit autotools pkgconfig useradd update-rc.d ${@bb.utils.contains('VIRTUAL-RUNTIME_init_manager','systemd','systemd','', d)}
 
 PACKAGECONFIG ?= "gmp "
diff --git a/meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_183-2024-03-27.bb b/meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_183-2024-03-27.bb
index 7ed9569..64df708 100644
--- a/meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_183-2024-03-27.bb
+++ b/meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_183-2024-03-27.bb
@@ -23,7 +23,7 @@ SRCREV = "c37c74438429e1d5fe465232e7bf894b239a2cd4"
 
 UPSTREAM_CHECK_GITTAGREGEX = "rev(?P<pver>\d+(\-\d+)+)"
 
-S = "${WORKDIR}/git/src"
+S = "${UNPACKDIR}/${BP}/src"
 
 CFLAGS += "-Wno-error=maybe-uninitialized"
 
diff --git a/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb b/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb
index 8e941d1..3ceda55 100644
--- a/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb
+++ b/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb
@@ -26,4 +26,3 @@ UPSTREAM_CHECK_GITTAGREGEX = "v(?P<pver>\d+(\.\d+)+)"
 
 EXTRA_OECONF = "--disable-tpm-1.2"
 
-S = "${WORKDIR}/git"
diff --git a/meta-tpm/recipes-tpm2/tpm2-tcti-uefi/tpm2-tcti-uefi_0.9.9.bb b/meta-tpm/recipes-tpm2/tpm2-tcti-uefi/tpm2-tcti-uefi_0.9.9.bb
index 9c60e2b..09bbef2 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tcti-uefi/tpm2-tcti-uefi_0.9.9.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tcti-uefi/tpm2-tcti-uefi_0.9.9.bb
@@ -14,8 +14,6 @@ SRCREV = "0241b08f069f0fdb3612f5c1b938144dbe9be811"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
-S = "${WORKDIR}/git"
-
 inherit autotools pkgconfig
 
 EFIDIR ?= "/EFI/BOOT"
diff --git a/meta-tpm/recipes-tpm2/tpm2-totp/tpm2-totp_0.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-totp/tpm2-totp_0.3.0.bb
index d324e33..25c96eb 100644
--- a/meta-tpm/recipes-tpm2/tpm2-totp/tpm2-totp_0.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-totp/tpm2-totp_0.3.0.bb
@@ -14,4 +14,3 @@ SRC_URI = "git://github.com/tpm2-software/tpm2-totp.git;branch=master;protocol=h
 
 inherit autotools-brokensep pkgconfig
 
-S = "${WORKDIR}/git"
diff --git a/recipes-mac/smack/mmap-smack-test_1.0.bb b/recipes-mac/smack/mmap-smack-test_1.0.bb
index b11fbf3..36d887e 100644
--- a/recipes-mac/smack/mmap-smack-test_1.0.bb
+++ b/recipes-mac/smack/mmap-smack-test_1.0.bb
@@ -5,8 +5,7 @@ LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda
 
 SRC_URI = "file://mmap.c" 
 
-S = "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
+S = "${UNPACKDIR}/sources"
 
 do_compile() {
     ${CC} mmap.c ${LDFLAGS} -o mmap_test
diff --git a/recipes-mac/smack/smack-test_1.0.bb b/recipes-mac/smack/smack-test_1.0.bb
index 0949cd5..6fa1d4d 100644
--- a/recipes-mac/smack/smack-test_1.0.bb
+++ b/recipes-mac/smack/smack-test_1.0.bb
@@ -10,8 +10,7 @@ SRC_URI = " \
            file://test_smack_onlycap.sh \
 "
 
-S = "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
+S = "${UNPACKDIR}/sources"
 
 inherit features_check
 
diff --git a/recipes-mac/smack/smack_1.3.1.bb b/recipes-mac/smack/smack_1.3.1.bb
index 6c52392..14b7c44 100644
--- a/recipes-mac/smack/smack_1.3.1.bb
+++ b/recipes-mac/smack/smack_1.3.1.bb
@@ -25,8 +25,6 @@ inherit features_check
 REQUIRED_DISTRO_FEATURES = "smack"
 
 
-S = "${WORKDIR}/git"
-
 PACKAGECONFIG ??= ""
 PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}"
 
diff --git a/recipes-mac/smack/tcp-smack-test_1.0.bb b/recipes-mac/smack/tcp-smack-test_1.0.bb
index 370905d..10e1b4e 100644
--- a/recipes-mac/smack/tcp-smack-test_1.0.bb
+++ b/recipes-mac/smack/tcp-smack-test_1.0.bb
@@ -8,8 +8,7 @@ SRC_URI = "file://tcp_server.c \
            file://test_smack_tcp_sockets.sh \
 "
 
-S = "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
+S = "${UNPACKDIR}/sources"
 
 do_compile() {
     ${CC} tcp_client.c ${LDFLAGS} -o tcp_client
diff --git a/recipes-mac/smack/udp-smack-test_1.0.bb b/recipes-mac/smack/udp-smack-test_1.0.bb
index 861138d..5a6d2b0 100644
--- a/recipes-mac/smack/udp-smack-test_1.0.bb
+++ b/recipes-mac/smack/udp-smack-test_1.0.bb
@@ -8,8 +8,7 @@ SRC_URI = "file://udp_server.c \
            file://test_smack_udp_sockets.sh \
 "
 
-S = "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
+S = "${UNPACKDIR}/sources"
 
 do_compile() {
     ${CC} udp_client.c ${LDFLAGS} -o udp_client
diff --git a/recipes-security/libgssglue/libgssglue_0.9.bb b/recipes-security/libgssglue/libgssglue_0.9.bb
index 73e6dec..532227a 100644
--- a/recipes-security/libgssglue/libgssglue_0.9.bb
+++ b/recipes-security/libgssglue/libgssglue_0.9.bb
@@ -26,8 +26,6 @@ SRC_URI = "git://gitlab.com/gsasl/libgssglue.git;protocol=https;branch=master \
           "
 SRCREV = "ada76bdaec665f70505f0b3aefe871b873e7c4b6"
 
-S = "${WORKDIR}/git"
-
 inherit autotools-brokensep ptest
 
 do_configure:prepend() {
diff --git a/recipes-security/redhat-security/redhat-security_1.0.bb b/recipes-security/redhat-security/redhat-security_1.0.bb
index 1f0ba6c..8957a68 100644
--- a/recipes-security/redhat-security/redhat-security_1.0.bb
+++ b/recipes-security/redhat-security/redhat-security_1.0.bb
@@ -18,8 +18,7 @@ SRC_URI = "file://find-chroot-py.sh \
            file://selinux-check-devices.sh \
            file://selinux-ls-unconfined.sh"
 
-S = "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
+S = "${UNPACKDIR}/sources"
 
 do_install() {
 	install -d ${D}${bindir}
-- 
2.43.0


