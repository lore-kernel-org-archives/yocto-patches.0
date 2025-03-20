Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E80BC28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 07:39:46 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.2272.1742456379591760448
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Mar 2025 00:39:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O3a6c7Vz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so2314315e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 00:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742456377; x=1743061177; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SyTptOSpagmzShG82M/Gxwf3Ov5WGPruyqjvRv2V80A=;
        b=O3a6c7VzNQ3evS+Bj60fcnUn2dBXFZ8S/+rxwDchktUz+TUnHTeiCnKgaABIyoeFQt
         m+s6czZFZ/QpY73MTEHdJitZv+Ou+/sLxL67J+lgs6TDRl9e6MgJxoJj7w7Pkn93Gewz
         D2MtSOI6lC7FMJ0vt9Ct6u/Ib2z+gQT2u958o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742456377; x=1743061177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SyTptOSpagmzShG82M/Gxwf3Ov5WGPruyqjvRv2V80A=;
        b=KQnJhIDozDC+Lzhgwm/EKVvYeC7Ooh/RMZGqcBL3f7sdkMTheld1Qwazte1LsBPJib
         o2deAXwHvU8WE5Ephot1uU9j1LQ1JFZCqGanrWZsZKHjgEkT8qzzsI+/J6y7RNELJ3oq
         2PNpT17KjRkFm8oeazOziWFuyAljOpokSrxWpthy7BW4Fkpsd5B8AxgqlswjpC4IzDs9
         MvMoKpDgENrxixLxl4IJkkFeAcwy3dd56pK7DFGVaRzKFTIlYzs3v4KdjOtAXprtxvuP
         vESWgCw8TJIPMKd70uOoPbGp3R3ojcPojX+gTHZzkpfR4Bb7OiNoqqMX4V/JMaWqt009
         1e7w==
X-Gm-Message-State: AOJu0YxSOwoRrc34YEL+OAXMiDmNryALgik7WJmP1XqkYIgq0ou9WYfo
	V5feJiT5GNhFTHZAHraBmwUlckajcA41XXXMUP6cSHtJ78qW25EzQ1OZAhjNVI524IGpprvzsu6
	o
X-Gm-Gg: ASbGnctcntbfFXh9yIrKhnI5rrX2Yu2IeuO//Xje9il5KIExSxfTPu26THJ5rlOamXZ
	vrb2y7FPrspl7W9Y8kIte2v7Gga967DLao7eyAJzYMfNFVyv8a/fcpmCR2bFLDyHHJGtr7eekLE
	yrRUROa5OK7FkWwkNSEgYu12PSZukpIxP4Im93yLIZr9D/vxR4DRUU4+5O9H5rtgAqEPV162OyV
	olpV6LuLCv2NLeyB662bjKJcZnbot9itxz2TidDKbm27RggYUI3ig9hZvyCpGFHH0/qRLvrmva9
	ehrVogAHIPFM3E1oWe5f1zBlpPzc1accVybCTDPplnFOdvEqm5vR9UjYhnhrNRkBhNncXlQuAg=
	=
X-Google-Smtp-Source: AGHT+IEzZQA1xOzCOSuRuM8LEzxGJo68cOsmeroCkb7bzFL14NoI2Ls9zv9vmExwOxd4o8czkZI8Zg==
X-Received: by 2002:a05:600c:3659:b0:43c:ec72:3daf with SMTP id 5b1f17b1804b1-43d491bf814mr15114155e9.14.1742456377035;
        Thu, 20 Mar 2025 00:39:37 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ede9:63ed:996d:ca84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4863b4a7sm24389305e9.8.2025.03.20.00.39.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 00:39:36 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Fix builds on ubuntu 2004 arm workers
Date: Thu, 20 Mar 2025 07:39:35 +0000
Message-ID: <20250320073935.901015-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 07:39:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1228

Arm workers need a different tarball, fix the mappings.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 9aafa5a..058dcd8 100644
--- a/config.json
+++ b/config.json
@@ -1981,13 +1981,14 @@
         }
     },
     "buildtools" : {
+        "ubuntu2004-arm-*" : "${BUILDTOOLS_ARM_URL}",
+        "ubuntu2004*"  : "${BUILDTOOLS_URL}",
         "alma8*"       : "${BUILDTOOLS_URL}",
         "rocky8*"      : "${BUILDTOOLS_URL}",
         "stream8*"     : "${BUILDTOOLS_URL}",
         "opensuse154*" : "${BUILDTOOLS_URL}",
         "opensuse155*" : "${BUILDTOOLS_URL}",
         "opensuse156*" : "${BUILDTOOLS_URL}",
-        "ubuntu2004*"  : "${BUILDTOOLS_URL}",
         "perf-alma8*"  : "${BUILDTOOLS_URL}",
         "perf-ubuntu1804-ty-*" : "${BUILDTOOLS_URL}"
     }

