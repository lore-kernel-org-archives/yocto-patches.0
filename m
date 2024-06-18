Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA35DC27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 17:16:37 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web10.26.1718730992082590315
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Jun 2024 10:16:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bjDsthYp;
 spf=pass (domain: gmail.com, ip: 209.85.160.182, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-441187684e3so35287691cf.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718730990; x=1719335790; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLJS+R1PAqG5y8y9q9L3VfbI7tYCR0aQVp6MbnB1PaU=;
        b=bjDsthYppj2Tf/gULxwsPCzJiEw0m717PH20O9+RalQlq5j98jcDxipWIdGsnErAD2
         ZxCf+SuJDLF/SxVhJKK2gMed38Ndd4rv2FETt+PQcXGGVp3CcootiAmFzo26uZx8NEhu
         i8NDrx+uATMZBrkanuv32StqcJnPqcPina/kCcfKpmY64jgjP+/uMkr46sW6kG8ALY7c
         YDLAkJv+Zvyh5bfQW8cUrsDuHfrATONj8/TrK2jAWRZcjkH85jlPWz6t5QLaaH1r39vE
         yiO47Hp8WHCwPjEGv7AzWER150eOjYqKUhAVbaxRFVo+w/mBu3aap6/A5+FS0gMgNcQS
         Mp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718730990; x=1719335790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MLJS+R1PAqG5y8y9q9L3VfbI7tYCR0aQVp6MbnB1PaU=;
        b=tGCq/R6Juyo3D/wBeXf9qL/nNQ4XUrbmzS+1FKCwmd8u0D9clKJJ6G27IeRUVaXHdN
         oN7ifR8Sg3HU2UZfBk7q0tAm3Te7YsXtQFg5WIPobd7heseRWnMYug8dyWoexCPX7J/4
         yDB8AF1j7zL/9i/T5D7/G8bnauqhEXddBscIv5X+D/6o7P0MosyXt8G81ENeU9q+ysOz
         DKbU9HWV9DemB1wpgikcAfnLF25trgiSP3acz8Urkj7qbgICGgwcUzUkas6+bRJgrnMf
         iEuM0TiGQRRbqVyNE/LzthYqFfGz68fqhaqztNrSMfPCtbgXSNgEwY2G55IW+4NK7zbc
         8tCA==
X-Gm-Message-State: AOJu0Yzj9oXxVTVv+8srLCOzlZcf3Wi0hKV1xHeJ3CzlB5PLOePFKB0W
	VkyliDS5OaJNIeJgkD0XXzCrbJrouhOJ0dlkO+Dv1l9U2kxc+ddEDv38HA==
X-Google-Smtp-Source: AGHT+IFDt3+sc7UZahAkZEbXjocNIhISrjrxUjOKQxZo+wOjjqSl2f0X12uDRcKJwX8dtdHB1ANDmQ==
X-Received: by 2002:ac8:5913:0:b0:440:5ac6:af6c with SMTP id d75a77b69052e-444a7a88419mr4112861cf.63.1718730990225;
        Tue, 18 Jun 2024 10:16:30 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4421772802fsm49860031cf.58.2024.06.18.10.16.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:16:29 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2] linux-torvalds-next: use tag
Date: Tue, 18 Jun 2024 13:16:19 -0400
Message-ID: <20240618171619.9303-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 17:16:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/342

Use the tag name specifically; note that it is no longer reachable from any
branch.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-kernel/linux/linux-torvalds-next_git.bb | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
index 9a95eb5bc4d8..1369ba1d707f 100644
--- a/recipes-kernel/linux/linux-torvalds-next_git.bb
+++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
@@ -10,13 +10,12 @@ COMPATIBLE_MACHINE = "^$"
 COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
 
 LINUX_VERSION = "6.10-rc3"
+KERNEL_VERSION_SANITY_SKIP = "1"
 PV = "${LINUX_VERSION}+git${SRCPV}"
 SRC_URI = " \
-	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;branch=master \
+	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;nobranch=1;tag=next-20240611 \
 	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
 	"
-# this is tag 'next-20240611'
-SRCREV = "a957267fa7e9159d3d2ee1421359ebf228570c68"
 
 inherit kernel
 inherit kernel-yocto
-- 
2.44.0.478.g7774cfed6261


