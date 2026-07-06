Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B0C43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:06:44 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.161473.1783375597337593838
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TrtGqzM4;
 spf=pass (domain: gmail.com, ip: 209.85.210.170, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-845ea8924a2so3469661b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783375597; x=1783980397; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHc2v7P6S3eXsGYj8ncD03YtPXXdbXRMlxd+lLp0sgM=;
        b=TrtGqzM4aQvaH/9aThDZpF1BdT18KKcUO95Erx4e5SLmIlIEfuliKYjRxhR0SurhQS
         3pMGmRpmrX6HW44Ei0Izu8gPwGZzbCFaOZNbwxcMuaoCmbK8sBZKX/Y0N6VReb/d2sRk
         XWU5cKHdB7sO/f+mL1CElh/fF8kX0RSAVoHqQCmYOJKuSoozl5qegOZhiZ4Ha4QS4cN9
         FD8ZDLGbozGYLgZLRSKeSBTAwS4t9EW7B7kTH6ateozZE+A4vVS54g9XfiomxKQDuGyR
         G1n/+ByNmVbnZ1nQtKfbvtrf+rFgw+2VQ47bP3wyfIPMFQ8fqdG3lKUX2S4od3W9p7L+
         V6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783375597; x=1783980397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RHc2v7P6S3eXsGYj8ncD03YtPXXdbXRMlxd+lLp0sgM=;
        b=XIb64EIbTFq4+LRX2x2LMLfGqNf5GSqGaeh1g0VXSjbhzfZQ06RQuSlmmiNkJDFXH/
         4k23qh613yc97s0zuBaiw65ga8aSnCrBRpMssN/R2rnkDyDJt5tPkDFrCv+DEZTlPy2f
         eojNC52q5CyMokN4HP6gMaa5pYOrzsp19O8wbW+PsAfdHQcIoXlNEmgaIG459E/gWuEI
         pONbpSqUJfQiLxZowwtFv+FY1kTqc5iHqn1gnI0nOx+euseyrC/n9dpQxI+pE2o+V0qw
         9EgVqGMWvQvjT1wTKsZRHF4NtVOB9ms5MEmn1Cw1USkEVC/boy7pGHXL0qAS8OGvxNPg
         boEQ==
X-Gm-Message-State: AOJu0Yx9wm34smOe+8kl9mQuXI39V1P1/RWv1/yvM41gkGTsNNM0bZzf
	ByyLB3vRybuxatj12eN7XSA9ImHAn8bk8OF1te073hDy0YrSi3/8AXhsZbpJjA==
X-Gm-Gg: AfdE7cnM0rhtBCXeHuXN0TkhDOFsx3vQR84Y7IuCm3dVoQTHYNmdWBr0hMUmx4H6rn8
	PBkBVCk+ipN6rL2GJJcSezfsNQUp3ocCGiZmZH567TiVrsK25tvjD3ULmcZjRx/dU+my3OIIOt8
	Pt22f+XLO5olInd8UGqnKAufkBX4kC0RfamI7/ZtAzU2+SOOeRQy5enWnHDiPqLbGR8TOlAE4H6
	tRHSLwumGICSbOEaL5D/cwtQ27W/1zRaG5KswbNZmvV5q+3Bnmrkfsgn8/z8gZ+iU4HtP1HcaBZ
	FpE+UoswZtEcH0NbQRvbloRFXiypoU6vzfSQhGPSjf7NtEKcpFqA3m5j9cP0Xb5Iz+bexIrcunf
	YvHk7UZzVkZjOVpjwMXQwIUuNULE3WFW5LMYgQ/Uy30ooDxhkkHcUhaS0LyYndJFuwM/vzQsI7j
	77fCItpsg7CiTyyx2/ClCbxY2BxifNwZMzJX5yL43pIJXUUKuN8CYWi7MZmOCLiA/HfuRPv86Nd
	FOMG9rYBA+BBWjzzffk1pE=
X-Received: by 2002:a05:6a00:2e24:b0:847:8625:f7bb with SMTP id d2e1a72fcca58-84826e2393cmr2304731b3a.60.1783375596587;
        Mon, 06 Jul 2026 15:06:36 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d5b95sm84720a12.3.2026.07.06.15.06.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 15:06:32 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v4 01/11] scripts: add vcontainer-tarball setup, integration, and publishing
Date: Mon,  6 Jul 2026 15:05:33 -0700
Message-ID: <496be2c920bf0bffb4c0881f0818ff858175ed2d.1783371914.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783371914.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com> <cover.1783371914.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:06:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4431

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
2.54.0


