Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F03CCD199
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:55 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web10.1667.1760649765875564574
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BFknYYvD;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-81fdd5d7b59so18206186d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649765; x=1761254565; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj6ILYVbxPB99XAaAHspcZThwBKY7Z3nBxU0teCUFO8=;
        b=BFknYYvDkVfKqlBA/9P6qwmh/lix746dt0coxQYwRA1HLL/mkDAsEt1M90E938lcdC
         JEb+z5lNae8ch7dE6/CLEs+dCDHUJ9QGwudzksQNgm7l35k6DyBbbtL0VxOE4mLEqD7A
         V3tN9ceLTDyFfYuQP5gLbVducOI4rwKF+FsFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649765; x=1761254565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj6ILYVbxPB99XAaAHspcZThwBKY7Z3nBxU0teCUFO8=;
        b=PJkelQURRgz5+VjtvFnnkbWR/9yFtD4fUmdp+rEHP4lqdiRdylznhZC3SndxgX75Oh
         t7FHsMrp5HStT68hTepJ05ODpD4XDywypEHzv80CjzSe5OhzNbVp5LHkpB7ehWMIJu8g
         SZTGpYQHRP+Nl2T5h5IH9E4uNQmc7UpwOfZkFb+sdCf8cmOKQwsExICQtViR/IYf62kt
         4CXRmnJX87A6AWGUhuN4/2jsVUgbmcq1iJXatunLJFB5WVFd58CbdjCiUp/xcMszt+6u
         /nFtN8eQAWmOILwg6cDG1SNAOqvW4wvR8hOya8J3h267S5PYvyTed3YeC932DJBZQMHb
         I85A==
X-Gm-Message-State: AOJu0Yy6dZ/wzivKrY6Ylk5ZhDN2G+SM6GqAmW2COzpiFy1Dbk/CkmeK
	MxTgBzPnbrXEU3Y7Et8eQyKZFERCLRsZtNkrUTSdHJ+B9WJFjPQMxFSlHkLlvCULtwgDy0NlJmY
	/S4+H
X-Gm-Gg: ASbGncuxdxO9ZHW2nFkW1XhKvfRrXpRsL9piXCnl2oX4YtVoQqBPTIJCYmB7lmTY8E2
	cj3cLoZaOzQ5y8hpghds0XZcLKfA9Vj0LGnZVLhcxAKATJ9gmgM/t2/c3o01Elk/mCV/21I+MUI
	Ugqfo1nvEKiwZCN3MDqLjTKmRiSIHVYr5EY6m5uU+VSfk9y/InqqgdgChT30T13X05p3OPfa/4a
	L3s9HXpKs+LQ6xoiohmT49qR1+DgqmTRK5DMH/jXVbb/x7i2NESi/e8gmuOIf/7XT9n5XQAspRM
	YJTcUSHLzfRZbXK+hc9/T526RVo4fRQuuRavUdXg0N3I+qcWt1woQ0PZM3Z+mltWx5+gfT6COqf
	yTzGraUMN9jPyr4+DnS9Wv2pq6BdtQ+pvP6KHQ9nyQh2QaQZ6CyTnQ+fgRH8/sgUGvHDlJHOSt3
	qDCgyxUD8whdLY2nWyQmpiU+Njt2mJZcJdjc9r9Pyw0O/plZOBu9y6
X-Google-Smtp-Source: AGHT+IFcMQC32eMkKSn8ClzCVRAhH/oSGNozcYcfuktubRUItznlCvxZOT1MVNeZfLbWJIk3qw3CXA==
X-Received: by 2002:a05:6214:2a8d:b0:7f7:777e:39c5 with SMTP id 6a1803df08f44-87c2056890amr31940836d6.25.1760649764365;
        Thu, 16 Oct 2025 14:22:44 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:43 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 13/15] paxctl: Remove recipe
Date: Thu, 16 Oct 2025 17:22:12 -0400
Message-ID: <65083a6a01d42f3bbe0d9aa50326f2000b1d097d.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2338

