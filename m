Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434CFEED626
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 17:01:54 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web11.53260.1726160507163639158
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Sep 2024 10:01:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=nkl9uf5G;
 spf=pass (domain: smile.fr, ip: 209.85.208.174, mailfrom: yoann.congal@smile.fr)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f7502f09fdso9116631fa.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1726160505; x=1726765305; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mhykdU+OnXpJEBVwKZmcb7cpLmievxYPvwNoLGZDhrk=;
        b=nkl9uf5GQGsAHUllxMxxFQ4OTmmntvquE0P4FddGixnw9dsMt2q9tBXlFqNiMEB8fM
         x85ftMrasFTfYTrzUbgScmg5uHBGmrB7gaTfEyn1YqH6zwQspPA8rlmOqhtVTqs54m+u
         b5fp5EtVMPC+f858exJ3/TTpXxmnEahEY8CRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726160505; x=1726765305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhykdU+OnXpJEBVwKZmcb7cpLmievxYPvwNoLGZDhrk=;
        b=WL4fQ1HU50Fb8k+5V7Bm7DfB8YSq81uyD/JdDCorPc3bJnOdwRr2zilrgk5xP8wqWW
         YwpySeZl3jutAB/aoTItkOwMK4MuKroGPLQvZhMyjkT7C+TmoM1cZkil3unH0Bd5IaXG
         DKCZEx6N/+k3xu5skcD7vjSkdN6naj/LQfpbfffre7ksj3PBoSjwp6q9Fo2P9qFNoPUa
         0bmEhH3ccYjuPIPH6rYT0wCYB1/Js7bFvHXfET/dZs9fZj/kAJBNdHNwxkzPTw2ZjV0B
         gPjgu1GY6Dxf3MMNaRLN9mMZisScdr6u30S6ZLp7Zt3Q3T0CFABX0pu4VDzp42roYAl9
         MX0Q==
X-Gm-Message-State: AOJu0YxOJZy4lqUurgT5HA7EypqIbcMkzWAMRZvZB27hptLC8KD5tBHC
	KqzVaJZkQuymvdETeIJaxtTbevinrN793tReYAo+giAFWWJ0z61uiI7cuZApr365qB3/NhBCabU
	0
X-Google-Smtp-Source: AGHT+IEz4X+JbctvqQMJMdGRQKSi7pNLMan/xpgomgMXIR9QVpgMF6R1AVIYQbcDhpbe2/vCa8ax6w==
X-Received: by 2002:a05:651c:1987:b0:2f7:5c20:5daf with SMTP id 38308e7fff4ca-2f772603a6cmr40610921fa.2.1726160503731;
        Thu, 12 Sep 2024 10:01:43 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (2a02-8440-b217-cde0-302a-0e19-3538-9f8b.rev.sfr.net. [2a02:8440:b217:cde0:302a:e19:3538:9f8b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75bffd058sm19461961fa.51.2024.09.12.10.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:01:43 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH] config.json: remove BB_LOGCONFIG workaround
Date: Thu, 12 Sep 2024 19:01:27 +0200
Message-Id: <20240912170127.1967039-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 17:01:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/650

From: Yoann Congal <yoann.congal@smile.fr>

Since bug #15241 has been resolved, the
"BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG)" workaround is not needed
anymore.

This partially reverts commit 6f48f65c682c ("config.json: add a
workaround for the "autobuilderlog.json" error")

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.json | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/config.json b/config.json
index 0a83f8d..4845a44 100644
--- a/config.json
+++ b/config.json
@@ -324,7 +324,7 @@
             ],
             "step1" : {
                 "shortname" : "Repro meta-oe/meta-filesystems",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-filesystems/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-filesystems -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-filesystems"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-filesystems/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-filesystems -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-filesystems"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -346,7 +346,7 @@
             },
             "step2" : {
                 "shortname" : "Repro meta-oe/meta-gnome",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-gnome/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-gnome -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-gnome"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-gnome/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-gnome -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-gnome"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -368,7 +368,7 @@
             },
             "step3" : {
                 "shortname" : "Repro meta-oe/meta-initramfs",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-initramfs/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-initramfs -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-initramfs"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-initramfs/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-initramfs -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-initramfs"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-initramfs"
                 ],
@@ -381,7 +381,7 @@
             },
             "step4" : {
                 "shortname" : "Repro meta-oe/meta-multimedia",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-multimedia/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-multimedia -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-multimedia"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-multimedia/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-multimedia -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-multimedia"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -400,7 +400,7 @@
             },
             "step5" : {
                 "shortname" : "Repro meta-oe/meta-networking",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-networking/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-networking -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-networking"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-networking/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-networking -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-networking"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -419,7 +419,7 @@
             },
             "step6" : {
                 "shortname" : "Repro meta-oe/meta-oe",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-oe/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-oe -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-oe"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-oe/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-oe -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-oe"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe"
                 ],
@@ -432,7 +432,7 @@
             },
             "step7" : {
                 "shortname" : "Repro meta-oe/meta-perl",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-perl/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-perl -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-perl"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-perl/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-perl -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-perl"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-perl"
@@ -449,7 +449,7 @@
             },
             "step8" : {
                 "shortname" : "Repro meta-oe/meta-python",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-python/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-python -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-python"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-python/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-python -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-python"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python"
@@ -464,7 +464,7 @@
             },
             "step9" : {
                 "shortname" : "Repro meta-oe/meta-webserver",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-webserver/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-webserver -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-webserver"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-webserver/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-webserver -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-webserver"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-webserver"
@@ -481,7 +481,7 @@
             },
             "step10" : {
                 "shortname" : "Repro meta-oe/meta-xfce",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-xfce/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-xfce -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-xfce"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-xfce/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-xfce -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-xfce"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",

