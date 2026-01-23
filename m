Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A546FD72348
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 08:01:06 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.63502.1769155246948324377
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 00:00:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=HHRMyJ1I;
 spf=pass (domain: smile.fr, ip: 209.85.221.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4327790c4e9so1187390f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 00:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769155245; x=1769760045; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6VdZxZ5nBP+TbzAvF21/ykX742yfZMSrKcdrqa2/kM=;
        b=HHRMyJ1IDY/BePwLWPZ/cDI8x6zbMy3vWhFcNh+pcvRejNyywW3l+MhH7ZVSk/c72c
         xExpTT4q/NlRkdyf3vGHhV3szW0oXNygu+lSuAl0r5H0FE6UfWx41XBmDvk6LUI072rm
         MVK5iARGVJVknDChEuQU4OF//ZXGUR7V7NB34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769155245; x=1769760045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6VdZxZ5nBP+TbzAvF21/ykX742yfZMSrKcdrqa2/kM=;
        b=PUQIXpKOIqVCsypkZGX3quevXqp1wrwEBdc+y+IOTkIYtr5YvJ33GRjWDyHSfsHjm2
         t/lSdexdgKpWL3z6N2U5+A9r/gIaV1qU4uv9z2Yq3lAxPTxm1MtsR+q18gQ4ITw1UYTa
         /BF1PBqDVR7ZExDR9meAVRLjr4IH2sMh06SicgJugSXFec71YaOlYappt/HBbzyTfmZd
         i0hIUxdLX2DiOrsXV7lMPKb/DIpRYI7LJD52V2dT9TsV43Q24OXtN3ThGFaKAZmjkTXT
         djc9Rf8oI4XqqslLEU805Lo8sWRXjl3PLLw9r/q5xgVQU4j0TMZ1c8qa8IPc4RyBA1Gb
         3I0g==
X-Gm-Message-State: AOJu0Yx2g5flAam/ZIbHlZvdmYithHLHXHRhaQ9R+xC/b6EZlkbN0ItQ
	egxTVk4cezGE4PiyvhTOCyA2EweOkkqw4nptDUE1VqMLHqMMNcxq21SXRZ6VYuLfDtKxts0wz76
	xVIq7opQ=
X-Gm-Gg: AZuq6aJSSfkgWoSVGaOOAdJlKk3AzjX+qE/6NNo4AP04UK0PuMI9c2fskKr487qGmnr
	L12AWybysOm07lly2igtj52aSxFNjwkQ18yZ3pNqlhJ3H05vs+kvabeqW09tj8/vkRwNDiJ4nyC
	1gjrIFx/fmQZ8q8DENP3oG0fA9UgRfArLnYzOwSMPEuLP7bVN/j3gcwgpo5uXh8ttEgUi5ZPpg9
	L5JdYQa315kS4p8Xy5eIyMTKL/8gCtmaffovNkEoJIsDUKIy5dvnX09HRh20We+ksHzT1DJ0tZi
	bafMpeNGozFCUxstQ924OoscQdZEYziZircLWx6sj9gQTphc/lzNar3v6mNPNC+qmwVV265S57n
	MRZHgzlhUy/85EOaH0sCCTaUT+agSuYA/cP/iPxk0SwosDz5wbtNH4Aa3mTKxvFE59yAuA8OTQs
	r8Yo4XkjsrFX+x/uGllBgXmYIDOLM/N5zS1ajUSIVf1kSuC9e04SzTJuz2bffUelan9yBJd6akc
	X1dKws3PEmxr48=
X-Received: by 2002:a05:6000:18a7:b0:431:53:1f49 with SMTP id ffacd0b85a97d-435b15fb20fmr3324573f8f.41.1769155242519;
        Fri, 23 Jan 2026 00:00:42 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24f15sm4784463f8f.18.2026.01.23.00.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 00:00:41 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH] schedulers: Remove non-existing whinlatter branch for meta-clang
Date: Fri, 23 Jan 2026 09:00:25 +0100
Message-ID: <20260123080025.72672-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 08:01:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3053

From: Yoann Congal <yoann.congal@smile.fr>

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/schedulers.py b/schedulers.py
index 036d66c..95d87e0 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -76,7 +76,6 @@ branchdefaults = {
         'branch_bitbake': '2.16',
         'branch_meta-arm': 'whinlatter',
         'branch_meta-aws': 'whinlatter',
-        'branch_meta-clang': 'whinlatter',
         'branch_meta-gplv2': 'master',
         'branch_meta-intel': 'whinlatter',
         'branch_meta-mingw': 'whinlatter',

