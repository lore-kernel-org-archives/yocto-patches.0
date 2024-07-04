Return-Path: <alexandre.truong@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72165C3DA40
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 14:13:37 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.11166.1720102408928167370
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jul 2024 07:13:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=DZKTh/e4;
 spf=pass (domain: smile.fr, ip: 209.85.208.181, mailfrom: alexandre.truong@smile.fr)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so7137241fa.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jul 2024 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1720102407; x=1720707207; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+fHkRafixv4UZbomuo2fca9E1wzAgFdJ36ZqTHMu04=;
        b=DZKTh/e4g2TvPa9Be5dE2OyYBdsj1AhMbEjXENEUtGvpNUhu2eqIxuq/4jOMkeadQB
         5CKKzCL7i/dgN9GWgkxg9lwhReUldKQpA+t16XDyaGK4ptXMg/L3zRPw/y+FtJsuVDwb
         fm+2ET7bKy6/94CycR6EhzZGPFYKfLCQuRxOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720102407; x=1720707207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+fHkRafixv4UZbomuo2fca9E1wzAgFdJ36ZqTHMu04=;
        b=GTQV598ePD7lJVwHJwYED/18EKFLMFPQEFQGY4InfVeWrfGPwjQmkqUPgxwdUADbbs
         Nds5qFLEZcvv8ElsZNvK2bXmBXdUeGSKsspURt1YdrTFdkn/9BHURfMaXuqyJ7jIfTzj
         gTj0xkQAnG+ONcYV0dGH/qwacjfgO2XBu7yiMN8O/ITkczGueDgpfECWI0JS5mRkB1/w
         M0qGDrL086awzameu9ogazSnZAMxI1m1mb0Eelz42j5G3UzKJxpQHTP2gcl1w4aDGqF9
         z4/ecqkMOpnJYhse/Fv7MXR5AkkTVrHb3IUgVxndQl+oAAcKQrydyUIpEh7a4/J2wA9L
         6Jig==
X-Gm-Message-State: AOJu0YzKuMSGvZ0xcdvYpAZkxPq0fo+g0LWHQukKTJ9MnjaUwZ/m42BU
	DrSrZb9zIRkXq3cxBrD9egDaRWVLcSPi4vIFWYVHp+psofN4eVob+c2r+6rnNzerrhYEw7+9wV3
	I
X-Google-Smtp-Source: AGHT+IE9t5qYrRmerqPX/Pz+qLEyVnsfVzdIe8d8RpqcHK9q3qbuqUQec/8kpVpRsQQnaBVwfuFD1Q==
X-Received: by 2002:a2e:b0e6:0:b0:2ee:7e25:dc0a with SMTP id 38308e7fff4ca-2ee8ed461bamr13345841fa.21.1720102406999;
        Thu, 04 Jul 2024 07:13:26 -0700 (PDT)
Received: from P-ASN-MOON.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd66fsm18810623f8f.8.2024.07.04.07.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:13:26 -0700 (PDT)
From: alexandre.truong@smile.fr
To: yocto-patches@lists.yoctoproject.org
Cc: Alexandre Truong <alexandre.truong@smile.fr>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-metrics][PATCH RESEND 1/2] patch-status: Add missing inactive-upstream status
Date: Thu,  4 Jul 2024 16:13:16 +0200
Message-Id: <20240704141317.24385-1-alexandre.truong@smile.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jul 2024 14:13:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/416

From: Alexandre Truong <alexandre.truong@smile.fr>

Adding missing inactive-upstream status to the pie chart and
to upstream status graph.

Signed-off-by: Alexandre Truong <alexandre.truong@smile.fr>
Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
---
 patch-status/index.html | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 99ddbbd2..c77db918 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -272,6 +272,14 @@ SPDX-License-Identifier: MIT
             <p><em> Rejected patches could signify issues with patch quality, conflicts, or discrepancies between the patch and upstream requirements.</em></p>
           </dd>
 
+          <dt><strong>Inactive-Upstream</strong></dt>
+          <dd>
+            <p>The upstream is no longer available, due to lack of activity for several years.</p>
+            <p><em>
+              Inactive-Upstream patches indicate that the original source code repository is defunct, with no recent commit or releases, and unaddressed bug reports and merge requests.
+              There is no longer active maintenance or development from the original project maintainers to merge the patch.
+            </em></p>
+          </dd>
           <dt><strong>Total</strong>:</dt>
           <dd>
             <p>The total count of patches in the OE-Core meta directory, regardless of their upstream status.</p>
@@ -435,7 +443,8 @@ SPDX-License-Identifier: MIT
       denied: 'Denied',
       total: 'Total',
       sob: 'Malformed Signed-off-by',
-      upstream_status: 'Malformed Upstream-Status'
+      upstream_status: 'Malformed Upstream-Status',
+      inactive_upstream: 'Inactive-Upstream'
     };
     const branches = ['master', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
 
@@ -524,7 +533,8 @@ SPDX-License-Identifier: MIT
                     inappropriate: status.inappropriate || 0,
                     accepted: status.accepted || 0,
                     submitted: status.submitted || 0,
-                    denied: status.denied || 0
+                    denied: status.denied || 0,
+                    inactive_upstream: status['inactive-upstream'] || 0
                   }
                 })
 
@@ -625,7 +635,8 @@ SPDX-License-Identifier: MIT
           { "value": data.inappropriate || 0, "name": "Inappropriate" },
           { "value": data.accepted || 0, "name": "Accepted" },
           { "value": data.submitted || 0, "name": "Submitted" },
-          { "value": data.denied || 0, "name": "Denied" }
+          { "value": data.denied || 0, "name": "Denied" },
+          { "value": data['inactive-upstream'] || 0, "name": "Inactive-Upstream" }
         ]
         generatePieChart(formatted)
       });
@@ -741,4 +752,4 @@ SPDX-License-Identifier: MIT
   </script>
 </body>
 
-</html>
\ No newline at end of file
+</html>

