Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FD9C982DA
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:58:51 +0000 (UTC)
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26468.1789595922345108095
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AklVIQqB;
 spf=pass (domain: konsulko.com, ip: 74.125.230.140, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-912355b1bf6so317516d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595921; x=1790200721; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ipdhUoUSU2XPMnGZ842JXgBb4NK8diCRbZlXMLf7OsM=;
        b=AklVIQqBtEEyD12B6Vdqa0QbDoTya9BxO9h309N10aSBgsNdM5fayJxwBlfQJO1XoL
         pkT9FY8MRrjQtrkNJqdG4/bhSlBEFjiawdtHZi89bBB3THMWXUv+sm62dSMCOySANGJU
         Uo5MnKIcKSZ1hQlzI97QezDPd9HMf6lrO8Z+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595921; x=1790200721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ipdhUoUSU2XPMnGZ842JXgBb4NK8diCRbZlXMLf7OsM=;
        b=ip8Hiq4TQzi2xniMCVZ0BWQCu/jovM1/GDu4VYQLsrQEOEDSOGWYh39MZcqFbK5l/E
         Walf7a72T7RUOapP23WyYw+QOwhyFyYEOoJmPBdf7c6TSD0auvy7nHmdwlyC1olLd99G
         ZSH88eRXgLrC6kCk1nBHJLRnIU0QEIUPBvzjd0VALjY5ePMkTTt8sFj1Q4w63qGR/P4a
         Dps5aT3XBIdphgAdjucDAOp9z1jV0TXi+9YGTuvD1KIl8KawOYpyV1viBkQKf2AT5oO3
         g2/pI+dTtRBrSN2s+UawtEJdq7QMmcMLRhqe9y1FEm28zpIxMd6wDKdbspRmgskWsY1h
         l3Pw==
X-Gm-Message-State: AFuF++kkUfYUw7QWlWOjzqVqDK6vE8Ph1MkC3hw3NcPtrx4AivKeuoed
	A7svBqMI10kQzpZwnJuunNWMOVjjZCpK2j+C3RPBr9Z8IwIaAvEZT/QaiRhuzk0Lr2YTpcuf5U7
	rrfAW
X-Gm-Gg: AYBFou1IserWyv4KeuGA4Q96SZ1w2UgHamnn00LactYjo1ImyvDCGHx1SERWBuNOiXb
	aJd4h3/yCxjNzCb8vBvwqplEn9j7292yKGWCsOJ9OZnGJNaYLVdOb2ut9VZf+dAG4I0N+5vNguY
	Thls7AK4DOVnH9c2IB8QMWDrj0vTx/T+8dT0FFbsiAFXz6SZM4Tu6fjrHh0Nd+jVsTtMY3eorzM
	zZwjHnmQsQr7SQNk39L+7MSalH1VhiPyhUvL4a1oeL7jQdbImCoatZmqyw4FkST/qrca40I6cZG
	hIpJvr9rXMqlScVqJIl/xrVPtMHrmgXAHJLS05iqoqgNKGevqIyL4mverZxvvH9k+RK81Ygd9wc
	3WNPXF0QGcgGvn57ph3q4Dvy1NF7Xzo5sGcjXl6a/A7eti6RDkuemV6nrfNRA/P3qOhIePENdt3
	LmBjKp8tHYXzhOaKxrfW4kS/0sUUk7Xj8hELKJqNFmV4+iXVDZ5L7RWY9MIm26Fq2Lxn960Q3OT
	w70g0EG2NDbdNr+zJkPLsDfp5Id5KQbuwqXna2cVF4YqCp0nVJuA770ODF70EphmX1DUf/33v/J
	eSvrstrm9oKny8mi9kwXDl/EgIJ0StVruPOPUPaJowYsQA==
X-Received: by 2002:a05:620a:710f:b0:939:4baf:5b99 with SMTP id af79cd13be357-93bc63741eemr194727085a.18.1789595920873;
        Wed, 16 Sep 2026 14:58:40 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:40 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 04/19] sssd: upgrade 2.10.2 -> 2.13.1
