Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9697.1795884894067141931
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:54:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=tWRYUEyC;
 spf=pass (domain: konsulko.com, ip: 209.85.128.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso69616955e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884892; x=1796489692; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VxOGH6TCB0T3vYb+F0E37DA7Jrg8rC9A+gT5oftqr/A=;
        b=tWRYUEyCq1bjDS7QXus1SyynX6fHaTV1cZoANhGXlq7DVG4ksulwN59BLeHWDVMm8X
         LmNMIlwad/4sY2EGgmFHJ2S9XSHTeqsHV2bobRvapNbO5WbAFaJ3FeTOSnYBixLFCTlN
         ogIFFmxvjmj2+x4zTFs+RdMRVoezXSrNIPL14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884892; x=1796489692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VxOGH6TCB0T3vYb+F0E37DA7Jrg8rC9A+gT5oftqr/A=;
        b=hBH+hBBbNYrlPbyRkTReGafBpdhYFWL95VSxN3iogDFSnuhqVIZ2zXoJq1jjrbDK44
         Rz36Q0HXJSc0UuwC4K+gEUa0Uu7lbGfW2WMzxFgDtXc9krD2zzaKiELENwXrzNMmFTh8
         q4+sJNz1EUN7EOFhuKOyvz/p/un+cfH1lhJzkQBiw6FajtUKUhiqQIOs5vAVAAJO9X+L
         aqgGmJID3hfIsovcOWG+ISVUYAqNYZQEcTRDas3zUOB8p2qOR+tZFc2MnwVCug3ypg6I
         cGF0kwXxHJxV4vUe5CJSusuxOxr3026uGOq5upOv1xHCcbIcW9uUMs/xUJkRaX8fXR6/
         kc4Q==
X-Gm-Message-State: APuU4Z+OtmegOnqQF2+kZQ4C7IKTUwOlmwjpuB+Kti10H+kinPi7K2HX
	Z/2BkgjQfDNPaZUDP4Sd0RXFRjNhqlAuNyunk6OnFWwKj1lLLqYP1Kc4zUWz3RCdlCzDdyFpr6+
	k9PKHRDo=
X-Gm-Gg: AZFdTZfqjNQXk0efJgq0IEAkNOzaGDClHZlp9TG2j4GKpk5J8l6sUQgHYAdNk7y7IRh
	XaIsWFKZ8gs1pc/8kfZLWmAFJ0/h5L7K7BZBvGIb4+DmJ5haS2Ao/z95wZgOjFRY2VgVtnEEqV2
	iwhw6C4uPq7eak762dZx859dTKWffAgL93HEW5MVymOvmesnLoWO0Cw/XHQexg94r1y9gih5F8f
	ebSTa/mm+w7thS7yV1vrg8pJkyE+NUiHCF4jZH/JHG8ZopqjZFu8tyxG2745cOxv3CfriAacAUO
	+6yG1mVI3YJyYO07lp7c/RgvyDTLeicc62vxpV2w0YWVJWur9SeLGzzvnbehS8MhNmRBUyyvzi7
	Xj8bBefujIiPDQskAkI+1qJf2IxBwsKnoQP4XW7EMsPgmaWlk94E/yZljWC2spWIp2vFPq6bH+v
	sjkRZ4Wmo8HbHQZD/4ZQsmPe42yatJE1yzt79YfMbfPdTh1fv9T3+K5Gcv3zHxLMIFthaSrTf0s
	QA1pHCeQxlF89qVHXHkezPwglXgjEXQOOLcr1O84oxZNWqM0VS0l+xG8jqKEdgQ4XLKx2CyCQpf
	F1FK3dtMKwURXvxevG9X+Ijz20uRdOul5x0gj1z7zGwkq36CEGMY4tTpgrCcNHVvVNkxr2lV6KT
	ibfUUhF8cIW+lUIgjK/5UsabPXr1OMQ==
X-Received: by 2002:a05:600c:3555:b0:4a1:9663:7639 with SMTP id 5b1f17b1804b1-4bb8882907fmr584041325e9.34.1795884891967;
        Sat, 28 Nov 2026 08:54:51 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:51 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 06/14] swtpm: backport sysusers and tmpfiles support
Date: Sat, 28 Nov 2026 18:54:24 +0200
Message-ID: <0cad2a335e3af637211d575a7f543fe6d61dcc6f.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:55:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5576
Content-Type: text/plain; charset="utf-8"

From: Niranjan Reddy Mekala <nirameka@qti.qualcomm.com>

