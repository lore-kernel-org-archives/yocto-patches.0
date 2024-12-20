Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA472E77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:05:42 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web11.152232.1734703541874283550
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=VhVlz2+H;
 spf=pass (domain: linaro.org, ip: 209.85.208.182, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3043e84c687so16944351fa.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703540; x=1735308340; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3UCKYIMGhv5ah0DLq70qiLLXth1Pu0Gfaxii1och8w=;
        b=VhVlz2+HqQMh3oz8hBbes5v5FvJIuIkNN4nTTpd1e6jXrpPnZYy6wZnUAXXITl8ArD
         Nbr6BHWMeqKcJhU9JWHuAfDV4yvxbzCtakRsO2pfRv8/bmBgpct8NTFeun2NJo3h1RSg
         ecBP/KFX1+9DrvfcJ3LYcQtxvFZtBk6Hek8f0wDH5NeqfS9+ZH1iJAhTxZ1JD/gHZHZY
         hBmXoYdjwlynxVpYheOPdWNZIN/a6bldvZG7CAZt8C0DU7R+yomp712azgZTsVT8Ai1b
         VzJJpQepAE9OXg+S6cqJpeAyTeEMT018o2ScPAYzMMwAL1B1asOvD29DpEQQ+y4c/Cva
         DZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703540; x=1735308340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3UCKYIMGhv5ah0DLq70qiLLXth1Pu0Gfaxii1och8w=;
        b=e9JoYfYj/BMwa4wwCmrC2Esc7Jz5xgNfYHbOggRMxoCSO8qBn3WT9UVxfVlf6PwPyI
         6C6cRKsrHXRu6FdxKxEQ+TNZWs9nN7yVQ8qTJ29f8Ic9OXAsMhUUJul7+FjgN2wJZANj
         HYqB+mOVXV4p/mtwWPYHCRMz8AAmc42Wu+Y1XCRxnUwqv7366+wqFCLYpXks2zSwuefm
         OhwvM/u8ul91JYdj7x0SBF5oHXEC7Obv079N/f+XlihZyoY70WV+3m1HJqmLtLRI4/OI
         JLQeV70erTtwBU3TS2JCTbX3TbsjvWyCrdMoXQjA8EvnFRsNrkafDEB7/z+v6IlOcTk1
         fbxQ==
X-Gm-Message-State: AOJu0Yy1ePiMWx8hBFeHoURRuiL6SQyS7uS3gSN3Pklt0jErnpcfQlmj
	bKlgderYaHLKcbKHOzFSdMscbqhYGpePq+d6Ej9JQvn3QyFADmPogyjF24nR07lTGwPLxhR/a9x
	hmNs=
X-Gm-Gg: ASbGnctISpwEqFRqissdcoLyQRc3k1t6dBnbfZ8rIZAa/FNwZEwMlalVQZmwAZq1GRH
	b2RQaQpL7G49VSiatdtJ6zd2XupX9WNGP4XymhZt6uMqk149mIJ+cXC9PZ2twOLmx3h17TjbVjh
	u6EvpSvX6XRWHLyMr0Rq/Y28P4UJtlB8OzZ0GYH4H43M85deMIgWRpOwklxx7L6VcV9yWIZs0o9
	QZp6YGz1MRVFLy2IgriAo8Amb46QYFLFZM9XF34loef3j1GGcXS7pgaBZhvymsWzoXU3d72I6mC
	no1k2xBVu3yRp1RiVJCP48KXJQ==
X-Google-Smtp-Source: AGHT+IE7mgc4EmTgWk/RRg0FvaTwyrjX9x1CSf6GDrgJiotSeUZJomSakoWgbqvHSmy2U7Hhr8hP6g==
X-Received: by 2002:a05:651c:4007:b0:2ff:d7cf:a6cb with SMTP id 38308e7fff4ca-304685506f3mr8961611fa.11.1734703539947;
        Fri, 20 Dec 2024 06:05:39 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:38 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 11/18] u-boot: enable TPM support via "tpm2" in MACHINE_FEATURES
Date: Fri, 20 Dec 2024 16:04:34 +0200
Message-ID: <20241220140441.271395-12-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:05:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/950

"tpm2" is used elsewhere in distro and machine featues to
enable TPM device support.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend b/meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend
index c5d2923..d1d61f8 100644
--- a/meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -1,3 +1,3 @@
 FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
 
-SRC_URI += "${@bb.utils.contains("MACHINE_FEATURES", "measured-boot", "file://measured-boot.cfg", "", d)}"
\ No newline at end of file
+SRC_URI += "${@bb.utils.contains("MACHINE_FEATURES", "tpm2", "file://measured-boot.cfg", "", d)}"
-- 
2.43.0


