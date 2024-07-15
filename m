Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0474FC3DA59
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 14:32:09 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web10.39590.1721053919537070739
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Jul 2024 07:31:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VggGHr0f;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44f5df38e64so11864631cf.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jul 2024 07:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721053918; x=1721658718; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DiFXDz2bKfo7TYC3kixDOqAYCwnxuB63zMWzk+fybFo=;
        b=VggGHr0f6kc+wP4iRdVF/SGgq6ERowlb3oRTrZFSlIzd2Arx+UMV5kFNH6VqeZXtC3
         lbl5waLxtum1zJraAgjYLPIWmsYVxjt8RN/9LO7QEIb2YUqKWQLorJDR5hrkmwAffNVO
         vLabLdbYGzHToEAMAcOaDROrOcDvm7nnCstocuT/L94dpgAahIz0GG8FpG58y4YT4paS
         TQGyGuP/CKrIshianfZy/h0XqolPAQ644VjzO6Zywy5BB/+ueAyMeI5XcvXIAQPE5UFc
         aqjom+/iy9J3temFY34e52PL+us6q3eme9H9oas/lRLTZ1w6Ke3qxY0ROF074b8/3sl5
         NvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053918; x=1721658718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DiFXDz2bKfo7TYC3kixDOqAYCwnxuB63zMWzk+fybFo=;
        b=JkTf5pvTSaIe9hnPbKP8dTQI8n6iC6yKMBK22FFOr26yFbKPLfTvvJIv3IHhtUFjU/
         DM2jEkjHg2yiesRYMhl14s6OIreWJTMLLm4WXNOuVSSZvtPqRKSNUH9S4eEkpH7QSOGA
         20yKVnuAyKLWTKZ8M260S4ZvI5MxeJdlPXJvqIDTuxOFlC1956Z0M2eN7706qSIQhH0A
         do5d9YCzkyRAGIPk3T34QD1wnUNemyMFZTDm9CCZ5Y7uACYcI4Nr8Say18znhOwDvyph
         DFWJKjBrG1w1X9sZ1C1Gdt9lJlDwY8qZpI+nqGolZCsc0cdZcI8H0VhtnTyFZ2B4sHds
         WagQ==
X-Gm-Message-State: AOJu0YzME27vy3KmF0pSjblkFFXpzh9AxAlQxlNEGduJ/g6qiCQDrs88
	wVkUzuzSwyG5QsuW63yu0GxQrHgVWYXxxOVxUz7uU50u8zvSP6AXnnI/qw==
X-Google-Smtp-Source: AGHT+IEXSyO7s0p6DYbdtOCVtpxxC4onofpoxuwqEqQmavdgy0VaWc2+sm9gS/1DLUdE4uOXLqv28w==
X-Received: by 2002:a05:622a:553:b0:447:e14d:ab10 with SMTP id d75a77b69052e-447faaca507mr249720271cf.56.1721053916973;
        Mon, 15 Jul 2024 07:31:56 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7eded2sm25247431cf.39.2024.07.15.07.31.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:31:55 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] linux-torvalds-next: ignore TMPDIR issues
Date: Mon, 15 Jul 2024 10:31:49 -0400
Message-ID: <20240715143149.16336-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jul 2024 14:32:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/428

oe-core has raised the status of some checks from warnings to errors. Ignore
the "...contains references to TMPDIR..." error when building the
torvalds-next kernel.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-kernel/linux/linux-torvalds-next_git.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
index c0ac1de22005..6f3db7c61bdf 100644
--- a/recipes-kernel/linux/linux-torvalds-next_git.bb
+++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
@@ -5,6 +5,7 @@ SECTION = "kernel"
 LICENSE = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
 
+ERROR_QA:remove = "buildpaths"
 DEFAULT_PREFERENCE = "-1"
 COMPATIBLE_MACHINE = "^$"
 COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
-- 
2.44.0.478.g7774cfed6261


