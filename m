Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7906BCD8C8C
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 02:51:48 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9587.1780714305859555575
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 19:51:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UD0euxVw;
 spf=pass (domain: konsulko.com, ip: 209.85.210.179, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423610ec93so1999082b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 19:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780714305; x=1781319105; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WveKnbto7xdliqmKUZvkOHdcTJqF/PT0PBVVTGkyrA0=;
        b=UD0euxVwFNeb+btTmtHf226yCn9w6DU8fxtHuzFhTQqS/6Q4jrqQ9iYL9dTAbkcnzB
         1ykWmMM/H+gk5wPoPeew85Nc5Iq8RawQvzKM+WmRxm/pjbp/X4MO2C5nBLjW07+sDBGX
         E8ELrZevWlDHCZqrWUfuBW7I2xgTKZRZEOnMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780714305; x=1781319105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WveKnbto7xdliqmKUZvkOHdcTJqF/PT0PBVVTGkyrA0=;
        b=WcW9L4Cw04Fc9LaGohBSUpqorII1BIzuHCCFGo3oxhjczOmGFjxvEdbG+mgWBDQfc9
         eJQwD8ufLZj4H/O635b1JILbAe4QT1KegPDRcKtFpFXZDNCOmgX/OoOrVQ9bBuLdz1zF
         m9CWBC7e12+2IfZbuzeiTAj5RcKl4Y5DKxDvRk19tCjl41U29GB0+7Pw998SKJ9yEu8t
         xy5zhKbQawaOmYYWetJ074lp1HLZaPZVMluwHtMVyTgIK+SYf+PKm+xfFufSnCjSrCiu
         HasorV3A2M4HBGKSoWBKqdVaHOTHLD77yo2YMBYN/H2dK3K2qQMhIzoWeM0EMN/U9TW2
         Kdpw==
X-Gm-Message-State: AOJu0YxrAcAgaN1aaIAQG+dFakLB5fW/1vodBc2jsDcnFUCoYuqHmMDR
	IW2EWQUG8JlA1Birul62TAMy4t2/z/JVnuqlgGH+m81CeapBKYxc5ihg43DTMnsjQHC2A0cnOi6
	l4mBj
X-Gm-Gg: Acq92OEw14EIAo5rN7c2AaxRWDqVM1ARA6vgysfCXoz4fqea9p6STBit0PmD6CAEuwV
	U5g5fypnhYFwiAkZLOwlIXOSCMe6R7cQbVPCPEFIIZraA0SVvKagoGDda3sBHOeBi5HIyCHbYVf
	VmCqx8jRQ6Fqi1H5gKM4gQePNvMevpee6ird0m9dirEZRfsbNmCGbXeDsiPruIOeX0EZ+sckFqd
	cwhp45ImMckIAw5NHn+q/YdYi7fPEQHIx6CCXYQu2iN1xeYYc1HjFH+LbwysJ6TF+awuhbDq/yF
	j9YE4Kn0fTOk5NihjPB/oH29TPz2TokvTdsJlgsR4svRf4NCpPUwZlSzFarHWE7UgshrI2l0CVt
	58zJAc2J6+f/vP1aB24yyWdeicc3sonWc5cCQe+zXP6Gp59KjmzwmIK7sexVQOfWxg6aSY4f++P
	H8WEgAFVpXt65R1g29qza3+EZSxcl13ZGnDl3BS+j5M9HTVP/3Te/RO78CPFthWyL921viwtARM
	w==
X-Received: by 2002:aa7:8892:0:b0:842:459b:d62a with SMTP id d2e1a72fcca58-842b0de6486mr6387037b3a.17.1780714305134;
        Fri, 05 Jun 2026 19:51:45 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282883647sm12722450b3a.36.2026.06.05.19.51.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 19:51:44 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH v3 4/6] scripts: add container registry push, auth, tagging, runtime selection
Date: Fri,  5 Jun 2026 19:51:18 -0700
Message-ID: <83d7e0d4ebaf3a0d559c4e2a5b6a4f2ff1972e4a.1780710041.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780710041.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 02:51:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4159

From: Tim Orling <tim.orling@konsulko.com>

Add the push-containers infrastructure that drives the
post-build steps for the 'containers-library' job. After
each build step the runtime container store is harvested
and pushed to one or more registries with derived per-step
tags.

