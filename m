Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2288C5DF97
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:59:03 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22442.1787777938925603796
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=G9EmSUSR;
 spf=pass (domain: konsulko.com, ip: 209.85.160.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-52d590ce5cdso107551cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777938; x=1788382738; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5YsrYyLH1PtsYrEVzvnEREoheTcl8kBBgPoyHGeW8xI=;
        b=G9EmSUSRANa3e8GKxL6LV6tCKGfX98r5PhqYciN5KTsdSsVjzpbDQ6Z0kPO5zGjuws
         nwsBFw6e9ZVyZWrJiXPvGhWegOUskClzaPRBUzpTz3CjLod+JWpnGzOqnlWhuY51QC/2
         DQUY68HLnpBEVVaIMYbofDvXa84+a4F9yEiww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777938; x=1788382738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5YsrYyLH1PtsYrEVzvnEREoheTcl8kBBgPoyHGeW8xI=;
        b=CGsWczFIGtZ9ih494GtNbuffUPZp2NJ4xTKTDfypUXhkikyYbWR7b4KnnxsgCp0YzC
         aaxxI0+rsykQiqQI+M+L6lwYEO5o08KFPcE8xaPb4uBuCvsPAVbEEOgYUDIREbrE3Ahx
         F1ZjYugj8nPSJLVDDQDdcGzzzERrpD/sfcPo/+s2Bnyd0OJMj+o6Y0W9RrNh7qBIuNu8
         qyLqfomTt0f3H3b8/73qtQHS7dMjs4doj07svkd0p4/E5EZ/GPEukwQPNf4c+Varb3M8
         nkBgnf5dOWVo/6V74OhAtBVKwEeMJhexrZkpLkMTBxVh9huR2xcP73aThas3E8d+OI/C
         i5ow==
X-Gm-Message-State: AFuF++n9jzqN8VlG+jctgpWR7QhXAUYG3IC5ReuIjkLlk8v45XboTTvK
	7YDy1bJcyE1Hkym4BLZJLmcjZpM4HAU6UX0fU3xm5j1ATbhddS3/Cg14G1x13UcH+3hhcqAyBhr
	K1llO
X-Gm-Gg: AR+sD10vcjTvE6+v/oSvSbXKNQ4UcgIxILvd2JJNINSl1tHo3YxWUyqRz2sdrIakFOW
	x6Ezm3uUw3mDLcmBmgp8tgdYoBLhDkWc12JtakkQh+CGEXGm+PoCwQSOv0H7rY5/JsxMdHt8n8+
	cBswNC6Hi+9Mm6V6EahXY/ffPaHt4+RfhxOr6YKMNJu2HZy2BQ6Ky7Pz2qp6wVybWa0PxDa/0Pc
	t5hoZR4aRlFhqNFDVi7lxMCYbJp0r1ZtQMR1Mz06kHjkT787W7xJDjqJYd1Tuwgzv9XsGFfflf6
	vH8NAEuiP9ce5hUbzaMr3F8pyvYvWOZoUc1cwg7PUblgCP/0c0hObxhoLgw3UxH3AJzGhg+7bmC
	15uhHLK2OOhaIRRdoX5kRiRb5doe/FoIdwVMM01ICHNIb/PxYR+fESOFioh2U/bOxg4cHHsF+YX
	ceLNMeZ51eHHdlG4Zq27YmxBuWwuJBEIP6Pu3SqgbtBoofSG3bmsbuYSzkg5sH+EWEBaghc61tM
	khJAK3jN9+Bb1fOdHpSN/bEKHPKWTGfbIuT4cfB0lGCGVHd7Tkewr9A+/waY3EIuaxlNWY0Gg2K
	f3S6V/vOpP/Q7veVnBlVJbE+cwp42KFIHTzw
X-Received: by 2002:a05:622a:1303:b0:50d:e471:2d1e with SMTP id d75a77b69052e-52e42371acamr106692221cf.35.1787777937677;
        Wed, 26 Aug 2026 13:58:57 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:57 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 15/15] aide: Fix unstable install task hash
Date: Wed, 26 Aug 2026 16:57:49 -0400
Message-ID: <0339b65f63877ed36fcffa44953e57c3bb969ca9.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:59:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4707

From: Esa Jaaskela <esa.jaaskela@suomi24.fi>

The installation task hash for the aide is marked as nostamp. This is
done because the native task installs files outside the sysroot, to the
Aide staging directory. Those files are not captured by
do_populate_sysroot, so they are missing whenever the task is skipped or
restored from sstate.

Install the required native contents to the sysroot, and then customise
and deploy the configuration file in the aide_init_db rootfs postprocess
function that utilizes the files. The configuration file needs to be
reset every time the function is run to avoid using stale
configurations.

