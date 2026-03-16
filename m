Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582F6F53D97
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 20:32:13 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.60846.1773693128640822268
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 13:32:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=W9odf27I;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso44523935e9.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773693126; x=1774297926; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=miDjVRxKeEKiKSM1y7ixkYR65hj1N9Kneq9GLpCYRsA=;
        b=W9odf27IeDXAeZPbhKZxLPA6JufNWTF5vl851NyB1QNdJ8JEU2UQKXRYPrchlqiNGl
         f4ap8hav8oDiMnwy7TxwpUXyGslqOuVsj9hp8izPTWu+gS2n7F59TF8ejdAdr3WU12vB
         JbRnOWen5jwDUmEIwIs6lpc1+NgN/y2dKkFrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773693126; x=1774297926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miDjVRxKeEKiKSM1y7ixkYR65hj1N9Kneq9GLpCYRsA=;
        b=RUJgIweHlvqPs2o4B2JsWUXBkRQwzuj2Wp32wIMZyDyVbUm4lzg97NLPgv/MwiMJjG
         Gx1aP4YZUDbyax4RqxIDJJFRmKJhsEX09ee4XqqYu3mKfYiuG4FxneGDxDuzr2OArpmR
         S3mmz1G/iNXtxqUMUBYf/V66YNStRcPr5R0jBHhuhPPa2UHiYovD1S8QtAWmXx0TbeU8
         fPy+PmBNFcfuRZOgCQ9FSnLc5EEfrQ80erI3kk4+LV9lcSnV2UrekiWt/y1Y9c5pIQRm
         mnZcUEZBQIW1TgZ/IS6r8S32laKkbGn5rGRP80hgFtfpbZkAVvvDcvYrEEcyD8pbRu0V
         U88Q==
X-Gm-Message-State: AOJu0YzofjmS5+z6/Ge8pORTfv+pK/CANFb70fEwfRKwpIMyJ8mtRSBV
	u8DHvLMDUUxslpOauGE0OJmECZ1aSwUfgDC7t/YZcZ+FgWY3M6z2niBVWOUOaYWEYidhMQVKK75
	EQ1Gp6sM=
X-Gm-Gg: ATEYQzw6uU/2FZhWWpM586JruBAcL327wkD+EIQRMnYgIPqGhaoIKiV+ZZ8eZICw2jo
	RPTZLp/v6aGQvMha98N8rsfK0HqxqneF7f26NIeeYcCxjujM+ZpL369r2FKOtPzFRbf91ptK5PD
	e3ActmzeFOGuKnnimSjjaj3tXwQlvgkP/jI7JYFNmhDm0iff57O+s5CaLhjP0ckcJp5tVswTwxr
	NZGuh0HPUTQ3Dsh4rCr7X+wdze0Kg8T46EJ3jyWYiGFxZMJeHNLP0pwiFg+lmwfmp2brV6joyJk
	Lt7I7b5JC7ZSDjEGgZAD7RkRnAcyv2WXbwnmp/4qdpjkQFQmXV+/AEg/SjJQS2x60jIywuXVTb9
	FPrR5ySDM77QkrCGJELW3gpDmOwqilSKoWINflrbDCvOWrKlDOYm/Y96DxwOKQMujyjVqZii6XK
	fFTv5XJTeTDSzkC1kT3NngsuzwLuNJQ/FBhM5PPJ6GyWMJPX696pLlYaawBA8CYQ==
X-Received: by 2002:a05:600c:4514:b0:485:2f6a:6ed with SMTP id 5b1f17b1804b1-4855670b701mr236100175e9.28.1773693126152;
        Mon, 16 Mar 2026 13:32:06 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:15f8:fc87:2277:10bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6ece3sm100183045e9.29.2026.03.16.13.32.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 13:32:05 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][scarthgap][PATCH] config.json: Drop checkvnc usage
Date: Mon, 16 Mar 2026 20:32:03 +0000
Message-ID: <20260316203203.818480-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 20:32:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3476

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

