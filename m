Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DBDC54EFC
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 01:41:47 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2422.1785202898743357332
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 18:41:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=bnFHICky;
 spf=pass (domain: gmail.com, ip: 209.85.210.171, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845c92bc464so2757268b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 18:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202898; x=1785807698; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KRvD6DUGxSSWc2HjzUy6NxaZaT5wg+mIu7aXGn+VKMs=;
        b=bnFHICkyc63Tgxv1GkOUGYf8OcJKUP/9NhZpocO7C8VlJuPd0OzhI0QdhfipWQtnzr
         GKVl5xBUXXBrEFrdJbryh4CJeCqBkMExAhJC0RJHZCBY+0ZjL7ilajNQDF53KVBfgV0j
         GhujOTNcSQbH8aGY49LFr6iUaOscGeKdbJfuXzpQcqQcLskNDd3XWziF4uNHsM2mvDOR
         5Hp+3I67CJvthiZWY554oTqLJlqnPxihmde4ITOVOyIwBVgxuyVmg5qJbad448aaoxWT
         iK/JFbRh1wBd8DLkZAIO4jfvUGVLZ12aX4AQJcdCKh5A+sQEkrSJPqGUoHsTbZaubLle
         F6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202898; x=1785807698;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KRvD6DUGxSSWc2HjzUy6NxaZaT5wg+mIu7aXGn+VKMs=;
        b=ImdWBTVKYal92E9YqIlyP75aTAFQXA72H91VaXvwh6ezDQYhjdnvPQmv6AHqn/QnKo
         D77NhCdpZqvBNEldpgIgrhPO+wJsbBw5TtnS0dslTZT20kDy/mF53ArSbBBfyb6RRySx
         8JjD4Qo/6SGtR47eytYN7H/QkmHkxUtAwS5DaaEX0dgSIEYWcFD8c8kgqXFsrVLjVNra
         fayrkr8S9Pg02HWVukzS1UhfxbZC0ER1StTzwdb4HgDTo88SmAtiazPEDPLAhJKxMSKv
         H4EYDOsVGpkJa82xP+nVvbsMh+B31SmLOnAu8Gl+QHhjzxNz/aNPsbKpX5TmTeZq25yk
         BnUg==
X-Gm-Message-State: AOJu0YwhMIAV617D3d6wo84+v+/bx94kzqXfNYhubwgFTMDTYgARRcIi
	0rNmjKNIIwe1XxP3dWuzk1ixceimcaUJBj2Z+UJOxEPejKanreEdMo9ZSm4Gdw==
X-Gm-Gg: AR+sD13jSlzHAPMpU9cTwslZe093RBzicqMLHZct28C5G8rXcRWSARbVWYdigqkWe93
	NK4S+adFxiDk+EjvH9zZ2KycHZ4JOcp7GxaJKLT17OQG4Ex4Ebb0/KUXuKTuFMSgO9sWFSjLc7g
	BRex8RAi5w7XKBWw/XCLla8AQBwDOKJXGUXXGc1mMPDgXDCs+UG1hsxGu/FVOQ2v/PGKtY/RrIG
	i46KhD0WLwfyGQglvMIIP7KBMJr5jCT605qP0eUPfQLZj3YGzkw6GvS0zGAkjRQsYDh5Sfxaer7
	7uRKa7P3eeOMHfSWnaSnG1m98McPxu258zwOafgpbMW+AwEN8nu8A2cP9EppQ9eu+UD+Vnh1qzY
	FWGRc9vPY2yW1h6xYfC8Kg9FcnZkYCS7nzAlWYAf4Bmp3xRJRjgn40FPMJQnYENVbgZVSqJT2yj
	RCxuIICCPMXWLwM4/nbMNTE9kf49FRFFDbV638DF9a6+s4O5Izj448RPuaY4K+4eUWCF2cSHrpr
	g==
X-Received: by 2002:a05:6a00:3992:b0:848:7f8a:8d0e with SMTP id d2e1a72fcca58-84e932c5f3emr288181b3a.55.1785202897961;
        Mon, 27 Jul 2026 18:41:37 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm3661537b3a.58.2026.07.27.18.41.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 18:41:36 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v5 09/12]  scripts/run-push-containers: add SPDX SBOM attestation
