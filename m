Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6108C52CD8
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:15 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web11.32093.1721898128597054026
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=EQMUejKp;
 spf=pass (domain: linaro.org, ip: 209.85.167.44, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efc89dbedso680007e87.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898127; x=1722502927; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKgmqCG89tJRgcgBtjwK68BBJ2om/yNVQQvXJO8zTiY=;
        b=EQMUejKp5FdPuuhdfk6uQQhOoQnQ8ky+IU/f7bIZCkUcNSSYNWrIS4JSiWwW2ecNhe
         Sg+olJaTP6rBO0nE9cuN7Nmq8zu1KLwrtKJqNgpLoS01bmaR6si6z0D+rg7qXNN7C52i
         rDanSeBAklMW8rTd6l0OKoiiOcgJCvdsBqHYDA/Bg5VKVCSnNmSFAv+kklF1PcAMC20P
         OJMlNlo37iNLjRSFC4QOCP2UR5Jr2UsfD3bUU9qNDHiwRIIte/eQW+OntSX7qAHf4UXq
         5oKkNA8EVnG04QFbgFaXI5/t02t/zDcHvEzu54sI6JWZJaGtw+Q7O/6JMZ3XJX2sUkpO
         TiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898127; x=1722502927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKgmqCG89tJRgcgBtjwK68BBJ2om/yNVQQvXJO8zTiY=;
        b=BlYk2eHJkbrLqx2v6JTqWXKpms6gVV1LoJ8ZT3ooLjrl/hM/bBMogd8szS3oHDTbwF
         UJep14trFEK4zUF4Gdo2qiqIDeK9Jxl8DBnET3vC//L7FKgvUDIlcGdpB481BrU7j/Ii
         qWc6pnVQSfzJHIure/iFoISeW45o208Fc5JQRW6/7rG1+ANohAksdpOoaraOq+94reAj
         O8iLTj4c0iwFvk+3J9btWQ09PgF9K2afKxPmOuSlp4REGseJ/hYGXTD9p8krqxznJoVr
         sz1T7LzxZ4dn3xx7/uq6i4JmC3GN+SVaRCqFNjDz1bqeNgIWHn70n5I2gqxMrA0AwHYu
         SBSA==
X-Gm-Message-State: AOJu0YzkNLe3BzhnSGYQMjoDtxAQ+ecvScQ253F84HhRT414qPfTadRb
	HNWnxIV+wjWHTRjX7h9gMyQlg0awOagtLw+wW45RAW6KvPCr19uKkSiKd/sm3iqtkyeNWY3sb3d
	L
X-Google-Smtp-Source: AGHT+IHURBIeZmNClQNfEGH44M6dj/qarsYO3f6j4AZgHCLwf7/rcok4ROKKWTKQ6KgfO8vjtYx9dg==
X-Received: by 2002:a05:6512:2c0b:b0:52e:7a8c:35a0 with SMTP id 2adb3069b0e04-52fd608773fmr852358e87.7.1721898126727;
        Thu, 25 Jul 2024 02:02:06 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:06 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 05/17] ima-policy-appraise-all: UNPACKDIR fix
Date: Thu, 25 Jul 2024 12:01:19 +0300
Message-ID: <20240725090131.75860-5-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/462

New poky uses UNPACKDIR instead of WORKDIR

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-integrity/recipes-security/ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb b/meta-integrity/recipes-security/ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb
index 5f2244e..88b3698 100644
--- a/meta-integrity/recipes-security/ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb
+++ b/meta-integrity/recipes-security/ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb
@@ -9,7 +9,7 @@ REQUIRED_DISTRO_FEATURES = "ima"
 
 do_install () {
     install -d ${D}/${sysconfdir}/ima
-    install ${WORKDIR}/ima_policy_appraise_all ${D}/${sysconfdir}/ima/ima-policy
+    install ${UNPACKDIR}/ima_policy_appraise_all ${D}/${sysconfdir}/ima/ima-policy
 }
 
 FILES:${PN} = "${sysconfdir}/ima"
-- 
2.34.1


