Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E57BCD37A7
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:01:14 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4665.1778205666591546791
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:01:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=KicGi0u1;
 spf=pass (domain: konsulko.com, ip: 209.85.214.180, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba4a1a0325so10226015ad.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205666; x=1778810466; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zoUlgS46/uIUQJfoLuWdhmaV6qcAEnnd0l06KjPCjQ=;
        b=KicGi0u1nW/EJdFnLVLfaAP8RgM0Dq1TwKC6n8ehD1fin8Nl3od6TL2aAWzrMOpUBK
         /B36NSslITM6EY4gjh7wQwltD1JNjYwgQugPzFaBZ7WxGi2bWU8XAbPmWIc1Yi3NQmSs
         lLpAIuEerS1h9UUuACJ9G4cMwCbMX2S7XfHDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205666; x=1778810466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8zoUlgS46/uIUQJfoLuWdhmaV6qcAEnnd0l06KjPCjQ=;
        b=ZVbO0gN/tGkvl6NDp5i52RuAmEXaodI0nOJ2b6pIYiCfECxPLq2KlvfNF3QtQpe/6n
         nG4CfAOjlmJc2LKc1CxWDt4rA3VMTCxKVBAxV8ofplYUI7bhC2EPWYNQc+BYFNmBm7f7
         NbZt/Z/+z3kL8bNUbyUwZOhu/NuLDl85FpaxRDoteTdKCr41e4QNY1xE70QcvqXWEXeo
         bPGsscgB9Odr6oRHk4XbseJ3g+62UjI3IC6u+vX5nisWR5i1RPWnxdHgFGNe2W9rqnNO
         hvdHcPJBt8K3brWkV6A7VEQNFCLC8hf6AzxM9S6G3p87DDfWKHwZdf7BI3QOPcFJpRtF
         9u9w==
X-Gm-Message-State: AOJu0Yxb4vLjJvnAGcL8tjuG/Og+j7RyjC0omgid4lzlJhFts1wOOwdr
	G5RrW+Qnsmdoielf3lxpBB9QfxaxLTCdoHgikhEimMCQPpZHfZaWZLPN9FedWwzirbAKCE8866A
	OBs1n
X-Gm-Gg: Acq92OHSM6mho4LeyGwRKidcGAkPymeteKVOEUFzr0mebKp4d3norMi9/jJQWcjAi86
	+W6cUIdJMGG2WkVhgaxzrgWmQ+Kb4oVT//W0yctRuAEHY9r9vhFh7xIKjHo2ph9g8e/ZYBR9S+S
	YBH83ngvoglABaRyEuxCk09h+4+pL3Y0H05WvAAW4c11gjiDugzlnYHWa2bwc0j3wYzSurP+usp
	NV3wfaO14lQxZ2DfjMg6nlpR5Y/cOIJQokNXb7+zySWwNt2/PJPsCQcPgz7DhsYV+fOMKhuXuJU
	dPJefku8Z9+0BntXsHWBWtjF66o+2cXfAeWnoZCyD1soquS75FaVw4/yw15ulB0m6TmQj/0UjVK
	2scbDOIa+hz1IABy+kdMnadUBr35LVjBBr0Syi6olVCBZOyiBg9xNs08k8ir4t5cmty93icJene
	eNc1Dtx4zjS9E+dP3ZlJVyTGouuZ1N/bBpxvX4QgorQ5R1LrYii5EJIE5znBESsysAt9xHU0xMO
	w==
X-Received: by 2002:a17:902:cf4c:b0:2b2:5840:809c with SMTP id d9443c01a7336-2ba78b49e00mr105427505ad.1.1778205665489;
        Thu, 07 May 2026 19:01:05 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4050dsm1891695ad.31.2026.05.07.19.01.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:01:05 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 10/11] scripts: add container registry push, auth, tagging, runtime selection
Date: Thu,  7 May 2026 19:00:33 -0700
Message-ID: <94817f61d81b462e073e28f48cc71152f666eaeb.1778202125.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:01:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3949

From: Tim Orling <tim.orling@konsulko.com>

