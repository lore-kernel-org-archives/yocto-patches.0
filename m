Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9301CC3DA61
	for <webhook@archiver.kernel.org>; Tue, 30 Jul 2024 01:05:26 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.web11.7839.1722301522933428339
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jul 2024 18:05:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EAWYm0fo;
 spf=pass (domain: gmail.com, ip: 209.85.128.172, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-65faa0614dbso27771317b3.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 18:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722301522; x=1722906322; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VjGWTPeKdT+2YO3Fo8u7pSUIIxaDQT7xEfGK8bT59k8=;
        b=EAWYm0fotfIK4+Q/MK0zg8sJGVlL6JrR/zegFiMk0C9//POSqo0HGYLtyqdv3SWrWG
         zJpUNARf7h+xmsfSg4XEcBr+zbdqvtX/KRluAIJmG6DfDRpTDUspluQHrR2P7iPF3z3G
         YTUJ+jGxAFPOT/V4GDkH1lyArE94+Rcn0NvUDtYuQdNyf6GiDc562k/F4ntGDQPv93+r
         UmoIYOwgD+UIKY84e+3e8OTDNZ49lZ9sNXvdWsEzM/aaa3fluSlifT1TigLtqyTN0+lC
         OIRioTqvfqq6GqXtn7on+n23PnV+wahiPmFi1LSFyAVS9vkFCoTMODaQOF957xGQvzHg
         E94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722301522; x=1722906322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjGWTPeKdT+2YO3Fo8u7pSUIIxaDQT7xEfGK8bT59k8=;
        b=hGHTRw2XcSXBshZONz42xZl3//QsVowKzflaenhOdhuySW5UvM3kGvB3oNE8qRz+eQ
         PGBhcE2jE+DFEEK2RRKGkTMf2GuwyuqITxtsGsuTIfzEMHd/TqPaxNdMIMBDf/g/wG69
         0fyAq/qZrytyaR3jsnSy0lBur7Qbk8J4WfJe1XSLydQA0e2v2Yuzh5qqECqTdmHK1HOq
         Kh1HARBKaP90L5MTs3KF0ByGEBjbEdm4PT2Im55NruV63ZURgA3UH9meT4b7draB4jn5
         0mZe2SdBGTlazMkQPlhvN4VlaIgRgsGM1qljF6Cv3Bqsi4BX5sjValmi4PIswTX2gnc+
         u9nQ==
X-Gm-Message-State: AOJu0Yyge1X+gmIRDPRLQGVRSbH6JJ744ekAmYPMUYhxYNiZZ7Hd1mkm
	+NwsMaSv5iXu5r4RszM/rzQioqwskHtvaiXyuHq4DufFso3NJBde5LGk+Q==
X-Google-Smtp-Source: AGHT+IEw22z2vADYGY7xmCgfK5oU6/R8+7sVrtVElLi34fvJI1/9qvDtsq4D6IjOLWO15srdOmNTxA==
X-Received: by 2002:a05:690c:6f0b:b0:632:842c:d9f0 with SMTP id 00721157ae682-67a055ca3b2mr126195427b3.1.1722301521756;
        Mon, 29 Jul 2024 18:05:21 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:8681:66fb:3bc3:40d0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd8fd6sm23589857b3.7.2024.07.29.18.05.21
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 18:05:21 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] harden-image-minima: Fix usermod
Date: Mon, 29 Jul 2024 21:05:15 -0400
Message-Id: <20240730010515.1601741-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jul 2024 01:05:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/499

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-hardening/recipes-core/images/harden-image-minimal.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-hardening/recipes-core/images/harden-image-minimal.bb b/meta-hardening/recipes-core/images/harden-image-minimal.bb
index 38771cd..4366961 100644
--- a/meta-hardening/recipes-core/images/harden-image-minimal.bb
+++ b/meta-hardening/recipes-core/images/harden-image-minimal.bb
@@ -18,9 +18,9 @@ DEFAULT_ADMIN_ACCOUNT ?= "myadmin"
 DEFAULT_ADMIN_GROUP ?= "wheel"
 DEFAULT_ADMIN_ACCOUNT_PASSWORD ?= "1SimplePw!"
 
-EXTRA_USERS_PARAMS = "${@bb.utils.contains('DISABLE_ROOT', 'True', "usermod -L root;", "usermod -P '${ROOT_DEFAULT_PASSWORD}' root;", d)}"
+EXTRA_USERS_PARAMS = "${@bb.utils.contains('DISABLE_ROOT', 'True', "usermod -L root;", "usermod -p '${ROOT_DEFAULT_PASSWORD}' root;", d)}"
 
 EXTRA_USERS_PARAMS:append = " useradd  ${DEFAULT_ADMIN_ACCOUNT};" 
 EXTRA_USERS_PARAMS:append = " groupadd  ${DEFAULT_ADMIN_GROUP};" 
-EXTRA_USERS_PARAMS:append = " usermod -P '${DEFAULT_ADMIN_ACCOUNT_PASSWORD}' ${DEFAULT_ADMIN_ACCOUNT};" 
+EXTRA_USERS_PARAMS:append = " usermod -p '${DEFAULT_ADMIN_ACCOUNT_PASSWORD}' ${DEFAULT_ADMIN_ACCOUNT};" 
 EXTRA_USERS_PARAMS:append = " usermod -aG ${DEFAULT_ADMIN_GROUP}  ${DEFAULT_ADMIN_ACCOUNT};" 
-- 
2.34.1


