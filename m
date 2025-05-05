Return-Path: <emailaddress.ashish@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AC9C3ABB6
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 09:22:56 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.46432.1746436970105121268
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 02:22:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=a6HFpJl0;
 spf=pass (domain: gmail.com, ip: 209.85.210.171, mailfrom: emailaddress.ashish@gmail.com)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso4211940b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746436969; x=1747041769; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV//MsubayP8a2k4/bbRdSNjAVXtZ2pXGF7m5/BjpNI=;
        b=a6HFpJl0uZlMd5EBTkK5lGnqpNi9Yny9XmUaeyojaZ6Lyxdf3hse37iqAEE6IQ3nst
         uXXe2u0+kL4EseLjJZwyndEZWGJrIhKLqRau5w7A3sgwRZjfZWY1ppERUQ/4D9yIsnGS
         K/3xLgIcm/ElyhNGdp8EG8vW99y3XmhcToTRBjQVVvIJMT23uDrJMyEDquUNtQBO8PRz
         T8ryRN1MTqi0n03GFE/0vhTdRHDYT6dZMr44EnQLbOvnCIKFbWBH1fVYHoWOLSWxec9D
         jEc/ZNcLDlHbXEDPDctWU/jaE7jdSuiMa/puHQzVuyuay8lFxJkoGUXeEIBMjRhx05Jj
         HATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436969; x=1747041769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV//MsubayP8a2k4/bbRdSNjAVXtZ2pXGF7m5/BjpNI=;
        b=oJXtrB02cNP5M41/xwUCwB50vbyktq7TKQV5JM4IgTeIxqPrSwyog2f8qB+r0kUf6Z
         Cn5erdjo+lNiYADuw3NyWdITxz2u+OUIcd4/bEKv+f0Ufsv22Xcrc9LlfvlRUtfbMHEs
         nqtMRqmQRNNR4iez4xdKMz/LJXPstMtiqqhCiLHyLw10MGGT/15NpD7RYrOyQqMD0njv
         sypQy9l/JzNRigRmdszvX2rd5divEDbguyH5eMea6TIiE4hkSFy1JTeZ9BmaW/eniGkb
         BWbcoNjVJxnTTmyVOBTAv7y+FARwAOvbd5Ef0vbUZ9E/S6YS26fDxFK32C/EwrOFouuv
         bzRg==
X-Gm-Message-State: AOJu0Yyi+LooBlttEupMZew/rshVO58Wbes26TZMi96Bj4IJas0m1L+P
	UE1UoCKDZoDztX9ZjXSwS9tv4NPTgB5P91dE3uTAf0wgbsE7ab89fdpqCA==
X-Gm-Gg: ASbGncvEJdSZjzZpvR6u7Rn2BPWwVYQV18aKnQhGKNIkhX+/akm7PN9Ed2nLQRC1AV9
	VdVGamv45eb8bmtJiI439JTKEZ6drQ+RfoTovg56M6Xy6YHZYT0BOHESo4CDWX1wqcS2GS7kIqE
	KV+8aN1fNNNQzTnG8s/479aZj8SQLWBT4NmtuYrHx61+KP7Xt8lydnc+S/7CUGXiRZG4oxtaG2C
	l8a7Pq9LZnyJwMhz788O1ZF8GSFfEAu9kk8EBhluaRH6a3waf66uhrg/id28/aklSN4/QIqu4B8
	xoU0+RGLFO4cKVkUc0ogxapKCDHMkfVTCcrhoUOmT1K1GbsXWn6Z
X-Google-Smtp-Source: AGHT+IEVmirGL1GP8e9oDvRmv5QxRWYqOPwvKPZlaWnYwHNd+T+4oqXLANrp5+vquSYqft1zluyg1Q==
X-Received: by 2002:a05:6a00:438f:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-7406f08cfefmr9413187b3a.4.1746436969367;
        Mon, 05 May 2025 02:22:49 -0700 (PDT)
Received: from MVIN00210.. ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm6487611b3a.98.2025.05.05.02.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:22:49 -0700 (PDT)
From: Ashish Mishra <emailaddress.ashish@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Ashish Mishra <emailaddress.ashish@gmail.com>
Subject: [meta-java][PATCH 2/4] Updates the SRC_URI for xml-commons-resolver recipe
Date: Mon,  5 May 2025 14:52:36 +0530
Message-ID: <20250505092238.853811-3-emailaddress.ashish@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505092238.853811-1-emailaddress.ashish@gmail.com>
References: <20250505092238.853811-1-emailaddress.ashish@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 09:22:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1494

Signed-off-by: Ashish Mishra <emailaddress.ashish@gmail.com>
---
 recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb b/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
index 0fafcea..790b2e7 100644
--- a/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
+++ b/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
@@ -4,7 +4,7 @@ LICENSE = "Apache-2.0"
 PR = "r1"
 LIC_FILES_CHKSUM = "file://LICENSE.resolver.txt;md5=d229da563da18fe5d58cd95a6467d584"
 
-SRC_URI = "http://archive.apache.org/dist/xml/commons/xml-commons-resolver-${PV}.tar.gz"
+SRC_URI = "https://archive.apache.org/dist/xml/commons/binaries/xml-commons-resolver-${PV}.tar.gz"
 
 inherit java-library
 

