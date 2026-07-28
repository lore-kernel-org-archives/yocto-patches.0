Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5898BC53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 01:41:47 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2397.1785202904180994443
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 18:41:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=f3rgXmOb;
 spf=pass (domain: gmail.com, ip: 209.85.210.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84861fc51f5so2599705b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 18:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202903; x=1785807703; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2kZqLcIhUdmdBGX6T1eXHtWfAhJvixU83AG8CnGFqYE=;
        b=f3rgXmObcHU7ogrjXpBQuvWo4fNyW6zZNOq3o3xkFrgu/O3UXgfVD5BxYz0TP+OE2D
         s3gjUd0bhtUzlwb1BoboNQbmBjLxsqetTtaLknhLnHIhPUsoqZ5l4hzZdgw8FnmtbAsz
         YJkGwhXm9q09CBli6LiZU/+M+ai0tKuEp4vBx/y0cuhl2FvNdzTSlZvAJPrHfhZpeZ7s
         HmqKVCBnASiS/bfdgecdTUVDfIFCnFQYQgPuL3RlpUy+UVvbiXVTDazgjifvRhnMYUG7
         OmTmgX7Ltr6PiNTNYLWcWBb0vPxZ+93FuW3MhObM+1RWt+3cu+tQVt5otMuY3h3h7Z+E
         8WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202903; x=1785807703;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2kZqLcIhUdmdBGX6T1eXHtWfAhJvixU83AG8CnGFqYE=;
        b=gZ8Dq44zTmL+1qiBHmpWDfG9QpN1xCCD/7bqBvD/kZDqLT9FntdeLsMc69qmsP+3WE
         IaH1Hy7Y+YrUkXlNEm5Ka9X4CmiurwybshZE8Wg5+CKU/RErmdoZj5aIsGqjU/nFoqMq
         +SRFjjQr3N7n7JNyJ8bkpvav/EZRKRT2X5o1DWz4PwDl5uC5rdmbtG16W2DyGqvqY7VL
         2LnBRbnXL/WIZgg/wz/PAyyQl+wwKmJhG0XJsbpO8xK389glrn4CPLpT6sbPl2dXPXHU
         KInFedfkR9tM7EugxqEbrLB50txYvuVXxnNKROJg8QZ55EOMuglY+9qJ5CXQSgMgh+5u
         MyxA==
X-Gm-Message-State: AOJu0YyzsGYZpQIH0+9i8YDLeLPPGxB2pBAHlqB8CviUs/ZKIo2dYE7p
	FnG5ELHK6SE+4gHRVc175eP04cHVNF8tqqXI3VsjH4VOqQNPfMpL2CjLq+5dyg==
X-Gm-Gg: AR+sD13bB+EyIH81TapJm2Qnk8LQzwAMDEeBO1jjfayyav5byEG2KlCmHsgh72xlWsY
	ftPCkwOVBv+eAqmthMzSm3FaMLjIwXyRMPJGHvZpksfbaZqNh0/hgsGavWSQbT79fOAW2id8Tem
	jHtxM80waSrPWfGcuYb6C1RPOZaLZhN5p1Daak7xefrKZKng1gJWrH6QSDPTuCn/IYLcInM8KS3
	DJA5toQ7wUpl6M/+wHZt4qf7c8GiJpr45AecSrzpotvdNEtX0Clfg9493pqLJnO4BdLqQGhR2Pg
	1HFZ66yTYPjevnv+EJzSUnmeW85u8o4KpKkWf7IB0/D0KH2k/j2C8Ztr/ZzezKIfKTfeI2m20vR
	0htcfuOKHgK9CMmUPDLjK11krSGLqxW5FQ0z0obOURik3FGmjOKz5vqv8HH3aUXqy9Sc07nYUsr
	QxGDp7jRXd8WZK0tkaW8pa9G0Ba9IZXVIHhnnIMUNwI3tcmesyIEraiPDXuSfvLOeUzcGIVJUws
	cIpmH/2acDk
X-Received: by 2002:a05:6a00:10c6:b0:847:83bd:6671 with SMTP id d2e1a72fcca58-84e93225c16mr255668b3a.19.1785202903514;
        Mon, 27 Jul 2026 18:41:43 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm3661537b3a.58.2026.07.27.18.41.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 18:41:42 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v5 11/12] run-push-containers: optionally push -dev tagged containers
Date: Mon, 27 Jul 2026 18:40:44 -0700
Message-ID: <1fc1f15f2f6c7b0c370cf2218f2b4d3d460347b9.1785198322.git.tim.orling@konsulko.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4550

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
2.55.0


