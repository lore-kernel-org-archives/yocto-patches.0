Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF16CCF9E3
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 08:01:38 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6677.1762502488171166547
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Nov 2025 00:01:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lcqXUEqv;
 spf=pass (domain: gmail.com, ip: 209.85.208.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso788477a12.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 07 Nov 2025 00:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502486; x=1763107286; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rko6vZb7zHCcUc4g7OwVyeQ2NmWIZc8tsLab6b4z888=;
        b=lcqXUEqvGEi6e8EC3cbQr0dMAUX9tk2dAD3+4d+7kI/wQ/5UXjs4gJREwuiyCP8mjN
         8A+n+9eqy3nOOrd9UeZn23W3l+DCrToz6ymOkGeRYwqa+3aOjqDDsZH+QWPM/WKu7tWk
         AXesO84r4AmjUcbN4fksaxM3tvKQSGN4JwIZCd7jYjZBHZjglX7MDcCmRBbPJtXg5t34
         PKjYWQ1qN9ByJYnIcVeZLTcb5kYlkPGMskI7P4weH1/CJpiAV4ajGX4ISjTX66Beog3s
         jalTmtRRGWFa57DN8O3vyI7mUPWCsyBghVFQm0g4tzKXkH30sgkueO/Q2WMFwOPgrEuZ
         MbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502486; x=1763107286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rko6vZb7zHCcUc4g7OwVyeQ2NmWIZc8tsLab6b4z888=;
        b=ED8Duh7BVdNxcozU3EfoCqwtP3miS85hfAD6ojLYNu6t6k2/AyBXUzsYHD2Gk4Ew/V
         LJgxjHkSpwloZNHqQMx+oBT9ksQRotDIl6Scmb36YZCubJy44zkO2yEigDx4enuWhHz4
         kfUa0Z0R3HctVC+lLPyereN5g3akK+qEv3KYpGtyZgD2rCx/Q/E5k8y6JFWlAxh3vAIM
         IXxMZld0z5vqqMbIm0+Tbg54g73U+C1f/8IMxwNeydokOywOe7NBScLt8D2Ue/cOK2VJ
         m6seIXoRZLBxu+PGhOu5yp4mqJPzEzXb4YtFxQaRxbQTjNH3wkUuZE7XoQf6mfDCtt2l
         y0tQ==
X-Gm-Message-State: AOJu0YyxvIzLG9Y3Z9tZnT+5DdQ8nnU6XCw+hBSoWL3ZsHXmERutsPWj
	N435nyblYGQArEyeFaEWj6GlrsNuY0xR1Tp6hbGMOlJlqjLtJvAC7P/oAr8x9g==
X-Gm-Gg: ASbGnctfKvg621CCr92CJKeamINNLFyDOBvy2PLjb+9w6cR/2hWMK2QLXDVXFBNuGgP
	tDGCE32/w+c+6v5Z/tITkLFDXCBGnKWWluDaWluVXBrAXTfHSq0nVEEqiiR3mHRVIqQrXoNLJhh
	J4BhEH6Fvyy1UX8ELAi43q7UJgZ+amnpbXq/VQj1xTnbuoCA3G3Q33NCUwnvX0Q6VRSas99NJ7S
	J19RxEMLWVM8b6ruqn8fDj/lbGvNc+gJ/deyVSYnJsngs1O+Ptd9CXwrcnBy5R+y34vOci5YsEc
	9WY0dbWqYY/AIVScmSPOaXXLUIz3RVck9JNimyfv/Is0ryCH88gBD7pzcHjhlZ+W+jMLtarwg9G
	z/qeL7Z00upLeYvfmVawYdzZy4DtjWJqPzDrOgFOITx0e0yPhj9cNBgAh0UnuoYtfFrp4Q+/aht
	hH8ZAPDP6jOhpcSH+I1IZpOVaufeMDyw405xk7m7W2IApXP84=
X-Google-Smtp-Source: AGHT+IE0wxp3oGXMNx7AuZYauUEOpJQlAlzgQhxYLSK4TPJhOzrQmQESD1C67uOU1pQKhpLsfgPvYA==
X-Received: by 2002:a05:6402:3484:b0:640:b9c5:24a1 with SMTP id 4fb4d7f45d1cf-6413f09675cmr2192616a12.38.1762502486134;
        Fri, 07 Nov 2025 00:01:26 -0800 (PST)
Received: from alex-lx-laptop.lab.linutronix.de ([2a02:2455:86ac:8b00:8de8:97f1:4c58:d8a6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713970sm3620897a12.8.2025.11.07.00.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:01:25 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [yocto-autobuilder-helper][PATCH] config.json/scripts: account for 'layers' -> 'sources' rename in bitbake-setup
Date: Fri,  7 Nov 2025 09:01:14 +0100
Message-ID: <20251107080114.402494-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Nov 2025 08:01:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2429

From: Alexander Kanavin <alex@linutronix.de>

I hope nothing falls out; I carefully grepped for all occurences of
'layers' in the tree, and corrected all spots where that was a path
component.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 config.json                     | 40 ++++++++++++++++-----------------
 scripts/build-perf-test-wrapper |  2 +-
 scripts/getproperties.py        |  8 +++----
 scripts/run-config              |  2 +-
 scripts/run-patchtest-selftest  |  2 +-
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/config.json b/config.json
index f65563b..d9f14e0 100644
--- a/config.json
+++ b/config.json
@@ -89,7 +89,7 @@
             "step1" : {
                 "shortname" : "Machine oe-selftest",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest ${HELPERSTMACHTARGS} -j 15"],
-                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
+                "ADDLAYER" : ["${BUILDDIR}/../sources/openembedded-core/meta-selftest"]
             }
         },
         "altcfg-qemu" : {
@@ -225,7 +225,7 @@
                     "RPM_GPG_SIGN_CHUNK = '1'"
                 ],
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],
-                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
+                "ADDLAYER" : ["${BUILDDIR}/../sources/openembedded-core/meta-selftest"]
             }
         },
         "buildperf" : {
@@ -262,7 +262,7 @@
             "step2" : {
                 "shortname" : "OE Selftest",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg reproducible -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],
-                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
+                "ADDLAYER" : ["${BUILDDIR}/../sources/openembedded-core/meta-selftest"]
             },
             "step3" : {
                 "shortname" : "Python Linter Report",
@@ -282,7 +282,7 @@
             "step1" : {
                 "shortname" : "Reproducible Selftest",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest -r reproducible"],
-                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
+                "ADDLAYER" : ["${BUILDDIR}/../sources/openembedded-core/meta-selftest"]
 
             }
         },
