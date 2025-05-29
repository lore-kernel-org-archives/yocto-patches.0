Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48498C5B543
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 02:42:13 +0000 (UTC)
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
 by mx.groups.io with SMTP id smtpd.web11.12376.1748486531277819735
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 May 2025 19:42:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=OUk9kGZ9;
 spf=pass (domain: konsulko.com, ip: 209.85.214.193, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-234b9dfb842so4585145ad.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 19:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1748486530; x=1749091330; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqhtjyrS+M3o4+O5eJGz5Mg9LNrVYXN7HjTR/DsYrW4=;
        b=OUk9kGZ99yW6pzXm2XngPCUxizvBmkMhmz9JKftwS0QuvzzOHx2bKtzQoXT7kCSa6h
         wVWhVpX7FlCUlqEA0Fu+mRyKEnYqk3/Ct7UeoSdtxksvea6PK1CZIN3XmUnpFULWhJr7
         wJvAXUaAzD0/0DfrgHDUdGaHKOX3Hqk/GgFsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748486530; x=1749091330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqhtjyrS+M3o4+O5eJGz5Mg9LNrVYXN7HjTR/DsYrW4=;
        b=GASpFYzseDxGXx8ERaqm2bzdtHJG0+9XiHxnQ5qs+JcbD+/x1ZC7b+4WKgLhtWxWSB
         8AaXfF1C2ewjhZWrjlws7vb2PVVMASn7Omj+ghhnKc6OUinrOW+Bx3w3vIYm3F4SD7Th
         Z4YgObPYEVyAFR2xNQDnU9VBXg5/cw2mU6ri+8jcf86emT4KELmcigu7TjbTgXp0/KA5
         S+EnaUo2algtm62C88t+9tixSaxDZSPwT1BbZCnmJHJyYU/VQe1tPXluKcajIhg73Lyd
         BJ4LH1HO8WK9yeXAQXXh+U8EiJE4X7wjL3ERYonUD4MDL0ZsagHWPaW51C7sKJHfiKQj
         nxFA==
X-Gm-Message-State: AOJu0YzI593/+//BD9PwFyFjp1aRru0fDalh9K1ha7gdHIvne9wa4KMo
	UGhcthHsqLoNrhEAgq5uMSzqyVgNgTmquXII99oLc5aqB2IiEBp0zsJDRVaslVkX52GBWY2ofU9
	i0nja81DIVnTw
X-Gm-Gg: ASbGncud5ClP7dymCQ0nLsoSpKq3SncSfOIVhAMAu+Ewb63SRN3SVGIbZ0zWzB//NFD
	aT64D25nMAeKIgwQIQl3/D/mXLidXBis+OaCdg+dvmmJSirhn4k5F/k1XmehEtFzcIWoLnaLRgD
	KQIveqgx6qw+96arQSd2Nl1z7aqtdfxcblfjnhOWFfdk9fR9znWFQf8NRyrkfLOJoEhjjqORrzY
	GobrJcUDUmdteedlvIg5W8SX3T5rHZ90zui9Kk9HPMTLd8aPpfz5hFIyPY73XfhvDdzFAyylqOP
	PCMP4MSNSzujbcbK0WbCUearCXlj/nsseLofS+YZUVdV2YttxZXrgt6XaKCY+xHsvCn3R748pQF
	BTJUtJ6sLUowetGI=
X-Google-Smtp-Source: AGHT+IFkIxHVR0olNpwf+5xRBw6Y3aI3YEnGDSlLB9hASz0M8vc5UF9AYuD1T5KW/dB6FscTS1cPPA==
X-Received: by 2002:a17:902:cf01:b0:234:bca7:2920 with SMTP id d9443c01a7336-234bca735b4mr104064845ad.24.1748486530265;
        Wed, 28 May 2025 19:42:10 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf5453sm2754385ad.183.2025.05.28.19.42.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 19:42:09 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 07/11] u-boot: Update Upstream-Status
Date: Wed, 28 May 2025 19:41:34 -0700
Message-ID: <7afb006c0749452e3e393e230460336cc4b10b3e.1748486276.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748486276.git.tim.orling@konsulko.com>
References: <cover.1748486276.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 02:42:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1591

From: Fabio Estevam <festevam@denx.de>

0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch is now
applied in U-Boot upstream.

Update the Upstream-Status accordingly.

(From OE-Core rev: 718f97d90b13c190e2b1852447764c31464ebdf1)

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 ...1-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-bsp/u-boot/files/0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch b/recipes-bsp/u-boot/files/0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch
index 9cd2cee..2eeef99 100644
--- a/recipes-bsp/u-boot/files/0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch
+++ b/recipes-bsp/u-boot/files/0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch
@@ -17,7 +17,7 @@ since swig 4.3.0.
 |  5581 |     resultobj = SWIG_Python_AppendOutput(resultobj, val);
 |       |                 ^~~~~~~~~~~~~~~~~~~~~~~~
 
-Upstream-Status: Submitted
+Upstream-Status: Backport [https://github.com/u-boot/u-boot/commit/a63456b9191fae2fe49f4b121e025792022e3950]
 
 Signed-off-by: Markus Volk <f_l_k@t-online.de>
 ---
-- 
2.43.0


