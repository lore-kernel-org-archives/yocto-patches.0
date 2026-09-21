Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC6CC982EF
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 00:46:02 +0000 (UTC)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40007.1789951557567213434
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 20 Sep 2026 17:45:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=eZr8DXoz;
 spf=pass (domain: konsulko.com, ip: 74.125.228.42, mailfrom: tim.orling@konsulko.com)
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c3304784so2105479a12.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 20 Sep 2026 17:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789951557; x=1790556357; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOfRFZ1pAeOGLZ2vuY2FyCFNOV7rdnmpSwtHL8/EtTw=;
        b=eZr8DXoznJL8DSe3NE4yI9uHFzVl6FW/X/ehP2heFkYSQwhtWsvMeA70YrptYoUDi5
         Jjlv8iUbrnS++nmr30U2GWYVYnxssRZBsAqFWF6OLhsXJTJA5dy0rGmCcN/wOL6rEyn9
         vqpw4aroyIujt+kiKwcID275MAjJKP4CNGm7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951557; x=1790556357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DOfRFZ1pAeOGLZ2vuY2FyCFNOV7rdnmpSwtHL8/EtTw=;
        b=LL/1bQv0XpP/NoG6aqdgg5YCwOAUZxrfpZKLYHkqvtU0kJN3w9JLZOaNAyNADqUPoq
         eRq7D3o/osX/LSP/2ZxzRfoDkq9hGvt1ufls0mWhJzYZzYcaCtf4Z+xluednc8n60K2B
         +IgsIaKelceYwlGRKKm8/NBEptnUPdrPi255TtkLfbUPD8AtgYH135sEhCN4v7lPdgqq
         3f5ahxUvUpzYJowVM8/o4TZsRt1orp90pgye1t9XT32TANAZtCU4/FxlhvWb7yShdVJv
         ll3n7LOp7JxqYhAn2SVm+fxDZ6hribeVnJbfkP+gaxbG9sDVm54D1Cx/fQ8waLeulZ6/
         x8SQ==
X-Gm-Message-State: AFuF++ng44lUhwMsjHKRBS8ma9AL1lB2ZI6igi1dSdxjydXzwiIvFdiS
	XuYYX4EYgMUTgcioiIEVqoEfpGNZZGRBU2+Qy391POEqqU2o93gn2QnDHFHPWCegrTDhROiyoZh
	LM2r1
X-Gm-Gg: AYBFou2L2LDnAL25YC98Twt730VYrHT99KWZSiaFSRaLM2lp0OYUReHcg2H8rPrVZY6
	s1DhvOykx8fuBk3RqTRCWveIEGv4rNeXL/YVYqaawIAEJegj1Pfm1z+VFnIwwnpFk6dC+NOAYYq
	n633MAhpvdE5azcPR2XsMYW//aPeYc+Dhc5uuyWyWZZi8id2LRoxDr1tMpL6gDYWCentMGufyXn
	lafjPXl/6u//YGGpW+QvbSy+nxGlCRYnzypgeqarhkt4xppanhAmI1Yrl+y9hRH6XWm9P8A8fUS
	1zaNHph/JCp8v8SON12WGz4PT1ZrT+Wdgic3mlHyzK3KxY+BYTkUfwmvZCBevfPNnEDGiaiKYnf
	BS0TOEFkQ/h3bI6A/8Z8dffrWif60mhytmqklnf5aYEcHsHrrtE2FFhXKukzfpr8mMVr11V0R8l
	HklvHSOuwDTg3tXR8nkU6k+XIHmzHwgtfKUlYDxYIgdkpaZPUbKwZfVPoIzehVWfz6e2cl87uKo
	QNuTzYRVj+TIz/zcIEESnQiog==
X-Received: by 2002:a17:902:a9cb:b0:2dd:c053:e668 with SMTP id d9443c01a7336-2ddc053e68amr51933105ad.46.1789951556763;
        Sun, 20 Sep 2026 17:45:56 -0700 (PDT)
