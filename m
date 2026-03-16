Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400E7F53D98
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 20:32:33 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.60851.1773693151932035119
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 13:32:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MLN8pqpP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4855dbfc129so25012525e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773693150; x=1774297950; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=miDjVRxKeEKiKSM1y7ixkYR65hj1N9Kneq9GLpCYRsA=;
        b=MLN8pqpPx5eCiCRPRB//hx73HXJFneXGAvml8tMx5i/lLyQKO5FhBwdfAngHn3xqbM
         1eqHoWuLSY2dx+++nEZPUptDuPbRUf6gcU9mIwCg+6xmruuMuFONX7jVLkgj7+6rdBht
         1XbTAFuheZTBS0at5dObnFGIauHYKH+xp8DT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773693150; x=1774297950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miDjVRxKeEKiKSM1y7ixkYR65hj1N9Kneq9GLpCYRsA=;
        b=rIETmaQ9W9IU9FGhgPXiMQWPiwMafomBQNjXyaNvjsaSpJxrpAyqtuOhbpv8KlrWqQ
         tcQQXl2VrBWU/tOpmAPHqBhKTYuT8bN2f+Xa0VhCne00ExM1YTVFd/nWCOUZkBmNJ3Vi
         hhSTJpWMzp8l0B048+ytkYbEu+Vpn+RbHUI8uNLegG1k3UCCHJCs60QMqSAQjP/gOrxt
         aaVJdIwZEEEU2NpYTnSlZ69zOq/5A5Qb7H5ZfPuaYaKRDd7FrQd7NLd/EFkqeSC7smio
         acPDBVR1LEtbHEBZZJEXU3NB4H0DZPSgqgPR9kKmJHndqL06c6kKc96E4MWmgKqP/eiS
         gxxQ==
X-Gm-Message-State: AOJu0YyB5vDTaWkEF/fOzSFYDX+ZLZa//CqElPOc3CVg7iIJV9B53f1D
	jG2oTDEjl3lQsUo96bNhrBd8pncKdnZnVdUUI0r6Gdh1VVSB8SnWoEhUXD5KqyPD0M1oOBiZk92
	/UQU83bo=
X-Gm-Gg: ATEYQzwv2uWFjI+nWXzQb5swlE+0rYHfgweSeiH5RHK+6Ugp2K6kD57vSbqtHylE7fY
	SKrUbF01zsSnOA/zzQ8aQQepRvp2gqL4P+J+0sNd+i/p2wRNbK3PeTw0Z/hehi+jQ3G/vN8Ooa5
	FDrJoSOa2zOyxoymlZzzp3o9nzYTQtKpwiCheUwhF9wegQgiuY6CjHxfiUbYcJWJr1zI2nSTqq9
	jpKyploXIQR6O7EGkleL9TpBDDcTB7b8kS3GqYcRau/wEBMGdl0Q+yvnqx9IyaX8w1H1malVJvI
	UA+hQLa0nQTNcrRNcXMVZ66Jtae4B5wHY29O6sDHBfHi6cSXt3vukQwZxCib7ODGgLl64EPGQc1
	pJRCCEuKE1abhz8Y0d7gs/4pUC5Pe4hBSHXZUKRwK9kUXxbSHysmK7LFynlKAy6ZtVP7NhIpnDP
	veQLgXbqmSshs40EMdULgUcqkhOkwzLgeoUtozXMiKMDsQQSIKRQ9RZ81GpBD2/Q==
X-Received: by 2002:a05:600c:3b10:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-485566db72dmr238513895e9.15.1773693149565;
        Mon, 16 Mar 2026 13:32:29 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:15f8:fc87:2277:10bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556401521sm104447025e9.2.2026.03.16.13.32.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 13:32:28 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][whinlatter][PATCH] config.json: Drop checkvnc usage
Date: Mon, 16 Mar 2026 20:32:25 +0000
Message-ID: <20260316203225.818521-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 20:32:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3477

The autobuilder workers take care of setting up DISPLAY themselves, we don't need
the checkvnc script any more and haven't for a while.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/config.json b/config.json
index edeb7ae..9d4f031 100644
--- a/config.json
+++ b/config.json
@@ -88,7 +88,7 @@
             ],
             "step1" : {
                 "shortname" : "Machine oe-selftest",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest ${HELPERSTMACHTARGS} -j 15"],
+                "EXTRACMDS" : ["DISPLAY=:1 oe-selftest ${HELPERSTMACHTARGS} -j 15"],
                 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
             }
         },
