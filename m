Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE80C83F09
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 17:11:58 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web10.1070.1751649115528243175
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:11:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JG4eAqXj;
 spf=pass (domain: konsulko.com, ip: 209.85.160.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a44b0ed780so13368641cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 10:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751649114; x=1752253914; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGf2RYiiySC/5mDRzwfx20QxCK8N7FWXFtnT1SjtCUI=;
        b=JG4eAqXjZ8lz6qyQI3eHz6tGlVydOD1dwlCBFixx6Div4a5dS8qJSrtQQ9M46I2szx
         rAgOiUEBmQrqiaZi5V4ZsSG2nKJQJO5g07N3yjwyFfiffzxemPsQwsQ2ZISGLE/dS6ig
         XGS9FMjeK4GsV/C0br3c1I5oMr61Adc0qE3ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649114; x=1752253914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGf2RYiiySC/5mDRzwfx20QxCK8N7FWXFtnT1SjtCUI=;
        b=oP50xT2ItvjPqFFF4cnsoLI1KOfX3o5kspF4ZuVnqSsT6xXznX8LNsVkPKdzUle46P
         TTtPePUPdV2KBLWdC8XfovDNNkzj5jsGKzW2V/FZ0UWNRovyilm2fWMGhX59h715gWg3
         +8VOwnElnezLhE21ncbpY8PG6FxyWdrj0YKltCagErt+P0Ipob1u//m0mFkvcqKJp2v7
         4ewRIIWzPta/aK+W4iIp3SC6S+ouCUXdsEOxGOk8PK117orLzT28UmHhUZSU9zsm2POh
         xvCpPF9CgEiIdQM8IdowEn4TZskgv1R/mNxE9SRsSK2n/wbOT9TjQhCp2NuU198yYpqp
         Ksog==
X-Gm-Message-State: AOJu0YxlUS5r360antXg6HPfmM2EBwaLcD4PjYSX4+m5J8lARnPfnZEB
	1j7PcSvHwCjg+Xvoy7IDITndRLCUjLmmJc3GTtMlM1ohQ4lZ19E3iTZTj2xhDMw9HuL9W+WGpMw
	Q8MJx
X-Gm-Gg: ASbGncuZAYXpKBdRuBH4WhukAujOeVlLPSzDo/BGScbamRyAaqJAVqUxHwrOnFVwbgu
	C07bMKsZb17xdPzhymOUadZ6EgT5HNZGOy2RZrfZS4XUtGdsD6Ws65XFHky/CMiAcAEe22HDMGP
	vXxHV+yRKvS+VcSnw73gjfHajwMDDRgTkphLOK43qhpDuJ2xmFms53zNedQ3KyUvK7dHYxl5mq9
	WoS7AplGSupp86z8aWdZU8zmp88uy7EPt9lEIGH75BSbisEBWxKtmnjqdWrbWgg7ujwmQGfwjEB
	/EJNzJwbWS8Z7nzAXTE7lA2Zc4dd53BILZ7mXdpKrZPnEKZgVi757WbKqtvf7KmUzeMRHzCQqh3
	l0hDCSIq8KEJ3Y9mS9AjePd2eTf9eLYkDfIqFAg==
X-Google-Smtp-Source: AGHT+IHpvnWsWdkrMM6NZzoU2ejMa+P2pZoVPD/3l58WLWWcQ8yS2Dq9O753I3egiQBzx0zZ7gKVQA==
X-Received: by 2002:ac8:5a8f:0:b0:477:c04:b512 with SMTP id d75a77b69052e-4a99647de63mr53636551cf.16.1751649114339;
        Fri, 04 Jul 2025 10:11:54 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949f99dcsm17249611cf.19.2025.07.04.10.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:11:53 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>,
	Scott Murray <scott.murray@konsulko.com>
Subject: [meta-security][PATCH 06/12] scap-security-guide: fix fetch
Date: Fri,  4 Jul 2025 13:11:10 -0400
Message-ID: <4822b91ef5d662cd1a63dd24b0c36ab6da732ddb.1751647559.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751647559.git.scott.murray@konsulko.com>
References: <cover.1751647559.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:11:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1758

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

The project does not use release branches; their release model currently
rebases the stable branch each release and relies on the release tags to
keep the commits referenced.  Until their release model changes, just
use the release commit with nobranch.

See upstream issue [1] for details.

[1] https://github.com/ComplianceAsCode/content/issues/13543

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
[tweaked commit message]
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../scap-security-guide/scap-security-guide_0.1.76.bb           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
index d5a9406..b9f7a70 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
@@ -7,7 +7,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
 SRCREV = "616d4363527acb61c6494a97f3ceb47ec90f65fd"
-SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
+SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=https \
            file://run_eval.sh \
            file://run-ptest \
            "
-- 
2.50.0


