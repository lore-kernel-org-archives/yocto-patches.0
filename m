Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268BDC7112F
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:16 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web11.5857.1724875807169431812
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bxnVP0VQ;
 spf=pass (domain: konsulko.com, ip: 209.85.166.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81f905eb19cso393927239f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875806; x=1725480606; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8m6MUkA1GEwgycRxaCftG09/SJ7oV19iPH2LpM6aTc=;
        b=bxnVP0VQzxj3v+iMd0Vg1EvunGbxGNJffo7Z6O9M04WcW/AeFR/DsAMzYcIbAHsdkZ
         OX/erBLoOxlf6P8PAztlXZSo7unMG+emAJQ2Q7rOvYNJhhhJdJypQaWyXfZ2MOQsS26q
         26aSnJtGfKRD9kdoNOy/MFWQsL3RNiHQElr+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875806; x=1725480606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8m6MUkA1GEwgycRxaCftG09/SJ7oV19iPH2LpM6aTc=;
        b=aIS8vzPxeAg/3VjnMqbgc4oZs/1n75vtxfQQHusb/F/WlRsLmH35yZXEpBW3pULRNG
         sjdbAmhDfkpzjo50Roqwz1aL93X9qbsQ/CFd8BocEViHr77pLWLtyM1rS300YQmPS2IY
         7nIm2AsAw4LFVz4CHLuyNO1pn2hxtpnyiuPgwSNdMi/MNDabPslV2OnbBB/YF4C/6Dt9
         sRyMCp02d+t0PNrrLx+ebQzfL8Q1nLMc6wTCnNbg0/8zM/jk12n6OZMn1xYKSJ5iXhxS
         R7Nx03Pd58XlPTsoEbFCkGYoyyQeE7muyfQxHu8H0wlDOewVEFi/D0rUEXZRu1ZGb0fl
         aBWA==
X-Gm-Message-State: AOJu0YxWqtdp2wZWKsh4Il5Lz4DGzublJ5/fLImREnXU7pvgyCwGN88f
	ahMz025azH4LyKtnkfz/OAGIz/CgcnHiXjX8nDACKCpFTB0T9ft/Y57+Kbigw6PfFOjzwvk0xeC
	z
X-Google-Smtp-Source: AGHT+IGHjD3Tk8obwmaYTtNQ46YvvdPyobCztFE4o/15KeS+Wf7vArS3Lan7bSpNdiSynZI/jz3yag==
X-Received: by 2002:a05:6602:1543:b0:7f6:84e7:bd35 with SMTP id ca18e2360f4ac-82a1103930cmr80772239f.8.1724875806066;
        Wed, 28 Aug 2024 13:10:06 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:05 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 22/33] devtool/upgrade: rename RECIPE_UPDATE_EXTRA_TASKS -> RECIPE_UPGRADE_EXTRA_TASKS
Date: Wed, 28 Aug 2024 16:09:08 -0400
Message-ID: <a4432772e921bcdfa36fd0d50f4df54026fdae9d.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/589

From: Alexander Kanavin <alex@linutronix.de>

'UPDATE' as a name is somewhat unfortunate as the variable is intended only for
the 'devtool upgrade' operation and devtool also has an 'update-recipe' operation.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 4467aa0661e233f44c4ce029428c67d88fccfc07)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/cargo-update-recipe-crates.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/cargo-update-recipe-crates.bbclass b/classes/cargo-update-recipe-crates.bbclass
index 12039f9..5de978b 100644
--- a/classes/cargo-update-recipe-crates.bbclass
+++ b/classes/cargo-update-recipe-crates.bbclass
@@ -18,7 +18,7 @@ do_update_crates[depends] = "python3-native:do_populate_sysroot"
 do_update_crates[nostamp] = "1"
 do_update_crates[doc] = "Update the recipe by reading Cargo.lock and write in ${THISDIR}/${BPN}-crates.inc"
 
-RECIPE_UPDATE_EXTRA_TASKS += "do_update_crates"
+RECIPE_UPGRADE_EXTRA_TASKS += "do_update_crates"
 
 # The directory where to search for Cargo.lock files
 CARGO_LOCK_SRC_DIR ??= "${S}"
-- 
2.46.0


