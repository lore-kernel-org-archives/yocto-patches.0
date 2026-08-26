Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816AEC61DCD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:59:04 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22440.1787777937337291707
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=jx8UHgzL;
 spf=pass (domain: konsulko.com, ip: 209.85.160.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52f9fc510e1so2282461cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777936; x=1788382736; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uIzjFyKAE+nT/7IgPCDo0Ild3McayTNNgUw+l2eC7hk=;
        b=jx8UHgzLxMENm8jkNhLkd73QJ+U8tbzQnpRb/3jfRyAgT5s4kWang43PC89galCv87
         S6hntftY4lKsDRMH41jNBB2X+4aqWBRtciStkthN0Sv7+rumdk0OycrnhImBhVrbuJvF
         EyTtCS2NsNgngyx2yjKSeCMGRg54laCjO7Eeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777936; x=1788382736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uIzjFyKAE+nT/7IgPCDo0Ild3McayTNNgUw+l2eC7hk=;
        b=jGZTBT08UahGxh7hxzzF86se+6dAFMvkAkfsHemsCR+8fycDPJd73Q3/Eg7PFazd/l
         TcVtPrhfJBRNihVI2Jdj7+ECTnHAAotS48L+YMFmSM6dasjs2FLbd/fbNvTsbWBOJjH1
         2wSLOkBGgDE8q9FfcUkUfoPVv7g9yYf5N2hIMu9KP35eyicNBHNiBcNWF8czIUUPIF1v
         MDw51ndWyc6gV5zQZxE6sPAHAEk5FYQZyPln7WLH85X2I13ZCkqOs3HaPz75xkMopWTp
         l/lYcDT9QU7LwXoeWVBFvLHcGqqCJIXA4XKznOHoIPgda3jr6sU6jWCnWbb58t+CxGcb
         ZyeA==
X-Gm-Message-State: AFuF++mQiXBGi5xel6gTv16tZZJIzzymVmsQVkdMYHF+pB1nP8DSQZui
	vtWe7Bwi3mur4swJCbrnwrx4zHlXzRJYGlUXQL7TTA/R8Uho+CSYP6prZbs3vNkYhAnY8iegNY+
	IDI8x
X-Gm-Gg: AR+sD114XML+zAVDyAqHaP5pUxdDNa0VcO/VJL3eGv8rEWuzMEf3uxWY6PL/bp8r5G6
	eJNSkCzP1aO81UrClOumljSZOKX2oKCyYI5MSbE1N9096k784NwCC2RoCzqgkj/AYM9+3OlZsXf
	pl8oz1UWOueAU7bXWI1bL0aFy7eePgl9EZCKAbU2pW7Qx/plVA3TXN5ORlaIi9OIyH928HzYEZg
	Fp3yjuGv5ljXP7E7mqjB/lSWU6wftDSzDGXjZEoCgnzrOKv46TRsF4IOCffnf+bsXsp+owduBLq
	Zm5IraKSKnWt1/ixuGIEOA9ZCWbxct79VFn5grJ738kII5NF4er8tppQSyi+htyX/nlRgus0rkf
	SMbtWA6J/dBQwA1Up0F/184qWC5U6QPzpvuU+8C/9+qWLIZJLayqFxm1svd6/1n9m4VA8ONzqK8
	ROoWDdID+VDM1u48XlKk9tOEkSR2xZtp0/DHq2cKLBVUUB9w3pz9lqjM4nvizuPKeF8ML4GDOe0
	G0DMY00HcIhqGxOVkBrUnKhdOyh8TGlJymPkZf5LGDj0Trdmq1T0XovRxEvJzoUUHhU9KQvfESt
	ITGWIoHZQNSI5fimBj13fReGcw==
X-Received: by 2002:ac8:6906:0:b0:50e:474a:47e1 with SMTP id d75a77b69052e-52fa1bb79c7mr28764641cf.10.1787777936142;
        Wed, 26 Aug 2026 13:58:56 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:55 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 13/15] meta-integrity: Fix ima-evm-utils LICENSE
Date: Wed, 26 Aug 2026 16:57:47 -0400
Message-ID: <91c2bfdcc2565d197d3c57e44a895b3c97631375.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:59:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4705

Update for upstream switch to SPDX syntax for LICENSE to silence QA
warning.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-integrity/recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb b/meta-integrity/recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb
index ac0a383..c382cf4 100644
--- a/meta-integrity/recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb
+++ b/meta-integrity/recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb
@@ -1,5 +1,5 @@
 DESCRIPTION = "IMA/EVM control utility"
-LICENSE = "GPL-2.0-with-OpenSSL-exception"
+LICENSE = "LicenseRef-GPL-2.0-with-OpenSSL-exception"
 LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"
 
 DEPENDS += "openssl attr keyutils"
-- 
2.55.0


