Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35448CD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 03:57:42 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12704.1779854258914014088
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 May 2026 20:57:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=N+rKNr6I;
 spf=pass (domain: gmail.com, ip: 209.85.210.182, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-836ebdeb969so5046813b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 May 2026 20:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779854258; x=1780459058; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=parPfGNXu1+A82j1xQPMNH4CLtHQ+NlFdG0hfz00D40=;
        b=N+rKNr6IxY8OF1nQzZWWh/4rced6QmogTXTWG76Io0V29oqV5iaxav7xYxvokNbYUG
         SsUpiRFcB4QdrYUuUKFUavwSa1wLpx5rgFdAak+xjLU3Am4ZGOVVqReYJCtI1up4e3Ra
         FSye8h9PD2H+sZ22tjd7z1SbsIKEBgC0MfD4hV96e7HhNteWFt70hqy9crSvtgal6R0N
         ixFWVAjSwT3bSNQRLqdznbN/28N2JSzaYiAQ2iz+DLpYSKrDMqQZeWOgvzzFiCVyVNOe
         eUGGgZ/i1CfeEP0PFw6qNKXjRJUFgfaoDy5+7AUsklb12K+jYoqBW3MSwOys2fBAsIxM
         EtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779854258; x=1780459058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=parPfGNXu1+A82j1xQPMNH4CLtHQ+NlFdG0hfz00D40=;
        b=ijQeQe29mvAhFrVPQajJ7D+2BTGgrJURRpUM0eXToUngsE2u7c8MiUWgbpf1QGXsPq
         KaG2rjQuCm2HyqZasaHyEbJXTRJTFL8j+HYuaMVNeZoOtMl2C2FEDnX0+2vlA409npov
         6t3ivRh4OXaDZnXfVkIBc33f5M6mUryAU8V5pLaXEL22YMbPenbWoWMahZG8dtOsqoZA
         KkGaiEHyd4mW71KCj+h2RA/ePsFhEbIVqtKDFyNXFggNu/Pqu0Ysc7n4XqGw71QZaEnl
         yKVWsDMSVphQTjOBrfZFzFDTmCeDBfMlPeJ3eKU58UoN1IO9yrGT8RiY31SRCk7HlT02
         716g==
X-Gm-Message-State: AOJu0YxE5yD2ijK2jUu+kbLdwYg91t3G1uVKzkXuYG/SJzX+pGThmGum
	+1ar8A6Ux6I8/4r/7vlN2/6MKPsMI6OB4tdam8cw/8eTNVlzMZ2IAjXAi4SU+w==
X-Gm-Gg: Acq92OHa/7wCOYbBdMeixBy0VBzzwGZpxvJo2g8amRb3+CBXFKCrNFruewgPBEjo02Z
	TrgxzHQJEK79V+HDhsqyI22HMnUeLY7aFzaFgt4YrtMijg5Egbkqiq5uxVfFHKmDl7AHcWCGqdR
	cvJedr9vkMHAnYXJsfcPJU3K2IVJ8G8vVc5I/f8P+VvlwNmeDmwX5NFaVlbetHwMjJn+bbBqWpJ
	6u+9Cmy6FhWAHQTcTXUyj4Z3OCDLslvd0UHRp2gyNGRDt0k8/o0meqQRB1ggPPuVaC0DeQ9Dyy4
	DhsuwQ8BuXMVq+PhlCMpDKXKlNQrMCk2bLQyhFxBgtG2lRYfBXqTmrWct+zhNWHWisODd5O1KBp
	yJmuIrum5BgMCvbeeeiRY29M8a+cJJ4ZujQ2kNsaKd1IFDCB3ez4ZjtL1XU8rEajo8lywareC76
	V/SniloB17BXPZ/Yj/sbp/t9+KTMSsIYg/2+bJWA==
X-Received: by 2002:a05:6a00:368d:b0:835:3949:3c1f with SMTP id d2e1a72fcca58-8415f32e062mr20409582b3a.24.1779854257758;
        Tue, 26 May 2026 20:57:37 -0700 (PDT)
Received: from LL-868L.kpit.com ([49.206.135.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70f17cbsm757174b3a.45.2026.05.26.20.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:57:37 -0700 (PDT)
From: Jackson James <jackson.james9803@gmail.com>
X-Google-Original-From: Jackson James <jacksonj2@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jackson James <Jackson.James@partner.bmw.de>
Subject: [meta-lts-collab][kirkstone][PATCH] cargo: set CVE_PRODUCT
Date: Wed, 27 May 2026 09:27:21 +0530
Message-Id: <20260527035721.205797-1-jacksonj2@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 03:57:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4061

From: Jackson James <Jackson.James@partner.bmw.de>

This removes mediawiki:cargo CVEs from CVE metrics.
* CVE-2026-39837, CVE-2026-39839, CVE-2026-39840, CVE-2026-39841

Reference: [https://git.openembedded.org/openembedded-core/commit/?id=a5cb71e7df95925a5c342c341e699e244b1b84f6]

Signed-off-by: Jackson James <jacksonj2@kpit.com>
---
 meta-core/recipes-devtools/cargo/cargo_%.bbappend | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 meta-core/recipes-devtools/cargo/cargo_%.bbappend

diff --git a/meta-core/recipes-devtools/cargo/cargo_%.bbappend b/meta-core/recipes-devtools/cargo/cargo_%.bbappend
new file mode 100644
index 0000000..f175229
--- /dev/null
+++ b/meta-core/recipes-devtools/cargo/cargo_%.bbappend
@@ -0,0 +1 @@
+CVE_PRODUCT = "rust-lang:cargo"
-- 
2.34.1


