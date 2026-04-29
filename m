Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487F9CD13D9
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 15:40:21 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14376.1777477218676979800
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 08:40:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IZbs5nMX;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8f231f3b130so468423485a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777477217; x=1778082017; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waT8nCjXZ0YVg5AkwwPlnWHiZxz7q4e9qIjtXzJhL3A=;
        b=IZbs5nMXZw3Jn86IHALIC3UzxXSfufKmACKcSVgLmxj1ehoW+41IecYfylgbfaY+d2
         D4QeY/Wzth7uf5B/T1uB83lUdjgIksMkIc/qmp1TM2jo0aCXETNcHUj0XI1ADFYaMqm/
         h0uCmwXDsnp3B2N2dIwkJF1GVHFC7nbyLXSHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477217; x=1778082017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=waT8nCjXZ0YVg5AkwwPlnWHiZxz7q4e9qIjtXzJhL3A=;
        b=ApaF/b1La+8/jjlEuAP+cI0VRHisjlw7ynhPlsjUdV5/h/oc+fQK6gjQk5wHBvoCSj
         U9NY+bYVQUPJ3ADcobXiojaCh1Wd3gQ90o0nqur/fNbkDGOJ4tSvANbtSAl2iilSr0UG
         vKpIvclCvevhtBEDrDgC8GgoaK3FSYemB/lZ9PTrZMl4mc71D7RaT9V4mTubKPavKkL+
         gWuiOg0S7YRu3hmsaLzehI3u3YzImsDmpTYeHyyOdWWx79T39In25GOzAb7Jg8KE6LAq
         CU1trUSLcV0NlcC88Q0GWodEp4x7cz727jJPUq1UyQ24+ItNmcQqM3k/q7ejyXtf62Fm
         M/jQ==
X-Gm-Message-State: AOJu0YzpTab5z41S2gtZm/ab/0frrCivuN6Ej3jEv/w96Svi70KvT08z
	huyKnUhIFMCw6jJiEaK+pWfwseaV3oTRiVcwWSFOLnJWFnk/kDuf83YlwCSK/jrEZd391JB46YH
	IuZxO
X-Gm-Gg: AeBDieuexTYuQFkeHTpw4rnCObWVt7HhBm12N0o/DNGi0frAaRHyTy9jrItFa6+RwYz
	7WGhpUterNHVGxgHLJS1AsrqdTwgQJZrhMCdZcrVVqWowkxS1noDrZdHyn2/946CFcKAZvZTc9v
	QY8AOSwA1nxoDeZCwtRrdTXkXoo0AJjkdoTEnrAD73QUzuiych7NN7MVRMtM+Slqe9JcSXiNx+3
	YzT6ftb0N+ScAGCma9sb2OlRu9seI2Jalx5DAsClT33YSxuPiL4zfaA4n51YhrFMZ9ESS+6Fvfx
	9cv3u2ZBhxLw6QFUie96opXCjHEvkpnVIC3tIqO+tmsInustRInptWfnjrCDwMnoH5XaDSRqJXc
	jPQE5guQLCRfNWkQrlCCWdc+Jch0BmLM15VNt9dn3Jm5fGxZPpYL50Q9enAZOLhzKnQ86gFgPpG
	eD7guBdS7yKXxKnJK75s4ENeYp08NIinfQcgtyQQPeSpI4ASZi59uOSPf6qazzAV51mzcaygzhV
	kARpE0u6TROr/KkqFAtB9PBHjMjrb12eKhP1RnEYKnjcwbY+KO3qhcv+pgyrly2wOW6SQO85ns=
X-Received: by 2002:a05:620a:45ab:b0:8e3:4182:6c4e with SMTP id af79cd13be357-8f8f628fd53mr675433985a.49.1777477217171;
        Wed, 29 Apr 2026 08:40:17 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940340f1csm207924185a.44.2026.04.29.08.40.16
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:40:16 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 09/13] libmhash: Remove
Date: Wed, 29 Apr 2026 11:39:39 -0400
Message-ID: <ffdbb6dffd7460fde0e9a8a3add2cc2da2ca065d.1777476608.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777476608.git.scott.murray@konsulko.com>
References: <cover.1777476608.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 15:40:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3883

Remove libmhash, as it is no longer required to build aide.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../include/maintainers-meta-security.inc     |  1 -
 .../packagegroup-core-security.bb             |  1 -
 recipes-security/libmhash/files/Makefile.test | 13 -----
 recipes-security/libmhash/files/mhash.c       | 32 -------------
 recipes-security/libmhash/files/run-ptest     | 12 -----
 recipes-security/libmhash/libmhash_0.9.9.9.bb | 47 -------------------
 6 files changed, 106 deletions(-)
 delete mode 100644 recipes-security/libmhash/files/Makefile.test
 delete mode 100644 recipes-security/libmhash/files/mhash.c
 delete mode 100644 recipes-security/libmhash/files/run-ptest
 delete mode 100644 recipes-security/libmhash/libmhash_0.9.9.9.bb

