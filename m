Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06061ECE586
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 14:56:05 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.web11.55132.1725893758592449702
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 07:55:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kjk+iFOl;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4582a0b438aso12620501cf.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725893757; x=1726498557; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lE/BaR5ScabrmOOM5NIaqj6qOY2iSq6Jx88Y4CLx2Q=;
        b=kjk+iFOlrnLaMrr1bnHKISDpGbFMyn/oA+5x9rzobgE1RKbbHphF1my2DCducf5y2F
         ZPMbJphnXePoSm+bk7ZeEAkKZVDhROOl+rMbx1zoY+cSryLIGxjJISEefCNjh6ewMnCc
         pRS3MiOoNczbddEPKsZqi3hT+d3lWr9I1KW0XSoooO2dLkWWjemavMFXkHi6//LRGLab
         L5pPQzqZuuKxHoqKO1yQJfFauG94uXR6xkLFAtRZFzWi549OjvE/AJ21SaCy9bfnAT5j
         lbbD4Hf3jI7Cao3mQJISsgXvsXRZPBPk1n2BViKpXOkty/O/la7JZ+NtcTwo2Zd2z4Og
         A90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893757; x=1726498557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lE/BaR5ScabrmOOM5NIaqj6qOY2iSq6Jx88Y4CLx2Q=;
        b=g5wKjdGCsgsyLWMVUbGIbeFZoFwxw70qBaG+UoFiZfXDtCgEnl2mGjacun5IaQCa4g
         OZyAJd56g4jCT7Rpd0bA/7eo/HuYLH/nTHCgyPahYN8PFDVG8oAMDhS0Kvugs0LAZ3ng
         8p3obOdOIbgIouOIHS3ct3Cd0I6MnKxPIX264+k1JMZdrsNiuRAKNfT8WDJxtv1JMEnN
         7qNCvqLVUqJd3Rfaaldk2QAsgV3XMP7xVjOiylJGS0JUvoYYTLA2ru5OkDkL5/B71qRv
         +UhItrUfWaABp340Y+Pl87ecTYAaLYebcRNguz+PAlAZeu3EdshbhIpDURIO1K/66oZP
         OjLw==
X-Gm-Message-State: AOJu0YzAJPedT4kOCoXu9poy2E11LlFKu5yLKB6Se5DdGUq72fMRfTPo
	XSFaH6XmUMGnKnv8eQWBU/ZZFNBnEnRjiXCUUX0wERAduB686ivxNkNNJaqy
X-Google-Smtp-Source: AGHT+IGUTwtPJWJa/Oi0z+HQUzFigJ5D/yxtp912Vle59Zqdr2jXCjCx1ESmnVjs1pnYIv3e7JSXAg==
X-Received: by 2002:a05:622a:1804:b0:446:34cd:9e21 with SMTP id d75a77b69052e-4580c69761fmr210868241cf.18.1725893756780;
        Mon, 09 Sep 2024 07:55:56 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e772a2sm21050231cf.27.2024.09.09.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:55:55 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marcin Bober <mbober1@gmail.com>
Subject: [meta-rockchip][scarthgap][PATCH 07/10] mesa: build panfrost for RK3566 boards
Date: Mon,  9 Sep 2024 10:55:27 -0400
Message-ID: <20240909145530.25301-8-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240909145530.25301-1-twoerner@gmail.com>
References: <20240909145530.25301-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 14:56:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/633

From: Marcin Bober <mbober1@gmail.com>

The RK356x SoC family (of which we currently only support RK3568) has a
Bifrost GPU that is supported by open-source Panfrost Linux kernel and
Mesa drivers, therefore let's build mesa with Panfrost support for
RK3566.

Signed-off-by: Marcin Bober <mbober1@gmail.com>
---
 recipes-graphics/mesa/mesa_%.bbappend | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa_%.bbappend
index 2d9ec2e676f7..00cc15c6221c 100644
--- a/recipes-graphics/mesa/mesa_%.bbappend
+++ b/recipes-graphics/mesa/mesa_%.bbappend
@@ -1,5 +1,6 @@
 PACKAGECONFIG:append:rk3288 = " kmsro panfrost"
 PACKAGECONFIG:append:rk3328 = " kmsro lima"
 PACKAGECONFIG:append:rk3399 = " kmsro panfrost"
+PACKAGECONFIG:append:rk3566 = " kmsro panfrost"
 PACKAGECONFIG:append:rk3568 = " kmsro panfrost"
 PACKAGECONFIG:append:px30 = " kmsro panfrost"
-- 
2.44.0.478.g7774cfed6261


