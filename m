Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48165C53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 01:41:37 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2419.1785202890813901490
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 18:41:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FnypSso5;
 spf=pass (domain: gmail.com, ip: 209.85.210.175, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e0688b859so2030745b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 18:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202890; x=1785807690; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qR3lz2jblWLKLj9Xaztceu/mgLi95WzSkXeiyKIIqNk=;
        b=FnypSso5WbCFtMz7F8o2dbLKogIy9663DcGxbcvqnUYtS5WOf70Bbk2R9S35RszcG9
         n8H+DtZHoRXhH2al48iGL3ayP5WPJujviJMIqMXMZsO8zOuCymDUpJLCMVnkiICVB5RT
         5nIP4g1xW5yugy+iSG4/tD8X7+9v3tuBC1ZmN12G/NATX7t8DCu31mum1Ow6Q9BWEmfo
         1ZB4WreTMLkQo/yJaw3+07TEXnjQa/9jSXKGzXVIDG6iLaQ/tb2n84IQt1rSp21nZEeM
         enPmepOnHs8/Zv367VlcxhuYSB1VTZV3YVIzzpNIpsjp2vsVn9YjiJpXYoh+7lGXsI9r
         X8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202890; x=1785807690;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qR3lz2jblWLKLj9Xaztceu/mgLi95WzSkXeiyKIIqNk=;
        b=LPYyBWRqJSFDaijnGtw5qVtJDu9gP39S2XDZl2zwPQiK3RIe2whf2KFnD7De8pCSud
         +/qSLEZn5o6ujZwnnmxBqYcWC5fX/SditHc6sjZmNEHslGC/P8fBOYgtwWRPxojvh88p
         zYeAVQDVyq0t4nVmJBhVLTIyQgxXcWdFS7o4pRHMeeULc/sQDfjWQv7TxMD3Aery0k+F
         HCE72jYW6WNk9YMD8bbGnrl9q2sWxxRbXvKUvy2IJZXUfkINEMzuw+ddgvT1srF9mt9x
         WW3hV634g7pUj+YKfJsmgq5cgTrc7FrhlBvKGNFXq2wZSW+ashGx7/K4p82htu1hgQYJ
         yvkg==
X-Gm-Message-State: AOJu0YxTCaPZckaaKdtu64aHlknGE1d6T30XNDx7CkYj7jLFGuy9jsf5
	v8D5KXm3gYpdpjsjYsXByBwhi1mJS7IDDDXis8ruWWVBj1cyDlTpf+vCfvR7iA==
X-Gm-Gg: AR+sD10w4SN9GK3EnmwoQN/f0CvPGeZvIwu8ogM+5koPjEocDfoXlnr0tn/XFquVkxQ
	TrviHAiLoDYfBc0/sW+BKBe8IxZlismUmIKSGEEE97xczZsUYytITnhYA9guriS5Br3HDYJvpHk
	d+fdOOp5TqWL5e62DvVcPj9gj7gin0IovuT3p3epBICVomXMSQ840RX/fvOT+XXgQv3W2Ks13Uq
	c4fPQuwf/hDrQMUN49y10fkAoPiRl7f0ZCIQ8+z1YbYZYnjPpTCi7R+T2cHgxDk57Jo03U9P5zh
	sBZuI3f+S2y9bLwDHpzdjTiPuRw4cJSFD2JP5fBBr9+LH3dYwbs4S/GR0kMkzqbV/otaNH8na93
	WWAX/+FeFaxLqsVd0besorAK0l3sNsVS/Deml5wRqZ788GwmCbR9W40UBVEHkMjFLXhlWYleNbx
	hklVQWLb0i88Sua8wApzTvjzhhgjXORPI6fExGQX7mmv3khfj4sGa/eJ8Al0c3dbft1ctIYvz0E
	gawLNc4dtGr
X-Received: by 2002:a05:6a00:4292:b0:848:6895:b763 with SMTP id d2e1a72fcca58-84e9332e67bmr277552b3a.40.1785202890019;
        Mon, 27 Jul 2026 18:41:30 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm3661537b3a.58.2026.07.27.18.41.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 18:41:28 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v5 06/12]  scripts/run-push-containers: push multiarch containers with skopeo-native
Date: Mon, 27 Jul 2026 18:40:39 -0700
Message-ID: <ee326d6102303f071de789c3c6e1c410b8046290.1785198322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785198322.git.tim.orling@konsulko.com>
References: <cover.1783371914.git.tim.orling@konsulko.com> <cover.1785198322.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 01:41:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4545

