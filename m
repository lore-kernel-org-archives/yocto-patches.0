Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15940C53209
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 01:41:27 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2418.1785202884721806782
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 18:41:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=hR/gKekR;
 spf=pass (domain: gmail.com, ip: 209.85.210.173, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso3387241b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 18:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202884; x=1785807684; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWuk+FPjb3drsqOpTGVduyc+q08Wp7jSDLINYERmlTg=;
        b=hR/gKekRVIPW745W3cK8qf6CB8mWDhbr+v57Jkug1nEsOcrLdf3EVlKfwLs62hvaZL
         t+PosebBSEfc4qOeT8rkxmYYYmiVWomQppykIPSsKkp08wYYyP8C1R7A9bfVJtyormgy
         qUjUVixQZUzG5q404AWk70HUPNRn4fU0LH6Kg7Qz5+OiEojRwELw2/+LiIhS1hZQ3UzH
         dZHAlWFX1bKbNS0jy89/2WtAHlQvzkEmuOGPjARP8oUSwYxouOLK1RBSEYnTEdBLQjIz
         cxG1x6WRcjJ+zPoC/UB2fKDnM84RtJ58iYKDoXAZzbAGWOaE9cPMewp4UvFdFy5aqAfo
         miug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202884; x=1785807684;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nWuk+FPjb3drsqOpTGVduyc+q08Wp7jSDLINYERmlTg=;
        b=f80qjxC42p+ikR2RzVDKf88WkgBRCrleoc4LhdZLXliWDQXdk9vS/lig9neX3GkLPN
         5kEL+WV7QidhCLQMnVpHi5NFpGM5ak5VitdcxEfMoLTliiA62EgCrnUg0zLQ+iN7PMtk
         vOfgI7/d/hwkN5+dy1gvneXALXmLc791UVQ1YVGPqoq57uUVpAAtf7wlZJ/9KgP1rOUo
         6Piu4o/LfxlMYP3b26+6kMXqFgfXm6dZtygKoGnW3Zqu7v+gt8h2dyKRBHya6kN8pJzd
         g/36HVNYB45RhIwmvjf9AiPz/aaGjPJLO3jUf6MMbUA5wy3MmXEkBECFrYOAb3VR/yTp
         1yOg==
X-Gm-Message-State: AOJu0YxTOpA4yD2M8iV1FMpk5M1ZRRm5/45MnniQDfxNFdRL7DcAoK2o
	/kd4DdiiloM/mB7Xo8gyDwLyK0YAMI1igOazE6NTcaFNLLFu7pmvT5y4Bivvaw==
X-Gm-Gg: AR+sD10o6uqi8sNcCrvme3YMWaeZ/rtSAgUCOzVCBqfyIwcfgQg5s/o2s+JLsrMh37M
	rkCQeHahYNs6euXRP79vIMF1icPhwzLMzRYsH20pMRbII7D9QIBcrQghdcCs+QLp/t+Hwbi7tRN
	HoRtRZNDNBRt+JqE2iFc4u4GAUwCxcYvKI02OgL/V9GVK8zGcN83wgUHfcxImHPetTYx44Lo465
	JtGJY0tgXrKcjQ0wuxdHNPtHJY9npnN48GR68AfPhw9oQFDoMa4mNkqCOlSrG6h8obTcsqpEQ3J
	PowTT8o5r18Azip66ScMhrrQahwQ9Uk9DxX5o4ygqOfBYjVaj52EL9FHrexN4vqhFDpY20l9WV7
	YzUI5hZg3bzA/N2paXnfbdw14oTn1sqenX3Q/zBPfnGq9P2ajiA9xI6s6gW8V4sBWneEZ1sQNyP
	b1+ThYcB7GU08A7YDMirR1e7cxmX8tXDUo0NHriE5/kpBzYMSJ9GK0F9h0uo9SCMZqNXkzw8yv3
	A==
X-Received: by 2002:a05:6a00:84e:b0:848:2f84:f427 with SMTP id d2e1a72fcca58-84e93338b86mr294282b3a.64.1785202883839;
        Mon, 27 Jul 2026 18:41:23 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm3661537b3a.58.2026.07.27.18.41.22
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 18:41:22 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v5 04/12] scripts: add container registry push, auth, tagging, runtime selection
Date: Mon, 27 Jul 2026 18:40:37 -0700
Message-ID: <ed9aaa9ee6b60053739695ecb74a508fbb6f3321.1785198322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785198322.git.tim.orling@konsulko.com>
References: <cover.1783371914.git.tim.orling@konsulko.com> <cover.1785198322.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 01:41:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4543

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
* Skip pushing when building the container image failed
* Registry auth is staged via .../config.json or podman
  .../auth.json using CONTAINER_AUTH_CONFIG, replacing an
  interactive login that could hang. CONTAINER_RUNTIME picks
  between vdkr (Docker-compatible) and vpdmn (Podman) runtimes.
