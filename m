Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED66105F7AE
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 14:00:53 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16493.1773410448064965117
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Mar 2026 07:00:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=opd1ZkI9;
 spf=pass (domain: smile.fr, ip: 209.85.128.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso19560045e9.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773410446; x=1774015246; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyLS62qLx7mQ3DdaSfUYV5LShnWZFQRe7XJrhoyUpu4=;
        b=opd1ZkI9RhpNgE7lIgERC55Os8Br8QZZkWKZt/E/gYMRfqIUVJ2d3CuF1+SBqQAW6b
         Kji1wmkVCNpG6bjp4MsM8GzB+6oc9iJYYcSxt6uFslJCHzg4uHKnVIHLpIegmEllO7DD
         HXI6LrncrV0rfCT95OOvk8l18HDX5tArsMZbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410446; x=1774015246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lyLS62qLx7mQ3DdaSfUYV5LShnWZFQRe7XJrhoyUpu4=;
        b=EH2uh0/N+HJLaVjhGEK3uV8+PL+VlksIi2mJuVWdpp8cc3qHbF9MzlWd7Rmh/A1nr6
         qS//BIky8G3kY+uaG+yOJCG385M5Z1zmarzi47UqiYr0pdFUjemxklGfJTSex0RvdRcn
         qjlYYd33hBuhGC9HEKYUYWJ4gd/6dojVuDrZXMqp7I6e8v0EHYZksNqc+m8UNGBXTkZf
         0wWd5pRVfa7eRvx1OLyD2scCodGs+UP7L7whJoJmh3wJpfTKGP5upyju+s2vnY83nS4D
         8YbLc1deLwMTw/EzFeR4FSzCYPKc5Qxf8KUyaRzmgLoBPiwEMb935KF2LgxuQfhPcUN0
         aY4g==
X-Gm-Message-State: AOJu0YzdAYhjIcINyMDzs3cFxdK4ERh1KtJPhfZuRLCTHXfFZhvjemBi
	kfxmUh/kWS4x8djW+1Vbx53bAf8jU8MtO5YqBaWilNGKwzTwMaUFAHJ3eaZornJanYHNbQvoDMo
	Ggl+j
X-Gm-Gg: ATEYQzwVvI2Rz91xvzR6mZDjqpSk/8jPb9Bvn/5T0NzqR4OxK8h1NrM2wpAhQxheXth
	491+4gzNTYJCpchn/TmGn/ZhT85sn9E5w2SOqWno9TlaSl1MHJ0robsBwar/9f3mYypviBWitCU
	KMxqqBRSjGx/bBC6P3abI7t8EaM/TB5FVTGzF347QbTAJTcKNAV/4YYaUubP7f6K0bhhFELR6ML
	vRhSAK4YJKxnXDo681bB2wHhDOJDvJaaGk426BU6MTJs/gjcL6h0sFlehfzPdoG28b//h78puLE
	KvvnDs/znXqT7RY9OQ7kPjfnsmEfAiSRrgtAHc9iEe1qj3c7cLEPZBOB7nr5bv/m3XR7pRpDJrm
	Z8z6g9C8jTDJ8ITFgFEMB0hyEW/2WjTFq+NzVHhxgI2wOaKD2YwaM45rHChhrRic6BkhfXFg8Vz
	1sVfI4EsHo7xlwiZijcz/Rej4UvejrVU8GTnfFW5ZBp06l6sfjQZiCozuqH+mWaUzVEV99fRrzc
	12saTneVDGgjnMMDfIOi9KvsKMmzaexvhxo/+Y=
X-Received: by 2002:a05:600c:c162:b0:485:35ee:f836 with SMTP id 5b1f17b1804b1-485566c94a6mr54514005e9.2.1773410446049;
        Fri, 13 Mar 2026 07:00:46 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa001ac8ae6baecd7e1d.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:1ac8:ae6b:aecd:7e1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a0b2db487sm2056109f8f.28.2026.03.13.07.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:00:45 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Ross Burton <ross.burton@arm.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH 2/4] dashboard/bugtriage: Setup params before creating HTML elements
Date: Fri, 13 Mar 2026 15:00:27 +0100
Message-ID: <20260313140029.805927-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313140029.805927-1-yoann.congal@smile.fr>
References: <20260313140029.805927-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 14:00:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3455

From: Yoann Congal <yoann.congal@smile.fr>

No change.

This is preparation work for the creation of a "View in bugzilla" link.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/dashboard/bugtriage/index.html | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/bugtriage/index.html
index 8e2d3a0..72090af 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -238,16 +238,16 @@
     }
 
     async function searchBugs(selector, params) {
+      params.append("include_fields", Array.from(fields.keys()).join());
+      params.append("f0", "product",)
+      params.append("o0", "notregexp",)
+      params.append("v0", `^(${ignoreProducts.map((s) => escapeRegExp(s)).join("|")})$`)
       const spinner = document.createElement("div");
       spinner.setAttribute("class", "progress")
       spinner.innerHTML = `<div class="indeterminate"></div>`;
       document.querySelector(selector).replaceChildren(spinner);
 
       try {
-        params.append("include_fields", Array.from(fields.keys()).join());
-        params.append("f0", "product",)
-        params.append("o0", "notregexp",)
-        params.append("v0", `^(${ignoreProducts.map((s) => escapeRegExp(s)).join("|")})$`)
 
         const response = await fetch(`${serverUrl}/rest/bug?${params}`);
         if (!response.ok) {

