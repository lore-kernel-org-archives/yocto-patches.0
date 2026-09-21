Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6998C982DA
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 00:46:00 +0000 (UTC)
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39803.1789951559853327545
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 20 Sep 2026 17:45:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kw9hpMHF;
 spf=pass (domain: konsulko.com, ip: 74.125.227.170, mailfrom: tim.orling@konsulko.com)
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df4c9d14b8so432775ad.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 20 Sep 2026 17:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789951559; x=1790556359; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RmAxzzCY1yLb1VROhCPO4RSJ+hZHk7Vyp0imBoE9Yzs=;
        b=kw9hpMHFGOue85BOkriqWzLh1JXqByDZFqbkfXflLnAc0d40iTP9K0ZnvADaFPhSTm
         +HQG2aDJxiizqnYpeDBmqWGCNIXD9TR3GN3wDTTTtmKSvcscnT45QJeW9DDDlBngtd70
         NI87zynQ3RMT3mNMb433oxErP2QcUlhyPYti4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951559; x=1790556359;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RmAxzzCY1yLb1VROhCPO4RSJ+hZHk7Vyp0imBoE9Yzs=;
        b=gAGMpFefXlOroLEzwU3My7vjI3ifY1y1/94GCnvjCUbON6MmW2oLT5LuTnz06cH32m
         L0r5m5HXbTHmisTU149eg7G6lFuhDNuUtanDPf8qNzEHxQoPxo+olgDbCRJDgNPw78aC
         Xc22k2ZEnGS9ROOYZ7F+Msm6IB+MyphHfaiTduHKMJYzNI+22TaCUsvvPUtCdwiC8Qe6
         0S5COcJT+tKBfRK9zYsgRjTygnxj5VdRXi3ANrw7Q4YpHcO0g4O0OwMjWDQExzXp5Z20
         7uUP/6KYPc2+HfpvPHJVk1LHObmiMkIRFvtwXDyTa4hJQl3vQcDDuB37l9vas69QCSM7
         QCcQ==
X-Gm-Message-State: AFuF++mmWNv0wELZdC8WFLyQEXV6FhFpLUCYWpPKMFqA5+H2ir4kuabN
	S7er0ixNFz8xOYRFxJxbzIFX+xAfYbyorbNu2b+3Hngm+eySyShL8RNC+mKLzzL99y62aqGMSIQ
	SAk+w
X-Gm-Gg: AYBFou31ELjJFAJrECdm5Ny7QUWG8pxS4ZOGjiTQp9Ea+x1o17qx/S8enVeWJvWI+4R
	eK/Ja4pC3QfDaa0vmxygJbynigmb0HzwWWUfc6zn6klsmFE9mEUysXvih/1rs9qtsUi2zD/pXrp
	BPmgN9teJumEDT+lhuWJsSII0m3JfUMouN0u/hZeuA7U/PZ9Quz8frLkycVsKaTkl9unD9IUa6M
	rqgccrReWZ8lDJutMxLTdKVvFCcQZt5WgA1YAsT+UYamvsrdMTeIkjxA6RUF8illHAbQ9isn7Kz
	C6KLMnm8X6OzqTKjpGOoyQVrbxMOe18wLR7DlppkR5FOP1PFContdi07GQ5RAKhyPtiGB1OtC52
	pqHUMYWa1+6B7ZCACLLqYD8JvegazYJ1g22SYh04Wqo7n7IGG6T+sMJzNo6Yv4m/YssDXA597Xe
	wIqWHMkC9zeQmeT1Hx6Ijs8MUzyyUR3dYmB23lMQdBuFkeao9MTnJOh/sqqnhYeuqac2Gu17Wzw
	CauyCTC8HLt5A==
X-Received: by 2002:a17:903:1b6c:b0:2dd:c053:b9c7 with SMTP id d9443c01a7336-2ddc053ba17mr58692465ad.24.1789951559191;
        Sun, 20 Sep 2026 17:45:59 -0700 (PDT)
