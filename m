Return-Path: <alexandre.truong@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F1CC38150
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 13:45:37 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web11.10405.1720100733890802689
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jul 2024 06:45:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=bJQDoHUD;
 spf=pass (domain: smile.fr, ip: 209.85.218.53, mailfrom: alexandre.truong@smile.fr)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6fd513f18bso74931966b.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jul 2024 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1720100732; x=1720705532; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+0vi50MsWIw/uHm+/Phpbiflj18S+D8UQUqWBNXcHA=;
        b=bJQDoHUDiIg6I5T5wXUDKluZggB5faGEkeb0Rb0xGVGsQeZCPrsIky6pOqTcOG5u6f
         VYQEpZb4VVUrtFZxza7wCVjWtRwihvlOucyhnwqDlOZtzTOFqHMmiQLVDtIO8KTgXGzV
         K3bKEn0CXCfDZh20n2o+dqNyoTS8Lb2sJo8GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720100732; x=1720705532;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+0vi50MsWIw/uHm+/Phpbiflj18S+D8UQUqWBNXcHA=;
        b=DdHGpxAEG5P9YKV8jR4D1Nfc3x/YrNOVz+VDAtTvK8xYM29wGAEUrvjnwNd1SxnMaF
         xym/KJn+/tAGSV9DP4u7N/kTzeXFILx0ycsEz254DMODiAuShc/yUpujy/TJkW5YmxEn
         EX/yu4BrjbW+I29mtr9sm+a4q2sZuq5WEquRAlujfqzgpuiS5tfe8ih9N31GrkFqiD1O
         AUc4TVFuXv5wCq3+/lEtyvfRJm2R/HRUsJLet1hjwY4AM+FKryLQ/rg9Wz/QRLZIgeHq
         lxrpKmnGWCWPQd03RBpc6z7pGC6cOFNjR4QJ7FqiddEqCl/MdZsiooB7wFZk1KYdLPrp
         X+Ow==
X-Gm-Message-State: AOJu0Yz4thvkKMAYvSaqjK6vUhE1gkseXKl4Bc/VA4Tf+J8TfnQNQ0oV
	vDDj/sgmtDFztFfBwRCOiWVsZehfVgtuL5RevKs5E9EeJ9FXRgyGIwzCOvCS0DCXkNET10X55YN
	QCww7NQ1ej7/Y9QevrHCnNr1y3ZfuKaIR/pFH7iJhkUTMipvI
X-Google-Smtp-Source: AGHT+IEzj/qr7BErxRQUmKQ9cuOVCfGL6enSpRao792FuKvwLGC4qO/30y5AXPh4+kFk4zGVy+UsDZgUnKRozYzBfCQ=
X-Received: by 2002:a17:907:7854:b0:a75:25b8:ffc with SMTP id
 a640c23a62f3a-a77ba7123b6mr104249266b.57.1720100732253; Thu, 04 Jul 2024
 06:45:32 -0700 (PDT)
Received: from 234945705956 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jul 2024 06:45:31 -0700
From: alexandre.truong@smile.fr
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704134514.23430-1-alexandre.truong@smile.fr>
References: <20240704134514.23430-1-alexandre.truong@smile.fr>
MIME-Version: 1.0
Date: Thu, 4 Jul 2024 06:45:31 -0700
Message-ID: <CAN21hX4dh0_1=6AJxUP3eYxhq0SrsGvmqsOPQW7DuYmYisW7Xw@mail.gmail.com>
Subject: [yocto-metrics][PATCH 2/2] patch-status: remove accepted status
To: yocto-patches@lists.yoctoproject.org
Cc: Alexandre Truong <alexandre.truong@smile.fr>, Yoann Congal <yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jul 2024 13:45:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/413

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
-            <p>The patch has been accepted upstream, meaning it has
been applied to the original source code repository from which it
originated.</p>
-            <p><em>A high count of accepted patches indicates
successful contributions and integration of changes into the upstream
project.</em></p>
-          </dd>
-
           <dt><strong>Backport</strong>:</dt>
           <dd>
             <p>The patch has been backported from a newer version of
the software or a different branch to an older version or a specific
branch.</p>
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
           { "value": data['inactive-upstream'] || 0, "name":
"Inactive-Upstream" }

