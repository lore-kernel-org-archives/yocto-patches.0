Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F3E77180
	for <webhook@archiver.kernel.org>; Sun,  8 Dec 2024 17:53:26 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.web11.82923.1733680401022880349
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 08 Dec 2024 09:53:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aAbv97VT;
 spf=pass (domain: gmail.com, ip: 209.85.128.174, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6eff4f0d9fcso13258757b3.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 08 Dec 2024 09:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733680400; x=1734285200; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbk8TNm5IfqoA39xvgn8DQTVHRlBQ6ZQJvr2s6GBeXQ=;
        b=aAbv97VTKRxZQfqLZ6uiBz3PPDLQ3XKsX92Y2K0S6n97q1lg+BRUoeAGN/UkoBxSPB
         X+f660iFkGqlPyIbuj4GS/oAwUhro8ggMcg+lJJ0u1EHvV0cWqkORB8BOwOIugetvABv
         7//V7Ixv8uyve7M4F0eEe0FSXAsU/qFzcssBQDKJkFId0Ap/LDE/5riTnAzB5VRu8U7v
         eDSGsDnGX3X3hLvMcnWUd7e5qf/b7O+R4SfMgzstEuWTOPolE4FCJ/eHax1jniZrODLU
         YslbttZBjnssFQT1I5cSzqHXL1rcdHZDWDvc3T4MbMiPoPtNM4z9/1oN+ArSVFpO27Yw
         gkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733680400; x=1734285200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbk8TNm5IfqoA39xvgn8DQTVHRlBQ6ZQJvr2s6GBeXQ=;
        b=E2imXRaekYx+ud9DfZ0oXdrlLG0q5PMxvYDMozwxHvukKc2jtZDs7/evjH4K+ddMCA
         BV0Ui6xinIs8wTucHKwiO0gM+RfOPz5H0rDwC/0UZrVEDbvTKGoH4f1wgTgYYcH8pKNw
         2eh7FlZ+JNIgjoR/4w249ubjE/YMiVjPz+gxclnvYN2Ak4/GerAIe73Ojwhx0xyvh1xE
         332gFZKYRexnOP87JZ4nBDhyTZLYZkGuPJiqUte51DCzPSSA93CdhiO1i6hwNmV6+wCB
         0eMcTDU+dRpKB+EcxcOn4L/FFuuRGtaFvmKqspKWqy4nmNnHt/otxtUb4VOJL226LUCy
         j8zw==
X-Gm-Message-State: AOJu0YxB/rMPXXrlv73ByNsj44SW5b6/MNP58kQGp6k01+hNn26UVWuH
	2WN92c3zT6AH8I1wkVeTNT2WZUmhQ1p25VPNEp3wl3SbMGjauuNjdeZWJzaH
X-Gm-Gg: ASbGncvxnCi3P6s2I9fzx/S3S9kpPJe+R/2W5S5wWIH1bmJLn2MIWdO7dp5R2ZV/KCt
	2jRc0Zz4IYkcID0cPU+qS99BK5khQpgKBVf87rUZsvt5beFc7YmKyHG0zCdjycuzkQGAasLv1S3
	0xAUa0mV/3fF9jdfAakaDiey7q15EViFOYWfDZRpBDETs469Fe7L3+JippUc86w0mbA2NeJ63Ma
	el78CYDav66E1RZThTyQdojWMKVu2ZV8k4tmTQgmQ==
X-Google-Smtp-Source: AGHT+IHCy9iL99fG2ycCrRsS49kP/Mm6b5prjpAcr0s+GBQwitiffRvJIcwGpmqhRobD19JbudwdsQ==
X-Received: by 2002:a05:690c:450c:b0:6ef:458f:284a with SMTP id 00721157ae682-6efe3c0ee99mr110209407b3.22.1733680400117;
        Sun, 08 Dec 2024 09:53:20 -0800 (PST)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000::d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6efd384eadesm19103777b3.26.2024.12.08.09.53.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 09:53:19 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/2] drop: debug-tweaks from ci
Date: Sun,  8 Dec 2024 12:53:18 -0500
Message-ID: <20241208175318.833015-2-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208175318.833015-1-akuster808@gmail.com>
References: <20241208175318.833015-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 08 Dec 2024 17:53:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/870

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 kas/kas-security-base.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
index fa7915c..bdd74b1 100644
--- a/kas/kas-security-base.yml
+++ b/kas/kas-security-base.yml
@@ -43,7 +43,6 @@ local_conf_header:
     BB_TASK_IONICE_LEVEL = '2.7'
     BB_TASK_IONICE_LEVEL_task-testimage = '2.1'
     TEST_QEMUBOOT_TIMEOUT = "1500"
-    EXTRA_IMAGE_FEATURES ?= "debug-tweaks"
     PACKAGE_CLASSES = "package_ipk"
 
     DISTRO_FEATURES:append = " security pam apparmor smack ima tpm tpm2"
-- 
2.43.0


