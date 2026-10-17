Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87755CCF2CA
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 16:57:22 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.343.1792256235179934955
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 09:57:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DjJ9uwrT;
 spf=pass (domain: gmail.com, ip: 209.85.214.175, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso3904125ad.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792256234; x=1792861034; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+5a6VHycAPs5b0bQ2HsTtIP03p39Xiv4tUYlbwHIS6I=;
        b=DjJ9uwrThHMKx/+LmlQqdltdPm2geZ37YyRLG/Z07OJE+4cKvRRYFT2pRVtkoNp87d
         duPrx5N+9lPrs/r99DuYKh0We5OV/+vOe4Oqcf93oziTKB7yTzrglzs5YDK8eEIF/34i
         RNxJDv/tnnra45JfhZkqdiZSID7axJJlzONHn01oYSc2RX/cfvybfn8n+DoulSoXf7EZ
         hEbHJwegg/JAFhuGnDruw9It2knj0YrOKkLW0Lb7MYBClcI3IfxK6qasRmOSUi3sIxWj
         Z/bdcRDmTEbm7MZtktPOr5P8nk4Pw4QD3dZdDnD0YcBcs7gRlCI5OflEyZLchzNSNw0k
         JoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792256234; x=1792861034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5a6VHycAPs5b0bQ2HsTtIP03p39Xiv4tUYlbwHIS6I=;
        b=zDg8nBg6oxTc8+BT/dJJS9tHxWn8dFo8ihMV/CrzimAvsoEaW+y/kWTMWV7gOciopP
         HN/0ultcwVKF99MByEp7n5NSSNPdQwSBna+Y1kWfILDh9evMQcgFDPQjns0C977ZWst8
         5zEQ+Jl0IMb8tNZK0gpUnzPieK7qVayhqmMlcU4r3alfXJGETtEwXD76TNkTt9iDqDNV
         sLnrTLDJFuGTSfp0KI5V8kVQRjjRczl/HTzsSqHkwddB0o0BfQA0oKn7p90FS6UeOMv2
         0UduqqVJID1TcE5Q/o+YZJtsKM6AWz4VxCRk0Q2gOMk8s76HNMVJRHVy/Sb3iKDzxb4H
         u06w==
X-Gm-Message-State: AFq9FYLeC/IvUr/sb9LfGqkdNuK58hak0nwZsOhjATAzK+C/PFzkSsP7
	z4BC3en48BkzZyRwXc+dqV9fx0rF1fgZwFYOuPMCXjdD0fusv4gfAKEmogG0nw==
X-Gm-Gg: AYBFou2fF3UzOCwTtOpbL5SfYxUi4BDJOqJN3qQu0HpXbp8VjSjE7zEQYgNM4yr57/Y
	yCIDxKOL7WytPizXLLbEakG6F3w/BeInRQbR1Qy7ShHJMmQ53MJF/UkH+9Dh02Iz2TacmWNB+Xa
	Qi7sG0eMSny8MO+1fFL4QjiPZNNyx1qfRMoXGuSAkXQRBJhX0LkCZd6Fpboy8WVE6Xt6+/2qK0a
	2vBicim3QEPIwXpKT3n1qJBXxiT/MMXukGwMZxyfwpU0bvwBURPf/Ft3vi1xq99DZXPSCUVhCW8
	msRzS+/pP0kfgl4tlXKO58VLpSSiJmmH/thLf8c5W3XCvOJ+N39Com+RfV3s09bSu3opU616yP9
	3UQyGTBmOn3yZqB7lgF8UTBwdUnptK6SGrTSrWrgSgZ9YRStwGXuiNohppv7gJFdb0ZwbSOK72e
	ypcZNsU6KQ33y6KottZCG9ZJrcHUrrPKFw72CtSyHEy7ZHFZnIVoZogpUop7IKa/b+47YkcDsy7
	b79ppQxRytN2tgw9Vq+HF1eARu5uTg=
X-Received: by 2002:a17:902:c405:b0:2e2:e3aa:7a35 with SMTP id d9443c01a7336-2e9a6e41184mr29097455ad.36.1792256234323;
        Sat, 17 Oct 2026 09:57:14 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d7efcsm22402035ad.5.2026.10.17.09.57.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 09:57:12 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/3] layerindex/views: BranchCompareView: fix to_branch check
Date: Sat, 17 Oct 2026 09:57:01 -0700
Message-ID: <20261017165703.70617-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 16:57:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5036

The to_branch lookup was guarded by from_branch_id instead of
to_branch_id, so a request with only from_branch set tried to fetch a
Branch with id None and returned a 404 instead of the empty form.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/layerindex/views.py b/layerindex/views.py
index 4f8e64e..73a4f6a 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -1927,7 +1927,7 @@ class BranchCompareView(FormView):
             from_branch = get_object_or_404(Branch, id=from_branch_id)
         context['from_branch'] = from_branch
         to_branch = None
-        if from_branch_id is not None:
+        if to_branch_id is not None:
             to_branch = get_object_or_404(Branch, id=to_branch_id)
         context['to_branch'] = to_branch
         if from_branch and to_branch:
-- 
2.56.0


