Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD86AC43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:07:14 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.161488.1783375628642154536
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:07:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=maVJxAgB;
 spf=pass (domain: gmail.com, ip: 209.85.210.171, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8471013fac2so3857171b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783375628; x=1783980428; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tcSruuJO1rQHGCLoyUGX+qMkiVQJy0Gh7TBeqkW7tA=;
        b=maVJxAgBSJndLV0VthQr3SH7DyB7usHBm0I+CgMD1morSOxZiSGUn1XK3138dzDEyM
         j+pf15fJ+Wdg2S1SvuCcktUUpDYArPlC4eNl3A1HvlO6Q/uqAN5oL6Zcyunm535oc812
         LCl7aVKT6bFHFzzJybZ4sS1uu1ltAQLjOgKVLHFGiB0uNJ6v5HTlIkEeF0p1I8cREpfU
         3sK4prUNekhrp5RkgpLkohKWuQEHYKGWNfHfKTok2Mw0vR3ieRQyVKkadkD/FYeSiWLX
         BOcuTpBe5zKh3dcr8PcMIBm6hoF0d8g/ElAVIkM/S6VaelYDHoy9f51g+/bV0uC4fhYy
         Ppuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783375628; x=1783980428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2tcSruuJO1rQHGCLoyUGX+qMkiVQJy0Gh7TBeqkW7tA=;
        b=J5i2LwSfPcYFLDKs96oFywwNhCg0yJs2hSW9nY+Y42+GVNDGCfiAlDg//YwR3snIrh
         hY/K8MJTwhsE6yMywvC4r1XejXft4BRQvf3VhSFmsX6Bq244K6w7i8QmENRi4LMwst3g
         s8FIpk7y+lD++ZiJ6ELyBDB+pDp3SbFur7WI4iyX1cl7/Pdpp2j0bjhK3XsxaWKnQIW3
         kg5Uss9DhWiZcckVijtDxNiw5l80uE2yjREywcCbFDWOCPWCMvLoJ8cBGqVn1PogFusn
         cB4Doi+BDa/TsCyr8Rbt4TCFoS9TxHABPRZfg3QUvG/HWP7f3/d+TdVpvEcyayyhEvah
         Ijrg==
X-Gm-Message-State: AOJu0YwoGjSPybwz3pNSZME08wb5XYEWDSr9PRx/TgDhXd6q8q/CDGcI
	C7XnemDEhWViCRiRD/F+MtSIim2YRKC4jEayRWnRlVcw+PxbXqyYCjh/eT1mcQ==
X-Gm-Gg: AfdE7cmReK1HE9UhJZR2AVnrvl5t9Uevu6zYDy7zKSMD+rmbPKXG7FJSV/ePHrF4M4M
	FgnQLmDjbTMFSC46uQfwiKOP3TDxothCrRmETKjQArMbB84cbozjhrmkdP6etH1l9CIcRkb6Csa
	2g1KAQ6MP/KzHLMD5GkDyXrssHl68cAtQwgl3hKXx6U7xhxZoRWoc8he2UXB5sH6jiV8M8n7U8A
	35FHUhmMKWV8u9iT11I5iif6GBvZAMdoyzmykGJi1tGh2eAVZs68D+GcK+L7VBhp2Jv1mQAtr5m
	IINZuEV6n5zGeT+Kf20LxuuLK0Rsx6NiOCWqvRq2/0AlXE44GI99DZDNlpSS/id0R7uD50COedy
	UUtJYvcFi043pn+Q+8jJhUh+ltIBczIqUOYZ6CcBQg3sH5UJhgFsI26OZ0yGZDRaaKWPfyEDFEz
	w42S+1trgKj8/GBApEzyEHO+XxB+28gwF7iVmkLixWuICkAA3/Jvmzr4lxo870VEjIFKuxjH8zp
	g7+P+VsIM5m
X-Received: by 2002:a05:6a00:e07:b0:845:d274:bf88 with SMTP id d2e1a72fcca58-84826d8637amr2453529b3a.49.1783375627722;
        Mon, 06 Jul 2026 15:07:07 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d5b95sm84720a12.3.2026.07.06.15.07.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 15:07:05 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v4 08/11] run-push-containers: conditionally sign pushed containers with cosign
