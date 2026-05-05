Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3963CD3427
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 19:23:16 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1868.1778008993338892154
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 05 May 2026 12:23:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=R8iiPUa1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48d146705b4so15656915e9.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 05 May 2026 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778008991; x=1778613791; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AxiI/4h8OofEPOqdlJoP/NonWW6X7+pxrx5fmuE2uSM=;
        b=R8iiPUa1R3R7lnh6LiBRo4sryCcbhwLfJSSahw/MoLPV0ox+Tum1FEhqFlOXilyZIs
         28FY3jBSsAvwS6J0lxqUOASDeOHPcItMW2JjHfwzRyK6TOGBzx95/vlJS/XgyGbeXJNx
         Scy+WhS+RS6U83+ldvh7DvYRZdJDK3jrWZ9QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778008991; x=1778613791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxiI/4h8OofEPOqdlJoP/NonWW6X7+pxrx5fmuE2uSM=;
        b=Fq4KniRRfMv1zfTOb87F+hYdPpY31pwJpA7rN0zhigqGK5vYuMZdW0IYlO9NAF2Rwi
         iO7g7YAzUEh6jgOwkndZ0G9bKmVE7TrmtQlTC80X6JRLmsHjS5lrB3+Vy+UQ5o1OwWT0
         Msf9YfJnYQDmpPKl1XlEU4ytTAyWUkQ0dKnCoyDYqcfynGen+XOSlQ3QKUuT71hxWdGa
         t16jttDX30klzi1/g04281s/Za5WHjQgXrv0NpxcFGOIZBvMivFvtTmhlOMSGfsyZnTj
         Kfq2zfocAcOEfvibTOEyIr11wpwn1S6g6ndya6fFF60VlXnTBMhdiOYZcv4/3xTYEluU
         s4oA==
X-Gm-Message-State: AOJu0Yxkc7YqhW2gXnjRFRnA2f/Vph55ToS3aog1rc/yKG4ZzB57caB1
	Z28iy3v+zZBEQm/enwYe/ty6whuCQrrz1kzekVQ7oIyhL0/KWdvNy0i9NGZe0z2hlikgrAa/HCP
	HsOFj
X-Gm-Gg: AeBDievVhQ+TJA/LjC2JaikZpoVd0ZcimqF4ADXVCdztMnDpH4UD9ZzXQ6g7XL72YAq
	mZHQ1EKhAqBkhOB1pGPMM+vq3rCWYL05cLv1b+R+AdsXDjjk/ZdTNlL/p7CcIUkHIYlBDi3J/8A
	JG7BuBo65xYvpEKDDYRsJ1Ch5+l7eKeZcKTnN5Yv5jopzWZ6xDDtCWIrYitCC7MnzQeY9q9L3Gd
	1ZqmAsQeYDzZEdDkWloaEacYb5EKLyY/RvWdtl6zGBa91VJ3V+P4O6RZ1NHQbo8aj8ZFENykfa6
	tqrp0EB/SjyaHR9GCXrgGIlG2K7LycEO4Tk5jAqjP8A0pcDULzqlv4xSIbkBw0zwQl+vkhVzByC
	kwyyogZKx3mkOb90FkP66YepdE4LigvK8dVb1g3i0z4BtLCT1qqfLz8GayxBBb0/6YZ7eB/LVt1
	ybHF04bWh2s1Cqg60qHaKShKTxJjkbsANYMr+watm1HzaolZmg1ckghjBiH6QRbAf01aoTbGiqK
	pjEVwGwCvhI
X-Received: by 2002:a05:600c:1c26:b0:488:9439:880d with SMTP id 5b1f17b1804b1-48e51f5c282mr8432085e9.29.1778008991088;
        Tue, 05 May 2026 12:23:11 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:561f:9420:ad01:54f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm668733535e9.1.2026.05.05.12.23.10
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:23:10 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Drop obsolete worker config
Date: Tue,  5 May 2026 20:23:09 +0100
Message-ID: <20260505192309.3253010-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 05 May 2026 19:23:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3920

Drop buildtools information for obsolete autobuilder workers.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/config.json b/config.json
index 6c1a932..f0e220e 100644
--- a/config.json
+++ b/config.json
@@ -1999,18 +1999,13 @@
         }
     },
     "buildtools" : {
-        "ubuntu2004-vk-arm*" : "${BUILDTOOLS_ARM_URL}",
-        "ubuntu2004*"  : "${BUILDTOOLS_URL}",
         "alma8*"       : "${BUILDTOOLS_URL}",
         "rocky8*"      : "${BUILDTOOLS_URL}",
         "stream8*"     : "${BUILDTOOLS_URL}",
         "alma9*"       : "${BUILDTOOLS_URL}",
         "rocky9*"      : "${BUILDTOOLS_URL}",
         "stream9*"     : "${BUILDTOOLS_URL}",
-        "opensuse154*" : "${BUILDTOOLS_URL}",
-        "opensuse155*" : "${BUILDTOOLS_URL}",
         "opensuse156*" : "${BUILDTOOLS_URL}",
-        "perf-alma8*"  : "${BUILDTOOLS_URL}",
-        "perf-ubuntu1804-ty-*" : "${BUILDTOOLS_URL}"
+        "perf-alma8*"  : "${BUILDTOOLS_URL}"
     }
 }

