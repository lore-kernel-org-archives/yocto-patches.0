Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EE0CD3427
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:01:14 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4663.1778205664818438544
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:01:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=RycwRQqr;
 spf=pass (domain: konsulko.com, ip: 209.85.210.181, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-838d0b7c950so963810b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205664; x=1778810464; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ek0wk7Jhu8BEqFxB1TRIiJokVIKU2hYC5xqez6fDbs0=;
        b=RycwRQqrgk0rTV/pMlPudurn0RziqDqeWQW5o1wabF6fSOyVK4MKBh9Bv0IqsG99tC
         ZsbCmD5yqMTUQ+WiF32RvxC+hGY+HD7XHhGSDF3TBzxZrsm9yTkUXKokR1GOuO+kC1CR
         SJiSPsVsHJ7BFZccCAUjUTY0TeqJoI18Ts12E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205664; x=1778810464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ek0wk7Jhu8BEqFxB1TRIiJokVIKU2hYC5xqez6fDbs0=;
        b=Zc69lWHmILMYjUWQBnXN+Q6FQqxaGUCj2AE/DL6web0mHeRFLD8QCKZjYwcI9Eo690
         gP5jepj0C3JpqleElil39a87dfjNhDV8TsLFaH85nosdWxKorNEVwwCPYrlBRjW7Gmey
         T/ni2E+GGQYPTkrb/i5GqepdfZZMmkzxSvCyqo67v5mcy195EAr+GYy1Z5e//toekAD6
         qH9jugySxsU2COJzPJ0vfCnNd23sEi3LwYGU8929N989SEurjb8y4TkBXgRQIiluNov/
         f3VRhFxfdXG3EgX3J1XXJJpEuwKpQFXOoNjIdL+Sd/7DjrP8HbBpuQcmmwcCqz5fZIhW
         JDzA==
X-Gm-Message-State: AOJu0Yz1hagRgqnDDz5tPeL7rw2IVcVGVNkkCTlKjzSSRApjQr/XlNGo
	1O4i48G6MNwYlSbdnd59L0myf2Dv2fZeA30ryCrocc9eRKYuZgS5Y0c5y75BtKmqIVx/OF6B+sW
	XjxoH
X-Gm-Gg: AeBDieumAmsEqNJPEyj7HB3ChtrzPLTH/rboMY6sI6ncG4QHxl5gphCdamJBMk6KTkH
	8skTABkvYG3kbr3GdJhnE4KjNRxZtzG4WC8OJQgCXulD5gIeUKHpdgJ4bcjp7JWPLkibotejqQt
	VV00bJOroHmHyda95UX25fnyeZ31sD7jVjmmfPb/MgYIsGNbuzLw0CMsL/R0jvDO7koGRmU8Bxt
	SNsgsW/xer7aBAi9SYz/ydXu57qoAFzuSX5tKt9uG7se9FZgdmxGEayjv5UXAWtDkazASPYtCkK
	TNfOMEh/pneaCJv1bXtdWuFxVu6ao2HyJjCPUZbnNdnemFm7yb9RfN46qPMOon62VkufWukTlLr
	bPHBBCLi/rHe67/xTipFYFFo/Wd+0gJvNaCR7HOBXH2XY9bHhO14x5IARuIipcAtdMl1ahHCmPW
	ZcCuIvuT20LYk1z5jFf8c8gvpBSoaieJ0i3IS1+qtcriyTvqo+EhKkwjD4Pl3d7lpZXkhAxwx72
	A==
X-Received: by 2002:a05:6a00:4097:b0:82f:425b:4c27 with SMTP id d2e1a72fcca58-83a5bfbf782mr11566694b3a.14.1778205663745;
        Thu, 07 May 2026 19:01:03 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d35b3bsm9526633b3a.24.2026.05.07.19.01.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:01:03 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 09/11] config.json: add vcontainer-tests, vdkr-tests, vpdmn-tests jobs
Date: Thu,  7 May 2026 19:00:32 -0700
Message-ID: <fedb9a114f294f1d1dc80d1df086a41e3419b490.1778202125.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:01:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3948

From: Tim Orling <tim.orling@konsulko.com>

Add three pytest job overrides that run the meta-virtualization test
suites against the vcontainer standalone SDK published by the
vcontainer-tarball builder.

Each job runs the new scripts/run-vcontainer-tests helper via
EXTRACMDS (we need BUILDDIR variable so EXTRAPLAINCMDS is not
sufficient) with both NOBUILDTOOLS and NOVCONTAINER set, so the
workers don't spend time setting up either tarball: the test runner
gets the published SDK installer through VCONTAINER_SDK and manages
its own pytest venv.

