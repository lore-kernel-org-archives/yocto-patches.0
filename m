Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC02E7718B
	for <webhook@archiver.kernel.org>; Wed,  1 Jan 2025 19:59:00 +0000 (UTC)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
 by mx.groups.io with SMTP id smtpd.web11.21152.1735761535693233097
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jan 2025 11:58:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aAYZMngv;
 spf=pass (domain: gmail.com, ip: 209.85.219.169, mailfrom: akuster808@gmail.com)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso15071995276.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jan 2025 11:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735761535; x=1736366335; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6tgAJmAIWgi7wFc6Zal8zI+s0yittYOWvO2I7VcF0uM=;
        b=aAYZMngvFONfVFrR4LyioDMGXEakkyaqwLZWsGxYezV0E5RFyKbIkatdbYiPuGhu0T
         cILoxz+36ybSxKMC2O2r38Ewnaw/XsACSfl9h0PVLJCZkPRAfUkTi1/AaioAoZL2zek8
         hHtLqf9SKHKCmdphA2aETZbaT0KYhO4vGTnxJ1Gy+fN8kePctKavI+9mz/NgC7FAtgZC
         OCvhxp8cyorE1WiOcTdbnVzJTRqAiWe+2o07yejR/Qq6WzIrUz59ITVB6hkS7+2icYrs
         cuitBTr3jWH34kifdxGrRBfs8e635aRDqRCJbWHcM0DerVCCA5YAn9WCIb2sKVWuOybY
         2Z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735761535; x=1736366335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tgAJmAIWgi7wFc6Zal8zI+s0yittYOWvO2I7VcF0uM=;
        b=i6VVEBlTXFtN8W14K/1TMPvsMPu8Ond0RoKxIeoAXwPW5zJbQZ7odWNQ3dTAI2kuaD
         2YRk8NemAkzE5xmqFKcqV7DhI5xegzCgnqzN+88mcXG5v0JEGgsd0+cvXuLMMGUDjSxF
         SiUS8InRmkKBWtc0e2vobi7+OG+TEogSrbMbQmZ//7K1zNE0av+vja5AlHxZbDk+IHA/
         v2SYgYT2qWBOTwcYFwdkY6yIrZS9QZoAUwi71ikONVcQOEEg+UuRCQZz6fKULu/dHh5O
         KfduDS2wvZoHnDpfAfs9xQ5NqV0P8LcnP3fpvarwmslgePpL4lmLsC87wRs7ifUVhWik
         NG6g==
X-Gm-Message-State: AOJu0YwijUWBa56xBhXGT+Gckmaa78h6JOdNWB+s58AERWDaHhV/yx90
	nNjlNvhNwhH/xPA0ifDsZ7JBOYkQN5sewsuKk4HYiWHf55CceP3Vdz97tyqe
X-Gm-Gg: ASbGncuyzSQJ2STfUumozy7szdfcl+cO/rwgELe6Eb4upXgjXTLO4O2Q6oKGEOt+lg8
	LY/Sb7E3ZbGWo1Edt5texwZ7/Pa0kAtxnNDp1nhkUITCns78izT+FB0roO2GO2wzhbJAdCAXw6o
	K/AVqnKzv3ZNnPFJHTAaHStP79qHrYUl3Ss96Ay0qsglIc3fXvzWmA0VEGUbmsEFMLEgYsZQ+mr
	khMk708onsh5aPPnwS0WoASnb3Tcpc48ghSvXUei12WhhOM7SvC4VrEEYv34orKblZflM8=
X-Google-Smtp-Source: AGHT+IFTJZuRayJ++fbcl6Btlf2eGPv8TEVeo5hA1FetNLH7CRejYFnJxrmW7n1pF+5NhRatjpRjkg==
X-Received: by 2002:a05:6902:2786:b0:e4b:3d71:3467 with SMTP id 3f1490d57ef6-e538c1f1d73mr21941341276.9.1735761534790;
        Wed, 01 Jan 2025 11:58:54 -0800 (PST)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:96f5:c643:ece4:950a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cbf425bsm7177487276.2.2025.01.01.11.58.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 11:58:54 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/2] packagegroup-core-security: drop firejail for musl
Date: Wed,  1 Jan 2025 14:58:53 -0500
Message-ID: <20250101195853.2653594-2-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101195853.2653594-1-akuster808@gmail.com>
References: <20250101195853.2653594-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jan 2025 19:59:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/963

appears to be a known issue:
https://bugs.gentoo.org/937374

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 recipes-core/packagegroup/packagegroup-core-security.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/packagegroup/packagegroup-core-security.bb b/recipes-core/packagegroup/packagegroup-core-security.bb
index 9eab063..764ec02 100644
--- a/recipes-core/packagegroup/packagegroup-core-security.bb
+++ b/recipes-core/packagegroup/packagegroup-core-security.bb
@@ -49,7 +49,7 @@ have_krill =  "${@bb.utils.contains("DISTRO_FEATURES", "pam", "krill", "",d)}"
 RDEPENDS:packagegroup-security-utils:append:x86 = " chipsec ${have_krill}"
 RDEPENDS:packagegroup-security-utils:append:x86-64 = " firejail chipsec ${have_krill}"
 RDEPENDS:packagegroup-security-utils:append:aarch64 = " firejail ${have_krill}"
-RDEPENDS:packagegroup-security-utils:remove:libc-musl = "krill"
+RDEPENDS:packagegroup-security-utils:remove:libc-musl = "krill firejail"
 
 SUMMARY:packagegroup-security-scanners = "Security scanners"
 RDEPENDS:packagegroup-security-scanners = "\
-- 
2.43.0


