Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A77DCAC5B0
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 09:35:40 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.12604.1758620131763411835
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Sep 2025 02:35:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XHIIozJ9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45ed646b656so46722785e9.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Sep 2025 02:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758620130; x=1759224930; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHmHv9Xx/T2O3qsZJkMTaEpEdrHPPkg8g9MukeN9kBc=;
        b=XHIIozJ9QcARwHCMpjfnRTGcEbhv1rMvuN6AxLdDBTo3/iN9fQMTVfy9xi6vFkywxf
         5fJrwyJbl7l5mUyarx/PM3VXX1HkNux0LpWgHE4JwYtEMj96huPFmRrvRh0ROL+nzcby
         SBQpSMefuW6cLnuU9Ex7Onl/tVzzAQ7mSmDDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620130; x=1759224930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHmHv9Xx/T2O3qsZJkMTaEpEdrHPPkg8g9MukeN9kBc=;
        b=YGtxkzo1VrgRFzAksnL+P3d6w7+8qNdXr/nQBfr8cizOhGKEcOBA79tBA5ZiDK0Wco
         9clbTMj7qS4a92MhywlYIZnz42mGpE3TzVLVB/MH1vLJ907RMSKSyw6alJLavaYZLN1y
         SVjjZWH4NAwBkddZAzzC5XzLZeZld3ys/azUvM64rn7yxKmkglj7Rn4+sveB4zQfYswU
         mFfBoeRbaCMJw7v5Mjq5Jw+qnTrHfx2NRShjtmJqXTRsB7VYlvmFuSM42ltvPZIBesjs
         Gs3uyXXgDPx3rE5pZnyVa7r/pZaGClbKOMcy7BUW/U+4Nqe2DE1rzzClbSifbumz5Dih
         TM4w==
X-Gm-Message-State: AOJu0YwoBz6QestU4rtw0ScLfYMN3FrrnkUzlpkJF3vIWG4bDPJLW9z8
	vV7/0QzCYTRlBO7NpwDCw+pWOMiBtEtqvtLXHq/Rk6qiW4ToyFtkEiUDyODcywJVQjxhg4ZDpK2
	UzoV/
X-Gm-Gg: ASbGncsskhJuay7Szak1jbGeqjsmjUzER+ImZr1dwDf78Ir0QQdnfZQDZRiYollnanL
	vQSiYYkzv/3GrrAdQTiJFQ1nlHr58K7GlR0ENNXAVhbJCc6jJX4tg1RuklLLN7t079AcECf6WZP
	dlp1NgY7qVncvssYVhbkuNHH6Rx3eXCFQLv9scWiT6Pc1qFRlvJMBw/OAU7F6S5/vyGSkJHR3ZF
	dZLrzv+xAYwBhiXiHdrmDv2iPinXb2RPlFogCasspBUfmCrMVBkOGmzzzfaVMAKoh02r+ZxtykC
	JtuxDOYbwrpmzb5qBxNI6EOslnEej5FDbeT/Wbf88Q0nC7f/E/5LMwptkNAx3YZ02aGMNPImLRS
	skUg61sv+Mo/n8X83qn7g2lqxyIxaaeq+0PqOBPGO7zw/RtzsZdI=
X-Google-Smtp-Source: AGHT+IEtmwpauhDDtj9TFNNbKXGTJs1oyIV18UYIx3MZWLBV9S4hoxdXMMuIHIynVuYFOaHvDGaZDg==
X-Received: by 2002:a05:600c:1c08:b0:46d:d6f0:76d8 with SMTP id 5b1f17b1804b1-46e1dac9fcemr23661125e9.35.1758620129600;
        Tue, 23 Sep 2025 02:35:29 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fe09:3ae7:900c:f751])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d14d212sm303264875e9.12.2025.09.23.02.35.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:35:28 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 1/2] config.py: Remove obsolete eclipse references
Date: Tue, 23 Sep 2025 10:35:26 +0100
Message-ID: <20250923093528.2384475-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Sep 2025 09:35:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2231

We stopped building eclipse plugins a long time ago. Remove
the remaining references.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/config.py b/config.py
index 559ca99f..3c81c372 100644
--- a/config.py
+++ b/config.py
@@ -5,8 +5,6 @@
 # ## Build configuration, tied to config.json in yocto-autobuilder-helpers
 # Repositories used by each builder
 buildertorepos = {
-    "eclipse-plugin-neon": ["eclipse-poky-neon"],
-    "eclipse-plugin-oxygen": ["eclipse-poky-oxygen"],
     "a-quick": ["poky", "meta-intel", "oecore", "bitbake",
                 "meta-mingw", "meta-gplv2"],
     "a-full": ["poky", "meta-intel", "oecore", "bitbake",
@@ -45,10 +43,6 @@ repos = {
     "yocto-autobuilder-helper":
         ["ssh://git@push.yoctoproject.org/yocto-autobuilder-helper",
          "master"],
-    "eclipse-poky-neon": ["ssh://git@push.yoctoproject.org/eclipse-yocto",
-                          "neon-master"],
-    "eclipse-poky-oxygen": ["ssh://git@push.yoctoproject.org/eclipse-yocto",
-                            "oxygen-master"],
     "poky": ["ssh://git@push.yoctoproject.org/poky", "master"],
     "meta-intel": ["ssh://git@push.yoctoproject.org/meta-intel", "master"],
     "meta-arm": ["ssh://git@push.yoctoproject.org/meta-arm", "master"],

