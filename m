Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C80CFF6E9F
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 23:29:23 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2785.1773790157808153905
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 16:29:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=LBGG0MJq;
 spf=pass (domain: smile.fr, ip: 209.85.221.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b40fb7f95so2722500f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 16:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773790156; x=1774394956; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkG03YUdX4+GWYnD7QxSfCH/aFqUV5Ld65zmjMd5IXE=;
        b=LBGG0MJqg6uyH07hcnw5AUyHkmnCMLCYS90yHv2yNMYUTd6leI1V8pUVfUFsSLpxSL
         Wr3FElHKY89yDND4DA9sJL7a8RVaQ6wgC68RpYlEZ47OebS8ZlAMq0GnGrhwL/YXWUVk
         WzpaKuV9JEDtukrnxJbzQ8VAAJ9Szg2R6rTAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773790156; x=1774394956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pkG03YUdX4+GWYnD7QxSfCH/aFqUV5Ld65zmjMd5IXE=;
        b=tYSfOzQ9jROJylxOBAw/2rqnvHREuOuIQJrCZW/4eO12/mj+7qAYGx07Y961gELs/G
         XgV3C7fAxWmjO6nGFd0QXfFlDWS8dslN2oX7lx6JzUuNJlCCKvKRS3+jLvBaCzr7ILCN
         GOigzkpzYnys38ADtO4BqFIH182/f38TOk7I2SybvSRBJkjIgg66z3BfKZKPg6GGLXdI
         mxzv1mdashSF71voUpzkToF1f02WyD4lH077D6BJpWB2rfCj00lN9LRBywZH8QBJxGqd
         naqWtroSUEEeVA/NsEEh3d0HZi1ZlMl5pcebWnQS1T4b+SXkBXyYJXCgWHKQOQTS486H
         fufw==
X-Gm-Message-State: AOJu0YwA3ivIJ/Vejgm/SUC5GlbOHZmaJK8zeHtVlU/CxajMN1X3ZpXf
	mX/ATVn245pA1N0YWk7UAutEteKXkLx2KP0HnqhppP9J4s0bh9gbmHyelLG1DrPPamlYFE9rYe0
	w/a0K
X-Gm-Gg: ATEYQzyeyccwlnhqVISdYULqZqhs1a4ix7ffV6kkWRlCFYrMDpw9tm26w5xT5IELZwC
	4qTUBEfpblNXBLUvfJMCxu7bMjsgKEIkN0E/2xLsV3cc4Mpk+ic1dEilw64h+zOl2EiA6KbKaTp
	3nEZvX2NpUEmY39VF1lA166ccdpzmvYpZMZm+ox6vBghEj3NRaSjtEB5ilsMQMZIoGAJkO5s8xY
	ooaRgY3EsBUkLQSV8mmjbNX/jbbPlNtiAyDleGn0uJ8Q+W16E8GvYZc19sA45lEqE19F+EyYfPG
	k8/5Xy8oSnABfNMwstE1LedVzrMH2S9EwRSkHeBK34vDUFChhbljxtAHPvCHdX7hJ05U0V1P+KX
	l7a3f6LzDn0Vs9u+u0UReRF8A2PLDwxeR6+p6miM0CU1RMZF9l06jNksL8NQcTWY+32DPWpCSk7
	we3ZSr4eW5HWlIuqdDn+1DZfxtaryC6rBXSqa/Qj8RfCfQt57YfUucMrJDQS4IJ5lPINH6z4s9f
	tnq3Vk2/y94lHeI+K0Sse9nOls=
X-Received: by 2002:a05:6000:4284:b0:43b:3d80:b0b7 with SMTP id ffacd0b85a97d-43b527c8178mr1510969f8f.42.1773790155806;
        Tue, 17 Mar 2026 16:29:15 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892234sm2807644f8f.24.2026.03.17.16.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:29:15 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH v2 3/5] dashboard/bugtriage: Use websearch-compatible operator
Date: Wed, 18 Mar 2026 00:29:00 +0100
Message-ID: <20260317232902.2404326-3-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317232902.2404326-1-yoann.congal@smile.fr>
References: <20260317232902.2404326-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 23:29:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3497

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
index e62d211..12c0c9d 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -564,7 +564,8 @@
     async function bugsByWhiteboard(table, keyword) {
       const params = new URLSearchParams({
         resolution: "---",
-        whiteboard: keyword,
+        status_whiteboard: keyword,
+        status_whiteboard_type: "substring",
       });
       const bugs = await searchBugs(table, params);
     }
@@ -579,7 +580,7 @@
 
     async function bugsByStatus(table, status) {
       const params = new URLSearchParams({
-        status: status
+        bug_status: status
       });
       const bugs = await searchBugs(table, params);
     }