vcontainer-tests covers the broader bbclass/tooling tests (and so
brings in meta-openembedded layers it transitively exercises);
vdkr-tests and vpdmn-tests cover their respective CLI harnesses.

AI-Generated: Claude Cowork Opus 4.7
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json                  | 42 +++++++++++++++++++++++++++++++++++-
 scripts/run-vcontainer-tests |  7 +++---
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/config.json b/config.json
index 86c1ffb..dda5b12 100644
--- a/config.json
+++ b/config.json
@@ -1891,7 +1891,7 @@
             },
             "step2" : {
                 "shortname" : "Publish vcontainer SDK for test reuse",
-                "EXTRAPLAINCMDS" : [
+                "EXTRACMDS" : [
                     "install -d ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest && install -m 0755 ${BUILDDIR}/tmp/deploy/sdk/vcontainer-standalone.sh ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh.new && mv -f ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh.new ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh"
                 ]
             }
@@ -1938,6 +1938,46 @@
                 "shortname" : "Build 'python' container",
                 "BBTARGETS" : "app-container-python"
             }
+        },
+        "vcontainer-tests": {
+            "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-virtualization"],
+            "ADDLAYER" : [
+                "${BUILDDIR}/../meta-openembedded/meta-oe",
+                "${BUILDDIR}/../meta-openembedded/meta-python",
+                "${BUILDDIR}/../meta-openembedded/meta-networking",
+                "${BUILDDIR}/../meta-openembedded/meta-filesystems",
+                "${BUILDDIR}/../meta-virtualization"
+            ],
+            "step1" : {
+                "shortname" : "Run vcontainer pytest suite",
+                "NOBUILDTOOLS" : 1,
+                "NOVCONTAINER" : 1,
+                "EXTRACMDS" : [
+                    "VCONTAINER_SDK=${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh RESULTS_DIR=${HELPERRESULTSDIR} ${SCRIPTSDIR}/run-vcontainer-tests vcontainer ${BUILDDIR} ${BUILDDIR}/../meta-virtualization"
+                ]
+            }
+        },
+        "vdkr-tests": {
+            "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-virtualization"],
+            "step1" : {
+                "shortname" : "Run vdkr pytest suite",
+                "NOBUILDTOOLS" : 1,
+                "NOVCONTAINER" : 1,
+                "EXTRACMDS" : [
+                    "VCONTAINER_SDK=${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh RESULTS_DIR=${HELPERRESULTSDIR} ${SCRIPTSDIR}/run-vcontainer-tests vdkr ${BUILDDIR} ${BUILDDIR}/../meta-virtualization"
+                ]
+            }
+        },
+        "vpdmn-tests": {
+            "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-virtualization"],
+            "step1" : {
+                "shortname" : "Run vpdmn pytest suite",
+                "NOBUILDTOOLS" : 1,
+                "NOVCONTAINER" : 1,
+                "EXTRACMDS" : [
+                    "VCONTAINER_SDK=${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh RESULTS_DIR=${HELPERRESULTSDIR} ${SCRIPTSDIR}/run-vcontainer-tests vpdmn ${BUILDDIR} ${BUILDDIR}/../meta-virtualization"
+                ]
+            }
         }
     },
     "repo-defaults" : {
diff --git a/scripts/run-vcontainer-tests b/scripts/run-vcontainer-tests
index cbb5544..1394c7c 100755
--- a/scripts/run-vcontainer-tests
+++ b/scripts/run-vcontainer-tests
@@ -3,7 +3,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # Run meta-virtualization pytest test suites against the vcontainer
-# standalone SDK (vdkr/vpdmn) that was built by the previous bitbake
+# standalone SDK (vdkr/vpdmn) that was built in a previous bitbake
 # step.
 #
 # Arguments:
@@ -21,9 +21,8 @@
 #
 # The script is intentionally conservative: any pytest tests that cannot run
 # in the CI environment (those marked "slow", "network", "boot") are skipped
-# are skipped so that the autobuilder step completes without needing network
-# access. Those can be re-enabled by exporting META_VIRT_PYTEST_MARKERS
-# before invocation.
+# so that the autobuilder step completes without needing network access. Those
+# can be re-enabled by exporting META_VIRT_PYTEST_MARKERS before invocation.
 #
 # It is assumed that /dev/kvm is writable by the CI user running the tests,
 # since the performance is significantly faster with 'memres'.
-- 
2.43.0


