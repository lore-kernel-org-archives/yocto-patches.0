Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345EF106FD9D
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 08:19:04 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11108.1773389938130989798
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Mar 2026 01:18:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eMGpiauR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so1548166f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773389936; x=1773994736; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGzSmaWOkhgkU4AaHnZEhwVLNRex57HXYxU1RsB33uY=;
        b=eMGpiauRT7/sH3srjWGhGWd9mufPPAUVxYmOhc+Ow4FI0Chfr/SAnFlTNk4hRiW7EM
         fnUPhMiw9XQN8//j8E0ZvunbxQUZ1sxqv5Aqbjfwsw5z+oqJDxYrDr/Q4Lfy2H698WS1
         epc/MH69B92Lv+b4QZzpM2Hzr0kCJ8Fj0+3Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773389936; x=1773994736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGzSmaWOkhgkU4AaHnZEhwVLNRex57HXYxU1RsB33uY=;
        b=dE3UtBTLTxtL0QzgxaLPo+lPkyregwsZE5XsQfIYy+FUyuUNQfIhfro4ZJ+aYNUSoj
         t/Gsbr7Qen3Ujpyi0fSbzymbxSuRoweyPIFJr50BcmUezx+jX2ZkvaaGZB8c0FNqCEBS
         wMZ1AA1gaJmVrpLdmui4/iMS1nUfui0K6u7elPxOAmt45LvZ9o6DvgKJZN1rJc8r7yg8
         atZkzxuMxSyhtR9sagDoOiz9AYE9NCYkhMhpG93KZ4mmXZQv1biNl+hN1yUZrFXFu11/
         lZYodfr00Vum7M/aT/ty+j4Z0PovQtbk09EQ8aq81/unOa2ae0r1cOE4P1FnSVq+SPwz
         xEPw==
X-Gm-Message-State: AOJu0YzToHIsOOTqFPLThFGMm2AS5ngft0SJT7FiY4skz3WHRrWy3dJS
	RAY9c6u9TR5o5Wd/VRMyk/aKXeyI21Y376WGv7EI3XmkkT4Xy/Z+stPzaNIg2MsJmf5WOs0zgNT
	6EKyqSCI=
X-Gm-Gg: ATEYQzxrW9mtB3nweUwfCQDqLiP9qI7wCkvIqYKU0Q2A9CqAI7PtNvER3i+ytIxU35p
	llnslWw6RMhl4WFap/NSpkCOpNVxZeNtG+x9qA4c2dv+uH5ikDnQjAgqpxSfHjdncSsp5Ctty4T
	3f6epz1etM4ROxVkKs0yxE2yNsnD4d/pZpC4e/A7ox8t/WZlhGgIeuyV9uU0TNsjvZXPBmwWyWA
	3TLdrMpUPLsUnR7MY+fQNPMDJV6crEZKQgV6PgYkYbHWqHTORkONd27VdZKRUHaDiN4UDIu1jyj
	FMGPSLZIiJ3iF0nejcACBkn+5vTEFG82wo4C9EbYysSlDxjGe2Vp54B3KZqv62r1TQOWOkG+lP3
	hFXliD5RrO06W9x6sQ8IIBSBKxuAYFSWXQ+zmUu1cRoRX3FeurK/uMoSs4KePWGulu06TdXQdg2
	fv0RL/HXtQO+GLi09mR4s4HGBM0Zx8pWJLXLwmbh4pbNtfz7JL1hw=
X-Received: by 2002:a05:6000:2505:b0:439:be3b:ddb6 with SMTP id ffacd0b85a97d-43a04dc5084mr4728436f8f.59.1773389935446;
        Fri, 13 Mar 2026 01:18:55 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8f77:c880:e027:e164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b4dasm15522827f8f.18.2026.03.13.01.18.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 01:18:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Fix bring up after bitbake-setup changes
Date: Fri, 13 Mar 2026 08:18:53 +0000
Message-ID: <20260313081853.3779726-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 08:19:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3453

We have to leave MACHINE/DISTRO unset via fragments for oe-selftest, tweak the bringup
target setup to handle this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/config.json b/config.json
index 1a8284c..45262c6 100644
--- a/config.json
+++ b/config.json
@@ -192,36 +192,51 @@
        "bringup" : {
             "BUILDINFO" : true,
             "SSTATEDIR" : ["SSTATE_DIR = '${HELPERBUILDDIR}/sstate'"],
-            "MACHINE" : "qemuarm64",
-             "step1" : {
-                 "SDKMACHINE" : "x86_64",
-                 "BBTARGETS" : "core-image-sato core-image-sato-sdk core-image-minimal core-image-sato:do_populate_sdk core-image-minimal:do_populate_sdk_ext core-image-sato:do_populate_sdk_ext",
-                 "SANITYTARGETS" : "core-image-minimal:do_testimage core-image-sato:do_testimage core-image-sato-sdk:do_testimage core-image-sato:do_testsdk core-image-minimal:do_testsdkext core-image-sato:do_testsdkext"
-             },
+            "MACHINE" : "unset",
+            "DISTRO" : "unset",
+            "step1" : {
+                "SDKMACHINE" : "x86_64",
+                "extravars" : [
+                    "MACHINE = 'qemuarm64'",
+                    "DISTRO = 'poky'"
+                ],
+                "BBTARGETS" : "core-image-sato core-image-sato-sdk core-image-minimal core-image-sato:do_populate_sdk core-image-minimal:do_populate_sdk_ext core-image-sato:do_populate_sdk_ext",
+                "SANITYTARGETS" : "core-image-minimal:do_testimage core-image-sato:do_testimage core-image-sato-sdk:do_testimage core-image-sato:do_testsdk core-image-minimal:do_testsdkext core-image-sato:do_testsdkext"
+            },
             "step2" : {
                 "SDKMACHINE" : "x86_64",
-                "MACHINE" : "qemux86-64",
+                "extravars" : [
+                    "MACHINE = 'qemux86-64'",
+                    "DISTRO = 'poky'"
+                ],
                 "BBTARGETS" : "core-image-sato core-image-sato-sdk core-image-minimal core-image-ptest-all core-image-sato:do_populate_sdk core-image-minimal:do_populate_sdk_ext",
                 "SANITYTARGETS" : "core-image-sato:do_testsdk"
 
             },
             "step3" : {
                  "SDKMACHINE" : "i686",
+                 "extravars" : [
+                    "MACHINE = 'qemuarm64'",
+                    "DISTRO = 'poky'"
+                 ],
                  "BBTARGETS" : "core-image-sato:do_populate_sdk",
                  "SANITYTARGETS" : "core-image-sato:do_testsdk"
-             },
+            },
             "step4" : {
-                "MACHINE" : "qemux86-64",
                 "SDKMACHINE" : "i686",
+                 "extravars" : [
+                    "MACHINE = 'qemux86-64'",
+                    "DISTRO = 'poky'"
+                 ],
                 "BBTARGETS" : "core-image-sato:do_populate_sdk",
                 "SANITYTARGETS" : "core-image-sato:do_testsdk"
             },
             "step5" : {
                 "BUILDINFO" : false,
-                "MACHINE" : "qemux86-64",
                 "SDKMACHINE" : "x86_64",
                 "PACKAGE_CLASSES" : "package_rpm",
                 "extravars" : [
+                    "MACHINE = 'qemux86-64'",
                     "RPM_GPG_SIGN_CHUNK = '1'"
                 ],
                 "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],

