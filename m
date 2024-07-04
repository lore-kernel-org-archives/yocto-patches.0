Return-Path: <alexandre.truong@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F35BC30653
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 13:45:37 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web11.10404.1720100733446114401
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jul 2024 06:45:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=JF57MVp7;
 spf=pass (domain: smile.fr, ip: 209.85.208.47, mailfrom: alexandre.truong@smile.fr)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58b447c519eso876616a12.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jul 2024 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1720100731; x=1720705531; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dUDoblIV7ZTr5v5744WDLFySDaARkPU9UC9/z9A6Jrc=;
        b=JF57MVp7Rp8ySniLB1Z7fKE6Q8Z4zDXeAFlw3ZhaJuvrB7BQMImFFx0WfjQ9QyEBjc
         q90jCRf2yNKJ0VqqoDymIVFg/G7utvrqcEREXhenoASy0O8JMgWx+U4AZiYtdbH8rGf0
         VLqD/ss1+PRUmLTd89Dd04stx0tMNPduRqX8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720100731; x=1720705531;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUDoblIV7ZTr5v5744WDLFySDaARkPU9UC9/z9A6Jrc=;
        b=UrLOLnQ6ya++ng8OeitPLp/HdyUGEdcVRKFGnrl0SIeDKCzoT2R8Li8anOFZ+ZzAle
         ZgGLMUKd2iCavqd42o99PWXPzinytn7gFuihyqRxUAms6Irypb75ycyKxDa1TR34W5cN
         zwQvUboZo2Rv7UyVcyqBh61GAXN2P0i6OPaZH6wwQIhRI3mX8Y6DkNW0d1iKg0yi4hHA
         m4rij33SxeSrUXmINdYJLWVZH+rJOTFW9t/jbrsHQj/9iUjCw1Dr35MA0Jp7oddQFWuO
         r8eyrRtI+QxOqzNJAB/zP3pUBBoi5kNwTKMvRUqeDLB7w9M+vjIJGJpna9VNZBxhuce0
         xDww==
X-Gm-Message-State: AOJu0YxUqGlsfu3Ao5z45CbjsBAURjdcjEthfCY16I2lb/qln+/hiU3c
	16R1SQXJdtjFiurip7pOhmfc/ySl1Wpf7ZvHY1ARBnX9DlzmCFY/JSG9I1SOTShpuIvIySSn927
	AK93S6TBFuRnvZ4c+x539Ck0uqGl8cueTylhyy11c/YSQL4qh
X-Google-Smtp-Source: AGHT+IE/7/xlYwMB8e/IRiANqBX7YSb/zOoKAq5f6iwz0vxt8POyenp1T2gAaHqQ8rQLzaHJf/5NtLXP/vacn2ol3UE=
X-Received: by 2002:a05:6402:2349:b0:57c:aac9:cd8 with SMTP id
 4fb4d7f45d1cf-58e5a7e8b66mr1267631a12.8.1720100731468; Thu, 04 Jul 2024
 06:45:31 -0700 (PDT)
Received: from 234945705956 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jul 2024 09:45:31 -0400
From: alexandre.truong@smile.fr
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Date: Thu, 4 Jul 2024 09:45:31 -0400
Message-ID: <CAN21hX7y7j64LM+wp8vV9f6_uKo84auwqk3wCGtJ949VMq5JYQ@mail.gmail.com>
Subject: [yocto-metrics][PATCH 1/2] patch-status: Add missing
 inactive-upstream status
To: yocto-patches@lists.yoctoproject.org
Cc: Alexandre Truong <alexandre.truong@smile.fr>, Yoann Congal <yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jul 2024 13:45:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/412

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
             <p><em> Rejected patches could signify issues with patch
quality, conflicts, or discrepancies between the patch and upstream
requirements.</em></p>
           </dd>

+          <dt><strong>Inactive-Upstream</strong></dt>
+          <dd>
+            <p>The upstream is no longer available, due to lack of
activity for several years.</p>
+            <p><em>
+              Inactive-Upstream patches indicate that the original
source code repository is defunct, with no recent commit or releases,
and unaddressed bug reports and merge requests.
+              There is no longer active maintenance or development
from the original project maintainers to merge the patch.
+            </em></p>
+          </dd>
           <dt><strong>Total</strong>:</dt>
           <dd>
             <p>The total count of patches in the OE-Core meta
directory, regardless of their upstream status.</p>
@@ -435,7 +443,8 @@ SPDX-License-Identifier: MIT
       denied: 'Denied',
       total: 'Total',
       sob: 'Malformed Signed-off-by',
-      upstream_status: 'Malformed Upstream-Status'
+      upstream_status: 'Malformed Upstream-Status',
+      inactive_upstream: 'Inactive-Upstream'
     };
     const branches = ['master', 'scarthgap', 'nanbield',
'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott',
'gatesgarth', 'dunfell']

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
+          { "value": data['inactive-upstream'] || 0, "name":
"Inactive-Upstream" }
         ]
         generatePieChart(formatted)
       });
@@ -741,4 +752,4 @@ SPDX-License-Identifier: MIT
   </script>
 </body>

-</html>
\ No newline at end of file
+</html>