Date: Mon, 27 Jul 2026 18:40:42 -0700
Message-ID: <bda372ec3d49a0cd03df391892db639a59a6fb7f.1785198322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785198322.git.tim.orling@konsulko.com>
References: <cover.1783371914.git.tim.orling@konsulko.com> <cover.1785198322.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 01:41:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4548

Attach a *.rootfs.spdx.json as an in-toto attestation to either
the top-level container if it is single-arch or to each arch
container image if it is multi-arch.

Introduce CONTAINER_COSIGN_PUB which is the cosign public key path;
when set, each attestation is verified with 'cosign verify-attestation'
after it is attached

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/run-push-containers | 106 +++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/scripts/run-push-containers b/scripts/run-push-containers
index 9f6f2fa..debf83f 100755
--- a/scripts/run-push-containers
+++ b/scripts/run-push-containers
@@ -17,7 +17,14 @@
 #   CONTAINER_AUTH_CONFIG    - registry auth file staged into the guest
 #   CONTAINER_COSIGN_KEY     - cosign private key path; when set, each
 #                              successfully pushed image is signed with
-#                              cosign (otherwise signing is skipped)
+#                              cosign (otherwise signing is skipped). Also
+#                              gates SPDX SBOM attestation: each pushed image
+#                              gets a 'cosign attest --type spdxjson'
+#                              attestation of its SPDX SBOM (per-arch on the
+#                              multi-arch path, top manifest on single-arch).
+#   CONTAINER_COSIGN_PUB     - cosign public key path; when set, each
+#                              attestation is verified with
+#                              'cosign verify-attestation' after it is made
 #
 
 import subprocess
@@ -59,6 +66,9 @@ if not auth_config:
 # Signing is conditional: only when CONTAINER_COSIGN_KEY points at a cosign
 # private key. When unset, no cosign sysroot is prepared and no signing runs.
 cosign_key = utils.getconfigvar("CONTAINER_COSIGN_KEY", ourconfig, args.target, args.stepnum)
+# Public key for verifying attestations; when unset, attestations are made but
+# not verified.
+cosign_pub = utils.getconfigvar("CONTAINER_COSIGN_PUB", ourconfig, args.target, args.stepnum)
 
 utils.printheader("Pushing container images %s" % list(container_images.keys()))
 
@@ -193,6 +203,13 @@ sys.stdout.write(base64.b64decode(t).decode() if t else "")' "%s" "$_host")
         login_block,
         "    _COSIGN_READY=1",
         "}",
+        # Resolve the lone manifest digest of a single-arch reference. Correct
+        # only when there is no manifest list (single-arch / child manifest);
+        # the multi-arch path passes explicit digests instead. oe-run-native
+        # prints 'Getting sysroot...' to stdout, so grep the digest out.
+        "resolve_digest() {",
+        "    oe-run-native skopeo-native skopeo inspect --authfile %s --format '{{.Digest}}' docker://$1 | grep -oE 'sha256:[0-9a-f]{64}' | tail -n1" % auth_config,
+        "}",
         # Track digests already signed in this run so the same artefact is
         # signed only once (see sign_image).
         "_SIGNED_REFS=\"\"",
@@ -205,7 +222,7 @@ sys.stdout.write(base64.b64decode(t).decode() if t else "")' "%s" "$_host")
         "    prepare_skopeo",
         "    prepare_cosign",
         "    _SIG_DIGEST=\"$2\"",
-        "    if [ -z \"$_SIG_DIGEST\" ]; then _SIG_DIGEST=$(oe-run-native skopeo-native skopeo inspect --authfile %s --format '{{.Digest}}' docker://$1 | grep -oE 'sha256:[0-9a-f]{64}' | tail -n1); fi" % auth_config,
+        "    if [ -z \"$_SIG_DIGEST\" ]; then _SIG_DIGEST=$(resolve_digest $1); fi",
         "    if [ -z \"$_SIG_DIGEST\" ]; then echo \"WARNING: could not resolve digest for $1, skipping cosign sign\"; return 0; fi",
         "    _SIG_REF=\"${1%:*}@${_SIG_DIGEST}\"",
         "    case \" $_SIGNED_REFS \" in *\" $_SIG_REF \"*) return 0 ;; esac",
@@ -222,6 +239,46 @@ sys.stdout.write(base64.b64decode(t).decode() if t else "")' "%s" "$_host")
         "    }",
         "    echo \"$_sign_out\"",
         "}",
