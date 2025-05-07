Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5738FC3ABBF
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 13:44:03 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.9610.1746625442928046700
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 May 2025 06:44:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Le3BzGmu;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.170, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c277331eso877361b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1746625442; x=1747230242; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHjtMiBD2ozqKpMhGWBASgmSn3L3cW5DPhDo8w85RQI=;
        b=Le3BzGmuJpw7/tDoe/eoLzriOEqiFfbJw2J7YUQ+rmlD/yxgYQ0gzpsWjH7qQ7RBcv
         J7hl0CMsqs2mJL33kEvJKTAIZWq0HhZUKfgRM5QDbgmUQlDgd6vXQvqVvZYGsy9JjGBW
         NljTmPh9aTVF2uxUFAzp6IDZuaqNFA0+g8K9IoDFjzJ7HB93avFRi5NQjBYt30xfRNzO
         Yo1VaZ3+gJc6ejb0USVjt4qhAyGrEDYOCk7guBG2aZCVc7tj4SUo9q5yN2lmF7CMAS9J
         5EbQsXIQri+Xcm0MsHkhxrmrcoFIPeS1+FqaR3rDf2X/a00MSWERyvC8cmjnHB2Y7hse
         9c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746625442; x=1747230242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHjtMiBD2ozqKpMhGWBASgmSn3L3cW5DPhDo8w85RQI=;
        b=q75n4wx275MX0hHp3+/ISr47mHJgMX61eG+hFznwZuIMVQSPG9W2SNEGt7JSQrRgWQ
         j10qTbXCqE72HI9Dfd7fXnCLJmTF1a5SpCP7WSOt4VAq5+ybyhpHUdG+ZYCOWG32OGlh
         9RoDOHR40rtT0s1DQ4o+jqOEjdj/kO+fPJqe2FR3gH/N5h/GrGxL+peaJKWyceN8PmC4
         lwec3OS26ejZMOx0yHzVqHyzxgREhNbX/OliUAiLtfEm1nlGobgoQbj6v5mxt6DAt3Br
         qt7Tpib+SToMRs6TwGzsfJityNQC5PQrm9VwLHX4Y1zTftVkZucZuEynZuOXAMc4f9jl
         zraA==
X-Gm-Message-State: AOJu0Yy8ykN4a6uDdVpS4aYO/Y8n/zzXy0PsD1VtOmo82UMd8ahAMRI6
	RpZmbLGcccvlLffsjWMgqrmWMaQwM3w0JVD4CVodMa8AomdXn0Xcj2uum7RUUCDKkaWTLdPJj91
	v
X-Gm-Gg: ASbGncv4PwZIzHtEFB+LhkxXdKrgEglGNWxz1ZkaO2NEgLH9OrCZiYNmtb4Rrqt2p5U
	9rF6Y5NZr6J/bWeIWSbwOIrShOD2zMzYxkx98GLYrX3AVtKjyby7/q1lWJeLfrPjCI8QfGTfqmL
	cNOlfJ4cJFDRzEioSWgXu64bbZc6sFw1S9ttPTYDzOmfp/0xUhZY+i1N3mwIJZWvAac4J25yoa3
	v7Ea6WW4G1VKA2T+n33WioULkjNwExwhTTVzPibfw5xOsVhsU4ZLVl1C9qp06gsiYYpSBGOQwk3
	0sbBtfKJl1hs3x2Jkl/xceEPm6nFGqmG
X-Google-Smtp-Source: AGHT+IFLzuISXBUaagJXMGjrgPGjxZ0sM7pEOwTib7XdmN2OcbT9n/i/mW2zWT6UonYqoGKtKuwf8w==
X-Received: by 2002:a05:6a21:112:b0:1ee:ab52:b8cc with SMTP id adf61e73a8af0-2146b3c1edfmr5960023637.21.1746625441697;
        Wed, 07 May 2025 06:44:01 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:7681:5b3e:8acc:798e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fbe65d9c3sm8098113a12.56.2025.05.07.06.44.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:44:01 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] schedulers: update branchdefaults for walnascar
Date: Wed,  7 May 2025 06:43:57 -0700
Message-ID: <fe6159a484d65b2d610e6c0f6cf42161cb2c2367.1746625332.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746625332.git.steve@sakoman.com>
References: <cover.1746625332.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 13:44:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1527

Signed-off-by: Steve Sakoman <steve@sakoman.com
---
 schedulers.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index fd2cad6..9916d8b 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -70,17 +70,17 @@ branchdefaults = {
         'branch': 'walnascar',
         'branch_poky': 'walnascar',
         'branch_bitbake': '2.12',
-        'branch_meta-arm': 'master',
+        'branch_meta-arm': 'walnascar',
         'branch_meta-agl': 'master',
         'branch_meta-aws': 'master',
-        'branch_meta-clang': 'master',
+        'branch_meta-clang': 'walnascar',
         'branch_meta-gplv2': 'master',
         'branch_meta-intel': 'master',
         'branch_meta-mingw': 'walnascar',
-        'branch_meta-openembedded': 'master',
-        'branch_meta-security': 'master',
+        'branch_meta-openembedded': 'walnascar',
+        'branch_meta-security': 'walnascar',
         'branch_meta-ti': 'master',
-        'branch_meta-virtualization': 'master',
+        'branch_meta-virtualization': 'walnascar',
         'branch_oecore': 'walnascar',
     },
     'styhead': {
-- 
2.43.0


