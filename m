Return-Path: <emailaddress.ashish@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B805C3ABB0
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 09:46:56 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.46409.1746438408773731647
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 02:46:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eXvWlOSr;
 spf=pass (domain: gmail.com, ip: 209.85.214.175, mailfrom: emailaddress.ashish@gmail.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2260c91576aso36169995ad.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 02:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746438408; x=1747043208; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2LTXUBcdhU3/GZDfQ+DFOnOwsi5sdzS2u0jj1KDMHk=;
        b=eXvWlOSri11dBRBai/HEwJVt6Jyu+CgE1KjSDN/y8/tyGbmMsysHIArDmLtJCWVPk5
         ZT/UhVkh9SzfuvAtIG+76T7au+2gugLsndUjNiNNHnIQ0zFNzp38b3gDPFVQINxoCbC1
         gkbKfYkzz0JmXXz6sjMq5xzzwoYt0tKK2sTVi9qMqbWUKYHp5cl+YhDR+Y3pmNlJBXwN
         OzMMHtASbufdmmYlmV5yZ+W0zNe84v3YSQfHIDUTsRwssU7jKnJPC1Tm/sMeqWj+T0j0
         FvlEjoTte5Lb9axWPIF7KSLiStQx+PHnTNd75fCsZC5Fj6oSCE84shTRqSISnXYkskfF
         gchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746438408; x=1747043208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2LTXUBcdhU3/GZDfQ+DFOnOwsi5sdzS2u0jj1KDMHk=;
        b=kTcuaGn/D+CtoD/lSX/opjzZUcUn9gxgQqooES8701vjwfYtivIMWfywHb8lKu/AUX
         2d6wppVOIkslU0JTdzw8HA789mtbBlJIE7QQbk4dbNdiyk2G7zDYig1zOTpzcrtrGsiD
         JYCB0u0u1E3mhI8gKqNwfCJZILXdBz23Ow6ceBMI12iBKuJCwovxh3lFNai5H4bIwBWO
         mVXZl4BX2M6196EXQz2vwjdZNh2tNiC0jS0QiXpkmpQePghNVqijAHxEm9eUtKmDmMq5
         lG7gcu1gtsR/3Em2e5T8kNXZnJIBp8MhsQ4ZfNke3r9gDYYioZXY+YN1RBpUlk1hZAup
         UWXg==
X-Gm-Message-State: AOJu0YydMpSyuzU9MiKV/EKz6ynmTEAU/BfFfI7kQZSv7vlzcIUXMHPi
	YiE+AL2OSWDA9ou9d8/HWW3+7LQ6H4ZGKDAfclNSG1it5qRwku5UmGCeZA==
X-Gm-Gg: ASbGncsUTfiuk/xWcwTxoU0OPKCQ2BcCo6eXfcRhdo2/rf3glX7A7iS56FxT2IjOTZg
	ukeSfwaGGWN5zVzbO+8Gae8MZB/HoOil7FmrcgpWnPQNI/jcc9w84TfNFR/y0ftgLJ3nHWuQsOQ
	3K/hagVAUBM5/U7Y7X/3Y6Rwk6QHrzgWffkzk2E42NYDesSwxJjeVrRGYQ9xLdgspzQwR1yaE5k
	w8pxJ9KJH9VYH09ilEh+chhc6Ld+ju1nBSNRbWZAalqdtdJzQQgjr+ZhED68sC+9r7AW7gSHYmT
	sD7Na2niejfUhKBw9s6e6A7opEGunCZm6gUaWiOvf5SOlhvMI7RT
X-Google-Smtp-Source: AGHT+IHHdgNaapzgY68ig2yxGBghqvY69HNcGjh/UPRQlkb5DEovG+jAGU4va/0Cc5k8hJHkbBuUGA==
X-Received: by 2002:a17:903:1a10:b0:224:1074:6393 with SMTP id d9443c01a7336-22e1eafeb7fmr101243405ad.43.1746438407901;
        Mon, 05 May 2025 02:46:47 -0700 (PDT)
Received: from MVIN00210.. ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e93cbsm50283585ad.56.2025.05.05.02.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:46:47 -0700 (PDT)
From: Ashish Mishra <emailaddress.ashish@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Ashish Mishra <emailaddress.ashish@gmail.com>
Subject: [meta-java][PATCH] Updates the mailing list for meta-java
Date: Mon,  5 May 2025 15:16:42 +0530
Message-ID: <20250505094642.941006-1-emailaddress.ashish@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 09:46:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1497

The mailing list is being updated as per commit
"ac65b6e5bbd2c9b55a64a13ab4c55d212a8b585f"
in meta-java

Signed-off-by: Ashish Mishra <emailaddress.ashish@gmail.com>
---
 CONTRIBUTING.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 00c7b88..d7cc308 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -14,7 +14,7 @@ Contributing via E-Mail
 -----------------------
 
 To contribute to this layer you may submit the patches for review to the
-mailing list (openembedded-devel@lists.openembedded.org).
+mailing list (yocto-patches@lists.yoctoproject.org.).
 
 Please refer to:
 https://wiki.yoctoproject.org/wiki/Contribution_Guidelines#General_Information

