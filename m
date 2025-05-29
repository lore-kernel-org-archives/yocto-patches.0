Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D972C3ABB2
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 02:42:03 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.12281.1748486517485786670
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 May 2025 19:41:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=h2qZ1H+r;
 spf=pass (domain: konsulko.com, ip: 209.85.210.182, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so284706b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1748486516; x=1749091316; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V78m16xrm/lAGYhEAAU/pvDB28zo8XNZH2x1xsThROM=;
        b=h2qZ1H+radQkrWpH/xcn9N9TBATwaU6VYDzFWRC1o+t3Kt65kNvCZaezvgdFfDnJf2
         E4qKlhZ9usXCUUwuhAj5Mc6UIe92Pw+59n/eOFIq69s+vtKPDI+4d3tCT/Oco0uhE0lv
         ORSKUrBkiO86WiiS+v4TKsiWB7nhkW/jURrR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748486516; x=1749091316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V78m16xrm/lAGYhEAAU/pvDB28zo8XNZH2x1xsThROM=;
        b=SI59yfTVapkzRBtIx59ayf4IRJBzpZqUQenrkpRpOKWNYX1MT9XSs3ndBTi0iDjm/h
         UA+dp0XwKzeT865oErIq6ObfKWuRGtUCJWL5ao3Gq0fcbVOb6Gb5CuJNy+nrwrnT9mYf
         4ov70qbI05ILkuBRw8/Vd99h/o6vplQAw7v6jZStW5m4a1hl81ReQSU7lW1Z7E2GuYQ0
         xTRpENskVsDF9V9tBftKgd59uGA1zjqbmfON/8uYGWOaMJ6+JItxVtfi2VFIOKRG9N32
         iL2dnTRaLPPnBT4iCDFj+Wrx09zsznNnhHPJmCJIOe/7wOh0xp8FI/SB1yVRyq7mKj7H
         p/yA==
X-Gm-Message-State: AOJu0YxgMwaxGXr10VwiPiFzBM2POwnbzVidQbxvScTrCJ2ULtPw6cu4
	0WEkJu1joVE7WkzRDUiXMRX70/tS4avrDBf7vA0LnTmpCJwtVI2P47SHnBhSUnzflWVxR7TNQJn
	nK4GqmFhXNw==
X-Gm-Gg: ASbGncs2DdnE1/yi6KnS90CWQq0L5/bJiu28qxhU65C3Y8g0y+FsEeCfhj7R/6eB4MT
	GUVk7wAFVBbldQbB2UAnK1IFBKq0i9hfoe3oLG0rZIrbivsL+2t9t4lZTV343qRXGwPZ/FPIg2P
	2GmVIMqw5NDF8luDIyfmwIZycODtPyhtUBNsDCGRuNzzR5xqilUShKxODkpHk7aRFPsoey3tnu8
	HcmbQ0w6na2XCi6CaqYVJEdj3DK6iqZJYoXp0hQtknSaXEO6qMdbOEqrC+lF4ZS1i4RHkKFt3Up
	jtjb/axsuJO9fNxlB3GA2UF7Qd7yp04/P5kYHyTv4IMCNbdVK6/FGdAlpDzpQBt7LeyW8xQuxAH
	hoY4EVwMHc9zBVpw=
X-Google-Smtp-Source: AGHT+IFyXZrGjuvGLrXqyOTS6OdB73miKL3pfMac3VINKacjao6lxbDCVAi+NaAxg75A2+KafP1gfA==
X-Received: by 2002:a05:6a21:3945:b0:1fd:ecfa:b6d7 with SMTP id adf61e73a8af0-21acbb104cdmr768345637.28.1748486516301;
        Wed, 28 May 2025 19:41:56 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2d99ec762dsm1791254a12.52.2025.05.28.19.41.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 19:41:55 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 01/11] u-boot: Fix potential index error issues in do_deploy with multiple u-boot configurations
Date: Wed, 28 May 2025 19:41:28 -0700
Message-ID: <2dc63a32d4ad8a0b0179bb8d2468f8bf104e5732.1748486276.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748486276.git.tim.orling@konsulko.com>
References: <cover.1748486276.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 02:42:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1585

From: Florian Amstutz <florian.amstutz@scs.ch>

If i or j have not been unset in do_deploy:prepend functions, images are not correctly
copied to DEPLOYDIR.

(From OE-Core rev: 5a0764eaac90bd62dac4a387eed5eb68f556412f)

Signed-off-by: Florian Amstutz <florian.amstutz@scs.ch>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 recipes-bsp/u-boot/u-boot.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-bsp/u-boot/u-boot.inc b/recipes-bsp/u-boot/u-boot.inc
index f5b43f6..608d621 100644
--- a/recipes-bsp/u-boot/u-boot.inc
+++ b/recipes-bsp/u-boot/u-boot.inc
@@ -217,6 +217,7 @@ RDEPENDS:${PN} += "${PN}-env"
 do_deploy () {
     if [ -n "${UBOOT_CONFIG}" ]
     then
+        unset i j
         for config in ${UBOOT_MACHINE}; do
             i=$(expr $i + 1);
             for type in ${UBOOT_CONFIG}; do
-- 
2.43.0


