Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B024CD6E61
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:18:39 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12714.1780355912813146290
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:18:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=VBK5U8UA;
 spf=pass (domain: konsulko.com, ip: 209.85.215.170, mailfrom: tim.orling@konsulko.com)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c8584bbbf2cso1704539a12.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355912; x=1780960712; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfEDyXtR2H5UTOnUnmi38QGbL6XG1SWvmAgTnwagwjc=;
        b=VBK5U8UACbvWKecA9YTE0hS4ELSNdSF44BK0UYRnCT5utE56OslrJCZHqo4MGMBhr0
         6rWqyJHksSNI7SMIkzTW4E5C7lwra39rkGafNaYbbHmy1ltVUHAd3CapgFxkhxQLd8tc
         kOlSrh/rRG0Mc9OteRQKgzo1efZGzKsi3eh3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355912; x=1780960712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LfEDyXtR2H5UTOnUnmi38QGbL6XG1SWvmAgTnwagwjc=;
        b=cgYYWuFMbA9Q3b4r64cmltuVHS5e2MOfgjeKlhVIrgtYcrSggwPe/awHYKUQ3wmM7G
         yI5r6fb9Qohqr6W1oe4/c15bFrtzH2FD92gL2Dbv22nNOHcE8H41vDC2j2shEV7dUxZp
         vE2EstqIeN6mPb/JO9b5XqJ8M1kuLjm4wx6C9/hubsM+LmsHZaf4pGDrMYfiuad3nCVp
         RMsHqF/wVDtRwr7arw3CE0UCPntS4fk+u/d6+19el8Z5z50PPVCWZQGq8dD6jT9H3nCS
         SBgwH6H2pyCDV1veX8ZJ77DqB7h94BhKbN0cj3Qf8Q5cBsa97g9awuoMBINKeubKnHE3
         wfgw==
X-Gm-Message-State: AOJu0YzMrMhZfcLmWBCN2p2xrbNLA1meMIvqhcIKHL4dk8DBip77Xz7e
	0Myk9p3vH9v+uxjE51G4aVXn135xrUIxFIi1gcoOhPUbRkIiALoNsxyDpXN75UsI6hrO8DLGUcD
	EPk9M
X-Gm-Gg: Acq92OHmaNA42UGobwgjLmm1dLlJW2oCOtJ2XrMpdOzDgRZ16s373stj3r8FEaqCMNM
	vwPKXw/M6XlZL6kBEwWkJz56n5yfpvX++tBk+LmhqW4eFscTn6od4Nsjw+fEouT5z+Y8fg4D1wR
	oweQrMhaMA8inO9GesixcFLhixRKqv2nNXbP0zxEXWX2iTll8i8fp1KAcy/enTCCfouLWxOZyeN
	WeFcB1FIa6XsmJOE14G7JHj84Qho0VWpI6b/azkUt7ds2Y27Flopj2Jtbcc/6lGPmmPsUg0eTVI
	eEaRviTRN9orrzvBWC0XQSJDltBWIPkKgK54sNgq7rySncqcZmN3f/qPg9472y1RJ2ImGzgM3/Y
	ClCdyC0KHM1OXypnnX7LoJe5OUo9shSkr/oqreNGhnPFKsf59EcikLefJSuK75H4TfgvYYHccKq
	fqh1m5XbmU7iOiTkLQc2BDzUTZ7gHH4q4C+3YJDsD/vVtNYTQdBPNJ5sUoD7es2cGm5caEsJGQm
	Q==
X-Received: by 2002:a05:6a21:512:b0:3b2:86a4:b01c with SMTP id adf61e73a8af0-3b427f2b31fmr13983966637.26.1780355912092;
        Mon, 01 Jun 2026 16:18:32 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85771a7c24sm12021678a12.2.2026.06.01.16.18.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:18:31 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v2 05/10] scripts: add vcontainer-tarball setup, integration, and publishing
Date: Mon,  1 Jun 2026 16:18:04 -0700
Message-ID: <2cf468a3da7c7db15ee42c14404a71aaacab0f28.1780354513.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:18:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4102

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
    for build-targets / cmds / test-targets / plain-cmds steps,
    gated by a new NOVCONTAINER step variable so individual steps
    (such as the dashboard indexing step) can opt out independently
    of NOBUILDTOOLS.
  * scripts/shared-repo-unpack: invoke setup_vcontainer_tarball so
    workers extract the SDK during unpack.
  * scripts/publish-artefacts: publish the vcontainer-tarball
    artefact so downstream test jobs can fetch a stable SDK.