Date: Wed, 16 Sep 2026 17:58:04 -0400
Message-ID: <dddf6f4781a5e6c3ef56e3e8af169e5d0bb23c54.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:58:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4860

Upgrade sssd to latest release, in part to fix OpenSSL 4.0 related build
failures.  Add _GNU_SOURCE to CFLAGS when building with musl to pick up
strchrnul definition.

Release notes:
https://sssd.io/release-notes/sssd-2.11.0.html
https://sssd.io/release-notes/sssd-2.11.1.html
https://sssd.io/release-notes/sssd-2.12.0.html
https://sssd.io/release-notes/sssd-2.13.0.html
https://sssd.io/release-notes/sssd-2.13.1.html

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../sssd/files/drop_ntpdate_chk.patch         | 17 ++++++---
 .../sssd/files/fix-ldblibdir.patch            |  9 ++++-
 .../recipes-security/sssd/files/fix_gid.patch | 18 ++++++---
 .../sssd/files/musl_fixup.patch               | 38 +++++++++++--------
 .../recipes-security/sssd/files/no_gen.patch  | 18 ++++++---
 .../sssd/{sssd_2.10.2.bb => sssd_2.13.1.bb}   |  4 +-
 6 files changed, 69 insertions(+), 35 deletions(-)
 rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.10.2.bb => sssd_2.13.1.bb} (98%)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/drop_ntpdate_chk.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/drop_ntpdate_chk.patch
index 338af5d..732f4d8 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/drop_ntpdate_chk.patch
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/drop_ntpdate_chk.patch
@@ -1,14 +1,21 @@
+From 106a4283f450d9cf6caab9e63d45aeb5a6c9718b Mon Sep 17 00:00:00 2001
+From: Armin Kuster <akuster808@gmail.com>
+Date: Tue, 18 May 2021 15:10:53 +0000
+Subject: [PATCH] sssd: update to 2.5.0
+
 nsupdate path is needed for various exec call
 but don't run natvie tests on it.
 
-
 Upstream-Status: Inappropriate [OE specific]
 Signed-off-by: Armin Kuster <akuster808@gmail.com>
+---
+ src/external/nsupdate.m4 | 12 ------------
+ 1 file changed, 12 deletions(-)
 
-Index: sssd-2.5.0/src/external/nsupdate.m4
-===================================================================
---- sssd-2.5.0.orig/src/external/nsupdate.m4
-+++ sssd-2.5.0/src/external/nsupdate.m4
+diff --git a/src/external/nsupdate.m4 b/src/external/nsupdate.m4
+index a137f38..ab08f57 100644
+--- a/src/external/nsupdate.m4
++++ b/src/external/nsupdate.m4
 @@ -3,16 +3,4 @@ AC_MSG_CHECKING(for executable nsupdate)
  if test -x "$NSUPDATE"; then
    AC_DEFINE_UNQUOTED([NSUPDATE_PATH], ["$NSUPDATE"], [The path to nsupdate])
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/fix-ldblibdir.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/fix-ldblibdir.patch
index e350baf..ab4f98d 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/fix-ldblibdir.patch
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/fix-ldblibdir.patch
@@ -1,3 +1,8 @@
+From 937a58aaa95036529e03926ab79d407438777981 Mon Sep 17 00:00:00 2001
+From: Kai Kang <kai.kang@windriver.com>
+Date: Wed, 16 Jun 2021 14:42:33 +0800
+Subject: [PATCH] sssd: fix for ldblibdir and systemd etc
+
 When calculate value of ldblibdir, it checks whether the directory of
 $ldblibdir exists. If not, it assigns ldblibdir with ${libdir}/ldb. It is not
 suitable for cross compile. Fix it that only re-assign ldblibdir when its value
