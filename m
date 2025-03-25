Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC02C36008
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 21:50:02 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.8268.1742939401441481075
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Mar 2025 14:50:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gK4Nxfxl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0782d787so43319155e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 25 Mar 2025 14:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742939399; x=1743544199; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0C8NlKxL6PMrSEhUmA1xRWt4ReOEuhIrSQyZAj57hk=;
        b=gK4NxfxlCzELNnN6mfZ1tue+0hHvQnqbf+ZINfdq7PzM3LHuaFOWk8o6dOmKvVNLQg
         b4a/Ib1HHzniR9TDx1InwxpaN0+NZnSOf0h1AxU/5fGVkP3/vAv/kIfZKNv2IwgRfNiD
         SYD+ZQTWjiwNx6TAzZorfHGH+BB09FU61SQXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742939399; x=1743544199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0C8NlKxL6PMrSEhUmA1xRWt4ReOEuhIrSQyZAj57hk=;
        b=BpNk+hZWqjxIUWi7FRFQxWRTYRZgJlFRvhLZi5iAP9IIbg5gGf9WQZOvw1D2PZeS0Y
         dBaJkmTj3LgFfujN4oSyeRh1KU2kTf05zHfHg7v6TgaGbZgIOlA1j8jl7fRiKdEdWTwj
         NUZxJIiJ5LjjkJ/Pk7UXQZwKm3DrspxYOKDcvuOVJsKzx6eHZQ/pyO6JvcX8E0COi84O
         htScPc1PPZFNINsvacHmivuhjknWbHjasL+8yPLfjQE0zEKoD8woHOYdG2+vFRpwHxM7
         fPgCAlVs3Vr5MM49g3CxtdNZV5vBl5qcE/ImzB7wc4/y7Z+af/78gSsDh2mX4DDBScH/
         L3zA==
X-Gm-Message-State: AOJu0YyBqvc1gD0z7+hGr9hBtzOPPEVYCBCTxpr03/QnRhguNfB6mY0q
	jUysbtAyxQxZ75PjDdOcz2A9Hi2gtm/J3udxhTYoRLJz+jtsdDttvJuIRFuP4Keg5ZLjGxIpeqk
	u
X-Gm-Gg: ASbGncvKwgsjD3ioxvmRxjAG7CDSQOizIsKuo9Dn03SRrSFWlfdvoh4Cn9uGWKzFY7M
	cdnNdNI50rTgDFREmNeyWiqoWd4xmESGgmom3BMg+HK8vCMVIGdDFYUksWf+q3CERyB+xd6SABX
	takRNeFg4BP7egMgj/ULIj3NVVyhc2xSwSwsfiXzTbfzoX/sSgzy+aC+ByXgCqbH3xNyNQTOyvI
	F6HqsAg44NweTZCWFUst+OS3zv6rqcUUOCsU+5A0W7txxEij1o3XKV0rNRDEPQ18jRWYfh9m/Qv
	FX7OCH+ANXId0IBnLuDUCfxx7AAHxTJinbwcN5rphoGM4oZlxp5T81nepuCkuwCNjbWNGqDxaA=
	=
X-Google-Smtp-Source: AGHT+IHl10GfoPCT9HWhUkD8t7MWMWfXgmwYfr43XGgnornCFDqo1/ZvFjYSmJZVTVO3TCHteH9U7Q==
X-Received: by 2002:a05:600c:5021:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-43d509f6307mr200326945e9.18.1742939399143;
        Tue, 25 Mar 2025 14:49:59 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:367a:5014:d4b0:4e9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd26cecsm161474715e9.17.2025.03.25.14.49.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:49:57 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH v2] config.json: Start to use config fragments
Date: Tue, 25 Mar 2025 21:49:56 +0000
Message-ID: <20250325214956.643973-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Mar 2025 21:50:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1251

Switch the autobuilder to use the config fragements in OE-Core, maintained
there so people can easily see and test with them if needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 66 ++++++++---------------------------------------------
 1 file changed, 9 insertions(+), 57 deletions(-)

