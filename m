Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5739BCCD187
	for <webhook@archiver.kernel.org>; Tue, 14 Oct 2025 10:23:49 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.12007.1760437428578579149
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Oct 2025 03:23:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RxCWjvmC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so41618225e9.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Oct 2025 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760437426; x=1761042226; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F81u3W31k5T1so65ZgY5cSVYE+VMri0yxAteiCvvBdI=;
        b=RxCWjvmCKMkXc7jkTt6pp3tMfeCnG2HaDflB9Kit6KiahoVT5Jt7cGl0flJi3N/KaD
         xaSssrPOVWwubvzRVEw0kCuDSuk/OXp30Dl8eEkGyKm8ZqTfVMolfXBUGID2Xg6qUy52
         y0mqWgHHp7EKXwVx/08pUfzHCBRF/rqBg69pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437426; x=1761042226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F81u3W31k5T1so65ZgY5cSVYE+VMri0yxAteiCvvBdI=;
        b=DVLSoPaeUFSIhWzxIVnf35vD8xJBoyjlqdJGyML1LQAVFUUCBH6g3Uj4RIqL2xxl48
         m0N4aGtxE3FOZESSYIX5jwPqqJSpR4iQeENQ0DZqac3GdoA2lpwgv0Gy7QgjNgwTgzBM
         Zt0rlxkR1p68eqgXyEWECUg14uFoavPudnHsdfTNFa9Pg0If/dtF5is8zY2GQxyx33FI
         MI8MkKnD27uM/jpllGKtqKNwVJwUHUwpT8kBuP9zmG9OwhwLbF1j9JwnZRe5a40K2AWc
         jTS+ihQVBWzahkWPx22/DuXChdyVC3ITJaeMrUSVy6Ijd1hSkOQ81QQfMu6FV7KDfNVh
         snlQ==
X-Gm-Message-State: AOJu0YxNvF+Y37Rho0ig/etadfTHcHSfV2VXpCqOxUBZCxN7bPFrwfWx
	eGyGWfLIv0MrSpNDsY3nrOmiBBwrwLIw5Jowv8qSbkt3rf4YWgPKZyOIdT34+8PwFj66a1jL70r
	kWIqz
X-Gm-Gg: ASbGncsgYiStNn02LYDW8Yi5pGgL9k243N9TpoajKqNbZLZ2Vv/cO1ZHou/StVkhllW
	1oPFsz5i3ZPb7ghWljl92CxXtIn4hRubFwTpHX1gcjVZY6MBiCphKLsSRrXVviO+Cl7VKH5SJ7+
	2aLGTAOW36UA2zWC16b/oS5+46thX3ShYpCGaHMeOpAxenUxikAS+yvv9z1ouCHsYL1HYkb/nhH
	y8YBUCc8P2py4qcIzKqcFsgcq5UDyW3JSyrEKlBI6cFerVIsgfunHHWoWch17qvlDyt4Q2tIJev
	HxkKjJvHGxNqwV9u8bIBQFG9yUynS4ToyUMgjJrbFsHDUrhYXPWW8UdH27X71cbawpUvjUaeHpd
	66TseIR7CcAR3curfLoWcdJiAEtXB+GfQjw8sHFwFjmeSY2z/foLAgFSQRbV+2cNqWAhfu2MXqy
	/rO2wIo5sNLPgjfQ==
X-Google-Smtp-Source: AGHT+IEtvlqEZUncTn4He15wGNAGYcUPmyilQRAnJNWfVu7wxb30pEIS1ZH3eyU6n7la2rXkdYhLPQ==
X-Received: by 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id 5b1f17b1804b1-46fa9af8595mr197055635e9.19.1760437425939;
        Tue, 14 Oct 2025 03:23:45 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2ac0:755:9ed5:f113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49bdfd0sm233715225e9.10.2025.10.14.03.23.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:23:44 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 1/2] config.json/scripts: Switch to use bitbake-setup
Date: Tue, 14 Oct 2025 11:23:43 +0100
Message-ID: <20251014102344.645363-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Oct 2025 10:23:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2300

With the addition of bitbake-setup to the master branch, we can switch from using the
combo-layer built poky repository to using bitbake-setup instead.

This patch set changes the setup to use bitbake/oecore/meta-yocto/yocto-docs instead
of poky. Most of the changes are due to the new layer layout, or using bitbake-setuip
instead of scripts in helper. The existing scripts are still run for now to handle layers
not in the core configuration json.