@@ -11,10 +16,10 @@ Signed-off-by: Kai Kang <kai.kang@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/src/external/libldb.m4 b/src/external/libldb.m4
-index c400add..5e5f06d 100644
+index e8285a9..e98913c 100644
 --- a/src/external/libldb.m4
 +++ b/src/external/libldb.m4
-@@ -19,7 +19,7 @@ if test x"$with_ldb_lib_dir" != x; then
+@@ -22,7 +22,7 @@ if test x"$with_ldb_lib_dir" != x; then
      ldblibdir=$with_ldb_lib_dir
  else
      ldblibdir="`$PKG_CONFIG --variable=modulesdir ldb`"
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/fix_gid.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/fix_gid.patch
index 419b83f..ce62a1d 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/fix_gid.patch
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/fix_gid.patch
@@ -1,3 +1,8 @@
+From 394e022694d03dc456f00df656c8a0c5e59a1d49 Mon Sep 17 00:00:00 2001
+From: Armin Kuster <akuster808@gmail.com>
+Date: Tue, 18 May 2021 15:10:53 +0000
+Subject: [PATCH] sssd: update to 2.5.0
+
 from ../sssd-2.5.0/src/util/sss_pam_data.c:27:
 | ../sssd-2.5.0/src/util/debug.h:88:44: error: unknown type name 'uid_t'; did you mean 'uint_t'?
 |    88 | int chown_debug_file(const char *filename, uid_t uid, gid_t gid);
@@ -11,11 +16,14 @@ from ../sssd-2.5.0/src/util/sss_pam_data.c:27:
 
 Upstream-Status: Pending
 Signed-off-by: Armin Kuster <akuster808@gmail.com>
+---
+ src/util/debug.h | 2 ++
+ 1 file changed, 2 insertions(+)
 
-Index: sssd-2.7.1/src/util/debug.h
-===================================================================
---- sssd-2.7.1.orig/src/util/debug.h
-+++ sssd-2.7.1/src/util/debug.h
+diff --git a/src/util/debug.h b/src/util/debug.h
+index 22c8ebd..5736d3d 100644
+--- a/src/util/debug.h
++++ b/src/util/debug.h
 @@ -24,6 +24,8 @@
  #include "config.h"
  
@@ -24,4 +32,4 @@ Index: sssd-2.7.1/src/util/debug.h
 +#include <sys/types.h>
  #include <stdbool.h>
  #include <sys/types.h>
- 
+ #include <libintl.h>
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/musl_fixup.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/musl_fixup.patch
index 68f267c..51d0b25 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/musl_fixup.patch
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/musl_fixup.patch
@@ -1,4 +1,7 @@
-fix musl build failures
+From 05abd666016db971d8738685a31277771d16b29d Mon Sep 17 00:00:00 2001
+From: Armin Kuster <akuster808@gmail.com>
+Date: Sun, 4 Jul 2021 08:50:06 -0700
+Subject: [PATCH] fix musl build failures
 
 Missing _PATH_HOSTS and some NETDB defines when musl is enabled.
 
@@ -8,22 +11,25 @@ These are work arounds for now while we figure out where the real fix should res
 |  1199 |                   _PATH_HOSTS);
 |       |                   ^~~~~~~~~~~
 
-and 
+and
 
 i./sssd-2.5.1/src/sss_client/nss_ipnetworks.c:415:21: error: 'NETDB_INTERNAL' undeclared (first use in this function)
 |   415 |         *h_errnop = NETDB_INTERNAL;
 
-
 Upstream-Status: Pending
 Signed-off-by: Armin Kuster <akuster808@gmail.com>
-
-Index: sssd-2.5.1/src/providers/fail_over.c
-===================================================================
---- sssd-2.5.1.orig/src/providers/fail_over.c
-+++ sssd-2.5.1/src/providers/fail_over.c
-@@ -31,6 +31,10 @@
- #include <talloc.h>
+---
+ src/providers/fail_over.c | 4 ++++
+ src/sss_client/sss_cli.h  | 8 ++++++++
+ 2 files changed, 12 insertions(+)
+
+diff --git a/src/providers/fail_over.c b/src/providers/fail_over.c
+index d56c20f..2c6ceb6 100644
+--- a/src/providers/fail_over.c
++++ b/src/providers/fail_over.c
+@@ -33,6 +33,10 @@
  #include <netdb.h>