Add the push-containers infrastructure that drives the
post-build steps for the 'containers-' jobs. After each build
step the runtime container store is harvested and pushed to
one or more registries with derived per-step tags.

  * config.json: add CONTAINER_REGISTRIES, CONTAINER_AUTH_CONFIG,
    CONTAINER_RUNTIME, CONTAINER_TAG_CMDS and
    CONTAINER_VERSION_RECIPE configuration knobs. Tag
    app-container-python with python3 PV via
    CONTAINER_VERSION_RECIPE.
  * scripts/run-config: drive push-containers as a post-step
    action. Tags are generated from recipe and distro metadata
    (yocto- tag uses major.minor on snapshots and full PV on
    releases) with CONTAINER_VERSION_RECIPE allowing a step to
    source PV from a different recipe than the image itself.
  * Registry auth is staged via .../config.json or podman
    .../auth.json using CONTAINER_AUTH_CONFIG, replacing an
    interactive login that could hang. CONTAINER_RUNTIME picks
    between vdkr (Docker-compatible) and vpdmn (Podman) runtimes.
  * Robustness: skip gracefully when no registries are configured,
    fix the OCI directory path, handle memres already running,
    and avoid hanging when memres has not yet come up.

AI-Generated: Claude Cowork Opus 4.7
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json        |  17 +++++-
 scripts/run-config | 128 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+), 2 deletions(-)