Date: Mon,  6 Jul 2026 15:05:40 -0700
Message-ID: <79eda3320fba3266fcfb00710d46cc5949a506a0.1783371914.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783371914.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com> <cover.1783371914.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:07:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4438

Introduce CONTAINER_COSIGN_KEY, a cosign private key path that gates
signing. When unset (the default) no cosign sysroot is prepared and
signing is skipped entirely.

When set, every image that is successfully pushed is signed in place:

  - prepare_cosign() lazily populates the cosign-native sysroot
    (bitbake cosign-native -c addto_recipe_sysroot) and logs cosign in
    to each target registry. CONTAINER_REGISTRIES entries carry a
    namespace path (e.g. quay.io/ticotimo), but the auth file is keyed
    by the bare registry host and 'cosign login' only accepts a host
    authority, so each entry is stripped to its host ('${reg%%/*}') for
    both the credential lookup and the login: auths.<host>.auth is
    base64-decoded into user:password and the password is fed on stdin
    (--password-stdin).

  - sign_image() signs the image by digest with 'cosign sign --recursive
    --key' (which also covers every child manifest of a multi-arch index)
    so cosign does not warn about signing a mutable tag. The digest must
    be the one the tag resolves to: the multi-arch index digest is taken
    from 'skopeo copy --all --digestfile' at push time, and the
    single-arch manifest digest from 'skopeo inspect' (correct there, as
    there is no list). Signing 'skopeo inspect' on a multi-arch tag is
    avoided because without --raw it returns the host platform's child
    digest, which would sign one arch and leave the index unsigned.
    Signing is deduped per digest within the run, and a transparency-log
    conflict ('entry already exists' / HTTP 409, which also recurs on
    rebuilds that reproduce the same digest) is treated as success so
    signing stays idempotent rather than aborting the step.

Signing runs in both push paths (multiarch skopeo-native and single-arch
memres VM) and only after a successful push, so a missing/failed-build
artefact is still skipped rather than signed. COSIGN_PASSWORD is exported
(defaulting to empty) so cosign reads the passphrase from the environment
instead of falling through to an interactive prompt (which dies with
"inappropriate ioctl for device" under the autobuilder); an encrypted key
requires the real value to be present in the build environment.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json                 |   1 +
 scripts/run-push-containers | 115 +++++++++++++++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/config.json b/config.json
index 878cca0..a1eee57 100644
--- a/config.json
+++ b/config.json
@@ -48,6 +48,7 @@
         "CONTAINER_TAGS" : ["latest"],
         "CONTAINER_TAG_CMDS" : [],
         "CONTAINER_IMAGE_MAP" : {},
