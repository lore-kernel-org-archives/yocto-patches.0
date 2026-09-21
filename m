Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C20C982E1
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 00:46:02 +0000 (UTC)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40006.1789951554935211090
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 20 Sep 2026 17:45:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hvD8oyD+;
 spf=pass (domain: konsulko.com, ip: 74.125.227.140, mailfrom: tim.orling@konsulko.com)
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso19896065ad.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 20 Sep 2026 17:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789951554; x=1790556354; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJiGDXwtCReAkKX0mbvc9oUfBAMKl9IAMAu5Hv73O0E=;
        b=hvD8oyD+hGA+99x5etj1DMGnwaRUdjg61ysJQu35jS0H+Ri94uDcVTRbZLec8szo1J
         MsJ2gk9/GISAGSADEmEF9sed8y56NdLnd9olu79FVIDsoHlu19AlCu4Yn1cMz+UOfKlo
         95M038TMTE53dC3FzzIQPfEnaWFx4YshrQ9Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951554; x=1790556354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HJiGDXwtCReAkKX0mbvc9oUfBAMKl9IAMAu5Hv73O0E=;
        b=g0Nak6d1wU1otOUohN377odfi/3qVp/OQr0R5pfrR1qnjyyQljllOW70ogvi98l9Yl
         RlX2e3L/wGu9l+g24jtZLNYUA0/Ig2WSVQ9Ny4he8/sPO7ADG3m1ya857rqilmzda3H2
         xtZokm2HwN0nP8UV66LqXeYva+HFNZeT3L5sfu1ZjyOzJtQ9jRsAeRjkAPaPlqjWbCFv
         K3aTsJhX8VLtxshCwYkRFg/MbMIwCFTSxIK3p9efRORf7hANzLr97OJJcoFBaUcGLKgb
         ZFiUmpBQj1xhVH7YeX2sIpRenVst0WdFOqm51wfMH4wfb4m+1uWoMKY9ul1zNhjPkYFE
         WCoA==
X-Gm-Message-State: AFuF++mK+oKpZC8GkzgqIycgNNrZgrQ3vwJgq10tVkrX8G8CrB7Ow5T6
	eUBzAgEtC0uychsqwD6RB5geyMQVHFCmpyjxnNdqILdL7Y3N/DLsTnzQAp/zarUFczM+4oFjUnv
	5xcty
X-Gm-Gg: AYBFou3RlF3lrj8g5Qs1+ycjKsxJf/TU4Qw6RSeRZ4aKf0EjMxw6+BdgirjPvgVJPvf
	RD8PU5IwPMs0FAKpx2SDbqPuEQCI4V24PWxDNGbGmm8yTZ9Hadvq0c+VM2HWBpi7ZDPiN177FjL
	AaUSx/z28kt01E0xHbgsFxj9TPpTIW10KrODPwjHtL9pmqlFH3hpbiNuyS5qzRPqFl4uLUE6e+G
	g4X5IUVvW7YuRb3LXxQNoFZP0sueG4GVcYOPfbcHws+UhjyvMdFf2PLc7mifAXoXRCmX25ql+zT
	uENw+GzsQUi38l+YwwwLHCtk+lIS/kcyCBtGp+17gwYz+TlmI21d2/0wn+QQ1NeSHeAxfSJW7rO
	B5QmewlwBK7tiiQIfZsb+VnadHS2AI5RCduSOC1l/hqaTtxdU7PK1lxEo+o5DeO+dtDJOcri/+L
	S6JTt09UzfvjT7hNmVoeP5B+BbIK032hhT1W+uOxcyz5lpISmf4UVqY12ZCotDbHO6RQM/NlBhe
	uSeUGa87hT78A==
X-Received: by 2002:a17:902:ce07:b0:2da:f1b1:56c4 with SMTP id d9443c01a7336-2ddb1ab3254mr148186015ad.3.1789951554199;
        Sun, 20 Sep 2026 17:45:54 -0700 (PDT)
Received: from thetis.home.local ([2606:c800:6024:2000:7821:4c5:938a:e12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc1803813sm24512385ad.82.2026.09.20.17.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 17:45:53 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [yocto-autobuilder-helper][PATCH 1/4] run-push-containers: Set COSIGN_YES to avoid interactive prompt
Date: Sun, 20 Sep 2026 17:41:15 -0700
Message-ID: <20260921004540.3718904-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921004540.3718904-1-tim.orling@konsulko.com>
References: <20260921004540.3718904-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 00:46:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4914

From: Tim Orling <tim.orling@konsulko.com>

cosign 3.x asks for consent before uploading to the Rekor transparency
log, which the autobuilder cannot answer:

  By typing 'y', you attest that (1) you are not submitting the personal
  data of any other person; and (2) you understand and agree to the
  statement and the Agreement terms at the URLs listed above.
  Are you sure you would like to continue? [y/N] Error: signing [...]:
  recursively signing: signing digest: user declined the prompt

Export COSIGN_YES=true alongside COSIGN_PASSWORD so both 'cosign sign'
and 'cosign attest' run non-interactively.

AI-Generated: Claude Opus 5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/run-push-containers | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/run-push-containers b/scripts/run-push-containers
index 5dd35af..3ed43ae 100755
--- a/scripts/run-push-containers
+++ b/scripts/run-push-containers
@@ -164,6 +164,11 @@ script = [
 # The real value, if the key is encrypted, must be present in the build
 # environment.
 #
+# COSIGN_YES answers the transparency-log consent prompt ("Are you sure you
+# would like to continue? [y/N]") that cosign shows before uploading to Rekor.
+# Without it the non-interactive autobuilder gets "user declined the prompt"
+# and the step fails. It covers both 'sign' and 'attest'.
+#
 # sign_image() signs by digest ($2) so cosign does not warn about signing a
 # mutable tag, while still pinning the index a consumer verifies. The digest
 # MUST be the digest the tag resolves to:
@@ -196,6 +201,7 @@ sys.stdout.write(base64.b64decode(t).decode() if t else "")' "%s" "$_host")
     done""" % (" ".join(registries), auth_config)
     script += [
         "export COSIGN_PASSWORD=\"${COSIGN_PASSWORD:-}\"",
+        "export COSIGN_YES=true",
         "_COSIGN_READY=0",
         "prepare_cosign() {",
         "    if [ \"$_COSIGN_READY\" = 1 ]; then return 0; fi",
-- 
2.47.3


