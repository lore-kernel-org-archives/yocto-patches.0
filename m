Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4FEC8303D
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 17:11:58 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.web11.1105.1751649114016486856
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:11:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=MRQHihIA;
 spf=pass (domain: konsulko.com, ip: 209.85.160.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a76ea97cefso11607191cf.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751649113; x=1752253913; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUmDskrKsEqvqtZy1quyX5iLzqnoFP7NmznBEX2CWQQ=;
        b=MRQHihIALfzW5VqxRXvMQw5VvnL5NYr6qJEcRQiw7KiOXjVBv6XSiGugxbWOaqEm5E
         XYRLk4DsrTQPjjNNau17tU3o+loXhOLb2Mny1A1E13q3MYZfBk7CP25xVwtpD6zsDaru
         lWQWuDrcCDCCUBaepv9bK45wtaYTRf5yhgtGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649113; x=1752253913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUmDskrKsEqvqtZy1quyX5iLzqnoFP7NmznBEX2CWQQ=;
        b=mGCriA2Qbll0qbomiTHHLWMs64XLENIA2CVhKbGh/PakCtOh2C1lFCdNVKr8bH35IG
         0NrsAlzIlqyePkV81fUUz19Vp1URWBn0yAMb8SkGKouZMGxlorP5LfjC2pRl3S+McbLB
         t4Vv6MorRdqf25i0Hs1leaQx5e77IA2ukqqt8SfboiKFA30NZJ1WUw9YNzRWIYUnfqfE
         8PqoQqWARqf/++zqdDbbEAO9qjxNzvBYBOEBteXNaBrBnwF9MyXGaPRgIzQSNasQVikn
         E7XHzQMkkiiGnUql0rSoghFMthW7wvcSyUMl5Tn0+PDwLXAMz9fz3ubqhiBM77mBPWUI
         hlSQ==
X-Gm-Message-State: AOJu0YzFZk3S15ThUYbpxWU5MT6wRqwuDO3KNeSLa03jKGNXI7zvQ3xT
	rAtQrgQDKC8a7CI0ftTpMkIiQugTLt91F7ouZajx6QkGY35z0FXWWWAHKNIN3jbZJSIPclf9uoh
	suYnR
X-Gm-Gg: ASbGncuVMwGnfUs1qTJ39C8n6V0L/lX9e2/iIr2VzN/m1pzICTpoj7q+OWA0t6f0b0L
	t0yPxQEiGZgH4Ha0p6TwrQg0tf4Zl2RlOQRL/3XwL77StXJVoN79RrH8aHyfBJi3/vC6Z5rgKKk
	m/s/giIFPZg6dNTul5/NwdtPOcyBjh40kbR9/c8eg5nx0c5W9ndCumc4WEVSOiYWOYO9I0bSSaf
	C88PcBDCokd7uF0Y5czLX8IebwWqmaGJVHIEEYJeSXeLRdFOs5bv+pPHaSSoZcbuna8mMn0aNvp
	tHxaBNLeBaPocHSr+5otp2b1y8nw6bGR6dlZmzHamrEsEGxy70ne20ba6seqT47s9MBaPk/8Rg4
	8W0z725xCW8Ctbj7klGrGSPZ2+Nm5oP3sY/qQJw==
X-Google-Smtp-Source: AGHT+IHB7qfQTpKaEtBe3bW+nV8xtgXGbB4DcjNXVgq4dlwbkE8WNUcpT/8UyJAf8TLPETKKl6xw4Q==
X-Received: by 2002:a05:622a:6205:b0:4a4:3d13:7d21 with SMTP id d75a77b69052e-4a99883e4e0mr43840061cf.47.1751649112154;
        Fri, 04 Jul 2025 10:11:52 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949f99dcsm17249611cf.19.2025.07.04.10.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:11:51 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Scott Murray <scott.murray@konsulko.com>
Subject: [meta-security][PATCH 04/12] Adapt to S/UNPACKDIR changes
Date: Fri,  4 Jul 2025 13:11:08 -0400
Message-ID: <0272225ccdfb31a84408351c5911920a68249cc7.1751647559.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751647559.git.scott.murray@konsulko.com>
References: <cover.1751647559.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:11:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1756

Remove or update S definitions as required to work with oe-core
S/UNPACKDIR changes.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../recipes-scanners/checksecurity/checksecurity_2.0.16.bb    | 3 +--
 .../meta-perl/recipes-security/bastille/bastille_3.2.1.bb     | 2 +-
 .../meta-perl/recipes-security/nikto/nikto_2.1.6.bb           | 2 +-
 .../recipes-security/fail2ban/python3-fail2ban_git.bb         | 2 --
 meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb                 | 1 -
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb                    | 2 --
 meta-tpm/recipes-tpm1/hoth/libhoth_git.bb                     | 2 --
 .../openssl-tpm-engine/openssl-tpm-engine_0.5.0.bb            | 2 --
 meta-tpm/recipes-tpm1/pcr-extend/pcr-extend_git.bb            | 2 --
 .../recipes-tpm1/tpm-quote-tools/tpm-quote-tools_1.0.4.bb     | 1 -
 meta-tpm/recipes-tpm1/tpm-tools/tpm-tools_1.3.9.2.bb          | 2 --
 meta-tpm/recipes-tpm1/trousers/trousers_git.bb                | 2 --
 meta-tpm/recipes-tpm2/ibmswtpm2/ibmswtpm2_183-2024-03-27.bb   | 2 +-
 meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb          | 2 --
 meta-tpm/recipes-tpm2/tpm2-tcti-uefi/tpm2-tcti-uefi_0.9.9.bb  | 2 --
 meta-tpm/recipes-tpm2/tpm2-totp/tpm2-totp_0.3.0.bb            | 2 --
 recipes-compliance/openscap/openscap_1.4.1.bb                 | 2 --
 .../scap-security-guide/scap-security-guide_0.1.76.bb         | 1 -
 recipes-ids/crowdsec/crowdsec_1.1.1.bb                        | 2 --
 recipes-ids/ossec/ossec-hids_3.7.0.bb                         | 3 ---
 recipes-ids/suricata/libhtp_0.5.50.bb                         | 4 ----
 recipes-ids/tripwire/tripwire_2.4.3.7.bb                      | 2 --
 recipes-kernel/lkrg/lkrg-module_0.9.7.bb                      | 2 --
 recipes-mac/AppArmor/apparmor_4.0.3.bb                        | 1 -
 recipes-mac/smack/mmap-smack-test_1.0.bb                      | 3 +--
 recipes-mac/smack/smack-test_1.0.bb                           | 3 +--
 recipes-mac/smack/smack_1.3.1.bb                              | 3 ---
 recipes-mac/smack/tcp-smack-test_1.0.bb                       | 3 +--
 recipes-mac/smack/udp-smack-test_1.0.bb                       | 3 +--
 recipes-scanners/checksec/checksec_2.6.0.bb                   | 2 --
 recipes-scanners/clamav/clamav_0.104.4.bb                     | 1 -
 recipes-security/Firejail/firejail_0.9.72.bb                  | 2 --
 recipes-security/chipsec/chipsec_1.9.1.bb                     | 2 --
 recipes-security/fscrypt/fscrypt_1.1.0.bb                     | 2 --
 recipes-security/fscryptctl/fscryptctl_1.1.0.bb               | 2 --
 recipes-security/glome/glome_git.bb                           | 1 -
 .../google-authenticator-libpam_1.09.bb                       | 2 --
 recipes-security/krill/krill_0.12.3.bb                        | 1 -
 recipes-security/libest/libest_3.2.0.bb                       | 2 --
 recipes-security/libgssglue/libgssglue_0.9.bb                 | 2 --
 recipes-security/libmspack/libmspack_1.11.bb                  | 2 +-
 recipes-security/ncrack/ncrack_0.7.bb                         | 2 --
 recipes-security/redhat-security/redhat-security_1.0.bb       | 3 +--
 43 files changed, 10 insertions(+), 79 deletions(-)

diff --git a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
index bc146a9..8dfb1cc 100644
--- a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
+++ b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
@@ -10,8 +10,7 @@ SRC_URI = "http://ftp.de.debian.org/debian/pool/main/c/checksecurity/checksecuri
 
 SRC_URI[sha256sum] = "9803b3760e9ec48e06ebaf48cec081db48c6fe72254a476224e4c5c55ed97fb0"
 
-S = "${WORKDIR}/checksecurity-${PV}+nmu1"
-
+S = "${UNPACKDIR}/checksecurity-${PV}+nmu1"
 
 # allow for anylocal, no need to patch
 LOGDIR = "/etc/checksecurity"
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
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index 52d35f8..7312bf8 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -26,8 +26,6 @@ inherit systemd
 
 SYSTEMD_SERVICE:${PN} = "fail2ban.service"
 
-S = "${UNPACKDIR}/git"
-
 do_install:append () {
     rm  -f ${D}/${bindir}/fail2ban-python
     install -d ${D}/${sysconfdir}/fail2ban
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
diff --git a/meta-tpm/recipes-tpm1/tpm-tools/tpm-tools_1.3.9.2.bb b/meta-tpm/recipes-tpm1/tpm-tools/tpm-tools_1.3.9.2.bb
index 816f382..6d911c9 100644
--- a/meta-tpm/recipes-tpm1/tpm-tools/tpm-tools_1.3.9.2.bb
+++ b/meta-tpm/recipes-tpm1/tpm-tools/tpm-tools_1.3.9.2.bb
@@ -22,8 +22,6 @@ SRC_URI = " \
 
 inherit autotools-brokensep gettext
 
-S = "${UNPACKDIR}/git"
-
 # Compile failing with gcc-14
 CFLAGS += " -Wno-incompatible-pointer-types -Wno-stringop-truncation -Wno-error=implicit-function-declaration"
 BUILD_CFLAGS += " -Wno-incompatible-pointer-types -Wno-stringop-truncation -Wno-error=implicit-function-declaration"
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
index 8e941d1..797222e 100644
--- a/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb
+++ b/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb
@@ -25,5 +25,3 @@ SRCREV = "0b9d77e304f68228b13b20ff0d72b0c16ffd2651"
 UPSTREAM_CHECK_GITTAGREGEX = "v(?P<pver>\d+(\.\d+)+)"
 
 EXTRA_OECONF = "--disable-tpm-1.2"
-
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
index d324e33..9c9f4c5 100644
--- a/meta-tpm/recipes-tpm2/tpm2-totp/tpm2-totp_0.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-totp/tpm2-totp_0.3.0.bb
@@ -13,5 +13,3 @@ SRCREV = "96a1448753a48974149003bc90ea3990ae8e8d0b"
 SRC_URI = "git://github.com/tpm2-software/tpm2-totp.git;branch=master;protocol=https"
 
 inherit autotools-brokensep pkgconfig
-
-S = "${WORKDIR}/git"
diff --git a/recipes-compliance/openscap/openscap_1.4.1.bb b/recipes-compliance/openscap/openscap_1.4.1.bb
index 47034ad..3e5f00a 100644
--- a/recipes-compliance/openscap/openscap_1.4.1.bb
+++ b/recipes-compliance/openscap/openscap_1.4.1.bb
@@ -15,8 +15,6 @@ SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
 
 SRCREV = "23a8ea3de3c4fd6017db4067675a81287177166e"
 
-S = "${UNPACKDIR}/git"
-
 inherit cmake pkgconfig python3native python3targetconfig perlnative systemd
 
 PACKAGECONFIG ?= "python3 rpm perl gcrypt ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux', '', d)}"
diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
index 25309c7..d5a9406 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
@@ -15,7 +15,6 @@ SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=
 
 DEPENDS = "openscap-native python3-pyyaml-native python3-jinja2-native libxml2-native expat-native coreutils-native"
 
-S = "${UNPACKDIR}/git"
 B = "${S}/build"
 
 inherit cmake pkgconfig python3native python3targetconfig ptest
diff --git a/recipes-ids/crowdsec/crowdsec_1.1.1.bb b/recipes-ids/crowdsec/crowdsec_1.1.1.bb
index deccecf..fa13e9d 100644
--- a/recipes-ids/crowdsec/crowdsec_1.1.1.bb
+++ b/recipes-ids/crowdsec/crowdsec_1.1.1.bb
@@ -12,8 +12,6 @@ GO_IMPORT = "import"
 
 inherit go
 
-S = "${UNPACKDIR}/git"
-
 do_compile() {
     export GOARCH="${TARGET_GOARCH}"
     export GOROOT="${STAGING_LIBDIR_NATIVE}/${TARGET_SYS}/go"
diff --git a/recipes-ids/ossec/ossec-hids_3.7.0.bb b/recipes-ids/ossec/ossec-hids_3.7.0.bb
index d9f5121..f8ee993 100644
--- a/recipes-ids/ossec/ossec-hids_3.7.0.bb
+++ b/recipes-ids/ossec/ossec-hids_3.7.0.bb
@@ -15,9 +15,6 @@ UPSTREAM_CHECK_COMMITS = "1"
 
 inherit autotools-brokensep  useradd
 
-S = "${UNPACKDIR}/git"
-
-
 OSSEC_DIR = "/var/ossec"
 OSSEC_UID ?= "ossec"
 OSSEC_RUID ?= "ossecr"
diff --git a/recipes-ids/suricata/libhtp_0.5.50.bb b/recipes-ids/suricata/libhtp_0.5.50.bb
index 3a795ae..7695539 100644
--- a/recipes-ids/suricata/libhtp_0.5.50.bb
+++ b/recipes-ids/suricata/libhtp_0.5.50.bb
@@ -13,10 +13,6 @@ inherit autotools-brokensep pkgconfig
 
 CFLAGS += "-D_DEFAULT_SOURCE"
 
-#S = "${UNPACKDIR}/suricata-${VER}/${BPN}"
-
-S = "${UNPACKDIR}/git"
-
 do_configure () {
     cd ${S}
     ./autogen.sh
diff --git a/recipes-ids/tripwire/tripwire_2.4.3.7.bb b/recipes-ids/tripwire/tripwire_2.4.3.7.bb
index 3c85027..e2968e4 100644
--- a/recipes-ids/tripwire/tripwire_2.4.3.7.bb
+++ b/recipes-ids/tripwire/tripwire_2.4.3.7.bb
@@ -19,8 +19,6 @@ SRC_URI = "\
 	file://run-ptest \
        "
 
-S = "${UNPACKDIR}/git"
-
 inherit autotools-brokensep update-rc.d ptest
 
 INITSCRIPT_NAME = "tripwire"
diff --git a/recipes-kernel/lkrg/lkrg-module_0.9.7.bb b/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
index 20982a8..85a9644 100644
--- a/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
+++ b/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
@@ -13,8 +13,6 @@ SRC_URI = "git://github.com/lkrg-org/lkrg.git;protocol=https;branch=main"
 
 SRCREV = "5dc5cfea1f4dc8febdd5274d99e277c17df06acc"
 
-S = "${UNPACKDIR}/git"
-
 inherit module kernel-module-split
 
 MAKE_TARGETS = "modules"
diff --git a/recipes-mac/AppArmor/apparmor_4.0.3.bb b/recipes-mac/AppArmor/apparmor_4.0.3.bb
index 06a5010..9983157 100644
--- a/recipes-mac/AppArmor/apparmor_4.0.3.bb
+++ b/recipes-mac/AppArmor/apparmor_4.0.3.bb
@@ -23,7 +23,6 @@ SRC_URI = " \
     "
 
 SRCREV = "b4dfdf50f50ed1d64161424d036a2453645f0cfe"
-S = "${UNPACKDIR}/git"
 
 PARALLEL_MAKE = ""
 
diff --git a/recipes-mac/smack/mmap-smack-test_1.0.bb b/recipes-mac/smack/mmap-smack-test_1.0.bb
index b11fbf3..df2896c 100644
--- a/recipes-mac/smack/mmap-smack-test_1.0.bb
+++ b/recipes-mac/smack/mmap-smack-test_1.0.bb
@@ -5,8 +5,7 @@ LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda
 
 SRC_URI = "file://mmap.c" 
 
-S = "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
+S = "${UNPACKDIR}"
 
 do_compile() {
     ${CC} mmap.c ${LDFLAGS} -o mmap_test
diff --git a/recipes-mac/smack/smack-test_1.0.bb b/recipes-mac/smack/smack-test_1.0.bb
index 0949cd5..4a581ee 100644
--- a/recipes-mac/smack/smack-test_1.0.bb
+++ b/recipes-mac/smack/smack-test_1.0.bb
@@ -10,8 +10,7 @@ SRC_URI = " \
            file://test_smack_onlycap.sh \
 "
 
-S = "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
+S = "${UNPACKDIR}"
 
 inherit features_check
 
diff --git a/recipes-mac/smack/smack_1.3.1.bb b/recipes-mac/smack/smack_1.3.1.bb
index 7b20e6b..99f79b7 100644
--- a/recipes-mac/smack/smack_1.3.1.bb
+++ b/recipes-mac/smack/smack_1.3.1.bb
@@ -23,9 +23,6 @@ inherit features_check
 
 REQUIRED_DISTRO_FEATURES = "smack"
 
-
-S = "${WORKDIR}/git"
-
 PACKAGECONFIG ??= ""
 PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}"
 
diff --git a/recipes-mac/smack/tcp-smack-test_1.0.bb b/recipes-mac/smack/tcp-smack-test_1.0.bb
index 370905d..8b7704f 100644
--- a/recipes-mac/smack/tcp-smack-test_1.0.bb
+++ b/recipes-mac/smack/tcp-smack-test_1.0.bb
@@ -8,8 +8,7 @@ SRC_URI = "file://tcp_server.c \
            file://test_smack_tcp_sockets.sh \
 "
 
-S = "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
+S = "${UNPACKDIR}"
 
 do_compile() {
     ${CC} tcp_client.c ${LDFLAGS} -o tcp_client
diff --git a/recipes-mac/smack/udp-smack-test_1.0.bb b/recipes-mac/smack/udp-smack-test_1.0.bb
index 861138d..1a2e011 100644
--- a/recipes-mac/smack/udp-smack-test_1.0.bb
+++ b/recipes-mac/smack/udp-smack-test_1.0.bb
@@ -8,8 +8,7 @@ SRC_URI = "file://udp_server.c \
            file://test_smack_udp_sockets.sh \
 "
 
-S = "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
+S = "${UNPACKDIR}"
 
 do_compile() {
     ${CC} udp_client.c ${LDFLAGS} -o udp_client
diff --git a/recipes-scanners/checksec/checksec_2.6.0.bb b/recipes-scanners/checksec/checksec_2.6.0.bb
index 4767239..192e249 100644
--- a/recipes-scanners/checksec/checksec_2.6.0.bb
+++ b/recipes-scanners/checksec/checksec_2.6.0.bb
@@ -9,8 +9,6 @@ LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=879b2147c754bc040c29e9c3b84da836"
 SRCREV = "2753ebb89fcdc96433ae8a4c4e5a49214a845be2"
 SRC_URI = "git://github.com/slimm609/checksec.sh;branch=main;protocol=https"
 
-S = "${UNPACKDIR}/git"
-
 do_install() {
     install -d ${D}${bindir}
     install -m 0755 ${S}/checksec ${D}${bindir}
diff --git a/recipes-scanners/clamav/clamav_0.104.4.bb b/recipes-scanners/clamav/clamav_0.104.4.bb
index 48cc75c..7b81fd0 100644
--- a/recipes-scanners/clamav/clamav_0.104.4.bb
+++ b/recipes-scanners/clamav/clamav_0.104.4.bb
@@ -21,7 +21,6 @@ SRC_URI = "git://github.com/Cisco-Talos/clamav;branch=rel/0.104;protocol=https \
     file://headers_fixup.patch \
     file://oe_cmake_fixup.patch \
 "
-S = "${UNPACKDIR}/git"
 
 LEAD_SONAME = "libclamav.so"
 SO_VER = "9.6.0"
diff --git a/recipes-security/Firejail/firejail_0.9.72.bb b/recipes-security/Firejail/firejail_0.9.72.bb
index 10023c1..cf0190d 100644
--- a/recipes-security/Firejail/firejail_0.9.72.bb
+++ b/recipes-security/Firejail/firejail_0.9.72.bb
@@ -16,8 +16,6 @@ SRC_URI = "git://github.com/netblue30/firejail.git;protocol=https;branch=master
 
 DEPENDS = "libseccomp"
 
-S = "${UNPACKDIR}/git"
-
 inherit autotools-brokensep pkgconfig bash-completion features_check
 
 REQUIRED_DISTRO_FEATURES = "seccomp"
diff --git a/recipes-security/chipsec/chipsec_1.9.1.bb b/recipes-security/chipsec/chipsec_1.9.1.bb
index 213b047..ef293bc 100644
--- a/recipes-security/chipsec/chipsec_1.9.1.bb
+++ b/recipes-security/chipsec/chipsec_1.9.1.bb
@@ -12,8 +12,6 @@ DEPENDS = "virtual/kernel nasm-native"
 SRC_URI = "git://github.com/chipsec/chipsec.git;branch=main;protocol=https"
 SRCREV = "d8c2a606bf440c32196c6289a7a458f3ae3107cc"
 
-S = "${UNPACKDIR}/git"
-
 inherit module setuptools3
 
 EXTRA_OEMAKE = "CC='${CC}' LDFLAGS='${LDFLAGS}' CFLAGS='${CFLAGS}'"
diff --git a/recipes-security/fscrypt/fscrypt_1.1.0.bb b/recipes-security/fscrypt/fscrypt_1.1.0.bb
index c620c6e..6ccb8fe 100644
--- a/recipes-security/fscrypt/fscrypt_1.1.0.bb
+++ b/recipes-security/fscrypt/fscrypt_1.1.0.bb
@@ -20,8 +20,6 @@ inherit go goarch features_check
 
 REQUIRED_DISTRO_FEATURES = "pam"
 
-S = "${UNPACKDIR}/git"
-
 do_compile() {
 	export GOARCH=${TARGET_GOARCH}
 	export GOROOT="${STAGING_LIBDIR_NATIVE}/${TARGET_SYS}/go"
diff --git a/recipes-security/fscryptctl/fscryptctl_1.1.0.bb b/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
index cf03a18..edd6943 100644
--- a/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
+++ b/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
@@ -12,8 +12,6 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
 SRCREV = "7c80c73c084ce9ea49a03b814dac7a82fd7b4c23"
 SRC_URI = "git://github.com/google/fscryptctl.git;branch=master;protocol=https"
 
-S = "${UNPACKDIR}/git"
-
 do_compile:prepend() {
     sed -i 's/fscryptctl\.1//g' ${S}/Makefile
     sed -i 's/install-man//g' ${S}/Makefile
diff --git a/recipes-security/glome/glome_git.bb b/recipes-security/glome/glome_git.bb
index b99239e..5a0300f 100644
--- a/recipes-security/glome/glome_git.bb
+++ b/recipes-security/glome/glome_git.bb
@@ -10,7 +10,6 @@ inherit meson pkgconfig
 
 DEPENDS += "openssl"
 
-S = "${UNPACKDIR}/git"
 SRC_URI = "git://github.com/google/glome.git;branch=master;protocol=https"
 SRCREV = "48d28f82bd51ae4bccc84fbbee93c375b026596b"
 
diff --git a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
index ba0531c..60f2c9e 100644
--- a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
+++ b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
@@ -8,8 +8,6 @@ SRCREV = "962f353aac6cfc7b804547319db40f8b804f0b6c"
 
 DEPENDS = "libpam"
 
-S = "${UNPACKDIR}/git"
-
 inherit autotools features_check
 
 REQUIRED_DISTRO_FEATURES = "pam"
diff --git a/recipes-security/krill/krill_0.12.3.bb b/recipes-security/krill/krill_0.12.3.bb
index d5917a1..472bac9 100644
--- a/recipes-security/krill/krill_0.12.3.bb
+++ b/recipes-security/krill/krill_0.12.3.bb
@@ -15,7 +15,6 @@ include krill-crates.inc
 UPSTREAM_CHECK_URI = "https://github.com/NLnetLabs/${BPN}/releases"
 UPSTREAM_CHECK_GITTAGREGEX = "v(?P<pver>\d+(\.\d+)+)"
 
-S = "${UNPACKDIR}/git"
 CARGO_SRC_DIR = ""
 
 inherit pkgconfig useradd systemd cargo cargo-update-recipe-crates
diff --git a/recipes-security/libest/libest_3.2.0.bb b/recipes-security/libest/libest_3.2.0.bb
index 04bfcee..e6af2c6 100644
--- a/recipes-security/libest/libest_3.2.0.bb
+++ b/recipes-security/libest/libest_3.2.0.bb
@@ -20,8 +20,6 @@ EXTRA_OECONF = "--disable-pthreads --with-ssl-dir=${STAGING_LIBDIR}"
 CFLAGS += "-fcommon"
 LDFLAGS:append:libc-musl = " -lexecinfo"
 
-S = "${UNPACKDIR}/git"
-
 PACKAGES = "${PN} ${PN}-dbg ${PN}-dev"
 
 FILES:${PN} = "${bindir}/* ${libdir}/libest-3.2.0p.so"
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
diff --git a/recipes-security/libmspack/libmspack_1.11.bb b/recipes-security/libmspack/libmspack_1.11.bb
index 338701e..7203dee 100644
--- a/recipes-security/libmspack/libmspack_1.11.bb
+++ b/recipes-security/libmspack/libmspack_1.11.bb
@@ -11,6 +11,6 @@ SRC_URI = "git://github.com/kyz/libmspack.git;branch=master;protocol=https"
 
 inherit autotools
 
-S = "${UNPACKDIR}/git/${BPN}"
+S = "${UNPACKDIR}/${BP}/${BPN}"
 
 inherit autotools
diff --git a/recipes-security/ncrack/ncrack_0.7.bb b/recipes-security/ncrack/ncrack_0.7.bb
index 881ee38..f389e3c 100644
--- a/recipes-security/ncrack/ncrack_0.7.bb
+++ b/recipes-security/ncrack/ncrack_0.7.bb
@@ -13,6 +13,4 @@ DEPENDS = "openssl zlib"
 
 inherit autotools-brokensep
 
-S = "${UNPACKDIR}/git"
-
 INSANE_SKIP:${PN} = "already-stripped"
diff --git a/recipes-security/redhat-security/redhat-security_1.0.bb b/recipes-security/redhat-security/redhat-security_1.0.bb
index 1f0ba6c..edd34f7 100644
--- a/recipes-security/redhat-security/redhat-security_1.0.bb
+++ b/recipes-security/redhat-security/redhat-security_1.0.bb
@@ -18,8 +18,7 @@ SRC_URI = "file://find-chroot-py.sh \
            file://selinux-check-devices.sh \
            file://selinux-ls-unconfined.sh"
 
-S = "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
+S = "${UNPACKDIR}"
 
 do_install() {
 	install -d ${D}${bindir}
-- 
2.50.0


