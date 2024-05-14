Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD55C04FFE
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 22:22:38 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.980.1715725349647621756
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 May 2024 15:22:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20230601.gappssmtp.com header.s=20230601 header.b=PG19Ro8d;
 spf=pass (domain: smile.fr, ip: 209.85.221.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-351b683f2d8so2458073f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 May 2024 15:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1715725347; x=1716330147; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R73plEDNQmrW8K1eJPJai/HG5OQbCfvySSzRXT5eByQ=;
        b=PG19Ro8d/oZNZ/aS5zMNvpGPU978lDpvK/5Xmbhcxy+Z944VNwmAhRhd9R9uQ+f3KT
         Gc2bUm1ORoi/j7ObcnJArDHNwUBayN77huojJJ9CekdQ0tMw9jyJVt6TjiQrVmcvxTfO
         An6rhaAgRt431r8QD0H+oOVUFsXmTnIfgICQNA3XomNkSKSfSZeMCSK7c/ZnxU+G5ut4
         Os2W5iZOGAFD7VEEK0pTlLyvaSQGE42g2hjjmMkEhMe1pxBYX7Y/9Q2DUlKCiR4P/PD9
         Jv3TWVfVw8FQiE6K5nGML9EdO7LkoAeLC6nxq9Tsr72CPqs5n9r/RqXD5XAPx6Qmuzzt
         kOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715725347; x=1716330147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R73plEDNQmrW8K1eJPJai/HG5OQbCfvySSzRXT5eByQ=;
        b=pw1rP/SZH6WqNXrqSGJn9L8UHoVeBGWGysjWS5HucfbvPXxzx10GI6zhlXmrBPE0LM
         xg0H0hJBlKRHNNJZL2A6W2atQ7PlMocnay9oLPmCF5L7plzWMTu66hr5uhGjG4mYYPIL
         TEA0sUdQq4QQQrqUgbyoGvTjxN/bx9DoX9zlENV7Rx1jmw9zAvY+2oMDMY1w0uS6hvBw
         A8n/aHHsiYbuGaYxP3ZzYYl+sG0D+nKVn3LBJmWAsdYXWF5ZxmdGO1RlsjOYMcUm6Dj2
         faqEEESe28cL9z9jSgvo/p44xy5atK3IqKBbkwyj80KElvCvFGdkI0WjsuX51lPu2KLl
         x9Uw==
X-Gm-Message-State: AOJu0YwDsgJjJUge27agmRHZYqmOfTTpJtlFLr7iQ5AcK8FS0Iz2lJlz
	g96BdoeFCimmINtDLrv8EvyHm8HhQqhBo/p9O5kGkI0sz2/t/XowOcDpt0LZ4Gt3jGvcbbveqBu
	mbgg=
X-Google-Smtp-Source: AGHT+IFamYpAde230y4j//Ynkjmj7l0/YnmHpJipKfg1gZeYLeaMtU8VReB9sVU7ewLwNxWdz8GgBw==
X-Received: by 2002:a5d:6201:0:b0:349:f8a1:cd6a with SMTP id ffacd0b85a97d-3504a73773emr10101630f8f.16.1715725347344;
        Tue, 14 May 2024 15:22:27 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a78cdsm14640129f8f.58.2024.05.14.15.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 15:22:27 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH] config.json: Repro meta-oe: clobber build directory to save disk space
Date: Wed, 15 May 2024 00:21:41 +0200
Message-Id: <20240514222141.3200224-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 May 2024 22:22:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/137

This patch clobbers each of the meta-openembedded/meta-* repro selftest
build directory after a successful reproducibility step and should
decrease maximum disk space used by this builder.

Previously, the full parent build directory would only be clobbered
after a successful full build (which is yet to be seen).

As a reminder, each reproducibility build directory contains 2 builds:
* for each recipe of the layer (and their recursive dependencies)
* without rm_work
* one with sstate, one without
As a result, I'd expect to find 10 times a build directory for each
recipe near the root of the dependency tree (linux-yocto, gcc, ...):
one for each meta-openembedded/meta-* layer. This would add up quick.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.json | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/config.json b/config.json
index 6c9946f..93d49f8 100644
--- a/config.json
+++ b/config.json
@@ -322,7 +322,7 @@
             ],
             "step1" : {
                 "shortname" : "Repro meta-oe/meta-filesystems",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-filesystems/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-filesystems -r reproducible"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-filesystems/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-filesystems -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-filesystems"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -344,7 +344,7 @@
             },
             "step2" : {
                 "shortname" : "Repro meta-oe/meta-gnome",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-gnome/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-gnome -r reproducible"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-gnome/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-gnome -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-gnome"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -366,7 +366,7 @@
             },
             "step3" : {
                 "shortname" : "Repro meta-oe/meta-initramfs",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-initramfs/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-initramfs -r reproducible"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-initramfs/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-initramfs -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-initramfs"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-initramfs"
                 ],
@@ -379,7 +379,7 @@
             },
             "step4" : {
                 "shortname" : "Repro meta-oe/meta-multimedia",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-multimedia/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-multimedia -r reproducible"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-multimedia/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-multimedia -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-multimedia"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -398,7 +398,7 @@
             },
             "step5" : {
                 "shortname" : "Repro meta-oe/meta-networking",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-networking/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-networking -r reproducible"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-networking/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-networking -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-networking"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -417,7 +417,7 @@
             },
             "step6" : {
                 "shortname" : "Repro meta-oe/meta-oe",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-oe/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-oe -r reproducible"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-oe/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-oe -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-oe"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe"
                 ],
@@ -430,7 +430,7 @@
             },
             "step7" : {
                 "shortname" : "Repro meta-oe/meta-perl",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-perl/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-perl -r reproducible"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-perl/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-perl -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-perl"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-perl"
@@ -447,7 +447,7 @@
             },
             "step8" : {
                 "shortname" : "Repro meta-oe/meta-python",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-python/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-python -r reproducible"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-python/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-python -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-python"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python"
@@ -462,7 +462,7 @@
             },
             "step9" : {
                 "shortname" : "Repro meta-oe/meta-webserver",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-webserver/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-webserver -r reproducible"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-webserver/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-webserver -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-webserver"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-webserver"
@@ -479,7 +479,7 @@
             },
             "step10" : {
                 "shortname" : "Repro meta-oe/meta-xfce",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-xfce/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-xfce -r reproducible"],
+                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail-openembedded/meta-xfce/ DISPLAY=:1 BB_LOGCONFIG=$(readlink -f $BB_LOGCONFIG) oe-selftest --newbuilddir $BUILDDIR/build-st-meta-xfce -r reproducible && ${SCRIPTSDIR}/../janitor/clobberdir ${BUILDDIR}/build-st-meta-xfce"],
                 "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
-- 
2.39.2