AI-Generated: Claude Cowork Opus 4.7
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json                |  1 +
 scripts/publish-artefacts  |  5 +++++
 scripts/run-config         | 19 +++++++++++++++++++
 scripts/shared-repo-unpack |  1 +
 scripts/utils.py           | 22 ++++++++++++++++++----
 5 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/config.json b/config.json
index 7df4271..16d8a04 100644
--- a/config.json
+++ b/config.json
@@ -1433,6 +1433,7 @@
             "step3" : {
                 "shortname" : "Populate/update dashboard site",
                 "NOBUILDTOOLS" : true,
+                "NOVCONTAINER" : true,
                 "EXTRACMDS" : ["${SCRIPTSDIR}/run-dashboard-index ${HELPERBUILDDIR}/../"]
             }
         },
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
index e896234..0f5a26a 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -153,6 +153,25 @@ else:
     if args.phase == "init" and args.stepname == "buildtools":
         sys.exit(0)
 
+if jcfg:
+    vcontainer = utils.setup_vcontainer_tarball(ourconfig, args.workername, None, checkonly=True)
+    if vcontainer:
+        addentry("vcontainer", "Setup vcontainer tarball", "init")
+else:
+    # If we're executing a specific step, check whether vcontainer is disabled for it
+    vcontainer = True
+    if args.stepname in ("build-targets", "cmds", "test-targets", "plain-cmds"):
+        try:
+            vcontainer = not utils.getconfigvar("NOVCONTAINER", ourconfig, args.target, int(args.phase))
+        except ValueError:
+            # Not an integer step phase
+            pass
+
+    if vcontainer:
+        utils.setup_vcontainer_tarball(ourconfig, args.workername, args.builddir + "/../vcontainer-tarball")
+    if args.phase == "init" and args.stepname == "vcontainer":
+        sys.exit(0)
+
 extratools = utils.getconfigvar("extratools", ourconfig, args.target)
 if jcfg:
     if extratools:
diff --git a/scripts/shared-repo-unpack b/scripts/shared-repo-unpack
index 797dec6..869b214 100755
--- a/scripts/shared-repo-unpack
+++ b/scripts/shared-repo-unpack
@@ -77,6 +77,7 @@ for repo in sorted(repos.keys()):
     utils.flush()
 
 utils.setup_buildtools_tarball(ourconfig, args.workername, args.abworkdir + "/buildtools")
+utils.setup_vcontainer_tarball(ourconfig, args.workername, args.abworkdir + "/vcontainer-tarball")
 
 if "bitbake" not in repos:
     sys.exit(0)
diff --git a/scripts/utils.py b/scripts/utils.py
index 112ebc2..b020a7b 100644
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
@@ -474,6 +474,20 @@ def enable_tools_tarball(btdir, name):
                 if line in os.environ:
                     del os.environ[line]
 
+def setup_vcontainer_tarball(ourconfig, workername, vcdir, checkonly=False):
+    vctarball = None
+    if "vcontainer" in ourconfig and workername:
+        vccfg = getconfig("vcontainer", ourconfig)
+        for entry in vccfg:
+            if fnmatch.fnmatch(workername, entry):
+                vctarball = vccfg[entry]
+                break
+
+    if checkonly:
+        return vctarball
+
+    setup_tools_tarball(ourconfig, vcdir, vctarball, name="vcontainer-tarball", env_glob="/environment-setup-ci")
+
 def setup_buildtools_tarball(ourconfig, workername, btdir, checkonly=False):
     bttarball = None
     if "buildtools" in ourconfig and workername:
@@ -488,7 +502,7 @@ def setup_buildtools_tarball(ourconfig, workername, btdir, checkonly=False):
 
     setup_tools_tarball(ourconfig, btdir, bttarball)
 
-def setup_tools_tarball(ourconfig, btdir, bttarball, name="buildtools"):
+def setup_tools_tarball(ourconfig, btdir, bttarball, name="buildtools", env_glob="/environment-setup*"):
 
     btenv = None
     if bttarball:
@@ -548,7 +562,7 @@ def setup_tools_tarball(ourconfig, btdir, bttarball, name="buildtools"):
         if not os.path.exists(btdir):
             print("Extracting %s %s" % (name, bttarball))
             subprocess.check_call(["bash", btdlpath, "-d", btdir, "-y"])
-        enable_tools_tarball(btdir, name)
+        enable_tools_tarball(btdir, name, env_glob)
 
 def get_string_from_version(version, milestone=None, rc=None):
     """ Point releases finishing by 0 (e.g 4.0.0, 4.1.0) do no exists,
-- 
2.43.0


