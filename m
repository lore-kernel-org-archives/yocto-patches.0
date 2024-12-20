Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11AAE77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:06:12 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web10.152512.1734703562899909321
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:06:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Ty7CoS+S;
 spf=pass (domain: linaro.org, ip: 209.85.208.176, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso23495651fa.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703561; x=1735308361; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb7G9iZiTHAr4zn5n25Pn+xXlUfYOsF4AMeFlgSF9Mk=;
        b=Ty7CoS+StABaZ9laqqCdfkpUZf5YIsKabaOUZQ6C1Takqy1HZgxp66/d24LjOsfMSW
         rHWJXDJO02Ivs1oaD2AbhCNbr0lUgHBs12v+ykwtdedTZeaPTdtXpvtJZc2aB6B7joTX
         NYQK/XmxuDIeEGQogQgpLC3bANj1bQI+3rN/8f+4mWtcfOHh0tj7bLRduPcNKyJmtcG1
         /Xp+oRrV8EUHxQIsdXgCAYHCA7INe0ByiaIvtqBKhTbncbaCz9UZDNLcw6zC2bRmkTuS
         VPwLYxNySZ0kuV3UpPGiRH9N4Kel7R1oWaNQ4tM8RHvJTpBHPNrToFuRaBfgk2561JpB
         /w8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703561; x=1735308361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb7G9iZiTHAr4zn5n25Pn+xXlUfYOsF4AMeFlgSF9Mk=;
        b=Sz2pWnx0amPcDWRvtcNgXL/IvgLOauQVLldeiz+8m7Lo3SaLI+bBRvrEVMX3JtKJb1
         fV7ip/ZhutAO6Y9UB8uKkSO7oSuOVZ8SfZovASeAg2av4y1N89pk45v3DbHk8hD1Bdr1
         2e8V++OKnIll7f0g7gI9C3UbVYZwZWDOQKlWbMKNAqLF/4vZa7WOrTS5KlDtQ1O1/Vib
         OOXBJ7uXWVloW/MgHIKp9gdrG8hjx8DJaljjbt8lAQO3ENfHQAlkq01r4LodxrLwGxGS
         TGjSkVyFVcJAzOWhL0OrZT2xqGiuPlQKgoDA4IXKnJ/q5OAB3nEDscZI4wsIiX9JS7C7
         8iKQ==
X-Gm-Message-State: AOJu0YzgQreEpLNmblRIn9bIKVACxJQ48o5M5kG8FUcFQ9YdKPBOh5Bj
	oR0mFAEQDlBsHqshpw4mkn6qGlgiAXkUxgEXIkZ1Bh0PLLrXMFCbSlp4L6u5WoHweYM8186mA9Z
	Iq7Q=
X-Gm-Gg: ASbGnct68jRpo1LOZFY4WyIFPgsfcBEVqGQnAh+TvD41BADrOwjQ4mgXHnxcPjjhJvR
	XXK7s6bgdDu3cL5iM5WyW2XOu4WTw7aXb99fTt8jwnzgMNVfGtGWpfGAtg+BGVPmo7MLBHBxhlY
	GGjPDoQv2BwEeYXWqAVE374a7JRAe8/8ZSBS9WYB9u2BewwboT7I8xxFjJfM6kn8hdjmtnRz4JC
	yRy2jKHwO2oHrXEeUOL+0fsYtjRTsGJGa2OVrP7LKZwT5bDzncPDhDEntXOICwBmml9xsSffCDv
	bD6Bd+ghPUDPNNvuDBWGm97jwA==
X-Google-Smtp-Source: AGHT+IF80BlPKuXXQH98iB8FIDP+gpJTIjXIFi77SFmxpOkHn8gotZfbReV+JdLWRLfTR/dMudXHDA==
X-Received: by 2002:a05:651c:555:b0:300:330d:a5c4 with SMTP id 38308e7fff4ca-30468570ae5mr10374321fa.10.1734703561063;
        Fri, 20 Dec 2024 06:06:01 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:59 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 16/18] ecryptfs-utils: depend on ecryptfs kernel module
Date: Fri, 20 Dec 2024 16:04:39 +0200
Message-ID: <20241220140441.271395-17-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:06:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/955

ecryptfs-utils userspace daemon fails to start if kernel
module is not available on target.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb b/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb
index 83d37d6..83246a2 100644
--- a/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb
+++ b/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb
@@ -69,4 +69,7 @@ do_install:append() {
 FILES:${PN} += "${base_libdir}/security/* ${base_libdir}/ecryptfs/*"
 
 RDEPENDS:${PN} += "cryptsetup"
-RRECOMMENDS:${PN} = "gettext-runtime"
+RRECOMMENDS:${PN} = " \
+    gettext-runtime \
+    kernel-module-ecryptfs \
+"
-- 
2.43.0


