Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9E6CD8C88
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 02:51:48 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9455.1780714299601827075
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 19:51:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dBdPftae;
 spf=pass (domain: konsulko.com, ip: 209.85.214.171, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so19131625ad.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 19:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780714299; x=1781319099; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Gz6PtQ7RBykcVKfuiCd5YiRZxhzZeHKwdIeWfTBGp0=;
        b=dBdPftaeSPyNH8c027jsP+JuHZmFckBZIAjqnuVBGmsIPBBvBf7tnpWKMhvMmUaXSe
         UQDR/OBrV0JYyXCErbhXeG/Sd9m9bn6IJP6eRvyaBCLTmxI5bknQ3WBno9bR1bck/Mn7
         4k44TQ6d7cpV5vcZa/k6XfvlGrvTau+XZHfkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780714299; x=1781319099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Gz6PtQ7RBykcVKfuiCd5YiRZxhzZeHKwdIeWfTBGp0=;
        b=NMDAlAu9lkmOGvR2NDEs2GTebabTd42XsoplD46VLlFM/9eIYmqOOFVX9ilTPWrS//
         uuqgwOdph/2RL+Si2WTczJv5paIOTjR41RrQ9/Vw0Hoa/C1pysUz6L2sHmlMzNWmATb/
         X+uTEJdzis33varM4zMjP8rIx3CPFzEDh2pxwdeNwArv4QWC6PqxbZDY0ok4be/EDFHu
         KevnmEcwkDuDyjWw+xkXeKp8O69sA2CJJpvMjmdgW8BjamkPRsj6YFk0M5DvlyUVQQjo
         gIYN4EJR/E764qfuGxaaKvD477juLaeRdGTH8OHQUSEQQXjiA3XVFEmyeci3647AvyWn
         8Jyw==
X-Gm-Message-State: AOJu0YxcYt0OZBuo/rtjJ4fxv2RJY6KpP05kmvCAU99JRUVC44JLsahS
	6IUwfKptYlabVWFOgZ/FsPVEn3ZP4SZKTzF7tWMM//CA3bvEB7ekhDQZy8lv7/0OZBVQiLkD1Le
	n08fd
X-Gm-Gg: Acq92OH3Aag6fqp/f8VT1ZhRxIoL9IaN/CxObTGZq9vPbSid3ATUqDpTRN7E726yard
	hNeh6qqtBbIyFU7zD/EYGpCK/NiZBA7ujMrrT2XimYDC9jD6XKYzjuy9BXHtq4GYj+66xned+5K
	uBaPag3FP178xSydEDohfnYDV6TC5hXvGj9t4CqFrzclppPwmVJGYYay8kwLzbIK9skOLd5TG2U
	ERg2xAms3PyK4V+G2Tr4J8lwEQNeOQv3kVoJqRDYjKtn9x3xpjhOjCrCFqoWkYMft/9Or1X/JD2
	JmQhCVkgz0rsEdFoIluaci2xTuGUnrjiZg/ZRzOsHSMM1sXzk0mlOvr9IJ3eN3Q13B8ujvBt94N
	sLnyVNZsoHNyi4EDxUKLtCluOqVeZCeMAzvzHr8T+btJptqbdyYlRGZBP/N8BK4eM3D4VXBJfnu
	V6luREmm/TphaD0FKNtrT61C149+cyIatQwFILkdkzKcbolq0izXOkgqjMmBAIiGxqp2sZIK8z0
	g==
X-Received: by 2002:a17:903:a03:b0:2bf:2b84:c207 with SMTP id d9443c01a7336-2c1e8331ff9mr41437145ad.35.1780714298874;
        Fri, 05 Jun 2026 19:51:38 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649d2dfsm106113825ad.75.2026.06.05.19.51.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 19:51:38 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH v3 1/6] scripts: add vcontainer-tarball setup, integration, and publishing
Date: Fri,  5 Jun 2026 19:51:15 -0700
Message-ID: <af9b99be6144873b935a47c49ef862ad63dd7c55.1780710041.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780710041.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 02:51:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4156

From: Tim Orling <tim.orling@konsulko.com>

Introduce the vcontainer-tarball SDK plumbing used by container build
jobs. The vcontainer-tarball is a meta-virtualization-derived SDK
(modelled after buildtools-tarball) that ships the container build
toolchain so worker jobs do not need to rebuild it for every step.

  * scripts/utils.py: add setup_vcontainer_tarball(), and add an
    env_glob keyword argument to setup_tools_tarball() and
    enable_tools_tarball() so the vcontainer-tarball can source its
    specific environment-setup-ci file rather than the universal
    glob.
  * scripts/run-config: source the vcontainer-tarball environment
    for build-targets when "vcontainer" parameter is passed in,
    similar to "extratools" behavior.
  * scripts/publish-artefacts: publish the vcontainer-tarball
    artefact so downstream test jobs can fetch a stable SDK.

