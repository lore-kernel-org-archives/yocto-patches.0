Return-Path: <yanis.binard@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D53410F6FB8
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 14:57:43 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15340.1775055459126794756
 for <Yocto-Patches@lists.yoctoproject.org>;
 Wed, 01 Apr 2026 07:57:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=gOQSji2v;
 spf=pass (domain: smile.fr, ip: 209.85.221.54, mailfrom: yanis.binard@smile.fr)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso3181287f8f.0
        for <Yocto-Patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1775055457; x=1775660257; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G68EKVztDoOUNbXpdUpCxnwpkAWAPo0Fdni7JFSgBZw=;
        b=gOQSji2vTXN/kLyewDZ0OE3X5Oqg7IovVi4LIh0ZgmlvQ5+haz2VaU1jk7AXjCc2k3
         ooiq/4g8KBNzJ+AhpBNk6Wi//JoIYvyQaVp7Bl00coWzpta/s5OHFUHZhNITBGr2dY2d
         FO4uquJwNj0zfAPWswSPePqdBYZu3HtPZaaMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775055457; x=1775660257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G68EKVztDoOUNbXpdUpCxnwpkAWAPo0Fdni7JFSgBZw=;
        b=ZWlnMrvMtoncm5y/cAhgL1VDuyQMyTjkxux3r86GVkvj++7F155n2nn/NoNrFbpVOg
         Xr4sskPrVbxys92a7IZcKyszhJL2TN+dIdc5BV+cINMK3sWAcRUIM85rKSCp7BiwvSBS
         nGGfkFYG4h0BoXNf5xL2bqHXawtC6kvcRxwMQOukQf4aYpNH6lqYq8+Ih4A4Z7UCO8iX
         r+tPxd6VVGSQgUuUpMNnu+668UFHFo0f7BIuvWyhud9Poy1DM0L8ffAvv1n06y8voL41
         Dp7jKDdNSEZ4sNIiMedAxRrsWRjUJ9xuE1ZM8HpbZRIEXVxNPGlGoJCQ7fM25NtcCO4v
         AE1Q==
X-Gm-Message-State: AOJu0Yxfh8UJYWgMkNlspm31bTtFR6cO1TjpJAOJkmNoDjPsYWc6ZR6k
	x+k8BCX38Cxk1CzVsZQxdWTthP1Jquy3kUaK5vLBwDJ4sl4h2dT9ZpM2QFb8WK8VsVXshaK2VeG
	Tm0RM7tRlTg==
X-Gm-Gg: ATEYQzybcsUChuZXy5zeuPwAOfCH76JvlcmXGq1v1fXotkgls18lvwIZJhXPwcjb/CC
	9hSOIGJ8kB+5nPsx9d2H/MG6RTt7hgwwnQ2/cxVGVBMDq0+SOpV8ubr6DPldxHSKPCnB2V6KAmO
	F/v1XrjW1jh0juGb+kCg8nSOt2HpjRG7n5XWNOdTXmjqxEL+o04vTYX2NqmXXtCKPa9d3iMrS/k
	8PgqrbcLuCvPAfWNS5yOSGRxMZDxWc01qs3p5LiU4vfIFGdmJzEffGpSFK3/cv8/z8Ky6U8EHmS
	GxyUL0Um/VSMa2nlkBoQRt08DTnx3amildIKYmYfXZLLRQNXszb2ztO/riZapHDjDrUmsKS9Fs3
	TAP1YLq1d5tyClAdl5BoKE6upV88rCj1jFKjbDJNiv2IumUzyPTu1ZqjVQ8ueTHNBSJEGOsKhZd
	C907JKHh+XhZ9mscq9oZhTqSCqWiLQWW18Fr/bmNPP8NalCBgEkpoVWjo5BDJrdoJSv1OXCptgf
	c5V+tsvn8eCUat4iNTIaDY83zqtv0R2DA==
X-Received: by 2002:a5d:588f:0:b0:43c:f7f6:6016 with SMTP id ffacd0b85a97d-43d150d3d2emr8154623f8f.32.1775055457278;
        Wed, 01 Apr 2026 07:57:37 -0700 (PDT)
Received: from P-ASN-MAGENTA.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d2738sm396902f8f.24.2026.04.01.07.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:57:37 -0700 (PDT)
From: yanis.binard@smile.fr
To: Yocto-Patches@Lists.Yoctoproject.Org
Cc: Yanis BINARD <yanis.binard@smile.fr>
Subject: [PATCH] patch-status: Fixed typo in some h3 titles
Date: Wed,  1 Apr 2026 16:56:15 +0200
Message-ID: <20260401145614.274137-2-yanis.binard@smile.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 14:57:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3596

From: Yanis BINARD <yanis.binard@smile.fr>

From: Yanis BINARD <yanis.binard@smile.fr>

Signed-off-by: Yanis BINARD <yanis.binard@smile.fr>
---
 patch-status/index.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 071bb1b7..cdd89e6e 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -95,7 +95,7 @@ SPDX-License-Identifier: MIT
     </section>
 
     <section>
-      <h3>Patch Upstream-Status Counts (meta-openemebedded)</h3>
+      <h3>Patch Upstream-Status Counts (meta-openembedded)</h3>
       <div id="upstream_status_chart" style="height:400px;"></div>
     </section>
 
@@ -105,7 +105,7 @@ SPDX-License-Identifier: MIT
     </section>
 
     <section>
-      <h3>Recipe Count (meta-openemebedded)</h3>
+      <h3>Recipe Count (meta-openembedded)</h3>
       <div id="recipe_chart" style="height:400px;"></div>
     </section>
 

