Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1C4CD98DB
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 20:14:23 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2265.1763064857540171282
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 12:14:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lzO2f5e+;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88246676008so14814836d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763064856; x=1763669656; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+3aMVFYRADRxw6dyw3C82D0woQDBhC3SzYr/qXH97Y=;
        b=lzO2f5e+8kedOGiS8rWrS7mHUONAgg2e7pFaY+qFxIm15tbycx8eSaoFCrD/KwVdOK
         36VG3nMKGaAunAHU+0mRHK6oLVq+m4UTpNbjHmuts27H62DEftoLU+TYjlxVbqVgAv8f
         fVvSZPdSmyR7XNpn6rrgbYy4uV7yYi36o0lSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064856; x=1763669656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0+3aMVFYRADRxw6dyw3C82D0woQDBhC3SzYr/qXH97Y=;
        b=aWHCiDxksUWCa9vo63LyX6wBqSl6JF1BKNHwKEMIfJnUiRhNGirzdssVy0av/ieTy2
         2RDw6VhbQQHwqPBgSCS6C+fbPylcQe/ryIzgiN6QZ5ow8SSwLwZLgN6fNC+/re5OuyyG
         aOZcJFc1PcntD/Kc9m/x/Qb3Hl38N0MTLt/Q+XfH2+ErFJJSSYWt3QjR1vT/sf5GcsZ5
         FXKUferEEkbHNYnWp1rGMO/kJYs317lRT9sgUMqd75Lnc7GKoKbZsFNOA+buYDTzwZtP
         6cyil18GXGCDznOtNT8iD6+dWrQCHZFawTg08hRV+bYpyoKdrlOCwrSCOjJB67GwsOp/
         8haQ==
X-Gm-Message-State: AOJu0Yyu3y8svJGGuXts2vdWVuOvgGtuiU0qhGAxR6mvFfm/VOcPUHSR
	QEgPKa21hmZRJj8hd6ytc3ebFIJgn1JYzOuWXSCXsQDv/xbuQTayByokPOWCDEn5vk4JNf6NtNg
	11jXw
X-Gm-Gg: ASbGnctk4Xc3KYdOAhgDWFQwmlZUrJq3DqbTKS7+U2jX0KqSDq7xwL/4XEy/TZqCwnq
	E7+yji0zbZyMLuzA2HjuBh2WNOX//UHvgRuYIT6rOb/3hwcC29wJG6GYpOAj5guELxZc4eWZDIY
	nx1vMj0TQkBgx4vDpI52EH/JlK7wAdCBKENu5Z4X4GXhxAZZFzMRLGYELK/gl2iFPFstb7YT6T9
	1RO/VVwhbnyVL/DDdSfBahbk3ehhXntT2HUInsUTqBg8SL/Q5oXQib9Y3UbE+h2yIrDMGm0SVpV
	up4Mfxu3ufbNWhKttnsnbloRvATstdBvGL6OF4dvawj1LANyhVrg8j1Dv5fbM39asSdHy6KK/a2
	OY8C0s2R1Gs9S66m6siW/rY/0AKgqPcBxTkxbogu6M5PG4eAzzw9cgkrCcYmccf/xk2vVXBnslw
	9roimV7ugDKhv1XBNBoL9VkdMAKfDO/Jz52zf58IVbrFSpiObNl+oO
X-Google-Smtp-Source: AGHT+IHa7ESCl34H7c172CUBdcbsf0tPxaguLQqWHamAPXw2LewPnm3cHWTBRe2u2klXhgrBWJ2JQQ==
X-Received: by 2002:a05:6214:5093:b0:880:541c:8243 with SMTP id 6a1803df08f44-88292594e26mr5480156d6.1.1763064856305;
        Thu, 13 Nov 2025 12:14:16 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede881acc7sm17636211cf.28.2025.11.13.12.14.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:14:15 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 6/6] ima-evm-utils: remove unnecessary FILESEXTRAPATHS tweak
Date: Thu, 13 Nov 2025 15:13:42 -0500
Message-ID: <5770a76fc0d78a645ab254979986f572fd18b3ec.1763064477.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763064477.git.scott.murray@konsulko.com>
References: <cover.1763064477.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 20:14:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2549

It was pointed out that the recipe was wrongly doing
FILESEXTRAPATHS:append, but on inspection the recipe does
not need it at all, so just remove.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb         | 2 --
 1 file changed, 2 deletions(-)

diff --git a/meta-integrity/recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb b/meta-integrity/recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb
index 8ac080c..ac0a383 100644
--- a/meta-integrity/recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb
+++ b/meta-integrity/recipes-security/ima-evm-utils/ima-evm-utils_1.5.bb
@@ -6,8 +6,6 @@ DEPENDS += "openssl attr keyutils"
 
 DEPENDS:class-native += "openssl-native keyutils-native"
 
-FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"
-
 SRC_URI = " \
     https://github.com/mimizohar/ima-evm-utils/releases/download/v${PV}/${BP}.tar.gz \
     file://0001-Do-not-get-generation-using-ioctl-when-evm_portable-.patch \
-- 
2.51.0