AI-Generated: Claude Cowork Opus 4.8
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/publish-artefacts |  5 +++++
 scripts/run-config        | 11 +++++++++++
 scripts/utils.py          | 20 ++++++++++++++++----
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/scripts/publish-artefacts b/scripts/publish-artefacts
index e56e131..0e820e9 100755
--- a/scripts/publish-artefacts
+++ b/scripts/publish-artefacts
@@ -146,5 +146,10 @@ case "$target" in
         sha256sums $TMPDIR/deploy/images/qemux86-64
         cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemux86-64/*qemux86* $DEST/patchtest
         ;;
+    "vcontainer-tarball")
+        mkdir -p $DEST/vcontainer-tarball
+        sha256sums $TMPDIR/deploy/sdk
+        cp -R --no-dereference --preserve=links $TMPDIR/deploy/sdk/*vcontainer* $DEST/vcontainer-tarball
+        ;;
 esac
 
diff --git a/scripts/run-config b/scripts/run-config
index e896234..90a5996 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -153,6 +153,17 @@ else:
     if args.phase == "init" and args.stepname == "buildtools":
         sys.exit(0)
 
+vcontainer = utils.getconfigvar("vcontainer", ourconfig, args.target)
+if jcfg:
+    if vcontainer:
+        addentry("vcontainer", "Setup vcontainer tarball", "init")
+elif vcontainer:
+    # vcontainer is opt-in per target via the "vcontainer" config variable,
+    # so this is a no-op for targets which don't set it
+    utils.setup_vcontainer_tarball(ourconfig, args.target, args.builddir + "/../vcontainer-tarball")
+    if args.phase == "init" and args.stepname == "vcontainer":
+        sys.exit(0)
+
 extratools = utils.getconfigvar("extratools", ourconfig, args.target)
 if jcfg:
     if extratools:
diff --git a/scripts/utils.py b/scripts/utils.py
index a4dd12e..bddc715 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -456,8 +456,8 @@ def sha256_file(filename):
             pass
     return method.hexdigest()
 
-def enable_tools_tarball(btdir, name):
-    btenv = glob.glob(btdir + "/environment-setup*")
+def enable_tools_tarball(btdir, name, env_glob="/environment-setup*"):
+    btenv = glob.glob(btdir + env_glob)
     print("Using %s %s" % (name, btenv))
     # We either parse or wrap all our execution calls, rock and a hard place :(
     with open(btenv[0], "r") as f:
@@ -474,6 +474,18 @@ def enable_tools_tarball(btdir, name):
                 if line in os.environ:
                     del os.environ[line]
 
+# Unlike buildtools (a host/worker property, keyed by worker name globs),
+# the vcontainer-tarball is only needed by specific jobs (e.g.
+# containers-library), so it is keyed off the target/builder via a
+# per-target "vcontainer" config variable, following the extratools pattern.
+def setup_vcontainer_tarball(ourconfig, target, vcdir, checkonly=False):
+    vctarball = getconfigvar("vcontainer", ourconfig, target) or None
+
+    if checkonly:
+        return vctarball
+
+    setup_tools_tarball(ourconfig, vcdir, vctarball, name="vcontainer-tarball", env_glob="/environment-setup-ci")
+
 def setup_buildtools_tarball(ourconfig, workername, btdir, checkonly=False):
     bttarball = None
     if "buildtools" in ourconfig and workername:
@@ -488,7 +500,7 @@ def setup_buildtools_tarball(ourconfig, workername, btdir, checkonly=False):
 
     setup_tools_tarball(ourconfig, btdir, bttarball)
 
-def setup_tools_tarball(ourconfig, btdir, bttarball, name="buildtools"):
+def setup_tools_tarball(ourconfig, btdir, bttarball, name="buildtools", env_glob="/environment-setup*"):
 
     btenv = None
     if bttarball:
@@ -557,7 +569,7 @@ def setup_tools_tarball(ourconfig, btdir, bttarball, name="buildtools"):
         if not os.path.exists(btdir):
             print("Extracting %s %s" % (name, bttarball))
             subprocess.check_call(["bash", btdlpath, "-d", btdir, "-y"])
-        enable_tools_tarball(btdir, name)
+        enable_tools_tarball(btdir, name, env_glob)
 
 def get_string_from_version(version, milestone=None, rc=None):
     """ Point releases finishing by 0 (e.g 4.0.0, 4.1.0) do no exists,
-- 
2.43.0


