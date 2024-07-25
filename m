Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0243AC3DA49
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:36 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.32099.1721898145800412586
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=tW2FtppP;
 spf=pass (domain: linaro.org, ip: 209.85.167.46, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52fc14d6689so639736e87.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898144; x=1722502944; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHqixL2xpqeYqiA4vj3qEHMj/p5fVBNm7e3jPrpUjWA=;
        b=tW2FtppPFAjlv9DfC7aUV+K5ESNp3OhzJkpZ1hTRTj5bXoSFdgErhfyyMmYNUEGBGl
         gajkkFMNux3yWteMw7mbTCPduqhtSB0E7qPEoU6JsyCSagqxfdw64w0Ho/x5UyktnEPI
         hAJFtsvzuLTBuC62qIhMsp5iOhEIFhBhNDuRnjFO2Jx7b0sxkoirKIH6hTkviwedMqlK
         dsCavAltFoT0JysvBnasOk1jbcNLu1JnDB7CO0pxfAg+0XuaLoC55byE3gpGALRMx7iG
         J//If6oJ5g2RIplA26qfhkh2S6B7wXSj11PAkpma5yisLO/TgbRkmofOMJobvXrcW4Dz
         F41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898144; x=1722502944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHqixL2xpqeYqiA4vj3qEHMj/p5fVBNm7e3jPrpUjWA=;
        b=Y3MMhIKIq32SRmpRWDSbgzzkcLmKj4p0rt7NsJmCltDhf9//f7RjVbapDYzYqFhfuv
         jNDfEdZQMglVVpUL5hLxT0UGnr3ln7UELQNy7E+o6wZZTJ6yrINfVv6Gf20uMhtixXa/
         zhQhEeeBa8kvSK9/mAHreD88g/dmc2FY+EYXQSEZZT+thbSN6r3mk0zYPZeCfNuhXuIk
         5CdXCk1HoPKGFOkfbnXDAyM0dMr/cszDGv5bKZToje2lX9aa+SIFHt2hibWQO61mxdVo
         PFgtG1t+Q7X7n4S4SYDsEQeD5Lf1fP4WOqkcmCK3kPx+9b5x2tUtl7j7jX1SPnnNtKOv
         enLA==
X-Gm-Message-State: AOJu0Yyx4fKV3xdJP8Dnrz0qelr+lpoUDDpmMeXddCAKdf1O6fjyrS9X
	E7RzextUeGxTt6O9UdSWNOUoZb8a8qwRviRiH9gm0m6xVTTWpvj/3Qwzm1epgJ42P9AUtmkUuxr
	f
X-Google-Smtp-Source: AGHT+IFbYd7P16mPBLtIK2Dj4w+a5qEJ9J8Vhmk2J2Mzxj7r2HSl0yBZhsg1qIEmnPlkARGwWn3W/g==
X-Received: by 2002:a05:6512:3f02:b0:52c:d9b3:2b06 with SMTP id 2adb3069b0e04-52fd6098ce2mr917856e87.58.1721898144058;
        Thu, 25 Jul 2024 02:02:24 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:23 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 16/17] ima-policy-simple: set S
Date: Thu, 25 Jul 2024 12:01:30 +0300
Message-ID: <20240725090131.75860-16-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/473

Build with latest poky fails without it

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-integrity/recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb b/meta-integrity/recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb
index 69aec47..8b30858 100644
--- a/meta-integrity/recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb
+++ b/meta-integrity/recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb
@@ -4,6 +4,8 @@ LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384
 
 SRC_URI = " file://ima_policy_simple"
 
+S = "${WORKDIR}/${BP}"
+
 inherit features_check
 REQUIRED_DISTRO_FEATURES = "ima"
 
-- 
2.34.1


