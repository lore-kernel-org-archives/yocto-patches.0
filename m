Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD78CD13DE
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 15:40:21 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14375.1777477217531266834
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 08:40:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HOOzKvj3;
 spf=pass (domain: konsulko.com, ip: 209.85.222.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8dbbc6c16b2so137745385a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777477216; x=1778082016; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGb2oNZj95xgDg2IvgB6c+Fro0xaGkWZQkG2BRiSIqI=;
        b=HOOzKvj3N6a9sZ5Pxw+nvLu1WUcWFlYu+ozdkUV7kRlRSuxIoUuGpjPQEfStmTf/R4
         gzSh6TM+sUBHEMkrKAQ6TpATj2CHui/FncBrsVLzFoA6xkD3xDTPwsp4lmVvsWRyKpzk
         JlOt7jGbS7IajKbxQizEGRT8K8eW1C6eshwm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477216; x=1778082016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GGb2oNZj95xgDg2IvgB6c+Fro0xaGkWZQkG2BRiSIqI=;
        b=URMedrhUe+RFhJa1d4DGt3fsEdxXYpMXnBF//xJ/rZtu8bd5SCfy5978KOx3jgJYfU
         WYfOBq9h+X4b3QeTJGRQBgP9ltgHpB4zD/tNQvtTNOhB6V2fuJB0n5wdbKRjhuwfLO4S
         s9hUVJOGPg05oTdqvIbqBrvKSkJaTv0r+gcaVfhQElBOSDuM+wFw6dL+dh9CC6JSdxW3
         KNb+yf/TNaRLIMTAj3za1OmrXIs15Q1FsbcKBeMY2qewEoSSdxNO5v6xQNPJwb0Dd7h4
         opPDjhHWSHvWHl6mQxr+2Umne8vVWlWtr2Ot+nA8H6DV4M0jsUk8+awamyyjlfF8EIuL
         13IA==
X-Gm-Message-State: AOJu0Yx4Ryw3QrMMfFd6q00Gw/ZMilEJClLNspS4YK67hsrcfkZ9vTI/
	iJdzvgxZyuJVJGa9UZ5ZFLgSBOLmDMHhkVxJc8eEW2NsgmZmc41NiloB5MSlK/FBsUAMGBJgZV1
	/Tz0p
X-Gm-Gg: AeBDieszYAjf5aT4FWoNjKUBHanoloQOs1MvfWGZkrHXGbFXisaONaOdp/34FQjiyUi
	Wjz76EDjB5Y1XL2IFGIVwsdBok+qgSg4rFdyJO5VfrDQmlyx0vJ3kW6o3YxSNctYd12OidqzbQY
	ldQ49qb45mwXBcIwDBCxQmPISu5mzuNOMf8UBydommd8xs1DwVss808+LGkw9ha42vy1hGwYknu
	64lTPOyDlv6TsOX6sxmIrQZkQ9RmYeRvl1flzVb00JtYvU8xGZvqYE/1DlT6nbeHJx3/09aG56Q
	AS8218W/75IldULQzo5yQhQADvhTJHJqUsAoM8Y0VKHGDdgn4k8Wchcv1+Dn37XJIjx/9l1syJJ
	N3XQdjIbJa51zMnmGikDu4VeV8XdSb1NODw7HVBznSUj2854Cq5HI1zExrgJZIJTz+wcVoYDQ+d
	CqOz01ARCZHhLBwuDM7ozM32GzoPr9MhKgFnIuTfGRGHrY5z56mfG33iCntQ+pUxJmuD0cZBlfG
	0yGQjvoB/sDHy/VWiC20FSqsGey6AD84XRGiQPiUCdSfF8T4tAJRvg6SlN6X/zOJhxPpxf8WTq7
	ZMrZklleHQ==
X-Received: by 2002:a05:620a:2a0c:b0:8d8:13c9:55cb with SMTP id af79cd13be357-8f916b4a1cbmr464699585a.4.1777477216188;
        Wed, 29 Apr 2026 08:40:16 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940340f1csm207924185a.44.2026.04.29.08.40.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:40:15 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 08/13] aide: Upgrade to 0.19.3
Date: Wed, 29 Apr 2026 11:39:38 -0400
Message-ID: <203087eb7031085d57f34a9e7fa94e1ee32929c3.1777476608.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777476608.git.scott.murray@konsulko.com>
References: <cover.1777476608.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 15:40:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3882

