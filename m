Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E498FD8779
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 23:29:23 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2787.1773790158786553497
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 16:29:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=0sWzFPaC;
 spf=pass (domain: smile.fr, ip: 209.85.128.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48541edecf9so68495365e9.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 16:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773790157; x=1774394957; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvpV1Tr4O7U/6z/1aU1gcXXyfUExzLHM4npixVSrbG4=;
        b=0sWzFPaC7rzQoTX4Gq72pnlfadUAbAxmmw+R8Ssrops9tt3XY0S4ywwEXLGJDXwwEu
         4ReWmt4SILIx3iDRysex9DTUbIO15UryUEli9ILpJRCiT+VAwO+EWHBacfxN2MQP1epQ
         TnPVUzGLc0/LFzJowu4F11Bdv1e5+m30WKNH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773790157; x=1774394957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yvpV1Tr4O7U/6z/1aU1gcXXyfUExzLHM4npixVSrbG4=;
        b=E/m9jzdvp3+YvOK7eYZzq9nthVgVA+4hMPqlYTChIZ962mUcqu/di5FwLy/H5jpG3J
         7jnoOCssSa/ZazVEYIo/TkVJCtp870lsEf8Twb2IgUC8rnGgzxYv0R86YisOs0cTqT8W
         it+Qj7HazS/Az7wE6wQMatmlDP6eY2dWyvOw/tUyQMnfhdx9tlL1P5ZdOvho7bECfObS
         TS1ktmzBRE224pRTGlxB9036VODP/C3WwXVCCyU/VOgWefJM345YNOmtpV4vWBOqjs9F
         jMrY8da8GPJ9hTtTDwxOtD2/mXV7cMNgeDqCvMQTqViWJWmVFROQybr+yKXwHtQpvXic
         CmeQ==
X-Gm-Message-State: AOJu0YwczBdqunG+/Yk1x97X1OQ2BdxvmZbxELe4L0hMnAor4YzCh7sX
	Xppgn+a6bwYJxSgB+KuYSIpuUOxvEuQ9Z52CqF9ZE6Iswbly6SXikHWwHu/7yh3SKd6yg0mUKM8
	1ntWD
X-Gm-Gg: ATEYQzxHhOyUAM0B46gXoomjG3b8yZYvtf2Zt6pjwyY1Ls/F/6gWFMHHagZr2nQCrwq
	gt8C1BoqsKBJgNrRIfSO/qy0H3tY2CbRY9RA9Z6Uq1n/2IouvtrGFuiZqSfFwIM2XFeLcvOTIve
	08HwWReDqpSGHAp6O7xkEOLOxPEAhNviY5ert7KX/ycZw11kDxoZSFTzVXuqmJVtJDmFi7cEt+k
	c2R/Tt2JaWHomy8TqJrGn1urB9kjZW8gbqFswL5mN+mbjLAbdpjqB6cjkNlQNl7WDIumMo7VlO3
	E/8QZCrSLSVNuGZHyIsXbCS0HzHaMPzPdwpGAksPFco64yB9Wt5HWUq1uwhpp7KH/Qfmi8YdBX8
	eocERwjWI3omfMl3fQjRx9/1PUNY98s6gLJDei/IxEmiLA9nFF41jBvjxZEiXSeltM7hmcN09dV
	xc5yTfo+tDyDgdFDzoMOV/obLUIki2HzWPWj2tdu612LuayBAGGkpkPL5TcsQhQnFRBFFcYQfxQ
	Ba3sHt56fqI7cIvujDs6KPSlbJJVaGOWIGQ5Q==
X-Received: by 2002:a05:600c:4e09:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-486f4443e8fmr19655395e9.16.1773790156901;
        Tue, 17 Mar 2026 16:29:16 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892234sm2807644f8f.24.2026.03.17.16.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:29:15 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH v2 4/5] dashboard/bugtriage: Setup params before creating HTML elements
Date: Wed, 18 Mar 2026 00:29:01 +0100
Message-ID: <20260317232902.2404326-4-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317232902.2404326-1-yoann.congal@smile.fr>
References: <20260317232902.2404326-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 23:29:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3498

From: Yoann Congal <yoann.congal@smile.fr>

No change.

This is preparation work for the creation of a "View in bugzilla" link.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/dashboard/bugtriage/index.html | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/bugtriage/index.html
index 12c0c9d..758284d 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -541,12 +541,12 @@
       const reloadButton = container.querySelector('.reload-button')
       reloadButton.classList.toggle('spin')
 
-      try {
-        params.append("include_fields", Array.from(fields.keys()).join());
-        params.append("f0", "product",)
-        params.append("o0", "notregexp",)
-        params.append("v0", `^(${ignoreProducts.map((s) => escapeRegExp(s)).join("|")})$`)
+      params.append("include_fields", Array.from(fields.keys()).join());
+      params.append("f0", "product",)
+      params.append("o0", "notregexp",)
+      params.append("v0", `^(${ignoreProducts.map((s) => escapeRegExp(s)).join("|")})$`)
 
+      try {
         const response = await fetch(`${serverUrl}/rest/bug?${params}`);
         if (!response.ok) {
           throw new Error(`Failed to fetch: ${response.statusText}`);

