Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C631D2ECE5
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:32:03 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44162.1768854721030174665
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:32:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=RiUVsBN3;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c5320536bfso495577585a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768854720; x=1769459520; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbm/s9a0TuF3OSTJ6hovUZIJmzQ3SjBPJVAQyNRxaTo=;
        b=RiUVsBN3EP/ZM1TObI1k19j7hNInKcc+EwCdmVZhPxA4Ly2JvHverN/dJwWL5jOkfF
         danajN75p1t5okB7OMPTYGClIovDoAQVgJKD/adCXwSOWV938A+kZTfEe8QJswqNvUPx
         2f/tfPon0vzwDJkF89i+ntTceFQkfy6jZ8xfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854720; x=1769459520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gbm/s9a0TuF3OSTJ6hovUZIJmzQ3SjBPJVAQyNRxaTo=;
        b=lKJSzgONisQMXWHyX4r6RPSuK3wySH/NBiTGPbvkQpLGB5wG+NPbxfFpAGoeolkpyx
         /HArUWAzQwgG62QWgM2ZTIjmMLcklKajJwHS/NORpp4KSoGpY9PkCa0rSWH2Fvx0VNQs
         3iKSthOkem40+awmkBeD/QKg4Q24kyHx2E+dKqNxsrLxD31rFaP+hS1ABONlYiFWgh0a
         zNvgaXcfnIRA/X7J29MxXo6DOt7QaecDHlX4sJO72ZkYi+HNWRBlj2BowHqfHUw1ma86
         PVn26fnNihBXsorDMFs0pTy03XN08Q9EISkWWCnB7yPcyhCRwXyDuOV7m+EN8xDW09wK
         qTxg==
X-Gm-Message-State: AOJu0Yy6KXt57smh0Uak2elzkV10gcHv8JsyWEkl2xEoESCMxvunEGiQ
	mK07Fd6+P33/gZV9xKcj8qLP913YfuGS+0Y+tBo5e/7qk4MWNqqByVcLtYw8qO64QuHCSrmoYE0
	kLz1F
X-Gm-Gg: AY/fxX453ukWhOchDdCDYbGe7x2N2ThYkXhTbkYEm26+I9qPB0xd1gx77DFdjmStngO
	U1ooXKMykzccG13br6bmS1rYsvIr/WvF3n7Lt0N1WvR9DkuTShuFxfROHonfc7NTsmVkFKg1aYw
	QQtqkZeQUq+5XfdeKSbzh+S2h8VvU8DZvCdVV5QLf/D1T3G5FROOoTQti8gQOhAKUcEser0eGSl
	NAVTElt2TC5/2CVTrNEQEO6qgahXR7P06XX5aFZ2h7llRRLRmfKhiRNdvkff3rQwXxlZ4YNHqEf
	Zd0wS8kzAVTP1++pEOuMnhyuTEdlTw8xjrA4UklAlcad2saIG/vXVu7UTCbRnBlz8Toacxw+/RZ
	0teN6DS85pd1ACoxCGqKdnw2ePbcHu9+U9+T9wN0w9NOTPedf2PP2pyHHH0+A4TYJizWfipAbXd
	xj9xBbkRWDdUsvgSSFwjggOd7WkxLg5upxX8ZoqFMjScQJvdflpxIwmXHbogDlLdxeaW7iZpb0s
	K5oDRWwtmn/Rb3XUkoH5kg9AXhZ8k4ZFZ6sYsjMje509fNVx7lm
X-Received: by 2002:a05:620a:7014:b0:8b2:ea2b:923c with SMTP id af79cd13be357-8c6a66e90afmr1739391185a.14.1768854719843;
        Mon, 19 Jan 2026 12:31:59 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7248dcfsm860337485a.25.2026.01.19.12.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:31:59 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-lts-security][whinlatter][PATCH 1/3] lynis: upgrade to 3.1.6
Date: Mon, 19 Jan 2026 15:31:51 -0500
Message-ID: <0a448b7bc73b26aeb659bc1fdd4c90049d7d51bb.1768854613.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768854613.git.scott.murray@konsulko.com>
References: <cover.1768854613.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:32:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3019

Release notes:
https://github.com/CISOfy/lynis/releases/tag/3.1.6

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-compliance/lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb} (96%)

diff --git a/recipes-compliance/lynis/lynis_3.1.5.bb b/recipes-compliance/lynis/lynis_3.1.6.bb
similarity index 96%
rename from recipes-compliance/lynis/lynis_3.1.5.bb
rename to recipes-compliance/lynis/lynis_3.1.6.bb
index 51414c0..722072f 100644
--- a/recipes-compliance/lynis/lynis_3.1.5.bb
+++ b/recipes-compliance/lynis/lynis_3.1.6.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
 SRC_URI = "git://github.com/CISOfy/lynis.git;branch=master;protocol=https"
 
-SRCREV = "380b414e09bbca70be59a1b7ddccfaed4c30e1aa"
+SRCREV = "06153321ea50d53a27446084e646d9f43fe46e0e"
 
 #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
 
-- 
2.51.0


