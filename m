Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2742FCA0EE9
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 21:08:13 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.web11.60905.1755464892716864202
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 14:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=YToWacrf;
 spf=pass (domain: konsulko.com, ip: 209.85.160.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109914034so40514211cf.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 14:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755464891; x=1756069691; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6NpVdoYjv6ztK8NR1SpYLt4KiubyrP0KqcKi+6afuc=;
        b=YToWacrfLsjuw1NYwEXjXv3zcU+5S4oFGPQcb5qEAk9xVkR9vIiMJay1TfUZpvet3K
         /lRolfeY3l2j70w5vKcIqXu2jG8B3iEw1FZQKrLI1ZzXj8HwjjE+S/zEX16KzHJJiiFK
         nmxjii0L/kYlc+WR/9sMWdAjFwfOZR6Qsa8pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755464891; x=1756069691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6NpVdoYjv6ztK8NR1SpYLt4KiubyrP0KqcKi+6afuc=;
        b=R5Y5mIIebF/vbwxOFyeRcLK1SM32dR+QhWN81CIwJy6KN+Gm+BQu4t4x7N2Bh6Tj7y
         PhoRLJw733DaBm9D8B5+dcQy40T+fibm8Ol30zTXZ2D9MJQqDxT5edPHWeWfg0j3OtKR
         mnoyta6wwNNUUEy6swmSFq6exB1uuanuvBp5MKShLxlEuxvSZE5t2mAESwvDADdhBwMe
         lp0dKNxeaYalgemv4paXrFfg1FGTUmyrzQ/WcPxGGYoMva+sxByOH2GeUjNmn/Sxo0Bc
         bVfv3M4XI+l8fSVBXob+QtEXblFG6Unl7cujU2wpF8nBtlUQdJ7S4MdB1DVE9q65WPhs
         vePA==
X-Gm-Message-State: AOJu0Yy7XHJsVe2c+o7l71ABOSKQ3gB2S6EVdqQtYz6tUk586uuR1dj6
	DTXrOpaxxLi+2wYY5kIzfrE8sOj9dTE5OldbrCEcjlzwCOMSnda8Dk+LgemwQyLVQL8sP3JaA1Q
	Spi1p
X-Gm-Gg: ASbGnctZMnHLdYbDU7n0Ct6NcdW5JHGA2OuHymEjU4ft+z3V13QvJgiFIkUgaXBXC6H
	yBTlSaAhXqndMg407BB6T7AHT6fTooFBSgesa8nAtvRloUCziFlFLoDiDfSjSvfq2AfuZMW0B6S
	XgdsJLTNkjr8LnnM3Zqg2fL/7nMrCGq+A13UguBHOkA8rsK1wyf7edQfn4VYaa+2+72u/liXVYk
	pFjNaNE0F1hWA+b/0y7acaDt6zfuIZDBjUFKO5zvlMie0f/BeTLlLvVvzkrG1XtLeXZNdOQao6k
	EXwbFuAKOfq0phZet+Mx+VagaBZqCJ+AiHVOCwlUDx93IgiL01Wyw4++n4QllwUXXAxsWTrGJef
	mXwWkybPUodeqnH9EWw1ZHkI5MJV4lGkRgRkWleiSqd2HNHD1Jd4CNOI334PVh6mfcwzi9IREag
	==
X-Google-Smtp-Source: AGHT+IHkNcTXITXlfo7CpdSbcjRc8F2Z9P1i78pyXijd4qKosB5tPAXQCDHhsGqxiBLpuznolxpK2Q==
X-Received: by 2002:ac8:5f8b:0:b0:4b0:7ae5:c3a4 with SMTP id d75a77b69052e-4b129dd720amr100443401cf.40.1755464891509;
        Sun, 17 Aug 2025 14:08:11 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dddb0f4sm42215661cf.38.2025.08.17.14.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 14:08:11 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Subject: [meta-security][walnascar][PATCH 1/7] scap-security-guide: fix fetch
Date: Sun, 17 Aug 2025 17:07:53 -0400
Message-ID: <4df29593668e123146749a450e85fe4ef137071e.1755464538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755464538.git.scott.murray@konsulko.com>
References: <cover.1755464538.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 21:08:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2024

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

The project does not use release branches; their release model currently
rebases the stable branch each release and relies on the release tags to
keep the commits referenced.  Until their release model changes, just
use the release commit with nobranch.

See upstream issue [1] for details.

[1] https://github.com/ComplianceAsCode/content/issues/13543

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
[tweaked commit message]
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../scap-security-guide/scap-security-guide_0.1.76.bb           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
index 73bd576..8615f97 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
@@ -7,7 +7,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
 SRCREV = "616d4363527acb61c6494a97f3ceb47ec90f65fd"
-SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
+SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=https \
            file://run_eval.sh \
            file://run-ptest \
            "
-- 
2.39.5


