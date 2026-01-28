Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A56ED35682
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 06:32:20 +0000 (UTC)
Received: from host.hernesphere.com (host.hernesphere.com [3.13.130.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7392.1769581939706549745
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Jan 2026 22:32:20 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: qinc.tv, ip: 3.13.130.34, mailfrom: dev@qinc.tv)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
Received: from localhost.localdomain (unknown [50.216.236.226])
	by host.hernesphere.com (Postfix) with ESMTPSA id 6D255106C68;
	Wed, 28 Jan 2026 00:32:15 -0600 (CST)
Authentication-Results: host.hernesphere.com;
	spf=pass (sender IP is 50.216.236.226) smtp.mailfrom=dev@qinc.tv smtp.helo=localhost.localdomain
Received-SPF: pass (host.hernesphere.com: connection is authenticated)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
From: "Eric L. Hernes" <dev@qinc.tv>
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <eric@qinc.tv>,
	"Eric L. Hernes" <dev@qinc.tv>
Subject: [meta-darwin][PATCH] Add GDB and CLANG (conditionally) to the SDK builds
Date: Tue, 27 Jan 2026 22:32:00 -0800
Message-ID: <20260128063200.99314-1-dev@qinc.tv>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 06:32:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3124

From: "Eric L. Hernes" <eric@qinc.tv>

GDB and CLANG are not included in the SDK builds on Darwin. This patch
adds them. GDB is added to the packagegroup files.  I had to disable
some of the advanced options for gdb to get a compile.

CLANG is added conditionally from the `CLANGSDK=3D1` variable.  This
also was missing from the *packagegroup* files.

Signed-off-by: Eric L. Hernes <dev@qinc.tv>
---
 .../openssl/openssl_%.bbappend                | 25 +++++++++++++++++++
 .../nativesdk-packagegroup-sdk-host.bbappend  |  3 +++
 .../packagegroup-cross-canadian.bbappend      |  5 ++++
 .../gcc/gcc-cross-canadian_%.bbappend         |  2 +-
 .../gdb/gdb-cross-canadian_%.bbappend         | 19 ++++++++++++++
 5 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 recipes-connectivity/openssl/openssl_%.bbappend
 create mode 100644 recipes-devtools/gdb/gdb-cross-canadian_%.bbappend

diff --git a/recipes-connectivity/openssl/openssl_%.bbappend b/recipes-co=
nnectivity/openssl/openssl_%.bbappend
new file mode 100644
index 0000000..3b0674c
--- /dev/null
+++ b/recipes-connectivity/openssl/openssl_%.bbappend
@@ -0,0 +1,25 @@
+
+do_configure:darwin21 () {
+    target=3D"${@'darwin64-arm64-cc' if d.getVar('SDK_ARCH') =3D=3D 'aar=
ch64' else 'darwin64-x86_64-cc'}"
+
+    useprefix=3D${prefix}
+    if [ "x$useprefix" =3D "x" ]; then
+        useprefix=3D/
+    fi
+    # WARNING: do not set compiler/linker flags (-I/-D etc.) in EXTRA_OE=
CONF, as they will fully replace the
+    # environment variables set by bitbake. Adjust the environment varia=
bles instead.
+    PERLEXTERNAL=3D"$(realpath ${S}/external/perl/Text-Template-*/lib)"
+    test -d "$PERLEXTERNAL" || bberror "PERLEXTERNAL '$PERLEXTERNAL' not=
 found!"
+    HASHBANGPERL=3D"/usr/bin/env perl" PERL=3Dperl PERL5LIB=3D"$PERLEXTE=
RNAL" \
+    perl ${S}/Configure ${EXTRA_OECONF} ${PACKAGECONFIG_CONFARGS} ${DEPR=
ECATED_CRYPTO_FLAGS} --prefix=3D$useprefix --openssldir=3D${libdir}/ssl-3=
 --libdir=3D${libdir} $target
+    perl ${B}/configdata.pm --dump
+}
+
+RDEPENDS:remove:${PN}-misc =3D "perl"
+RDEPENDS:remove:${PN}-ptest =3D "openssl-bin"
+RDEPENDS:remove:${PN}-ptest =3D "perl"
+RDEPENDS:remove:${PN}-ptest =3D "perl-modules"
+RDEPENDS:remove:${PN}-ptest =3D "bash"
+RDEPENDS:remove:${PN}-ptest =3D "sed"
+RDEPENDS:remove:${PN}-ptest =3D "openssl-engines"
+RDEPENDS:remove:${PN}-ptest =3D "openssl-ossl-module-legacy"
diff --git a/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.b=
bappend b/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbap=
pend
index 170a8c1..d1191e7 100644
--- a/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend
+++ b/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend
@@ -4,3 +4,6 @@ RDEPENDS:${PN}:darwin21 =3D "\
     nativesdk-bison \
     nativesdk-sdk-provides-dummy \
     "
