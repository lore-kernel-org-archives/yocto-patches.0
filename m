Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E122AE7718B
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:05:32 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web11.152226.1734703530639250676
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Jgnw/HW3;
 spf=pass (domain: linaro.org, ip: 209.85.208.171, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30037784fceso20981371fa.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703529; x=1735308329; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNqEtZyT1ox+hsb6Vl+V/jd2CTYis0cs598tVwv8nHc=;
        b=Jgnw/HW3aPc+psWMA+YJdkw2YWXwE3c6Wopay8+nz4o2GjYe7Fv4DMzn1xUTpkkXec
         cf0T4V9a3XbUTY3QHk8koBZElcvuq7SS6qTYIkGS0m/aF0O6seQtiifnPq0/fUmPICYP
         pJYElo2RJl2qfoN1Pbb5mKaVtL2mWUjQ/fSTlVyVt4bjFSSDoMGhvVoO4fxJAxRU67tJ
         rYrtisRAQ3VM9g85rsoLWka5MAmfvmawyavs9BR1bkIKPJ78JVxuEJc/gx5uCaG64ahq
         W9nhSwYdaxWwdsvZXz4TYKnTklmB8PCUoAULNr1No8L1zYD5WqY8rrwnrNlf/BWjSFcR
         cPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703529; x=1735308329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNqEtZyT1ox+hsb6Vl+V/jd2CTYis0cs598tVwv8nHc=;
        b=hbJUjXTVy8N06VdXQQQ0lsIY2+X+IQX7j3u2+85NnUlBFPlcBS49vTKsCniRlwnMoQ
         S60JPzcoZ2qA9x3/+nHkdfgUqKPogSdYNb8Z+0PeUBQN4UYVIBVihL6So6Lee89mAy3Y
         6di6wZeroRp+RvsBTSPQLA71wLQQ3wluM26nUN+IImDkmwEjSc/UM0WoMoTBBEySKFAs
         E0DHsi6dbgQPOwmkiNabvCaHaf6/QbC6KrXy9OIMb8lxPf646lDXLMj6nZ99eW4NiJSE
         s0Nh2psKezOymqocZnoC3bYl1dk6UWjvKQKB1p5i+0t6M2lxhtvokvSl25uD3En6uabs
         GvnQ==
X-Gm-Message-State: AOJu0YzkeXL/Wf80y+Wu4Q40e1Nz3RSq98qs+mVrfVLqsbjzdSSvLzce
	XpslcQZWN+Y0/iacuS3xH2WGk2qVpWXYGR8cej2RoXFjep6mO1zBy/Du2D4vPBVftAq9hbizXCT
	KKhI=
X-Gm-Gg: ASbGncsVuu5fBzhgJksrsXEVpluZzGSjBSzQhcdxeFZzObpKCNit1eSXUT5ODstpvbR
	83+qm+lBlhgm9ROWTzY8suOv4D61C3mwM4m7Zomwnxk3mwwEZVHndoBJ921HDpPI4hkV7n88Anw
	OWjpL6BMPwIQy8etISb24J8UDUllgTqTCmmgD3WbyW9htXTAvo4wX92se99V8B5y9TVYwmTO2q2
	gLoK7x8jLFSv0r+b2AATW8sdssi+idVMzVsjW0DpmdoAzBFTrHyVNrxxJVKV0AVg3GbCD5Kb97Z
	nrESv7ZseXOCDmALX8U6saQpQA==
X-Google-Smtp-Source: AGHT+IG3AH40pFjDUuVQN0nbKjlcfKGfjzHtdCXZB1JKVmIauxecGmGCyj2Argpek24pPUCzpp+slw==
X-Received: by 2002:a2e:a71f:0:b0:300:3a15:8f19 with SMTP id 38308e7fff4ca-3046860bb6bmr9721051fa.32.1734703528684;
        Fri, 20 Dec 2024 06:05:28 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:26 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 08/18] libtpms: set CVE_PRODUCT
Date: Fri, 20 Dec 2024 16:04:31 +0200
Message-ID: <20241220140441.271395-9-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:05:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/947

Using vendor "libtpms_project" and product "libtpms"
as in https://nvd.nist.gov/vuln/detail/CVE-2021-3446

Matches CVEs better when analyzing with cve_check.bbclass.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb b/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
index a2c3a14..55a4c01 100644
--- a/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
@@ -14,3 +14,5 @@ PACKAGECONFIG ?= "openssl"
 PACKAGECONFIG[openssl] = "--with-openssl, --without-openssl, openssl"
 
 BBCLASSEXTEND = "native nativesdk"
+
+CVE_PRODUCT = "libtpms_project:libtpms"
-- 
2.43.0


