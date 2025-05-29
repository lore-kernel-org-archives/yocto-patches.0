Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35625C5AD49
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 11:09:06 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.18289.1748516936284714130
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 May 2025 04:08:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eC/HDLVm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4dba2c767so1303280f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 04:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748516934; x=1749121734; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wiNzgPnO4u7Y9jRptKR1TOEz4jzSFhUUbpPcTrHaE4Q=;
        b=eC/HDLVmpQClANLAbRBaKUQPeAW86nZQJvlIDyxAvHqrnieMANnCMYuHxMyBZ5UHUx
         i4VOi8NG1yPI02/JVU9/i+FM7SEgD24Glnsq7NEYrHJoTfOCx8ZPVWPEtkfVNJsYihX0
         K1kgpRS4ehJ9n0Kym9DvKxk1WsP/1vBnAsqc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748516934; x=1749121734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiNzgPnO4u7Y9jRptKR1TOEz4jzSFhUUbpPcTrHaE4Q=;
        b=cdfxElTDlDEayKaRnfoBp3sxxG6jDNdy04YufKkr6SaY3/YWq8ibald99K9C0jH5Ut
         gKKB6pqCLBrggpuHNcSw6D7vwimoXN9n5pW3mYF+z2afg4USa+PqBiCeercSbpAs889m
         88k3CkCjqag9tMsIAqt0k4SYQDdBUSdYr+uS4TmoBDi5JFcOgZSFAR66E8SX2Nmc4Top
         WWV1jXv9VNLQGdUCHo4FpAwwhSQhxIWZx3kalA2zmcHF+iCTAuKxzziN7It1RfBpXN8Z
         LAdrFz4Ez0W9N8cPV0e5aiscqLpRJbe71zBuBg8HJeP2K5tl4ekrUZQzV6RAiZSu9sv4
         Thhw==
X-Gm-Message-State: AOJu0YwYY70gk/FQT+q9PGQsqVf0Lja8dnVeWsGUmYzqGFDnD310nBxZ
	GeIDOumqTw2kqIIDyKX21AEEDUF/4Bqf2oHgr33SKlY/tT5S+CQvZ8ceCaX7qNgN0altIA3r83w
	f+IbH5+4=
X-Gm-Gg: ASbGncu7ybfaI0pzebf+aJZup2i9oznqakwrKbl/1hsQCFtGXJf0EiMWPvKFvlkjPAG
	87FicUuJus7Qdu407r+KN8fdPK6ZxVEWjswmpP9ciDvDml3VEebidiljeWjelFEqLF8ko323rbf
	1hU7lL0cc+1aNLlR63KNbmYPHcZy36E5vuHYKAq1UWvP8OxxlWUYUMgCHG9gk5Gq2Oaaw+WhLji
	2h8gZXdzDZZfDkf5ensQF2r0DzpsaJnYEsv6xldbCn7RrLC0lcYjaszl8G5e9vpxlTj+Z6k/JOK
	adt63ucwVLMErR7gihZVxMiJEkYuZDlwokwqsLyRqGDxLuzDVW/XzA6JwocSw/+oNjsjtiSQHwM
	xpBfiOAe99c6l
X-Google-Smtp-Source: AGHT+IE2pntJxCfQthn3X0mP4ZbNCTj7z2YjVDfbnYUm+GxZ0gVOfXnyTU4bhqbdo889zmdr00fMzQ==
X-Received: by 2002:adf:e90b:0:b0:3a4:d367:c586 with SMTP id ffacd0b85a97d-3a4eed992d3mr2103161f8f.13.1748516934007;
        Thu, 29 May 2025 04:08:54 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1a5e:81:40ad:9da7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b7f8sm1655674f8f.3.2025.05.29.04.08.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 04:08:53 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] schedulers: Fix bug in scheduler started job coverage
Date: Thu, 29 May 2025 12:08:52 +0100
Message-ID: <20250529110852.3072969-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 11:09:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1597

Jobs started by the nightly scheduler were failing as sourcestamps are empty for these.
This meant that additional branch specific target triggers were not being handled and
jobs were being missed.

Switch to using the yo_build_branch property which was the original intention and
should always be set, fixing the jobs being started.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 schedulers.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index 3f0289e8..122149c6 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -430,7 +430,7 @@ for builder in config.subbuilders:
 @util.renderer
 def builderNamesFromConfigQuick(props):
     #log.msg("builderNames: Sourcestamp %s, props %s" % (str(props.sourcestamps), str(props)))
-    yp_branch = props.sourcestamps[0]['branch']
+    yp_branch = props.getProperty('yp_build_branch')
 
     builders = config.trigger_builders_wait_quick
     for b in config.trigger_builders_wait_quick_releases:
@@ -443,7 +443,7 @@ def builderNamesFromConfigQuick(props):
 @util.renderer
 def builderNamesFromConfigFull(props):
     #log.msg("builderNames: Sourcestamp %s, props %s" % (str(props.sourcestamps), str(props)))
-    yp_branch = props.sourcestamps[0]['branch']
+    yp_branch = props.getProperty('yp_build_branch')
 
     builders = config.trigger_builders_wait_full
     for b in config.trigger_builders_wait_full_releases:

