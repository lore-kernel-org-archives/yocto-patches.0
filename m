Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EEDCAC598
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 20:43:25 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.web10.34522.1758141797735578865
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Sep 2025 13:43:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HWfBlIJp;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-829243c1164so28795285a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1758141796; x=1758746596; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5TudJo8Ter3kwWQymie3WEeK6glWLF73/yzFchji48=;
        b=HWfBlIJpxURsqfaRQ8V09AhQxwlmj+K7WeqIc8VeXgVW65i2Ly9V9OFrOxYeuH0bPf
         J7oUBhvgAfiSqVE1tD0zns/sjuZAqQcmu89jPHY7pMEAOdkg15F4zCcCyE1WIbhhekF0
         LDfN3mNnDPxbLfToe6LsZIXl7QuT2rZNRRvKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141796; x=1758746596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5TudJo8Ter3kwWQymie3WEeK6glWLF73/yzFchji48=;
        b=fZW0TBprQ9EeR3PijA7oEK6umkyN+7x7keiXy5VGgsRod5z5XMNMwqNHrMcaXpdeea
         LB7mdjpZszQN2iDlc8fZsZpgI1WDQ3bOcrWuMokHbWUqhlzRoxeukUb8N96TYD5GIC4B
         DTF5ou00/BPU++wb0x9nYJyIjb6Ycd2ByX26Rl1acSUQzh3Ig38MHw1rkj1XGXbe9mPZ
         Ey3hGxKd/9tRvizy7L+LS2wIn4NQFt1DFuR02LIlUzNMOxa4liiFJ1G4O54UlbcFey3G
         DtOcThKMwOvrLrMxVS+cNYPT8+5Y7vMXUSBSspWgCgzRR9WMdCFz53Cz1II5ghpsJ6Te
         l+xA==
X-Gm-Message-State: AOJu0YxFu68C1R9ywcqf1pwe/wSko0MwA8JKLk/yvOYUpy6HjxaiITqo
	vxdDDWzaCCXVmjN1h5dLNfqfF0Ai0fg6Cadu44n1aoL8jj/ILG4xiX9oWGr/Djloskj1EW2hNWm
	1CotE
X-Gm-Gg: ASbGncsBaohU0RuGXC9xwNKyc+RcM4b/QBagfiDC7ixz2Y7HAJJJjCIr7d/K9xK2rJT
	Oa8J1nBHsVln2Q8dTVT2jXyIIrasxRbetGKy6WdCgV+Y175F4J0LS25FHl9gE07LBOZQ57WOx1K
	pTxpojFgub198cLj+BHREk99D89HT1NHwHYtdx4AR1Zx66mm7UTC8fnor7aIN5n5a252R6bhiae
	5rBG+++IjC6gxx3SS4m2d2jk7NPtZdb+M0BlZ2eGfkKBMlmUend1aHIMvffuT8Q8j3YYSl4VXoF
	bjXodSko6QJx870IKiu2ogX94w2cbyfFd7945PgdEHYTG8cukyZP+07SBH4PHP0PUU0hy9qm7TQ
	H8sn0Tyy9qZKd++PCbaHG3buJ8xhVVWWH5FeEf+nzStSdUO2i5Q4Kh5g2TLBoVOpFmGfRGpCCk/
	M620VPxjuBvyXgCq8VWHqnQO8D6WA=
X-Google-Smtp-Source: AGHT+IGWffDFsNbue3FBihY1SUHR6Kf3B2osigOHx/+eXX6TJaFFKQqiVN3zOytbJ+Av3l7wfzvhDw==
X-Received: by 2002:a05:620a:470d:b0:806:e8e6:ed1 with SMTP id af79cd13be357-83110911f0cmr423326385a.40.1758141795892;
        Wed, 17 Sep 2025 13:43:15 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836260ccccasm42991385a.10.2025.09.17.13.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:43:13 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 5/5] lynis: update to 3.1.5
Date: Wed, 17 Sep 2025 16:42:52 -0400
Message-ID: <730ebbddc121016151a72d3e0bce61351a0ad365.1758138771.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758138771.git.scott.murray@konsulko.com>
References: <cover.1758138771.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 20:43:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2212

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Tested on master (whinlatter) with beaglebone-yocto

New in version 3.1.5 (2025-07-29):
https://cisofy.com/changelog/lynis/#315

Added:
- Support for OpenWrt
- Bitdefender detection on Linux
- Detection of openSUSE Tumbleweed-Slowroll

Changed:
- Corrected detection of service manager SMF
- Extended GetHostID function to allow HostID and HostID2 creation on OpenWrt
- Check modules also under /usr/lib/modules.d

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.5.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/lynis/{lynis_3.1.4.bb => lynis_3.1.5.bb} (93%)

diff --git a/recipes-compliance/lynis/lynis_3.1.4.bb b/recipes-compliance/lynis/lynis_3.1.5.bb
similarity index 93%
rename from recipes-compliance/lynis/lynis_3.1.4.bb
rename to recipes-compliance/lynis/lynis_3.1.5.bb
index 3546a9e..3d1e8b7 100644
--- a/recipes-compliance/lynis/lynis_3.1.4.bb
+++ b/recipes-compliance/lynis/lynis_3.1.5.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
 SRC_URI = "https://downloads.cisofy.com/lynis/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "c4dbcddd429624d5b2319cd3b19728e18a7885b70b8eb0a9fdd3ca5f0ae28eb6"
+SRC_URI[sha256sum] = "8d2c6652ba60116a82514522b666ca77293f4bfc69f1e581028769f7ebb52ba4"
 
 #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
 
-- 
2.50.1


