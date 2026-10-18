Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAE0CCF2C7
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:54:36 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7929.1792288468046247632
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:54:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=C+vpl0rm;
 spf=pass (domain: gmail.com, ip: 209.85.214.177, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e977109392so4113995ad.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288467; x=1792893267; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mrx7lM4jKQa14ilNb2b+ZTmrUNTsglZBJXBvGth5XkM=;
        b=C+vpl0rmyPzsn8PRUgGvccl71XuyR0+ESspf8K1c+JcgUp9hZK+Bew9yFhYDsMfBGt
         2wv34hf7rWHlYgVByMOLSxtd+fjsC9arBjfhdE3VXdNUlQPidZEHe6Qwq9p4vYGibLct
         oIP85EB7jr9t/+EWh0xGNT4nU2D59NNi5C+d0c91kzW2jyzc/HARzAMiMMrpfzKv3prP
         j51KBt7kEQ9VQfZArPtuxi9obGnbv8iM3qWNmzd2RtfCObIUujqkh+V+8sDnU0JFx0Zb
         dG1yv8yuXpELOimyOU6q6QJ5SvUvtUbBV6bNeqrIRfIF3Eb+mRwrjW4Fp+l79QuUsOHv
         WZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288467; x=1792893267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mrx7lM4jKQa14ilNb2b+ZTmrUNTsglZBJXBvGth5XkM=;
        b=GiBkzitxsO4HuTy6uwiXLh/HrYrzWPOne3L8GndYROsza9ySwTNrVITpxFqBs82bfH
         m8hioQKNtokOmTnG5CdIjmmZtkDdLsZOz4oYcSuK6OpPIt0+wayQlJ2A6f/ZMs6qVLXB
         hqUcH2U9FH0qm7qKvJba3HJV1+rMHGEoEHAnVcgcFg2EGCUto4Et/9oMAkamyyV9F18z
         6ncw3p//xpOe8utmzJz35n37Jx/IxlvSwXvolZrA6GSNSmphyuVcm0C39EKVUU0tg194
         sp/w5Esrk0ULJfXwT/+6RCrBCL5qWqPmYpGNafOn2Ko/QDfzFaNLuiOFh35DIBQe0GdO
         pBVw==
X-Gm-Message-State: AFq9FYJst9T/xj/B+FyYeRs81T5Wlmn2vMkQ+E/AqzE7W65ZV1tiPIAV
	aCKA16WTBZ0ejdC453W3sYhJvwG+R8dfXhhpQ/do68uOGpRGLS/ol8wS0mt0oWd3
X-Gm-Gg: AYBFou0AF8lQH8vcsrcYifGKmsMLcVah6Knwt47Ow3ZxabAHQJCh3gbm8wdGRL/YuNB
	Dbx4VBtQuEl+fb6XfQPv5wHZyTL/kaDrDE+IBhPyKSB0I+Q/MXb/6FTwHX6SE1RuJHVUqdHJ1F6
	9PX1dssZ7MRjL56RmGIMY1/SruNhXYPjAY65lR3ZwgQTuNOAaDP+hpVJL4vScvWoASVH0qqe7M8
	3v6OGS5GWsszqizFRI9JPmJYRU6Qb+qyKNN7gRrk8YFvxBLbtQLeqTuf2/AyDdjxS/+EICH7ley
	LTbEcgFZ0AHjSe/RJnKf3rFupztopIuMFTiNYc1CzAW1S/qeWhnVJ4HibIuZJxZd7zFfN7kTJEq
	xsNSQJxgR4FL+NZ6o0OQyGptuklESS5mEZLRoSCwHIW5yZyd4vDwYWNuKNTTNH0RqgYJC+kz/TK
	Fy7dEnsmSX68JfjVMEZhurUdVfY0S5WuN4joXSndIjg3jGL0232k1jAjTgPwuL1NLeU+Y50A1Bg
	kJIjFBZij4qUZggqUGaQoj/P0A4w2E=
X-Received: by 2002:a17:902:eccd:b0:2e9:787c:8e68 with SMTP id d9443c01a7336-2e9a66ef868mr36532965ad.0.1792288467339;
        Sat, 17 Oct 2026 18:54:27 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d51b5sm24626155ad.8.2026.10.17.18.54.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:54:25 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 3/3] README: update where to send patches
Date: Sat, 17 Oct 2026 18:50:40 -0700
Message-ID: <20261018015326.73748-7-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018015326.73748-1-tim.orling@konsulko.com>
References: <20261018015326.73748-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:54:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5057

Patches go to yocto-patches, and the repository is served over https.
Show the git config for send-email.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 README | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 04f88d2..fb38a66 100644
--- a/README
+++ b/README
@@ -80,10 +80,14 @@ The code for this application is maintained by the Yocto Project.
 
 The latest version can be checked out by git cloning:
 
-  git://git.yoctoproject.org/error-report-web
+  https://git.yoctoproject.org/error-report-web
 
-Contributions are welcome. Please send patches / pull requests to
-yocto@lists.yoctoproject.org with '[error-report-web]' in the subject.
+Contributions are welcome. Please send patches with git send-email to
+yocto-patches@lists.yoctoproject.org with '[error-report-web]' in the
+subject. To set this up in your clone:
+
+  git config format.subjectPrefix "error-report-web][PATCH"
+  git config sendemail.to yocto-patches@lists.yoctoproject.org
 
 To manage the size of your database there is a convenience command:
 
-- 
2.56.0