* Robustness: skip gracefully when no registries are configured,
  fix the OCI directory path, handle memres already running,
  and avoid hanging when memres has not yet come up.
* The vcontainer-tarball bundles its own python3/site-packages;
  sourcing its environment-setup-ci puts them on PATH and shadows the
  buildbot-venv (e.g. its websockets<10 breaks bitbake's hashserv).
  It must never touch the build steps' PATH, so there is no job-wide
  "vcontainer" init step: the tarball is set up (downloaded/extracted
  on demand, cached) and its env sourced only in the synthesized steps
  that actually use its runtime wrappers -- push-containers (vpdmn/vdkr
  'vimport' for single-arch; multiarch uses skopeo-native from the
  build).

AI-Generated: Claude Cowork Opus 4.8
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json                 |   5 +
 scripts/run-config          |  24 +++--
 scripts/run-push-containers | 180 ++++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+), 8 deletions(-)
 create mode 100755 scripts/run-push-containers

diff --git a/config.json b/config.json
index 5a97674..d9d0fdc 100644
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
index 90a5996..391db3e 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -154,15 +154,11 @@ else:
         sys.exit(0)
 
 vcontainer = utils.getconfigvar("vcontainer", ourconfig, args.target)
-if jcfg:
-    if vcontainer:
-        addentry("vcontainer", "Setup vcontainer tarball", "init")
-elif vcontainer:
-    # vcontainer is opt-in per target via the "vcontainer" config variable,
-    # so this is a no-op for targets which don't set it
+# The vcontainer-tarball bundles its own python3/site-packages; avoid
+# shadowing the buildbot-venv, except in steps that require 'vpdmn' or
+# 'vkdr'. This avoids build failures on 'buildtools' workers.
+if not jcfg and vcontainer and args.stepname in ("push-containers"):
     utils.setup_vcontainer_tarball(ourconfig, args.target, args.builddir + "/../vcontainer-tarball")
-    if args.phase == "init" and args.stepname == "vcontainer":
-        sys.exit(0)
 
 extratools = utils.getconfigvar("extratools", ourconfig, args.target)
 if jcfg:
@@ -195,6 +191,8 @@ utils.mkdir(errordir)
 
 errorlogs = set()
 
+push_containers = properties.get("push_containers", False)
+
 def log_file_contents(filename, builddir, stepnum, stepname):
     logfile = logname(builddir, stepnum, stepname)
     with open(logfile, "a") as outf, open(filename, "r") as f:
@@ -313,6 +311,16 @@ def handle_stepnum(stepnum):
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
index 0000000..00d87ed
--- /dev/null
+++ b/scripts/run-push-containers
@@ -0,0 +1,180 @@
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
+    # Only push an image whose build actually produced an OCI artefact.
+    # build-targets runs 'bitbake ... -k', so a failed image build does
+    # not abort the build step or the other images, and the failure is
+    # already reported there. If we let the push proceed, 'vimport' of
+    # the missing ${recipe}-latest-oci would fail under 'set -e' and
+    # abort the whole push step — taking down the images that *did*
+    # build with it. So skip a missing image here (warn, don't fail)
+    # and let the successfully-built ones publish.
+    script += [
+        "_OCI_IMAGE=${_DEPLOY_DIR_IMAGE}/%s-latest-oci" % recipe,
+        "if [ ! -e \"$_OCI_IMAGE\" ]; then",
+        "    echo \"WARNING: %s did not build (no OCI image at $_OCI_IMAGE), skipping push\"" % recipe,
+        "else",
+    ]
+    for registry in registries:
+        # No per-registry 'login': credentials were staged into
+        # the guest by '--config' on 'memres restart' above.
+        script += [
+            "    for _tag in $_TAGS; do",
+            "        %s-$(arch) vimport ${_DEPLOY_DIR_IMAGE}/%s-latest-oci %s/%s:${_tag}" % (runtime, recipe, registry, image),
+            "        %s-$(arch) push %s/%s:${_tag}" % (runtime, registry, image),
+            "    done",
+        ]
+    script.append("fi")
+# Tear-down is handled by the EXIT trap installed above.
+utils.flush()
+sys.exit(subprocess.call(["/bin/bash", "-c", "\n".join(script)]))
-- 
2.55.0


