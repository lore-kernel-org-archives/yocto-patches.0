Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2E9C02187
	for <webhook@archiver.kernel.org>; Sun, 19 Jan 2025 06:52:13 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.11466.1737269530002381658
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 18 Jan 2025 22:52:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TNT64Aa4;
 spf=pass (domain: konsulko.com, ip: 209.85.214.174, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2164b1f05caso64086775ad.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 18 Jan 2025 22:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1737269529; x=1737874329; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gK+N8cBYufRNNTAT/Ur0ggVQiT8qF/5+Hut/e1+E+o=;
        b=TNT64Aa4Mob4lpyVhoUin7j9zhUUkwbewvNAz+qpvB+1YldLvGtKsZQmwzlo4HzWik
         KJE9LkDOytkY3aVSFQBPohI2ZD0RaaZtC570CVBimWTJGMvslbPSTNHj0cgG+Ptc8sHD
         XRnsce/IeOu0AuXA5fXLReIH+a+dhD+IEZzSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737269529; x=1737874329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gK+N8cBYufRNNTAT/Ur0ggVQiT8qF/5+Hut/e1+E+o=;
        b=UqhXRtCSkJZobvoUsUcVEO6xFKHBEfTjcqKcdvezn7cnHHDEYarKNb8kSMWfkOn4P0
         3UUuBMG+PoWxkWfqrcpA5z8Vdzte5lxaxzRpqqN78vC/rw2yfLOyfrLjyxhanGbGVTWG
         6KMy/rcZrbuUEIYa9M5xE2ylzapoaeIPpcCYtKIlSN7ow7LaPfCvIUJw1wgxM/A1kPz1
         Gdo1WlhjhI7iEd2pPW9BKTNFkwfruhxpPvSSilgSE+Qsq7z+8BrUiGDn3D1fJ5v8f3CT
         iLjSlroDVOQat7cvyo1r7x6jNspmxn+ANbDb4RfCRDUiL/3AukI1pAPn4WtCdJURPR0k
         uBsg==
X-Forwarded-Encrypted: i=1; AJvYcCVwfSv8GNj/nONRYz49volrYNh3C9g5GwVI072Mbc0pBgfnXfq4slj+TvKdSIxY3UWs+mSwPBrhj1LaQ6S5@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yz0u3d1WztnXvfzzJiAFtIejRV2ow34eFDRTjv61G8coKm8/yyO
	/aw2dGAiD1QgzaSlMV0QN0ZVhTbAsf8kXXU7IAUSqDRUJjp1MPXlCZMEo/20LMk=
X-Gm-Gg: ASbGncsLPqkheOsz6qSWEpGrtpe076yBiNcTr4aJRjVq6q0+ktRdBY2Hsfzxe/13A9e
	F8jw+CVxTtmHnX9imvr2iHLODnsqlvrlFYL7vWtSMtYP7eiEWin4+e74OmhjRDN4oRsvBcj2Gmf
	d2El3i3b+fLwNKAAfM1NGy+jkGE0vs6UrlDQ86u4Iikb+yonhdqepjSzqloiEUMWs+g8J2oOgo7
	GlJj8Tm85CYdTnifNOtjbtbjl/PbOpITrszd/HlWwY22L+sbsIc6KNjhYT5mYNuJ/c9sZfgGbJD
	oytHCNPdemhkOVRkfKCLXPT4ZI7xPrjuag==
X-Google-Smtp-Source: AGHT+IHEXoKlGRAt3buPawRy7gTAlrLnSwyuAKlmQm/8nX5AxhkQYGVYH0ryszbd2KIKMnemRtIOmA==
X-Received: by 2002:a05:6a20:7491:b0:1e3:cf57:5f5f with SMTP id adf61e73a8af0-1eb21568535mr13356771637.27.1737269529267;
        Sat, 18 Jan 2025 22:52:09 -0800 (PST)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdebeeb3csm4464899a12.65.2025.01.18.22.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 22:52:07 -0800 (PST)
From: tim.orling@konsulko.com
To: openembedded-devel@lists.openembedded.org,
	yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH] CONTRIBUTING: move to yocto-patches mailing list
Date: Sat, 18 Jan 2025 22:51:55 -0800
Message-ID: <20250119065155.1947971-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 19 Jan 2025 06:52:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/983

From: Tim Orling <tim.orling@konsulko.com>

Since the definitive, canonical repository remains
https://git.yoctoproject.org/meta-java the official
mailing list should remain in the yoctoproject.org
domain. Move to the new yocto-patches@lists.yoctoproject.org.

Please remember to set the "meta-java" subject-prefix:
git format-patch -M -s --subject-prefix='meta-java][PATCH' -1

This makes it much easier to find patches for meta-java.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 CONTRIBUTING.md | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 5420797..00c7b88 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -23,7 +23,7 @@ for some useful guidelines to be followed when submitting patches.
 
 Mailing list:
 
-    http://lists.openembedded.org/mailman/listinfo/openembedded-devel
+    http://lists.yoctoproject.org/mailman/listinfo/yocto-patches
 
 Source code:
 
@@ -41,7 +41,7 @@ Therefore use something like:
 
 When sending patches, please use something like:
 
-    git send-email --to openembedded-devel@lists.openembedded.org <generated patch(es)>
+    git send-email --to yocto-patches@lists.yoctoproject.org <generated patch(es)>
 
 Please add the main layer maintainers to CC:
 
-- 
2.43.0