@@ -291,7 +291,7 @@
             "SDKMACHINE" : "x86_64",
             "NEEDREPOS" : ["bitbake", "meta-openembedded"],
             "ADDLAYER" : [
-                "${BUILDDIR}/../layers/openembedded-core/meta-selftest"
+                "${BUILDDIR}/../sources/openembedded-core/meta-selftest"
             ],
             "extravars" : [
                 "EXCLUDE_FROM_WORLD:layer-core = '1'",
@@ -467,7 +467,7 @@
             "step1" : {
                 "shortname" : "Sources pre-fetching",
                 "BBTARGETS" : "universe -c fetch -k",
-                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"],
+                "ADDLAYER" : ["${BUILDDIR}/../sources/openembedded-core/meta-selftest"],
                 "extravars" : [
                     "SOURCE_MIRROR_FETCH = '1'"
                 ]
@@ -483,7 +483,7 @@
             "step1" : {
                 "shortname" : "Source Mirror Selftest",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -a -t yocto-mirrors -j 15"],
-                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
+                "ADDLAYER" : ["${BUILDDIR}/../sources/openembedded-core/meta-selftest"]
             }
         }
 
@@ -563,7 +563,7 @@
             "step1" : {
                 "shortname" : "Sources pre-fetching (arm specific)",
                 "BBTARGETS" : "universe -c fetch -k",
-                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"],
+                "ADDLAYER" : ["${BUILDDIR}/../sources/openembedded-core/meta-selftest"],
                 "extravars" : [
                     "SOURCE_MIRROR_FETCH = '1'"
                 ]
@@ -1197,10 +1197,10 @@
             "NEEDREPOS" : ["bitbake", "meta-mingw"],
             "DISTRO" : "nodistro",
             "step1" : {
-                "EXTRACMDS" : ["yocto-check-layer ../layers/meta-yocto/meta-poky"]
+                "EXTRACMDS" : ["yocto-check-layer ../sources/meta-yocto/meta-poky"]
             },
             "step2" : {
-                "EXTRACMDS" : ["yocto-check-layer ../layers/meta-yocto/meta-yocto-bsp"]
+                "EXTRACMDS" : ["yocto-check-layer ../sources/meta-yocto/meta-yocto-bsp"]
             },
             "step3" : {
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-mingw"]
@@ -1273,7 +1273,7 @@
             },
             "step2" : {
                 "shortname" : "Patch metrics for meta",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/run-patchmetrics --oecore ../layers/openembedded-core/ --metrics ./yocto-metrics --repo ../layers/openembedded-core/ --layer ../layers/openembedded-core/meta --branch ${HELPERBRANCHNAME} --results ${HELPERRESULTSDIR}/../../patchmetrics --push"]
+                "EXTRACMDS" : ["${SCRIPTSDIR}/run-patchmetrics --oecore ../sources/openembedded-core/ --metrics ./yocto-metrics --repo ../sources/openembedded-core/ --layer ../sources/openembedded-core/meta --branch ${HELPERBRANCHNAME} --results ${HELPERRESULTSDIR}/../../patchmetrics --push"]
             },
             "step3" : {
                 "shortname" : "CVE checks for meta",
@@ -1281,7 +1281,7 @@
             },
             "step4" : {
                 "shortname" : "Patch metrics for meta-oe",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/run-patchmetrics --oecore ../layers/openembedded-core/ --metrics ./yocto-metrics-meta-oe --repo ../meta-openembedded --layer ../meta-openembedded --branch ${HELPERBRANCHNAME} --results ${HELPERRESULTSDIR}/../../patchmetrics-meta-oe --push"]
+                "EXTRACMDS" : ["${SCRIPTSDIR}/run-patchmetrics --oecore ../sources/openembedded-core/ --metrics ./yocto-metrics-meta-oe --repo ../meta-openembedded --layer ../meta-openembedded --branch ${HELPERBRANCHNAME} --results ${HELPERRESULTSDIR}/../../patchmetrics-meta-oe --push"]
             },
             "step5" : {
                 "shortname" : "CVE checks for meta-oe",
@@ -1465,7 +1465,7 @@
                     "IMAGE_INSTALL:append = ' service hello-mod'",
                     "TEST_SUITES:append = ' skeletoninit'"
                 ],
-                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-skeleton"]
+                "ADDLAYER" : ["${BUILDDIR}/../sources/openembedded-core/meta-skeleton"]
             },
             "step4" : {
                 "shortname" : "Systemd with sysvinit compat",
@@ -1532,9 +1532,9 @@
             "step1" : {
                 "shortname" : "setup AUH",
                 "EXTRAPLAINCMDS" : [
-                    "git -C ../layers/openembedded-core config user.email auh@yoctoproject.org",
-                    "git -C ../layers/openembedded-core config user.name 'Auto Upgrade Helper'",
-                    "git -C ../layers/openembedded-core switch -C tmp-auh-upgrades HEAD",
+                    "git -C ../sources/openembedded-core config user.email auh@yoctoproject.org",
+                    "git -C ../sources/openembedded-core config user.name 'Auto Upgrade Helper'",
+                    "git -C ../sources/openembedded-core switch -C tmp-auh-upgrades HEAD",
                     "install -D ${SCRIPTSDIR}/auh-config/upgrade-helper.conf ./upgrade-helper/upgrade-helper.conf"
                 ]
             },
@@ -1679,7 +1679,7 @@
             "step1" : {
                 "shortname" : "Yocto Mirror Selftest",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"],
-                "ADDLAYER" : ["${BUILDDIR}/../layers/openembedded-core/meta-selftest"]
+                "ADDLAYER" : ["${BUILDDIR}/../sources/openembedded-core/meta-selftest"]
             }
         },
         "meta-oe-mirror" : {
@@ -1687,7 +1687,7 @@
             "MACHINE" : "qemux86-64",
             "NEEDREPOS" : ["bitbake", "meta-openembedded"],
             "ADDLAYER" : [
-                "${BUILDDIR}/../layers/openembedded-core/meta-selftest",
+                "${BUILDDIR}/../sources/openembedded-core/meta-selftest",
 
                 "${BUILDDIR}/../meta-openembedded/meta-oe",
                 "${BUILDDIR}/../meta-openembedded/meta-python",
@@ -1772,11 +1772,11 @@
 	    "NEEDREPOS" : ["bitbake"],
 	    "EXTRACMDS" : ["${SCRIPTSDIR}/run-patchtest-selftest ${HELPERBUILDDIR}/.."],
 	    "ADDLAYER" : [
-	        "${BUILDDIR}/../layers/openembedded-core/meta-selftest"
+	        "${BUILDDIR}/../sources/openembedded-core/meta-selftest"
 	    ]
 	},
         "toaster" : {
-            "EXTRACMDS" : ["${SCRIPTSDIR}/run-toaster-tests ${HELPERBUILDDIR} ${HELPERBUILDDIR}/../layers/bitbake"]
+            "EXTRACMDS" : ["${SCRIPTSDIR}/run-toaster-tests ${HELPERBUILDDIR} ${HELPERBUILDDIR}/../sources/bitbake"]
         }
     },
     "repo-defaults" : {
diff --git a/scripts/build-perf-test-wrapper b/scripts/build-perf-test-wrapper
index 989e898..66c4ab9 100755
--- a/scripts/build-perf-test-wrapper
+++ b/scripts/build-perf-test-wrapper
@@ -78,7 +78,7 @@ hostname = os.uname()[1]
 
 print("Running on " + hostname)
 
-gitdir = args.build_dir + "/../layers/openembedded-core"
+gitdir = args.build_dir + "/../sources/openembedded-core"
 
 os.chdir(gitdir)
 
diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index 5c342c7..2af176e 100755
--- a/scripts/getproperties.py
+++ b/scripts/getproperties.py
@@ -27,8 +27,8 @@ jsonprops = {}
 jsonprops['commit_yocto-autobuilder-helper'] = get_revision(builddir + "/../yocto-autobuilder-helper/")
 jsonprops['branch_yocto-autobuilder-helper'] = get_branch(builddir + "/../yocto-autobuilder-helper/")
 #set below to a combined hash
-#jsonprops['yp_build_revision'] = get_revision(builddir + "/layers/openembedded-core/")
-jsonprops['yp_build_branch'] = get_branch(builddir + "/layers/openembedded-core/")
+#jsonprops['yp_build_revision'] = get_revision(builddir + "/sources/openembedded-core/")
+jsonprops['yp_build_branch'] = get_branch(builddir + "/sources/openembedded-core/")
 
 done = []
 
@@ -36,8 +36,8 @@ def getrevs(jsonprops, layerpath, layername):
     jsonprops['commit_' + layername] = get_revision(layerpath)
     jsonprops['branch_' + layername ] = get_branch(layerpath)
 
-for layer in os.listdir(builddir + "/layers"):
-    layerpath = builddir + "/layers/" + layer
+for layer in os.listdir(builddir + "/sources"):
+    layerpath = builddir + "/sources/" + layer
     if layer == "logs" or os.path.islink(layerpath):
         continue
     if not os.path.isdir(layerpath):
diff --git a/scripts/run-config b/scripts/run-config
index 17610ea..8731000 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -157,7 +157,7 @@ elif extratools:
     if args.phase == "init" and args.stepname == "extratools":
         sys.exit(0)
 
-logconfig = args.builddir + "/../layers/bitbake/contrib/autobuilderlog.json"
+logconfig = args.builddir + "/../sources/bitbake/contrib/autobuilderlog.json"
 print("Using BB_LOGCONFIG=%s" % logconfig)
 os.environ["BB_LOGCONFIG"] = logconfig
 
diff --git a/scripts/run-patchtest-selftest b/scripts/run-patchtest-selftest
index 197edf7..5157bb0 100755
--- a/scripts/run-patchtest-selftest
+++ b/scripts/run-patchtest-selftest
@@ -9,7 +9,7 @@ set -u
 set -o pipefail
 set -x
 
-oecoredir=$(realpath "$1")/layers/openembedded-core/
+oecoredir=$(realpath "$1")/sources/openembedded-core/
 
 python3 -m venv venv --without-pip --system-site-packages
 source venv/bin/activate
-- 
2.47.2


