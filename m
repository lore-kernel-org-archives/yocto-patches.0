Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33DAC982CD
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:31:03 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27100.1789597856197876289
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=NWSEJPGN;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafd6so14208785a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597855; x=1790202655; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wyucqu1srvY84IACRcsA5X5xV0/lu/KQe4R53T6nA6Y=;
        b=NWSEJPGNHDLXKGyTg4eQTwpXt2e+zmJ8asNEjZZhyxkgNksn28TZHeLWQvhv56sZIb
         EokvzfCwQFKB4ZobOWoV96UlIKoDgWRINwyh0RiSYpDrXq3n9i5ZLbZ1k7XS2+qgE4Rl
         f1VnwzAlFy9XVv+7Vs+1CPaQkimGxOFvaUEkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597855; x=1790202655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wyucqu1srvY84IACRcsA5X5xV0/lu/KQe4R53T6nA6Y=;
        b=nRhJla/GIYGMOudm5m/Z/gpDVy5RvFn9ZFfZ3u46DjsMwOfnyFAF/cztMjiOgY/3wB
         ettpFxZ+NJ7Wyh6LP8ACEB9sobzSRSKa+kOPrcKJK0mRpisk8WponxKiwzuyIlHLGkuh
         PA3tcRVysrQlhmZAYq4GTvJtAv4k3ShG67H3G1RC9gA+iYk0OGMxAnWKi2a/HFNNeLYc
         7yXy6sVOebZbblLw4gIFoMj2+BjOZQWXlhP3eB0tGRcL8vVq0BP+RwViUySd/MlseIla
         V4v+pTH2aEYYrf5zIfHZAPiCP6k2TW40/Cl3830IyyNaeyIOL9zHPpu5aiJryLSWyQqV
         m8Ew==
X-Gm-Message-State: AFuF++mWn+A5aKMqVKx0b5qqYR4wxJ4U7sKh8CJQ8p1rAjq1QRAIrygY
	moJiCmtikt6EL8ItjE8Ipv5p9HMmGo3YwgXIBm/a1ba3TuuG+HcIQncirreEV4uy1drEEy3OS/I
	7JPbe
X-Gm-Gg: AYBFou3yM7o+Xxq1zQsAjfitfhCqRwkbqD5F6S74oSfBlOQlKdT0qzFhF8eCk9veMSI
	eCKrcuzgzIOhmJsCZ4zMZ3RTbMHr1S7RmSigyDNM6YSwL3PHinq/h6ZkudMXRuX3im/yyFnUbi0
	rbLOm65kzYEwLX+k2YI40UCO8S6n9Qr1brv/EeFW5t29bcujogy/pEPTOJdVrQ+YjjgsgEk2iLc
	LJbxF41Mz89oq42/SAV5PuGwD2tl6pxBiMpeb92UuVCMI5H5OygLHHJf7W1TLXlUBfsekCXsn7k
	sDAfn3IV9MNixNiHBy2BwBEXPpeJN/M7Unk8qGGQ1oZP3SPZ1uHa5Cyjpj2+ZEo3mNtDzZtdUhj
	ugdQKe1g5mHIr0OrDabAbCv3kzwjz2RAcK9Q8bMze0JVDuFcLjmASJoS6k4Nqgzel+vuG9B7zdp
	F+wpN+2GCEY/dNuUi7tOk1xeAGuKGCEKcNu4OIrdgaWRD8VPrt2WO0pHtjkPhsfic4KxUqKiTPr
	6lx7UN663PN42sDaU2VF7fVStdk+M+sfy0DSCcojPf8UQMTK+di1BTUMKdJfDxfYjBYTCSNb2WW
	qLQXVS4Osjl0ZjzXcTa+Kd2ib0p+vBOxeLBXXJ8j55ydlDM=
X-Received: by 2002:a05:620a:f10:b0:93a:18f7:5aa9 with SMTP id af79cd13be357-93bb76e6779mr713907685a.4.1789597854851;
        Wed, 16 Sep 2026 15:30:54 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:54 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 24/24] lynis: upgrade 3.1.6 -> 3.1.7
Date: Wed, 16 Sep 2026 18:30:18 -0400
Message-ID: <2703974d5e2d61b221dffa302c2e059a522adbf3.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:31:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4899

Release notes:
https://github.com/CISOfy/lynis/releases/tag/3.1.7

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-compliance/lynis/{lynis_3.1.6.bb => lynis_3.1.7.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/lynis/{lynis_3.1.6.bb => lynis_3.1.7.bb} (96%)

diff --git a/recipes-compliance/lynis/lynis_3.1.6.bb b/recipes-compliance/lynis/lynis_3.1.7.bb
similarity index 96%
rename from recipes-compliance/lynis/lynis_3.1.6.bb
rename to recipes-compliance/lynis/lynis_3.1.7.bb
index 0b81ea9..be37f15 100644
--- a/recipes-compliance/lynis/lynis_3.1.6.bb
+++ b/recipes-compliance/lynis/lynis_3.1.7.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
 SRC_URI = "git://github.com/CISOfy/lynis.git;branch=master;protocol=https"
 
-SRCREV = "06153321ea50d53a27446084e646d9f43fe46e0e"
+SRCREV = "2e99f92265760b73fd6b139868eb8d4116624030"
 
 #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
 
-- 
2.55.0


