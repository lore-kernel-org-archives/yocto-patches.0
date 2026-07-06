Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75E0C44500
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:07:24 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.162445.1783375642618904001
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:07:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=N50PWKxj;
 spf=pass (domain: gmail.com, ip: 209.85.215.170, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso2509447a12.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783375642; x=1783980442; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7JfXDxZREHAPUlsc7o966yQlfqBpuufpNLSUeatE+H8=;
        b=N50PWKxj3GvpSFsOJQEYsmWGAGUbC7MRdg1sB+zaOtfwiwgF6aHPv6mRA8xM62iqrv
         r6CF+TAo/Pbp25qnrjP29Yn+ZmzIstX43qt2cbwXatGHl5eG7ahUq9Ok2KLtehBQJsE6
         ub2Ks4Tf0fVHyEJlHU09VDa31LNPtNo4t32UaD0aO2VZhtdKl4knwC0BDAFP+OTX5hTt
         ztNUbJK/4mOfF/w7PmWhUhYbmqtOyW0fscIdwrpaiDp/bYCJ4LwqXcfMEtveoP1/IH+P
         qC02j0/EUOHWk2EXXNoe5uswE/doaPgXr4dLNTjMR72jnDV8NRZVawGfmXVcK+iKC/TN
         zqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783375642; x=1783980442;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JfXDxZREHAPUlsc7o966yQlfqBpuufpNLSUeatE+H8=;
        b=Oqk0fsmRyBp4/JR5eYaHFgvK2cKkttrvY5cqxlegKE1Y0b4RtyJaMkacTj9mZWkbfL
         N6xK1tXDBJkEfMMiVNDoyeQEjCQOK3kemMkaPNNTfZ7fXvwu3V1dmp/9gGGVBl0wnTbH
         5z1sfASRNtHWo5jOkqyDsTVWgV74+aQdJpYES1DRIaUJfcYdKXlQSTRrCDaXDeMxptPB
         JmM+QVfS9z/yXMRqbSkl7DUectPo4h3g3y+ekwoejXhLxnLj8cYuE9fmt+lBQvpykFJq
         Ati8igd1Bn5kHBoYJwIjohZYaHAPvkJXRq6js1DuCzP2JyFnmdBTFXPNNrZNrzo9s0VA
         L8cA==
X-Gm-Message-State: AOJu0YxMYK2QfFYz+rizaII45j2lW0EJa8SOiMMLmCAGfAYXBiTlkOPV
	45XwV7ctfjtH+xv3hNT8jkQ3lv5PZP6NC+ALMBMsKzRXypdcZ5DDyUIJoTO9+A==
X-Gm-Gg: AfdE7clXBlrFrrb0RrnkvhN7YIku5gDjne999hnC0T7bBj+jNtUJgp33211aNFzWxsY
	FHJ4xVh+5e2eMWIgG+PJRctS3AOV1QOlZExeJuiFSsxlfCL0mqVL3BMAi6pMQdo7JnNCOGC2mcR
	Cvh0fMtJJbJdZAUbnCrwavpK5Idrwmh6J7j/2bEqCiP2Hb+nghpKDfZ8brVtk4f/o+7emQ5W8Gp
	6XkCOoIFDTc6MT/HwbRDZarCgaFGu4Eq/ikVjHkc6YE/9xhuIUd9Umr9M56/rc6JpKPid0IzzQt
	UiXqwvQlXq2ItIfqKZH/CO62yFoK6DIoafWn3DH01sFYK/+bSnaC7/YkYugC3vXqQ3C3z/6dLyV
	EuBej14tojN7+HcIqkTXhjzBFgFJ8EwL2cKyfjcqwUOOzbQICyw+05Zkwu4xGDkgecp5P+KB6Hm
	1q4l0+mgK5g6ni19+H9gcDRvwCDCliTFg6GJJh9ckZK0pF0yA+jggYpCpHOQ0s6nCck/vR9a5J0
	E9qHdDEpv7m
X-Received: by 2002:a05:6a21:a94:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3c08ee4f340mr3007352637.33.1783375641864;
        Mon, 06 Jul 2026 15:07:21 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d5b95sm84720a12.3.2026.07.06.15.07.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 15:07:18 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v4 11/11] run-push-containers: optionally push -dev tagged containers
Date: Mon,  6 Jul 2026 15:05:43 -0700
Message-ID: <a461cb0168da2143aade22ce1d34fab5d1ba1954.1783371914.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783371914.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com> <cover.1783371914.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:07:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4441

For containers which set PACKAGECONFIG 'dev', push additional
container images with '-dev' suffix to the tags.

Inspired by dhi.io (Docker Hardened Images).

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/run-push-containers | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/scripts/run-push-containers b/scripts/run-push-containers
index debf83f..5dd35af 100755
--- a/scripts/run-push-containers
+++ b/scripts/run-push-containers
@@ -327,6 +327,20 @@ for recipe, image in container_images.items():
         # oci-multiarch; doubles as the multiarch marker and
         # the OCI layout path for skopeo below.
         "_OCI_MULTIARCH_OUTPUT=$(echo \"$_BBENV\" | awk -F'\"' '/^OCI_MULTIARCH_OUTPUT=/{ print $2; exit }')",
+        # Drives the '-dev' tag suffix below (dhi.io convention: same image
+        # name, tag suffixed) for recipes built with PACKAGECONFIG:pn-<recipe> = "dev".
+        #
+        # $recipe here is the BBTARGET from CONTAINER_IMAGE_MAP, which on the
+        # multiarch path is the container-image-multiarch wrapper (e.g.
+        # container-image-multiarch-app-container-nginx) — a different PN
+        # than app-container-nginx, so 'PACKAGECONFIG:pn-app-container-nginx'
+        # never touches its PACKAGECONFIG. OCI_MULTIARCH_RECIPE (already
+        # extracted above) is the underlying app recipe name and is what
+        # PACKAGECONFIG:pn-<recipe> actually targets; fall back to $recipe
+        # itself for single-arch recipes (OCI_MULTIARCH_RECIPE empty there).
+        "_PC_RECIPE=\"${_OCI_MULTIARCH_RECIPE:-%s}\"" % recipe,
+        "_PC_BBENV=$(bitbake -e \"$_PC_RECIPE\" 2>/dev/null) || true",
+        "_PACKAGECONFIG=$(echo \"$_PC_BBENV\" | awk -F'\"' '/^PACKAGECONFIG=/{ print $2; exit }')",
         "_EXTRA_TAGS=\"\"",
     ]
     if version_recipe:
@@ -348,6 +362,18 @@ for recipe, image in container_images.items():
     script.append(
         "_TAGS=\"%s $_PV $_DISTRO_CODENAME yocto-$_DISTRO_VERSION $_EXTRA_TAGS\"" % " ".join(static_tags)
     )
+    # 'dev' builds (PACKAGECONFIG:pn-<recipe> = "dev") push under the same
+    # image name as production, with every tag suffixed '-dev' (dhi.io
+    # convention), instead of a separate image name/repo.
+    script += [
+        "case \" $_PACKAGECONFIG \" in",
+        "    *\" dev \"*)",
+        "        _DEVTAGS=\"\"",
+        "        for _t in $_TAGS; do _DEVTAGS=\"$_DEVTAGS ${_t}-dev\"; done",
+        "        _TAGS=\"$_DEVTAGS\"",
+        "        ;;",
+        "esac",
+    ]
     # Detect multiarch vs single-arch per recipe and push accordingly,
     # but only for an image whose build actually produced its OCI artefact.
     #
-- 
2.54.0


