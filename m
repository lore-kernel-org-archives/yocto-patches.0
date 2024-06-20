Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABB4C27C53
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 01:49:27 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.web10.37924.1718848158656183415
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Jun 2024 18:49:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TPsoxwNP;
 spf=pass (domain: gmail.com, ip: 209.85.222.181, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7955af79812so25005285a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 18:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718848157; x=1719452957; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u2gfxHQAsewnPOyef+wLTUEazsVOt3WHxbvtKSiKCLM=;
        b=TPsoxwNPQersX0hfy0d/DFS4kKAK8cgYcvy6TqwINkQDSxXeei2fd1pXMu6svpx69T
         ybTnC64EDOJpAa6m0TAcDvmyTlF7jJx5qWbSaf32XMEpx1//827SuYOKqpuIQ5JBd4Cp
         cAdOnRJqxLnpilv8M3LKQhNDD4RppcVff80Cco/cFV5PL2MKHAizPIfm7SkYCjgGz6lt
         g7riFrSFLxrsdpqxFh+zzAsoMqN05XYvAHPdNAYuoSMqvqLeuS7O49f+MuFE9pjwgHxb
         2iQ5Ph0oPvY24+Cl+iv/0hZqpDdo1T0XBt6C6KTO8ae6ukhWd+zsgCrr5ABSjVmu+WEM
         /YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718848157; x=1719452957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2gfxHQAsewnPOyef+wLTUEazsVOt3WHxbvtKSiKCLM=;
        b=d3XfrwwSaPKoUG0sFqKV5kq76lhuqwxnYI9kmpvmt8UAzyMnVBYIDd510Y6I0kzFAz
         GsW2ZC/MlJgCDkJW5QEh+qQ/mRDjBKMSUErQTeep/wvedp7YYu8//001yfO9B8y91Pj3
         h1XQ58bdmHvy50GwzlsqIEwkaKtjgU+1XtcNIRoaq7oDFLYIRxAJaWScZjBqmZqB93Er
         Asmvy/mBFm2yoHd6DN18a8Gt0dXTmvI6x0oE0e+PBvp0zVPoqhk4HaB5a08D6deEGdyD
         oGG3/rwSqOTLXXJGXjevkGVm1Xe30+kQXvKXDrB3mnWtmHu7uzfsLh7uOnNyBVODsZX9
         aoDA==
X-Gm-Message-State: AOJu0YzPjTGL7abyifN68fZpUUg7pIYYRotwLRK82PCfWJ+Qbrg+g7OA
	gyc4K4wga9vq3C2IASfLvEU80yFYzxvRuhtnLgESySEv+ROnEdmDPP84ZQ==
X-Google-Smtp-Source: AGHT+IFv91n4XGtwUzosLEjEBNNgXNp1/xHS2/gp3k255tU+qVLPWIF1E6JPDcwOI0SlnwN0ChSbAA==
X-Received: by 2002:a05:620a:4150:b0:797:aa9a:de5e with SMTP id af79cd13be357-79bb3e1152emr505182185a.3.1718848156769;
        Wed, 19 Jun 2024 18:49:16 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b49e4c82sm650925985a.88.2024.06.19.18.49.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 18:49:16 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] linux-torvalds-next: SRCREV with nobranch
Date: Wed, 19 Jun 2024 21:49:04 -0400
Message-ID: <20240620014904.40092-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Jun 2024 01:49:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/357

Switch back to using a SRCREV, but this time without a branch (since this
commit is no longer reachable from any branch), so that network-less builds
can take place (or builds that don't need to resolve the tag (over the
network)).

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-kernel/linux/linux-torvalds-next_git.bb | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
index 1369ba1d707f..c0ac1de22005 100644
--- a/recipes-kernel/linux/linux-torvalds-next_git.bb
+++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
@@ -13,9 +13,11 @@ LINUX_VERSION = "6.10-rc3"
 KERNEL_VERSION_SANITY_SKIP = "1"
 PV = "${LINUX_VERSION}+git${SRCPV}"
 SRC_URI = " \
-	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;nobranch=1;tag=next-20240611 \
+	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;nobranch=1 \
 	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
 	"
+# this is tag 'next-20240611'
+SRCREV = "a957267fa7e9159d3d2ee1421359ebf228570c68"
 
 inherit kernel
 inherit kernel-yocto
-- 
2.44.0.478.g7774cfed6261


