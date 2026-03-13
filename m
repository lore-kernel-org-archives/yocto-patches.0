Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED9C105F7AF
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 14:00:53 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16495.1773410449109984517
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Mar 2026 07:00:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=qnYgy08J;
 spf=pass (domain: smile.fr, ip: 209.85.221.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b7c2788dso1404329f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773410447; x=1774015247; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRwFeRWyCVVFGcWZW6sGMDY7E/O6pIvsA9C9AM+J+n4=;
        b=qnYgy08Jdalj6GDWkxFh4m1NSXTPeL/Pp43zlRt5eBJoV/KCsrkjVMaY3b6ooifSGI
         KH0ibomusJoDvhMo9EUGdZfiOdAN0PeGkK1TQsUpnZhadVn3nMcEl/DFMZA8MnYQgcFc
         fP6jG9/Q9NZ2z441xSW/clfNX/+mwjxD5+jD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410447; x=1774015247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DRwFeRWyCVVFGcWZW6sGMDY7E/O6pIvsA9C9AM+J+n4=;
        b=Jxa94jjg5U3+PF+pxM1hvY/9aca+iiraezBLJ2C6Qgf5FBZCI+T1c6IV9B+U2MBn5D
         CGt+1scyd+n9nWj0NuHObT/EtgF13V1KGeqG/AzzGDsSqn2eK2Vt1mIp/Ejz+eI8gK0q
         iSYreXcGMoCOk1nuHDVP+YTEy2Ulq221LWMB64lD3cgKtFJv5XHirFAJFn8kYZ677g3U
         /DGmTYpecgqxEmIk+Bw56mGEZ1lqv+ombJ+N4+EumfvHFvx2NjzCyGDepJ1EwPaTWY6a
         U3iqCIybYzJJjLlwCuihbvcegm1dpAIRHtYozErwDX+ZcbiKbZdzpNjKfU2wucstWsor
         8MIA==
X-Gm-Message-State: AOJu0YxR3g3SpGwCwfdf/PC5BYiYWiZDrM/rPUfisMlKqmOddmH60uiR
	HUvz2uGFKDc/4a773qQ7XOBvX1DrKREszkdAW275kFVpCMHJk9Q4UxaFbLtW243kvou3daeZj8Z
	0CgpV
X-Gm-Gg: ATEYQzy0RYY1+2OxiHlSJMNIO8yTNKe5I9wiyXG7bZSCeFg0rB5fuWnkjmrN2eic+Wm
	TvEbxeYtXbjHBcvTvdiBLgCrPK7DYmXvoekLR7QoG0Uh6/EpHry6mCGT0BWxNeFDJRPUcQm5eaO
	ArstbHjR/Twe2MVyjc2Uw3lJZe5JJfLD0GNaumEEqSeOYbjFbU6NeJYVTI4QLadznzlQN9kFrKh
	suEB9oAcWp9z4GwYktKTm/aYwvAEpmHtP2Q/yPTDXo7QfC3BTxFCa6b1Q2QDerN2Ftcag2HQh5z
	1rJIW+fl0213a2Rk8ikM+brhsq4c+OCfGqblcS4DfRoHU5uA/D/XqCPJnLrY/pF8luQaVZPsACC
	UURVqvUzXaAuOjsevFtFYvWaxZSyRRd2zFmrVhbkwn61zyn6Xtoz6HUx015oerVnnadf36yh8dU
	YQVJMwtaCLDjaEy1htuRDDhCPw5/lG7VVXZ2GW4e61PNaR5eeprGptJ5RocbzSLVBjP/IhX/ooz
	8tL39K02NL4esAOdR9b7eu+JMY2
X-Received: by 2002:a05:6000:1a87:b0:439:d242:e8fe with SMTP id ffacd0b85a97d-43a04d7c57fmr6802914f8f.11.1773410447045;
        Fri, 13 Mar 2026 07:00:47 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa001ac8ae6baecd7e1d.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:1ac8:ae6b:aecd:7e1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a0b2db487sm2056109f8f.28.2026.03.13.07.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:00:46 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Ross Burton <ross.burton@arm.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH 3/4] dashboard/bugtriage: Use websearch-compatible operator
Date: Fri, 13 Mar 2026 15:00:28 +0100
Message-ID: <20260313140029.805927-3-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313140029.805927-1-yoann.congal@smile.fr>
References: <20260313140029.805927-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 14:00:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3456

From: Yoann Congal <yoann.congal@smile.fr>

Use operators that work in both "/rest/bug" and "/buglist.cgi"
endpoints.

This should not change the displayed bugs.

This is preparation work for the creation of a "View in bugzilla" link.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/dashboard/bugtriage/index.html | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/bugtriage/index.html
index 72090af..9a773aa 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -265,7 +265,8 @@
     async function bugsByWhiteboard(table, keyword) {
       const params = new URLSearchParams({
         resolution: "---",
-        whiteboard: keyword,
+        status_whiteboard: keyword,
+        status_whiteboard_type: "substring",
       });
       const bugs = await searchBugs(table, params);
     }
@@ -280,7 +281,7 @@
 
     async function bugsByStatus(table, status) {
       const params = new URLSearchParams({
-        status: status
+        bug_status: status
       });
       const bugs = await searchBugs(table, params);
     }

