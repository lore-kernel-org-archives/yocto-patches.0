Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326E1C531D0
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 01:41:17 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2414.1785202876887186949
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 18:41:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=D+WFHMnJ;
 spf=pass (domain: gmail.com, ip: 209.85.210.171, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84874b52eabso4482927b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 18:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202876; x=1785807676; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qa4bGU/EjmW63DrYG02BiMdBc07C3ZfwGhsG8XH0vaY=;
        b=D+WFHMnJZcPLlIajz2oAfZJ5FfpAFPs6aoRue2WyNL0Vx9RyJFtYqisSG6o1G1w+/8
         c6AE3D5Q/q0FvpjS+BAVSXou095+j8zZV8WKvBzbkV7dGT/OEr1cs4Af3j+dfI9pEQnS
         rfwCoUMWwSVyDhSfvCVXpefAkFpsFrziawvuFUlcZzYCFCDy+cP45rX7qezQEGyN6Xg/
         lbBayUO0huFDj1qKbnWqa3CJf/M+PsAI1pDrDLGnxerLgxDVbJ3YcyeyES0hVTjNxU2n
         I6hknlxQtDct8uS+kxtA1a1/2Lf8SwYhOr7QnviOBleSblz7ESq6B/P5kbruDWr5Ejky
         ofIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202876; x=1785807676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qa4bGU/EjmW63DrYG02BiMdBc07C3ZfwGhsG8XH0vaY=;
        b=GGvyVGUt9KG+pUhyG0z4YZho2DMlhN5S9A6K+1MD4tOLO8cDSkYxciKW9icIm9tInO
         MXyTy1VVJPXI9EefVJbEWe6XKKMdZARiw8NvmJCvp5aMlBgBGsHgSqjdb5TnPgJgPXY4
         +gw8VC67yjEWwMCE/u6mtOxXg1ej0LbmLOBrhzavL1QMBoy9L/pGZeoHYfG3I8Etkuvr
         7Q1Q/j8myemFazI2tvfnU9EpP+42jPuL6EV9FK0J1hZ2omNlgfzR37tvsgQxyi8kmQs+
         hZWVRCRktVr+hROmHQYIp79bNUBqdCjKfHWw6eCLYb1XOoSt4MagdV3rsPU2NI9+CJOz
         4wdw==
X-Gm-Message-State: AOJu0YyRyFS8tXdzTsH/xUGOgT+AH+H8gbuQOkDnGra8Z2rrGze/YQJo
	5FRJcGJM8oK0a6ObpYF9K15DWk0tq7i8PiGlDLhPs58w9pKFay93x5sUXrLxYw==
X-Gm-Gg: AR+sD10gAVjx+plO+vMg6Qwg+FsacY0e6bHhGxilPBJqppsCjgODZE3KUFHvAYz5cgK
	AmIsnVAAovVQTYQVKr8O/BXnRzrprEFWrLSq3WsGsuYD/iml7gePdNWkpxSCK78pYrRu9NKN50q
	AtQy4mqQnZ/GfJ8rVFguBjmrCnZwRE7cCAZFi9KkI//lkqu3BpidCWI2FZ2DS8V5uk5ai+p8rGg
	ix413odoWzR6FcnPh48IIFkDv8YiQ2xJW/qIhn1y0KvDfT+3XG+WpQw3kreONNtS0QnjQo9CJKN
	hGU3VE4bKjuI5DWNCSD92vhB7FYaopXmAh03vOpAKtJ71IopByUrd74pVwoWzOKjhiEtSQIe9td
	57GdW3Ss3SlQl73NsYS8A1uSNhuvwwR4Po1EOSiD+Ou70y543c3nCAbcci3aXrPQjH9DWJ2yVoF
	XA+PcO24T3kiTgP+J2LB8EYdFoMjuSyK5UV7AXJ7a9oMLiKiM5yupkf/rdZsnrXzKgmKt+P4Q+a
	Hj5kQCGCKH0
X-Received: by 2002:a05:6a00:3e20:b0:847:893f:2d0c with SMTP id d2e1a72fcca58-84e931b4d0dmr296360b3a.5.1785202876252;
        Mon, 27 Jul 2026 18:41:16 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm3661537b3a.58.2026.07.27.18.41.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 18:41:15 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v5 01/12] scripts: add vcontainer-tarball setup, integration, and publishing
Date: Mon, 27 Jul 2026 18:40:34 -0700
Message-ID: <0de865ea7a35bb75d9c1cf35847bea1b0b5ff514.1785198322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785198322.git.tim.orling@konsulko.com>
References: <cover.1783371914.git.tim.orling@konsulko.com> <cover.1785198322.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 01:41:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4540

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
2.55.0