Backport the upstream sysusers.d and tmpfiles.d integration to
provision the tss user and /var/lib/swtpm-localca declaratively.

Also backport the follow-up change that aligns the tss sysusers
definition with tpm2-tss to avoid conflicting definitions.

Package the generated sysusers.d and tmpfiles.d configuration files.

Signed-off-by: Niranjan Reddy Mekala <nirameka@qti.qualcomm.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...ll-sysusers.d-and-tmpfiles.d-configs.patch | 86 +++++++++++++++++++
 ...2-swtpm-sync-sysuser.d-with-tpm2-tss.patch | 29 +++++++
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb    |  9 +-
 3 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 meta-tpm/recipes-tpm/swtpm/swtpm/0001-swtpm-install-sysusers.d-and-tmpfiles.d-configs.patch
 create mode 100644 meta-tpm/recipes-tpm/swtpm/swtpm/0002-swtpm-sync-sysuser.d-with-tpm2-tss.patch

diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm/0001-swtpm-install-sysusers.d-and-tmpfiles.d-configs.patch b/meta-tpm/recipes-tpm/swtpm/swtpm/0001-swtpm-install-sysusers.d-and-tmpfiles.d-configs.patch
new file mode 100644
index 0000000..3fc414d
--- /dev/null
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm/0001-swtpm-install-sysusers.d-and-tmpfiles.d-configs.patch
@@ -0,0 +1,86 @@
+From d318d40469474eb8f3ccc4a6e9fe0ba100814e20 Mon Sep 17 00:00:00 2001
+From: Luca Boccassi <luca.boccassi@gmail.com>
+Date: Mon, 22 Sep 2025 17:56:24 +0100
+Subject: [PATCH] swtpm: install sysusers.d and tmpfiles.d configs
+
+These configuration files will create the required user, group and
+data directory on first boot/factory reset/package installation,
+without requiring manual scripts or actions. This is very important
+for image-based OSes, but it is useful in other cases to, to allow
+using declarative configuration instead of scripts.
+
+RPM now has built-in support for sysusers.d too.
+
+https://www.freedesktop.org/software/systemd/man/latest/tmpfiles.d.html
+https://www.freedesktop.org/software/systemd/man/latest/sysusers.d.html
+
+Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
+Upstream-Status: Backport [https://github.com/stefanberger/swtpm/commit/d318d40469474eb8f3ccc4a6e9fe0ba100814e20]
+---
+ .gitignore                 |  2 ++
+ configure.ac               |  2 ++
+ src/Makefile.am            | 10 ++++++++++
+ src/swtpm-sysusers.conf.in |  1 +
+ src/swtpm-tmpfiles.conf.in |  1 +
+ 5 files changed, 16 insertions(+)
+ create mode 100644 src/swtpm-sysusers.conf.in
+ create mode 100644 src/swtpm-tmpfiles.conf.in
+
+diff --git a/.gitignore b/.gitignore
+index 579d0be..012ef88 100644
+--- a/.gitignore
++++ b/.gitignore
+@@ -63,6 +63,8 @@ Makefile
+ /src/swtpm_ioctl/swtpm_ioctl
+ /src/swtpm_localca/swtpm_localca
+ /src/swtpm_setup/swtpm_setup
++/src/swtpm-sysusers.conf
++/src/swtpm-tmpfiles.conf
+ /src/utils/swtpm_conf.h
+ /test-driver
+ tests/*.log
+diff --git a/configure.ac b/configure.ac
+index afcd18a..4eab9f4 100644
+--- a/configure.ac
++++ b/configure.ac
+@@ -502,6 +502,8 @@ AC_CONFIG_FILES([Makefile                   \
+ 		src/swtpm_ioctl/Makefile    \
+ 		src/swtpm_localca/Makefile  \
+ 		src/swtpm_setup/Makefile    \
++		src/swtpm-sysusers.conf     \
++		src/swtpm-tmpfiles.conf     \
+ 		src/utils/Makefile          \
+ 		src/utils/swtpm_conf.h      \
+ 		man/Makefile                \
+diff --git a/src/Makefile.am b/src/Makefile.am
+index 9e03c78..c36d5cc 100644
+--- a/src/Makefile.am
++++ b/src/Makefile.am
+@@ -17,3 +17,13 @@ if WITH_SELINUX
+ SUBDIRS += \
+ 	selinux
+ endif
++
++sysusersdir = $(prefix)/lib/sysusers.d
++sysusers_DATA = swtpm-sysusers.conf
++
++tmpfilesdir = $(prefix)/lib/tmpfiles.d
++tmpfiles_DATA = swtpm-tmpfiles.conf
++
++EXTRA_DIST = \
++	swtpm-sysusers.conf \
++	swtpm-tmpfiles.conf
+diff --git a/src/swtpm-sysusers.conf.in b/src/swtpm-sysusers.conf.in
+new file mode 100644
+index 0000000..0b02ca4
+--- /dev/null
++++ b/src/swtpm-sysusers.conf.in
+@@ -0,0 +1 @@
++u! @TSS_USER@ - "TPM software stack" @LOCALSTATEDIR@/lib/swtpm-localca
+diff --git a/src/swtpm-tmpfiles.conf.in b/src/swtpm-tmpfiles.conf.in
+new file mode 100644
+index 0000000..afe2d13
+--- /dev/null
++++ b/src/swtpm-tmpfiles.conf.in
+@@ -0,0 +1 @@
++d @LOCALSTATEDIR@/lib/swtpm-localca 0750 @TSS_USER@ root
diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm/0002-swtpm-sync-sysuser.d-with-tpm2-tss.patch b/meta-tpm/recipes-tpm/swtpm/swtpm/0002-swtpm-sync-sysuser.d-with-tpm2-tss.patch
new file mode 100644
index 0000000..edc0402
--- /dev/null
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm/0002-swtpm-sync-sysuser.d-with-tpm2-tss.patch
@@ -0,0 +1,29 @@
+From b64b114c9c6941d9729fcc2ad511f108a3affaef Mon Sep 17 00:00:00 2001
+From: Luca Boccassi <luca.boccassi@gmail.com>
+Date: Wed, 7 Oct 2026 08:29:09 +0200
+Subject: [PATCH] swtpm: sync sysuser.d with tpm2-tss
+
+tpm2-tss has shipped a sysusers.d file since 2019 for the tss user:
+
+https://github.com/tpm2-software/tpm2-tss/commit/c43f3c2190eb06e731c5bf7c2849d07f5f8503a5
+
+When two sysusers.d configs have a conflict, the tool raises a warning,
+and the result depends on alphabetic sorting of the config names which
+isn't great. Sync the content: drop the '!', drop the homedir (not used
+anyway) and modify the GECOS string.
+
+Fixes: d318d4046947 ("swtpm: install sysusers.d and tmpfiles.d configs")
+
+Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
+Upstream-Status: Backport [https://github.com/stefanberger/swtpm/commit/b64b114c9c6941d9729fcc2ad511f108a3affaef]
+---
+ src/swtpm-sysusers.conf.in | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/src/swtpm-sysusers.conf.in b/src/swtpm-sysusers.conf.in
+index 0b02ca4..a9a1779 100644
+--- a/src/swtpm-sysusers.conf.in
++++ b/src/swtpm-sysusers.conf.in
+@@ -1 +1 @@
+-u! @TSS_USER@ - "TPM software stack" @LOCALSTATEDIR@/lib/swtpm-localca
++u @TSS_USER@ - "tss user for tpm2"
diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb
index 1e91a91..50d2cfc 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb
@@ -8,7 +8,10 @@ SECTION = "apps"
 DEPENDS = "libtasn1 coreutils-native expect-native socat-native glib-2.0 net-tools-native libtpms json-glib"
 
 SRCREV = "32b5a0575991a73398de9749d63cafd847008af2"
-SRC_URI = "git://github.com/stefanberger/swtpm.git;branch=stable-0.10;protocol=https"
+SRC_URI = "git://github.com/stefanberger/swtpm.git;branch=stable-0.10;protocol=https \
+           file://0001-swtpm-install-sysusers.d-and-tmpfiles.d-configs.patch \
+           file://0002-swtpm-sync-sysuser.d-with-tpm2-tss.patch \
+          "
 PE = "2"
 
 PARALLEL_MAKE = ""
@@ -40,6 +43,10 @@ USERADD_PARAM:${PN} = "--system -g ${TSS_GROUP} --home-dir / \
 
 PACKAGE_BEFORE_PN = "${PN}-cuse"
 FILES:${PN}-cuse = "${bindir}/swtpm_cuse"
+FILES:${PN} += " \
+    ${libdir}/sysusers.d/swtpm-sysusers.conf \
+    ${libdir}/tmpfiles.d/swtpm-tmpfiles.conf \
+"
 
 INSANE_SKIP:${PN}   += "dev-so"
 
-- 
2.47.3

