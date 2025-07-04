Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE55C83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 17:12:08 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.web10.1076.1751649121373627455
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:12:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Zxprmjip;
 spf=pass (domain: konsulko.com, ip: 209.85.160.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a5903bceffso16569171cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751649120; x=1752253920; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1SnTX3DMhNFVDPSXroIv0Luy/aL7cfHWxkS+CAFaPU=;
        b=ZxprmjipBh/84pCC7yGnE8LdjMt2amenZbe9rmM2qxC/Vp/6Q3ZVPQhw+yldupr+R+
         Pl/EVwBHDcJjF7qgmOq/8wsLu4pTHBQQjyIkfkfeKg5WHBEtD7Y/R2JJhs940mGhw77/
         MKTXywHd5+rfUMzsY9zWCa89HNP+VLZTxbPsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649120; x=1752253920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1SnTX3DMhNFVDPSXroIv0Luy/aL7cfHWxkS+CAFaPU=;
        b=gX9Fp4gXk1rfxcUVmEcZFnKFlWo2TKND1MZQndVfhZSo7tK89W9oh4t9SOuLbSgSG1
         JxILRCxWq6EQwgr/cLEAUdTxCBTWZ1E3r4kjmVcI9b/V4QsLMa9qjOZgKGILVuGJfuGR
         2pjbyNBbRF6FU8VPcHc3Su1fTSBYQFzXh+T7RB/9kh5ahhFV0U0XXsm30IvRn39cwB+2
         w0rPN6ch5VJnC77ERFvUbjvXkPwsMpx+zQE9Xk/d3G3xYeABawxbDVlIUXKZ+5IFDjKK
         eMpE9aWaNdVhXJ6bOkfNDTewYzaxbX1H+aUIfWRkTFNf8cwxSgmM7xVwdVbPjlbRDt7Z
         ZkhA==
X-Gm-Message-State: AOJu0YzTpBBNttlYLyZKaXn4p6fty/oXn8QspnSVl1Knbh4AJJPXUgJC
	FL9f28q94qJGLVu7ggSZAV3mvCH3kDUtZwlZQB0ywtoAW5HnwBBHlGaZ4tUFGWYcHl7BlVxtSxG
	3/dXZ
X-Gm-Gg: ASbGnctlyhNiUCJd/ipHn3GMuWcM5+RNp5Y4vl/gk5VJ6an2SJvXfJX64O//dUNvQ/M
	wO/mWrEGPr3Giin+hRxaI014g0iMjDWq2aaNw97zTuci7NivVBlAwAbGjSD7UXF5VPnfPVUmsEy
	lGf0elVTyeoK3VaJPZVV0mRS6akG+1D+c8wGnuJPQ232PW/nhcJ2L42n4WUKwIxGYFPIPs1Bdiv
	WfduifFqmc+f0fWi40Ru9LScQ1LA752CZJxmLygjw+qbdXcOGwaE7WMhaTpPpVzckMsRxwDFWLP
	MVNKFrNIcQx1USIHz826I/TpA4amFyjQPjEsM2DqlMIktqHGdkLcZMkZwjJ1l094/+j3PrLNCHg
	j/r4dE1hwu13yjMWL/ZGXun7LZ5DDLHHak6hjzA==
X-Google-Smtp-Source: AGHT+IHgndsDnKhBbDtWJxJcoJwOzNvPgsHJHhq+a14ZlcfKOkBibTH96vdSn6W9Y0Zx5WvGLCnFpw==
X-Received: by 2002:a05:622a:1988:b0:4a9:9428:6f01 with SMTP id d75a77b69052e-4a9968579ccmr51288761cf.51.1751649120012;
        Fri, 04 Jul 2025 10:12:00 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949f99dcsm17249611cf.19.2025.07.04.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:11:59 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>,
	Scott Murray <scott.murray@konsulko.com>
Subject: [meta-security][PATCH 11/12] CI: update build for new CI
Date: Fri,  4 Jul 2025 13:11:15 -0400
Message-ID: <7cabe4fa2b992f525d17c493146edd8fdb2d9578.1751647559.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751647559.git.scott.murray@konsulko.com>
References: <cover.1751647559.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:12:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1763

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Update for Ubuntu 24.04 runners:
- use venv for installing kas
- add missing directories

Assume that python3 and pip are installed.

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .gitlab-ci.yml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 46ab4a9..32ce2b9 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,10 +1,12 @@
 .before-my-script: &before-my-script
     - echo "$ERR_REPORT_USERNAME" > ~/.oe-send-error
     - echo "$ERR_REPORT_EMAIL" >> ~/.oe-send-error
+    - echo "$CI_PROJECT_DIR" >> ~/.ci_project_dir
     - export PATH=~/.local/bin:$PATH
-    - wget https://bootstrap.pypa.io/get-pip.py
-    - python3 get-pip.py
+    - python3 -m venv ~/kas_env/
+    - source ~/kas_env/bin/activate
     - python3 -m pip install kas
+    - mkdir -p $CI_PROJECT_DIR/build/tmp/log/error-report/
 
 .after-my-script: &after-my-script
     - cd $CI_PROJECT_DIR/poky
-- 
2.50.0