Release notes:
https://github.com/aide/aide/releases/tag/v0.19
https://github.com/aide/aide/releases/tag/v0.19.1
https://github.com/aide/aide/releases/tag/v0.19.2
https://github.com/aide/aide/releases/tag/v0.19.3

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../aide/aide/0001-Fixes-build-issues.patch   | 37 +++++++++++++++++
 recipes-ids/aide/aide/m4_allow.patch          | 40 -------------------
 .../aide/{aide_0.18.8.bb => aide_0.19.3.bb}   | 15 ++++---
 3 files changed, 44 insertions(+), 48 deletions(-)
 create mode 100644 recipes-ids/aide/aide/0001-Fixes-build-issues.patch
 delete mode 100644 recipes-ids/aide/aide/m4_allow.patch
 rename recipes-ids/aide/{aide_0.18.8.bb => aide_0.19.3.bb} (85%)

diff --git a/recipes-ids/aide/aide/0001-Fixes-build-issues.patch b/recipes-ids/aide/aide/0001-Fixes-build-issues.patch
new file mode 100644
index 0000000..399df76
--- /dev/null
+++ b/recipes-ids/aide/aide/0001-Fixes-build-issues.patch
@@ -0,0 +1,37 @@
+From d7c7cb223ddb8b816332532c9d8f79f3ba16c911 Mon Sep 17 00:00:00 2001
+From: Scott Murray <scott.murray@konsulko.com>
+Date: Sun, 26 Apr 2026 05:15:36 +0300
+Subject: [PATCH] Fixes build issues
+
+Upstream-Status: Inappropriate [next version has many changes to configure.ac]
+Signed-off-by: Armin Kuster <akuster@mvista.com>
+(Updated for 0.19.3)
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ configure.ac | 3 +--
+ 1 file changed, 1 insertion(+), 2 deletions(-)
+
+diff --git a/configure.ac b/configure.ac
+index eb39aaa..c538c58 100644
+--- a/configure.ac
++++ b/configure.ac
+@@ -14,6 +14,7 @@ dnl The name of the configure h-file.
+ AC_CONFIG_HEADERS(include/config.h)
+ 
+ dnl Checks for programs.
++m4_pattern_allow([AC_MSG_ERROR])
+ AC_PROG_CC
+ if test "x$ac_cv_prog_cc_c99" = xno; then
+     AC_MSG_ERROR([AIDE needs a C99 compatible compiler])
+@@ -282,8 +283,6 @@ AC_CHECK_HEADERS(syslog.h inttypes.h fcntl.h ctype.h)
+ 
+ AIDE_PKG_CHECK_MANDATORY(pcre2, PCRE2, libpcre2-8)
+ 
+-AX_PTHREAD(compoptionstring="${compoptionstring}use pthread: mandatory\\n", [AC_MSG_ERROR([AIDE requires pthread])])
+-
+ AC_ARG_WITH([fstype],
+             AS_HELP_STRING([--without-fstype],
+             [Disable file system type support for restricted rules (Linux only)]),
+-- 
+2.47.3
+
diff --git a/recipes-ids/aide/aide/m4_allow.patch b/recipes-ids/aide/aide/m4_allow.patch
deleted file mode 100644
index 6f0b97b..0000000
--- a/recipes-ids/aide/aide/m4_allow.patch
+++ /dev/null
@@ -1,40 +0,0 @@
-Fixes build issues
-
-Upstream-Status: Inappropriate [next version has many changes to configure.ac]
-Signed-off-by: Armin Kuster <akuster@mvista.com>
-
-Index: aide-0.18.8/configure.ac
-===================================================================
---- aide-0.18.8.orig/configure.ac
-+++ aide-0.18.8/configure.ac
-@@ -14,6 +14,7 @@ dnl The name of the configure h-file.
- AC_CONFIG_HEADERS(include/config.h)
- 
- dnl Checks for programs.
-+m4_pattern_allow([AC_MSG_ERROR])
- AC_PROG_CC
- if test "x$ac_cv_prog_cc_c99" = xno; then
-     AC_MSG_ERROR([AIDE needs a C99 compatible compiler])
-@@ -246,6 +247,7 @@ if test "$aide_static_choice" != "yes";
- fi
- 
- dnl This macro is new in autoconf-2.13
-+m4_pattern_allow([AC_DEFINE])
- AC_SEARCH_LIBS(syslog, bsd socket inet, [AC_DEFINE(HAVE_SYSLOG,1,[syslog available?])])
- AC_CHECK_FUNCS(vsyslog)
- 
-@@ -320,14 +322,10 @@ fi
- AC_CHECK_HEADERS(syslog.h inttypes.h fcntl.h ctype.h)
- 
- AIDE_PKG_CHECK_MANDATORY(pcre2, PCRE2, libpcre2-8)
--
- AC_MSG_CHECKING(for pthread for multithreading)
- AC_ARG_WITH([pthread], AS_HELP_STRING([--with-pthread], [use pthread for multithreading (default: yes)]), [with_pthread=$withval], [with_pthread=yes])
- AC_MSG_RESULT([$with_pthread])
- compoptionstring="${compoptionstring}use pthread: $with_pthread\\n"
--AS_IF([test x"$with_pthread" = xyes], [
--    AX_PTHREAD([AC_DEFINE(WITH_PTHREAD,1,[use pthread])], [AC_MSG_ERROR([AIDE requires pthread])])
--])
- 
- AIDE_PKG_CHECK(zlib, zlib compression, yes, ZLIB, zlib)
- 
diff --git a/recipes-ids/aide/aide_0.18.8.bb b/recipes-ids/aide/aide_0.19.3.bb
similarity index 85%
rename from recipes-ids/aide/aide_0.18.8.bb
rename to recipes-ids/aide/aide_0.19.3.bb
index 2912cb2..9a94ce2 100644
--- a/recipes-ids/aide/aide_0.18.8.bb
+++ b/recipes-ids/aide/aide_0.19.3.bb
@@ -6,17 +6,17 @@ LICENSE = "GPL-2.0-only"
 DEPENDS = "bison-native libpcre2"
 
 SRC_URI = "https://github.com/aide/aide/releases/download/v${PV}/${BPN}-${PV}.tar.gz \
+           file://0001-Fixes-build-issues.patch \
            file://aide.conf \
-           file://m4_allow.patch \
-           "
+"
 
-SRC_URI[sha256sum] = "16662dc632d17e2c5630b801752f97912a8e22697c065ebde175f1cc37b83a60"
+SRC_URI[sha256sum] = "6513170bb5b8c22802dd1b72f02d8aa9f432aef2b4470522db03e755212a3f47"
 
 UPSTREAM_CHECK_URI = "https://github.com/${BPN}/${BPN}/releases"
 
 inherit autotools pkgconfig aide-base
 
-PACKAGECONFIG ??= " gcrypt zlib e2fsattrs posix capabilities curl pthread \
+PACKAGECONFIG ??= " nettle zlib e2fsattrs posix-acl capabilities curl \
                  ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux audit', '', d)} \
                  ${@bb.utils.contains('DISTRO_FEATURES', 'xattr', 'xattr', '', d)} \
                  "
@@ -25,12 +25,11 @@ PACKAGECONFIG[zlib] = "--with-zlib, --without-zlib, zlib, zlib "
 PACKAGECONFIG[xattr] = "--with-xattr, --without-xattr, attr, attr"
 PACKAGECONFIG[curl] = "--with-curl, --without-curl, curl, libcurl"
 PACKAGECONFIG[audit] = "--with-audit, --without-audit,audit"
-PACKAGECONFIG[gcrypt] = "--with-gcrypt, --without-gcrypt, libgcrypt, libgcrypt"
-PACKAGECONFIG[mhash] = "--with-mhash, --without-mhash, libmhash, libmhash"
+PACKAGECONFIG[gcrypt] = "--with-gcrypt, --without-gcrypt, libgcrypt, libgcrypt, , nettle"
+PACKAGECONFIG[nettle] = "--with-nettle, --without-nettle, nettle, nettle, , gcrypt"
 PACKAGECONFIG[e2fsattrs] = "--with-e2fsattrs, --without-e2fsattrs, e2fsprogs, e2fsprogs"
 PACKAGECONFIG[capabilities] = "--with-capabilities, --without-capabilities, libcap, libcap"
-PACKAGECONFIG[posix] = "--with-posix-acl, --without-posix-acl, acl, acl"
-PACKAGECONFIG[pthread] = "--with-pthread,"
+PACKAGECONFIG[posix-acl] = "--with-posix-acl, --without-posix-acl, acl, acl"
 
 do_install[nostamp] = "1"
 
-- 
2.53.0