We continue to write extra settings to auto.conf.

This switches the code to use the distro/machine selection from fragments.

We need to use init-build-env instead of oe-init-build-env in most cases.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json                     | 79 ++++++++++++++++++---------------
 scripts/bitbake-extra-tests     |  2 +-
 scripts/build-perf-test-wrapper |  8 ++--
 scripts/getproperties.py        |  2 +
 scripts/layer-config            | 22 +++------
 scripts/run-config              | 15 ++++---
 scripts/run-cvecheck            |  2 +-
 scripts/run-patchtest-selftest  |  6 +--
 scripts/setup-config            | 17 ++++++-
 scripts/shared-repo-unpack      | 43 +++++++++++++++---
 scripts/upload-error-reports    |  2 +-
 scripts/utils.py                | 12 +++--
 12 files changed, 128 insertions(+), 82 deletions(-)

diff --git a/config.json b/config.json
index 588a2f6..04358a9 100644
--- a/config.json
+++ b/config.json
@@ -26,7 +26,10 @@
     "AUTOBUILDER_HASHSERV" : "wss://hashserv.yoctoproject.org/ws",
 
     "defaults" : {
-        "NEEDREPOS" : ["poky"],
+        "NEEDREPOS" : ["bitbake"],
+        "BBSETUP_DLDIR" : "${BASE_SHAREDDIR}/current_sources",
+        "BBSETUP_CONFIG" : ["poky-master", "poky"],
+        "BBSETUP_FRAGMENTS" : [],
         "DISTRO" : "poky",
         "MACHINE" : "qemux86-64",
         "SDKMACHINE" : "x86_64",
@@ -43,7 +46,8 @@
         "extravars" : [
             "SANITY_TESTED_DISTROS = ''",
             "BB_HASHSERVE = '${AUTOBUILDER_HASHSERV}'",
-            "OE_FRAGMENTS += 'core/yocto-autobuilder/autobuilder core/yocto-autobuilder/autobuilder-resource-constraints'"
+            "OE_FRAGMENTS += 'core/yocto-autobuilder/autobuilder core/yocto-autobuilder/autobuilder-resource-constraints'",
+            "EXTRA_IMAGE_FEATURES ?= 'allow-empty-password empty-root-password allow-root-login'"
         ]
     },
     "templates" : {
@@ -85,7 +89,7 @@
             "step1" : {
                 "shortname" : "Machine oe-selftest",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest ${HELPERSTMACHTARGS} -j 15"],
-                "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"]
+                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
             }
         },
         "altcfg-qemu" : {
@@ -221,7 +225,7 @@
                     "RPM_GPG_SIGN_CHUNK = '1'"
                 ],
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],
-                "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"]
+                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
             }
         },
         "buildperf" : {
@@ -257,7 +261,7 @@
             "step2" : {
                 "shortname" : "OE Selftest",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg reproducible -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],
-                "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"]
+                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
             },
             "step3" : {
                 "shortname" : "Python Linter Report",
@@ -277,16 +281,16 @@
             "step1" : {
                 "shortname" : "Reproducible Selftest",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest -r reproducible"],
-                "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"]
+                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
 
             }
         },
         "reproducible-meta-oe" : {
             "MACHINE" : "qemux86-64",
             "SDKMACHINE" : "x86_64",
-            "NEEDREPOS" : ["poky", "meta-openembedded"],
+            "NEEDREPOS" : ["bitbake", "meta-openembedded"],
             "ADDLAYER" : [
-                "${BUILDDIR}/../meta-selftest"
+                "${BUILDDIR}/../layers/openembedded-core/meta-selftest"
             ],
             "extravars" : [
                 "EXCLUDE_FROM_WORLD:layer-core = '1'",
@@ -462,7 +466,7 @@
             "step1" : {
                 "shortname" : "Sources pre-fetching",
                 "BBTARGETS" : "universe -c fetch -k",
-                "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"],
+                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"],
                 "extravars" : [
                     "SOURCE_MIRROR_FETCH = '1'"
                 ]
@@ -478,16 +482,17 @@
             "step1" : {
                 "shortname" : "Source Mirror Selftest",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -a -t yocto-mirrors -j 15"],
-                "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"]
+                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
             }
         }
 
     },
     "overrides" : {
         "qemuarm-oecore" : {
-            "NEEDREPOS" : ["oecore", "bitbake"],
+            "NEEDREPOS" : ["bitbake"],
             "MACHINE" : "qemuarm",
-            "DISTRO" : "None",
+            "DISTRO" : "",
+            "BBSETUP_CONFIG" : ["oe-nodistro", "nodistro"],
             "extravars" : [
                 "INHERIT += 'uninative'",
                 "require conf/distro/include/yocto-uninative.inc",
@@ -557,7 +562,7 @@
             "step1" : {
                 "shortname" : "Sources pre-fetching (arm specific)",
                 "BBTARGETS" : "universe -c fetch -k",
-                "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"],
+                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"],
                 "extravars" : [
                     "SOURCE_MIRROR_FETCH = '1'"
                 ]
@@ -614,7 +619,7 @@
         },
 
         "meta-arm" : {
-            "NEEDREPOS" : ["poky", "meta-arm"],
+            "NEEDREPOS" : ["bitbake", "meta-arm"],
             "ADDLAYER" : [
                 "${BUILDDIR}/../meta-arm/meta-arm-toolchain",
                 "${BUILDDIR}/../meta-arm/meta-arm",
@@ -648,7 +653,7 @@
             }
         },
         "meta-agl-core" : {
-            "NEEDREPOS" : ["poky", "meta-agl"],
+            "NEEDREPOS" : ["bitbake", "meta-agl"],
             "ADDLAYER" : [
                 "${BUILDDIR}/../meta-agl/meta-agl-core"
             ],
@@ -665,7 +670,7 @@
             }
         },
         "meta-aws" : {
-            "NEEDREPOS" : ["poky", "meta-openembedded", "meta-aws"],
+            "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-aws"],
             "ADDLAYER" : [
                 "${BUILDDIR}/../meta-openembedded/meta-oe",
                 "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -799,7 +804,7 @@
             }
         },
         "meta-intel" : {
-            "NEEDREPOS" : ["poky", "meta-intel"],
+            "NEEDREPOS" : ["bitbake", "meta-intel"],
             "ADDLAYER" : ["${BUILDDIR}/../meta-intel"],
             "MACHINE" : "intel-corei7-64",
             "TEMPLATE" : "arch-hw"
@@ -1050,7 +1055,7 @@
         },
         "buildtools-docs" : {
             "MACHINE" : "qemux86-64",
-            "NEEDREPOS" : ["poky", "meta-openembedded"],
+            "NEEDREPOS" : ["bitbake", "meta-openembedded"],
             "ADDLAYER" : [
                     "${BUILDDIR}/../meta-openembedded/meta-oe",
                     "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -1188,20 +1193,20 @@
             "TEMPLATE" : "reproducible"
         },
         "check-layer" : {
-            "NEEDREPOS" : ["poky", "meta-mingw"],
+            "NEEDREPOS" : ["bitbake", "meta-mingw"],
             "DISTRO" : "nodistro",
             "step1" : {
-                "EXTRACMDS" : ["bitbake-layers remove-layer ../meta-poky; yocto-check-layer ../meta-poky"]
+                "EXTRACMDS" : ["yocto-check-layer ../layers/meta-yocto/meta-poky"]
             },
             "step2" : {
-                "EXTRACMDS" : ["bitbake-layers remove-layer ../meta-yocto-bsp; yocto-check-layer ../meta-yocto-bsp"]
+                "EXTRACMDS" : ["yocto-check-layer ../layers/meta-yocto/meta-yocto-bsp"]
             },
             "step3" : {
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-mingw"]
             }
         },
         "check-layer-nightly" : {
-            "NEEDREPOS" : ["poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein", "meta-qcom"],
+            "NEEDREPOS" : ["bitbake", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein", "meta-qcom"],
             "step1" : {
                 "shortname" : "Test meta-agl YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-agl/meta-agl-core ../meta-agl/meta-netboot --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python --no-auto-dependency"]
@@ -1248,7 +1253,7 @@
             }
         },
         "metrics" : {
-            "NEEDREPOS" : ["poky", "meta-openembedded"],
+            "NEEDREPOS" : ["bitbake", "meta-openembedded"],
             "extravars" : [
                 "INHERIT += 'cve-check'",
                 "BB_DISKMON_DIRS = ''",
@@ -1299,7 +1304,7 @@
             }
         },
         "metrics-gitstats" : {
-            "NEEDEDREPOS" : [],
+            "NEEDREPOS" : [],
             "step1" : {
                 "shortname" : "Generate gitstats",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/run-gitstats ${BUILDDIR}/../"]
@@ -1321,7 +1326,7 @@
             }
         },
         "meta-mingw" : {
-            "NEEDREPOS" : ["poky", "meta-mingw"],
+            "NEEDREPOS" : ["bitbake", "meta-mingw"],
             "MACHINE" : "qemux86-64",
             "BBTARGETS" : "core-image-mingw-sdktest:do_populate_sdk",
             "ADDLAYER" : ["${BUILDDIR}/../meta-mingw"],
@@ -1334,7 +1339,7 @@
             }
         },
         "meta-oe" : {
-            "NEEDREPOS" : ["poky", "meta-openembedded"],
+            "NEEDREPOS" : ["bitbake", "meta-openembedded"],
             "MACHINE" : "qemux86-64",
             "extravars" : [
                 "INHERIT += 'rm_work'"
@@ -1354,7 +1359,7 @@
             }
         },
         "meta-virt" : {
-            "NEEDREPOS" : ["poky", "meta-openembedded", "meta-virtualization"],
+            "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-virtualization"],
             "ADDLAYER" : [
                 "${BUILDDIR}/../meta-openembedded/meta-oe",
                 "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -1459,7 +1464,7 @@
                     "IMAGE_INSTALL:append = ' service hello-mod'",
                     "TEST_SUITES:append = ' skeletoninit'"
                 ],
