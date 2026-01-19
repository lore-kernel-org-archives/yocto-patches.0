Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98613D2ECF0
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:40:23 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44591.1768855222836175140
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:40:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Ttmb21IM;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6aaf3cd62so365161585a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768855222; x=1769460022; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5oCyw6LHwxw9OGXp6TB0YVR9Us0fHgJvgE68DdcVec=;
        b=Ttmb21IMW27596TNxsjBiWp4kxVfSz6+pnSPkibJtr1boFUsDgZ75ivZjIBnf+KQ63
         3NkmyC9ar+FX4WS8qgOanqK0kNZDLGLc+PeKVHzQwxjntDNmTswxQ/hvrC2NXqxJYW2X
         KjNMW6E4PUKUmtgr8J8wdYJanJKXU7JgNeDaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855222; x=1769460022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A5oCyw6LHwxw9OGXp6TB0YVR9Us0fHgJvgE68DdcVec=;
        b=fiyKvW/oEioXAtybCegZHGQkEoHQEgsxPwGOt+2SYbm1sYqk1d7FexbYMdbpn+PKkU
         WAsVaTK5wjR+uPybZYLlb+2g6V0f7KMOsJKERB4pmT1HjGEmUA5p8GNHtXK0NUsOFMlE
         pFoEOdFv4Jlb1DedjoPzVznK48ru1qOLHHs9OiPzKwbq/U5M2/6O6zN/XQ26jnxjuJTh
         a2PGp5U735Icc/HTvPeiba1VrqAf/ZZTNwv2TKpNHCyWu6PnYPCxieg5blzuYXIIqnC4
         RECjx7whA3MBzUiOBtG/XXJpiklv/uedQo0+2t0jkhA4JjfHUNiZwRcN74wsc/zYIQGK
         eKrQ==
X-Gm-Message-State: AOJu0YxgMl4Q9qXS2sixaghw505XeFuz7Dkr32K15qs9vyL8Xa6RrM1e
	IpeYOrFnIEoFZmaaCDv2eC57x82ue3jCLPCGEyBJuzTgLNOlTA2x2roECSwJyomfAVCJXVKzMhQ
	wg1xv
X-Gm-Gg: AY/fxX7Vep7onTdlTKpSdFx6lgsGTKug7UD5vp81mZ5ZIpx7urPqLPI5n3dfxVxm3Yo
	QojgmmNB6L8L8/wZZPgWkOweVg/JvFhhlbJmmxUWTb1vUsX9bRFAW9r4sy+2akrjLJDowBuTNcR
	fTzjexmuXXDlPsf9JG24LPWt0w/p/NPaLAbl6RqlgjrmqVpPK8F2QnZ+THtLxteEu94/Sc0MnIH
	Kirk5Se3r9EDNvosYYQV+znkg9Jg9jCwn38K+HkHG7Ca9ratPrDZDuEmEnrat7/xlfTljNXbSC8
	0NPYt+bnbnKYfht7/NqkYRTg7hcWvNDp7PVHBXloCubxOKjZVSpUpqwDmY3kQLemDJYXIjml+ED
	6Ue4fD5Qzh9Wypwu2tIx8qnRevojoTDZm0imxC9Vl5Gn1uX3kxyzKgl//IJWqwCumS9ccfMHbD5
	krfA37d7qUeXK3LD5TzU03Zwfv81b8HE1eV7xBEbC+q7alu6voe+8ONDKuiCKGlDMVulTeWBoMM
	YkmPTU99J8fIPV0OdEBV9rqt4C5I8D5lX5YUnwkt9Byuf8fiP/w
X-Received: by 2002:a05:620a:3b11:b0:8a3:e51d:63c9 with SMTP id af79cd13be357-8c6a66f8dfbmr1390912585a.25.1768855221614;
        Mon, 19 Jan 2026 12:40:21 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a70f1fe1sm851462085a.0.2026.01.19.12.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:40:21 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][scarthgap][PATCH 6/6] lynis: upgrade to 3.1.6
Date: Mon, 19 Jan 2026 15:40:01 -0500
Message-ID: <97e482b71688b62ac1109d16e89368122f039cbf.1768854779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768854779.git.scott.murray@konsulko.com>
References: <cover.1768854779.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:40:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3030

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
index 9105bbc..c3961b7 100644
--- a/recipes-compliance/lynis/lynis_3.1.5.bb
+++ b/recipes-compliance/lynis/lynis_3.1.6.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
 SRC_URI = "git://github.com/CISOfy/lynis.git;branch=master;protocol=https"
 
-SRCREV = "380b414e09bbca70be59a1b7ddccfaed4c30e1aa"
+SRCREV = "06153321ea50d53a27446084e646d9f43fe46e0e"
 
 #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
 
-- 
2.51.0


