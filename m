Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29124C53209
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 01:41:37 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2421.1785202896212741216
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 18:41:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=AgiRSPgB;
 spf=pass (domain: gmail.com, ip: 209.85.210.172, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso3350347b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 18:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202895; x=1785807695; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lqtnxB0yWJIqRvRFQ7Rt72fFtE9TJ2kHbkVQ4r8SHT8=;
        b=AgiRSPgBfXRpcxwdXWAF4c0N4ux1MHnwF4dP7RELGxWLAnM2z1DYLv3AD0o2dU7P6I
         aQKn67QZYANx6UfSPox7f6FYE7qIC6MimslMrqb30JxR44nFsuCOOCQkbBbhnPCDP/vv
         J7Bh2lc2Y6qEQERo1mtVrr7WTelHCUoUiGDb2TX9hWw9u6EjBBThwSC2NykC7AyYV7bS
         nobDmkRISveM2dT4i7z56WwuhU5mqFiuZOPeiaQIa6h5WjD1wVTu0S78wL1ZUighT6AI
         xgIsPfVCTaZOdfxfb1KFWXXw8OZDiiOfh+83mepI0JKFTZMcj94syRixebTNKsNaKkMy
         qHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202895; x=1785807695;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqtnxB0yWJIqRvRFQ7Rt72fFtE9TJ2kHbkVQ4r8SHT8=;
        b=CbSYC140zaCoWrWo4NF/sERM1OyMYUZVi75LvUvj8rfE4GVxRyvH1SkomA6PcpHxoA
         RLp/Vr6esx9FEu94zSLlwQiVbgzEDLlaYwa6f8S7O9pQ3CMM5ha4XlqmqESQ3Zcr8PgH
         L3O0ShOFfUqmpxMkpErbEraHjmzUibTbOxoq/MtLpXLo7MYAESSwG7gs4YNch8f/jfHS
         4t5O+nzKPEQpRGkQ4MxtW1huKh0vR+C6loB3ZO36FlWDjDYBe7NFM0MvC/tTWO62A7z5
         zLcmSnyChX+sIwxyML+XVxSU3mfeiCHR3fgfBnjf5vY9yEF8loBQTVNZDStH+2rfJsXy
         HuZA==
X-Gm-Message-State: AOJu0Ywpw9auJaVyhB4p2s9bBeCx7g2ERYUm5L9Yd+2BbdFIad0VMzkg
	fHX+1NI7HXEQDYpILy9e4z+fX5id6HhRfcdXH+7sw6jrMaVW6/B7Sk3kB+e9+A==
X-Gm-Gg: AR+sD10aZ268YK/0Bvn3DIDCP0U93WRLuxQpg04W9Kpd7buNUif2dNFgAg279UOOL+0
	G5lVC9QVEYHrcT5A6KhEgKTsLMc3tULF6Arlh5NO2oghPioimRnjuxayyP6cfS3Jc3wkk2Qqvi8
	uoIMERqUs+nfzxybvsrtRs3B4ojxGjkZUlPHWmozq3eYBhTPQcUQnPHvBlc6rPDgDLdXdwDz9wJ
	uMge1WQ7MrVZRtfNro8bzC01p4flYfiXGJUY9eZVC6mdZfkLPusiZnyaiVMimjcMkCCLxAJ/4rb
	nEmlfr/u0OZ7sjZqEaQJJctVNz8v766DsOdvrXAGnU+qy9PmaUBvRm2tltdpW7Dfwk0m4I6jsnE
	0xvQoVgL7fE4RKCIG4/5uw1iyl83WXeIDnwN3KKn4WEvdYWgTB+t7+AVR1I1mfZq4XKKV/r9r+X
	dp64fW1gEx1i6BJSiTXWHKXcoGWHRVbhV5ly+TrSMqWQ/rhbFOK4+c9PVna/qWxNR5d6OJULGJn
	JtUyT6bTt+c
X-Received: by 2002:a05:6a00:3a1f:b0:845:bda6:574b with SMTP id d2e1a72fcca58-84e931f8e3cmr318001b3a.5.1785202895323;
        Mon, 27 Jul 2026 18:41:35 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm3661537b3a.58.2026.07.27.18.41.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 18:41:34 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v5 08/12] run-push-containers: conditionally sign pushed containers with cosign
Date: Mon, 27 Jul 2026 18:40:41 -0700
Message-ID: <10f3fd7b6decfa230ce7b3c7c1c660112a42814f.1785198322.git.tim.orling@konsulko.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4547

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
index d92c493..00fc498 100644
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
2.55.0


