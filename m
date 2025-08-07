Return-Path: <schonm@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE126C87FCB
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 02:11:26 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.web11.41629.1754532686083146627
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 Aug 2025 19:11:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RfWPeMEc;
 spf=pass (domain: gmail.com, ip: 209.85.128.176, mailfrom: schonm@gmail.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71b76c2f903so4727157b3.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 06 Aug 2025 19:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754532685; x=1755137485; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4yd4/1uDkgViM5w85ov9go+gZFPnylJulAq8z/EuYps=;
        b=RfWPeMEcx2Fbq+E+aW0FQxR2yuRkuwENbnVIpJSj9GBxWlR/k8tL61J47N8VV4pMHD
         HnvnCzO0l8Ee/Simj2hjC5bzfa9R9whUylC7cJbjx5RgacgOM7eQXG1JJ5ZhACZWZjcx
         +QkjV9h3v+8LmRYTSMtihh3o+eeaEw9RWgMkguqgsM79xQifs7xpf3DDBb4fQAYPBGPC
         DEaml5e1K0FOcb9ERNrNVEbg/ySbO7KHd5XbKRKa2tFZKR52C1Aui0WAPgeHqjW/YCw8
         To67WtrFLk1WiawSKBzWmDIyh6dgv0s95VsVhgJx5vTIBIKOHwjRCnfQpK6yM1T5zJ+M
         CIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754532685; x=1755137485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4yd4/1uDkgViM5w85ov9go+gZFPnylJulAq8z/EuYps=;
        b=Yr08kzBMjQ/PZAXOLiPSazZXTgsTJjlAzkxdh9MDKR4TdnEyoyYE8+GiI7NmV8Gzp2
         oWheWtqsUCDaTntgB8l2bh0951c4MC/vCbnrIencFBtbNbIlLHV7gH4eiFDvg+YqXwGW
         1KCL6FqWPRIvF6ul9maa8PhZ7Sx2PRk+EeDWhkgCIbbOTlQAhnC9FJav/5vkbVM9/LXS
         cId+OLapUiJ5y6E+EI0vlV6WArrG/zSNe520lBzDBfgl/sSezHcKA0Xe4v+An+5vZYWL
         V3zFatmY5oinoJtIT8CgeRH6Seghn/inBRM6PHmv5tKFkU+jY1c/72pyfVEqTIYQLfRF
         w51A==
X-Gm-Message-State: AOJu0YwUw/togdIYaGXJUKGllOTImpfhiVqSfYrk2Kbv9scROlLYmz5N
	wEV3hx0JF4FYlQI2zyNBYcFJ4Dx/k3JljC8SLk072zjQLPAzHjLWx6qJb8ZD8Q==
X-Gm-Gg: ASbGncuBRtcomT7plMnN4ACcG1hw7+egzFDsDJDdd5hhrXFP4BQBrz/oZsMJgfsaSwn
	/aT/NRu1s4r92kMzuhvDgMVQSSev4/zrlTeJ/8rinQ6pnhtAT0KSXyLzniEQEQ/AKg5MdTv3vNN
	6yQ80XufFJmpUjkv1LMDPKAqcr8XVCbpsCTAAq7BYueC594Go1HO8/8olrOMEyzbNfSuJmQi4lI
	X42tcJY6tpGmSTYt3JSUzmk9LNM9W3inHWjup48zSP9bwSBxEGqVhQXlqDRdM+xiJUwVXm3Z2FE
	OSxYCCmkx3Lb98IYugF+FIijFqbxlK+weDGDfdsNIK0Gmd5LyIPYfvhaj83U6DOP4kys/xnGCah
	R0VZaAifYtKYIG7as4qHA9DFnq8A0
X-Google-Smtp-Source: AGHT+IEDtgtNAmeqDUYgQDf5HnSvMQ/Q3QQspvEGbtqy8ZUgXClyP4oUsaEvFAJd3MN1AgfBvaeuhg==
X-Received: by 2002:a05:690c:968f:b0:71a:2dc9:a209 with SMTP id 00721157ae682-71bc97f6d43mr73749577b3.22.1754532684592;
        Wed, 06 Aug 2025 19:11:24 -0700 (PDT)
Received: from localhost.localdomain ([67.233.61.26])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5988f0sm43497667b3.52.2025.08.06.19.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 19:11:24 -0700 (PDT)
From: Jason Schonberg <schonm@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jason Schonberg <schonm@gmail.com>
Subject: [meta-security][PATCH] lib-perl: add a HOMEPAGE.  Use CPAN_MIRROR
Date: Wed,  6 Aug 2025 22:10:48 -0400
Message-ID: <20250807021048.12303-1-schonm@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 07 Aug 2025 02:11:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1898

Signed-off-by: Jason Schonberg <schonm@gmail.com>
---
 recipes-perl/perl/lib-perl_0.63.bb | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-perl/perl/lib-perl_0.63.bb b/recipes-perl/perl/lib-perl_0.63.bb
index 6fc44e4..f0d6832 100644
--- a/recipes-perl/perl/lib-perl_0.63.bb
+++ b/recipes-perl/perl/lib-perl_0.63.bb
@@ -4,6 +4,7 @@ directories to Perl's search path so that later 'use' or 'require' statements \
 will find modules which are not located in the default search path."
 
 SECTION = "libs"
+HOMEPAGE = "https://metacpan.org/dist/lib"
 LICENSE = "Artistic-1.0 | GPL-1.0-or-later"
 PR = "r0"
 
@@ -11,7 +12,7 @@ LIC_FILES_CHKSUM = "file://README;beginline=26;endline=30;md5=94b119f1a7b8d611ef
 
 DEPENDS += "perl"
 
-SRC_URI = "http://www.cpan.org/authors/id/S/SM/SMUELLER/lib-${PV}.tar.gz"
+SRC_URI = "${CPAN_MIRROR}/authors/id/S/SM/SMUELLER/lib-${PV}.tar.gz"
 
 SRC_URI[md5sum] = "8607ac4e0d9d43585ec28312f52df67c"
 SRC_URI[sha256sum] = "72f63db9220098e834d7a38231626bd0c9b802c1ec54a628e2df35f3818e5a00"
-- 
2.43.0


