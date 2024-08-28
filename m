Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD2CC71129
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:05 +0000 (UTC)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
 by mx.groups.io with SMTP id smtpd.web10.5970.1724875799956657967
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=b3/R+MR6;
 spf=pass (domain: konsulko.com, ip: 209.85.166.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82a0f237a68so27018039f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875799; x=1725480599; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2aRiHBBbqAGPxrNtz4TGgHXcbGTf7YDFrIcsSNZge4=;
        b=b3/R+MR6TxaUKaUptOP8n+EzOvWgYXXCDLI0qA9qTO2Q1Niiu6CsnvkqeMADDNAqIE
         Qe+J7+Juwb4HZFUhhqhHvr3g5rDTqVpnsOYQsfeANfOLbrTiDvSKz5xc6/K9lcjDtFuv
         orv9MWWkG2HTyKHHxT7UEi7p7379UKD+wNAO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875799; x=1725480599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2aRiHBBbqAGPxrNtz4TGgHXcbGTf7YDFrIcsSNZge4=;
        b=xKfuY/dG2Imuex5YHbjhMIdL2SmskXN13S1nUi75boC9fDYt1z544uCO+fAfhJ48HM
         KDzY4ZD8LBmZumVjrRaLiVifolH0A7qnrJgZRKlF2snlxpI4OoqnBCnmpqZi8TGF0DZK
         95I2G4lsoSZd84XHPcaTparl5kCXuaFsXU9o9wv3YvJxmp3haiQVaqJRp/lyjHrhuojy
         DTW/+k+h6Tn1ICmv78JDElY9h0BFgqeW6PCOo346v1M8+VJV3YzmsR91asZZgfqiHhOl
         NmFsiWTR+MMw6CHzw3U8FkMoTK6iyieZAtZcy2RPYZ+1qidWtrPRXL3jyB/P0MljYzh8
         VWuA==
X-Gm-Message-State: AOJu0YzggGE5akLbJ2t9l5EI4btu/uAfbpE8HXTl90GhYbnQJpTJTihq
	yxStvrWYq6WG1LZdwzg0FLyPD+KzAkkTG6GkRB/QDPVmbCH23xBpxqkX0uKSDj/1xX3rV7SS0DA
	j
X-Google-Smtp-Source: AGHT+IENwbQTfOptuWTduZxzY5qxMbj72YB8ScU3EIiRilD9J2WYAGZi3u6TPnPzOAQRw+KI28Augg==
X-Received: by 2002:a05:6602:b90:b0:829:f6f3:f77c with SMTP id ca18e2360f4ac-82a11039184mr79041539f.8.1724875798891;
        Wed, 28 Aug 2024 13:09:58 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:58 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 13/33]  cargo-update-recipe-crates: add RECIPE_UPDATE_EXTRA_TASKS
Date: Wed, 28 Aug 2024 16:08:59 -0400
Message-ID: <0c76af5478317e99b1bbd696dc4fb051df373890.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/580

From: Tim Orling <tim.orling@konsulko.com>

When we upgrade a recipe that inherits cargo-update-recipe-crates and
the upstream Cargo.toml/Cargo.lock have been changed, we need to run
the update_crates task or else the devtool upgrade (and therefore
AUH upgrade) will fail.

Add "do_update_crates" task to RECIPE_UPDATE_EXTRA_TASKS for all
recipes that inherit this class.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 0156ab3e009fa789c629f6c0ab06fcf21add94f8)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/cargo-update-recipe-crates.bbclass | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/classes/cargo-update-recipe-crates.bbclass b/classes/cargo-update-recipe-crates.bbclass
index 5312264..12039f9 100644
--- a/classes/cargo-update-recipe-crates.bbclass
+++ b/classes/cargo-update-recipe-crates.bbclass
@@ -18,6 +18,8 @@ do_update_crates[depends] = "python3-native:do_populate_sysroot"
 do_update_crates[nostamp] = "1"
 do_update_crates[doc] = "Update the recipe by reading Cargo.lock and write in ${THISDIR}/${BPN}-crates.inc"
 
+RECIPE_UPDATE_EXTRA_TASKS += "do_update_crates"
+
 # The directory where to search for Cargo.lock files
 CARGO_LOCK_SRC_DIR ??= "${S}"
 
-- 
2.46.0


