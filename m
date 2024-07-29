Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4367BC3DA61
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 16:50:00 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.60582.1722271790568613531
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jul 2024 09:49:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=DScpMfGB;
 spf=pass (domain: snapchat.com, ip: 209.85.214.177, mailfrom: ecordonnier@snapchat.com)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd69e44596so21841665ad.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1722271790; x=1722876590; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fxx32wEK9uTF+S/yVZGF46Hzifl/tRAfMLDaQnLTLQ=;
        b=DScpMfGBQqDyNWqZ+hcn+kJ1q0mqfgEqvAeBkMOZgLpMKcC8lPTlP/CV7OlYs5Cn8o
         89hdYKmyELE4EakDejTX0seestun4Zmo9RNwt66ZYFgzXkW0ztZvrSP2NiuTdzA8U7Aa
         CpfSk/FDhi7mRXJjB8nOBsyo67QivhJENMpok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271790; x=1722876590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Fxx32wEK9uTF+S/yVZGF46Hzifl/tRAfMLDaQnLTLQ=;
        b=Cq+RZ39TvqQ5wVzA2k44Zx+omu4rLV7admt0BKL29fvqMTNbxQUh2rwUP3PKyGY7KX
         NdL/VCYhVulIzEt9FMVn2YUrvdI35NtnrgMh1fcXS1cmowtCHY08QZsTZZY4hd2mRBOf
         msQC4MfWn5jxqFP4mtPFyQd5kYk8/jXduE/MBIFAsMkOaZE7TTYHTv67YttWjDM65MmB
         0d2lKG8qqGtLvY7xND+c08Kfyn37tce6B/W8zfec727wWz8ITY+RVt/iiFMJ+zP1DLgb
         /CwJ3+9rXcMxVrJOIvpzDp+38DPkTXzH2jObGXh6Yc1YyXIr1QUZiAE6j7bme7cRxXjS
         clOA==
X-Gm-Message-State: AOJu0YzecMHNiFTzCP+bE9Nf6ZhPQQYKnjnLLBj3IjbtynrU52whYsRQ
	DrGN96Df+JiiT9OcC7DrIYe0QKaPXLQJDNpKXHUz0q60CcxYD6yS5Fj2OhzPO5OLD7aSJbQwOvo
	FRqU=
X-Google-Smtp-Source: AGHT+IERfMXSYAAhb3BlKV7laV3qJ3RO8Md2IScA0Y3q6B+bQbHACMokgxHfSLWHFEh2fVLVpC5erg==
X-Received: by 2002:a17:902:ce04:b0:1fa:2b11:657d with SMTP id d9443c01a7336-1ff04a42e5cmr120636055ad.10.1722271789546;
        Mon, 29 Jul 2024 09:49:49 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fc8102sm85094365ad.280.2024.07.29.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:49:49 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 2/2] Fix patch Upstream-Status
Date: Mon, 29 Jul 2024 18:49:24 +0200
Message-Id: <20240729164924.145828-2-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20240729164924.145828-1-ecordonnier@snap.com>
References: <20240729164924.145828-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 16:50:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/497

From: Etienne Cordonnier <ecordonnier@snap.com>

This causes a build error when ERROR_QA contains "patch-status".

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../automake/automake/0001-Remove-ar-D-argument.patch            | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-devtools/automake/automake/0001-Remove-ar-D-argument.patch b/recipes-devtools/automake/automake/0001-Remove-ar-D-argument.patch
index e66b5ad..6e27448 100644
--- a/recipes-devtools/automake/automake/0001-Remove-ar-D-argument.patch
+++ b/recipes-devtools/automake/automake/0001-Remove-ar-D-argument.patch
@@ -6,6 +6,7 @@ Subject: [PATCH] Remove ar 'D' argument
 Poky patch "automake/0001-Drop-ar-u-argument.patch" adds the argument 'D' (deterministic mode),
 however this option does not exist on MacOS.
 
+Upstream-Status: Inappropriate [OE specific]
 Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
 ---
  bin/automake.in | 2 +-
-- 
2.36.1.vfs.0.0


