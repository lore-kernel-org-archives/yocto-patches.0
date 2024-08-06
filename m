Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A461AC49EA1
	for <webhook@archiver.kernel.org>; Tue,  6 Aug 2024 13:31:50 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.web10.7314.1722951101561893920
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 06 Aug 2024 06:31:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TQ2pN3sv;
 spf=pass (domain: gmail.com, ip: 209.85.128.176, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-65f7bd30546so6455107b3.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 06 Aug 2024 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722951100; x=1723555900; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ablWwM8IMngF9fgr1rbx5/iQydt6RLHPNVESsx1ko7E=;
        b=TQ2pN3svHUgzK4Ghs+VLg4RNuAQnb1bVd708ThX5SgmTfxq/1cqEX9JtIxCTvZhSVa
         tvfuSNTJbiQXfde/jM6jLEp+zYSPW2nlZmgRoYs5uujTXy3KEVoqUjIPKah2t3KSxl1m
         U/VL8fr5wVzgRkL6yvtONuOgfLcGw5Z413w8qvBQK8m62My9Nxr8hBldVGKTUy82X/I0
         OoFp+nHNqhs3csFo5RJ0+qPKj1XPwgkMFkOnYzcM/Qb9XS8s+fvQQlsxXLlIzBVCghAa
         D1iOj11tSyafp4POOrWFCy5No6qk5N32lngTEBWMzV/qMe9LHSgpmtp+HZT1gugSedgk
         MUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722951100; x=1723555900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ablWwM8IMngF9fgr1rbx5/iQydt6RLHPNVESsx1ko7E=;
        b=i+hSeQcsHL0G76Xi/4uNEiQcqruP537zHcjVL0JCvbOU5ujF1eXjOLRMxKsJUxPLSa
         /zVEIIdUURJDD7Bf84px265bdOqiYNRUhyOz18UUXzCaTU6gmQzLzOzhgAgegYM67MBQ
         TTXdxd3kk4YB2B9mFHQ+cHOiijfcC5aQK+YblImReeoWqZUry9humiGsNJfYxCUFz75r
         fT0YUYdqjzvmGDCIhEyp+kV6wVSSw+TeWbHfDLIrG+zSWl5A/Ovurz1Q3hfPYz3KYgDf
         9JG9UlNouLAR/eFbDdsq48XzVo6nrq+j/92iyza5SqOMWHpBaaMYOhAeythczICfBadg
         7vSg==
X-Gm-Message-State: AOJu0YzneENpOG1WfQo4uz3F4ivgXBmMVkkr4/yHd3a7wYJrGhdYylrt
	Oc1TQHAY0fh9uxfyB3iNjGX2nvGs0J0//g6u/Xhkxtaa9MPugPP/fu1SJA==
X-Google-Smtp-Source: AGHT+IF/Ke2vQ8iFvHSQVso0Woty45W/SRSTCxs2AdwBqbeMj9DBYljHTt8CSbw7PlNoNj47qupcpQ==
X-Received: by 2002:a81:bb45:0:b0:65c:8dfb:fa04 with SMTP id 00721157ae682-68960c5007cmr117617117b3.14.1722951100475;
        Tue, 06 Aug 2024 06:31:40 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:4300:30cd:ed94:a289])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a136bfbb0sm15397517b3.124.2024.08.06.06.31.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:31:40 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] aide: update to latest stable.
Date: Tue,  6 Aug 2024 09:31:39 -0400
Message-Id: <20240806133139.786953-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 Aug 2024 13:31:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/512

address new configure error.
Enable pthread always
mhash is being dropped in the next release so switch to gcrypt for now.

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 recipes-ids/aide/aide/m4_allow.patch          | 40 +++++++++++++++++++
 .../aide/{aide_0.17.4.bb => aide_0.18.8.bb}   | 12 +++---
 2 files changed, 47 insertions(+), 5 deletions(-)
 create mode 100644 recipes-ids/aide/aide/m4_allow.patch
 rename recipes-ids/aide/{aide_0.17.4.bb => aide_0.18.8.bb} (88%)

