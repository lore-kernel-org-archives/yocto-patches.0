Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8917DD2ECE6
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:40:23 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44340.1768855222033769652
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:40:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=H3oj6SHG;
 spf=pass (domain: konsulko.com, ip: 209.85.160.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-502a2370e4fso28629571cf.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768855221; x=1769460021; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfbwCU7FfjY92xWO5Wpj7s0BSBcchgYYh/RKQZOG064=;
        b=H3oj6SHGm6FceqcH+wCigcaZe+rfCY5gzE/PJy9f3BXo7XUFnkW6HVXgG/nJF2e0Sc
         Q+USdcioTzoaHBFYQ4CCkFpEc5xNRJ+6mM/JZ4tqYSm0xTe/tJ3IHVawVe10vteFDqNb
         Lj8+Z29hMaDZWAiC0uu3P/+8HQM3LXB1O/Nls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855221; x=1769460021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nfbwCU7FfjY92xWO5Wpj7s0BSBcchgYYh/RKQZOG064=;
        b=bhBUHfI9N1POidRuJOESbKJ9zMgKDnr+RpJyZt1Pq0FGBzfSTtbiOjf5L6kLD4052R
         /docq99hJS/h8kxYLPDejfOAGPH/pLDRb8BAgQrTMBnVN9wz46/7m3hjaU57B92DQB5s
         zdhXCYOheHHwi6eVyZP49RzCaCa6ryjWbYK0MmFnVM1dt9Zjy4SFO0l20UZfoXMjdeji
         C14vys3ZNBBy1+7v6UFlaA+lLJSLGwcovoxMMOrFBH3RMxNfk+PZEyR27eLI5D3dc7m0
         Q8kn/SkCqnaaFggu9vP8RUxMBuM3F37C0Y3ig+sn8glJv6xXFTHn+m0YvSLu7B38kJRf
         fTpA==
X-Gm-Message-State: AOJu0YwxBIpNSoGArSaNe+/TsuGrSeuOsPTx+r4Y1Q9uA0qi42P2qob6
	8huqe0cYm0abAvuYbnB2hVf69Lf0sguBPO81569czSKFNkzbEfKkrtv2DCHQvH7HYCyncMxqQDy
	POZu4
X-Gm-Gg: AY/fxX5W6uecQ1F7vdwwjmwMh3/HCV23Anle+D8cXUMqFbnSp9MuYd6VvG7kaWqWSSz
	QMIIyqqvq60Db55/BNkUBtnaJNfZOt1W9uFhz8PXdVRjL6HInBuV51fQdouaqRQQNvm/AZrmgPl
	sf0qKRVVMXSX42UYT5/Y+3YYI3xEZZTebt8JiQuAoKLzPGiq9MBlEDXU7UK4CYD8NMO9d1RyZCy
	C3bI+G7aD4hrTO1tQl5Jb0cIMHk/s5SGa+c8tZV+CfZCiZodK0xF06wtKmNPdphajAb5wWdnhRc
	04XdJT9QRzJbVos1SayA1h6w+RpXmhl9sjOHMenUr1ZVV1HFQdMvrg+ovf3l5nm/bX4CFoXChXk
	eAZVocux6dJFYdV09B80CSYElXivF7ewDaDIiaz4ldS33cRHZ7UPMeEJmsxU49qt71Q3+K94Q5O
	y+nwjpf+GCoLTg0+Tq1PY0rHMyj3bDRlfxf0DVfwkrcoDFcfcNPmk7VAWM0eytxb9sBz9Ces1DF
	pGHBEi/C5LGgWEimozabYVmat5dzMiZ1wRJlEF/bZZIyP2gJsOH
X-Received: by 2002:a05:622a:1794:b0:4ee:2423:d538 with SMTP id d75a77b69052e-502a168803fmr146249181cf.18.1768855220701;
        Mon, 19 Jan 2026 12:40:20 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a70f1fe1sm851462085a.0.2026.01.19.12.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:40:20 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][scarthgap][PATCH 5/6] lynis: move to GitHub fetching
Date: Mon, 19 Jan 2026 15:40:00 -0500
Message-ID: <6113f0e2f8521427374c8c47bf7ed883962651bd.1768854779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768854779.git.scott.murray@konsulko.com>
References: <cover.1768854779.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:40:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3029

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Move to fetching from GitHub hashes to avoid issues at releases,
when the last-recent release changes place.

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
(adapted for scarthgap)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-compliance/lynis/lynis_3.1.5.bb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-compliance/lynis/lynis_3.1.5.bb b/recipes-compliance/lynis/lynis_3.1.5.bb
index 6264edc..9105bbc 100644
--- a/recipes-compliance/lynis/lynis_3.1.5.bb
+++ b/recipes-compliance/lynis/lynis_3.1.5.bb
@@ -6,13 +6,13 @@ HOMEDIR = "https://cisofy.com/"
 LICENSE = "GPL-3.0-only"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
-SRC_URI = "https://downloads.cisofy.com/lynis/${BPN}-${PV}.tar.gz"
+SRC_URI = "git://github.com/CISOfy/lynis.git;branch=master;protocol=https"
 
-SRC_URI[sha256sum] = "8d2c6652ba60116a82514522b666ca77293f4bfc69f1e581028769f7ebb52ba4"
+SRCREV = "380b414e09bbca70be59a1b7ddccfaed4c30e1aa"
 
 #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
 
-S = "${WORKDIR}/${BPN}"
+S = "${WORKDIR}/git"
 
 inherit autotools-brokensep
 
-- 
2.51.0


