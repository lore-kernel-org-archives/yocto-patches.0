Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E781BE77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:06:02 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web11.152236.1734703554196187645
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=dTVibGT7;
 spf=pass (domain: linaro.org, ip: 209.85.208.181, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3003c82c95cso15253961fa.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703552; x=1735308352; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPnHBSb/jE9OeRGrpgCugm74i+lSzal/70nGBjmu3Hk=;
        b=dTVibGT7mGzE1raKmuUqOpeZHHdC2bD8KS59roS4lN0Nfv2VaeyEw4SlduC8HfqxIk
         +mDKTLad1Hi2fibFLJXox/ti2WNyagZmjW6OkuIHBGwn2qhSQCh+5Wz7MkPeBIvlsO8g
         QARoqIcaYdfSvyDXA2z33+a877Uncopm5mAgAW8EEixemRXUBuuu96zJ5a4uKyEar3v+
         tSNnbiuZ3hxdJHClChAk9LxM0uue+b9NbBUtpVcstR1IOWd1UggB55g94q+tPzMCmnPs
         LuM2nAfDXl7FuxK8Ujypz9JcE26fr9eBMNwlH7HprAcDFJZQTsb5TkPjXIIOhvASYVte
         llCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703552; x=1735308352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPnHBSb/jE9OeRGrpgCugm74i+lSzal/70nGBjmu3Hk=;
        b=XvARKgf24iGLzGWDwlw0OnbblvChsOGkLx4D50TFnVnsgxdBSndIrOB/+rk0GZ7IPa
         yd062TaFLgdqXkuQYvfXUtLS4gfuqte2HkB5YzLocdNIG30gGDDqdSo81HmbH/DM4dxe
         yPDanw5MuHAXy/8H23QNUIfrl+KrscVLSmrG238c06I+FmeffymfuTOUqQ/OHSqtQ/5b
         UZ8EhtVp+f4/xFUlr4jhOA1xzw/Ra/t2a/dMLoWTr23d3Vkmj9bewjYca2saOXwQQeCt
         F1hPb/pRAS29xoFlS8USzdsNaVQW4gN1UdPmVnssYXIQlbOli60TRTiUpO1rTUKyVMei
         JufA==
X-Gm-Message-State: AOJu0Yy5WGb5F4An6uUa60gq2bZ3ueuh8cqB8lpvgFRJciy74BMASATG
	qseVXBci+OW6ANkP7+142Q+dOqBrsUH8rt7w/GqNXzkoCdEp1R0iTwfrKq0luj9pEE35leYhWCY
	IDEk=
X-Gm-Gg: ASbGncvj5ebDNMvMnneE7ILSxHUGwJnlFkhhWNd0m9xo8j5tQdL2VVCKoRrE93jzn14
	ohOnf6jLIGKBOIqutiSEj5yD+IwlZf7OF8oWsXfU46Lb+xZ1yhiHQhOsAll9oZEt+T4xvYm6iaT
	TiNm3FWOHCMRAQdlrH8b+3lJxZexvqlvUQk3sbzBfNy8E4uNPnB3wXeZ54AnLL2u8g0H+duECiq
	WjP9zTmy3Kz5BglGUZE/Xw3jGPUCeb9oRxhdKog+Pxxk4pyyrAuDGYqXeEIuY4SdYudYOcyeGIX
	/Y7RJGMwqC5x79YTLqtepd+ugA==
X-Google-Smtp-Source: AGHT+IHuKHwQB5HLgzFIuMnDQqhBlrSY+xMusqgnmnpddXZXThfgqFJYPuDzVw9m5eH9dNOJ2Fqseg==
X-Received: by 2002:a2e:be94:0:b0:300:32a3:a322 with SMTP id 38308e7fff4ca-3046860cef5mr10668671fa.32.1734703552290;
        Fri, 20 Dec 2024 06:05:52 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:50 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 13/18] systemd-boot: enable TPM support via "tpm2" in DISTRO_FEATURES
Date: Fri, 20 Dec 2024 16:04:36 +0200
Message-ID: <20241220140441.271395-14-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:06:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/952

systemd-boot will then measure boot components to TPM device.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend

diff --git a/meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend b/meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend
new file mode 100644
index 0000000..712a764
--- /dev/null
+++ b/meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend
@@ -0,0 +1,7 @@
+DEPENDS += "\
+    ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'tpm2-tss libtss2 libtss2-tcti-device', '', d)} \
+"
+
+EXTRA_OEMESON:append= "\
+    ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', '-Dtpm2=true', '', d)} \
+"
-- 
2.43.0


