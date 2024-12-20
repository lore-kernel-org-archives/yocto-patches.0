Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7489E7718B
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:05:12 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.152488.1734703508866771067
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=eD1+oIZ9;
 spf=pass (domain: linaro.org, ip: 209.85.208.181, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3003943288bso19703031fa.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703507; x=1735308307; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYwv8ve/8MfY19Xwxzi8Uh/HPriySj3YFp+eWvzJ2G8=;
        b=eD1+oIZ91C3etl7/so81Wok73ogY/ScejFZHvjoay5SwnqRCgstDp3u2gEfvsNxVgi
         DxuTxLhKtMBZPi1u24wae/xGrd+3yJN84NL6a4HJ5KshSnuwK7dwXaD4l8jRJeir9nI2
         wbvnHLyeLnSAOH1qFDkbqjtv1ETZ939EhQPwgmmZ0sR7jZOpx92Ga4AhOXkrE4KIhrBa
         +XE68oilT+GDHzst1sVRWgsDoi1IYjPGhnK9ZYj6zAjMFcg1f8A2WD+abgON+z0x6IKL
         dr22xpgZq33bOFCUPLnTuKfijrpxMwLVma/4qQRL7051QI/JQnhtKkomJ7eC0ar30ULw
         SjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703507; x=1735308307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYwv8ve/8MfY19Xwxzi8Uh/HPriySj3YFp+eWvzJ2G8=;
        b=SlIAsl99JEihY4lpXKta5NmDdPfbolPsEVd1LdcHdscZKKsL8DV5EpcltwgIGLcyyX
         8Fi1cNtag81jTetPgtRTTiRzAvHMX2e2pSF19neQvhMrkT6ZEvAhC1YBwM81Tpf9/6Lf
         w0D4o3lF7YiKz1pFmqiYyG28nn/NedZm4HQBduNuZwFSL13xDwXSdeDzyZjCY3XaYlXp
         SaCMxPEpu43YuvzFSxAS1cm0ofdqJecXcbOnWpsV3Sw+ouJsDYQmVi3BxRTbVt1c/1Ym
         uWHiRADDl/9p9l+9JGJvqDtZH1TDqmvIQytXIuBRryVigd0efdgRxKxWrKmAfu4gIy/X
         B90A==
X-Gm-Message-State: AOJu0YwfaRTqM+wEeJBC2DCIBnEY4fiWdNkMIRAGvwdRkVi6HyUDl7PI
	he8CBif1qI2FGTHqQkV65CbEdBqZAFdAbE6eD/LLkzKhvbd5B2z/OCVaCGvtYGdAnISEjWwRiwt
	3aNs=
X-Gm-Gg: ASbGncsMvT4QZJNu2cbnHxiYB1LjEGmYhtz8Nb5tYs5fVHC5mrkxDZy3OIZeqdNXvqi
	taxRM7UiF8PyFqO77ff5XXeR0j3r4uvgi2EHGUeyO7QSuK43CSrPFetAR+dpgqGNeHdfkfU5anY
	YYxXG4+8RsVnXMhZrpuvsMCqoN9FVimvL98jnXKP8dZZZdcMBVe1beHkr0xmgzYCG8FN7OHTQRm
	0UYqv/2v9gyYqG/5XM/8pCeoq/iRQXDR7Gxm4spO8RB5650QDJNpfG6ONVYs/9pChM5tcveUB99
	zoPDtmmLks4KN9B3VhgqPe7mAg==
X-Google-Smtp-Source: AGHT+IG2RIGL9z78TcZaDvfe71Hsdf0YCHg7UnD27XCwmA5NbfHg51yC1QG8nsOmp/HXYYYEigCR5Q==
X-Received: by 2002:a2e:b8c3:0:b0:2ff:cb47:3c77 with SMTP id 38308e7fff4ca-30468605037mr12544131fa.26.1734703506867;
        Fri, 20 Dec 2024 06:05:06 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:04 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 02/18] kas-security-alt.yml: fix systemd config
Date: Fri, 20 Dec 2024 16:04:25 +0200
Message-ID: <20241220140441.271395-3-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:05:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/941

Adding "systemd" to DISTRO_FEATURES does not work anymore
and build failes due to udev selection etc issues.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 kas/kas-security-alt.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas/kas-security-alt.yml b/kas/kas-security-alt.yml
index 3ee9808..8f754ac 100644
--- a/kas/kas-security-alt.yml
+++ b/kas/kas-security-alt.yml
@@ -5,4 +5,4 @@ header:
 
 local_conf_header:
   alt: |
-      DISTRO_FEATURES:append = " systemd"
+      INIT_MANAGER = "systemd"
-- 
2.43.0


