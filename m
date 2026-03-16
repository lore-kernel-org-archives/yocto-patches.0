Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B84F53D99
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 20:34:13 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.60886.1773693241395381943
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 13:34:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eXFkOuj5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso44110455e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773693239; x=1774298039; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5TCsp4OCUfLHL9EZkYZ2GJotbaK3wjy1WusFD/7kl3Y=;
        b=eXFkOuj5HK9nuoYwzmnE4DSgEHxZDje0mrT6LkW6sj5ORY4/MaAyYZTufBHr39v/Jg
         AK3NRGJ64whk1dyrJUrbqTT2kD4h0dHYrQW2kPKGjSonlL1n9d5N+TiJcZgCbrEaYSlO
         apFEIBmNcFoHWgVk3U7B9pWxijXfaAIia6Fco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773693239; x=1774298039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TCsp4OCUfLHL9EZkYZ2GJotbaK3wjy1WusFD/7kl3Y=;
        b=DAyugcm8hW4d0BG8OAbsolJH6qwMvzctleNNDiCg9+SwkXmmWHNXAYkRgpEq5/T7NM
         r5aQl6ytEzHjlewZj3ZrGm8nu06P2ClZ4CMT5p3u2SSx9R9KpspzhFE0hZKAynI+aLb2
         hSGQZjvoMO5TbSyp7CS3LudtS88YLWT23WHyd/UQ9ZP/6I1tKX1e0kZ4+/cbSnb9PXvz
         vYBGF3ZcI60kxMx7SP8yAPDmmeu/kSbRVGyhNvL9LO6p9aQ0oQ0xjfv7iEjjluTMMHVQ
         m3ZUS/TRl6A+cc9XvFzJQzaIHz509Tu/uof+guhv3lC7Zd089RorgI9OJAYhtsWWhuhG
         Zb8w==
X-Gm-Message-State: AOJu0YwDEgne/KmpIJb3xDDuhGwi6vzcl5RRMD+cgHiEobUgunQbN39E
	7h/BSs0CC7rdU2wX5u+J8m5rYTBdm5lfM03QgJiUIj5bXQeCvsT0Eq7MxdF/L+q2+02OJW7lDJI
	iqPfwSVU=
X-Gm-Gg: ATEYQzykSz7VN70cBe5pEEVWDN49ssMbW7HSo9hLmOetrHFpOFmbyi0nJBcwU0uoqUQ
	6HwK5UOTVqSy29wktFYqteytMFDwajhBVN3cw0tKP7bJsroYTL75/5JTE/gF8wthunNolEWenCu
	k6+V7NFwrizI0iCdxMgpHs1DmRSIMWR5HY2CNIgd+8Odd4f9yP9nyFFtfpm52A29TC4mSQHMdjO
	GoEvH75gwWkYgwufG2HvJmv0w+QHFr8wO/OknZxe1zOfOAVOfsi7cZShjKHNAZmK/l8CFre5xnf
	2B9RCMIsFD8OWtcdAT8qhThdEWX9s6zKKc6pTQQc5e8JF709x0OHMS12v2m1+BWSjMZdGxRRXOL
	zxWI63qGtt60MY02+w3aKzhaiNPrZtQBXTN19m2Fhkd45IUyuAPua/n0AU5a0gb+Xkw7pbbM1du
	JzjeNNOBcTsSgYx6BclIA3I0LxuSmbVF3TWd+bnlJDce1iAlRxgIM=
X-Received: by 2002:a05:600c:a39a:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-48556728b5emr183310055e9.31.1773693239243;
        Mon, 16 Mar 2026 13:33:59 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:15f8:fc87:2277:10bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6ce2fsm98871395e9.25.2026.03.16.13.33.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 13:33:57 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][kirkstone][PATCH] config.json: Drop checkvnc usage
Date: Mon, 16 Mar 2026 20:33:54 +0000
Message-ID: <20260316203354.818704-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 20:34:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3478

The autobuilder workers take care of setting up DISPLAY themselves, we don't need
the checkvnc script any more and haven't for a while.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/config.json b/config.json
index 4949bb2..706e838 100644
--- a/config.json
+++ b/config.json
@@ -91,7 +91,7 @@
             "step3" : {
                 "shortname" : "Machine oe-selftest",
                 "BUILDHISTORY" : false,
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest ${HELPERSTMACHTARGS} -j 15"],
+                "EXTRACMDS" : ["DISPLAY=:1 oe-selftest ${HELPERSTMACHTARGS} -j 15"],
                 "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"]
             }
         },
@@ -152,7 +152,7 @@
             "step2" : {
                 "shortname" : "Machine oe-selftest",
                 "BUILDHISTORY" : false,
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -a -t machine -j 15"]
+                "EXTRACMDS" : ["DISPLAY=:1 oe-selftest -a -t machine -j 15"]
             }
         },
         "altcfg-hw" : {
@@ -195,7 +195,7 @@
             },
             "step2" : {
                 "shortname" : "OE Selftest",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest --skip-tests distrodata.Distrodata.test_checkpkg buildoptions.SourceMirroring.test_yocto_source_mirror devtool.DevtoolAddTests.test_devtool_add_npm recipetool.RecipetoolTests.test_recipetool_create_npm reproducible -T machine -T toolchain-user -T toolchain-system -j 15"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest --skip-tests distrodata.Distrodata.test_checkpkg buildoptions.SourceMirroring.test_yocto_source_mirror devtool.DevtoolAddTests.test_devtool_add_npm recipetool.RecipetoolTests.test_recipetool_create_npm reproducible -T machine -T toolchain-user -T toolchain-system -j 15"],
                 "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"]
             },
             "step3" : {
@@ -208,7 +208,7 @@
             "SDKMACHINE" : "x86_64",
             "step1" : {
                 "shortname" : "Reproducible Selftest",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest -r reproducible"],
+                "EXTRACMDS" : ["OEQA_DEBUGGING_SAVED_OUTPUT=${BASE_SHAREDDIR}/pub/repro-fail/ DISPLAY=:1 oe-selftest -r reproducible"],
                 "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"]
 
             }
@@ -235,7 +235,7 @@
             "MACHINE" : "qemux86",
             "step1" : {
                 "shortname" : "Source Mirror Selftest",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"],
+                "EXTRACMDS" : ["DISPLAY=:1 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"],
                 "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"]
             }
         }
@@ -418,7 +418,7 @@
                 "extravars" : [
                     "RPM_GPG_SIGN_CHUNK = '1'"
                 ],
-                "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest --skip-tests distrodata.Distrodata.test_checkpkg buildoptions.SourceMirroring.test_yocto_source_mirror devtool.DevtoolAddTests.test_devtool_add_npm recipetool.RecipetoolTests.test_recipetool_create_npm -T machine -T toolchain-user -T toolchain-system -j 15"],
+                "EXTRACMDS" : ["DISPLAY=:1 oe-selftest --skip-tests distrodata.Distrodata.test_checkpkg buildoptions.SourceMirroring.test_yocto_source_mirror devtool.DevtoolAddTests.test_devtool_add_npm recipetool.RecipetoolTests.test_recipetool_create_npm -T machine -T toolchain-user -T toolchain-system -j 15"],
                 "ADDLAYER" : ["${BUILDDIR}/../meta-selftest"]
             }
         },
@@ -1202,7 +1202,7 @@
             },
             "step2" : {
                     "shortname" : "Source Mirror Selftest",
-                    "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"]
+                    "EXTRACMDS" : ["DISPLAY=:1 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"]
             }
         },
         "meta-webosose" : {