Received: from thetis.home.local ([2606:c800:6024:2000:7821:4c5:938a:e12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc1803813sm24512385ad.82.2026.09.20.17.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 17:45:58 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [yocto-autobuilder-helper][PATCH 3/4] run-push-containers: Cache native sysroots to cut bitbake startups
Date: Sun, 20 Sep 2026 17:41:17 -0700
Message-ID: <20260921004540.3718904-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921004540.3718904-1-tim.orling@konsulko.com>
References: <20260921004540.3718904-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 00:46:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4916

From: Tim Orling <tim.orling@konsulko.com>

Every oe-run-native invocation re-runs bitbake-getvar to locate the
native sysroot, paying a full cooker startup and metadata parse each
time. Resolve it once per tool in prepare_skopeo()/prepare_cosign() and
pass OECORE_NATIVE_SYSROOT through the _skopeo()/_cosign() wrappers.

For one multiarch container with 4 tags, 1 registry and 2 platforms this
drops bitbake startups from 19 to 11.

AI-Generated: Claude Opus 5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/run-push-containers | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/scripts/run-push-containers b/scripts/run-push-containers
index fd606c0..702335b 100755
--- a/scripts/run-push-containers
+++ b/scripts/run-push-containers
@@ -138,10 +138,16 @@ script = [
     "    %s-$(arch) --config %s memres restart </dev/null" % (runtime, auth_config),
     "    _VM_STARTED=1",
     "}",
+    # oe-run-native re-runs 'bitbake-getvar STAGING_DIR_NATIVE' (a full parse)
+    # on every call unless OECORE_NATIVE_SYSROOT is set, so prepare_*() resolves
+    # it once and these wrappers pass it in. Empty falls back to the query.
+    "_SKOPEO_SYSROOT=",
+    "_skopeo() { OECORE_NATIVE_SYSROOT=\"$_SKOPEO_SYSROOT\" oe-run-native skopeo-native skopeo \"$@\"; }",
     "_SKOPEO_READY=0",
     "prepare_skopeo() {",
     "    if [ \"$_SKOPEO_READY\" = 1 ]; then return 0; fi",
     "    bitbake skopeo-native -c addto_recipe_sysroot",
+    "    _SKOPEO_SYSROOT=$(bitbake-getvar -q -r skopeo-native --value STAGING_DIR_NATIVE)",
     "    _SKOPEO_READY=1",
     "}",
 ]
@@ -201,24 +207,27 @@ sys.stdout.write(base64.b64decode(t).decode() if t else "")' "%s" "$_host")
         fi
         _cuser=${_creds%%%%:*}
         _cpass=${_creds#*:}
-        printf '%%s' "$_cpass" | oe-run-native cosign-native cosign login "$_host" -u "$_cuser" --password-stdin
+        printf '%%s' "$_cpass" | _cosign login "$_host" -u "$_cuser" --password-stdin
     done""" % (" ".join(registries), auth_config)
     script += [
         "export COSIGN_PASSWORD=\"${COSIGN_PASSWORD:-}\"",
         "export COSIGN_YES=true",
+        "_COSIGN_SYSROOT=",
+        "_cosign() { OECORE_NATIVE_SYSROOT=\"$_COSIGN_SYSROOT\" oe-run-native cosign-native cosign \"$@\"; }",
         "_COSIGN_READY=0",
         "prepare_cosign() {",
         "    if [ \"$_COSIGN_READY\" = 1 ]; then return 0; fi",
         "    bitbake cosign-native -c addto_recipe_sysroot",
+        "    _COSIGN_SYSROOT=$(bitbake-getvar -q -r cosign-native --value STAGING_DIR_NATIVE)",
         login_block,
         "    _COSIGN_READY=1",
         "}",
         # Resolve the lone manifest digest of a single-arch reference. Correct
         # only when there is no manifest list (single-arch / child manifest);
-        # the multi-arch path passes explicit digests instead. oe-run-native
-        # prints 'Getting sysroot...' to stdout, so grep the digest out.
+        # the multi-arch path passes explicit digests instead. oe-run-native can
+        # still print 'Getting sysroot...', so grep the digest out.
         "resolve_digest() {",
-        "    oe-run-native skopeo-native skopeo inspect --authfile %s --format '{{.Digest}}' docker://$1 | grep -oE 'sha256:[0-9a-f]{64}' | tail -n1" % auth_config,
+        "    _skopeo inspect --authfile %s --format '{{.Digest}}' docker://$1 | grep -oE 'sha256:[0-9a-f]{64}' | tail -n1" % auth_config,
         "}",
         # Track digests already signed in this run so the same artefact is
         # signed only once (see sign_image).
@@ -226,8 +235,8 @@ sys.stdout.write(base64.b64decode(t).decode() if t else "")' "%s" "$_host")
         # $1 = <registry>/<image>:<tag> just pushed; $2 = its digest (the index
         # digest from 'skopeo copy --digestfile' on the multi-arch path). When
         # $2 is empty (single-arch), resolve the lone manifest digest with
-        # 'skopeo inspect' — correct there since there is no list. oe-run-native
-        # prints 'Getting sysroot...' to stdout, so grep the digest out.
+        # 'skopeo inspect' — correct there since there is no list. The digest
+        # is grepped out of resolve_digest's output (see there).
         "sign_image() {",
         "    prepare_skopeo",
         "    prepare_cosign",
@@ -241,7 +250,7 @@ sys.stdout.write(base64.b64decode(t).decode() if t else "")' "%s" "$_host")
         # transparency-log conflict ('already exists' / HTTP 409, which also
         # recurs on rebuilds that reproduce the same digest) as success so
         # signing stays idempotent instead of aborting the step.
-        "    _sign_out=$(oe-run-native cosign-native cosign sign --recursive --key %s \"$_SIG_REF\" 2>&1) || {" % cosign_key,
+        "    _sign_out=$(_cosign sign --recursive --key %s \"$_SIG_REF\" 2>&1) || {" % cosign_key,
         "        case \"$_sign_out\" in",
         "            *\"already exists\"*|*createLogEntryConflict*) echo \"cosign: $_SIG_REF already in transparency log, treating as signed\" ;;",
         "            *) echo \"$_sign_out\" >&2; return 1 ;;",
@@ -279,7 +288,7 @@ sys.stdout.write(base64.b64decode(t).decode() if t else "")' "%s" "$_host")
         # pass the v3 URI explicitly. For an unknown (non-alias) type cosign
         # parses the predicate as JSON and embeds it verbatim, which is what
         # we want for the SPDX 3 JSON-LD document.
-        "    _att_out=$(oe-run-native cosign-native cosign attest --key %s --type %s --predicate \"$2\" \"$1\" 2>&1) || {" % (cosign_key, SPDX_PREDICATE_TYPE),
+        "    _att_out=$(_cosign attest --key %s --type %s --predicate \"$2\" \"$1\" 2>&1) || {" % (cosign_key, SPDX_PREDICATE_TYPE),
         "        case \"$_att_out\" in",
         "            *\"already exists\"*|*createLogEntryConflict*) echo \"cosign: attestation for $1 already in transparency log\" ;;",
         "            *) echo \"$_att_out\" >&2; return 1 ;;",
@@ -289,7 +298,7 @@ sys.stdout.write(base64.b64decode(t).decode() if t else "")' "%s" "$_host")
     ]
     if cosign_pub:
         script += [
-            "    oe-run-native cosign-native cosign verify-attestation --key %s --type %s \"$1\" >/dev/null \\" % (cosign_pub, SPDX_PREDICATE_TYPE),
+            "    _cosign verify-attestation --key %s --type %s \"$1\" >/dev/null \\" % (cosign_pub, SPDX_PREDICATE_TYPE),
             "        && echo \"cosign: verified attestation for $1\" \\",
             "        || { echo \"ERROR: attestation verification failed for $1\" >&2; return 1; }",
         ]
@@ -419,7 +428,7 @@ for recipe, image in container_images.items():
     for registry in registries:
         script += [
             "        for _tag in $_TAGS; do",
-            "            oe-run-native skopeo-native skopeo copy --all%s --dest-authfile %s oci:${_OCI_MULTIARCH_OUTPUT} docker://%s/%s:${_tag}" % (digestfile, auth_config, registry, image),
+            "            _skopeo copy --all%s --dest-authfile %s oci:${_OCI_MULTIARCH_OUTPUT} docker://%s/%s:${_tag}" % (digestfile, auth_config, registry, image),
         ]
         if cosign_key:
             script.append("            sign_image %s/%s:${_tag} \"$(cat \"$_DGSTFILE\")\"" % (registry, image))
-- 
2.47.3


