Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0CCC52CD9
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:15 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.32010.1721898130158223775
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ajQl6zWq;
 spf=pass (domain: linaro.org, ip: 209.85.167.45, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f008aa351so786439e87.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898128; x=1722502928; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIJaUGyfa1fpHiHnxYmwvhSsmDJ5zijjd+J5huiOmNI=;
        b=ajQl6zWqwV5fag50FmGmd6aUqd2ViVEppX2ZY0dA1uOBFA9DwmWSzoaCbMgI/XIaIU
         A5bvWN8b/q7rfr5mtjuy+02lL361Xc1AiPf5e7AwmXzgiUzZl3NoVoSukTf8sDIVhDR2
         OR+p17GWR18B1k/rDsHnFVGPWd26IWEPI1t2FP/r7XPnLDxQkh/v6PN3sb5u4KvQVQjN
         B98zjf+ZsKRjFU8oqH+yvf7IBoqGR70WeAniXzWeCFHWe9DUAqfN0QDfX1WQljeEx3kI
         AeDe7L/I9sqwmN4vZigGKWiXQicJnIHpCzuVOB1kU2ibQmfZrx7bU/ELRPoBywGUC7aK
         BWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898128; x=1722502928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIJaUGyfa1fpHiHnxYmwvhSsmDJ5zijjd+J5huiOmNI=;
        b=mKO72e9W7IugZHtajsh8Aq5OxcVpQBM6ZGUeJoV+cTN0bUyN28NAVNPRHJ9Xcq/R3N
         qyylttlAWI0ipt6TahF/Nce0ZEo14alE4G7XDFx1WqaGYxIcbHxuacJkg1x5ep3TXtgP
         7kDL9+cqdB0fAXbyq4qjsCCSEXf4/EYRE0CCPY24iPPfp2+0a5aghGdaUe5bPKW5jpBh
         yb0Z8BwaeS7qHRfpILRgTjbTdOJtbBvr9tZJEa8gX2Fr8n8QewQb0+XyWHPwuh8Ay95o
         vCh172p3sDqZKTv+ZBT5MxuXSSK/QzQHvbeei73jRsEy7qJNYcB469Jn24lUwnlo1O6e
         mkiA==
X-Gm-Message-State: AOJu0YwX6grclSrwyFQX9BrDS8EvDTGV/199/gp5vgHhZGvgD3W+3yql
	JFD4gG9o6nIpRYzfLryf/+TGOBbOIOfi26kqZHG5JWRXr2V/5dJSQd3mHB/71PkhU+WeOa+cZsY
	x
X-Google-Smtp-Source: AGHT+IFaRD6Gf0cVXorep1p68gSUFIlN9UKiwSka0orG9RkLbQB1x6yX/OhD2AnoidYsx4h33LhlZQ==
X-Received: by 2002:a05:6512:31ca:b0:52c:dba6:b4cb with SMTP id 2adb3069b0e04-52fd602a88bmr1097239e87.13.1721898128327;
        Thu, 25 Jul 2024 02:02:08 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:07 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 06/17] ima-policy-simple: UNPACKDIR fix
Date: Thu, 25 Jul 2024 12:01:20 +0300
Message-ID: <20240725090131.75860-6-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/463

New poky uses UNPACKDIR instead of WORKDIR

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-integrity/recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb b/meta-integrity/recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb
index 8fed410..69aec47 100644
--- a/meta-integrity/recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb
+++ b/meta-integrity/recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb
@@ -9,7 +9,7 @@ REQUIRED_DISTRO_FEATURES = "ima"
 
 do_install () {
     install -d ${D}/${sysconfdir}/ima
-    install ${WORKDIR}/ima_policy_simple ${D}/${sysconfdir}/ima/ima-policy
+    install ${UNPACKDIR}/ima_policy_simple ${D}/${sysconfdir}/ima/ima-policy
 }
 
 FILES:${PN} = "${sysconfdir}/ima"
-- 
2.34.1