+
+RDEPENDS:${PN}:darwin21 +=3D "${@bb.utils.contains('CLANGSDK', '1', 'nat=
ivesdk-clang', '', d)}"
+
diff --git a/recipes-core/packagegroups/packagegroup-cross-canadian.bbapp=
end b/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend
index de29f47..4e46eae 100644
--- a/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend
+++ b/recipes-core/packagegroups/packagegroup-cross-canadian.bbappend
@@ -1,9 +1,14 @@
 # Use indirection to stop these being expanded prematurely
 BINUTILS =3D "binutils-cross-canadian-${TRANSLATED_TARGET_ARCH}"
 GCC =3D "gcc-cross-canadian-${TRANSLATED_TARGET_ARCH}"
+GDB =3D "gdb-cross-canadian-${TRANSLATED_TARGET_ARCH}"
+CLANG =3D "clang-cross-canadian-${TRANSLATED_TARGET_ARCH}"
=20
 RDEPENDS:${PN}:darwinsdk =3D "\
     ${@all_multilib_tune_values(d, 'BINUTILS')} \
     ${@all_multilib_tune_values(d, 'GCC')} \
+    ${GDB} \
     meta-environment-${MACHINE} \
     "
+
+RDEPENDS:${PN}:darwinsdk +=3D "${@bb.utils.contains('CLANGSDK', '1', '${=
CLANGCROSSCANADIANDEPS}', '', d)}"
diff --git a/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend b/recipes=
-devtools/gcc/gcc-cross-canadian_%.bbappend
index 192ee0d..5a4b8f9 100644
--- a/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend
+++ b/recipes-devtools/gcc/gcc-cross-canadian_%.bbappend
@@ -3,7 +3,7 @@ ELFUTILS:darwinsdk =3D ""
=20
 EXTRA_OECONF:append:darwinsdk =3D " \
     --with-gmp=3D${STAGING_EXECPREFIXDIR} \
-    --with-mpft=3D${STAGING_EXECPREFIXDIR} \
+    --with-mpfr=3D${STAGING_EXECPREFIXDIR} \
     --with-mpc=3D${STAGING_EXECPREFIXDIR} \
 "
=20
diff --git a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend b/recipes=
-devtools/gdb/gdb-cross-canadian_%.bbappend
new file mode 100644
index 0000000..3f69019
--- /dev/null
+++ b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
@@ -0,0 +1,19 @@
+PACKAGECONFIG:remove =3D "python"
+PACKAGECONFIG:remove =3D "debuginfod"
+
+EXTRA_OECONF:append:darwinsdk =3D " \
+    --with-gmp=3D${STAGING_EXECPREFIXDIR} \
+    --with-mpfr=3D${STAGING_EXECPREFIXDIR} \
+    --with-mpc=3D${STAGING_EXECPREFIXDIR} \
+"
+
+EXTRA_OECONF:remove:darwinsdk =3D "--disable-gas"
+EXTRA_OECONF:remove:darwinsdk =3D "--disable-binutils"
+EXTRA_OECONF:remove:darwinsdk =3D "--disable-ld"
+EXTRA_OECONF:remove:darwinsdk =3D "--disable-gold"
+EXTRA_OECONF:remove:darwinsdk =3D "--with-system-readline"
+
+# Remove -rpath-link and -rpath
+LDFLAGS:darwinsdk =3D "${BUILDSDK_LDFLAGS}"
+
+INSANE_SKIP:append:darwin21 =3D " buildpaths"
--=20
2.50.1 (Apple Git-155)


