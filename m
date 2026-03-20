Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65F7109879C
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 15:31:04 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15763.1774020657493516898
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Mar 2026 08:30:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ilTxKTyr;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: rybczynska@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so20506055e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Mar 2026 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774020655; x=1774625455; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8yzaxP6kfeN+Hw2otok1Szt3LZKQJwbvoDRF6vyey8=;
        b=ilTxKTyr4HcoxTAOlDXxXnQq9CB99Q4dluvBc/6IgaWlkICBTqtmf8qYFJOWkH4t+0
         tY8EC4mQRkEnKV5nRjQDLqVUpv3UhMi3TgGMUHkJkIKB8AzBvoTi8qHxF7MuyOlZ3lHt
         jeshj2SUgY6x5rIhwe+myCeGSzK8INmZf/EbrzWcLcohsh+Axp/9T6FY+38e51MTtizm
         h5Fut6aWdooYwkIAC6xiRRQvCybHLTrBAWs0Shyg740hDnBN3BGGpxYLt6w9x0VngC9K
         AbZu/H2MPmXNSd0o9Lpe8FDTDOVm8gIsu7yzF/ufVK+ccr77zjW+ev2D85RiNenV+HYG
         5UmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774020655; x=1774625455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8yzaxP6kfeN+Hw2otok1Szt3LZKQJwbvoDRF6vyey8=;
        b=TbA4CyfMbyfJ3tckhzZcwhI6YPPYRkWwk08SrEMidhIR2yAY++WouPH+8jvm9+O5ST
         Kxdq9qWOFzrSjCGBNPEOvW8/NwNRNKKOijXtkt8qh8A9u32yUI1crO8NCKa3ijCWRW6G
         OrXASGao10oi0XfUdpiMJm6fX4UB51Mb7R0ZAWlXNmeWGfkQ0qAtFJFT8xLhs5kwplWJ
         GK9bRPKSb/zkZJH0V2BEb/H/um9kPajnFvkGCTZNiZd9BuQygiI+q7/ErWeneIuFbxu9
         yaqyP1pYW6/EpMUYwV8b/0uYwDZuKk2MRuzlyBqDkMgGuoNdONuN3RXiy0pKFYardH1p
         TmkQ==
X-Gm-Message-State: AOJu0YzA5SidqPz25/2++AZLXhuN3UvAqB9RB1VCYNlbdGQ4cBI0AC5x
	0rPJMH92ot1ftEvtobd5jkZWb62k73xgkq6adCdnkC6NrqP0U0yCtt4jJjd8qQ==
X-Gm-Gg: ATEYQzyAu0SBGnqU5iTiwQuFhCR4s4li7VkLO0VeoInJFRdN3flK26XjcGOv/Jm7VjS
	Ec7gPxqRdb9wZubaR9sgNJXaIJ+Po0vLqeKIwW0czKYnKIhFTN7cb57U1zRlJEk06z/gkyjU5+p
	YyU7O80kt0/9UfIxnTlgrMNbed3Q/uNVlC3tXWznqxd1610CFDTpDkZFKaW8/iZhMKZY0o5Kr73
	28RVXPx3dlAnsfXKgKNqB/57qLWTfRJODbY8T1pHy3xkFAh42M0azHWzJ6tdHe7naX4SdZDhhhb
	Eeifd6FEHAA4GDZFmTvFm6xJxVuBe9Ja7MjNaHnczUbvNeF2MyDgvzD7SnHVusOXt64q0wqZg/h
	QtKK1YXWUkNdSus2HjBKon9rrTYh/XRaVqAIHqCNSLsaGEkNipdW/wtWOxWHffPuecpbsheiI2N
	5LOxNxQBCdOGY1PPWtfXgLy7QYjeweXGlS81AfKyXzpyDCybEjVe0arSUa3TOKf6glUpQdYzAWp
	FrV5KJ6FKWEDiBy/aFpCKTHND5WR0bhpax0tg==