Remove the paxctl recipe since it has seemingly been broken for a
while without anyone noticing, and there likely have been no actual
users since grsecurity stopped doing public releases in 2017.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../include/maintainers-meta-security.inc     |  1 -
 docs/overview.txt                             | 27 -------------
 .../packagegroup-core-security.bb             |  1 -
 ...ckage-error-if-DESTDIR-is-set-to-usr.patch | 26 ------------
 recipes-security/paxctl/paxctl_0.9.bb         | 40 -------------------
 5 files changed, 95 deletions(-)
 delete mode 100644 recipes-security/paxctl/paxctl/0001-To-fix-package-error-if-DESTDIR-is-set-to-usr.patch
 delete mode 100644 recipes-security/paxctl/paxctl_0.9.bb

diff --git a/conf/distro/include/maintainers-meta-security.inc b/conf/distro/include/maintainers-meta-security.inc
index 903bb9b..6f13ea9 100644
--- a/conf/distro/include/maintainers-meta-security.inc
+++ b/conf/distro/include/maintainers-meta-security.inc
@@ -44,7 +44,6 @@ RECIPE_MAINTAINER:pn-libseccomp = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-libwhisker2-perl = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-ncrack = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-nikto = "Scott Murray <scott.murray@konsulko.com>"
-RECIPE_MAINTAINER:pn-paxctl = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-python3-fail2ban = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-python3-scapy = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-python-fail2ban = "Scott Murray <scott.murray@konsulko.com>"
diff --git a/docs/overview.txt b/docs/overview.txt
index ed3135a..eb87279 100644
--- a/docs/overview.txt
+++ b/docs/overview.txt
@@ -103,33 +103,6 @@ help for each package.
                 usage : simply invoke the script name in the terminal.
 
 
-        == pax-utils ==
-
-		( This package can be found in oe-core )
-
-        pax-utils is a small set of various PaX aware and related utilities for
-        ELF binaries.
-
-        - scanelf : With this application you can print out information specific to the ELF structure of a binary.
-                    For more help please consult the man pages or the readme file.
-
-        - pspax : is a user-space utility that scans the proc directory and list
-                  ELF types, as well as their respective PaX flags and filenames and
-                  attributes. Depending on build options, it may additionaly display the
-                  process running set of capabilities.
-
-        - scanmacho : is a user-space utility to quickly scan given
-                      Mach-Os, directories, or common system paths for different information. This
-                      may include Mach-O types, their install_names, etc.
-
-        - dumpelf : is a user-space utility to dump all of the internal
-                    ELF structures into the equivalent C structures for fun debugging and/or
-                    reference purposes.
-
-
-                usage : simply invoke the script name in the terminal.
-
-
         == buck-security ==
 
         Buck-Security is a security scanner for Debian and Ubuntu Linux. It runs a couple of important checks and helps you to harden your Linux
diff --git a/recipes-core/packagegroup/packagegroup-core-security.bb b/recipes-core/packagegroup/packagegroup-core-security.bb
index 3f5b0a5..7fb7b62 100644
--- a/recipes-core/packagegroup/packagegroup-core-security.bb
+++ b/recipes-core/packagegroup/packagegroup-core-security.bb
@@ -42,7 +42,6 @@ RDEPENDS:packagegroup-security-utils = "\
     sshguard \
     ${@bb.utils.contains("DISTRO_FEATURES", "seccomp ", "libseccomp", "",d)} \
     ${@bb.utils.contains("DISTRO_FEATURES", "pam", "google-authenticator-libpam", "",d)} \
-    ${@bb.utils.contains("DISTRO_FEATURES", "pax", "pax-utils packctl", "",d)} \
     "
 
 have_krill =  "${@bb.utils.contains("DISTRO_FEATURES", "pam", "krill", "",d)}"