Received: from thetis.home.local ([2606:c800:6024:2000:7821:4c5:938a:e12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc1803813sm24512385ad.82.2026.09.20.17.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 17:45:56 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [yocto-autobuilder-helper][PATCH 2/4] run-push-containers: Declare SPDX 3 predicate type for attestations
Date: Sun, 20 Sep 2026 17:41:16 -0700
Message-ID: <20260921004540.3718904-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921004540.3718904-1-tim.orling@konsulko.com>
References: <20260921004540.3718904-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 00:46:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4915

From: Tim Orling <tim.orling@konsulko.com>

cosign's 'spdxjson' alias hardcodes the SPDX 2.x predicate type
https://spdx.dev/Document, but create_image_sbom_spdx emits SPDX 3.0.1.
Pass the in-toto SPDX 3 URI https://spdx.dev/Document/v3 explicitly on
both attest and verify-attestation; for a non-alias type cosign embeds
the JSON predicate verbatim, which is what the JSON-LD document needs.

AI-Generated: Claude Opus 5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/run-push-containers | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/scripts/run-push-containers b/scripts/run-push-containers
index 3ed43ae..fd606c0 100755
--- a/scripts/run-push-containers
+++ b/scripts/run-push-containers
@@ -19,7 +19,7 @@
 #                              successfully pushed image is signed with
 #                              cosign (otherwise signing is skipped). Also
 #                              gates SPDX SBOM attestation: each pushed image
-#                              gets a 'cosign attest --type spdxjson'
+#                              gets an in-toto SPDX 3.x ('cosign attest')
 #                              attestation of its SPDX SBOM (per-arch on the
 #                              multi-arch path, top manifest on single-arch).
 #   CONTAINER_COSIGN_PUB     - cosign public key path; when set, each
@@ -69,6 +69,10 @@ cosign_key = utils.getconfigvar("CONTAINER_COSIGN_KEY", ourconfig, args.target,
 # Public key for verifying attestations; when unset, attestations are made but
 # not verified.
 cosign_pub = utils.getconfigvar("CONTAINER_COSIGN_PUB", ourconfig, args.target, args.stepnum)
+# in-toto predicate type URI for SPDX 3.x documents. Must be identical on
+# 'attest' and 'verify-attestation', or verification finds no matching
+# attestation.
+SPDX_PREDICATE_TYPE = "https://spdx.dev/Document/v3"
 
 utils.printheader("Pushing container images %s" % list(container_images.keys()))
 
@@ -269,7 +273,13 @@ sys.stdout.write(base64.b64decode(t).decode() if t else "")' "%s" "$_host")
         "    prepare_cosign",
         "    case \" $_ATTESTED_REFS \" in *\" $1 \"*) return 0 ;; esac",
         "    _ATTESTED_REFS=\"$_ATTESTED_REFS $1\"",
-        "    _att_out=$(oe-run-native cosign-native cosign attest --key %s --type spdxjson --predicate \"$2\" \"$1\" 2>&1) || {" % cosign_key,
+        # --type is the in-toto predicate type URI, not cosign's 'spdxjson'
+        # alias: that alias hardcodes https://spdx.dev/Document, which is the
+        # SPDX 2.x predicate. create_image_sbom_spdx emits SPDX 3.0.1, so we
+        # pass the v3 URI explicitly. For an unknown (non-alias) type cosign
+        # parses the predicate as JSON and embeds it verbatim, which is what
+        # we want for the SPDX 3 JSON-LD document.
+        "    _att_out=$(oe-run-native cosign-native cosign attest --key %s --type %s --predicate \"$2\" \"$1\" 2>&1) || {" % (cosign_key, SPDX_PREDICATE_TYPE),
         "        case \"$_att_out\" in",
         "            *\"already exists\"*|*createLogEntryConflict*) echo \"cosign: attestation for $1 already in transparency log\" ;;",
         "            *) echo \"$_att_out\" >&2; return 1 ;;",
@@ -279,7 +289,7 @@ sys.stdout.write(base64.b64decode(t).decode() if t else "")' "%s" "$_host")
     ]
     if cosign_pub:
         script += [
-            "    oe-run-native cosign-native cosign verify-attestation --key %s --type spdxjson \"$1\" >/dev/null \\" % cosign_pub,
+            "    oe-run-native cosign-native cosign verify-attestation --key %s --type %s \"$1\" >/dev/null \\" % (cosign_pub, SPDX_PREDICATE_TYPE),
             "        && echo \"cosign: verified attestation for $1\" \\",
             "        || { echo \"ERROR: attestation verification failed for $1\" >&2; return 1; }",
         ]
-- 
2.47.3


