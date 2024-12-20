Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D2BE7718D
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:06:03 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web10.152510.1734703558230291774
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=H28qLILS;
 spf=pass (domain: linaro.org, ip: 209.85.167.51, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e28cf55cdso1604937e87.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703556; x=1735308356; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h93M3TjQt6wRySILXqHDY0XbIDeFd3dYymV+ay8S/yI=;
        b=H28qLILSz8LrOQ4BrcfczAbf3mlojQy78IMMESsW3S+W/ozHu8DLXQR/1Q18ohPUgC
         iAjB39fDKA0Q9sgMBk+2BJYfszIIO2fmvWt7IVSHdMAN6Pgcz0RfZecL+c7g/3V1DqYh
         J4EUbcwk4PTWHlDRvrtKI//IbpUBZlg9KXytfgfRv/OTHOmAVZOTSG3d7PyFPajrHdWH
         UKZfDexbeqLTiGGdhc7CPI3k2yFXi81c4CUwrx2i3143oI19lKG544sgUMjxQTniYAeo
         E8UVjbYWcCNSs60TFnvxTNxAfzhQOq0OUNSIFnklrVzc92E6qjqwXCmOJnRstVDiEb6S
         0IKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703556; x=1735308356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h93M3TjQt6wRySILXqHDY0XbIDeFd3dYymV+ay8S/yI=;
        b=CRp+pNcvBRU6USkt9vhEFo06ZOxOqkyocNM1jJ7T7/ELb6UNLaMgNR6PWwQkCs+2Mg
         8CCGRameHKPbR/yT2u0+US6Yw5FmZDYVWHN1kOX3BnVk9wlTZXOywQobpF6BfIrXf5y+
         3WVf/Q969H/yZGTlK4kIKD/pXu7pPrHW6Fiph0riVs+Np4wGwwyMzpxB1fMkl3d6wgGE
         ceZbQPvntFWZIqxG1cpdV0GlBNqm2vpyX14Uxl1OSb5UAIUhn/ETBJgWH2ZggGSP5sQt
         Td+z9DjXG+I+YJsfqFAmWgPppcUDkRCZAbwcVKAVX+RsAg1QrtVOH/1p0HipbyxE+8/k
         GsAg==
X-Gm-Message-State: AOJu0YyMcVP8JsUG4OytqorwkUwbbF05x1/XNd8006/H5a3jc/OvvWLw
	ZK7SNgejU0i+BJ9y7nsIleSiMaeMokQaD0RvE/KPamwdgq9twDZ61Nit1pzr2PZXO0+KeRd1AmY
	VVoE=
X-Gm-Gg: ASbGncsnM7wmMX62nfCWFL7bisdI8kBDkfQMRBOINLuPTH2jCbjPYTxzb37kOJXiMr7
	+A/ACdFVyBIrvSE/GWBk1Jus277C/3VmM0+0BrDaCX4fIubfry3WVLUON7DtOScxcWxt6u/AcAB
	BBfv+NzqR6y3i/UFc7jlVamuX9SvdjL58YsAXimgxxLxxVC+1tmLIaqqE4bGWOtLzsbEPSaoNry
	iEQw9iFxwHnFL3QcPtqLyTSKw+u9ItKd7daBboKPCUwxSMIn9huLzeqWO6U5ax3z2RB+rS7zS98
	76B+/truZZcGHLIr8u7AO4XWLg==
X-Google-Smtp-Source: AGHT+IH0yrCD1UxdQJAHakichVVMT6NLL9lnGRL3UEeVe2T7sKoUlz5DrqhZ5GJLFly+Mh3HfO7GOA==
X-Received: by 2002:a05:6512:12d1:b0:540:263a:131f with SMTP id 2adb3069b0e04-5422957ae4bmr918244e87.50.1734703556351;
        Fri, 20 Dec 2024 06:05:56 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:54 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 14/18] harden.conf: exapand debug-tweaks
Date: Fri, 20 Dec 2024 16:04:37 +0200
Message-ID: <20241220140441.271395-15-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:06:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/953

debug-tweaks was replaced with allow-empty-password empty-root-password
and allow-root-login so remove them from build config.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 meta-hardening/conf/distro/harden.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-hardening/conf/distro/harden.conf b/meta-hardening/conf/distro/harden.conf
index 1a5eb3d..2553152 100644
--- a/meta-hardening/conf/distro/harden.conf
+++ b/meta-hardening/conf/distro/harden.conf
@@ -6,6 +6,6 @@ DISTRO_FEATURES = " acl xattr pci ext2 pam ipv4 ipv6 ipsec largefile usbhost"
 
 VIRTUAL-RUNTIME_base-utils-syslog ?= "rsyslog"
 IMAGE_ROOTFS_EXTRA_SPACE = "524288"
-EXTRA_IMAGE_FEATURES:remove = "debug-tweaks"
+EXTRA_IMAGE_FEATURES:remove = "allow-empty-password empty-root-password allow-root-login"
 
 DISABLE_ROOT ?= "True"
-- 
2.43.0