diff --git a/config.json b/config.json
index dda5b12..7cdf91a 100644
--- a/config.json
+++ b/config.json
@@ -1,4 +1,4 @@
-{
+			{
     "BASE_HOMEDIR" : "/home/pokybuild",
     "BASE_SHAREDDIR" : "/srv/autobuilder/autobuilder.yocto.io",
     "BASE_PUBLISHDIR" : "/srv/autobuilder/downloads.yoctoproject.org",
@@ -40,6 +40,10 @@
         "SDKEXTRAS" : ["SSTATE_MIRRORS += '\\", "file://.* http://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH'", "BB_HASHSERVE = 'auto'", "BB_HASHSERVE_UPSTREAM = '${AUTOBUILDER_HASHSERV}'"],
         "BUILDINFO" : false,
         "BUILDHISTORY" : false,
+        "CONTAINER_RUNTIME" : "vdkr",
+        "CONTAINER_REGISTRIES" : [],
+        "CONTAINER_TAGS" : ["latest"],
+        "CONTAINER_TAG_CMDS" : [],
         "BUILDINFOVARS" : ["INHERIT += 'image-buildinfo'", "IMAGE_BUILDINFO_VARS:append = ' IMAGE_BASENAME IMAGE_NAME'"],
         "WRITECONFIG" : true,
         "SENDERRORS" : true,
@@ -1908,6 +1912,7 @@
             "step1" : {
                 "shortname" : "Build 'base' container",
                 "BBTARGETS" : "container-base",
+                "CONTAINER_IMAGES" : {"container-base": "base"},
                 "extravars" : [
                     "DISTRO_FEATURES:append = ' virtualization vcontainer'"
                 ]
@@ -1915,6 +1920,7 @@
             "step2" : {
                 "shortname" : "Build 'curl' container",
                 "BBTARGETS" : "app-container-curl",
+                "CONTAINER_IMAGES" : {"app-container-curl": "curl"},
                 "extravars" : [
                     "DISTRO_FEATURES:append = ' virtualization vcontainer'"
                 ]
@@ -1934,9 +1940,16 @@
             "extravars" : [
                 "DISTRO_FEATURES:append = ' virtualization vcontainer'"
             ],
+             "CONTAINER_TAG_CMDS" : [
+                 "_PV_MAJOR=$(echo $_PV | cut -d. -f1)",
+                 "_PV_MAJOR_MINOR=$(echo $_PV | cut -d. -f1,2)",
+                 "_EXTRA_TAGS=\"$_PV_MAJOR $_PV_MAJOR_MINOR\""
+             ],
             "step1" : {
                 "shortname" : "Build 'python' container",
-                "BBTARGETS" : "app-container-python"
+                "BBTARGETS" : "app-container-python",
+                "CONTAINER_IMAGES" : {"app-container-python": "python"},
+                "CONTAINER_VERSION_RECIPE" : "python3"
             }
         },
         "vcontainer-tests": {
diff --git a/scripts/run-config b/scripts/run-config
index 0f5a26a..48e0b85 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -198,6 +198,7 @@ utils.mkdir(args.builddir)
 
 revision = "unknown"
 report = utils.ErrorReport(ourconfig, args.target, args.builddir, properties['branch_oecore'], revision)
+push_containers = properties.get("push_containers", False)
 errordir = utils.errorreportdir(args.builddir)
 utils.mkdir(errordir)
 
@@ -321,6 +322,133 @@ def handle_stepnum(stepnum):
             hp.printheader("Step %s/%s: Running bitbake %s" % (stepnum, maxsteps, sanitytargets))
             bitbakecmd(args.builddir, "bitbake %s -k" % (sanitytargets), report, stepnum, args.stepname)
 
+    # Push container images to registries when push_containers is enabled
+    container_images = utils.getconfigdict("CONTAINER_IMAGES", ourconfig, args.target, stepnum)
+    if container_images and push_containers:
+        if jcfg:
+            addstepentry("push-containers", "Push containers", shortdesc, desc, str(container_images), str(stepnum))
+        elif args.stepname == "push-containers":
+            runtime = utils.getconfigvar("CONTAINER_RUNTIME", ourconfig, args.target, stepnum) or "vdkr"
+            registries = utils.getconfiglist("CONTAINER_REGISTRIES", ourconfig, args.target, stepnum)
+            if not registries:
+                hp.printheader("Step %s/%s: push-containers skipped — CONTAINER_REGISTRIES is empty, no containers pushed" % (stepnum, maxsteps))
+            else:
+                static_tags = utils.getconfiglist("CONTAINER_TAGS", ourconfig, args.target, stepnum)
+                auth_config = utils.getconfigvar("CONTAINER_AUTH_CONFIG", ourconfig, args.target, stepnum)
+                if not auth_config:
+                    if runtime == "vpdmn":
+                        auth_config = "${HOME}/.config/containers/auth.json"
+                    else:
+                        auth_config = "${HOME}/.docker/config.json"
+                hp.printheader("Step %s/%s: Pushing container images %s" % (stepnum, maxsteps, list(container_images.keys())))
+                script = [
+                    "set -e",
+                    "test -w /dev/kvm || { echo 'ERROR: /dev/kvm is not writable, cannot push containers'; exit 1; }",
+                    # Always bring up a fresh memres VM in the foreground.
+                    #
+                    # 'memres status' only checks that the QEMU PID in daemon.pid
+                    # is alive (see daemon_is_running()/daemon_status() in
+                    # meta-virtualization's vrunner.sh); it returns 0 as soon as
+                    # QEMU forks, so a hung/partially-booted VM from a previous
+                    # run — or a VM in mid-boot — is reported as healthy. The
+                    # subsequent 'login'/'vimport'/'push' commands then hang on
+                    # the unresponsive daemon socket.
+                    #
+                    # 'memres restart' is synchronous: it does stop+start and
+                    # runs a PING/PONG readiness probe against the daemon socket
+                    # (120s timeout), exiting non-zero if the VM never answers.
+                    # Running it in the foreground gives us a trustworthy ready
+                    # signal via its exit code, so we can drop the status-poll
+                    # loop entirely.
+                    #
+                    # Install an EXIT trap first so we always tear the daemon
+                    # down, even if bitbake -e / vimport / push fails mid-step
+                    # under 'set -e'. The trap is armed before the restart so
+                    # a restart failure also triggers cleanup.
+                    #
+                    # Registry auth is staged into the guest at VM boot via
+                    # the global '--config' flag — vrunner.sh's setup_auth_share()
+                    # copies $AUTH_CONFIG onto a read-only 9p share, and
+                    # vdkr-init.sh / vpdmn-init.sh's install_auth_config()
+                    # installs it at /root/.docker/config.json (vdkr) or
+                    # /run/containers/0/auth.json (vpdmn) inside the guest.
+                    # Subsequent 'push' calls use those creds directly, so no
+                    # explicit 'login' step is needed. Calling 'login' would
+                    # actually hang under the autobuilder (no PTY): when the
+                    # memres daemon is running, vcontainer-common.sh dispatches
+                    # login via '--daemon-interactive' and blocks reading the
+                    # password from stdin (see login case in vcontainer-common.sh).
+                    "trap '%s-$(arch) memres stop 2>/dev/null || true' EXIT" % runtime,
+                    "%s-$(arch) --config %s memres restart </dev/null" % (runtime, auth_config),
+                ]
+                tag_cmds = utils.getconfiglist("CONTAINER_TAG_CMDS", ourconfig, args.target, stepnum)
+                version_recipe = utils.getconfigvar("CONTAINER_VERSION_RECIPE", ourconfig, args.target, stepnum)
+                for recipe, image in container_images.items():
+                    # Extract version metadata from the recipe and distro via
+                    # bitbake -e. Steps that need additional derived tags (e.g.
+                    # major, major.minor) populate _EXTRA_TAGS via
+                    # CONTAINER_TAG_CMDS in their step config.
+                    #
+                    # PV is sanitized with 'sed s/+.*//' to drop Yocto's
+                    # '+git<sha>' suffix on AUTOREV/dev recipes — Docker
+                    # reference format does not allow '+' in tags, and the
+                    # base PV is what consumers expect.
+                    #
+                    # DISTRO_VERSION needs context-sensitive handling. Poky's
+                    # DISTRO_VERSION resolves to '${PV}+snapshot-${METADATA_REVISION}'
+                    # off a tag and just '${PV}' on a release tag. The '+' in
+                    # the snapshot form is illegal in a Docker tag, but more
+                    # importantly the patch level on a snapshot build (e.g.
+                    # '6.0.99' between 6.0 and 6.1) is a moving target that
+                    # doesn't correspond to any real release — only the
+                    # major.minor line is meaningful. So:
+                    #   - snapshot build (DISTRO_VERSION contains '+') → tag
+                    #     with major.minor only, e.g. 'yocto-6.0'.
+                    #   - release-tag build (no '+') → tag with the full
+                    #     version, e.g. 'yocto-5.0.5' from the yocto-5.0.5 tag.
+                    script += [
+                        "_BBENV=$(bitbake -e %s 2>/dev/null) || true" % recipe,
+                        "_PV=$(echo \"$_BBENV\" | awk -F'\"' '/^PV=/{ print $2; exit }' | sed 's/+.*//')",
+                        "_DISTRO_CODENAME=$(echo \"$_BBENV\" | awk -F'\"' '/^DISTRO_CODENAME=/{ print $2; exit }')",
+                        "_DISTRO_VERSION_RAW=$(echo \"$_BBENV\" | awk -F'\"' '/^DISTRO_VERSION=/{ print $2; exit }')",
+                        "case \"$_DISTRO_VERSION_RAW\" in",
+                        "    *+*) _DISTRO_VERSION=$(echo \"${_DISTRO_VERSION_RAW%%+*}\" | cut -d. -f1,2) ;;",
+                        "    *)   _DISTRO_VERSION=\"$_DISTRO_VERSION_RAW\" ;;",
+                        "esac",
+                        "_DEPLOY_DIR_IMAGE=$(echo \"$_BBENV\" | awk -F'\"' '/^DEPLOY_DIR_IMAGE=/{ print $2; exit }')",
+                        "_EXTRA_TAGS=\"\"",
+                    ]
+                    if version_recipe:
+                        # When the image recipe's PV is a wrapper-style
+                        # placeholder (e.g. app-container-python_1.0.0.bb,
+                        # whose 1.0.0 is meaningless to a downstream user),
+                        # CONTAINER_VERSION_RECIPE points at the recipe whose
+                        # PV is actually meaningful for the resulting tag —
+                        # typically the language runtime or app being packaged
+                        # (e.g. python3 -> 3.14.x). Override _PV from that
+                        # recipe; image-recipe state still drives
+                        # DEPLOY_DIR_IMAGE and DISTRO_* since those are
+                        # environment-wide.
+                        script += [
+                            "_VBBENV=$(bitbake -e %s 2>/dev/null) || true" % version_recipe,
+                            "_PV=$(echo \"$_VBBENV\" | awk -F'\"' '/^PV=/{ print $2; exit }' | sed 's/+.*//')",
+                        ]
+                    script += tag_cmds
+                    script.append(
+                        "_TAGS=\"%s $_PV $_DISTRO_CODENAME yocto-$_DISTRO_VERSION $_EXTRA_TAGS\"" % " ".join(static_tags)
+                    )
+                    for registry in registries:
+                        # No per-registry 'login': credentials were staged into
+                        # the guest by '--config' on 'memres restart' above.
+                        script += [
+                            "for _tag in $_TAGS; do",
+                            "    %s-$(arch) vimport ${_DEPLOY_DIR_IMAGE}/%s-latest-oci %s/%s:${_tag}" % (runtime, recipe, registry, image),
+                            "    %s-$(arch) push %s/%s:${_tag}" % (runtime, registry, image),
+                            "done",
+                        ]
+                # Tear-down is handled by the EXIT trap installed above.
+                bitbakecmd(args.builddir, "\n".join(script), report, stepnum, args.stepname)
+
     # Run any extra commands specified
     cmds = utils.getconfiglist("EXTRACMDS", ourconfig, args.target, stepnum)
     if jcfg:
-- 
2.43.0


