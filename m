Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0502C982C9
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:52 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27091.1789597842853710673
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=prtB2RcN;
 spf=pass (domain: konsulko.com, ip: 74.125.230.205, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a135ffb08so20479585a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597842; x=1790202642; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RseD+CpT6CtduPwWKi4SgutufEdH1DMTnnGSipxsiBE=;
        b=prtB2RcNcmliLNCBo8DxP7k2cBOPptr0yJ9DW1iw13zK7yvEZkIiVwOy+2aIkvTrKH
         rcr/5TiSbZj7UL0E/JAKF2rQ/SafAZ89dObmrAEjRlK9niM67lChBR6w9bUlEvd4hOz7
         /zZ+GLKCFMpY5SaexT40kNCE40hmZ7xAbwmkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597842; x=1790202642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RseD+CpT6CtduPwWKi4SgutufEdH1DMTnnGSipxsiBE=;
        b=lgst+uwI05YO9rZPjtV3JHu1DqFgZGvew4no1tRCJInIZWLZRiNqY6HuAtR2P6Qoly
         1dUpyldLG2/+lPnxZtG80M7/jgYRFXrlKDE5EsKAXy+muwh9kEkkTaCO3o4mh41iLmc9
         W7WShj/M+oV2DzhzanhqdRuzGYaS4dYTHejCSWom5w6UL1axgivV8MMaRlbMQG+AQ6Ce
         I0COGP36beqrIrBk3A/xVgIT2P6mjFvwSqrkbCTUYgAXpxhV7/H5JyuGuF4LcPZkaS4V
         xETm9csDD1vg8F6wJqELW9Ufqdtfp/RPTA/gZ/Ul1wj5q+woIyO86fnKL4a/AUOfWnRp
         iFjQ==
X-Gm-Message-State: AFuF++kWA+qM18T+1uY/hrLx5vMcvgrdahj6PdeQEyWeLcEcrYjDmmXn
	XEB+PK46JcEk78uVC20Wn0FfXhYXivW0D9cPbv9mf+O+aBt8l1glToxTA4xpBzwn5Pqs4PSo5GT
	aE+SK
X-Gm-Gg: AYBFou3dYnMsJfloCYmzpUJN1qmmfyZzqy+NrYyoVRv95fwvOghVO/YRlIOUWotkTKX
	TnEUGGdP6enKzKH45xoL4vaiXG5w5kTS0LwPZp62tS4y2gsd2f4BlFv2fVtSBTlwuyDHnLCv2qA
	WFTQ1jyjhsYIrUKjg/v7ZYkMMxNKbtI0Ycke0YJCmYRyjuvDvG2y2Uqnt/4Z/6ldmqeqA3P7Fr1
	izDVoZ7yNFhvkB949LikGkNjMKqtHZ7pur2isBrZ5xFtC97qEpiWBfTpAIOMTtMs8juYFpZaBPR
	rWfxi+EEiDKboukpYixcU3mk3Idy1SwLtekBNpxqlfz6qw9avQtF/HUeoN0GAz0GHytzvkZoqgF
	gzpzEqstp1BiF7Bw40hpxcGjeBhQkLEyRWtv50z4RpUPEioAoU5Ik5JIGjSW+yRqWo29ECHGPEH
	JakY8HTIOlcsaBB2HrD/IpngDMOyhsIJjq/NIAbHe+DTf0rkqm1kLTGqmG59chqEBz759CW1W0I
	+i3cYmd5LVFEil85+nkPmbW/skd46jX11gdb2AURWUSVl4SzubpnS9idvjAY9CQwiwA4TkDOYba
	X1977BAirjHzCKCFR+2nI5A111FqZRB+XkrQ
X-Received: by 2002:a05:620a:8399:b0:937:d6e8:59b0 with SMTP id af79cd13be357-93bb76c2b3amr703875185a.10.1789597841589;
        Wed, 16 Sep 2026 15:30:41 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:41 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 11/24] aide: Fix unstable install task hash
Date: Wed, 16 Sep 2026 18:30:05 -0400
Message-ID: <db0b71a7f3f257540134a2d9f5dcf1862db78c1e.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4887

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
index 68e3bfa..5daa295 100644
--- a/recipes-ids/aide/aide_0.19.3.bb
+++ b/recipes-ids/aide/aide_0.19.3.bb
@@ -31,8 +31,6 @@ PACKAGECONFIG[e2fsattrs] = "--with-e2fsattrs, --without-e2fsattrs, e2fsprogs, e2
 PACKAGECONFIG[capabilities] = "--with-capabilities, --without-capabilities, libcap, libcap"
 PACKAGECONFIG[posix-acl] = "--with-posix-acl, --without-posix-acl, acl, acl"
 
-do_install[nostamp] = "1"
-
 do_install:append () {
     install -d ${D}${libdir}/${PN}/logs   
     install -d ${D}${sysconfdir}   
@@ -47,14 +45,11 @@ do_install:append () {
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


