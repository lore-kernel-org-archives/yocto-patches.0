Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB9DE6FE33
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 16:59:26 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web10.4015.1725641962205546641
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Sep 2024 09:59:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aCPQWHOr;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f4f2868710so24067461fa.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Sep 2024 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725641960; x=1726246760; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9tYC/+0BHLnQ0kL04keOdpPtj5KuHs2StvvEMipLmI0=;
        b=aCPQWHOrpvkg1lzWbEjLz3evcRTq4KvpT2r8Um3GRZnYyfuO5wxdNVIrEGkwTqrace
         Hh8RgINcBDMigvw93DoKfQ8ZYfszE7g/v0njhXqZdkXfTDDjfub+XKeOGmYMpoonW3y/
         PamqY5M5M+13LI5IHqdoRmv+VsSLuAJqsHCTENUQLMPD7On8FE/C2zOZWYSwcIImQ6fJ
         4JQeeCJJeoXc2L+ectzp7SjsOmnibMOfQG2cgiFiCE2vM08N2z3joAs4DglGqiYgpD1q
         xQy4Kgt7/DP1NkTCXkvv8V61gmNlHSEsgO5SKG26NrExlclYwn78xRDEpMlFw84d7h9i
         QDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725641960; x=1726246760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tYC/+0BHLnQ0kL04keOdpPtj5KuHs2StvvEMipLmI0=;
        b=nAdIHwMY/q+oycnY6q6fTurG89rH9GjGvNz3gdBkty3PDx3ytc30p0kXYKJ/MtkBPq
         3LcxWQQ+Mi9yQ6U367HOHQdv/+EuaCdp8tDmPvTCzGmW9enydXOtCB6C1PTIQsjQP8b1
         g0M97jMIluYK/mmqhqtYNIaxYWBLP5q+y0PZcJaYejNRfY5V6UQaNcAT36ub3qOKxi0Y
         zn1xNX2m44dC86CYS/RrGqFGvElRFjQchZXThQCKWYuAgatS5Y1j+7Ew11lmXrln1m0o
         aPzRdfbjLST3i3MbxyYYbEYOCIg95LtA4gzag5YVfXIDn8e2hLzDEJc9tjowXKTNDMzO
         tHRQ==
X-Gm-Message-State: AOJu0YxpyrsmZB3GzW2ELm4y5yVmZXz5LwMC/CtRK32ARUbmL6/XvDEp
	qHSELIuhCbFYeqeM1p2s04ssJ8eOyQdwAZE7HKSkbXFCXvv+eDb6ERT65Q==
X-Google-Smtp-Source: AGHT+IER6YAIaJ5o6neHK+RG+Ydt+xvqLsM92SE+EZGi5Kb9HxllhSoYqkttEbTt9gFvJbYWGgHucQ==
X-Received: by 2002:a2e:be1f:0:b0:2f3:d032:4489 with SMTP id 38308e7fff4ca-2f751ea776fmr22876271fa.8.1725641959425;
        Fri, 06 Sep 2024 09:59:19 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc551397sm2641519a12.38.2024.09.06.09.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:59:18 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-rockchip] [PATCH] layer.conf: Update to styhead release name series
Date: Fri,  6 Sep 2024 18:59:11 +0200
Message-ID: <20240906165911.3777945-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Sep 2024 16:59:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/616

oe-core switched to styhead only in:
https://git.openembedded.org/openembedded-core/commit/?h=styhead&id=b4cf6d5236a3eacaf56ca2f805b006efac65b26c

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 03914d2..9e89132 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -14,7 +14,7 @@ BBFILE_PRIORITY_rockchip = "1"
 # This should only be incremented on significant changes that will
 # cause compatibility issues with other layers
 LAYERVERSION_rockchip = "1"
-LAYERSERIES_COMPAT_rockchip = "scarthgap"
+LAYERSERIES_COMPAT_rockchip = "styhead"
 LAYERDEPENDS_rockchip = "core meta-arm"
 
 BBFILES_DYNAMIC += " \
-- 
2.46.0


