Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159E9FD5F84
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 06:39:12 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.100447.1775630344289863397
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Apr 2026 23:39:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CncDqnSP;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89e8e352dc1so36173606d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 23:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775630343; x=1776235143; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EI/N86wZRVhUvjhprE8d7ImGvuJBrM8QefSPITP8HZ4=;
        b=CncDqnSPBQXwfFWK2hTok3cXrETs6GuNQrUB17gI2/Voypmrti8ifC7R8W4xzEHEkg
         aWjvvRgJlOEmI4zpkc/moCi77cnt/NjOH4knRiPOjHkenMKJIjlNpdQaU2V4ZpX3AmYu
         yM6w8vulAC1Hh/Szvt0N4HHtGxV+izBThiqrnsNKuOXimtzIX7Q4Q2ecYdGTkLqaNonX
         aTQSWk0w2UGYAs+F9o78zT5mN2e4Onbi8sdicHSNI7+sAFBJreHP8yVm0caQlh44/FZd
         60AJYr1WbR39tLYL7f6QUWkevI9z4HkdRfsWVp2x1hbURqRSbrEXyjzJX3cfwDXkwtTD
         zWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775630343; x=1776235143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EI/N86wZRVhUvjhprE8d7ImGvuJBrM8QefSPITP8HZ4=;
        b=Q/5G9dBaWOPe4uF4YD6kqQifuhJOkeqimpuycWunZnBerJnHzHi2QZ6U41/DS5WDDM
         h7FUwpP7akD47Rj+r31poiQC9VYXhn0+jJS0d+Xd9vryYJ4fyKxm9yNFIUThqJWAgaRO
         mNZLR36poWKHob6qDp0Sz9/P5ca2MEoI+p6KINzfZgng5+G9E6UEbqtH2lWkhSHvacmt
         aLd1vwZ1IzL6eeXIqVbRzqnB95LNbBHIei45UucQkNRRPWYeyCkrbF+odb3U4hshM7XF
         UeLRluKJiRkufzrW8CSmGusRJfxXn6F0Tx4TtKM1yoEMUAfSjO3Pt26u03vN/BDQphRW
         dtPQ==
X-Gm-Message-State: AOJu0YzBo0rDgJnoyAzfex/1ZDJrrv+r4jiZNO/9oK0POyDJL768pQzz
	ATFhdN5veidU7ThjGeb3VMZ+7EY0FdAafjGyz9EFwbCJR8OcnTDh/XE48Ex48Q==
X-Gm-Gg: AeBDiesR3VwPuOxpmz18+C5hSB73F0dhgFiLdYIc1Yj56WTzDz2DLfRzTWRToUJ9L6o
	cFKNB0YyYDAif+IUXsVZEM/wjNVsMRRGKWcNx7DgNuhBi4KRYMLCad/oKz98WJgBYP/MltTvOGS
	/3lOlNbOVYoESijhype8B4+oyvIXtGrV16FWXbN2nR3xjcJK1g2bMxGD1dJDd6NvfqzaIMPi2eU
	T1lW5mx4k0WqcRzXgo2KdirFNGRYjXfGHLPamHaNkBt3Z40UnEaNNAvkgHwoYRMApWrz+CgyeKZ
	M2Igwcfi/JdhcqpGEaV7gt3aSPzweupdJo8lshJmrXQpWckPIIoIKYOpBlcTdtFLDYArigOtdKW
	247G0/3OTdpYit+gQqhMjKmlPF8kcUMbf/OwGK2XcqFLGmNd3q/i8YAaSH+kQ10CR3+hyC+Tym3
	Be2E9QT7BbsP3PSDXzZtKOZ0L4Ye7989iw6rFWEtgcTxoOit01TMPVG4YxUevIHpFGPA==
X-Received: by 2002:ad4:5aeb:0:b0:89a:1536:251f with SMTP id 6a1803df08f44-8a704abb88cmr330153596d6.28.1775630342625;
        Tue, 07 Apr 2026 23:39:02 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5979d92fbsm204574216d6.48.2026.04.07.23.39.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 23:39:01 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] wic: move wks files
Date: Wed,  8 Apr 2026 02:38:58 -0400
Message-ID: <20260408063858.3845081-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 Apr 2026 06:39:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3659

The new, default, only location wic will look for wks files in a layer
is files/wic. Move the wks files to suit.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 {wic => files/wic}/rockchip.wks | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {wic => files/wic}/rockchip.wks (100%)

diff --git a/wic/rockchip.wks b/files/wic/rockchip.wks
similarity index 100%
rename from wic/rockchip.wks
rename to files/wic/rockchip.wks
-- 
2.51.0


