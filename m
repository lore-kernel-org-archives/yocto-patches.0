Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D92C3600E
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 21:42:12 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.8067.1742938929867465376
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Mar 2025 14:42:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=a2vrI29j;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0618746bso42359285e9.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 25 Mar 2025 14:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742938928; x=1743543728; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uyg5mN2TJjXy92KgNNe7mNFlKeAGTICZ4jAROs2SXjE=;
        b=a2vrI29jHeU2/Brc6h9h9n/zLfKbQQqcv7z/6SZnIK6W3OhbtNNmrLr27GJK63t76G
         DHJptRvKitEEn22wEYgyHeyhPN/t3CrNYsg6te+nUY0SP0zjhsy0b4k9JkLChpZxf23E
         l+p8N2se33RRLlGl3c6tVyEcY+0RtySdx3XtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938928; x=1743543728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyg5mN2TJjXy92KgNNe7mNFlKeAGTICZ4jAROs2SXjE=;
        b=bhNtGTAx5lDzljPqs5iQkDNYMQu7JfZ3SkaMEK8BAuOzSqBh92IXibF/mze1xlppEA
         b6BUzA0Fu5+YSo7y+yRnmk6rnF5jS1f84nBTkd5UF8tT0E/t6AeZSZi94HOij7C5O+4b
         YXm17md4XUKaOvhXEjuaTkGoVhQk3M+0TUU/lXfzhVdXBTj5X5Rn21udg1ymkBA1dmXI
         AmPRAIjIol4VxDZjab4qIY9rGvFnp/hzEF88uIyEZZbA/sZujz7PkoCvoLS0T2eC2ktD
         vVSlCnUYqt3gEqInualDnPYwKv4G5KuO1bFzlAMyCLfR8Z3d9UmtM82fduJKWg1EMqiv
         +BRg==
X-Gm-Message-State: AOJu0YwLHnnDNy/NJ7LU5BM1wj9jkg8vdOv5z8mTNqvLl4wpSL7pv85O
	oWhBuQAb9pYAplxd1QQ1PVWsmDObx+xECLIZc5KzHMYLMqZoi4/yuDw3hPGOB4kqHJ9xSE55GhW
	t
X-Gm-Gg: ASbGnct1HyLykPJxbc6RT1tahhFs7fz2KxABmu+IYNf14Hk3qeHwYYWEJ8X1Ob96W7g
	dESgIUZ75gLLfHzif2OaHMBoVuEvhNGF2RvDDspG5YK/Fm8CUgzk5DCxJ0mmiyTpP1QL+OaILdo
	RoRKW0PVaHAjFpoDwrdjOAnrBqA3saXMIHdbl5KqMV7QOra+IUGYjiUaY19KMbkvfNjd5f5f0hZ
	64Q0bnN/7uHdvkqi8VVnufsv+yK6k06mDuMsNhhSF4N1bOJ14hE/6Fn/rDbvqx6xCgdAJmilR8x
	YVO9cdO8P7eE3c7CyVfzNBFswiMqne0MbqgG/iMGC6dOiQ3RtzbgzcZBvcMk9fOjys38Vf0UBFC
	VsIyIIoyE
X-Google-Smtp-Source: AGHT+IFY2r+F3U1wmwLvI9VSzZYhXJ23iWXRL6O/oyJSLtj2QHB2xDpm4m3wOpn6v1i2Id41aZm7zA==
X-Received: by 2002:a05:600c:568d:b0:43d:2230:303b with SMTP id 5b1f17b1804b1-43d511012a1mr138206005e9.20.1742938927537;
        Tue, 25 Mar 2025 14:42:07 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:367a:5014:d4b0:4e9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d74b48b90sm14167285e9.14.2025.03.25.14.42.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:42:06 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Start to use config fragments
Date: Tue, 25 Mar 2025 21:42:04 +0000
Message-ID: <20250325214204.641484-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Mar 2025 21:42:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1250

Switch the autobuilder to use the config fragements in OE-Core, maintained
there so people can easily see and test with them if needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 67 +++++++----------------------------------------------
 1 file changed, 9 insertions(+), 58 deletions(-)

diff --git a/config.json b/config.json
index e01eef3..cae86d7 100644
--- a/config.json
+++ b/config.json
@@ -41,39 +41,8 @@
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
-            "SANITY_TESTED_DISTROS = ''",
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
@@ -866,9 +835,7 @@
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
@@ -877,9 +844,7 @@
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
@@ -921,9 +886,7 @@
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
@@ -934,9 +897,7 @@
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
@@ -946,9 +907,7 @@
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
@@ -961,9 +920,7 @@
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
@@ -974,9 +931,7 @@
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
@@ -986,11 +941,7 @@
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

