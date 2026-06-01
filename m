Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79325CD5BD1
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:18:49 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12810.1780355920404827819
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:18:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bmcL3V8r;
 spf=pass (domain: konsulko.com, ip: 209.85.214.173, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf114b0cf9so25473875ad.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355920; x=1780960720; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1bVo+m2+SeQAfcXST6hum76BOjKggBED5KLaEPA0bM=;
        b=bmcL3V8r1WCpIdjESpuCWGow0KynQUtwLHUZF8+0dqhDV3BWoMte+SaU35W3xLA20B
         es7knuyRwAKxACcAp/bLzxquanJXRLY6qSWt/NStt04jK5W6snmax/HoOKdPwlLgPhzn
         /JEkvWAelbsg9MRw4rn4upAN/uEudN7J22R+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355920; x=1780960720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R1bVo+m2+SeQAfcXST6hum76BOjKggBED5KLaEPA0bM=;
        b=dk17qvPF6qqIBZqgFXos+nfNQIzyFJNJuz7ZMITGNsmVycU/qGz+h9nSBzyyuYKxDs
         k5TlpQfLYMCyxnmCB5r7Q/XOCWep9VHYiegdHHg7LWg8LWcR4NDQUfyLdm//iOfedWsF
         lhsM4jz1djyguf9d+srRVuoruxWPWQZBOqXMhriO/3QxwX8by46/yeBzPnfctI6Pqg8L
         aaLLmkjVkITEhAvwlM6Lx1iUrQDFwhDPjWj2xWhWGwRtu/dzVfd6SU9l5p5fNfSwesAj
         WHp3gSmjHXsrBUaM34TQ6mu4l9t8Kg07Z0LULuLPLxf4fgPAYKpxu7OZSPWpXYEKODuW
         WsOQ==
X-Gm-Message-State: AOJu0YxDZE31Y/Gbub+oe3TaAEdwOjA7SYnhDwGSUiTNqYYUOfx/zuF3
	PHBGaSn4VMNcAG59ObnlIJEEe9KeEloVr3WC5FH9wKk9gUCqXsM7+PxBKfNp/kwCUjo3vcKV6w6
	IIqPI
X-Gm-Gg: Acq92OG6K7vQMcvy5Kt0304t9DSj40nxIntNJvMJI7McTlRFajwVupFOPx/qaTqh1im
	lFnJMVcowz9AhRoxaikh2q+Ds+44CkeLtBuFwxIFa9zNUD0uxzA6++rN6w9Oydr18Dq+2lrjJPS
	y7g1ONvjfqxMkDgtlshNDVwRkKN2o/f8yshl59WMFMXf1hFTuIlnkc3ZBjA+BRI1+vFahGKrXrq
	rMj4m48GPdgOTyuBpiXBj0xL+oPxXhmjbdjmwHxA5or3hgmcSvabn+cR/ZjHRW/27C2yDI7fKoG
	oLZp2maWj88NStwgP34eY0lZmQlL9xfQxsE+kBZUIGfk7lbGAOt0v67hJWWv0jp9JmjMzL3PdsS
	Y5qWloof78YhtX06byikBSmqIaf8kF+ng2MyfCCzdVHdmd2OpwbK4FMU6kyYVLUlyF4W51655hJ
	IyApfOgCPgPM2hL2EH33dclGevLq7l/y4I32eKWgWv/mySvJ6g/0/XNgs2TE7Hbf2Po/ZG5yCci
	pxDkwKwGDVB
X-Received: by 2002:a17:903:8c8:b0:2bd:606d:b342 with SMTP id d9443c01a7336-2bf36833abfmr137072665ad.26.1780355919784;
        Mon, 01 Jun 2026 16:18:39 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b01727sm120388715ad.53.2026.06.01.16.18.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:18:39 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v2 08/10] scripts: add container registry push, auth, tagging, runtime selection
Date: Mon,  1 Jun 2026 16:18:07 -0700
Message-ID: <31f010d5e7dbc1e2307dfb00f06a9b6380a19c5c.1780354513.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:18:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4105

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
 config.json        |   5 ++
 scripts/run-config | 129 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/config.json b/config.json
index 79a9d10..9f85a7d 100644
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
index 0f5a26a..0fe0385 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -203,6 +203,8 @@ utils.mkdir(errordir)
 
 errorlogs = set()
 
+push_containers = properties.get("push_containers", False)
+
 def log_file_contents(filename, builddir, stepnum, stepname):
     logfile = logname(builddir, stepnum, stepname)
     with open(logfile, "a") as outf, open(filename, "r") as f:
@@ -321,6 +323,133 @@ def handle_stepnum(stepnum):
             hp.printheader("Step %s/%s: Running bitbake %s" % (stepnum, maxsteps, sanitytargets))
             bitbakecmd(args.builddir, "bitbake %s -k" % (sanitytargets), report, stepnum, args.stepname)
 
+    # Push container images to registries when push_containers is enabled
+    container_images = utils.getconfigdict("CONTAINER_IMAGE_MAP", ourconfig, args.target, stepnum)
+    if container_images and push_containers:
+        if jcfg:
+            addstepentry("push-containers", "Push containers", shortdesc, desc, str(container_images), str(stepnum))
+        elif args.stepname == "push-containers":
+            runtime = utils.getconfigvar("CONTAINER_RUNTIME", ourconfig, args.target, stepnum) or "vpdmn"
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