@@ -175,7 +175,7 @@
             "step2" : {
                 "shortname" : "Machine oe-selftest",
                 "BUILDHISTORY" : false,
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -a -t machine -j 15"]
+                "EXTRACMDS" : ["DISPLAY=:1 oe-selftest -a -t machine -j 15"]
             }
         },
         "altcfg-hw" : {
@@ -224,7 +224,7 @@
                 "extravars" : [
                     "RPM_GPG_SIGN_CHUNK = '1'"
                 ],
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],
+                "EXTRACMDS" : ["DISPLAY=:1 oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],
                 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
             }
         },
@@ -263,7 +263,7 @@
             },
             "step2" : {
                 "shortname" : "OE Selftest",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg reproducible -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg reproducible -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],
                 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
             },
             "step3" : {
@@ -283,7 +283,7 @@
             "MACHINE" : "qemux86-64",
             "step1" : {
                 "shortname" : "Reproducible Selftest",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest -r reproducible"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest -r reproducible"],
                 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
 
             }
@@ -304,7 +304,7 @@
             ],
             "step1" : {
                 "shortname" : "Repro meta-oe/meta-filesystems",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-filesystems/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-filesystems -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-filesystems"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-filesystems/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-filesystems -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-filesystems"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -324,7 +324,7 @@
             },
             "step2" : {
                 "shortname" : "Repro meta-oe/meta-gnome",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-gnome/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-gnome -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-gnome"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-gnome/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-gnome -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-gnome"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -344,14 +344,14 @@
             },
             "step3" : {
                 "shortname" : "Repro meta-oe/meta-initramfs",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-initramfs/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-initramfs -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-initramfs"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-initramfs/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-initramfs -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-initramfs"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-initramfs"
                 ]
             },
             "step4" : {
                 "shortname" : "Repro meta-oe/meta-multimedia",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-multimedia/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-multimedia -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-multimedia"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-multimedia/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-multimedia -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-multimedia"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -368,7 +368,7 @@
             },
             "step5" : {
                 "shortname" : "Repro meta-oe/meta-networking",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-networking/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-networking -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-networking"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-networking/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-networking -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-networking"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -385,7 +385,7 @@
             },
             "step6" : {
                 "shortname" : "Repro meta-oe/meta-oe",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-oe/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-oe -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-oe"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-oe/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-oe -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-oe"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe"
                 ],
@@ -396,7 +396,7 @@
             },
             "step7" : {
                 "shortname" : "Repro meta-oe/meta-perl",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-perl/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-perl -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-perl"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-perl/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-perl -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-perl"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-perl"
@@ -411,7 +411,7 @@
             },
             "step8" : {
                 "shortname" : "Repro meta-oe/meta-python",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-python/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-python -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-python"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-python/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-python -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-python"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python"
@@ -424,7 +424,7 @@
             },
             "step9" : {
                 "shortname" : "Repro meta-oe/meta-webserver",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-webserver/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-webserver -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-webserver"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-webserver/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-webserver -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-webserver"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-webserver"
@@ -439,7 +439,7 @@
             },
             "step10" : {
                 "shortname" : "Repro meta-oe/meta-xfce",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-xfce/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-xfce -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-xfce"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-xfce/ DISPLAY=:1 oe-selftest --newbuilddir $BUILDDIR/build-st-meta-xfce -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-xfce"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -484,7 +484,7 @@
             "MACHINE" : "unset",
             "step1" : {
                 "shortname" : "Source Mirror Selftest",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -a -t yocto-mirrors -j 15"],
+                "EXTRACMDS" : ["DISPLAY=:1 oe-selftest -a -t yocto-mirrors -j 15"],
                 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"],
                 "extravars" : [
                     "MACHINE = 'qemux86-64'"
@@ -1731,7 +1731,7 @@
             "MACHINE" : "qemux86-64",
             "step1" : {
                 "shortname" : "Yocto Mirror Selftest",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"],
+                "EXTRACMDS" : ["DISPLAY=:1 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"],
                 "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
             }
         },
@@ -1768,7 +1768,7 @@
             },
             "step2" : {
                     "shortname" : "Source Mirror Selftest",
-                    "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"]
+                    "EXTRACMDS" : ["DISPLAY=:1 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"]
             }
         },
         "meta-webosose" : {

