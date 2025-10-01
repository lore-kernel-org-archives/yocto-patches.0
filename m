Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064A7CCA470
	for <webhook@archiver.kernel.org>; Wed,  1 Oct 2025 12:00:02 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.15482.1759319996389412387
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Oct 2025 04:59:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h7C85Uyy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so48201975e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Oct 2025 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759319994; x=1759924794; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hqpFPn4PeJYBGLV1SBzbh6Bt/m2qKh6new9UVFY8rQ=;
        b=h7C85UyyFuhRQ25RCfaEmZvGjlJ6oDRfJcjzAyeKQEey2glAo6DNBpGSulf6sKr8Tr
         6PA1Ao5jmx7cB+YSUwbgkxRZ5RZS7vqKnnFwOXQvX/C/GqjX6ljNyKCJ3luRBPFrzU+4
         dhXdFIXIBgLW9svArg3n5miYEQl4C2Jo/iX/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759319994; x=1759924794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hqpFPn4PeJYBGLV1SBzbh6Bt/m2qKh6new9UVFY8rQ=;
        b=MavR6ScIjPN6jkg+cpaYrdClaID1K+itW4xlB+Q1w26PITQv0cgjHZzoid3M76LJh9
         Gh9HeRIZL6GFtQyNbG6/EHTMQLA4KEq7mqPi7eR3AbsG+7wXvKOaQCsbh7cCpNZe/3lT
         DickiUuk1wWRRDHX7tV9140RWcPpYwSCKp6cF83c1KoY4a2LIOAw89omCHR9Bukpok54
         wjeK4cZLoZga75s95OqOnmBMMhCuHPxTLbyg1X4mE/ESWOKX5/cam/Ob/zwCG6bR/R7c
         6WKDS5uYM930OBsOdtn+x6GcDA+SMpZB97omUCsS/we0U3LmNz9rYDJVhi6D+IXsezre
         aCag==
X-Gm-Message-State: AOJu0Yw7hFFdvaiKT9pInCR/7MZeGFTXrtqWQSrG0HLbgkDjBZLOXYfA
	idi5MvNtUDko4e8OoVbWbizAZcXMA8Ynn5YgXrLRAdKfoidjw4bcqPUYF4OEHnVhV/q1wTzHQxF
	7PNbm
X-Gm-Gg: ASbGncuKbi8VJbmgyPMbroioxmGfxVJvctEOw2BPo5TGwSkCP5HFueGzADS37mPisxy
	SG5HhZWxQ7Liuo7Mlt1zSTFLE0dCa6OdCeENGcNckAxI0BNz5G2kp8a5jgQ5tWXETTr8awvVq1W
	P9Av2uHh/U2pgZ91oD59J1ktS/rtK1YkloiQSnVOo7XA5pyGUrlUK2lW686odAkfnExgiFEVN5j
	PaGqYclF7TUqkkQkSyC2fSumIs64zCaR/A6lWA421HEZwA3t2xMdzQnNeuGLa51ZXCfmHFacxzo
	2VKKxPCvrKw73DMfyjELtZICQ/Hw+f9k5ikuWkd8WkrQfR82UE7WPrR/dQhrCw7pvZgU5V0aSB9
	mnF2M+ZbM4xQxjG9VigCck6ysCqAUqDTMKQnIgwMxvomv4U3Xqxn6GmtLv33xFyvOT3HGy54SiM
	Q=
X-Google-Smtp-Source: AGHT+IEdV0NJ01cCuUaBBi5m0YuBD4IC0goa4XWyIquQj+ax+qhitD1KzLS34/yPopYFtVrrlLGkgw==
X-Received: by 2002:a05:600c:820c:b0:46e:4882:94c7 with SMTP id 5b1f17b1804b1-46e612cb269mr26399495e9.28.1759319994114;
        Wed, 01 Oct 2025 04:59:54 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d53b:59af:db6b:d4f7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a16e13sm37505535e9.15.2025.10.01.04.59.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:59:53 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 2/3] config.py: Add fedora42, debian13, tweak auh workers
Date: Wed,  1 Oct 2025 12:59:50 +0100
Message-ID: <20251001115951.253600-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251001115951.253600-1-richard.purdie@linuxfoundation.org>
References: <20251001115951.253600-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Oct 2025 12:00:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2265

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.py b/config.py
index 5f4a7f6d..8c128ea3 100644
--- a/config.py
+++ b/config.py
@@ -164,8 +164,8 @@ web_port = 8010
 # List of workers in the cluster
 workers_ubuntu = ["ubuntu2004-vk-1", "ubuntu2004-vk-2", "ubuntu2004-vk-3", "ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
 workers_centos = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1", "alma9-vk-1", "alma9-vk-2", "stream9-vk-1", "rocky9-vk-1", "rocky9-vk-2", "rocky9-vk-3"]
-workers_fedora = ["fedora39-vk-1", "fedora39-vk-2", "fedora40-vk-1", "fedora40-vk-2", "fedora40-vk-3", "fedora40-vk-4", "fedora41-vk-1"]
-workers_debian = ["debian11-vk-1", "debian11-vk-2", "debian11-vk-3", "debian12-vk-1", "debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9"]
+workers_fedora = ["fedora39-vk-1", "fedora39-vk-2", "fedora40-vk-1", "fedora40-vk-2", "fedora40-vk-3", "fedora40-vk-4", "fedora41-vk-1", "fedora42-vk-1"]
+workers_debian = ["debian11-vk-1", "debian11-vk-2", "debian11-vk-3", "debian12-vk-1", "debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9", "debian13-vk-1"]
 workers_opensuse = ["opensuse155-vk-1", "opensuse155-vk-2", "opensuse156-vk-1"]
 
 workers = workers_ubuntu + workers_centos + workers_fedora + workers_debian + workers_opensuse
@@ -176,7 +176,7 @@ workers_wine = ["ubuntu2004-vk-1", "ubuntu2004-vk-2", "ubuntu2004-vk-3", "ubuntu
 workers_arm = ["ubuntu2004-vk-arm1", "ubuntu2004-vk-arm2", "ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"]
 workers_buildperf = ["perf-debian12-vk", "perf-alma8-vk"]
 # workers which don't need buildtools for AUH and are able to send email to mailing lists
-workers_auh = ["alma8-vk-2"]
+workers_auh = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1"]
 #workers_toaster = ["ubuntu2204-vk-1", "ubuntu2204-vk-2"]
 workers_toaster = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
 

