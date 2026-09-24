Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA764C98315
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 14:26:36 +0000 (UTC)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9213.1790259986063759646
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Sep 2026 07:26:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QvlBDVh6;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.76, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so1534720f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Sep 2026 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790259984; x=1790864784; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wdFv8KwJKZuKq3OYt56WvS/SNFrgv2MxwAPrwdXhjBg=;
        b=QvlBDVh6ufzn7v+rfth2wXJlfiMK7mTZCUuUqULCBfTyIlJTh0fRu0DJOyJDjqIDna
         0rvGRA0goNF0+D6d0T6OK4WEZvPKdZ4fFZqXHv/vOBx3/o8MbO67SYVYg+Fv3//wUCyd
         CeQzjNnGx7m5ifm0wj6IP06iumDqZCSAA2ahU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790259984; x=1790864784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wdFv8KwJKZuKq3OYt56WvS/SNFrgv2MxwAPrwdXhjBg=;
        b=VZ2dddVGLjlER1iI8318eGJY8OuUX2i5FLViIPboS+Gw5v2gpG8Yr9zQD/ULMbgNS8
         c+nCFOlkA/kecFKTv+ntBVVuHIldEg99A/9C3r4nEmNURMx1zfcT+AqOJwAflu8nw3J8
         54H/+LkI1KUrtMedg9AIzOpOkB1CTy9n76grWdh0Pf+91USkbiGqjXDw12meNTgizgOc
         cCcvq7B1jJJJ7RqwEF3FymRMl66Ox0zHBR9skLcCpFlkm4IUN2EvPIP/EDMkWFUXnTlm
         qDp3Isv5GcZYY7ndOQ8/Q4GZ06KQS6Bz7ZuJ2o/NZ5ppBdBMD0Yv3aMCfc3qIhFZ7q/L
         Ffgg==
X-Gm-Message-State: AFuF++kFFhH+J5cy76vWUlFWWEmv3JmxGJfB5UgkVIiZ0xVBWMKFCNFH
	etg6QvxV+TH2CVLCiSurJAPtS8gpRKKKm2GheF+WHg2/kXwOZA5X9mTEKjSyo6/1molhUfHUmSJ
	TH51BjJs=
X-Gm-Gg: AYBFou3tov2tssLGHDGl3o22Ctyj8a7Y9SYYIZJ0N2NSBN/AQ6aFNqTjN1jiRtZ0XEJ
	0MnEEP7mcUJK7nCNVnGx51FVU7E0LQR1J8qAy4p/YPvjkEmlUCe4hlNhesQahS8MDj/wgBB7Q1/
	Cx1QqH0Ogv2bgga0/3DwuHpPkU5JfolIjvXnFbgi1cCGoSedikB3cZjPSAl1NtNQkYmwUmwIoWy
	dOrR8PJTiORJakstAxP6UMj4a23mGEucl7WJ5aiKUbCVj+RLZ8nmRfjt1ex9aknA5vdfapN/FJv
	yHyF8i8tmIhy8jamLo9OYgEM1YZZVHVPY/I9WiEIBLWvwU55FtBj27lKFf1T2O63nGrBU9ltvTM
	9z9EzFnFvZSCrMeLAGhFfh5WSgojfbhmJWccUhSm5MhUXzCXvvW9gi5WUvFxWwn/s6LweK3Hwqy
	l+jfCQJKfndqZcMiV3OCbIKWnABcjcU8+hTcvbYWpzBeQZqob0jwqpbgJLSp23WQPmomYBshm4j
	xDHOxRiYb57lHh4cRRU/XOOqA==
X-Received: by 2002:a05:6000:4711:b0:487:a0f:82ff with SMTP id ffacd0b85a97d-4887167c983mr4200099f8f.17.1790259984192;
        Thu, 24 Sep 2026 07:26:24 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d896:f63e:1133:71e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684863d9sm15252678f8f.12.2026.09.24.07.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:26:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH] layer.conf: Update to new blacksail release series
Date: Thu, 24 Sep 2026 15:26:22 +0100
Message-ID: <20260924142622.1034782-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Sep 2026 14:26:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4952

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 0dddb81..c7f6162 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -16,5 +16,5 @@ addpylib ${LAYERDIR}/lib oeqa
 
 LAYERDEPENDS_meta-mingw = "core"
 
-LAYERSERIES_COMPAT_meta-mingw = "wrynose"
+LAYERSERIES_COMPAT_meta-mingw = "blacksail"
 

