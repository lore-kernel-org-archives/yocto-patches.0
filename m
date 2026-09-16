Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BCCC982D1
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:53 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27097.1789597848551994682
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=aNwPCHwg;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a0fd41a7bso16607985a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597847; x=1790202647; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oetScjjCGN+fGju56oI3osKZy9NKgixSEM9KaYlVPdQ=;
        b=aNwPCHwg6Jx8rZ138j8opVRubYNgU6NHx9VoStZS0T+JKKWg/XLCiRMg5h5F/oElcb
         iflo3KNdCyWb5aK/bn3O6HDJIeGArhTCd3Ef2OINNvdzgjQ1x/3BAgh5C6SBN8FdHuYB
         wuvw8hZC5ZY6gwv9ZbHYYkdMHWAdUHZILqJEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597847; x=1790202647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oetScjjCGN+fGju56oI3osKZy9NKgixSEM9KaYlVPdQ=;
        b=jIlkBkv+Wf9qP2xOfe0GNt/cGB2GPksdmITUf0SmWEMI0zQ6tNKlkeZ68LABOR1g2/
         yE2VlTWt7d/Cp9n44fG0H8ziLp2+Xx5nvaCGlhzuKt+5SwoUXZF6zD8/uJ0heygMuiPE
         ZFRpu3x1MSHEhumVS7Yv5Jnen8tPhW3Eki8NFNT1wQ4N4IX87krQSxM9WWYaWjjCQmUU
         KkWA7EsqZSGccBTm/c3aA9HmI5JKIeYYDTl+UwnIk7VQs7ihN8qdmoPewLIkYNPYWQ9V
         OgoADfWQvJi5G70iV8oSrFYRZRi0S1l0yDtsW1gFfjUwFpsbvTu7lHt47PkNpwF3vML8
         +zvA==
X-Gm-Message-State: AFuF++mlPpEUVu2ZX9FewwTr/YIEDTxZn+1oyAkqqM2UcVZdCjKcy2gm
	vXT3DPZQBZELvI2lhT5t9Imv/JpL60cMxW+Yzw+MgXNjIrMiOvHCnHi/7q21gAIZgTe7sN1x7xd
	ZX1g5
X-Gm-Gg: AYBFou3cO4i0IfLf/ASrkb9ciAVqdzRZWFrkCnJAZfTm1v/ayOj7DrFRzhZ/wpCZr1O
	WT4MDzOtKw0cFxx34NXXXYAAhI775xgbZBMEG3YX0ZyYUoCxh0vCayCo6HqTgCiaxQZEuTqnh9t
	3odhyhB1JFOYE0g9/5i4fV+3p4nWQNq7+6ZIoyfkw1CBnnApxSy3o7HMdYMSv66lJd0pUh0qDMD
	iWBmtWf8/4yCILIxiF9mHZ64QAjoWrWtUwv6291B0Y3tOWahkpyWKRHRaYuI1K1h5+lLBG9DPpq
	e23m1SujIt0V/8Rf/KYPdjpx+fzhvfKoW47pPluNHPOwUw5E6j5o5lRXaJj4eZJ22vhFN8/x4Em
	y+ewOoi2U2MRTnnM0ZbpKmJb7WxVTTNQ8hM5dDM404Qh8eunaG7swRk/TynrzIFqwzV8WSCLNRA
	aRYzoAiBc+xq5JGkFI6e6KpuuNL/OpL4Sbnwho720YOR4VzA9bCCOxiLCwMd18MEZP5jNRbQUeU
	8Nghhpc+p6L7hLibKrOI5nDp96j6zSVggT6Xw1CEJt4hZS/eLLk4LniWqpPh3TN3gBcN1cugYJ7
	1MZIVFWrXqX1Yk8J1OZmykQHFddn3PEOtsM=
X-Received: by 2002:a05:620a:4888:b0:937:3aae:1385 with SMTP id af79cd13be357-93bb76e453cmr731867385a.11.1789597847243;
        Wed, 16 Sep 2026 15:30:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:46 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 17/24] clamav: upgrade 1.4.4 -> 1.4.6
Date: Wed, 16 Sep 2026 18:30:11 -0400
Message-ID: <d5cebb738186121868bc424f5d5fec3d6e3fadd9.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4893

Release notes:
https://github.com/Cisco-Talos/clamav/releases/tag/clamav-1.4.5
https://github.com/Cisco-Talos/clamav/releases/tag/clamav-1.4.6

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-scanners/clamav/{clamav_1.4.4.bb => clamav_1.4.6.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-scanners/clamav/{clamav_1.4.4.bb => clamav_1.4.6.bb} (99%)

diff --git a/recipes-scanners/clamav/clamav_1.4.4.bb b/recipes-scanners/clamav/clamav_1.4.6.bb
similarity index 99%
rename from recipes-scanners/clamav/clamav_1.4.4.bb
rename to recipes-scanners/clamav/clamav_1.4.6.bb
index e9c2aca..1eb79e4 100644
--- a/recipes-scanners/clamav/clamav_1.4.4.bb
+++ b/recipes-scanners/clamav/clamav_1.4.6.bb
@@ -22,7 +22,7 @@ SRC_URI = "git://github.com/Cisco-Talos/clamav;branch=rel/1.4;protocol=https \
            file://tmpfiles.clamav \
            "
 
-# ClamAV version 1.4.4
+# ClamAV version 1.4.6
 SRCREV = "f6d84be3c0048deb15c54d67e140dae062e5b82b"
 
 COMPATIBLE_HOST:libc-musl:class-target = "null"
-- 
2.55.0


