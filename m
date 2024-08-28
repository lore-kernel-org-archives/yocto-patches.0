Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6572BC71143
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:16 +0000 (UTC)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web11.5858.1724875808003138353
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=cpVFUtBp;
 spf=pass (domain: konsulko.com, ip: 209.85.166.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81fd9251d99so268477539f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875807; x=1725480607; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1wEIW+QKad4FMJnnZRD3qPnKiKYoPM3uYz8HMnSu/M=;
        b=cpVFUtBpEK77FAxHU/KiTsINKLsrQ/4WL7BHDKdg3wPnzsBvyF62zWoQ3LRQEFORj/
         pZO8sgbOVHF+0IV3G51+mx92r4+Xe3nmtzgCQaI1YDJFeumSGWy6bqJbKcOMBQq1DokG
         StEnCrK3xcPrpVUQTY0ks0L3PS7+JFl7dZxm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875807; x=1725480607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1wEIW+QKad4FMJnnZRD3qPnKiKYoPM3uYz8HMnSu/M=;
        b=MsguqTPS3EUSoapYMbg0b7eHUVugn/CtkXs6dLbnv7r3VpebxVAB9VHIesztHNYn7K
         X4lFFHTK3Zc5HBvXsxjnbgR0cy0eWJ5afJeV4kmrqR8mmmi9hq4p2aJNmsi7b9kgZrPL
         KAYAJXR+U/6KnhgYStXlQuTF+5VU7iEWCOF/YIpSS7OoyuFQogyerapDeCXbGp43dJFX
         AqSiPSmn1Fzvu7DpRWimYdSVaNISXPITR24ebfXaOSARE/z86B5DEtLDwk+gFkmb9FxE
         lT+oXcagovZBPWBGbsLTJVDDHsV4pcM7Qb+0ft9QDzo+SKl94X+9UxWWXLZgBccL3ZBV
         JjnQ==
X-Gm-Message-State: AOJu0Ywtsq58spFpHsDVuUdhcxQs6s56Vl6iEZeMDB9rkUGvnk2opK7h
	icyODEY17fa5cdq6fFgVhWQNSdfAdBgt1JvR7yVnzzb3QTGMTQJkR5bEc+EAhSAa+JKO9iGcv9O
	L
X-Google-Smtp-Source: AGHT+IFXjLIMzunp1OXmoDvDRznYxTJZ3jabP8nQivgTMYq922VtrP1tc6WJzE7U1S6p2bAAd6+qkA==
X-Received: by 2002:a05:6602:6215:b0:803:cc64:e0d4 with SMTP id ca18e2360f4ac-82a10e15774mr83545439f.3.1724875806959;
        Wed, 28 Aug 2024 13:10:06 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:06 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 23/33] cargo_common.bbclass: Support git repos with submodules
Date: Wed, 28 Aug 2024 16:09:09 -0400
Message-ID: <9ce8fea7891c6d82293b10caa6a22ed83903e8a3.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/590

From: Chris Spencer <spencercw@gmail.com>

This is useful for cargo dependencies specified as git repositories, where
those repositories themselves have submodules that need to be checked out.

Signed-off-by: Chris Spencer <spencercw@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit f871d9d6094ec0001d826e4b5b3395c1842631bb)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/cargo_common.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/cargo_common.bbclass b/classes/cargo_common.bbclass
index 92731c2..15f848c 100644
--- a/classes/cargo_common.bbclass
+++ b/classes/cargo_common.bbclass
@@ -142,7 +142,7 @@ python cargo_common_do_patch_paths() {
     fetcher = bb.fetch2.Fetch(src_uri, d)
     for url in fetcher.urls:
         ud = fetcher.ud[url]
-        if ud.type == 'git':
+        if ud.type == 'git' or ud.type == 'gitsm':
             name = ud.parm.get('name')
             destsuffix = ud.parm.get('destsuffix')
             if name is not None and destsuffix is not None:
-- 
2.46.0


