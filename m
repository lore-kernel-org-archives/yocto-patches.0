Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A67CFD376
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 15:26:00 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18455.1764343552900222282
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 28 Nov 2025 07:25:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IQn0XB0+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b379cd896so1162062f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Nov 2025 07:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764343551; x=1764948351; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IXFUXtcw9c3kdDsXT8oHLsXaGEetVDt0Ev235XXcjNo=;
        b=IQn0XB0+uMFSR0JQzuvShRnX3s54GE6L5EH7ZjsEy163j0XZnxpibWaMOJhPOGaYPp
         MnUTYlyqXKLp9EAoJupRBNBnVa0hk7MM/S789YPthPAhsLNo7TaqQ+qim8cQUrYFIXoh
         6ppCedHCSm0VXGof4CTdGVIzYmxLFzuwTePM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764343551; x=1764948351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXFUXtcw9c3kdDsXT8oHLsXaGEetVDt0Ev235XXcjNo=;
        b=pfhEtBGf2foyHIiTTYfARy5qdLHE4TJM+ckyaiWUcTGLcjGWGODvXqDwSSAjSREvcL
         mwz68aNSlVVvziIULxHMo67dk5q8u1pS3x9LPP/A/sO8XHYuA1B4owj4kAL8JaIyTwz/
         i/R8lsc1UQ6vbIBYqNijAAM8iy12edMzWsmFl79i9qGEq/PGK+jEVpn1sxXJuKqaLIiS
         9nNXAcnbptsPcJ9qHA0Gg3DHPX1f6spfAmzVaZ7uVQVcr02NgIi0F7JEJ29vhTd27CTu
         2sgV5+3jN0dvMXlwKIfozfQ6pGo5fuZapmAM/ygu9RpleVJLxs9+Cu1DQfhq/m50o6s8
         wyaA==
X-Gm-Message-State: AOJu0YyVM+cP086Rl8B9+WWZVrx+S/Hm/gOYkhSVxiufH7XhW0n2YrHS
	SVRy90/CB7zFWU/qCfyykCwgcbtROQ0Uo3REfpfhieejJEt4Ev6YfS3Qfeo40YthPSY7erJAXe8
	VL98v
X-Gm-Gg: ASbGncu1B/sMXYvsDPSrLK69+Dc3RezmaPzM/D7/7uIuUpUBEB1BszjASOoO3Ih1QtF
	/XNXvffvvhrfKWum9SVAkeL+Wf2t3jfODhzVxyXhjy2l73ICpcol6KR+el/YT00S9vBkAPGT50T
	sm5+Ux3zqey3mjXqY8uZoGtyw4Oa5/1ty4MrspSr/M6bOYjYeMv/kGfs6bPHqngllBcgQD2jM8y
	YCer2f5vtC8puyi5C3kZV2civQsCRGPipzN8TwM7GdyrIMlVNqLQBWejJNi7UoahGn4df5vv/3d
	G/sXMEaun+h1cHlRWbm+O183ISMwbgj5uXSGyFL9+eLVJ1H8J6oMfbLkxZnJBEsr/cRWuSvj39p
	zD4q6kRpcOK0ZOEOBtHE32HrMzYj2etZ0lybWXbWn0XZatmYaiuw4GnxGeHBcqnW/Qcyz98mwEK
	nxrXpwfRw/t9fnXMZlIISlGyXO5rK7XxjDn/8em/5RX1OBoI+lQQ==
X-Google-Smtp-Source: AGHT+IGsgxb6fO8viiCZDDC8+y2OXHsWxmoRenqeUf7FYzRqmpYk7SDs6s2EkNlMSNGFS7wAS+kNUw==
X-Received: by 2002:a05:6000:40e0:b0:42b:4081:ccec with SMTP id ffacd0b85a97d-42cc1cbd1b9mr26708642f8f.18.1764343550566;
        Fri, 28 Nov 2025 07:25:50 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3dcf:5b4d:ee74:653b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c302esm10134595f8f.5.2025.11.28.07.25.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 07:25:49 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json/utils: Update buildhistory mappings after poky -> openembedded-core transition
Date: Fri, 28 Nov 2025 15:25:48 +0000
Message-ID: <20251128152548.1080908-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Nov 2025 15:26:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2730

The results were not being stored correctly since the mappings needed updating
after the move poky -> oe-core.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json      | 2 +-
 scripts/utils.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.json b/config.json
index 0cce282..53481cc 100644
--- a/config.json
+++ b/config.json
@@ -5,7 +5,7 @@
 
     "BUILD_HISTORY_DIR" : "buildhistory",
     "BUILD_HISTORY_REPO" : "ssh://git@push.yoctoproject.org/poky-buildhistory",
-    "BUILD_HISTORY_FORKPUSH" : {"poky-contrib:ross/mut" : "poky:master", "poky-contrib:abelloni/master-next": "poky:master", "poky:master-next" : "poky:master"},
+    "BUILD_HISTORY_FORKPUSH" : {"openembedded-core-contrib:ross/mut" : "openembedded-core:master", "openembedded-core-contrib:abelloni/master-next": "openembedded-core:master", "openembedded-core:master-next" : "openembedded-core:master"},
 
     "BUILDTOOLS_URL" : "https://downloads.yoctoproject.org/releases/yocto/milestones/yocto-5.2_M2/buildtools/x86_64-buildtools-extended-nativesdk-standalone-5.1.sh",
     "BUILDTOOLS_ARM_URL" : "https://downloads.yoctoproject.org/releases/yocto/milestones/yocto-5.2_M2/buildtools/aarch64-buildtools-extended-nativesdk-standalone-5.1.sh",
diff --git a/scripts/utils.py b/scripts/utils.py
index a4de27e..b472451 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -26,7 +26,7 @@ def is_a_main_branch(reponame, branchname):
     includes master and release branches in poky, while excluding "next"
     branches
     """
-    return reponame == "poky" and not branchname.endswith("-next")
+    return reponame == "openembedded-core" and not branchname.endswith("-next")
 
 #
 # Check if config contains all the listed params

