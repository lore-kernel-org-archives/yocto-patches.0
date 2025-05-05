Return-Path: <emailaddress.ashish@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B87C3ABB0
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 09:22:45 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.46431.1746436964597232771
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 02:22:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JOHcj7Fo;
 spf=pass (domain: gmail.com, ip: 209.85.210.170, mailfrom: emailaddress.ashish@gmail.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso4211885b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 02:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746436964; x=1747041764; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x8Vb6Q8tEOhxeaWFEOD98sqH6apE9layOtVVEf5R2Dw=;
        b=JOHcj7FoR+xos8RNl6Va5GsuNj8nY+JEpHAvkcrHvxjadDQOOaIDkdTR374AowFlFO
         VJUoVP/tO3bgyGpWnc/xr6Dphc4KvfRYETYtVaAMAjqLtE/k76V79SfxYeU6rMe+hanD
         qv+k2o2e8sxBm7K3DMlce2nJ7Xk+NYnnO5sWGkJCkuY5hcJYuod6wiECUzuWJs+J2cDS
         0UZPduydYxos00BGLFBX6cDnMGL3TbrkoLiBm7XKwwcVwPTBezkwiyAHh5BzAWIZ90VP
         5tt088r1hg1kneCPRQ1+MFYEkWseOIcfd0jCVmraqpL5lZQH94cvhOCwWgiEUZi5UE6j
         uKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436964; x=1747041764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8Vb6Q8tEOhxeaWFEOD98sqH6apE9layOtVVEf5R2Dw=;
        b=HaQrcf/WpFyHqqXir4iE/gVwM2B+OGkmogZTH7dFGmDA/EsySGZGLDD217ULjm13/y
         VG5tv1frN6SL4FhX1HNeKf0SQvWFxgNuv19Dd9kkP8tgH5K73SQkt4Gg49y14qppiyEq
         eReEs2a6qi4AMLKLYOp0sjyzIQA54zNtzmlE3J30I6wdZCXCieCfJqWxlOr2h+aImpyd
         MjtprJSEoiOCo21gOxaeOPZ9V1TFAKBtkwUVj+/7jSIfeEB3SoEuUtXLfvHtxEM5KRaM
         1P0bdZB7Q7qP3osKJfLJ0fSwmwgWupTJWGfVV++4WOnbojCIwYazAG1CzwlAlQvi/9VZ
         zUPg==
X-Gm-Message-State: AOJu0YxD/EIQxDLIutYBPd7F4pgzaROUFRHaUfAvjFulHhm1PKOj7whU
	CF2oziHo0eys4T8b5pOTs9Tx9bhfWYBIa2lIm4mABzwHJfxfAU2qcU/e0A==
X-Gm-Gg: ASbGncv6HFNVqKXe0qnBB4fzVRlhdsvTy6xOeA8XlJ4C8P08c7YLPqDsZuppmS5jsSj
	mevSfW662L1/Pga2tGKqyHfWZByRkhf2nQQktWy4rJCC97VOaugMGJgOVEfZtlEyNTYRH/KbqZc
	FGRGYTIfQid5lSgCYVUbmUYgrBMMM/HG6YHvUEeiIpZxQWD3ZBHVzuSa8xVB4NjKzgdq776QF3i
	kGCs4fLnsnLyzqhogC6bRyv8hTHvDmUBJCmJDQT2mv339r3mseUS2kQj87j1yvl9gTf076Ditou
	WUXtAwW6wsggqE5pdQUpyEyCqFYRXyyWpi5/TbOjpMlzW3o36uvH
X-Google-Smtp-Source: AGHT+IHV0vBWIBi4Mtf5/VoLaj8iZ5+1X9+WDO5evjSeYWkVWNFTNd/oy8Gr+wC/qIiFwI2s28CnDQ==
X-Received: by 2002:a05:6a00:414a:b0:736:4d05:2e2e with SMTP id d2e1a72fcca58-7406f0af02emr7698262b3a.6.1746436963845;
        Mon, 05 May 2025 02:22:43 -0700 (PDT)
Received: from MVIN00210.. ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm6487611b3a.98.2025.05.05.02.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:22:43 -0700 (PDT)
From: Ashish Mishra <emailaddress.ashish@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Ashish Mishra <emailaddress.ashish@gmail.com>
Subject: [meta-java][PATCH 0/4] Fixes SRC_URI for meta-java recipe
Date: Mon,  5 May 2025 14:52:34 +0530
Message-ID: <20250505092238.853811-1-emailaddress.ashish@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 09:22:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1492

Below patches fixes the link's used as SRC_URI

- The recipes are failing to feth the compressed tar from the link
  mentioned in the recipe of scarthgap branch.
- These patches fixes the path & tested on qemuarm

Ashish Mishra (4):
  Updates the SRC_URI for xalan-j recipe
  Updates the SRC_URI for xml-commons-resolver recipe
  Updates the SRC_URI for avalon-framework-api recipe
  Updates the SRC_URI for fastjar recipe

 recipes-core/fastjar/fastjar.inc                        | 2 +-
 recipes-core/jakarta-libs/avalon-framework-api_4.3.bb   | 2 +-
 recipes-core/xalan-j/xalan-j_2.7.1.bb                   | 2 +-
 recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)