Staging the native files through the sysroot makes the nostamp
unnecessary, so remove it along with the unstable task hash it caused.

Signed-off-by: Esa Jaaskela <esa.jaaskela@suomi24.fi>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/aide-db-init.bbclass    | 11 +++++++++--
 recipes-ids/aide/aide_0.19.3.bb | 13 ++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/classes/aide-db-init.bbclass b/classes/aide-db-init.bbclass
index 800006f..3fe2c27 100644
--- a/classes/aide-db-init.bbclass
+++ b/classes/aide-db-init.bbclass
@@ -31,6 +31,13 @@
 inherit aide-base 
 
 aide_init_db() {
+    install -d ${STAGING_AIDE_DIR}/lib/logs
+    rm -f ${STAGING_AIDE_DIR}/aide.conf ${STAGING_AIDE_DIR}/lib/aide.db ${STAGING_AIDE_DIR}/lib/aide.db.gz ${STAGING_AIDE_DIR}/lib/logs/aide.log
+    install ${STAGING_DATADIR_NATIVE}/aide/aide.conf ${STAGING_AIDE_DIR}/
+
+    sed -i -s "s:\@\@define DBDIR.*:\@\@define DBDIR ${STAGING_AIDE_DIR}/lib:" ${STAGING_AIDE_DIR}/aide.conf
+    sed -i -e "s:\@\@define LOGDIR.*:\@\@define LOGDIR ${STAGING_AIDE_DIR}/lib/logs:" ${STAGING_AIDE_DIR}/aide.conf
+
     for dir in ${AIDE_INCLUDE_DIRS}; do
         echo "${IMAGE_ROOTFS}${dir} NORMAL" >> ${STAGING_AIDE_DIR}/aide.conf
     done
@@ -39,7 +46,7 @@ aide_init_db() {
     done
 
 
-    ${STAGING_AIDE_DIR}/bin/aide -c ${STAGING_AIDE_DIR}/aide.conf --init
+    ${STAGING_BINDIR_NATIVE}/aide -c ${STAGING_AIDE_DIR}/aide.conf --init
     gunzip ${STAGING_AIDE_DIR}/lib/aide.db.gz 
     # strip out native path
     sed -i -e 's:${IMAGE_ROOTFS}::' ${STAGING_AIDE_DIR}/lib/aide.db
@@ -47,6 +54,6 @@ aide_init_db() {
     cp -f ${STAGING_AIDE_DIR}/lib/aide.db.gz ${IMAGE_ROOTFS}${libdir}/aide
 }
 
-EXTRA_IMAGEDEPENDS:append = " aide-native"
+do_rootfs[depends] += "aide-native:do_populate_sysroot"
 
 ROOTFS_POSTPROCESS_COMMAND:append = " aide_init_db;"
diff --git a/recipes-ids/aide/aide_0.19.3.bb b/recipes-ids/aide/aide_0.19.3.bb
index 8d4efbb..c352583 100644
--- a/recipes-ids/aide/aide_0.19.3.bb
+++ b/recipes-ids/aide/aide_0.19.3.bb
@@ -32,8 +32,6 @@ PACKAGECONFIG[e2fsattrs] = "--with-e2fsattrs, --without-e2fsattrs, e2fsprogs, e2
 PACKAGECONFIG[capabilities] = "--with-capabilities, --without-capabilities, libcap, libcap"
 PACKAGECONFIG[posix-acl] = "--with-posix-acl, --without-posix-acl, acl, acl"
 
-do_install[nostamp] = "1"
-
 do_install:append () {
     install -d ${D}${libdir}/${PN}/logs   
     install -d ${D}${sysconfdir}   
@@ -48,14 +46,11 @@ do_install:append () {
 }
 
 do_install:class-native () {
-    install -d ${STAGING_AIDE_DIR}/bin
-    install -d ${STAGING_AIDE_DIR}/lib/logs
-
-    install ${B}/aide ${STAGING_AIDE_DIR}/bin
-    install ${UNPACKDIR}/aide.conf ${STAGING_AIDE_DIR}/
+    install -d ${D}${bindir}
+    install -d ${D}${datadir}/${BPN}
 
-    sed -i -s "s:\@\@define DBDIR.*:\@\@define DBDIR ${STAGING_AIDE_DIR}/lib:" ${STAGING_AIDE_DIR}/aide.conf
-    sed -i -e "s:\@\@define LOGDIR.*:\@\@define LOGDIR ${STAGING_AIDE_DIR}/lib/logs:" ${STAGING_AIDE_DIR}/aide.conf
+    install ${B}/aide ${D}${bindir}
+    install ${UNPACKDIR}/aide.conf ${D}${datadir}/${BPN}/
 }
 
 CONF_FILE = "${sysconfdir}/aide.conf"
-- 
2.55.0


