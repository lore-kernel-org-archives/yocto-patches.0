Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614AFCD5BD2
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:16:06 +0000 (UTC)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7161.1779624965185148011
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:16:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nsEjQeN/;
 spf=pass (domain: konsulko.com, ip: 209.85.222.52, mailfrom: scott.murray@konsulko.com)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-95d3492fb1eso5703956241.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779624964; x=1780229764; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyAR8EnaSZyrhUSKWdatuNYEwD9apBLlu/6ryHKY75Q=;
        b=nsEjQeN/lfEw+xDUKva0rPSnVBROe1zZWtdg971I+yr3cx+a1wwwrCzqJ6d+X3Q+Dy
         T0eImRdKQNPOBaTQcVoQ3HI3LhqC2W3O2KTNs1WizhALcB4rS+D2j5uU8oO1Sp7k9gbh
         cnYsQLmYAFsf/3fRCWGyfzByDavMlBdK8TaH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779624964; x=1780229764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zyAR8EnaSZyrhUSKWdatuNYEwD9apBLlu/6ryHKY75Q=;
        b=NrOmMHQntj2m0d/3EiDun1h6ViaitabetBhrJt520902FvGkvULbuGB7QF+TZsJf7P
         rUaJ+H622pv0sdUIyFhf2P06xaE8DvhAqrmh/RcCZ7R7v6hqPA/FzDp/Zva6n5J/5BJj
         ifnxQaxR5+22YuyyZYGS0ST4zdtF0U6Dh/+19eMLby5TCKMSh/kzu9zNqkqxj5NiUmdF
         76Onvi7GijG9a37cvKMsl0t/WiOfKdZ4DtaxMdwCBzMzCZsGIAd57wL/adN4hJx9qf9F
         eorerC7l8Kh7+Xu3Wl3vZs4qlCwz5GUDKzim3DkaKMWrjpiMzANflfTKv1vEp5OtDi8B
         pARQ==
X-Gm-Message-State: AOJu0YxLmA0ic8Ejt9nWmzaL0JKf8/X4Qg/dLv4Q/9vdl+PosJj0JqqJ
	Yl77xRG6RI2Z1yiJTYk7MO5Ju5c9fR2sxHN5m7QMr0MttqPWdEaPOjigWIBwTZW7nsv/cpN7m6e
	iMosT
X-Gm-Gg: Acq92OGM4XPReLskKeK2Bmru07AFXRJHVqCyxjXDJnLd9dKsLT7wgydkLTq7oqpeX5x
	JD7/8EJOrGHeVg4NrusMu/vhZ8VE01pP7BeI9rkomTryYBdaYN5grbpIL09t0m3stxfHVA4dcNH
	xMDhBnwVa2ljhZ2UTeIgTdJz7D1JwWAVc5k4JUo/45vUV2VLuTCKSgEVm5hmAEGEhau/Bvs0jVj
	Oi0XsrTVbD2ts86dSpZ5GawQyGKLqZIQASRGjT+SoXaJj3ClsTqR4mBsFdEq+Vujb8SMZDZ//X1
	MJQWLqajd+Op7HqmYXOmlbacC+96wxVRRAksoYIrRKGymxQQ5CuvhnVNoi66WWcdodhut2SuRKL
	xDuI6mbGjs9iQhIExCCr4Sv1vHdaAcA7fkctzTdeBmWVwyTlVb3HCc71l5KR+1PGaCZ1aSVIf/E
	5uoDUVjgjqwHrFq8lYIjS6fEtczJQGP3OxlV4ZnWD6iBX/slvWQzOWlOs+E2OVPYDLwdmCIg8Lx
	tG9ZC+JmIxHB5s1vTiVVZk+WsqDFYW/ET83Bh3+s95akTSPwQnjKkWYz7lNOiva
X-Received: by 2002:a05:6102:2926:b0:632:eef7:4b7f with SMTP id ada2fe7eead31-67c8d071383mr5405724137.22.1779624964045;
        Sun, 24 May 2026 05:16:04 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm82385186d6.38.2026.05.24.05.16.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:16:03 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 11/13] aide-base.bbclass: correct STAGING_AIDE_DIR
Date: Sun, 24 May 2026 08:15:38 -0400
Message-ID: <b4c43ad77ad7eedab05d48dcbd32e4ef96b21c83.1779624335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779624335.git.scott.murray@konsulko.com>
References: <cover.1779624335.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:16:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4017

From: Li Zhou <li.zhou@windriver.com>

Fix the typo "aida" to "aide" in STAGING_AIDE_DIR.

Signed-off-by: Li Zhou <li.zhou@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/aide-base.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/aide-base.bbclass b/classes/aide-base.bbclass
index 36cc454..9d9472c 100644
--- a/classes/aide-base.bbclass
+++ b/classes/aide-base.bbclass
@@ -2,7 +2,7 @@
 # Copyright 2022 Armin Kuster <akuster808@gmail.com>
 #
 
-STAGING_AIDE_DIR ?= "${TMPDIR}/work-shared/${MACHINE}/aida"
+STAGING_AIDE_DIR ?= "${TMPDIR}/work-shared/${MACHINE}/aide"
 AIDE_INCLUDE_DIRS ?= "/lib"
 AIDE_SKIP_DIRS ?= "/lib/modules/.\*"
 
-- 
2.53.0


