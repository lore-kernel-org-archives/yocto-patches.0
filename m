Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E9AC02194
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 14:30:05 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.42583.1738852197047432809
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Feb 2025 06:29:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TG4WAych;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7157cf352so409540666b.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Feb 2025 06:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738852195; x=1739456995; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WJJDBg3gVxo/aK+WaqOb/4Nx5GPpVic/6bYWeXYjb7s=;
        b=TG4WAych6751hTO1SA5mhXZRlEVFcLdHGAt5LiCr9DbQLnwXLPsKRv9oVCrFHz5irN
         uhT6bXEvCMXM+duoRkBnYGvEy8bsb9nLx4DZWfRJji/hXMCj6GMK3zlCevzGFS6QWf8K
         vw1DQE3A16vnAxAu4+qvL2i7TK0NuC/zHVS0C3xyIAOAqXlM6W72c5rUCLxwVtspBQog
         ciakgfJPRK304Dv4fhWakjdVZx8PbxhnCTpC5jUROg4VxqYXrkn8yzZau8Bw7yJ1t5Wm
         3Uf8c1xbGXHQr2gkWjeJTISDws9SL8CnE5ccWaPT+/LXXZPJPjaRuesTyA1c5b9KU9/3
         VIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852195; x=1739456995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJJDBg3gVxo/aK+WaqOb/4Nx5GPpVic/6bYWeXYjb7s=;
        b=gFaaAv4V+MGgI5qz8+OMWRKMX8mZGrzlFtw5aS2eeJIlQtmHgemuX6/TKQmrWTJ12g
         qLurzD212fwJOwQiJ3PumcWyFYJAKLmLwn9/9o2vyp39IvJPBfbth/X1+6YG4mIqg+0m
         jsCCPCLhwNZakgG+81tZJ3Fw0qgMQXUAXgE6djkS2W9qLp/2cAU6gDUge8c21wWMMMVy
         n1DkT3kpYjK/9xxXjzwUGHzRNYaMsQtADtVVvVAF5G+wPHzc2yDrcdRCXFYoPRGTo/F3
         6dSYybM1KeBcpIqzGbyPm7VJjCYpSrCVtguS/qbnD6O0f98OJ1+4kHZ2T7idw0byi1o6
         7PjQ==
X-Gm-Message-State: AOJu0YxZB3dFbTo8+CmVtwf11rD4K88X4nVbT2DUZCLiGwuPWFfoP9Jr
	grzInaK1NQirCbLo2fq9xLzKkai7Lct4fyzwX1lHJuhVp5lYIR+COYK1Cw==
X-Gm-Gg: ASbGncvyXamH85e9J+pT3Wm9lZISmS26+sigNI4N0NHAfQioAYtkEKMylFlWdqV1VDV
	yOEDFrSECPBg8WexbX9OtwqFowE9tur4lLx2QwNDFfKXF1hhzYJb2ATjjrga9qGcr1rbp0rHPoq
	6C2N58L0BcacrIyj0/MS9bnQVxBOTnPT+GBFPCAA8RgTlsawumNXNquWJanOAts8y2F+oeviHMg
	FR51X0b/dFHD+VBmNDuPh8V9ydOHmaUo2CqTshyJcL5cRAc0Ht1xYyGTcoekiM9FId25CJJ+7Yi
	+FCIT0lfxKzXJ7+o/g==
X-Google-Smtp-Source: AGHT+IHAh9h/zL1CWmpPxucdMLPxehzBLcPvQreI76QLauKbbB+B7f/NHDfYMzR4h69oXaA6lvx/8Q==
X-Received: by 2002:a17:907:3e14:b0:ab3:a4bc:ac4 with SMTP id a640c23a62f3a-ab76e8ad263mr386164966b.18.1738852195279;
        Thu, 06 Feb 2025 06:29:55 -0800 (PST)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab772f892e4sm107979266b.64.2025.02.06.06.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 06:29:54 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][scarthgap][PATCH] MAINTAINERS.md: fix e-mail address
Date: Thu,  6 Feb 2025 15:29:52 +0100
Message-ID: <20250206142952.17877-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Feb 2025 14:30:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1045

yocto@yoctoproject.org doesn't exist and yocto-patches is probably better than
yocto@lists.yoctoproject.org

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 MAINTAINERS.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS.md b/MAINTAINERS.md
index 09a0cef..e049457 100644
--- a/MAINTAINERS.md
+++ b/MAINTAINERS.md
@@ -20,7 +20,7 @@ When sending patches please take a look at the contribution guide available
 here: https://wiki.yoctoproject.org/wiki/Contribution_Guidelines
 
 example:
-git send-email -1 -M --to yocto@yoctoproject.org  --subject-prefix=meta-tensorflow][PATCH
+git send-email -1 -M --to yocto-patches@lists.yoctoproject.org  --subject-prefix=meta-tensorflow][PATCH
 ```
 
 ### 2. Github
-- 
2.48.1


