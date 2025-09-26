Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739AECAC5AE
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 15:53:23 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.20963.1758901994515367688
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 26 Sep 2025 08:53:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=N366SODm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso14048015e9.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758901992; x=1759506792; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=52DHrdkOp3VU1NnH7SiUxwTMqZVaRKq5QZOFrTqxxDo=;
        b=N366SODm9FN7qEaOED+Rv36N+ogzFOBIPsbbdJunCLM/UyQna+qOXaXecib+WiAq2d
         Xy03ojCLZJfMI7oo7FylNCZoV2KNoGkSiyb2zXqGW6LK/ALDLh0E2bvp/WbiUsIo0I96
         M9cTA+Zk/IhMZC5+DflA6Eew4SSyqw/7w3c5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901992; x=1759506792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52DHrdkOp3VU1NnH7SiUxwTMqZVaRKq5QZOFrTqxxDo=;
        b=pk9NHWhVFs8F/gxxEcsqDbhp4uerAI9kb4p67cUKVxsebuVwPFNVlBgvVPGWG8Z7BX
         u78hjH5/sZxfvej6h6baun5aEIYQIxf71ZdXiBXwvpt3Vezb+4Jp7Wxdkq+//qAxkYxs
         yQBMwN0FMjteIcvT9VAgXYxgORxyunxPV9A23XWmhEfBN4GCoJ/Wp/tPXS59riaf+df0
         IAeWLy7+Zj49qbc6aUkIs+q9DKQjThFvPRmgYecyiAvNIgD3jSd5y6NAYdIlfcvso51G
         xh/r/JYa7aAg559VDRgt8fM/PkPbmkfz/Ft0H9HVMlMMIyzaJvzsvWIQvREMtrQx8EiL
         SLnA==
X-Gm-Message-State: AOJu0YyXjFmwTHE2/5Q1+OtF1yBR2DucoTKuSsXuKijG4chAGRafjSxD
	2jwbU3tnu1mwa22NAqUVFc9pFNcC81pUoCsHFJa5zJP/JnmMZh0VMflsWT/yLFpdeZHkGbqvGhK
	GTUnw
X-Gm-Gg: ASbGncv7Pl1xnVntmL5WPrWRDIbT9vyDVxPunjiE7X0dbrkoGePmf4BoNAfGmixCuB+
	+gZuVkjv5PgcLkLYV99i+EwnMWpRKl4OdaVF7DlINXOe9R5/jes6aySINNIrVKtgzMp4QBWwL4A
	FXv2l2Utf01XIWZ3PiuZl3GAhLjYpRiHeaaIs3+f6Vu97AaNf5L1I3/M6zMciDLytByZ7QaWaKR
	pSAMqaTAKGvC107R2w/4cxBLTaCL64vrcLVfj+TlJLo+jkSA9YC8qnYA+GdXC8eRDSnjs9gXQbK
	YG6EYdAE7lQU462jxlrNCuTfHI9oHuMd49ClQjSJDTgeMYEO7xX4wN3WkRNxnEyovsK532yug98
	9K8E8M1vDAHdAe4Fc1ay3xmSypV94htNOV0nbYCUocLE7i72vO+c=
X-Google-Smtp-Source: AGHT+IERr6kAWUi96tUrtsTbaCfEu9tyLHxloM+IWlTg8aqBG9ch+xNknuIjszCr1KOvi2YwdoHk7Q==
X-Received: by 2002:a05:600c:1e23:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-46e3a4e1b6amr38220955e9.5.1758901992165;
        Fri, 26 Sep 2025 08:53:12 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8a7a:1fb6:e6df:2fa7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9c32734sm7707826f8f.25.2025.09.26.08.53.10
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:53:11 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] builders: Improve the property fetching functionality
Date: Fri, 26 Sep 2025 16:53:10 +0100
Message-ID: <20250926155310.26630-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 15:53:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2236

Rather than running specific commands on the builds, call a function in helper
and read back the json properties in a generic way. This allows us to adapt the
commands for the new layout from bitbake-setup.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 builders.py | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/builders.py b/builders.py
index d26b7e9d..7887945a 100644
--- a/builders.py
+++ b/builders.py
@@ -96,6 +96,11 @@ def canStartBuild(builder, wfb, request):
         wfb.worker.exitQuarantine()
     return True
 
+def extract_json_props(rc, stdout, stderr):
+    if rc != 0 or stderr:
+        return {}
+    return json.loads(stdout)
+
 def create_builder_factory():
     f = util.BuildFactory()
 
@@ -127,18 +132,11 @@ def create_builder_factory():
         haltOnFailure=True,
         name="Unpack shared repositories"))
 
-    f.addStep(steps.SetPropertyFromCommand(command=util.Interpolate("cd %(prop:builddir)s/build; git rev-parse HEAD"),
-                                           property="yp_build_revision",
-                                           doStepIf=util.Property("yp_build_revision", default='') == '',
-                                           haltOnFailure=True,
-                                           name='Set build revision'))
-
-    f.addStep(steps.SetPropertyFromCommand(command=util.Interpolate("cd %(prop:builddir)s/build; git rev-parse --abbrev-ref HEAD"),
-                                           property="yp_build_branch",
-                                           doStepIf=util.Property("yp_build_branch", default='') == '',
-                                           haltOnFailure=True,
-                                           name='Set build branch'))
-
+    f.addStep(steps.SetPropertyFromCommand(
+        command=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/getproperties.py %(prop:builddir)s/build"),
+        extract_fn=extract_json_props,
+        name='Load build revisions',
+        haltOnFailure=True))
 
     f.addStep(RunConfigCheckSteps(posttrigger=False))
 
@@ -330,17 +328,11 @@ def create_parent_builder_factory(buildername, waitname):
         haltOnFailure=True,
         name="Unpack shared repositories"))
 
-    factory.addStep(steps.SetPropertyFromCommand(command=util.Interpolate("cd %(prop:builddir)s/build; git rev-parse HEAD"),
-                                                 property="yp_build_revision",
-                                                 doStepIf=util.Property("yp_build_revision", default='') == '',
-                                                 haltOnFailure=True,
-                                                 name='Set build revision'))
-
-    factory.addStep(steps.SetPropertyFromCommand(command=util.Interpolate("cd %(prop:builddir)s/build; git rev-parse --abbrev-ref HEAD"),
-                                                 property="yp_build_branch",
-                                                 doStepIf=util.Property("yp_build_branch", default='') == '',
-                                                 haltOnFailure=True,
-                                                 name='Set build branch'))
+    factory.addStep(steps.SetPropertyFromCommand(
+        command=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/getproperties.py %(prop:builddir)s/build"),
+        extract_fn=extract_json_props,
+        name='Load build revisions',
+        haltOnFailure=True))
 
     # run-config
     factory.addStep(RunConfigCheckSteps(posttrigger=False))