-                "ADDLAYER" : ["${BUILDDIR}/../meta-skeleton"]
+                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-skeleton"]
             },
             "step4" : {
                 "shortname" : "Systemd with sysvinit compat",
@@ -1515,7 +1520,7 @@
             "TEMPLATE" : "buildperf"
         },
         "auh" : {
-            "NEEDREPOS" : ["poky", "auto-upgrade-helper"],
+            "NEEDREPOS" : ["bitbake", "auto-upgrade-helper"],
             "extravars" :[
                 "DL_DIR = '${TOPDIR}/downloads'",
                 "INHERIT += 'buildhistory'",
@@ -1542,7 +1547,7 @@
             }
         },
         "auh-meta-oe": {
-            "NEEDREPOS": ["poky", "auto-upgrade-helper", "meta-openembedded"],
+            "NEEDREPOS": ["bitbake", "auto-upgrade-helper", "meta-openembedded"],
             "extravars": [
                 "DL_DIR = '${TOPDIR}/downloads'",
                 "INHERIT += 'buildhistory'",
@@ -1673,15 +1678,15 @@
             "step1" : {
                 "shortname" : "Yocto Mirror Selftest",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"],
-                "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"]
+                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
             }
         },
         "meta-oe-mirror" : {
             "SDKMACHINE" : "x86_64",
             "MACHINE" : "qemux86-64",
-            "NEEDREPOS" : ["poky", "meta-openembedded"],
+            "NEEDREPOS" : ["bitbake", "meta-openembedded"],
             "ADDLAYER" : [
-                "${BUILDDIR}/../meta-selftest",
+                "${BUILDDIR}/../layers/openembedded-core/meta-selftest",
 
                 "${BUILDDIR}/../meta-openembedded/meta-oe",
                 "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -1713,7 +1718,7 @@
             }
         },
         "meta-webosose" : {
-            "NEEDREPOS" : ["poky", "meta-webosose", "meta-security", "meta-clang", "meta-openembedded", "meta-qt6"],
+            "NEEDREPOS" : ["bitbake", "meta-webosose", "meta-security", "meta-clang", "meta-openembedded", "meta-qt6"],
             "DISTRO": "webos",
             "MACHINE": "qemux86-64",
             "NOLAYERADD": ["meta-security", "meta-clang", "meta-qt6", "meta-webosose", "meta-openembedded"],
@@ -1751,7 +1756,7 @@
             "TEMPLATE" : "trigger-build-posttrigger"
         },
         "patchtest" : {
-            "NEEDREPOS" : ["poky", "meta-patchtest", "meta-openembedded"],
+            "NEEDREPOS" : ["bitbake", "meta-patchtest", "meta-openembedded"],
             "MACHINE" : "qemux86-64",
             "ADDLAYER" : [
                 "${BUILDDIR}/../meta-openembedded/meta-oe",
@@ -1763,10 +1768,10 @@
             }
         },
 	"patchtest-selftest" : {
-	    "NEEDREPOS" : ["poky"],
+	    "NEEDREPOS" : ["bitbake"],
 	    "EXTRACMDS" : ["${SCRIPTSDIR}/run-patchtest-selftest ${HELPERBUILDDIR}/.."],
 	    "ADDLAYER" : [
-	        "${BUILDDIR}/../meta-selftest"
+	        "${BUILDDIR}/../layers/openembedded-core/meta-selftest"
 	    ]
 	},
         "toaster" : {
diff --git a/scripts/bitbake-extra-tests b/scripts/bitbake-extra-tests
index c8d6d83..1bc06fb 100755
--- a/scripts/bitbake-extra-tests
+++ b/scripts/bitbake-extra-tests
@@ -1,5 +1,5 @@
 #!/bin/bash
-. ./oe-init-build-env
+source ./build/init-build-env
 TERM=xterm-256color
 TASK_EXP_UNIT_TEST=1 bitbake -g -u taskexp_ncurses zlib acl
 if [ $? -ne 0 ]; then
diff --git a/scripts/build-perf-test-wrapper b/scripts/build-perf-test-wrapper
index c236c60..9028463 100755
--- a/scripts/build-perf-test-wrapper
+++ b/scripts/build-perf-test-wrapper
@@ -128,7 +128,7 @@ os.makedirs(build_dir + "/conf", exist_ok=True)
 subprocess.check_call("cp -r %s/build/conf/auto.conf %s/conf" % (gitdir, build_dir), shell=True)
 
 # Run actual test script
-ret = subprocess.call("BDIR=%s . ./oe-init-build-env >/dev/null; oe-build-perf-test --out-dir %s --globalres-file %s --lock-file %s/oe-build-perf.lock"
+ret = subprocess.call("BDIR=%s source ./build/init-build-env >/dev/null; oe-build-perf-test --out-dir %s --globalres-file %s --lock-file %s/oe-build-perf.lock"
  % (build_dir, results_tmpdir, globalres_log, args.work_dir), shell=True)
 
 if ret == 1:
@@ -147,7 +147,7 @@ if git_repo:
     print("\nArchiving results in " + git_repo)
 
     os.makedirs(git_repo, exist_ok=True)
-    subprocess.check_call("BDIR=%s . ./oe-init-build-env >/dev/null; oe-git-archive " % build_dir + \
+    subprocess.check_call("BDIR=%s source ./build/init-build-env >/dev/null; oe-git-archive " % build_dir + \
         "--git-dir " + git_repo + " " \
         "--branch-name '{hostname}/{branch}/{machine}' " \
         "--tag-name '{hostname}/{branch}/{machine}/{commit_count}-g{commit}/{tag_number}' " \
@@ -182,8 +182,8 @@ if git_repo:
         with open(report_txt, "w") as f:
             f.write("HTML Report/Graphs are available at:\n    %s\n\n" % url)
 
-    subprocess.check_call("BDIR=%s . ./oe-init-build-env >/dev/null; oe-build-perf-report -r %s %s >> %s" % (build_dir, git_repo, extraopts, report_txt), shell=True)
-    subprocess.check_call("BDIR=%s . ./oe-init-build-env >/dev/null; oe-build-perf-report -r %s %s --html > %s " % (build_dir, git_repo, extraopts, report_html), shell=True)
+    subprocess.check_call("BDIR=%s source ./build/init-build-env >/dev/null; oe-build-perf-report -r %s %s >> %s" % (build_dir, git_repo, extraopts, report_txt), shell=True)
+    subprocess.check_call("BDIR=%s source ./build/init-build-env >/dev/null; oe-build-perf-report -r %s %s --html > %s " % (build_dir, git_repo, extraopts, report_html), shell=True)
 
     subprocess.check_call("cp %s %s/%s.txt" % (report_txt, global_results, filename), shell=True)
     subprocess.check_call("cp %s %s/%s.html" % (report_html, global_results, filename), shell=True)
diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index 5f396a9..5ce6204 100755
--- a/scripts/getproperties.py
+++ b/scripts/getproperties.py
@@ -6,6 +6,8 @@ import sys
 
 builddir = sys.argv[1]
 
+builddir = builddir + "/layers/openembedded-core/"
+
 jsonprops = {}
 jsonprops['yp_build_revision'] =  subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=builddir).decode('utf-8').strip()
 jsonprops['yp_build_branch'] = subprocess.check_output(["git", "rev-parse", "--abbrev-ref", "HEAD"], cwd=builddir).decode('utf-8').strip()
diff --git a/scripts/layer-config b/scripts/layer-config
index 93dc7e3..348f9df 100755
--- a/scripts/layer-config
+++ b/scripts/layer-config
@@ -26,33 +26,23 @@ args = parser.parse_args()
 ourconfig = utils.loadconfig()
 
 def bitbakecmd(targetdir, cmd):
-    subprocess.check_call(". ./oe-init-build-env; %s" % cmd, shell=True, cwd=targetdir)
+    subprocess.check_call(". ./init-build-env; %s" % cmd, shell=True, cwd=targetdir)
 
 needrepos = utils.getconfigvar("NEEDREPOS", ourconfig, args.target, None)
 
-callinit = False
-
 repos = utils.getconfig("repo-defaults", ourconfig)
 
 for repo in needrepos:
     repo_basename = repo.split('/')[0]
-    checkdir = repo_basename
-    if repo_basename in repos:
-        if "call-init" in repos[repo_basename] and repos[repo_basename]["call-init"]:
-            callinit = True
-        if "checkout-dirname" in repos[repo_basename]:
-            checkdir = repos[repo_basename]["checkout-dirname"]
-
+    if repo_basename in ['bitbake', 'oecore']:
+        continue
     source = args.abworkdir + "/repos/" + repo_basename
-    destination = args.abworkdir + "/" + checkdir
-    if not os.path.isdir(destination) or callinit:
+    destination = args.abworkdir + "/" + repo_basename
+    if not os.path.isdir(destination):
         utils.mkdir(destination)
         for f in os.listdir(source):
             subprocess.check_call(['mv', source + "/" + f, destination + "/"])
 
-if callinit:
-    subprocess.check_call(". ./oe-init-build-env", shell=True, cwd=args.abworkdir)
-
 for repo in needrepos:
     repo_basename = repo.split('/')[0]
     if repo_basename in repos and "no-layer-add" in repos[repo_basename] and repos[repo_basename]["no-layer-add"]:
@@ -61,7 +51,7 @@ for repo in needrepos:
     if repo_basename in nolayeradd:
         continue
     try:
-        bitbakecmd(args.abworkdir, "bitbake-layers add-layer %s" % (args.abworkdir + "/" + repo))
+        bitbakecmd(args.abworkdir + "/build", "bitbake-layers add-layer %s" % (args.abworkdir + "/" + repo))
     except subprocess.CalledProcessError as e:
         utils.printheader("ERROR: Command %s failed with exit code %d, see errors above." % (e.cmd, e.returncode))
         sys.exit(e.returncode)
diff --git a/scripts/run-config b/scripts/run-config
index 98b48e5..17610ea 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -157,7 +157,7 @@ elif extratools:
     if args.phase == "init" and args.stepname == "extratools":
         sys.exit(0)
 
-logconfig = args.builddir + "/../bitbake/contrib/autobuilderlog.json"
+logconfig = args.builddir + "/../layers/bitbake/contrib/autobuilderlog.json"
 print("Using BB_LOGCONFIG=%s" % logconfig)
 os.environ["BB_LOGCONFIG"] = logconfig
 
@@ -202,21 +202,23 @@ def bitbakecmd(builddir, cmd, report, stepnum, stepname, oeenv=True):
     except FileNotFoundError:
         numreports = 0
 
+    cmdpath = builddir
+
     def writelog(msg, a, b):
         a.write(msg)
         b.write(msg)
 
     if oeenv:
-        cmd = ". ./oe-init-build-env; %s" % cmd
+        cmd = ". ./init-build-env; %s" % cmd
 
     if testmode:
         print("Would run '%s'" % cmd)
         return
 
     with open(log, "a") as outf:
-        writelog("Running '%s' with output to %s\n" % (cmd, log), outf, sys.stdout)
+        writelog("Running '%s' with output to %s in %s\n" % (cmd, log, cmdpath), outf, sys.stdout)
 
-    with subprocess.Popen(cmd, shell=True, cwd=builddir + "/..", stdout=subprocess.PIPE, stderr=subprocess.STDOUT, bufsize=0) as p, open(log, 'ab') as f:
+    with subprocess.Popen(["/bin/bash", "-c", cmd], cwd=cmdpath, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, bufsize=0) as p, open(log, 'ab') as f:
         for line in p.stdout:
             writelog(line, f, sys.stdout.buffer)
             sys.stdout.flush()
@@ -370,9 +372,10 @@ elif args.phase == "finish" and args.stepname == "send-errors":
 
 if jcfg:
     addentry("builddir-cleanup", "Cleaning up build directory", "finish")
-elif args.phase == "finish" and args.stepname == "builddir-cleanup":
+# full/quick have a second phase in post-trigger
+elif args.phase == "finish" and args.stepname == "builddir-cleanup" and args.target not in ["a-full", "a-quick"]:
     if args.builddir and os.path.exists(args.builddir):
-        if os.path.exists("oe-init-build-env"):
+        if os.path.exists(args.builddir + "/build/init-build-env"):
             bitbakecmd(args.builddir, "bitbake -m", report, 99, args.stepname)
         runcmd(["mv", args.builddir, args.builddir + "-renamed"])
 
diff --git a/scripts/run-cvecheck b/scripts/run-cvecheck
index c6b0066..39ee5ba 100755
--- a/scripts/run-cvecheck
+++ b/scripts/run-cvecheck
@@ -73,7 +73,7 @@ fi
 
 cd ..
 set +u
-. oe-init-build-env build
+source build/init-build-env build
 set -u
 bitbake world --runall cve_check -R conf/distro/include/cve-extra-exclusions.inc
 
diff --git a/scripts/run-patchtest-selftest b/scripts/run-patchtest-selftest
index 58edb0e..197edf7 100755
--- a/scripts/run-patchtest-selftest
+++ b/scripts/run-patchtest-selftest
@@ -9,10 +9,10 @@ set -u
 set -o pipefail
 set -x
 
-pokydir=$(realpath "$1")
+oecoredir=$(realpath "$1")/layers/openembedded-core/
 
 python3 -m venv venv --without-pip --system-site-packages
 source venv/bin/activate
-python3 -m pip install -r $pokydir/meta/lib/patchtest/requirements.txt
+python3 -m pip install -r $oecoredir/meta/lib/patchtest/requirements.txt
 
-$pokydir/meta/lib/patchtest/selftest/selftest
+$oecoredir/meta/lib/patchtest/selftest/selftest
diff --git a/scripts/setup-config b/scripts/setup-config
index 594ff5e..c311d95 100755
--- a/scripts/setup-config
+++ b/scripts/setup-config
@@ -56,13 +56,23 @@ sdkextraconf = os.path.join(args.builddir, "conf", "sdk-extra.conf")
 if os.path.exists(sdkextraconf):
     os.remove(sdkextraconf)
 
-for v in ["MACHINE", "DISTRO", "SDKMACHINE", "PACKAGE_CLASSES"]:
+for v in ["SDKMACHINE", "PACKAGE_CLASSES"]:
     value = utils.getconfigvar(v, ourconfig, args.target, stepnum)
     if value and value != "None":
         variables.append(v + ' = "%s"' % value)
 
+machine = utils.getconfigvar("MACHINE", ourconfig, args.target, stepnum) 
 distro = utils.getconfigvar("DISTRO", ourconfig, args.target, stepnum)
 
+def enable_fragment(fragment):
+    cmd = ". ./init-build-env; bitbake-config-build enable-fragment %s" % fragment
+    cmdpath = args.builddir
+
+    print("Running '%s' in %s\n" % (cmd, cmdpath))
+    utils.flush()
+    subprocess.check_call(["/bin/bash", "-c", cmd], cwd=cmdpath)
+
+
 for v in ["DLDIR", "PRSERV"]:
     value = utils.getconfigvar(v, ourconfig, args.target, stepnum)
     if value:
@@ -130,3 +140,8 @@ with open(sdkextraconf, "w") as f:
         print("  " + v)
         f.write(v + "\n")
 
+if machine:
+    enable_fragment("machine/" + machine)
+if distro:
+    enable_fragment("distro/" + distro)
+
diff --git a/scripts/shared-repo-unpack b/scripts/shared-repo-unpack
index 5269e0e..5c30baa 100755
--- a/scripts/shared-repo-unpack
+++ b/scripts/shared-repo-unpack
@@ -46,17 +46,19 @@ stashdir = utils.getconfig("REPO_STASH_DIR", ourconfig)
 
 needrepos = utils.getconfigvar("NEEDREPOS", ourconfig, args.target, None)
 
-with open(args.repojson) as f:
+layerjson = args.repojson
+bbsetup_json = args.repojson.replace("layerinfo.json", "bbsetup-overrides.json")
+
+with open(layerjson) as f:
     repos = json.load(f)
 
 utils.filterrepojson(repos, args.target)
 
+bitbake_setup = False
+
 targetsubdir = args.abworkdir + "/repos"
 needrepos_baseddirs = [r.split('/')[0] for r in needrepos]
 for repo in sorted(repos.keys()):
-    # gplv2 is no longer built/tested in master
-    if repo == "meta-gplv2":
-        continue
     if repo not in needrepos_baseddirs:
         continue
     if args.cache_dir:
@@ -76,7 +78,38 @@ for repo in sorted(repos.keys()):
 
 utils.setup_buildtools_tarball(ourconfig, args.workername, args.abworkdir + "/buildtools")
 
+if "bitbake" not in repos:
+    sys.exit(0)
+
 try:
-    subprocess.check_call([scriptsdir + "/layer-config", args.abworkdir, args.target])
+    bbs_dldir = utils.getconfigvar("BBSETUP_DLDIR", ourconfig, args.target, None)
+    bbs_config = utils.getconfiglist("BBSETUP_CONFIG", ourconfig, args.target, None)
+    bbs_fragments = utils.getconfiglist("BBSETUP_FRAGMENTS", ourconfig, args.target, None)
+    machine = utils.getconfigvar("MACHINE", ourconfig, args.target, None)
+    if machine:
+        bbs_fragments.append("machine/" + machine)
+    distro = utils.getconfigvar("DISTRO", ourconfig, args.target, None)
+    if distro:
+        bbs_fragments.append("distro/" + distro)
+
+    cmd = [targetsubdir + "/bitbake/bin/bitbake-setup",
+           "--setting", "default", "top-dir-prefix",  os.path.dirname(os.path.dirname(args.abworkdir)),
+           "--setting", "default", "top-dir-name", os.path.basename(os.path.dirname(args.abworkdir)),
+           "--setting", "default", "dl-dir", bbs_dldir,
+           "--global-settings", args.abworkdir + "/settings.conf",
+           "init",
+           "--skip-selection", "machine",
+           "--skip-selection", "distro",
+           "--source-overrides", bbsetup_json,
+           "--build-dir-name", "build",
+           "--non-interactive",
+           ] + bbs_config + bbs_fragments
+    print("Running command %s" % " ".join(cmd))
+    utils.flush()
+    subprocess.check_call(cmd)
+    layercmd = [scriptsdir + "/layer-config", args.abworkdir, args.target]
+    print("Running command %s" % " ".join(layercmd))
+    utils.flush()
+    subprocess.check_call(layercmd)
 except subprocess.CalledProcessError as e:
     sys.exit(e.returncode)
diff --git a/scripts/upload-error-reports b/scripts/upload-error-reports
index 36d7820..74a0ac9 100755
--- a/scripts/upload-error-reports
+++ b/scripts/upload-error-reports
@@ -22,7 +22,7 @@ if [ -d $BUILDDIR/tmp/log/error-report/ ]; then
     host=`hostname`
     echo "yp-ab-$host" > ~/.oe-send-error
 
-    . ./oe-init-build-env
+    source ./build/init-build-env
     for x in `ls $BUILDDIR/tmp/log/error-report/ | grep error_report_`; do
         send-error-report -y  -l $ERRORLINK tmp/log/error-report/$x
     done
diff --git a/scripts/utils.py b/scripts/utils.py
index ea92e0d..efc7c99 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -297,14 +297,12 @@ def publishrepo(clonedir, repo, publishdir):
     mkdir(publishdir)
     subprocess.check_call("rsync -av " + archive_name + "* " + publishdir, shell=True, cwd=sharedrepo)
 
-# The repo json needs to be filtered to allow builds with and without bitbake-setup
+# The repo json needs to be filtered for builds with bitbake-setup
 def filterrepojson(data, target=None):
-    # For a-full or a-quick, we want all repos. Otherwise we should use poky and ignore bitbake and friends
-    if target and target != "a-full" and target != "a-quick" and "poky" in data:
-        data.pop("bitbake", None)
-        data.pop("meta-yocto", None)
-        data.pop("yocto-docs", None)
-        data.pop("oecore", None)
+    if "poky" in data:
+        del data["poky"]
+    if "meta-gplv2" in data:
+        del data["meta-gplv2"]
     return
 
 def mkdir(path):

