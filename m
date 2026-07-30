Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2EDC54FCD
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 02:49:35 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3522.1785379766896400877
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jul 2026 19:49:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=IqdMg5DB;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f706438c3so107275f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 19:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785379765; x=1785984565; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+V9jVTyXH5/P7POLLH8lD2v5G16n3SV3ZLyjM79++UI=;
        b=IqdMg5DBsB3SiyCTtcKqhdFxRf/KMV2Zn/oEUUG67rV3w7PZ4IxjWg3zFEVQJ2EvR7
         GG9DaVTQhttYtt6rmLF34yJy02rSZfGH12mwMzyluvxkssoPKzrGT0xUG1fjUiEihW7c
         M8E3IaOp7d75ccgYcdtu3fEQoqba0z4GCAeDs9Sc4YPZG3opyXXKQbE0P1eebnU7QFjq
         rsX2w0ZVFl6MLzB14AleB9EDPiPLYPQqLwbBvY8ptwbw/GAY1JiJ6BDr0rQA66lOHCi3
         GL4Lpaih8ifD9upXG5AbpzQ85L1gp453X0Y8EfTMsPFhU99acbtpV69OvVDvzkue+IeW
         M5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785379765; x=1785984565;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+V9jVTyXH5/P7POLLH8lD2v5G16n3SV3ZLyjM79++UI=;
        b=ryN0qMiXuu/SbmFDTStG7ZHyxo1GGHnjXg0NeG7h6AOjQPMfAHaXJxytEOnCoyxD4L
         OZWtl6chRhDoYdGTJApaM95tXTSyL/uxaFo4DAUvS+6SSavPAMCwkDuQxqqe/MP2Ggnk
         pHqI+NNAWP+QhvkjQF/zn/kPig1cGxCreYD7wsgnkCGb6m9YOyRGehrbKcQnmvSc2q6t
         /rwqsQGg2TwYlTAInbmZJLXTnWr8lwOrDiS+jB0BTUk9g/aQOkAKGVA3vaK5HAve3fNE
         53Vg36naO2uv6P9TbQ8yFY/DsIZrJSSu/SjfPvaQI6YIJJbTzpHYIUvFyjCvoVVP5ezX
         48Mg==
X-Gm-Message-State: AOJu0YyxL6ujbKrtoJelO7tqdvrjtEGzLoCknhXldh3w1FiyCA+txRpA
	qyJ7NbxsHVep8FVX29y6tph9Tj+wlYHzeyyxRe1gGP19Dw2p3uSEV7d2c9/kuyVWSBg=
X-Gm-Gg: AR+sD13abur31D0Jfhj8BkrceB3FrBKPVN44zi/18NqXzuyOvKCpMZPLr9t+eSWObCK
	ozVBBMTYJNIfb9R5BOhInk6QCoIT8mFRMg8pJrbI4wTMUwfWS+UFehzPuf6x6dQ5+xXU8gVFNkW
	bpRNjEzyglctfLWXtOhwWesCOQ73kCpJizERSAV91SkZKaIYpTEoyv5lq6bjEvUSFYlgx4tT+TE
	8Cro4CbsjBeF/M4/EEuQaux0NhREb9NLzrxFazB05BUSU+JuU/yyTdTvbp2gXmWrIcJF/4gJ1mb
	+45rpqcE4Os07N1+fXIcoQhDVvZSMw38GE69mBiIMxpErsb1t9wHfjs+WWoqxocc/d2aTUgt6GB
	7xVwdRksMtL6IXJH9lnMqaFCQcOkuYkLzwon6JsoduxuOVIhK+vGGWSTZzUp6NKrGjfEx1nMsQB
	HndQu8Gc6wRekRk5FKCrwJLJ1PUTneowr6ItLZrxlPkXAZDJXUKr5JDNI6sYMZjjSusL0GN+uur
	gj24+BowrVea0F10wquiRVrVn9HFn0Qi4x8vxMphNP45w==
X-Received: by 2002:a05:600c:4ec6:b0:495:71ff:598d with SMTP id 5b1f17b1804b1-49800e6d0b8mr8387345e9.1.1785379764735;
        Wed, 29 Jul 2026 19:49:24 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:4bd7:86b5:c090:c54d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011f4eb7sm20647675e9.6.2026.07.29.19.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 19:49:23 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH] docs: fix formatting in dm-verity documentation
Date: Thu, 30 Jul 2026 04:48:49 +0200
Message-ID: <20260730024849.1120938-2-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 30 Jul 2026 02:49:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4571

This reformats the WIC partition example in the dm-verity documentation
to keep the `/boot` partition definition on a single line to make the
example easier to copy and less error-prone.

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 docs/dm-verity.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/docs/dm-verity.txt b/docs/dm-verity.txt
index a538fa2..f33f5a2 100644
--- a/docs/dm-verity.txt
+++ b/docs/dm-verity.txt
@@ -86,8 +86,7 @@ things and remove a bunch of manual steps that might be error prone.
 
 Consider for example, the beaglebone black WIC file, which contains:
 
-part /boot --source bootimg-partition --ondisk mmcblk0 --fstype=vfat
---label boot --active --align 4 --fixed-size 32 --sourceparams="loader=u-boot" --use-uuid
+part /boot --source bootimg-partition --ondisk mmcblk0 --fstype=vfat --label boot --active --align 4 --fixed-size 32 --sourceparams="loader=u-boot" --use-uuid
 part / --source rawcopy --ondisk mmcblk0 --sourceparams="file=${IMGDEPLOYDIR}/${DM_VERITY_IMAGE}-${MACHINE}.${DM_VERITY_IMAGE_TYPE}.verity"
 bootloader --append="console=ttyS0,115200"
 
-- 
2.43.0