diff --git a/config.json b/config.json
index e01eef3..92cbc82 100644
--- a/config.json
+++ b/config.json
@@ -41,39 +41,9 @@
         "WRITECONFIG" : true,
         "SENDERRORS" : true,
         "extravars" : [
-            "QEMU_USE_KVM = 'True'",
-            "INHERIT += 'report-error'",
-            "PREMIRRORS = ''",
-            "BB_GENERATE_MIRROR_TARBALLS = '1'",
-            "BB_NUMBER_THREADS = '16'",
-            "BB_NUMBER_PARSE_THREADS = '16'",
-            "PARALLEL_MAKE = '-j 16 -l 75'",
-            "BB_PRESSURE_MAX_CPU = '20000'",
-            "BB_PRESSURE_MAX_IO = '20000'",
-            "XZ_MEMLIMIT = '5%'",
-            "XZ_THREADS = '8'",
-            "ZSTD_THREADS = '8'",
-            "BB_TASK_NICE_LEVEL = '5'",
-            "BB_TASK_NICE_LEVEL:task-testimage = '0'",
-            "BB_TASK_IONICE_LEVEL = '2.7'",
-            "BB_TASK_IONICE_LEVEL:task-testimage = '2.1'",
-            "IMAGE_CLASSES += 'testimage'",
-            "TEST_QEMUBOOT_TIMEOUT = '1500'",
             "SANITY_TESTED_DISTROS = ''",
-            "SDK_EXT_TYPE = 'minimal'",
-            "SDK_INCLUDE_TOOLCHAIN = '1'",
-            "ESDK_LOCALCONF_REMOVE:append = 'BB_HASHSERVE'",
-            "BB_DISKMON_DIRS = 'STOPTASKS,${TMPDIR},1G,100K STOPTASKS,${DL_DIR},1G STOPTASKS,${SSTATE_DIR},1G STOPTASKS,/tmp,100M,30K HALT,${TMPDIR},100M,1K HALT,${DL_DIR},100M HALT,${SSTATE_DIR},100M HALT,/tmp,10M,1K'",
             "BB_HASHSERVE = '${AUTOBUILDER_HASHSERV}'",
-            "RUNQEMU_TMPFS_DIR = '/home/pokybuild/tmp'",
-            "BB_HEARTBEAT_EVENT = '60'",
-            "BB_LOG_HOST_STAT_ON_INTERVAL = '1'",
-            "BB_LOG_HOST_STAT_CMDS_INTERVAL = 'oe-time-dd-test.sh -c 100 -t 3'",
-            "BB_LOG_HOST_STAT_ON_FAILURE = '1'",
-            "BB_LOG_HOST_STAT_CMDS_FAILURE = 'oe-time-dd-test.sh -l'",
-            "SDK_TOOLCHAIN_LANGS += 'rust'",
-            "BB_SERVER_TIMEOUT = '60'",
-            "BB_LOADFACTOR_MAX = '1.5'"
+            "OE_FRAGMENTS += 'core/yocto-autobuilder/autobuilder core/yocto-autobuilder/autobuilder-resource-constraints'"
         ]
     },
     "templates" : {
@@ -866,9 +836,7 @@
             "MACHINE" : "qemux86-64",
             "BBTARGETS" : "world",
             "extravars" : [
-                "require conf/multilib.conf",
-                "MULTILIBS = 'multilib:lib32'",
-                "DEFAULTTUNE:virtclass-multilib-lib32 = 'x86'"
+                "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib32'"
             ]
         },
         "qemux86-world-alt" : {
@@ -877,9 +845,7 @@
             "BBTARGETS" : "world",
             "extravars" : [
                 "DISTRO_FEATURES:append = ' api-documentation'",
-                "require conf/multilib.conf",
-                "MULTILIBS = 'multilib:lib32'",
-                "DEFAULTTUNE:virtclass-multilib-lib32 = 'x86'"
+                "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib32'"
             ]
         },
         "qemux86-64-x32" : {
@@ -921,9 +887,7 @@
                 "SANITYTARGETS" : "lib32-core-image-minimal:do_testimage",
                 "extravars" : [
                     "TEST_SUITES = 'ping'",
-                    "require conf/multilib.conf",
-                    "MULTILIBS = 'multilib:lib32'",
-                    "DEFAULTTUNE:virtclass-multilib-lib32 = 'x86'"
+                    "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib32'"
                 ]
             },
             "step2" : {
@@ -934,9 +898,7 @@
                 "SANITYTARGETS" : "lib32-core-image-minimal:do_testimage",
                 "extravars" : [
                     "TEST_SUITES = 'ping'",
-                    "require conf/multilib.conf",
-                    "MULTILIBS = 'multilib:lib32'",
-                    "DEFAULTTUNE:virtclass-multilib-lib32 = 'x86'"
+                    "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib32'"
                 ]
             },
             "step3" : {
@@ -946,9 +908,7 @@
                 "SANITYTARGETS" : "core-image-sato:do_testimage",
                 "extravars" : [
                     "TEST_SUITES:append = ' multilib'",
-                    "require conf/multilib.conf",
-                    "MULTILIBS = 'multilib:lib32'",
-                    "DEFAULTTUNE:virtclass-multilib-lib32 = 'x86'",
+                    "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib32'",
                     "RPM_PREFER_ELF_ARCH = '1'",
                     "IMAGE_INSTALL:append = ' lib32-connman-gnome pango-module-basic-fc lib32-pango-module-basic-fc'"
                 ]
@@ -961,9 +921,7 @@
                 "SANITYTARGETS" : "core-image-sato:do_testimage",
                 "extravars" : [
                     "TEST_SUITES:append = ' multilib'",
-                    "require conf/multilib.conf",
-                    "MULTILIBS = 'multilib:lib32'",
-                    "DEFAULTTUNE:virtclass-multilib-lib32 = 'x86'",
+                    "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib32'",
                     "RPM_PREFER_ELF_ARCH = '1'",
                     "IMAGE_INSTALL:append = ' lib32-connman-gnome pango-module-basic-fc lib32-pango-module-basic-fc'"
                 ]
@@ -974,9 +932,7 @@
                 "MACHINE" : "qemux86",
                 "BBTARGETS" : "lib64-core-image-sato lib64-core-image-sato-sdk",
                 "extravars" : [
-                    "require conf/multilib.conf",
-                    "MULTILIBS = 'multilib:lib64'",
-                    "DEFAULTTUNE:virtclass-multilib-lib64 = 'x86-64'"
+                    "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib64'"
                 ]
             },
             "step6" : {
@@ -986,11 +942,7 @@
                 "BBTARGETS" : "core-image-minimal core-image-minimal:do_populate_sdk",
                 "SANITYTARGETS" : "core-image-minimal:do_testimage core-image-minimal:do_testsdk",
                 "extravars" : [
-                    "require conf/multilib.conf",
-                    "MULTILIBS = 'multilib:lib64 multilib:lib32'",
-                    "DEFAULTTUNE = 'mips64-n32'",
-                    "DEFAULTTUNE:virtclass-multilib-lib64 = 'mips64'",
-                    "DEFAULTTUNE:virtclass-multilib-lib32 = 'mips32r2'"
+                    "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-mips64-n32'"
                 ]
             }
         },

