Return-Path: <alexandre.truong@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D03BC3271E
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 14:13:37 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.11034.1720102409178033811
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jul 2024 07:13:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=z2FON/lx;
 spf=pass (domain: smile.fr, ip: 209.85.221.41, mailfrom: alexandre.truong@smile.fr)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367a23462e6so260273f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jul 2024 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1720102407; x=1720707207; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKp+aOc+vxIKufnHR4iQIIIVqiua2a1urTSxLiM0UBI=;
        b=z2FON/lx0RHv9DGCkFlWKPpqN6o9X1ws6j5KLhnlg6Qbd72Z6AefzOV2Klr95DdGCa
         qVnbiS/Q//wGsa/DflzJbWJ5ItnXPwPNTzL33bkAIdeXMBjViRLuk7UGsvn2eynNXcBY
         3E+US/cgWP8AbjaxxlyD+ijIKAzSqfMfyKJrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720102407; x=1720707207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKp+aOc+vxIKufnHR4iQIIIVqiua2a1urTSxLiM0UBI=;
        b=ItUcg8pYrxCNWtqouv/Vrl8NPTUNiTYR3VYocoMspvZ2G0RP0sN/yk7TPtavMKJs3p
         4NI+A5vV7RiyB4Q5A2iOIkywoyzeLOdVBAyzqAmHDvfmKz8QeyxoE3SfSoEpvve2aLbd
         kptofmcQ4EjVgrK1sDtjmUG9vBHfUmhKEMXL9MrQ3hNfAb4tqfnjb3xfoQJJF0esxvlt
         dHgklhEZ7IUlVj7Bqlu1IE5GVOi1TaOrhw71uw2wjp76SJSeRjgJeSGDsec1LIwuaorM
         MnJGEgSaIAwtHQeT6+jrvw8Pia6f3s7NdfAfedKgHLn+4rR1c69V6BRIz331hySsANqe
         4Csg==
X-Gm-Message-State: AOJu0YyaePiCWuA3hEdu/p5TssskgS4EZyB2dXS7gUQ6cmAifWY2l9uY
	duz6vTs2efaJVkH837GcpZ6aaZoDkOyWqBdhqUFbKZpSTMBuOPY0Phf87qrLoTtjyhWy/Lf02ms
	G
X-Google-Smtp-Source: AGHT+IEJp8hiPsO8P/dsidWxkMOzTtsLfr1JDPoUBzIvcmzLo7IESyTPxw6rEc/VtTbU/wKIC/MHjQ==
X-Received: by 2002:a5d:65c6:0:b0:367:43ce:9c91 with SMTP id ffacd0b85a97d-3679dd29679mr1035200f8f.27.1720102407573;
        Thu, 04 Jul 2024 07:13:27 -0700 (PDT)
Received: from P-ASN-MOON.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd66fsm18810623f8f.8.2024.07.04.07.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:13:27 -0700 (PDT)
From: alexandre.truong@smile.fr
To: yocto-patches@lists.yoctoproject.org
Cc: Alexandre Truong <alexandre.truong@smile.fr>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-metrics][PATCH RESEND 2/2] patch-status: remove accepted status
Date: Thu,  4 Jul 2024 16:13:17 +0200
Message-Id: <20240704141317.24385-2-alexandre.truong@smile.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704141317.24385-1-alexandre.truong@smile.fr>
References: <20240704141317.24385-1-alexandre.truong@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jul 2024 14:13:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/415

From: Alexandre Truong <alexandre.truong@smile.fr>

Following the convention [0], Accepted status has been replaced
with Backport. So Accepted status is being removed.

[0]: https://docs.yoctoproject.org/migration-guides/migration-3.2.html#miscellaneous-changes
Signed-off-by: Alexandre Truong <alexandre.truong@smile.fr>
Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
---
 patch-status/index.html | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index c77db918..2ca0bee7 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -227,12 +227,6 @@ SPDX-License-Identifier: MIT
           Upstream status categories explained
         </summary>
         <dl>
-          <dt><strong>Accepted</strong>:</dt>
-          <dd>
-            <p>The patch has been accepted upstream, meaning it has been applied to the original source code repository from which it originated.</p>
-            <p><em>A high count of accepted patches indicates successful contributions and integration of changes into the upstream project.</em></p>
-          </dd>
-
           <dt><strong>Backport</strong>:</dt>
           <dd>
             <p>The patch has been backported from a newer version of the software or a different branch to an older version or a specific branch.</p>
@@ -531,7 +525,6 @@ SPDX-License-Identifier: MIT
                     pending: status.pending || 0,
                     backport: status.backport || 0,
                     inappropriate: status.inappropriate || 0,
-                    accepted: status.accepted || 0,
                     submitted: status.submitted || 0,
                     denied: status.denied || 0,
                     inactive_upstream: status['inactive-upstream'] || 0
@@ -633,7 +626,6 @@ SPDX-License-Identifier: MIT
           { "value": data.pending || 0, "name": "Pending" },
           { "value": data.backport || 0, "name": "Backport" },
           { "value": data.inappropriate || 0, "name": "Inappropriate" },
-          { "value": data.accepted || 0, "name": "Accepted" },
           { "value": data.submitted || 0, "name": "Submitted" },
           { "value": data.denied || 0, "name": "Denied" },
           { "value": data['inactive-upstream'] || 0, "name": "Inactive-Upstream" }

