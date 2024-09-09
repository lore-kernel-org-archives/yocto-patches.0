Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7C8ECE57E
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 14:56:04 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web10.55098.1725893764479184786
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 07:56:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RcGSRoNj;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-456954d0396so25164831cf.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725893763; x=1726498563; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yl5z0j2JadkX4VI+nDZGTts0fxvG+EZ1wyzBRJpnEJU=;
        b=RcGSRoNjYRRlwA6PL6oS8nBdJzNxWXwG57tHfCtrIr3cPaBGOvMVpURwdMzeLdyVYp
         fTRLQdRpuIIJv77i9HLbVG06HHWzJ3pG3O7jlcDGAFU3st+p0BpFLFop63tw7XKnubjv
         zLwfsPfzt+mbfMKhrAEngPLadmvX6Irl5hMxzJf1uJSvWvDEKdLwjLRJ8Mm7w/M5+EXm
         tP8fGwI8jzoZtv8SpJ6m37BepC8aAvHbUapx9PhVuiIjYwTYb/DGCq25Voszlf/SYIR+
         q2eJ0skVfogSlT45Y7z25AL2ghtBC6m8no11CZIIfGsQh17kN4n41w0FzqGyh2/dPwTI
         8DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893763; x=1726498563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yl5z0j2JadkX4VI+nDZGTts0fxvG+EZ1wyzBRJpnEJU=;
        b=AZNBT8llAgj2CyuXbXh7cvjy0rns6AMdCM9VA+UXzk17155BTYK79XG+LvNAic4XO7
         ClvDwxgKLXfI+ZG4sv5FlqxEkBIucT/p1njuipk9+uxh+tdAVNQGYetUbK1yiF/919Iy
         iTYATfqJd25pS5/VqwWChu7+RtjOwHqG8/aMDlYSodtRKWKBuRak0P1NQQYqDY9IAtVK
         wZqV0/SwtmkZONChB8v4HrVrb/QgbNbYDQ+RZFpI1i9VTwhPi+LB8ub9x/ycWyYGhr63
         DmadrVdjmK3Sj2DEd6OjvANo87VISVsExfe3Dz8NTZOth07GAIhGrJCr0lUFl5vI9I98
         WVJQ==
X-Gm-Message-State: AOJu0YzU7wMNfHDLhVVNkpuYUSlMtK3pLT9WJYi5/G9E7EGdOYDie2SR
	ung1srE+Do2g86VOGIOrEtj7+O0CLRoqerXl6dnoldqmcMSalmheDgggBrmi
X-Google-Smtp-Source: AGHT+IGrdZVXjvoOh7kg/2eGp8+0w8MEES2/f1pFYaQ3HCnN6Zk9AYiiWUgspO+JzeNN8lKREQoi+g==
X-Received: by 2002:ac8:7fc6:0:b0:458:2e21:e422 with SMTP id d75a77b69052e-4582e21e5f6mr61523961cf.50.1725893762757;
        Mon, 09 Sep 2024 07:56:02 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e772a2sm21050231cf.27.2024.09.09.07.56.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:56:02 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][scarthgap][PATCH 10/10] linux-torvalds-next: bump to next-20240904
Date: Mon,  9 Sep 2024 10:55:30 -0400
Message-ID: <20240909145530.25301-11-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240909145530.25301-1-twoerner@gmail.com>
References: <20240909145530.25301-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 14:56:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/636

Bump kernel to tag "next-20240904".

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-kernel/linux/linux-torvalds-next_git.bb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
index 6f3db7c61bdf..b961b1408f09 100644
--- a/recipes-kernel/linux/linux-torvalds-next_git.bb
+++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
@@ -10,15 +10,15 @@ DEFAULT_PREFERENCE = "-1"
 COMPATIBLE_MACHINE = "^$"
 COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
 
-LINUX_VERSION = "6.10-rc3"
+LINUX_VERSION = "6.11-rc6"
 KERNEL_VERSION_SANITY_SKIP = "1"
 PV = "${LINUX_VERSION}+git${SRCPV}"
 SRC_URI = " \
 	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;nobranch=1 \
 	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
 	"
-# this is tag 'next-20240611'
-SRCREV = "a957267fa7e9159d3d2ee1421359ebf228570c68"
+# this is tag 'next-20240904'
+SRCREV = "fdadd93817f124fd0ea6ef251d4a1068b7feceba"
 
 inherit kernel
 inherit kernel-yocto
-- 
2.44.0.478.g7774cfed6261


