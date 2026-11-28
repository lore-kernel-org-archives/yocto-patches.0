Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9676.1795884901520632382
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:55:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PwE7gebM;
 spf=pass (domain: konsulko.com, ip: 209.85.128.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso83901445e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884900; x=1796489700; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZNMwuSY5YR00I0Pj/+6LAlIDoCmZHgA3e7P813IzmV4=;
        b=PwE7gebM89E/iJdTcBp6bTj3qBWDfQ8z9xEiaNFlKN/stXddH0OvG1niwyP8Hg5/cm
         2AaH0NumjoTlDp2q1rekaLrcMpWfvP0Rtlri7TPB26bf2ZdEcchNsN52pXc525JUI2oV
         TkS+eQxXJnjt1U19qN3OILTjGXzEq6tGndPb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884900; x=1796489700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZNMwuSY5YR00I0Pj/+6LAlIDoCmZHgA3e7P813IzmV4=;
        b=Wz08q8SBg27aJ/VKDuWV28nvniuFRA2Ay4q+WI+H57vrLq5G8+GsBaj1b341jhPnkW
         j0DR9LKi7it/NLZsPL0LPL07Eheae2EznZtzKJ/Jo0P8+5e+I3E/VKmpIsV2Tw7vXZMk
         pekz7Mt9gt3hRPbBHPoJuE/YHpXNsIJgsKauECVUvU0E5UiZjaWFeSxtr3zBXEiPlg8e
         fOHLLIZkHSCRWKT9LBVMYywhLFkOf0JVvIglEqOaGvxb2sCxwmN8vLrmjF9pptgMmVRd
         pe+5DfneSJPUMyDmtXSTy2yPCPh9dutrsGRXd48ipLwMoJoPpmiF9drtAl/xs1qzlEL0
         nbdg==
X-Gm-Message-State: APuU4Z9pCTI/1ZB7wYGp+En7nVxi6wGu84svG722cfRPlRrgqIEjX/Hs
	2N6W47jpzdPlaNmOG0aMI28gTk29/82NosX39ScpotNfH0E3baU8VuKWgq2FsqoXLkoZ3onkkKC
	tu6eAHgs=
X-Gm-Gg: AZFdTZe10apTFBW4S/Q9bi06EmTOIkxcIr31KTZvokNEDuuHPi9OutXG19hYStObmuo
	894RZTILzwz17WnuSr3q/lpekJUFl7VGft2y4goH6KH6x7yXVEdd3hGLR10tYa+V0xvx/2FTUPY
	nuOg2qxyLy/f9ka8bfRsrsQdWlOLMMgeDRtTaiyoYD3oppo2xTfP3sGmmrpMMYzu8r7wtP723SG
	T6Yrlhn32zvvBLz9D4Diyuyr30gZg1GHfpgtTSKWaEfogmaBXCJ4c2S+++oj9IQPt1VzQzmbtpl
	p2afDdwdzsWlpCMk2ZEdPwtLaZEri7WKU24JNby5qHGCftj/Z5C26ONgwG7C1kwBY4GQCfP6tYa
	ifVD2inGkF+N0ToJgnuNyJnj1+UwavHPF3NKaAhNxIPk+iZptflWy/cVQRqrMy8ta0t9Uct25Jz
	WXf2/TFYnRaG1UJjSVL/QUtoMYt0oJtgrBLgtTgKB6+gQuyR+x8OGQ6Y+uDux3dZdGbrtRjdedY
	Kyae0oDAtpx7RFFcW1sZRUobR88Iz0ZAsyOqiLyQQ/QZUN14OTU4x3k4Tp36KYtWEn25WZGt5oI
	j1QerwtOoahF5K1DZS2hfp8SpGlZ4rELvSk6+dtXNfZjAuBl6f4pTe25FeyI/+CfaDHriURivyO
	6x5JSnDK02tZ2OXDqLGIba9EwWknRjnraY45E71Q9r84kAHL70nY=
X-Received: by 2002:a05:600c:c086:b0:4bb:a5e1:8288 with SMTP id 5b1f17b1804b1-4bba5e1b76amr194247415e9.6.1795884899646;
        Sat, 28 Nov 2026 08:54:59 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:58 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 13/14] aide: Upgrade 0.19.4 -> 0.19.5
Date: Sat, 28 Nov 2026 18:54:31 +0200
Message-ID: <2aba1c6e0758079b3c125b81ac2a2df49dacfa32.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:55:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5583
Content-Type: text/plain; charset="utf-8"

Release notes:
https://github.com/aide/aide/releases/tag/v0.19.5

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/aide/{aide_0.19.4.bb => aide_0.19.5.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-ids/aide/{aide_0.19.4.bb => aide_0.19.5.bb} (96%)

diff --git a/recipes-ids/aide/aide_0.19.4.bb b/recipes-ids/aide/aide_0.19.5.bb
similarity index 96%
rename from recipes-ids/aide/aide_0.19.4.bb
rename to recipes-ids/aide/aide_0.19.5.bb
index 9cdd601..84f210c 100644
--- a/recipes-ids/aide/aide_0.19.4.bb
+++ b/recipes-ids/aide/aide_0.19.5.bb
@@ -10,7 +10,7 @@ SRC_URI = "https://github.com/aide/aide/releases/download/v${PV}/${BPN}-${PV}.ta
            file://aide.conf \
 "
 
-SRC_URI[sha256sum] = "47ab7c696f0745911479a41f90d7ad99d26536e186d66c4aad093bc72d20ff5f"
+SRC_URI[sha256sum] = "6b004557e9493048ceb5fa84fb44b904c16e23bed8850dc21316e7c44247a350"
 
 UPSTREAM_CHECK_URI = "https://github.com/${BPN}/${BPN}/releases"
 
-- 
2.47.3

