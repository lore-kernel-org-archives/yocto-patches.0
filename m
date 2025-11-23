Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071B2CFD316
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:23 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5033.1763941522477175299
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bTO4kcoi;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2ea2b9631so392955285a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941521; x=1764546321; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4RiSP4QvC3mczEa7yTyUdHcrIj19MHCovzOBYYuFHk=;
        b=bTO4kcoic/VYxGj83Effq6PU+5B5MxV9yHaLDzn81u3Bs8Z3+A2/p7RLnO4tC793yC
         KmtVArAwHKCkRlpcdmC5creLH1OWYisSQkW2sHEwptK4MBgp3GO97C2arhb7rXtYWpmR
         PL4RzyBEL1POIezDYu8RnVRnsFSkT2DGzMJhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941521; x=1764546321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j4RiSP4QvC3mczEa7yTyUdHcrIj19MHCovzOBYYuFHk=;
        b=EY4E/GEZbZiLkDoasbhoaHLqFnGR2nwSJq965HvJOs18GzmqVLeITsRVF+3f0LR1pL
         a5POko7Blqv33o0GKU3JhbBpAD3gJxR725nCpW3w+GPOJjXFhcvL8RrdsZ7OeKtWSsgF
         ZOh9oBhO/w2hNA+f2TtA/q1rTSZReTpC6nv1KtZIGz6hYWyK1lEbKjbSZva77vDhCh/e
         zdCILMZcr4m8LNyKtfhjwo3jRyZXCMDs0A2j2RdVnwpUzSuuCqe/JlH3gbs7YPDk91bp
         xgPAUIFsWzXbETvZQkgcQdJ1vE4Ub3SO89Ibdcon/Iro0hFAGWOXlAJdPDEQ5OslZFxd
         IY3Q==
X-Gm-Message-State: AOJu0YyBVHqL6S1Q2xHOxUuvfoCHJZV81fIcqRZkfeO8EioBUqry/4eN
	eOKfRsOpeiKtn2XuBz+S+tfDR8U+JC05CstiCevoS/x55PDpRpASUeR8h/mwhPx2wPX925bpTGZ
	gDZ/S
X-Gm-Gg: ASbGncuZsNG+PFjjNtx/Hih5nxjg6GQQRe7FFqpZ38r4RYSE9eiqr5whXl+cwvI/FFs
	x1Wkj+zk16thscEoVCT5GoM+R0nvURfKjKBK3PsggHYaeKkLxdW6NVM5NKIRgvfaQ68ooIv64R8
	CgZei2sh5fjQjvaO5oxpiR8Nd5KwNfjdOtvFIVLLEPfasPnGiyfFYsZVWTJTjpRBXaz9LyuVGp2
	URhwJLcDlQTKwWYCDAuMBGJyKBfhPDU2Ty/00lG+CJRBOBVgvIo/KBy/OV+P+cdEzkJEPnhptPE
	9Oe+BjjsYudu0u4BNFB0iSrlUodBYd8qPfpuIhYw0rpHapic/DOp1BvmexxQfXvMiOhhObXrnrD
	As/P0+dWeqrsAOosJL57bVzdDMLIF1OstLOtsYNqBeQKLoQRu3xD/fXnim1aLVtcWwYnHwqvQCz
	vjqWsMdfc9g7NqhaIob0sE9QbWGhjkRCGHr3vnvR2qCPQ7jBGBsdRmIy2A8GVEox0=
X-Google-Smtp-Source: AGHT+IE4LzjUbWDS1OwL6DnPutJGdg5eoJKF9js5T21GYiPhwVFZqpwH/PssJJC7GyZ2Zwuy0jgFbg==
X-Received: by 2002:a05:620a:4509:b0:8b0:f2bd:4762 with SMTP id af79cd13be357-8b33d5d4982mr1316266785a.75.1763941521124;
        Sun, 23 Nov 2025 15:45:21 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:20 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 05/32] lynis: update 3.1.1 -> 3.1.4
Date: Sun, 23 Nov 2025 18:44:45 -0500
Message-ID: <010cbaf90ecb86c1530b463b3d3c8e6309535fc3.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2663

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Changelog at [1].

[1] https://cisofy.com/changelog/lynis/#314

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 recipes-compliance/lynis/{lynis_3.1.1.bb => lynis_3.1.4.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/lynis/{lynis_3.1.1.bb => lynis_3.1.4.bb} (93%)

diff --git a/recipes-compliance/lynis/lynis_3.1.1.bb b/recipes-compliance/lynis/lynis_3.1.4.bb
similarity index 93%
rename from recipes-compliance/lynis/lynis_3.1.1.bb
rename to recipes-compliance/lynis/lynis_3.1.4.bb
index b69f4df..9cce848 100644
--- a/recipes-compliance/lynis/lynis_3.1.1.bb
+++ b/recipes-compliance/lynis/lynis_3.1.4.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
 SRC_URI = "https://downloads.cisofy.com/lynis/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "d72f4ee7325816bb8dbfcf31eb104207b9fe58a2493c2a875373746a71284cc3"
+SRC_URI[sha256sum] = "c4dbcddd429624d5b2319cd3b19728e18a7885b70b8eb0a9fdd3ca5f0ae28eb6"
 
 #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
 
-- 
2.47.3


