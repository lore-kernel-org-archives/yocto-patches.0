Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3738ACD37A7
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:01:04 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4506.1778205657434994842
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:00:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Ct2jFXuL;
 spf=pass (domain: konsulko.com, ip: 209.85.210.173, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82748257f5fso1626794b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205657; x=1778810457; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0gnjesXBkRgihvb4pMTCD07X8E5Q82+b+cm+vmuixY=;
        b=Ct2jFXuL9cgGZs5VFGLq71IOpPl6sIreCTIu5GZaBhpGwY03b4UJhsE6RoghUIm7c7
         keuNLnZuoumL8E2emZZXZcVTCgDJp9yDR32sh4bFSq9gAqaQ1gZUaEiFAjZKbfzqbd6b
         AYKqDvS+OJsleU+qyiUQei5Wa79QvRCxZn/oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205657; x=1778810457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s0gnjesXBkRgihvb4pMTCD07X8E5Q82+b+cm+vmuixY=;
        b=Nzp1qZCQzsaEB+GE1FsuGIxoEV+X0xgW2COkSma5BZo9+Wx5DbJfX9p+/vCj5jJqzs
         putfeLy7PlMcdRmJZmqcPZ85qihV/U+7NEOO8Uke2rmqH8FzPkunQfI2Qi+NI1yARxlg
         qRyDOOCPd9Xgnw1oyXYzUzgxZismK5SVWYyNp+CfvlgMhM+4EDp6rno8O19lYPZt22QQ
         TA+uCtjwXoWW/0uaQSbqG7Y7ooh2EDi+cmoKSnLb6jHaipe5+dGn9JDqizaCcCeA1IBw
         PkKV0Ii1r2AiIK8RQusuDgmSvRXNOu9ExbqgQfdhAsGmIAr1pQ5nSQPs8kALo0HZzUqg
         sQTw==
X-Gm-Message-State: AOJu0YwD0kajcfpPtNoqOHjkCoJYfpYunlpHCWo5QREOCROFK7nwzYwY
	0q+LZiESFIk46lYy4TF/B62jQ/e4wT1a3da2fOKhWwtxZg6UXiGslYunI4NXToIVPn8YgS6SFvo
	B2xQB
X-Gm-Gg: AeBDietrDX42xdR2rZjVDNb5I2Xbc5QGs2p56YofroVDNsgLuGjI6JCTW8ewm6gpURD
	0mhzoj81DkilkvHBlzu2FwNFJNzCO4dPDlWFyGsY+LhEH+JsUgQwTs7IpzOVrNKEcKrx6W1mpHt
	B6ohlXzdNYzxtJGcRiRHyMZG/XGDbY9CTVa34FxoHeL5A6M/2dGh0mTYuyLhGzC75A+D67sYE+r
	jZY2XKGDlXndQi/jtKnLpNHHknmcUAvhoNy2aEBYYadHyvqv96cEaQV9084op4/Yg0shYkZ49jq
	1r3Mekrprx6bpbHA14Yp0G9ldamCh0LsPfB5QWQaMl3DDkXWXhdQRL6xL7WgsYc1/23Czf9RraO
	MAAhSCxTWpo2EYrC5zwS2TWppmDyShuUpiGPGCvfR7Pf4s86WfcEDaO+B3iZlk3Db3t6ugqzXk5
	b+eEUvMyl2dQ5N10Xr+68oYgSibBPvnEjz3mBcZbVSOdIsBOyQu+t7U53eTHN3b5c=
X-Received: by 2002:a05:6a00:aa8d:b0:81f:5acb:55fc with SMTP id d2e1a72fcca58-83bb6bce110mr4333850b3a.10.1778205656543;
        Thu, 07 May 2026 19:00:56 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f049sm11904845b3a.7.2026.05.07.19.00.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:00:56 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 05/11] scripts: add vcontainer-tarball setup, integration, and publishing
Date: Thu,  7 May 2026 19:00:28 -0700
Message-ID: <a01030b3358f27759f63c499aae06ea02325883b.1778202125.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:01:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3944

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
index 8d42bbe..ab0ad7c 100644
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