Support pushing multi-architecture container images (recipes
inheriting meta-virtualization's oci-multiarch class) from the
'containers-library' job. These produce an OCI Image Index on
disk rather than a single-arch image in a runtime store, so
they are pushed with skopeo instead of vdkr/vpdmn (which only
vimport one architecture).

* scripts/run-push-containers: detect multiarch recipes per-recipe
  at runtime: 'bitbake -e' only contains OCI_MULTIARCH_OUTPUT when
  the recipe inherits oci-multiarch, and its value is the exact
  OCI layout path to push. Multiarch images are pushed with
  'oe-run-native skopeo-native skopeo copy --all' direct from
  the OCI layout, after populating the skopeo-native recipe
  sysroot via 'bitbake skopeo-native -c addto_recipe_sysroot'
  (once per step, prepare_skopeo). The same tag set and
  registries are used for both paths; auth is passed to skopeo
  via --dest-authfile from CONTAINER_AUTH_CONFIG.
* scripts/run-push-containers: defer the memres VM bring-up (kvm
  check, EXIT trap, restart, image rm) into a lazy start_vm() that
  only runs when the first single-arch recipe is pushed, so multiarch
  -only steps need neither /dev/kvm nor a VM boot.

AI-Generated: Claude Cowork Opus 4.8
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/run-push-containers | 100 +++++++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 23 deletions(-)

diff --git a/scripts/run-push-containers b/scripts/run-push-containers
index 00d87ed..c13f493 100755
--- a/scripts/run-push-containers
+++ b/scripts/run-push-containers
@@ -58,7 +58,24 @@ utils.printheader("Pushing container images %s" % list(container_images.keys()))
 script = [
     "set -e",
     "test -w /dev/kvm || { echo 'ERROR: /dev/kvm is not writable, cannot push containers'; exit 1; }",
-    # Always bring up a fresh memres VM in the foreground.
+    # Two push paths share this script:
+    #
+    #  - Single-arch images (the common case) are imported into
+    #    a vdkr/vpdmn memres VM and pushed from inside it. The
+    #    VM bring-up is expensive and needs /dev/kvm, so it is
+    #    wrapped in start_vm() and only runs when the first
+    #    single-arch recipe is pushed.
+    #
+    #  - Multi-arch images (recipes inheriting oci-multiarch)
+    #    are pushed with skopeo-native straight from the OCI
+    #    Image Index layout on disk — no VM, no /dev/kvm.
+    #    skopeo's recipe sysroot is populated on first use by
+    #    prepare_skopeo(). Detection is per-recipe at runtime:
+    #    'bitbake -e <recipe>' only contains OCI_MULTIARCH_OUTPUT
+    #    when the recipe inherits oci-multiarch, and its value is
+    #    the exact OCI layout path to push.
+    #
+    # Notes on the memres VM bring-up in start_vm():
     #
     # 'memres status' only checks that the QEMU PID in daemon.pid
     # is alive (see daemon_is_running()/daemon_status() in
@@ -92,8 +109,20 @@ script = [
     # memres daemon is running, vcontainer-common.sh dispatches
     # login via '--daemon-interactive' and blocks reading the
     # password from stdin (see login case in vcontainer-common.sh).
-    "trap '%s-$(arch) memres stop 2>/dev/null || true' EXIT" % runtime,
-    "%s-$(arch) --config %s memres restart </dev/null" % (runtime, auth_config),
+    "_VM_STARTED=0",
+    "start_vm() {",
+    "    if [ \"$_VM_STARTED\" = 1 ]; then return 0; fi",
+    "    test -w /dev/kvm || { echo 'ERROR: /dev/kvm is not writable, cannot push containers'; exit 1; }",
+    "    trap '%s-$(arch) memres stop 2>/dev/null || true' EXIT" % runtime,
+    "    %s-$(arch) --config %s memres restart </dev/null" % (runtime, auth_config),
+    "    _VM_STARTED=1",
+    "}",
+    "_SKOPEO_READY=0",
+    "prepare_skopeo() {",
+    "    if [ \"$_SKOPEO_READY\" = 1 ]; then return 0; fi",
+    "    bitbake skopeo-native -c addto_recipe_sysroot",
+    "    _SKOPEO_READY=1",
+    "}",
 ]
 tag_cmds = utils.getconfiglist("CONTAINER_TAG_CMDS", ourconfig, args.target, args.stepnum)
 version_recipe = utils.getconfigvar("CONTAINER_VERSION_RECIPE", ourconfig, args.target, args.stepnum)
@@ -130,6 +159,10 @@ for recipe, image in container_images.items():
         "    *)   _DISTRO_VERSION=\"$_DISTRO_VERSION_RAW\" ;;",
         "esac",
         "_DEPLOY_DIR_IMAGE=$(echo \"$_BBENV\" | awk -F'\"' '/^DEPLOY_DIR_IMAGE=/{ print $2; exit }')",
+        # Only set (non-empty) when the recipe inherits
+        # oci-multiarch; doubles as the multiarch marker and
+        # the OCI layout path for skopeo below.
+        "_OCI_MULTIARCH_OUTPUT=$(echo \"$_BBENV\" | awk -F'\"' '/^OCI_MULTIARCH_OUTPUT=/{ print $2; exit }')",
         "_EXTRA_TAGS=\"\"",
     ]
     if version_recipe:
@@ -151,29 +184,50 @@ for recipe, image in container_images.items():
     script.append(
         "_TAGS=\"%s $_PV $_DISTRO_CODENAME yocto-$_DISTRO_VERSION $_EXTRA_TAGS\"" % " ".join(static_tags)
     )
-    # Only push an image whose build actually produced an OCI artefact.
-    # build-targets runs 'bitbake ... -k', so a failed image build does
-    # not abort the build step or the other images, and the failure is
-    # already reported there. If we let the push proceed, 'vimport' of
-    # the missing ${recipe}-latest-oci would fail under 'set -e' and
-    # abort the whole push step — taking down the images that *did*
-    # build with it. So skip a missing image here (warn, don't fail)
-    # and let the successfully-built ones publish.
-    script += [
-        "_OCI_IMAGE=${_DEPLOY_DIR_IMAGE}/%s-latest-oci" % recipe,
-        "if [ ! -e \"$_OCI_IMAGE\" ]; then",
-        "    echo \"WARNING: %s did not build (no OCI image at $_OCI_IMAGE), skipping push\"" % recipe,
-        "else",
-    ]
+    # Detect multiarch vs single-arch per recipe and push accordingly,
+    # but only for an image whose build actually produced its OCI artefact.
+    #
+    # build-targets runs 'bitbake ... -k', so a failed image build does not
+    # abort the build step or the other images, and that failure is already
+    # reported there. If we pushed regardless, the missing artefact would make
+    # 'skopeo copy'/'vimport' fail under 'set -e' and abort the whole push
+    # step — taking the images that *did* build down with it. So skip an image
+    # whose artefact is missing (warn, don't fail) and let the
+    # successfully-built ones publish.
+    #
+    # No per-registry 'login': for the VM path, credentials are staged into
+    # the guest by '--config' on 'memres restart' (see start_vm); for the
+    # skopeo path, the same auth file is passed via --dest-authfile.
+    script.append("if [ -n \"$_OCI_MULTIARCH_OUTPUT\" ]; then")
+    # Multi-arch: push the OCI Image Index layout at $_OCI_MULTIARCH_OUTPUT
+    # straight from disk with skopeo-native (no VM, no /dev/kvm).
+    script.append("    if [ ! -e \"$_OCI_MULTIARCH_OUTPUT\" ]; then")
+    script.append("        echo \"WARNING: %s did not build (no OCI image at $_OCI_MULTIARCH_OUTPUT), skipping push\"" % recipe)
+    script.append("    else")
+    script.append("        prepare_skopeo")
+    for registry in registries:
+        script += [
+            "        for _tag in $_TAGS; do",
+            "            oe-run-native skopeo-native skopeo copy --all --dest-authfile %s oci:${_OCI_MULTIARCH_OUTPUT} docker://%s/%s:${_tag}" % (auth_config, registry, image),
+            "        done",
+        ]
+    script.append("    fi")
+    script.append("else")
+    # Single-arch: import the ${recipe}-latest-oci artefact into the memres VM
+    # and push it from inside the guest.
+    script.append("    _OCI_IMAGE=${_DEPLOY_DIR_IMAGE}/%s-latest-oci" % recipe)
+    script.append("    if [ ! -e \"$_OCI_IMAGE\" ]; then")
+    script.append("        echo \"WARNING: %s did not build (no OCI image at $_OCI_IMAGE), skipping push\"" % recipe)
+    script.append("    else")
+    script.append("        start_vm")
     for registry in registries:
-        # No per-registry 'login': credentials were staged into
-        # the guest by '--config' on 'memres restart' above.
         script += [
-            "    for _tag in $_TAGS; do",
-            "        %s-$(arch) vimport ${_DEPLOY_DIR_IMAGE}/%s-latest-oci %s/%s:${_tag}" % (runtime, recipe, registry, image),
-            "        %s-$(arch) push %s/%s:${_tag}" % (runtime, registry, image),
-            "    done",
+            "        for _tag in $_TAGS; do",
+            "            %s-$(arch) vimport ${_DEPLOY_DIR_IMAGE}/%s-latest-oci %s/%s:${_tag}" % (runtime, recipe, registry, image),
+            "            %s-$(arch) push %s/%s:${_tag}" % (runtime, registry, image),
+            "        done",
         ]
+    script.append("    fi")
     script.append("fi")
 # Tear-down is handled by the EXIT trap installed above.
 utils.flush()
-- 
2.55.0