diff --git a/conf/distro/include/maintainers-meta-security.inc b/conf/distro/include/maintainers-meta-security.inc
index 8bde7bd..3aac2cb 100644
--- a/conf/distro/include/maintainers-meta-security.inc
+++ b/conf/distro/include/maintainers-meta-security.inc
@@ -37,7 +37,6 @@ RECIPE_MAINTAINER:pn-keyutils = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-libaes-siv = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-libgssglue = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-libhtp = "Scott Murray <scott.murray@konsulko.com>"
-RECIPE_MAINTAINER:pn-libmhash = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-lib-perl = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-libseccomp = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-libwhisker2-perl = "Scott Murray <scott.murray@konsulko.com>"
diff --git a/recipes-core/packagegroup/packagegroup-core-security.bb b/recipes-core/packagegroup/packagegroup-core-security.bb
index d3d3d7e..101bc6d 100644
--- a/recipes-core/packagegroup/packagegroup-core-security.bb
+++ b/recipes-core/packagegroup/packagegroup-core-security.bb
@@ -39,7 +39,6 @@ RDEPENDS:packagegroup-security-utils = "\
     glome \
     keyutils \
     libgssglue \
-    libmhash \
     nmap \
     pinentry \
     softhsm \
diff --git a/recipes-security/libmhash/files/Makefile.test b/recipes-security/libmhash/files/Makefile.test
deleted file mode 100644
index 2e32626..0000000
--- a/recipes-security/libmhash/files/Makefile.test
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# Makefile for compiling mhash tests
-#
-
-ALL = mhash
-
-all: $(ALL)
-
-mhash: mhash.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -o mhash mhash.c -lmhash
-
-clean:
-	rm -f *.debug $(ALL)
diff --git a/recipes-security/libmhash/files/mhash.c b/recipes-security/libmhash/files/mhash.c
deleted file mode 100644
index 5d123cc..0000000
--- a/recipes-security/libmhash/files/mhash.c
+++ /dev/null
@@ -1,32 +0,0 @@
-#include <mhash.h>
-#include <stdio.h>
-
-int main()
-{
-
-       char password[] = "Jefe";
-       int keylen = 4;
-       char data[] = "what do ya want for nothing?";
-       int datalen = 28;
-       MHASH td;
-       unsigned char mac[16];
-       int j;
-
-       td = mhash_hmac_init(MHASH_MD5, password, keylen, mhash_get_hash_pblock(MHASH_MD5));
-
-       mhash(td, data, datalen);
-       mhash_hmac_deinit(td, mac);
-
-/*
- * The output should be 0x750c783e6ab0b503eaa86e310a5db738
- * according to RFC 2104.
- */
-
-       printf("0x");
-       for (j = 0; j < mhash_get_block_size(MHASH_MD5); j++) {
-               printf("%.2x", mac[j]);
-       }
-       printf("\n");
-
-       exit(0);
-}
diff --git a/recipes-security/libmhash/files/run-ptest b/recipes-security/libmhash/files/run-ptest
deleted file mode 100644
index 2b0b94a..0000000
--- a/recipes-security/libmhash/files/run-ptest
+++ /dev/null
@@ -1,12 +0,0 @@
-#!/bin/sh
-
-OUTPUT=$($(dirname $0)/mhash)
-MHASH_MD5="0x750c783e6ab0b503eaa86e310a5db738"
-
-if [ x"$OUTPUT" = x"$MHASH_MD5" ]; then
-    echo "PASS: mhash ptest"
-    exit 0
-else
-    echo "FAIL: mhash ptest"
-    exit 1
-fi
diff --git a/recipes-security/libmhash/libmhash_0.9.9.9.bb b/recipes-security/libmhash/libmhash_0.9.9.9.bb
deleted file mode 100644
index 7c7fb11..0000000
--- a/recipes-security/libmhash/libmhash_0.9.9.9.bb
+++ /dev/null
@@ -1,47 +0,0 @@
-SUMMARY = "Library of hashing algorithms."
-DESCRIPTION = "\
-  Mhash is a free (under GNU Lesser GPL) library \
-  which provides a uniform interface to a large number of hash \
-  algorithms. These algorithms can be used to compute checksums, \
-  message digests, and other signatures. \
-  "
-HOMEPAGE = "http://mhash.sourceforge.net/"
-
-LICENSE = "LGPL-2.0-only"
-LIC_FILES_CHKSUM = "file://COPYING;md5=3bf50002aefd002f49e7bb854063f7e7"
-
-S = "${UNPACKDIR}/mhash-${PV}"
-
-SECTION = "libs"
-
-SRC_URI = "${SOURCEFORGE_MIRROR}/mhash/mhash-${PV}.tar.bz2 \
-    file://Makefile.test \
-    file://mhash.c \
-    file://run-ptest \
-    "
-
-SRC_URI[md5sum] = "f91c74f9ccab2b574a98be5bc31eb280"
-SRC_URI[sha256sum] = "56521c52a9033779154432d0ae47ad7198914785265e1f570cee21ab248dfef0"
-
-UPSTREAM_CHECK_URI = "https://sourceforge.net/projects/mhash/files/"
-
-inherit autotools-brokensep ptest multilib_header
-
-CFLAGS += "-std=gnu17"
-
-do_install:append() {
-    oe_multilib_header mutils/mhash_config.h
-}
-
-do_compile_ptest() {
-    if [ ! -d ${S}/demo ]; then mkdir ${S}/demo; fi
-    cp ${UNPACKDIR}/Makefile.test ${S}/demo/Makefile
-    cp ${UNPACKDIR}/mhash.c ${S}/demo/
-    make -C ${S}/demo CFLAGS="${CFLAGS} -I${S}/include/" LDFLAGS="${LDFLAGS} -L${S}/lib/.libs"
-}
-
-do_install_ptest() {
-    install -m 0755 ${S}/demo/mhash ${D}${PTEST_PATH}
-}
-
-BBCLASSEXTEND = "native"
-- 
2.53.0