X-Received: by 2002:a05:600c:1c0a:b0:485:40c6:f528 with SMTP id 5b1f17b1804b1-486fee2bb38mr53597825e9.30.1774020655058;
        Fri, 20 Mar 2026 08:30:55 -0700 (PDT)
Received: from localhost.localdomain (88-174-158-187.subs.proxad.net. [88.174.158.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64717e97sm7501232f8f.35.2026.03.20.08.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:30:54 -0700 (PDT)
From: Marta Rybczynska <rybczynska@gmail.com>
X-Google-Original-From: Marta Rybczynska <marta.rybczynska@ygreky.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH] layer.conf: Update to wrynose (6.0) release
Date: Fri, 20 Mar 2026 16:30:40 +0100
Message-ID: <20260320153040.42242-1-marta.rybczynska@ygreky.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Mar 2026 15:31:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3530

Update LAYERSERIES_COMPAT in all layer.conf files with the exception
of meta-parsec to wrynose.  For meta-parsec, added wrynose to the list
of supported versions.

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 conf/layer.conf                | 2 +-
 meta-hardening/conf/layer.conf | 2 +-
 meta-integrity/conf/layer.conf | 2 +-
 meta-parsec/conf/layer.conf    | 2 +-
 meta-tpm/conf/layer.conf       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 7a86054..f0d8bba 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
 BBFILE_PATTERN_security = "^${LAYERDIR}/"
 BBFILE_PRIORITY_security = "8"
 
-LAYERSERIES_COMPAT_security = "whinlatter"
+LAYERSERIES_COMPAT_security = "wrynose"
 
 LAYERDEPENDS_security = "core openembedded-layer"
 
diff --git a/meta-hardening/conf/layer.conf b/meta-hardening/conf/layer.conf
index 367d3d7..c95371f 100644
--- a/meta-hardening/conf/layer.conf
+++ b/meta-hardening/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "harden-layer"
 BBFILE_PATTERN_harden-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_harden-layer = "6"
 
-LAYERSERIES_COMPAT_harden-layer = "whinlatter"
+LAYERSERIES_COMPAT_harden-layer = "wrynose"
 
 LAYERDEPENDS_harden-layer = "core openembedded-layer"
 
diff --git a/meta-integrity/conf/layer.conf b/meta-integrity/conf/layer.conf
index 23d6848..22d2992 100644
--- a/meta-integrity/conf/layer.conf
+++ b/meta-integrity/conf/layer.conf
@@ -20,7 +20,7 @@ INTEGRITY_BASE := '${LAYERDIR}'
 # interactive shell is enough.
 OE_TERMINAL_EXPORTS += "INTEGRITY_BASE"
 
-LAYERSERIES_COMPAT_integrity = "whinlatter"
+LAYERSERIES_COMPAT_integrity = "wrynose"
 # ima-evm-utils depends on keyutils from meta-oe
 LAYERDEPENDS_integrity = "core openembedded-layer"
 
diff --git a/meta-parsec/conf/layer.conf b/meta-parsec/conf/layer.conf
index 39d1265..e2a7a8d 100644
--- a/meta-parsec/conf/layer.conf
+++ b/meta-parsec/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "parsec-layer"
 BBFILE_PATTERN_parsec-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_parsec-layer = "5"
 
-LAYERSERIES_COMPAT_parsec-layer = "whinlatter walnascar scarthgap"
+LAYERSERIES_COMPAT_parsec-layer = "wrynose whinlatter walnascar scarthgap"
 
 LAYERDEPENDS_parsec-layer = "core"
 BBLAYERS_LAYERINDEX_NAME_parsec-layer = "meta-parsec"
diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
index 582fe1e..c0fd7a7 100644
--- a/meta-tpm/conf/layer.conf
+++ b/meta-tpm/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "tpm-layer"
 BBFILE_PATTERN_tpm-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_tpm-layer = "6"
 
-LAYERSERIES_COMPAT_tpm-layer = "whinlatter"
+LAYERSERIES_COMPAT_tpm-layer = "wrynose"
 
 LAYERDEPENDS_tpm-layer = " \
     core \
-- 
2.47.3


