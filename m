Return-Path: <mischief@offblast.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DDDC5B552
	for <webhook@archiver.kernel.org>; Mon,  9 Jun 2025 17:09:17 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.65219.1749488953486715837
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Jun 2025 10:09:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@offblast-org.20230601.gappssmtp.com header.s=20230601 header.b=HTkgzu6E;
 spf=pass (domain: offblast.org, ip: 209.85.216.42, mailfrom: mischief@offblast.org)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313154270bbso4800274a91.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Jun 2025 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=offblast-org.20230601.gappssmtp.com; s=20230601; t=1749488953; x=1750093753; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdeTrfI/LtJVR4i88rZWh3z7Tg9BLQC0FwNB7ZVSAcw=;
        b=HTkgzu6Ero3SY77TBlLKG0NtJzX1E5CvpAFXmMauaE9TnCgobqHc0b4vgVS+nCfNaj
         XEl1g1PTqkdlGRgKsJP8RWYQ1GoywaXm5mYSh7XZheCcnlucrr0eG//O8/Zxb4ikHk5u
         DecDFCovi849N9+I8ZKoO54GSiyV4DghhBwpSDC9UxPi333Q6/03pn8bCNUKt7KByC4q
         dMomkh6JugvQ6KpYi4OVd9dj7hacDIsiQm5QLLCu8EBQUWEQU37Mok89/MCfnG6W/Ih4
         tLYcGviw2zHuihkNI3TdeSlPBjns7IOjjHbeY8a3vBL9heObyh4lZoDjvrz9TZ2zevqY
         aGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749488953; x=1750093753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdeTrfI/LtJVR4i88rZWh3z7Tg9BLQC0FwNB7ZVSAcw=;
        b=B42CfdrRPctbaf9Kn9dKIGA4jg9l2dbAI0nyV6rJWodLcz2kf2bcHTAgbP1PuVpfSh
         ZUoQhg1LH5xUpp6G5BgN/csl7Zl9UXssGpUaIUgMkgDJSnpcbkVe5Ohw7DgLaMsylF2U
         +CCxY+jHb5jM+s6ueX7oTUOVbug8dSqmCgzk+744Toc6TAfPt8nlX3QZ8hXq8yGZt4D3
         V8UpO3P4WGU6INP2MXDKYCoWpkFC6U7gyXZObr4KAFg/b+I14t5/bg0I0pcZwQFG0zul
         85TNgux170gQQdUofiFcjFxxXwQoBflH2sLhITI7NqATPU1pbZne/n3b+CKPzNR/kM9p
         QKOg==
X-Gm-Message-State: AOJu0YwF9v2a9QcqYq3/9dBHBHJlK6UhIKN9wCGIatT2baKfIJQQbIwC
	jV3ppcDIDvdfxBSgxhQfKdlhsJI4OcWJ9mw9EhpLY7ONG25nj4fwDSZiNtXH3f/SqQ==
X-Gm-Gg: ASbGnctBuFBxfSG6v+psm78iRIv4PgOtYTQIC78QLh32QjOAoPmcm6KISFxS9m3U9Sw
	NWGz7p68DYVr8KI14Z79ShFNSTGjNV2CN+SfsfJLKjGashIxC/3RTnovrU4SqcTWwEWQvhcALsG
	kaAeMir06yIUxsDP9c/Ph0Mfrh6IEcKjFignksSfqyENGSeZsB+11bWCgq+zFNsRGM37OOWhzkC
	IvzdFQdRkreK87IzJIaRJQNFbHQ7/1cIscXVPwy1+awv5Ve5tZYVNW3NSQ0UPHwQVqSsWoCHXO0
	gG+Wl144dW2Kh9DlrbfF17PIBjSMuMP8bWo5e9pz9PwqakIIglHJixA=
X-Google-Smtp-Source: AGHT+IFt/x6pqDzutSLMdyIXqf5FrqpUY8vcK4bPwx2eO5BdWhrnQMEFR0NNAfZ1dDHxfvBGu5AseQ==
X-Received: by 2002:a17:90b:2650:b0:2ff:6167:e92d with SMTP id 98e67ed59e1d1-313476983e5mr18756835a91.32.1749488952791;
        Mon, 09 Jun 2025 10:09:12 -0700 (PDT)
Received: from fugu.offblast.org ([136.25.5.185])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-31349ffc1ebsm5970905a91.49.2025.06.09.10.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 10:09:12 -0700 (PDT)
Received: from megrez (<unknown> [192.168.0.186])
	by fugu.offblast.org (OpenSMTPD) with SMTP id 2e4f6a76;
	Mon, 9 Jun 2025 10:09:11 -0700 (PDT)
Received: (nullmailer pid 650464 invoked by uid 1001);
	Mon, 09 Jun 2025 17:09:11 -0000
From: Nick Owens <mischief@offblast.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Nick Owens <mischief@offblast.org>
Subject: [pseudo] [PATCH] fix _STAT_VER/_MKNOD_VER for riscv
Date: Mon,  9 Jun 2025 10:09:10 -0700
Message-ID: <20250609170910.650351-1-mischief@offblast.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Jun 2025 17:09:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1627

Signed-off-by: Nick Owens <mischief@offblast.org>
---
 ports/linux/portdefs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
index 9545550..1b4ce74 100644
--- a/ports/linux/portdefs.h
+++ b/ports/linux/portdefs.h
@@ -36,7 +36,7 @@ GLIBC_COMPAT_SYMBOL(memcpy,2.0);
 #include <linux/seccomp.h>
 
 #ifndef _STAT_VER
-#if defined (__aarch64__)
+#if defined (__aarch64__) || defined (__riscv)
 #define _STAT_VER 0
 #elif defined (__x86_64__)
 #define _STAT_VER 1
@@ -45,7 +45,7 @@ GLIBC_COMPAT_SYMBOL(memcpy,2.0);
 #endif
 #endif
 #ifndef _MKNOD_VER
-#if defined (__aarch64__)
+#if defined (__aarch64__) || defined(__riscv)
 #define _MKNOD_VER 0
 #elif defined (__x86_64__)
 #define _MKNOD_VER 0
-- 
2.45.2


