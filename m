Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA6AD2ECE3
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:32:03 +0000 (UTC)
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44400.1768854722860861582
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:32:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=uHSYGFLV;
 spf=pass (domain: konsulko.com, ip: 209.85.222.194, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c5384ee23fso505553785a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768854722; x=1769459522; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIp53e4wLwyAMivLd+6OyCTeURFJ7r5eBjzgCvqJMt8=;
        b=uHSYGFLV6TrR3snBUCdOnTr7bToDkEyLEl5nFKcxunPeggRObc9PF/2KlSZFuwKWd4
         gz+52KvXmnduL19wlXqgD3u7ArmqybYtgBTeqMoPWomO1W3uqvQX0eVHmSXY0cB58T1q
         xUeIa3UJquuLMKiMU8x5jHpSBPioFx3/8/OsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854722; x=1769459522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KIp53e4wLwyAMivLd+6OyCTeURFJ7r5eBjzgCvqJMt8=;
        b=Sa0O2oi/AsZfFqoDYJA7hc/BFQDEen06ZlO7HkZKf/elj4KijZy6lGtqunPMqQ9WVh
         o/FqSAWe+OHWTAMRbXbqCA39ONf5hRvBrNTPCb8zbrKQGl/QvDineO325ew1jwRDtWI0
         ebQHqgF1Clm65pgvpXMcOJDwhqiGMKKKH/GW0eYgvT3mq25Mq+jUnx2yRpUJHR+coH1x
         e6BGKnDR3ciVofbOjy922UdtL/YZj2h+kIJZEalOLhOiHt1BC2xorBNe+Gr+IvW5Ckrv
         FHqBEHurKHIzrAKCryzgfDglFxNixRxGFYbmdu+YXRbmKmmHw0rv1UUUuC5sLI2LU3Qs
         2MCQ==
X-Gm-Message-State: AOJu0Yzf4cSqHAMivUfZ4LV6NngkBhMY1y/l+t8FmjANqXtHbNWd2RnI
	grniEITfgwWAxj30nPFU21/36zteiQSTKXgGMBm0kSwnd8zQd4PIEvpDbhS+/L0YIJJqSSBz8sU
	NM9+AYi4=
X-Gm-Gg: AY/fxX6I5CSNs1iNtpsQ4eswXgzVBZpqhN3OkZaYDH9Ann6pLxKUpoenWNZh+aRiX18
	/hS9RHumLOVoBsmLZQ76i4pE+eqxGuh96oqrO2cPb2oQLRRLK3CeuwD6OiwtpAxj1Hbh6JjYA6F
	SMhTwHugi/0bpFjIVh5BuKT9L6JSjZ0rGLMvoyLooObwhyrYEGE05Gae4AsdR0vOW778j4awEW1
	auz74eUdSXjFwL3v9QwOLES9WLizJIK4p7ABDMzeodzlyqv3ESooHA200WOQFD+J+3RJGOW97+t
	RX4Q0DI7Gc7yl4i8KKEGSibJ1imo8lnIJcGufPoyCdXO5e1oyI5Bu48hppoC75GIIbeEN11KKA/
	EWFW8EcpDk1aN13gAM99wk6mlXg0aj9ZtuHNs4nfwDA4H9n+t0cv3OXXvsW/ZhrzJEBfPxBA33W
	cWUStgyjUcR650MP4N1+g8shlA58Se9ZAd8r8vmQ3Wwch40ckBWchaCSN0Dgm8EvLyA6dmjPt1F
	siPfGzbMLp6vHcWtzTLW5dW7Ygdh872pbKvgb9r5biToQYu2KU0I2e/skQYraw=
X-Received: by 2002:a05:620a:4805:b0:8a4:4156:17b with SMTP id af79cd13be357-8c6a694861amr1606891285a.70.1768854721649;
        Mon, 19 Jan 2026 12:32:01 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7248dcfsm860337485a.25.2026.01.19.12.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:32:01 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-lts-security][whinlatter][PATCH 3/3] dm-verity-img.bbclass: filter units from value part
Date: Mon, 19 Jan 2026 15:31:53 -0500
Message-ID: <18c6a7b5d836cc35c5131e33449b786111eceaf5.1768854613.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768854613.git.scott.murray@konsulko.com>
References: <cover.1768854613.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:32:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3021

From: Stephan Wurm <stephan.wurm@a-eberle.de>

This is necessary for cryptsetup starting from v2.8.0 which introduced
"[units]" in its output breaking the parsing of veritysetup output.

VERITY header information for image-poky-20250701085433.squashfs-zst.verity.
UUID:                   5dc16c55-79b8-4988-9d79-900f8e143f98
Hash type:              1
Data blocks:            40091
Data block size:        4096 [bytes]
Hash blocks:            318
Hash block size:        4096 [bytes]
Hash algorithm:         sha256
Salt:                   f670bf67a32f4f5a22e052d7bf84830f8d35ea24e2d52f585f6275207899153b
Root hash:              a7eab55b7933e347650671611e4b2a10571f2a28a1fb0fc8eae409f7a0d86693

This extends the value filter to remove the "[units]" from the .env file,
while retaining compatibility to older cryptsetup releases.

Signed-off-by: Stephan Wurm <stephan.wurm@a-eberle.de>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/dm-verity-img.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
index 47f698c..48557e9 100644
--- a/classes/dm-verity-img.bbclass
+++ b/classes/dm-verity-img.bbclass
@@ -71,12 +71,12 @@ process_verity() {
     # two parts into separate variables and process them separately. For the
     # key part: convert the names to upper case and replace spaces with
     # underscores to create correct shell variable names. For the value part:
-    # just trim all white-spaces.
+    # just trim all white-spaces and remove units.
     IFS=":"
     while read KEY VAL; do
         printf '%s=%s\n' \
             "$(echo "$KEY" | tr '[:lower:]' '[:upper:]' | sed 's/ /_/g')" \
-            "$(echo "$VAL" | tr -d ' \t')" >> $ENV
+            "$(echo "$VAL" | tr -d ' \t' | sed 's/\[.*\]//')" >> $ENV
     done
 
     # Add partition size
-- 
2.51.0