+        "CONTAINER_COSIGN_KEY" : "",
         "extravars" : [
             "SANITY_TESTED_DISTROS = ''",
             "BB_HASHSERVE = '${AUTOBUILDER_HASHSERV}'",
diff --git a/scripts/run-push-containers b/scripts/run-push-containers
index c13f493..9f6f2fa 100755
--- a/scripts/run-push-containers
+++ b/scripts/run-push-containers
@@ -15,6 +15,9 @@
 #   CONTAINER_TAG_CMDS       - extra shell to populate _EXTRA_TAGS
 #   CONTAINER_VERSION_RECIPE - recipe whose PV provides the version tag
 #   CONTAINER_AUTH_CONFIG    - registry auth file staged into the guest
+#   CONTAINER_COSIGN_KEY     - cosign private key path; when set, each
+#                              successfully pushed image is signed with
+#                              cosign (otherwise signing is skipped)
 #
 
 import subprocess
@@ -53,6 +56,10 @@ if not auth_config:
     else:
         auth_config = "${HOME}/.docker/config.json"
 
+# Signing is conditional: only when CONTAINER_COSIGN_KEY points at a cosign
+# private key. When unset, no cosign sysroot is prepared and no signing runs.
+cosign_key = utils.getconfigvar("CONTAINER_COSIGN_KEY", ourconfig, args.target, args.stepnum)
+
 utils.printheader("Pushing container images %s" % list(container_images.keys()))
 
 script = [
@@ -124,6 +131,99 @@ script = [
     "    _SKOPEO_READY=1",
     "}",
 ]
+
+# Cosign signing helpers, only emitted when a signing key is configured.
+#
+# prepare_cosign() is lazy like prepare_skopeo()/start_vm(): it populates the
+# cosign-native sysroot once and logs cosign in to every target registry. The
+# push paths authenticate via the auth file directly (--dest-authfile /
+# --config), but cosign authenticates through its own credential store, so we
+# must 'cosign login' explicitly. CONTAINER_REGISTRIES entries carry a
+# namespace path (e.g. quay.io/ticotimo), but the auth file is keyed by the
+# bare registry host and 'cosign login' only accepts a host authority (a path
+# fails with "registries must be valid RFC 3986 URI authorities"). So we strip
+# each entry to its host ('${reg%%/*}') for both the credential lookup and the
+# login: read auths.<host>.auth from the auth file, base64-decode it into
+# 'user:password', and feed the password on stdin (--password-stdin) so it
+# never appears in the process table.
+#
+# COSIGN_PASSWORD is exported (defaulting to empty) so cosign reads the
+# passphrase from the environment and never falls through to an interactive
+# prompt under the autobuilder (no PTY) — without it cosign tries to read the
+# passphrase from the terminal and dies with "inappropriate ioctl for device".
+# The real value, if the key is encrypted, must be present in the build
+# environment.
+#
+# sign_image() signs by digest ($2) so cosign does not warn about signing a
+# mutable tag, while still pinning the index a consumer verifies. The digest
+# MUST be the digest the tag resolves to:
+#   - multi-arch: the manifest-list/index digest, captured at push time from
+#     'skopeo copy --all --digestfile' (the digest of the list it pushed).
+#   - single-arch: the lone manifest digest, which 'skopeo inspect' returns
+#     correctly (no list, so no platform ambiguity) — used when $2 is empty.
+# 'cosign sign --recursive' then signs that digest and every child manifest.
+#
+# IMPORTANT: do NOT feed 'skopeo inspect' a multi-arch tag for the sign digest.
+# Without --raw it resolves to the host platform's CHILD manifest, so signing
+# image@<that-digest> signs one architecture and leaves the index unsigned —
+# why signed multi-arch images can still show as "Unsigned". Hence the index
+# digest comes from --digestfile, not inspect.
+if cosign_key:
+    login_block = """    for _reg in %s; do
+        _host=${_reg%%%%/*}
+        _creds=$(python3 -c 'import base64,json,os,sys
+a=json.load(open(os.path.expandvars(sys.argv[1])))
+e=a.get("auths",{}).get(sys.argv[2]) or {}
+t=e.get("auth")
+sys.stdout.write(base64.b64decode(t).decode() if t else "")' "%s" "$_host")
+        if [ -z "$_creds" ]; then
+            echo "WARNING: no credentials for $_host in auth file, skipping cosign login"
+            continue
+        fi
+        _cuser=${_creds%%%%:*}
+        _cpass=${_creds#*:}
+        printf '%%s' "$_cpass" | oe-run-native cosign-native cosign login "$_host" -u "$_cuser" --password-stdin
+    done""" % (" ".join(registries), auth_config)
+    script += [
+        "export COSIGN_PASSWORD=\"${COSIGN_PASSWORD:-}\"",
+        "_COSIGN_READY=0",
+        "prepare_cosign() {",
+        "    if [ \"$_COSIGN_READY\" = 1 ]; then return 0; fi",
+        "    bitbake cosign-native -c addto_recipe_sysroot",
+        login_block,
+        "    _COSIGN_READY=1",
+        "}",
+        # Track digests already signed in this run so the same artefact is
+        # signed only once (see sign_image).
+        "_SIGNED_REFS=\"\"",
+        # $1 = <registry>/<image>:<tag> just pushed; $2 = its digest (the index
+        # digest from 'skopeo copy --digestfile' on the multi-arch path). When
+        # $2 is empty (single-arch), resolve the lone manifest digest with
+        # 'skopeo inspect' — correct there since there is no list. oe-run-native
+        # prints 'Getting sysroot...' to stdout, so grep the digest out.
+        "sign_image() {",
+        "    prepare_skopeo",
+        "    prepare_cosign",
+        "    _SIG_DIGEST=\"$2\"",
+        "    if [ -z \"$_SIG_DIGEST\" ]; then _SIG_DIGEST=$(oe-run-native skopeo-native skopeo inspect --authfile %s --format '{{.Digest}}' docker://$1 | grep -oE 'sha256:[0-9a-f]{64}' | tail -n1); fi" % auth_config,
+        "    if [ -z \"$_SIG_DIGEST\" ]; then echo \"WARNING: could not resolve digest for $1, skipping cosign sign\"; return 0; fi",
+        "    _SIG_REF=\"${1%:*}@${_SIG_DIGEST}\"",
+        "    case \" $_SIGNED_REFS \" in *\" $_SIG_REF \"*) return 0 ;; esac",
+        "    _SIGNED_REFS=\"$_SIGNED_REFS $_SIG_REF\"",
+        # Sign by digest; --recursive also signs each child manifest. Treat a
+        # transparency-log conflict ('already exists' / HTTP 409, which also
+        # recurs on rebuilds that reproduce the same digest) as success so
+        # signing stays idempotent instead of aborting the step.
+        "    _sign_out=$(oe-run-native cosign-native cosign sign --recursive --key %s \"$_SIG_REF\" 2>&1) || {" % cosign_key,
+        "        case \"$_sign_out\" in",
+        "            *\"already exists\"*|*createLogEntryConflict*) echo \"cosign: $_SIG_REF already in transparency log, treating as signed\" ;;",
+        "            *) echo \"$_sign_out\" >&2; return 1 ;;",
+        "        esac",
+        "    }",
+        "    echo \"$_sign_out\"",
+        "}",
+    ]
+
 tag_cmds = utils.getconfiglist("CONTAINER_TAG_CMDS", ourconfig, args.target, args.stepnum)
 version_recipe = utils.getconfigvar("CONTAINER_VERSION_RECIPE", ourconfig, args.target, args.stepnum)
 for recipe, image in container_images.items():
@@ -205,12 +305,19 @@ for recipe, image in container_images.items():
     script.append("        echo \"WARNING: %s did not build (no OCI image at $_OCI_MULTIARCH_OUTPUT), skipping push\"" % recipe)
     script.append("    else")
     script.append("        prepare_skopeo")
+    # --digestfile records the index digest skopeo pushed, so signing can pin
+    # it directly (see sign_image); only needed when signing is enabled.
+    digestfile = ' --digestfile "$_DGSTFILE"' if cosign_key else ""
+    if cosign_key:
+        script.append("        _DGSTFILE=$(mktemp)")  # tiny tmp file, assumes autobuilder workdir is ephemeral
     for registry in registries:
         script += [
             "        for _tag in $_TAGS; do",
-            "            oe-run-native skopeo-native skopeo copy --all --dest-authfile %s oci:${_OCI_MULTIARCH_OUTPUT} docker://%s/%s:${_tag}" % (auth_config, registry, image),
-            "        done",
+            "            oe-run-native skopeo-native skopeo copy --all%s --dest-authfile %s oci:${_OCI_MULTIARCH_OUTPUT} docker://%s/%s:${_tag}" % (digestfile, auth_config, registry, image),
         ]
+        if cosign_key:
+            script.append("            sign_image %s/%s:${_tag} \"$(cat \"$_DGSTFILE\")\"" % (registry, image))
+        script.append("        done")
     script.append("    fi")
     script.append("else")
     # Single-arch: import the ${recipe}-latest-oci artefact into the memres VM
@@ -225,8 +332,10 @@ for recipe, image in container_images.items():
             "        for _tag in $_TAGS; do",
             "            %s-$(arch) vimport ${_DEPLOY_DIR_IMAGE}/%s-latest-oci %s/%s:${_tag}" % (runtime, recipe, registry, image),
             "            %s-$(arch) push %s/%s:${_tag}" % (runtime, registry, image),
-            "        done",
         ]
+        if cosign_key:
+            script.append("            sign_image %s/%s:${_tag}" % (registry, image))
+        script.append("        done")
     script.append("    fi")
     script.append("fi")
 # Tear-down is handled by the EXIT trap installed above.
-- 
2.54.0


