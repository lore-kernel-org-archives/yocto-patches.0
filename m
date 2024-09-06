Return-Path: <dbaryshkov@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9FCE6FE4A
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 21:23:08 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.9869.1725657779291964086
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Sep 2024 14:22:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=reTBSZEv;
 spf=pass (domain: linaro.org, ip: 209.85.208.175, mailfrom: dmitry.baryshkov@linaro.org)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f4f2868621so28092321fa.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Sep 2024 14:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725657777; x=1726262577; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq9fdGaT+XydM8E0uX2aeb2RNftuR4Nz34x1Oj9a2Qs=;
        b=reTBSZEvoPt/YhcH6znmO3tuc5uFF3dcxgWDkZSQqF8Cra14c09KVdbqb2R2Oi9mRC
         v+UBYK1vfgLZymGP+1R9nXC6uTLpxYuZMf3ovs8dcW1Zz+Jz6AN1UnrXlek4wNiqPVqf
         nTeftvGfB/7A+lRJFDWSmM4eG2mAvbBuAZjjrm3D366h+rlQCaqhP6/fEZbqjE1++Hap
         AywpLjaRQkjOQYC1+0N5ZzbSYphD0OP+77MY/DwIvmFv7FmDBDXCqT7mlOZz9IwRaXsp
         YNdN1syEVDofkgFA9i4w1o3m5amsRjMfLrTjIuJjMvMD4W2rYQSRqhb0fnWeCZLt0UQJ
         5qDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725657777; x=1726262577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq9fdGaT+XydM8E0uX2aeb2RNftuR4Nz34x1Oj9a2Qs=;
        b=BgVcAK865eW3QxJTgQEM6YdB0qEQjMZ4Y/PWZ8AZ4F3rRGKcZ9wNgdFmiSkZHG4UIl
         IZBFUBXvXVoEgvLF603rucoC1s6uYVkbMdeVQH3g3XVeprL2FFUoxHanqHa+Yr1ae4TQ
         8wALjnvqZ5128J6MZ73wMzs+3HSwgT5cDDjzBXeUvoQxhmxL0oqnl38GKYPxtqaApONp
         vbuxgM+rV9humwSqUtKD98cjodQ3csHAlhGhfOwm+Xu4o8MHIhFtnhyLZBkoA6pllP3+
         zaKbqXGjCE0A5RoZnVyRzNLFjAW9VRty0dWNupJ1qHl1whfyp9IOXTZtMdX3Yi9rjP22
         8x3g==
X-Gm-Message-State: AOJu0Yzdlg8CPl3klxycxa+1Ql7nOmzzJ4NOvjXPWWFjKwLcTARiJ6PR
	gZeLokmFI92rSY/MV19DQ79TAJSVzkHRFVc6i3AYfJh+gtESfY0O9S4Yavtc0PpgsqfLGudLfpY
	0
X-Google-Smtp-Source: AGHT+IFVSYKMi53v96xBRMx7Tm2K7awNBAfYnx1UQRFfZBKqk5mipiBxyJrOO2sanImWN0d0VqUs4A==
X-Received: by 2002:a2e:930c:0:b0:2f6:649e:bf70 with SMTP id 38308e7fff4ca-2f751f2820dmr20534921fa.26.1725657776016;
        Fri, 06 Sep 2024 14:22:56 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f751f4538bsm3055201fa.53.2024.09.06.14.22.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 14:22:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] layer.conf: set LAYERSERIES_COMPAT to styhead
Date: Sat,  7 Sep 2024 00:22:54 +0300
Message-Id: <20240906212254.829031-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Sep 2024 21:23:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/618

OE-Core has switched the master branch to styhead, follow the change.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 4e04e5cc7e6a..c7f8dfb2a1b9 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -17,7 +17,7 @@ BBFILE_PRIORITY_selinux = "5"
 # cause compatibility issues with other layers
 LAYERVERSION_selinux = "1"
 
-LAYERSERIES_COMPAT_selinux = "scarthgap"
+LAYERSERIES_COMPAT_selinux = "styhead"
 
 LAYERDEPENDS_selinux = " \
     core \
-- 
2.39.2