+        # Make sure an image's SPDX SBOM exists before we attest it. $1 is the
+        # expected spdx.json path, $2 the bitbake target that produces it
+        # (mc:<mc>:<recipe> on the multi-arch path, plain <recipe> single-arch).
+        # create_image_sbom_spdx runs by default for single-arch builds, so the
+        # file is normally already there; the multi-arch index recipe doesn't
+        # pull in the per-arch SBOM tasks, so we generate them on demand.
+        "ensure_spdx() {",
+        "    if [ ! -e \"$1\" ]; then",
+        "        echo \"SPDX SBOM $1 missing, generating: bitbake -c create_image_sbom_spdx $2\"",
+        "        bitbake -c create_image_sbom_spdx $2 || true",
+        "    fi",
+        "    if [ ! -e \"$1\" ]; then echo \"WARNING: SPDX SBOM $1 still missing, skipping attestation\"; return 1; fi",
+        "}",
+        # Track refs already attested so the same digest is attested once.
+        "_ATTESTED_REFS=\"\"",
+        # Attest an SPDX SBOM against a digest-pinned image ref. $1 =
+        # <registry>/<image>@sha256:...; $2 = spdx.json path. Idempotent: a
+        # transparency-log conflict on rebuilds is treated as success. When a
+        # public key is configured the attestation is verified afterwards.
+        "attest_image() {",
+        "    prepare_skopeo",
+        "    prepare_cosign",
+        "    case \" $_ATTESTED_REFS \" in *\" $1 \"*) return 0 ;; esac",
+        "    _ATTESTED_REFS=\"$_ATTESTED_REFS $1\"",
+        "    _att_out=$(oe-run-native cosign-native cosign attest --key %s --type spdxjson --predicate \"$2\" \"$1\" 2>&1) || {" % cosign_key,
+        "        case \"$_att_out\" in",
+        "            *\"already exists\"*|*createLogEntryConflict*) echo \"cosign: attestation for $1 already in transparency log\" ;;",
+        "            *) echo \"$_att_out\" >&2; return 1 ;;",
+        "        esac",
+        "    }",
+        "    echo \"$_att_out\"",
+    ]
+    if cosign_pub:
+        script += [
+            "    oe-run-native cosign-native cosign verify-attestation --key %s --type spdxjson \"$1\" >/dev/null \\" % cosign_pub,
+            "        && echo \"cosign: verified attestation for $1\" \\",
+            "        || { echo \"ERROR: attestation verification failed for $1\" >&2; return 1; }",
+        ]
+    script += [
+        "}",
     ]
 
 tag_cmds = utils.getconfiglist("CONTAINER_TAG_CMDS", ourconfig, args.target, args.stepnum)
@@ -259,6 +316,13 @@ for recipe, image in container_images.items():
         "    *)   _DISTRO_VERSION=\"$_DISTRO_VERSION_RAW\" ;;",
         "esac",
         "_DEPLOY_DIR_IMAGE=$(echo \"$_BBENV\" | awk -F'\"' '/^DEPLOY_DIR_IMAGE=/{ print $2; exit }')",
+        # MACHINE locates the single-arch SPDX SBOM (<recipe>-<MACHINE>.rootfs.spdx.json).
+        "_MACHINE=$(echo \"$_BBENV\" | awk -F'\"' '/^MACHINE=/{ print $2; exit }')",
+        # TOPDIR and the oci-multiarch plain vars drive per-arch SBOM
+        # attestation below; the latter two are empty for non-multiarch recipes.
+        "_TOPDIR=$(echo \"$_BBENV\" | awk -F'\"' '/^TOPDIR=/{ print $2; exit }')",
+        "_OCI_MULTIARCH_RECIPE=$(echo \"$_BBENV\" | awk -F'\"' '/^OCI_MULTIARCH_RECIPE=/{ print $2; exit }')",
+        "_OCI_MULTIARCH_PLATFORMS=$(echo \"$_BBENV\" | awk -F'\"' '/^OCI_MULTIARCH_PLATFORMS=/{ print $2; exit }')",
         # Only set (non-empty) when the recipe inherits
         # oci-multiarch; doubles as the multiarch marker and
         # the OCI layout path for skopeo below.