* config.json: add CONTAINER_REGISTRIES, CONTAINER_AUTH_CONFIG,
  CONTAINER_RUNTIME, CONTAINER_TAG_CMDS, CONTAINER_VERSION_RECIPE
  and CONTAINER_IMAGE_MAP configuration knobs.
* scripts/run-config: drive push-containers as a post-step
  action (by running scripts/run-push-containers).
* scripts/run-push-containers: Tags are generated from recipe and
  distro metadata (yocto- tag uses major.minor on snapshots and full
  PV on releases) with CONTAINER_VERSION_RECIPE allowing a step to
  source PV from a different recipe than the image itself.
* Registry auth is staged via .../config.json or podman
  .../auth.json using CONTAINER_AUTH_CONFIG, replacing an
  interactive login that could hang. CONTAINER_RUNTIME picks
  between vdkr (Docker-compatible) and vpdmn (Podman) runtimes.
* Robustness: skip gracefully when no registries are configured,
  fix the OCI directory path, handle memres already running,
  and avoid hanging when memres has not yet come up.

AI-Generated: Claude Cowork Opus 4.8
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json                 |   5 ++
 scripts/run-config          |  12 +++
 scripts/run-push-containers | 165 ++++++++++++++++++++++++++++++++++++
 3 files changed, 182 insertions(+)
 create mode 100755 scripts/run-push-containers

diff --git a/config.json b/config.json
index 3fccd83..e1ea01a 100644
--- a/config.json
+++ b/config.json
@@ -43,6 +43,11 @@
         "BUILDINFOVARS" : ["INHERIT += 'image-buildinfo'", "IMAGE_BUILDINFO_VARS:append = ' IMAGE_BASENAME IMAGE_NAME'"],
         "WRITECONFIG" : true,
         "SENDERRORS" : true,
