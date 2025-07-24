Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FC0C83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 07:27:21 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.6898.1753342035822891656
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 00:27:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BvNuPZFL;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: rybczynska@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso405199f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 00:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753342034; x=1753946834; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw30muO6xHZBsG+VnfSnUZ1lN73Y/WEe7ubXx9XY7bo=;
        b=BvNuPZFLZ6u12m1Ja9/6rVd8bcXrPHmT9+Q+0PulOY4aorwzixwnDdtcE6CYWf/19q
         B7YK35/HDGAdOj+Y2GoISCbNQznYK4G52AlvyMUr4XekANSnGqOn4YdijHEFdHpNZ5uC
         9fDDuhQa9Ml/T1AVpHelNFtT6mueGXp3imkAxj/3dOcWBQIt+pSY71WbUyAB+SoOJoN8
         tKOVrtjDNcchT5Gcxa4CUzuqjIWGZZ1Oo0uh+yrfxSz504+DlLP86bO0t+N9hfxlPin1
         4vi9E4xBh1u9/HHeS/h1upaRjxEG1LVhL3i/059Hg2vbAHfXakaq6koEqpi0K+QIcNK4
         2CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753342034; x=1753946834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fw30muO6xHZBsG+VnfSnUZ1lN73Y/WEe7ubXx9XY7bo=;
        b=UHbDQxb1IX0cDO+DCp4u6gRqsQxIPyqQMRaWCa3T8YyHY8KpdGx1pAQCh9D5033I32
         hf5nvC5RNz6wOMAguB+eEwoZgJAL9qRPOsIm7gmhzyIoxFGjy6g2GDQh/sQ3+qBZ1+TC
         FVaFghGJFNUD/Ns8nzmF71JbiINR2Q3TziIV0X8oZ5ixhdDGwKR02VH5X8p0X3M4jNi/
         MhOIGDKonT8WT8fMsfni5RJ3fmyhCkWsZ8oZhOpWdHK75HQJtiKXVoLtFIA1tZX/Tf7F
         U3rXsK1iQc37eX+nQH0FyrLdpuv5EO5GJPEpl/M9xw7T2yumHnttafeQ0btHRxeU7Qr/
         csfg==
X-Gm-Message-State: AOJu0YxzApaq2Yphd378NTVWQqemr/Xlzlezvd4nBSJK7Q9kVOKAJ1v7
	g1Vd8ZZkTwp04xi3HEIifuItwwH28ZBOuUNhq1e3SprwJUtw+QezKL+3U/I7KA==
X-Gm-Gg: ASbGncsWP6B3hzK0IbaA+R4lXBdKgTE0p5YGlvw8TN1C6panji3eTUaVTy5XRpI4Ki2
	rMPJmaBgBQ8jAncq5m7Dxz9CVMBbKiPTVH8zK0UXuUObaobTBTCCy34Fz6JYSvsv2QenkJNbtpC
	uzEeNF/Xo+c59UTG23W9J9/ByvDv7+ZoPDOyg9xDwHEjkMRRu/KdgsmMz8CLGQv4wnX8u1GAaxi
	5KsGDYS29MR/zDU3sYV4XmMnFojCs1My1YPf9SmugifaxongDFTEKapgw8zuXTPJrZFlNiZejP5
	Spsaf48658XKy3WIAkooRERZzHaJJa+Y8U32MCO16kqrFMDfSV2hIfz8JfIM1cuUZ60M/BvnNhx
	Uaws9ybldTzpPKrNq9X1yhHUGbFycBl8dSkQ=
X-Google-Smtp-Source: AGHT+IGm2K5TryP51KTzz4eliPCeYMIIEnb93hGzwchP49kPYZUr8CSPIHCmIImlyAAIzjK+gyOedg==
X-Received: by 2002:a05:6000:26cf:b0:3a5:2cf3:d6ab with SMTP id ffacd0b85a97d-3b768f076dbmr4727864f8f.39.1753342033574;
        Thu, 24 Jul 2025 00:27:13 -0700 (PDT)
Received: from voyage.lan ([2a0d:3341:cd4f:d110:cf6f:2013:cd74:cf4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm1231723f8f.44.2025.07.24.00.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:27:12 -0700 (PDT)
From: Marta Rybczynska <rybczynska@gmail.com>
X-Google-Original-From: Marta Rybczynska <marta.rybczynska@ygreky.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [PATCH 1/7] gitlab-ci.yml: fix file redirection for qemux86 build logs
Date: Thu, 24 Jul 2025 09:25:43 +0200
Message-ID: <20250724072642.7358-2-marta.rybczynska@ygreky.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
References: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 07:27:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1858

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 628b0e6..80b2dfd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -59,7 +59,7 @@ qemux86:
   extends: .base
   script:
   - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k security-build-image integrity-image-minimal" 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_security_image.txt
-  - kas build --target harden-image-minimal kas/$CI_JOB_NAME-harden.yml 2>&1 | tee CI_PROJECT_DIR/log/qemux86_harden_image.txt
+  - kas build --target harden-image-minimal kas/$CI_JOB_NAME-harden.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_harden_image.txt
 
 qemux86-musl:
   extends: .musl
-- 
2.47.2