@@ -318,6 +382,34 @@ for recipe, image in container_images.items():
         if cosign_key:
             script.append("            sign_image %s/%s:${_tag} \"$(cat \"$_DGSTFILE\")\"" % (registry, image))
         script.append("        done")
+    if cosign_key:
+        # Attest each child manifest with that arch's SPDX SBOM. The arch ->
+        # (multiconfig, machine) mapping lives in oci-multiarch.bbclass flags
+        # (OCI_MULTIARCH_MC/MACHINE[<arch>]); query them per platform with
+        # bitbake-getvar so an overridden mapping is still honoured. The child
+        # manifest digest is the per-arch source image's manifest digest, which
+        # the class copies verbatim into the index and skopeo copy --all pushes
+        # unchanged — so we attest <image>@<child-digest>.
+        script.append("        for _plat in $_OCI_MULTIARCH_PLATFORMS; do")
+        script.append("            _mc=$(bitbake-getvar -q -r %s --value -f $_plat OCI_MULTIARCH_MC)" % recipe)
+        script.append("            _machine=$(bitbake-getvar -q -r %s --value -f $_plat OCI_MULTIARCH_MACHINE)" % recipe)
+        script.append("            if [ -z \"$_mc\" ] || [ -z \"$_machine\" ]; then echo \"WARNING: no mc/machine for platform $_plat, skipping attestation\"; continue; fi")
+        script.append("            _pdir=${_TOPDIR}/tmp-${_mc}/deploy/images/${_machine}")
+        script.append("            _mspdx=${_pdir}/${_OCI_MULTIARCH_RECIPE}-${_machine}.rootfs.spdx.json")
+        # Locate the per-arch source OCI layout (same name patterns the class
+        # searches) and read its single manifest digest = the child digest.
+        script.append("            _mdig=\"\"")
+        script.append("            for _oci in ${_OCI_MULTIARCH_RECIPE}-latest-oci ${_OCI_MULTIARCH_RECIPE}-${_machine}-latest-oci ${_OCI_MULTIARCH_RECIPE}-oci; do")
+        script.append("                if [ -e \"${_pdir}/${_oci}/index.json\" ]; then")
+        script.append("                    _mdig=$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))[\"manifests\"][0][\"digest\"])' \"${_pdir}/${_oci}/index.json\")")
+        script.append("                    break")
+        script.append("                fi")
+        script.append("            done")
+        script.append("            if [ -z \"$_mdig\" ]; then echo \"WARNING: no source OCI index for $_plat under $_pdir, skipping attestation\"; continue; fi")
+        script.append("            ensure_spdx \"$_mspdx\" \"mc:${_mc}:${_OCI_MULTIARCH_RECIPE}\" || continue")
+        for registry in registries:
+            script.append("            attest_image %s/%s@${_mdig} \"$_mspdx\"" % (registry, image))
+        script.append("        done")
     script.append("    fi")
     script.append("else")
     # Single-arch: import the ${recipe}-latest-oci artefact into the memres VM
@@ -327,6 +419,12 @@ for recipe, image in container_images.items():
     script.append("        echo \"WARNING: %s did not build (no OCI image at $_OCI_IMAGE), skipping push\"" % recipe)
     script.append("    else")
     script.append("        start_vm")
+    if cosign_key:
+        # create_image_sbom_spdx runs by default for single-arch image builds,
+        # so the SBOM is normally already deployed; ensure_spdx regenerates it
+        # only if absent. Single manifest -> attest the digest the tag resolves
+        # to (resolve_digest, also used by sign_image).
+        script.append("        _SPDX=${_DEPLOY_DIR_IMAGE}/%s-${_MACHINE}.rootfs.spdx.json" % recipe)
     for registry in registries:
         script += [
             "        for _tag in $_TAGS; do",
@@ -335,6 +433,10 @@ for recipe, image in container_images.items():
         ]
         if cosign_key:
             script.append("            sign_image %s/%s:${_tag}" % (registry, image))
+            script.append("            if ensure_spdx \"$_SPDX\" \"%s\"; then" % recipe)
+            script.append("                _ADIG=$(resolve_digest %s/%s:${_tag})" % (registry, image))
+            script.append("                [ -n \"$_ADIG\" ] && attest_image %s/%s@${_ADIG} \"$_SPDX\"" % (registry, image))
+            script.append("            fi")
         script.append("        done")
     script.append("    fi")
     script.append("fi")
-- 
2.55.0