+        "CONTAINER_RUNTIME" : "vpdmn",
+        "CONTAINER_REGISTRIES" : [],
+        "CONTAINER_TAGS" : ["latest"],
+        "CONTAINER_TAG_CMDS" : [],
+        "CONTAINER_IMAGE_MAP" : {},
         "extravars" : [
             "SANITY_TESTED_DISTROS = ''",
             "BB_HASHSERVE = '${AUTOBUILDER_HASHSERV}'",
diff --git a/scripts/run-config b/scripts/run-config
index 90a5996..31db212 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -195,6 +195,8 @@ utils.mkdir(errordir)
 
 errorlogs = set()
 
+push_containers = properties.get("push_containers", False)
+
 def log_file_contents(filename, builddir, stepnum, stepname):
     logfile = logname(builddir, stepnum, stepname)
     with open(logfile, "a") as outf, open(filename, "r") as f:
@@ -313,6 +315,16 @@ def handle_stepnum(stepnum):
             hp.printheader("Step %s/%s: Running bitbake %s" % (stepnum, maxsteps, sanitytargets))
             bitbakecmd(args.builddir, "bitbake %s -k" % (sanitytargets), report, stepnum, args.stepname)
 
+    # Push container images to registries when push_containers is enabled.
+    # The push logic itself lives in scripts/run-push-containers.
+    container_images = utils.getconfigdict("CONTAINER_IMAGE_MAP", ourconfig, args.target, stepnum)
+    if container_images and push_containers:
+        if jcfg:
+            addstepentry("push-containers", "Push containers", shortdesc, desc, str(container_images), str(stepnum))
+        elif args.stepname == "push-containers":
+            hp.printheader("Step %s/%s: Pushing container images %s" % (stepnum, maxsteps, list(container_images.keys())))
+            bitbakecmd(args.builddir, "%s/run-push-containers %s %s" % (scriptsdir, args.target, stepnum), report, stepnum, args.stepname)
+
     # Run any extra commands specified
     cmds = utils.getconfiglist("EXTRACMDS", ourconfig, args.target, stepnum)
     if jcfg:
diff --git a/scripts/run-push-containers b/scripts/run-push-containers
new file mode 100755
index 0000000..cdef497
--- /dev/null
+++ b/scripts/run-push-containers
@@ -0,0 +1,165 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Push container images built by a target step to the configured registries.
+#
+# Invoked by run-config for 'push-containers' steps with the OE build
+# environment already sourced (bitbake and the vcontainer runtime wrappers
+# must be on PATH). All configuration comes from the target/step config:
+#
+#   CONTAINER_IMAGE_MAP      - dict of image recipe -> registry image name
+#   CONTAINER_RUNTIME        - vpdmn (default) or vdkr
+#   CONTAINER_REGISTRIES     - list of registries to push to
+#   CONTAINER_TAGS           - list of static tags (e.g. latest)
+#   CONTAINER_TAG_CMDS       - extra shell to populate _EXTRA_TAGS
+#   CONTAINER_VERSION_RECIPE - recipe whose PV provides the version tag
+#   CONTAINER_AUTH_CONFIG    - registry auth file staged into the guest
+#
+
+import subprocess
+import sys
+
+import utils
+
+parser = utils.ArgParser(description='Pushes container images for a target step to the configured registries.')
+
+parser.add_argument('target',
+                    help="The target build name")
+parser.add_argument('stepnum',
+                    type=int,
+                    help="The step number within the target")
+
+args = parser.parse_args()
+
+ourconfig = utils.loadconfig()
+
+container_images = utils.getconfigdict("CONTAINER_IMAGE_MAP", ourconfig, args.target, args.stepnum)
+if not container_images:
+    print("No CONTAINER_IMAGE_MAP for %s step %s, nothing to push" % (args.target, args.stepnum))
+    sys.exit(0)
+
+registries = utils.getconfiglist("CONTAINER_REGISTRIES", ourconfig, args.target, args.stepnum)
+if not registries:
+    utils.printheader("push-containers skipped — CONTAINER_REGISTRIES is empty, no containers pushed")
+    sys.exit(0)
+
+runtime = utils.getconfigvar("CONTAINER_RUNTIME", ourconfig, args.target, args.stepnum) or "vpdmn"
+static_tags = utils.getconfiglist("CONTAINER_TAGS", ourconfig, args.target, args.stepnum)
+auth_config = utils.getconfigvar("CONTAINER_AUTH_CONFIG", ourconfig, args.target, args.stepnum)
+if not auth_config:
+    if runtime == "vpdmn":
+        auth_config = "${HOME}/.config/containers/auth.json"
+    else:
+        auth_config = "${HOME}/.docker/config.json"
+
+utils.printheader("Pushing container images %s" % list(container_images.keys()))
+
+script = [
+    "set -e",
+    "test -w /dev/kvm || { echo 'ERROR: /dev/kvm is not writable, cannot push containers'; exit 1; }",
+    # Always bring up a fresh memres VM in the foreground.
+    #
+    # 'memres status' only checks that the QEMU PID in daemon.pid
+    # is alive (see daemon_is_running()/daemon_status() in
+    # meta-virtualization's vrunner.sh); it returns 0 as soon as
+    # QEMU forks, so a hung/partially-booted VM from a previous
+    # run — or a VM in mid-boot — is reported as healthy. The
+    # subsequent 'login'/'vimport'/'push' commands then hang on
+    # the unresponsive daemon socket.
+    #
+    # 'memres restart' is synchronous: it does stop+start and
+    # runs a PING/PONG readiness probe against the daemon socket
+    # (120s timeout), exiting non-zero if the VM never answers.
+    # Running it in the foreground gives us a trustworthy ready
+    # signal via its exit code, so we can drop the status-poll
+    # loop entirely.
+    #
+    # Install an EXIT trap first so we always tear the daemon
+    # down, even if bitbake -e / vimport / push fails mid-step
+    # under 'set -e'. The trap is armed before the restart so
+    # a restart failure also triggers cleanup.
+    #
+    # Registry auth is staged into the guest at VM boot via
+    # the global '--config' flag — vrunner.sh's setup_auth_share()
+    # copies $AUTH_CONFIG onto a read-only 9p share, and
+    # vdkr-init.sh / vpdmn-init.sh's install_auth_config()
+    # installs it at /root/.docker/config.json (vdkr) or
+    # /run/containers/0/auth.json (vpdmn) inside the guest.
+    # Subsequent 'push' calls use those creds directly, so no
+    # explicit 'login' step is needed. Calling 'login' would
+    # actually hang under the autobuilder (no PTY): when the
+    # memres daemon is running, vcontainer-common.sh dispatches
+    # login via '--daemon-interactive' and blocks reading the
+    # password from stdin (see login case in vcontainer-common.sh).
+    "trap '%s-$(arch) memres stop 2>/dev/null || true' EXIT" % runtime,
+    "%s-$(arch) --config %s memres restart </dev/null" % (runtime, auth_config),
+]
+tag_cmds = utils.getconfiglist("CONTAINER_TAG_CMDS", ourconfig, args.target, args.stepnum)
+version_recipe = utils.getconfigvar("CONTAINER_VERSION_RECIPE", ourconfig, args.target, args.stepnum)
+for recipe, image in container_images.items():
+    # Extract version metadata from the recipe and distro via
+    # bitbake -e. Steps that need additional derived tags (e.g.
+    # major, major.minor) populate _EXTRA_TAGS via
+    # CONTAINER_TAG_CMDS in their step config.
+    #
+    # PV is sanitized with 'sed s/+.*//' to drop Yocto's
+    # '+git<sha>' suffix on AUTOREV/dev recipes — Docker
+    # reference format does not allow '+' in tags, and the
+    # base PV is what consumers expect.
+    #
+    # DISTRO_VERSION needs context-sensitive handling. Poky's
+    # DISTRO_VERSION resolves to '${PV}+snapshot-${METADATA_REVISION}'
+    # off a tag and just '${PV}' on a release tag. The '+' in
+    # the snapshot form is illegal in a Docker tag, but more
+    # importantly the patch level on a snapshot build (e.g.
+    # '6.0.99' between 6.0 and 6.1) is a moving target that
+    # doesn't correspond to any real release — only the
+    # major.minor line is meaningful. So:
+    #   - snapshot build (DISTRO_VERSION contains '+') → tag
+    #     with major.minor only, e.g. 'yocto-6.0'.
+    #   - release-tag build (no '+') → tag with the full
+    #     version, e.g. 'yocto-5.0.5' from the yocto-5.0.5 tag.
+    script += [
+        "_BBENV=$(bitbake -e %s 2>/dev/null) || true" % recipe,
+        "_PV=$(echo \"$_BBENV\" | awk -F'\"' '/^PV=/{ print $2; exit }' | sed 's/+.*//')",
+        "_DISTRO_CODENAME=$(echo \"$_BBENV\" | awk -F'\"' '/^DISTRO_CODENAME=/{ print $2; exit }')",
+        "_DISTRO_VERSION_RAW=$(echo \"$_BBENV\" | awk -F'\"' '/^DISTRO_VERSION=/{ print $2; exit }')",
+        "case \"$_DISTRO_VERSION_RAW\" in",
+        "    *+*) _DISTRO_VERSION=$(echo \"${_DISTRO_VERSION_RAW%%+*}\" | cut -d. -f1,2) ;;",
+        "    *)   _DISTRO_VERSION=\"$_DISTRO_VERSION_RAW\" ;;",
+        "esac",
+        "_DEPLOY_DIR_IMAGE=$(echo \"$_BBENV\" | awk -F'\"' '/^DEPLOY_DIR_IMAGE=/{ print $2; exit }')",
+        "_EXTRA_TAGS=\"\"",
+    ]
+    if version_recipe:
+        # When the image recipe's PV is a wrapper-style
+        # placeholder (e.g. app-container-python_1.0.0.bb,
+        # whose 1.0.0 is meaningless to a downstream user),
+        # CONTAINER_VERSION_RECIPE points at the recipe whose
+        # PV is actually meaningful for the resulting tag —
+        # typically the language runtime or app being packaged
+        # (e.g. python3 -> 3.14.x). Override _PV from that
+        # recipe; image-recipe state still drives
+        # DEPLOY_DIR_IMAGE and DISTRO_* since those are
+        # environment-wide.
+        script += [
+            "_VBBENV=$(bitbake -e %s 2>/dev/null) || true" % version_recipe,
+            "_PV=$(echo \"$_VBBENV\" | awk -F'\"' '/^PV=/{ print $2; exit }' | sed 's/+.*//')",
+        ]
+    script += tag_cmds
+    script.append(
+        "_TAGS=\"%s $_PV $_DISTRO_CODENAME yocto-$_DISTRO_VERSION $_EXTRA_TAGS\"" % " ".join(static_tags)
+    )
+    for registry in registries:
+        # No per-registry 'login': credentials were staged into
+        # the guest by '--config' on 'memres restart' above.
+        script += [
+            "for _tag in $_TAGS; do",
+            "    %s-$(arch) vimport ${_DEPLOY_DIR_IMAGE}/%s-latest-oci %s/%s:${_tag}" % (runtime, recipe, registry, image),
+            "    %s-$(arch) push %s/%s:${_tag}" % (runtime, registry, image),
+            "done",
+        ]
+# Tear-down is handled by the EXIT trap installed above.
+utils.flush()
+sys.exit(subprocess.call(["/bin/bash", "-c", "\n".join(script)]))
-- 
2.43.0


