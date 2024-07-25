Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF121C3DA7E
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:25 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web10.32016.1721898142646548470
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ih3rI8DZ;
 spf=pass (domain: linaro.org, ip: 209.85.167.43, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efd530a4eso860680e87.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898141; x=1722502941; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVpxc1Na7ceBr+tLL98oBdSCpXM6/E0sOjfSBevQjek=;
        b=ih3rI8DZ6i4MNpj8R2t9QmGKbjo3tf8v9TrGmjBQjfVUFzbEq9taKOn30QX9Xmqaoq
         sunsboEc52x/yGMNtPJRhym95XQepSxnwSXOIECrnO5wuT4L9EGsrxuxvnD7KBtK+oSm
         IXhxpY+Q6qfbaON87BQRXCh6Q/b/x4AlbTjAlaW5SEcb1LLlliURKYYZsZ55/a5Sb68z
         Lunjkr166b2t+Oy/pVGgjtQ4qlzRMDSoEJWODloFQ8LFro7giIYBSq7RDZXe/7UHdyGF
         WBo81TH2BGxqDc6FMOGqlJntQUozOkxgiUKi0SMBakXtlGw2U+UhZ1kLJcnSRJsk9EQ1
         wSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898141; x=1722502941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVpxc1Na7ceBr+tLL98oBdSCpXM6/E0sOjfSBevQjek=;
        b=V4mPcoMmzDWaGrhIK62FyHKlLZaJuWgVo2CrUakrc/bNcOMiDbb4P6F8rw3lqi7aqg
         3LjNgNJ/Nl6Om5gPCpung9qu2aI5UqkPgj7U3h4/3PrD8jBZWWvx4ntchu868JPUS1qk
         cbz9V1gY0YsHII6WYQY6PovcnLXkL/9zgqP9IHmJACUbp2jOeDpyO6rJVybLDkEc+9FY
         Kwc6+RA5Fd3GaFORcBORocJkj6rqUwptRuWkpJF7BOK6v+nbi+18UJ7uDOaxCGsB7+/P
         +zT2mnc6Uit2an4MkysiIV+pxp0ZhUxMypUG8K7QIWK56SNIvbkXOD1OB3dgEc+vFqmn
         9UmA==
X-Gm-Message-State: AOJu0Yxe+e4UFENzZMDzwaqYgHO1fEDbNqwoh1exz7DJeZFPEIg+wjoO
	xLDqJtlYzYUa+VYIOF5b6/g1KyOhYI3H7SNv2kzkQL+SkPQIyqEneZ8WOZoBynuJC7CwZ5FbUPt
	q
X-Google-Smtp-Source: AGHT+IG8phJ6oiNtMRxQy9D8OWwe7DoVqcOFXEfxkGWEGHA267IytA3m/P2yhjbkhmwB8+s3xfZyZQ==
X-Received: by 2002:ac2:4c4b:0:b0:52c:c5c4:43d4 with SMTP id 2adb3069b0e04-52fd60fafcbmr1046607e87.53.1721898140899;
        Thu, 25 Jul 2024 02:02:20 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:20 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 14/17] ima-policy-hashed: set S
Date: Thu, 25 Jul 2024 12:01:28 +0300
Message-ID: <20240725090131.75860-14-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/471

Build with latest poky fails without

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../recipes-security/ima_policy_hashed/ima-policy-hashed_1.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-integrity/recipes-security/ima_policy_hashed/ima-policy-hashed_1.0.bb b/meta-integrity/recipes-security/ima_policy_hashed/ima-policy-hashed_1.0.bb
index 8c670e8..3de7497 100644
--- a/meta-integrity/recipes-security/ima_policy_hashed/ima-policy-hashed_1.0.bb
+++ b/meta-integrity/recipes-security/ima_policy_hashed/ima-policy-hashed_1.0.bb
@@ -6,6 +6,8 @@ SRC_URI = " \
     file://ima_policy_hashed \
 "
 
+S = "${WORKDIR}/${BP}"
+
 inherit features_check
 REQUIRED_DISTRO_FEATURES = "ima"
 
-- 
2.34.1


