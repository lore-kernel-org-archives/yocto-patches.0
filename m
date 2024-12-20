Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8533E77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:05:12 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web11.152213.1734703505609404911
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=O6Ik1opn;
 spf=pass (domain: linaro.org, ip: 209.85.208.175, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3023c51146cso20309241fa.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703504; x=1735308304; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uiZu4PFPvH48mQr0f3oDLOK2l1HAKc13nLmzWRle8w=;
        b=O6Ik1opnZoYVj8Pm5C3GGEWes/arTFU9jBxJwQKQJFAoad9OHvy8URn8EVr6j9ZzCH
         5R2QnrWA5a18AjO9Nbd7WlkHad98FGAuiZLr6+Ryx4qQfm7TtGWbtGorfJ3flLx1RsTE
         KUdmBRUlaQmt2nBhqwdv9KrB4rDC3IAa7xG8qWnIjWrGnchN4Fu93mweZCXsBV3/2X9o
         x5siGtLry3mC0fB5MI9fUYD51an4quiAKIjmFZhwciIAr8xkh02/AIo+n+1KuqUxGNqS
         IC65grQPp5/xjdRqaljD/jSjEMMiUnyX51X3I+vlupb/LvD/iry+x4j/u6I62txa3iU3
         7nIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703504; x=1735308304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uiZu4PFPvH48mQr0f3oDLOK2l1HAKc13nLmzWRle8w=;
        b=HxsNI1PMqLSC2VBy24W5mntHCdyJTEUCCEeKnrJyhFybjJsKDqLMyHoKutDZmKUKUn
         ysE8LaL2aEA5stfJNMgSWgUJW0QlU6WL6PBI0/cdEfbvmB/mjg3Cu7qy2O2ArwvqJdiA
         0B45AeWKHKQSsVUTXN92APx+1vfb03BDOqxqqLl33OXGt8lbbn15tVUCSP7A/ey2KmIa
         cGvU3dWCE05JZQuK/Gd6GyIConT+JbrDJvzCrL64QqNWopdsQgfazP3f/QczizXwdbvR
         JaKbVbw2xoBe/Qso0bHv/V8anZC7ATiY9RCU6n3J9KZz3Q4KyTauV55GvAX2BQPIiJ4P
         RpcA==
X-Gm-Message-State: AOJu0YzHXp8pcrW4+H5HKHECpriU0xtv18c+UjUP5Gt1uSyxZ9qcTjey
	Dw6XFWfT4ccMo05XArKBy4ZoW80oJ+wJ+IbgQLqSA4fiBg75RD2mTySchQJ4casPyfKK2vOwzOY
	Fbt8=
X-Gm-Gg: ASbGncs1ISP4AKx1LfaU4gKWgW27NLz71sIDmM7jpSfGYHtgCJte/xFGjmjactqCmrz
	oif+LrhJnaPrSzvsxjgql1QBwpJkRqngU50ljEbiSTfkdAGOetpnbZECHlODuscQIwUDunMHQ/0
	MACmoZM+mlwsO7Ahr2af+JHJz/H0o7c7Q1gPUNwtff83RKIuUjEgUPGGmlH8MwY4qCy2CDemU31
	+G0pTRIbkTWn8aL5uBfdjPXFXoC/bw76I+gGUk3eZQLGJlyiLV0KVKQIprAIJbkZ0x+kzbw7rUS
	6iDDLwzVbewZgmsyfSeL9juMfA==
X-Google-Smtp-Source: AGHT+IFjj499SxTkfJGIKb39yWOBIUPDmvneuET3NuIGVXOcO0JbNt6S9ZbFG9Xb11AqA2Z6vYfIvQ==
X-Received: by 2002:a2e:be21:0:b0:300:1a4f:4619 with SMTP id 38308e7fff4ca-30469acd023mr10454771fa.1.1734703503569;
        Fri, 20 Dec 2024 06:05:03 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:01 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 01/18] kas-security-base.yml: replace debug-tweaks
Date: Fri, 20 Dec 2024 16:04:24 +0200
Message-ID: <20241220140441.271395-2-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:05:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/940

debug-tweaks is now removed from oe-core and the config changes
need to be explicitly enabled. allow-empty-password,
empty-root-password and allow-root-login are needed for testing
over ssh with testimage.bbclass.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 kas/kas-security-base.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
index fa7915c..517d087 100644
--- a/kas/kas-security-base.yml
+++ b/kas/kas-security-base.yml
@@ -43,7 +43,7 @@ local_conf_header:
     BB_TASK_IONICE_LEVEL = '2.7'
     BB_TASK_IONICE_LEVEL_task-testimage = '2.1'
     TEST_QEMUBOOT_TIMEOUT = "1500"
-    EXTRA_IMAGE_FEATURES ?= "debug-tweaks"
+    EXTRA_IMAGE_FEATURES += "allow-empty-password empty-root-password allow-root-login"
     PACKAGE_CLASSES = "package_ipk"
 
     DISTRO_FEATURES:append = " security pam apparmor smack ima tpm tpm2"
-- 
2.43.0