+ #include <arpa/inet.h>
  
 +#if !defined(_PATH_HOSTS)
 +#define _PATH_HOSTS     "/etc/hosts"
@@ -32,12 +38,12 @@ Index: sssd-2.5.1/src/providers/fail_over.c
  #include "util/dlinklist.h"
  #include "util/refcount.h"
  #include "util/util.h"
-Index: sssd-2.5.1/src/sss_client/sss_cli.h
-===================================================================
---- sssd-2.5.1.orig/src/sss_client/sss_cli.h
-+++ sssd-2.5.1/src/sss_client/sss_cli.h
-@@ -44,6 +44,14 @@ typedef int errno_t;
- #define EOK 0
+diff --git a/src/sss_client/sss_cli.h b/src/sss_client/sss_cli.h
+index 57e1ead..f58510f 100644
+--- a/src/sss_client/sss_cli.h
++++ b/src/sss_client/sss_cli.h
+@@ -52,6 +52,14 @@ typedef int errno_t;
+ #define NETDB_INTERNAL (-1)
  #endif
  
 +#ifndef NETDB_INTERNAL
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/no_gen.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/no_gen.patch
index 7d8e80b..9e3e4b0 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/no_gen.patch
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/no_gen.patch
@@ -1,14 +1,20 @@
-don't run generate-sbus-code
+From e9d42559b03a9543f3db91202917c76184617a4f Mon Sep 17 00:00:00 2001
+From: Armin Kuster <akuster808@gmail.com>
+Date: Tue, 18 May 2021 15:10:53 +0000
+Subject: [PATCH] don't run generate-sbus-code
 
 Upstream-Status: Inappropriate [OE Specific]
 
 Signed-off-by: Armin Kuster <akuster808@gmail.com>
+---
+ Makefile.am | 2 --
+ 1 file changed, 2 deletions(-)
 
-Index: sssd-2.7.1/Makefile.am
-===================================================================
---- sssd-2.7.1.orig/Makefile.am
-+++ sssd-2.7.1/Makefile.am
-@@ -1023,8 +1023,6 @@ generate-sbus-code:
+diff --git a/Makefile.am b/Makefile.am
+index 0ca40d9..75fdf72 100644
+--- a/Makefile.am
++++ b/Makefile.am
+@@ -1048,8 +1048,6 @@ generate-sbus-code:
  
  .PHONY: generate-sbus-code
  
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.13.1.bb
similarity index 98%
rename from dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb
rename to dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.13.1.bb
index 8ee61ce..1e71300 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.13.1.bb
@@ -24,7 +24,7 @@ SRC_URI = "https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz \
            file://fix-ldblibdir.patch \
            file://musl_fixup.patch \
            "
-SRC_URI[sha256sum] = "e8aa5e6b48ae465bea7064048715ce7e9c53b50ec6a9c69304f59e0d35be40ff"
+SRC_URI[sha256sum] = "05ea79e89f0be399983925b8874ac196d6dc5fd4416f83609557b9fc8ef798b5"
 
 inherit autotools pkgconfig gettext python3native features_check systemd useradd github-releases
 
@@ -71,6 +71,8 @@ EXTRA_OECONF += " \
     --with-sssd-user=sssd \
 "
 
+CFLAGS:append:libc-musl = " -D_GNU_SOURCE"
+
 do_configure:prepend () {
     mkdir -p ${AUTOTOOLS_AUXDIR}/build
     cp ${STAGING_DATADIR_NATIVE}/gettext/config.rpath ${AUTOTOOLS_AUXDIR}/build/
-- 
2.55.0


