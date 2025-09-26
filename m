Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71693CAC5B8
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 15:55:13 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.20936.1758902110265469316
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 26 Sep 2025 08:55:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=K3/VCAte;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee155e0c08so1381435f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758902108; x=1759506908; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GCRJ03DC+wEwW2nAO8nkvKmi0yo+3k47LU9gCMqyECs=;
        b=K3/VCAteHgwLjn5h8mm9qrITAIaj1NlBPDCQ2l1z4CYxraEGpF/T6utgIeqM/P7o4l
         9fYbR3JkomifpKyiQ5kRrD/Qhb5+ZmsfQ8E1jMyp5Ikjqe1hqtqZ+SsPqLI4yzcVw7X6
         sJsULFSSNNnDDVIU0fF0ntEpV0WSyZkZqPi1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758902108; x=1759506908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCRJ03DC+wEwW2nAO8nkvKmi0yo+3k47LU9gCMqyECs=;
        b=PQbMEjFeKbeb5JXTVI8A4RdJOo8yfhynQ6xj+QIv2qypLcfCTjtBfoIHFsmZXmGGYa
         R3iRjg9gkhsN2HqsyZxDDobs+nWcZqONAdadV3t+WOQnAdAsNh535GUszhX8lXIQkmBZ
         g1gH/DbAeLXK0LLcRcpA7EM5tXKrHA2LiXzFzHOCBXNY05VxzJnWIdKoqK6+rtNJVqSo
         CvB2S/s8sCNxN9CdFG6i39fp4JP3r02iRWuk0X+oULEv6yrL38sbtV3AMKMKWL6BB0ON
         mbafApo6ylW3AFZVyNpLFY8jO/xQ9d7JZ3VlXTzp9+j2VNPEt1TNExkBJ59PPqigc5gX
         D1nA==
X-Gm-Message-State: AOJu0YziAfetFc2VsZ+Ownon2IZe3/7RmKDQqhMdvTB15wP3dyxVUH2A
	FrYbWE3lXbEfxPT3lppSZ/3VmtzTVNuybVLixNxTA+sZ8arZS1XUgOq9Jvm0HwOIOHgvpXqSKvg
	NR6M5
X-Gm-Gg: ASbGncv6svs7ClU3jeL0nwQleIfGxUshgSuggMKKc1quqX01t+ywOim2eX37RgSg051
	F0r0QCaMiwPlAyj1XRtHk0gBam06hMY5oaGhNtN11ROrocP+mzXrL/hbXqqZNoCBI1f7aoRcMWM
	i4pI93hhitmBSt57n2wf5NMxjnSCKo8SIxrGlkbH4fwfdt4CBqviBSkMoCtqgG0cz890+r2698L
	h57FlUT7gIIlB7Q943L/sV28k8g6m+BBk9gfwv8cKdpIj/LQZFl+XUPe+ZTE7dH0JODUjkdnwdv
	XnA6TrOuBGPNCXzZUx7RmsmpD5sh39TVvljRkY0JtKumVwXRu0tddhLkSnM6EUgNCvg5AJnzuLn
	I39uAypWEP6zeDsIPd4n8DAygTUaqeIsDrWNkosSsUgqt17bQOUE=
X-Google-Smtp-Source: AGHT+IHzrhe01Hmtarck9tCAmQqBP8xY8u5wAAQZ4KEIjlGO8cRFpPQcrPSqnZeAs8o4tl3I00DrfA==
X-Received: by 2002:a05:6000:290a:b0:408:5363:8266 with SMTP id ffacd0b85a97d-40e4bc23f4bmr7887132f8f.44.1758902107847;
        Fri, 26 Sep 2025 08:55:07 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8a7a:1fb6:e6df:2fa7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7e2c6b3sm8060728f8f.54.2025.09.26.08.55.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:55:07 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] config.py: Drop meta-qt3/4
Date: Fri, 26 Sep 2025 16:55:06 +0100
Message-ID: <20250926155506.26751-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 15:55:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2237

These haven't been used for a long time.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/config.py b/config.py
index b578d6cb..1b14538c 100644
--- a/config.py
+++ b/config.py
@@ -56,8 +56,6 @@ repos = {
     "bitbake": ["ssh://git@push.openembedded.org/bitbake", "master"],
     "auto-upgrade-helper": ["ssh://git@push.yoctoproject.org/auto-upgrade-helper", "master"],
     "meta-qt6": ["http://code.qt.io/yocto/meta-qt6.git", "6.8.1"],
-    "meta-qt4": ["ssh://git@push.yoctoproject.org/meta-qt4", "master"],
-    "meta-qt3": ["ssh://git@push.yoctoproject.org/meta-qt3", "master"],
     "meta-mingw": ["ssh://git@push.yoctoproject.org/meta-mingw", "master"],
     "meta-gplv2": ["ssh://git@push.yoctoproject.org/meta-gplv2", "master"],
     "meta-patchtest": ["ssh://git@push.yoctoproject.org/meta-patchtest", "master"],

