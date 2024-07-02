Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE87C30658
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 06:50:27 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.18817.1719903005352411346
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jul 2024 23:50:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=DTFDxE3W;
 spf=pass (domain: mvista.com, ip: 209.85.210.175, mailfrom: vanusuri@mvista.com)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70683d96d0eso2240423b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 23:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1719903004; x=1720507804; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E9H4VEuvSgeuWlQdJRFaipXQscKbeS9QwN9X8W4VGiI=;
        b=DTFDxE3W6GKNXnrI8031WMRvQ8FK7XBOplvFrv7Wef/ftqUKlqxzlA0rB75TCOQ8eG
         9WuJTQ/xNJ3BR9Zg6vDUUpZ/54v5W/B4arNGYaY2jRF+5mRewui/h880xd3LB2XxHusI
         xDjlCTuXiweIprg0w/Cu+5X8/E5qLUab2xGUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903004; x=1720507804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9H4VEuvSgeuWlQdJRFaipXQscKbeS9QwN9X8W4VGiI=;
        b=GXjJTbfnwNFjQt0vSPerUsmVTsFfOw/BYW8qQ6DyrH2ZvY54L4BM3Vz4XTzWpw3zD2
         0ylMmm+IavnxGgL0Xktrdw5URYEns9k9FlmleSTfVd43olhnM3ZFiE1VnsoGzG4IGW73
         HhzhXupanHhpJTHzrMuWi7nuRMRg7GO8WxgXgJgB53Ef3TpEtBP53ulsqhGo16W/H0Xe
         QtW/h/RoXUvBJo/GmqwzrHmq70njx/EKGrjtMYcy+Y6BXu5I3GVXIW6iSVTOukU201ez
         MCyiU0G48Ywo8xw+6Xd5lbluNRWwahpysu6rlBK9QoSH4yj5urHB+gYwt67Am8WRnwtD
         WjKQ==
X-Gm-Message-State: AOJu0YyiotiXGCV1eTZIxnRLfqgIH9pHiLqvIaDybSOOSgPhEkUQ7hzK
	9cigut8yjEtVH3BNN+Fi5ufSmvRR0zTdLWDlUi6iAW5hO5cSgheZjJWLpeIAkNsy3/0lE9h9Lp3
	2M0k=
X-Google-Smtp-Source: AGHT+IGykTo/Hg77goXzcRMCm6B4f6m1jp+lkwSqlng1+5eKmZJTGRtHt3edUwFa5yg0qki1q9bGEQ==
X-Received: by 2002:a05:6a00:1388:b0:705:ccec:5eb2 with SMTP id d2e1a72fcca58-70aaaf08de8mr7413207b3a.31.1719903003790;
        Mon, 01 Jul 2024 23:50:03 -0700 (PDT)
Received: from MVIN00020.mvista.com ([2401:4900:882f:8929:cdac:a43:d5de:ddd8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ae3a0sm7913364b3a.173.2024.07.01.23.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 23:50:03 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [meta-security][master][PATCH] tpm2-tools: Upgrade 5.5 -> 5.7
Date: Tue,  2 Jul 2024 12:19:49 +0530
Message-Id: <20240702064949.1631187-1-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jul 2024 06:50:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/405

From: Vijay Anusuri <vanusuri@mvista.com>

Include Security fixes:
Fixed CVE-2024-29038
Fixed CVE-2024-29039

Changelog:
https://github.com/tpm2-software/tpm2-tools/releases/tag/5.7
https://github.com/tpm2-software/tpm2-tools/releases/tag/5.6

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 .../tpm2-tools/{tpm2-tools_5.5.bb => tpm2-tools_5.7.bb}         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename meta-tpm/recipes-tpm2/tpm2-tools/{tpm2-tools_5.5.bb => tpm2-tools_5.7.bb} (83%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
similarity index 83%
rename from meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb
rename to meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
index 9bad758..bb422cf 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
@@ -8,7 +8,7 @@ DEPENDS = "tpm2-tss openssl curl"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "1fdb49c730537bfdaed088884881a61e3bfd121e957ec0bdceeec0261236c123"
+SRC_URI[sha256sum] = "3810d36b5079256f4f2f7ce552e22213d43b1031c131538df8a2dbc3c570983a"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
-- 
2.25.1