diff --git a/recipes-ids/aide/aide/m4_allow.patch b/recipes-ids/aide/aide/m4_allow.patch
new file mode 100644
index 0000000..6f0b97b
--- /dev/null
+++ b/recipes-ids/aide/aide/m4_allow.patch
@@ -0,0 +1,40 @@
+Fixes build issues
+
+Upstream-Status: Inappropriate [next version has many changes to configure.ac]
+Signed-off-by: Armin Kuster <akuster@mvista.com>
+
+Index: aide-0.18.8/configure.ac
+===================================================================
+--- aide-0.18.8.orig/configure.ac
++++ aide-0.18.8/configure.ac
+@@ -14,6 +14,7 @@ dnl The name of the configure h-file.
+ AC_CONFIG_HEADERS(include/config.h)
+ 
+ dnl Checks for programs.
++m4_pattern_allow([AC_MSG_ERROR])
+ AC_PROG_CC
+ if test "x$ac_cv_prog_cc_c99" = xno; then
+     AC_MSG_ERROR([AIDE needs a C99 compatible compiler])
+@@ -246,6 +247,7 @@ if test "$aide_static_choice" != "yes";
+ fi
+ 
+ dnl This macro is new in autoconf-2.13
++m4_pattern_allow([AC_DEFINE])
+ AC_SEARCH_LIBS(syslog, bsd socket inet, [AC_DEFINE(HAVE_SYSLOG,1,[syslog available?])])
+ AC_CHECK_FUNCS(vsyslog)
+ 
+@@ -320,14 +322,10 @@ fi
+ AC_CHECK_HEADERS(syslog.h inttypes.h fcntl.h ctype.h)
+ 
+ AIDE_PKG_CHECK_MANDATORY(pcre2, PCRE2, libpcre2-8)
+-
+ AC_MSG_CHECKING(for pthread for multithreading)
+ AC_ARG_WITH([pthread], AS_HELP_STRING([--with-pthread], [use pthread for multithreading (default: yes)]), [with_pthread=$withval], [with_pthread=yes])
+ AC_MSG_RESULT([$with_pthread])
+ compoptionstring="${compoptionstring}use pthread: $with_pthread\\n"
+-AS_IF([test x"$with_pthread" = xyes], [
+-    AX_PTHREAD([AC_DEFINE(WITH_PTHREAD,1,[use pthread])], [AC_MSG_ERROR([AIDE requires pthread])])
+-])
+ 
+ AIDE_PKG_CHECK(zlib, zlib compression, yes, ZLIB, zlib)
+ 
diff --git a/recipes-ids/aide/aide_0.17.4.bb b/recipes-ids/aide/aide_0.18.8.bb
similarity index 88%
rename from recipes-ids/aide/aide_0.17.4.bb
rename to recipes-ids/aide/aide_0.18.8.bb
index 9d998cc..e2014a1 100644
--- a/recipes-ids/aide/aide_0.17.4.bb
+++ b/recipes-ids/aide/aide_0.18.8.bb
@@ -3,18 +3,20 @@ HOMEPAGE = "https://aide.github.io"
 LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"
 LICENSE = "GPL-2.0-only"
 
-DEPENDS = "bison-native libpcre"
+DEPENDS = "bison-native libpcre2"
 
 SRC_URI = "https://github.com/aide/aide/releases/download/v${PV}/${BPN}-${PV}.tar.gz \
-           file://aide.conf"
+           file://aide.conf \
+           file://m4_allow.patch \
+           "
 
-SRC_URI[sha256sum] = "c81505246f3ffc2e76036d43a77212ae82895b5881d9b9e25c1361b1a9b7a846"
+SRC_URI[sha256sum] = "16662dc632d17e2c5630b801752f97912a8e22697c065ebde175f1cc37b83a60"
 
 UPSTREAM_CHECK_URI = "https://github.com/${BPN}/${BPN}/releases"
 
 inherit autotools pkgconfig aide-base
 
-PACKAGECONFIG ??=" mhash zlib e2fsattrs posix capabilities curl \
+PACKAGECONFIG ??=" gcrypt zlib e2fsattrs posix capabilities curl pthread \
                  ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux audit', '', d)} \
                  ${@bb.utils.contains('DISTRO_FEATURES', 'xattr', 'xattr', '', d)} \
                  "
@@ -28,7 +30,7 @@ PACKAGECONFIG[mhash] = "--with-mhash, --without-mhash, libmhash, libmhash"
 PACKAGECONFIG[e2fsattrs] = "--with-e2fsattrs, --without-e2fsattrs, e2fsprogs, e2fsprogs"
 PACKAGECONFIG[capabilities] = "--with-capabilities, --without-capabilities, libcap, libcap"
 PACKAGECONFIG[posix] = "--with-posix-acl, --without-posix-acl, acl, acl"
-
+PACKAGECONFIG[pthread] = "--with-pthread,"
 
 do_install[nostamp] = "1"
 
-- 
2.34.1


