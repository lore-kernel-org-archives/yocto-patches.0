Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7532EC6FD3F
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:05 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
 by mx.groups.io with SMTP id smtpd.web11.5844.1724875795916699938
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:09:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QPRzBDTk;
 spf=pass (domain: konsulko.com, ip: 209.85.166.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81fd520fee5so268497039f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875795; x=1725480595; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIp2WMnBrPxFFBJNryU5vaG+e7Wbqmue5OnhuO8YHgk=;
        b=QPRzBDTklNjr4LSrusyBa9nOk/b0k9ExVoCOQendWV8ytXpAkmXUOdEL+FKc6yQtxW
         vgPWe/TZKsopY9c0mNqMJOswILQaHnBrfPIt5Z7c5ddnJ8XDx5wLSsZ9vQNi5mXOkZjR
         Uu6aKlYMIgikbm7orGpdLszWH+Ow0vmKOTRA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875795; x=1725480595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIp2WMnBrPxFFBJNryU5vaG+e7Wbqmue5OnhuO8YHgk=;
        b=G7HU9eScvav9Rj+pa4afbGBf5STXES7GbTUtvJV+IV8YSXK2OUQ3Yu9i/douABpqEV
         WG0FMKFAaS/nc4LWMeoZYRK5GoC9Rjs6mKyknJWg4TyTKxQ7SG51zsnXMvt+RoglfFTr
         s7W+UIB89+TBy4IxNKCxTmDAqLTAduynQHcTEbT9G3HrBgs+ZTvr4NZ1UaJh+cApjUIJ
         N/0HbY9UO9dUPrE8NjAfBl1iR6KXD+nYMbrW+bcGlVHqTGhS5Xb3s7Athhv9cHzP6j0Q
         /ThvLZEwqoCcYeQBRhBjB1ICFt/UjYEQ0vgcVqoJkeBu0tN7S7CjBW0kQNR+LItSdOjT
         gDtA==
X-Gm-Message-State: AOJu0YxJ3jJ9jzwPfqXoGtw89PkgVPqs/A8jKp9UklCGbTKwHfCiNXHx
	KrXSQht5I9ihJfsPFIYkOs7PXxbQcvfeoaSLGHZzce3ccoU9OxAOI7BzyP0WRWWJQmuqMFRL5gI
	8
X-Google-Smtp-Source: AGHT+IGWB8JkD5ElQz6vvtCNT+9GfMmP1BIk8cU/GpTrswF+qUPNKC1ESam6JEKTgCeISEoxIJ5SJA==
X-Received: by 2002:a05:6602:2c0f:b0:824:e864:569 with SMTP id ca18e2360f4ac-82a1107a833mr85261239f.11.1724875794957;
        Wed, 28 Aug 2024 13:09:54 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:54 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 08/33] rust-target-config: fix feature for vfpv4f16
Date: Wed, 28 Aug 2024 16:08:54 -0400
Message-ID: <caed8bdd8ba9e155ced3ffdf085d04ba51c219d9.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/575

From: Willy Tu <wltu@google.com>

Based on [1] which fixed the target for vfpv3d16. Adding the support for
vfpv4d16 with the same set of changes.

Tested with running tokio which hit coredump before the change. It
worked fine after this change.

[1] https://lists.openembedded.org/g/openembedded-core/message/185702

Signed-off-by: Willy Tu <wltu@google.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 8fb2f9f60962339c877949f619e1e72d33bf3080)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index 63fb2a7..38fa761 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -21,6 +21,9 @@ def llvm_features_from_tune(d):
 
     if 'vfpv4' in feat:
         f.append("+vfp4")
+    elif 'vfpv4d16' in feat:
+        f.append("+vfp4")
+        f.append("-d32")
     elif 'vfpv3' in feat:
         f.append("+vfp3")
     elif 'vfpv3d16' in feat:
-- 
2.46.0