diff --git a/recipes-security/paxctl/paxctl/0001-To-fix-package-error-if-DESTDIR-is-set-to-usr.patch b/recipes-security/paxctl/paxctl/0001-To-fix-package-error-if-DESTDIR-is-set-to-usr.patch
deleted file mode 100644
index 451cb7f..0000000
--- a/recipes-security/paxctl/paxctl/0001-To-fix-package-error-if-DESTDIR-is-set-to-usr.patch
+++ /dev/null
@@ -1,26 +0,0 @@
-From 824c5d7b96aeef1b4e182f657ac002bed6e14cd5 Mon Sep 17 00:00:00 2001
-From: Lei Maohui <leimaohui@fujitsu.com>
-Date: Thu, 31 Aug 2023 08:20:56 +0000
-Subject: [PATCH] To fix package error if DESTDIR is set to /usr.
-
-Upstream-Status: Inappropriate
-Signed-off-by: Lei Maohui <leimaohui@fujitsu.com>
----
- Makefile | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/Makefile b/Makefile
-index 0d7bc0c..46fd664 100644
---- a/Makefile
-+++ b/Makefile
-@@ -19,7 +19,7 @@ $(PROG).o: $(PROG).c $(PROG).h $(PROG)-elf.c
-
- install: $(PROG)
- #	$(MKDIR) $(DESTDIR)/sbin $(DESTDIR)$(MANDIR)
--	$(INSTALL) -D --owner 0 --group 0 --mode a=rx $(PROG) $(DESTDIR)/sbin/$(PROG)
-+	$(INSTALL) -D --owner 0 --group 0 --mode a=rx $(PROG) $(DESTDIR)/usr/sbin/$(PROG)
-	$(INSTALL) -D --owner 0 --group 0 --mode a=r $(PROG).1 $(DESTDIR)/$(MANDIR)/$(PROG).1
-
- clean:
---
-2.34.1
diff --git a/recipes-security/paxctl/paxctl_0.9.bb b/recipes-security/paxctl/paxctl_0.9.bb
deleted file mode 100644
index 3d2f2a3..0000000
--- a/recipes-security/paxctl/paxctl_0.9.bb
+++ /dev/null
@@ -1,40 +0,0 @@
-DESCRIPTION = "paxctl  is  a tool that allows PaX flags to be modified on a \
-               per-binary basis. PaX is part of common  security-enhancing  \
-               kernel  patches  and secure distributions, such as \
-               GrSecurity or Adamantix and Hardened Gen-too, respectively."
-HOMEPAGE = "https://pax.grsecurity.net/"	       
-LICENSE = "GPL-2.0-only"
-LIC_FILES_CHKSUM = "file://paxctl.c;beginline=1;endline=5;md5=0ddd065c61020dda79729e6bedaed2c7 \
-                    file://paxctl-elf.c;beginline=1;endline=5;md5=99f453ce7f6d1687ee808982e2924813 \
-		   "
-
-SRC_URI = "http://pax.grsecurity.net/${BP}.tar.gz \
-           file://0001-To-fix-package-error-if-DESTDIR-is-set-to-usr.patch \
-"
-
-SRC_URI[md5sum] = "9bea59b1987dc4e16c2d22d745374e64"
-SRC_URI[sha256sum] = "a330ddd812688169802a3ba29e5e3b19956376b8f6f73b8d7e9586eb04423c2e"
-
-EXTRA_OEMAKE = "CC='${CC}' DESTDIR='${D}'"
-
-do_install() {
-	oe_runmake install
-}
-
-# The install target in the Makefile will fail for paxctl-native with error:
-#   install -D --owner 0 --group 0 --mode a=rx paxctl .../sbin/paxctl
-#   install: cannot change ownership of '.../sbin/paxctl': \
-#   Operation not permitted
-# Drop '--owner 0 --group 0' to fix the issue.
-do_install:class-native() {
-	local PROG=paxctl
-	install -d ${D}${base_sbindir}
-	install -d ${D}${mandir}/man1
-	install --mode a=rx $PROG ${D}${base_sbindir}/$PROG
-	install --mode a=r $PROG.1 ${D}${mandir}/man1/$PROG.1
-}
-
-# Avoid QA Issue: No GNU_HASH in the elf binary
-INSANE_SKIP:${PN} = "ldflags" 
-
-BBCLASSEXTEND = "native"
-- 
2.51.0


