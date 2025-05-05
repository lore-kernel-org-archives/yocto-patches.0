Return-Path: <emailaddress.ashish@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7B2C3ABB9
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 09:22:55 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web10.46124.1746436974767445971
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 02:22:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hyBPefFE;
 spf=pass (domain: gmail.com, ip: 209.85.210.177, mailfrom: emailaddress.ashish@gmail.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73972a54919so3800146b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 02:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746436974; x=1747041774; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/EkaZoqweWApJSgy4y1hE4cEDUiDlLwmBU9HWXKOUE=;
        b=hyBPefFEyMdSRPWkMH5AXQSq6F28p5qolNEgcmn1xeiRL2Dk5d57Si5KVyH/u3XhnG
         7NvtKQus6kaGUCAVLeS5nSfRdVitK8KYvB+W+g0YAthNbSDi2xEUgf2qnzLH7S5Yx6Ci
         NPA+sV/K7dldYdjW8dHEzHIJB/jUhRdgGGgN/63idW9i/SbQna7K/PT6Y5WYN9Q0zzhz
         vwBtc5AUIa2l6zpySOv5dx2IvJfS0/ELsAz2xAjq+5+Ck3ZzmCqlz0tv8arzppQd6KK2
         O82yIsxW5z5Cr4p9J0Lryj1gxe4uHToaVKH8iLOcHhRGfltaeJK5SxrKCLB2fl4a3nf1
         Evjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436974; x=1747041774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/EkaZoqweWApJSgy4y1hE4cEDUiDlLwmBU9HWXKOUE=;
        b=hvkth6sMoKdAvvpwa/phcOIhkTotK4mtWZNFQcoLF7jK6vVQqI/3BKpArcOf48PaWj
         vVaw+/tv6ro1C7qtr/xh1aHtm8zokS/5XZxPvfzuL96blCHW1q4lJT+HS8cB4RPtQtRi
         pbJaPX5uFE95LySGY/mlSLe4BBWCLJt8ly9iVNWJCZWX2jGQu1zAz/f8aCUSx6DBiKlC
         Ax5IAEBIQYmBACbU/k6fTrE6BAmLU4XeuVmHq6QqciPumtO9pRQD6xDJwa5xOxQalVm/
         EC3WI5LvpClkUHdf4JXqDgRVFOem8AxVBHNGBQHMS24QPhgVKGHvIA2E9z8QRJRi2wte
         1oqA==
X-Gm-Message-State: AOJu0YyqayRgJF/XnCT2Bx/xAROhnceT05x4Lq2LEJ70H0+Xoadl+Vis
	aAOi2g1qtiMPbVJv9kwRSzrqsGciLhSlVjClw8J0SBRyLoBY4deb2QYHaA==
X-Gm-Gg: ASbGncte1wgz2Ul3YpBUy/RD/yqYZ1hakJFJLDHbREdfOQbEjSOZqB4i4rdhQcY3Pd8
	Lwf8p0KSZiCNQb4FHmvrmd3kLVrEE/xDuRdT/OeVvLPqEfmK3z3tN/JE/HK9Xg7cm/vMM2J0zPE
	0alKoIumDa1vVT6vJmxqamzIvimFQX+Ec+mJKYrvciT6cahlPXRJ62U9n4Tag2n1LhLtINKE8Ys
	D7kJaGBqtzUNcfx6A8Uirm+KXJP69vZQf54SLe3yfE+rD7tYfcVuG+IrDDW57qVBQ/RR5Smdw/q
	rkcNYff5RAEDCOw2WYpy8Z9XSV1o7zM6eyJZ/ouU7DD7TSoGqX8l
X-Google-Smtp-Source: AGHT+IErXMzZS/Ac1a/3R1eIEzFISRVCbkiqwxCpBjHBwscHH0P0KfduU1kSFD3K7YRNDwtrrVkwhQ==
X-Received: by 2002:aa7:9a84:0:b0:736:3979:369e with SMTP id d2e1a72fcca58-7406f0b0e9fmr8655283b3a.9.1746436973770;
        Mon, 05 May 2025 02:22:53 -0700 (PDT)
Received: from MVIN00210.. ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm6487611b3a.98.2025.05.05.02.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:22:53 -0700 (PDT)
From: Ashish Mishra <emailaddress.ashish@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Ashish Mishra <emailaddress.ashish@gmail.com>
Subject: [meta-java][PATCH 4/4] Updates the SRC_URI for fastjar recipe
Date: Mon,  5 May 2025 14:52:38 +0530
Message-ID: <20250505092238.853811-5-emailaddress.ashish@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505092238.853811-1-emailaddress.ashish@gmail.com>
References: <20250505092238.853811-1-emailaddress.ashish@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 09:22:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1496

Signed-off-by: Ashish Mishra <emailaddress.ashish@gmail.com>
---
 recipes-core/fastjar/fastjar.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/fastjar/fastjar.inc b/recipes-core/fastjar/fastjar.inc
index 8412236..97e79bb 100644
--- a/recipes-core/fastjar/fastjar.inc
+++ b/recipes-core/fastjar/fastjar.inc
@@ -7,7 +7,7 @@ PR = "r1"
 
 DEPENDS = "zlib"
 
-SRC_URI = "http://download.savannah.nongnu.org/releases/fastjar/fastjar-${PV}.tar.gz"
+SRC_URI = "http://download-mirror.savannah.nongnu.org/releases/fastjar/fastjar-${PV}.tar.gz"
 
 inherit autotools update-alternatives
 

