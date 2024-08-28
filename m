Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D42DC6FD3B
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:09:55 +0000 (UTC)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
 by mx.groups.io with SMTP id smtpd.web11.5842.1724875791662396551
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:09:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=LMQInKMg;
 spf=pass (domain: konsulko.com, ip: 209.85.166.41, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-81fd520fe0dso268091339f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875790; x=1725480590; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ecv75dw0pdg/RNPnmGYy6uE7HyTL2dUebykcMdM2OY=;
        b=LMQInKMgICLM+1bDd0cocy6NGxh0L1AZw4NNwSOdC2J1YbziMdDD+xAZy2WnR5CoAe
         8B7cLVSq0ytDh6GsR2wm8SnTaTQpxf3Zh+dNHS5PaUuJ3iJVNB7IrTSxsUaqwGjInEFK
         TH4isyHE8gAmrT43WFUBFNAHPFMIXn4/2gePQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875790; x=1725480590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ecv75dw0pdg/RNPnmGYy6uE7HyTL2dUebykcMdM2OY=;
        b=tkLFuVP2yusCk4aVel5XbO/5LMCsrFMgqcrNJ2EYVWANn0KGLXYyVonDDqnEsK893l
         q6Ux7YDvuhvdyXnOLcmdopCFbdOmCPJ6x4e4fH9HAiaTq4OLxAGalkcVtlc139NJqUCs
         kmUusU/p7AklnMwuQDQsTyutI7T2aixzk1L0KWBP9bBSQvOK45kKpKVx4LukA5Slf3fB
         s+4K8XX8qyZviNjACYhtdRAowqAC9yWFv8bgKqvbnjL/bWfr44htUxCjc4LdQ/aJiEFc
         EV5AtROzB4pSf0cuYnH9XgCUoxOiczL0nhSkO3qza2CIh6ngSkL5rdHrvE7CadFxcXaO
         N/Ag==
X-Gm-Message-State: AOJu0Yz6NHsVvb2MzjQ6UL4VZOI99REQfSOCKTH/W+bd3s/p34YsNcRq
	7StoKTDHclkzAZIbrcFOlrhCILbcMudb2aoXgP+Yfjy8f4MnOG0k5v7yAx5KX2m3pcY8bYFAPLW
	0
X-Google-Smtp-Source: AGHT+IF+VgvkxMnVi727yET9X9iyUzxO0UdIhDEVxztNbruwe111rxJiVvhesY/LU4c8aBLXApYP3g==
X-Received: by 2002:a05:6602:1602:b0:7f7:e273:a97d with SMTP id ca18e2360f4ac-82a1104e86amr83778839f.9.1724875790542;
        Wed, 28 Aug 2024 13:09:50 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:50 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 03/33]  packagegroup-rust-sdk-target: Add cargo
Date: Wed, 28 Aug 2024 16:08:49 -0400
Message-ID: <741be1f18971253c38790f71acbfeb43681fdbd7.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:09:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/570

From: Alex Kiernan <alex.kiernan@gmail.com>

Signed-off-by: Alex Kiernan <alex.kiernan@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit ea23ff72507768e2201211e488632208b9180296)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-core/packagegroups/packagegroup-rust-sdk-target.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/packagegroups/packagegroup-rust-sdk-target.bb b/recipes-core/packagegroups/packagegroup-rust-sdk-target.bb
index 334b249..59874c4 100644
--- a/recipes-core/packagegroups/packagegroup-rust-sdk-target.bb
+++ b/recipes-core/packagegroups/packagegroup-rust-sdk-target.bb
@@ -10,4 +10,5 @@ inherit packagegroup
 
 RDEPENDS:${PN} = " \
     rust \
+    cargo \
 "
-- 
2.46.0


