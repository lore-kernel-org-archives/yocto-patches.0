Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BFBFEE4DE
	for <webhook@archiver.kernel.org>; Sat, 28 Feb 2026 09:20:48 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.116137.1772270443860491910
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Feb 2026 01:20:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=d1D65rwo;
 spf=pass (domain: smile.fr, ip: 209.85.128.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso30426665e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Feb 2026 01:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772270442; x=1772875242; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3O2/GLEV0hkOtzOCd8/IYzxCGiD9yhIYO25eL4Bp/XY=;
        b=d1D65rwooub49jf0WWtzjo42aJvY0hMgfp5l0Yktos2PZ1IBs6B61a1vog7H0/NbZN
         5dfJg09IuGUMbjDW/8R76wqQ/YBLtCSNVoRnh3ECAUkZ9mWAljyYntcSJZvL2C7cL/Vy
         tf1mk0DqFOaClKLWSJNXSlbueKJkCVJVlXj5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772270442; x=1772875242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O2/GLEV0hkOtzOCd8/IYzxCGiD9yhIYO25eL4Bp/XY=;
        b=YTUVfE9/OnZy1/npYlNsfuVBmv5MCqYg2LkYtd4wU58n4Fkp6S901OYPAk6EkYT1pR
         xPzpOdzKL2PJuLJaMp1Bu0H447ffiCUAh7EarWdtlN+v2iAf5JZfUOms4YRP2UdnpNq3
         LI9LfSu6Tr+2lCHAtxMzp4D1XzSWOBCp3L43t3r6cOwP8fClZsUusDZxA4gBbWsNPUXT
         wVMbuFO4qQ8cd7nIaQO/f2i02uGC9MTn7RFgiykO8UhzqbB/HOMuRmdHLJP+042xpUYc
         yFFmBaeNXXxRviA6j0cNnVCDVRwxZtLsEQxmgqeELUQhc0eq2tN5KXphIUKryHzbKrWz
         Rzlw==
X-Gm-Message-State: AOJu0YwkRzi545sMsJlw4AwOF40PiEsI4QamkZD+67HdcH+PqvFs9/NO
	J9YbG2mGovTpnfDX6rkWB5QJcXbm5Ymo1zU674IeCzsAKi1xfFqlJ/lsIWoB1XAdumMFl+Bqklr
	cI2vO
X-Gm-Gg: ATEYQzyxGC6ChvE0nZSVM8CilVZfN6eYsAq5f5TTgGJykJHzondmWWEELfSbEcOlvu5
	4kAP7OHCsZehXIgr7wYGsip6ox+W2nYtlQrHRLjwfubN1Ph/7DAw+xkSI2vU4aUcPlss6k3KIEZ
	woUsnx/Bv7ubsMyuaWXGdqk+UVRtsGrGyGAgfn8pOEPNyB5KzHc+3jX1w5o1yA7fl8QvGVnUvW4
	lglyscpDWn8FPN1P4UrYiyNRlNijADvzmbmTGM1ODsOUfwdqSW0TIB/HeM2Mvi2XTaKzVP7BPkB
	v+zzGc5QgmKN0Fb3M9AfGHWOehSpyBsMzBnknRuab+8mzsglKBw2GhgcFps0tyXpJCzCsEZwxIY
	LBVt4YJpBVYNfKcpp1GPgCoEqLb2GdJPqQ5R0yS7o5AHcYhqjaqtAAzspXKybDttcZqucjx2bYn
	BpCTLdh8bC9Fz8jrY3tDG0AeCKzkeTZ32TXEF0oygycuKGFuHy9T1TvtMDj81CYMglRGIIMaA23
	d+bbhdgRebIY0tzsfrymEaobyKCkM8lbm28hMM=
X-Received: by 2002:a05:600c:548a:b0:483:aa2:6bce with SMTP id 5b1f17b1804b1-483c9bdb0c2mr87284175e9.30.1772270441687;
        Sat, 28 Feb 2026 01:20:41 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa007f1b644d71d78354.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:7f1b:644d:71d7:8354])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b770e7sm171522005e9.9.2026.02.28.01.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 01:20:41 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [kirkstone][yocto-autobuilder-helper][PATCH] config.json: Use buildtools tarball for rocky8
Date: Sat, 28 Feb 2026 10:20:17 +0100
Message-ID: <20260228092017.175546-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 28 Feb 2026 09:20:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3309

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f7309f16f9b640f221237dc086943cad057d2211)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.json b/config.json
index 5f786cb..4949bb2 100644
--- a/config.json
+++ b/config.json
@@ -1354,6 +1354,7 @@
         "ubuntu1804-ty-*" : "${BUILDTOOLS_URL}",
         "ubuntu1804-arm-*" : "${BUILDTOOLS_ARM_URL}",
         "alma8*"       : "${BUILDTOOLS_URL}",
+        "rocky8*"      : "${BUILDTOOLS_URL}",
         "stream8*"     : "${BUILDTOOLS_URL}",
         "opensuse153*" : "${BUILDTOOLS_URL}",
         "opensuse154*" : "${BUILDTOOLS_URL}",

