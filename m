Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E45CCFA04
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 19:51:44 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4854.1762285899771381415
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Nov 2025 11:51:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Kg1A/CUd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.216.49, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so3192274a91.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Nov 2025 11:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762285898; x=1762890698; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8Wm1oe5smaEmlrD81WQQvPlZDmME6uAd+MLlOjN6fE=;
        b=Kg1A/CUdizfPC62TLNyCnpcIbSAXv85lYW7cR2dkwTg3X+yHXoXQwdNSJdYEkSiEDm
         cc6c/MUR3IKCnPDl2VUiAw1Q41J0aRErvHKe0/80I+EWKxOBTxSTI7I3KJni1toKe+MJ
         bUU3KM+qWebMdJIDxjDSmTCvITvZWoUybcvMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762285898; x=1762890698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8Wm1oe5smaEmlrD81WQQvPlZDmME6uAd+MLlOjN6fE=;
        b=CkC1XagbkRfKcE32whSMm3LgMxm/b/sKDOvF1bu+Hs/sxbXyuiLW1bTJVe2VJaKmsQ
         ejB73u+JGE/tgPC5EBgLLo4eM6WJDMtxoqtRatUzrLUj4x2V9fLQkHfHs4BDYgZt83Kj
         RNqKtR5ZRiv2fTd0cXqFWBWoULNGercILJPmVW1S1KHhHKAMPsfpG7v31dDPg/epTB1t
         6uaBy+zGGPZPQcoLxJqLgEFeRj5CdKJKuidSjJoE+JZmco9QcTNXfDW5wwZJnhIyCNm3
         FbxpLiAvtRur7XCaaBEh3R1g/FKWbKrgKFhcffH08XGFdwApJBbMHftOu2nTTerjP82Q
         1NsA==
X-Gm-Message-State: AOJu0YyzdrL9waHq+RWOr3NwxDdMvPCHxxBRSLdvqrhmrQ68Yo+aAuQq
	FlSskLNU0lHORq+LC0iWr0hnCzCmGyHRXzoBg5cpfg+Ohcty82m3wFqv/WC04hgJaB/FBXgvfST
	/T45C
X-Gm-Gg: ASbGncvqmrnu9XF1nD70Zkleq80pIr6VwYgDHiUO5ltz+FCbANd5jrmEClfptrPgasU
	XA4KdAKPyJWPEAbaaFDPjxNSavbf/IUPjH2WyhooamzDulBo+78ChM/6o6CJIsrog1LYK5AJHZY
	BJUThXnUwTYnj53ZFDR6IeSYfqPZhOXtQwAGufUHQRRcDXA+LlB2fylftRUw3TfDmCQrvzB+6FS
	X1HoOVdIE+RRaiDAs1+3l6E8iZhVQbNFqCj9vrn0+Wu0MnARsxEGCi7FTBMOByCcd1GJwxgCICX
	E7+g+MesY35hTOOLZm+wDOKRbgiSc4u1zPNfyxgF8nelsi5KH6KXmiziNTNzV/QAbLZoY3Nypci
	m3+sHHY27PPTmRgcr9pdX8w0zMgDM03sZPiaZLqxhqsPg6IhGESphjm+JYoasvHLVmd+ZERFR7g
	Hoph6OD8/Sqj3TF/YOY6kH8k2CNPROaCN4FnVRzMUv7Q==
X-Google-Smtp-Source: AGHT+IH0OOH/jd4MUnX4Fh9jirbJN77pvXIYxMyoEXw5F85X76IJ6nve15QDhaGZLfNRkae1c/D5BA==
X-Received: by 2002:a17:903:2347:b0:276:76e1:2e84 with SMTP id d9443c01a7336-2962adb29b7mr10119355ad.3.1762285898265;
        Tue, 04 Nov 2025 11:51:38 -0800 (PST)
Received: from yoctolap.taild15c8.ts.net ([138.199.43.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a39ffbsm35467855ad.62.2025.11.04.11.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 11:51:37 -0800 (PST)
From: Michael Halstead <mhalstead@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>
Subject: [PATCH][yocto-autobuilder2] config: add ubuntu 25.10 worker
Date: Tue,  4 Nov 2025 11:50:41 -0800
Message-ID: <20251104195041.28829-2-mhalstead@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Nov 2025 19:51:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2420

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 config.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/config.py b/config.py
index 19e85ce..82c1200 100644
--- a/config.py
+++ b/config.py
@@ -162,7 +162,7 @@ publish_dest = "/srv/autobuilder/valkyrie.yocto.io/pub"
 web_port = 8010
 
 # List of workers in the cluster
-workers_ubuntu = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
+workers_ubuntu = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1", "ubuntu2510-vk-1"]
 workers_centos = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1", "alma9-vk-1", "alma9-vk-2", "stream9-vk-1", "rocky9-vk-1", "rocky9-vk-2", "rocky9-vk-3"]
 workers_fedora = ["fedora39-vk-1", "fedora39-vk-2", "fedora40-vk-1", "fedora40-vk-2", "fedora40-vk-3", "fedora40-vk-4", "fedora41-vk-1", "fedora42-vk-1"]
 workers_debian = ["debian11-vk-1", "debian11-vk-2", "debian11-vk-3", "debian12-vk-1", "debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9", "debian13-vk-1"]
@@ -172,13 +172,13 @@ workers = workers_ubuntu + workers_centos + workers_fedora + workers_debian + wo
 
 workers_bringup = []
 # workers with wine on them for meta-mingw
-workers_wine = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
+workers_wine = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1", "ubuntu2510-vk-1"]
 workers_arm = ["debian13-vk-arm1", "ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"]
 workers_buildperf = ["perf-debian12-vk", "perf-alma8-vk"]
 # workers which don't need buildtools for AUH and are able to send email to mailing lists
 workers_auh = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1"]
 #workers_toaster = ["ubuntu2204-vk-1", "ubuntu2204-vk-2"]
-workers_toaster = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
+workers_toaster = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1", "ubuntu2510-vk-1"]
 
 all_workers = workers + workers_bringup + workers_buildperf + workers_arm
 
@@ -226,7 +226,7 @@ builder_to_workers = {
     "auh-meta-oe" : workers_auh,
     "metrics": workers_centos + workers_debian + workers_opensuse,
      # Have gitstats and gnuplot
-    "metrics-gitstats": ["ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"],
+    "metrics-gitstats": ["ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1", "ubuntu2510-vk-1"],
     "toaster": workers_toaster,
     "default": workers
 }
-- 
2.47.3


