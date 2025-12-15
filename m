Return-Path: <samuli.piippo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7872D5B16C
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 07:13:32 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42994.1765782804470299145
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 14 Dec 2025 23:13:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YiXuXhox;
 spf=pass (domain: gmail.com, ip: 209.85.167.51, mailfrom: samuli.piippo@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-598efcf3a89so2991732e87.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 14 Dec 2025 23:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765782802; x=1766387602; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w2OgmiPtZqDGL2INtJSlgBYsNMbHUXzh5GWnPfXE2VE=;
        b=YiXuXhoxJL9ya8mqn38RVVExsraBnTC/T9fp4WBFiOfzhlclLguN+gMToOEUsPMGs5
         1aT65TWk30YOtOfS6t69l8NgkciEeaD5A5l4YMBhDnIKyBmLXSOhcTUTHbvNUHoxNzvK
         dcC6U/5PEjcX/WiF1xZpTjZaUeIISm2gSGyBGrYwo7o0E4xuVPvNvJS/ZeIu/KFmm+7Y
         Br/+9Pksk7/nmEjWl0UTZ4qoObMQ1qDmJvEcQYPVnmqll254hhKqWhNHNnLc04fVtBKg
         mhMBs5gtdctUYbgvfWADWQnBKXPBdievxdrAhUreUifEDhu0qk1aW+3ONYGuFSGILK/J
         eHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765782802; x=1766387602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2OgmiPtZqDGL2INtJSlgBYsNMbHUXzh5GWnPfXE2VE=;
        b=B3bcj+Hv6gArenB+v1xajCN4Q0kIELB+7oabEPiJRfF+PbHcfWUubCwCuXxMOKTh9I
         TpWRqd0Dg/HJxCupXZuPrpKhUKgwmWxK8JFs+38x9DtqZTObhiR2Fxyimm2k6GwqKATl
         2mdHLeKWYFqHX5KrwjkLlHZiq4OlGsLDc5SgGRhvAbpoww6jpVul0I371lFuv4XB2Av1
         sW8BYRJNexx30YJdDzvVniW4eOP/vNna0aDF+SU5EWSy63yypS48dHOgVdMiQ6kLU2b0
         VJutIdEfc3sRefAh7UvZjB6q49/LQd1xwOjJjRKKgnOfyK38kIUTeQg8jdQDnUrsXKdh
         KoOw==
X-Gm-Message-State: AOJu0YxSXB+LCGD3N5HizhVEEzRLaljvtoESlZALuqfK3xC0AYPQR+Aa
	8IMG/y2cznuBlkAb7D9U3bw620Xh6OoJxLwPxNoBVrH/unwp8q+ZhUE8nmDQrw==
X-Gm-Gg: AY/fxX5I+AlEWMEA3PBV1pXJUnWDpv24SaBHGUDQiKI5bGUq0OyZcVsVqQiS9QwR32l
	Y4CtNl2WO8P1tGYjQuJJ6nRrYB67mIvuAKvvqM1UfiGIhfoU/nppwj4+aCcGBbSV5aW38fdNh3R
	zBP0uPwJwUV8KbKc20gj2ZL4tLVbpbroZ/V1UDg8U5Qeu6Y21ycros6HVu244Zi/wXbnSGg34Jd
	1BuolEImdzV2+tL84H3AP7TXc1n9u9vEB9ZAo6Jw+BjZqA4kUx8EN43h6x8PCzoANnu1gjOI8uP
	wOOPyuqkg65WKhcd3zIH2uc+CQoJoCLXrOR6pz9JnPT3vlx8ge9lZ8REWjblV10zaGewNTlfIJR
	l6NGMysYENqDtcudFd863YZmJ7gtOhVCoG/RubG2BnUPcahNfvgrzU6Y0NFYP6mS2WUaXYWTmZw
	tdxZukClA0f+5JIbDEP2B8QbqIyoyW8nb9H3F0xZyv0KsO7SfXQD7bVWItjV7YGSs=
X-Google-Smtp-Source: AGHT+IFtAnxC2SEwfeIz0o50okE1RXsRoVfTUpBfl+YhwDuC9YaRVaoguqc6XDWVdg0WXWu4icO+ZA==
X-Received: by 2002:a05:6512:3f09:b0:598:eecb:c330 with SMTP id 2adb3069b0e04-598faa36182mr3947571e87.4.1765782801927;
        Sun, 14 Dec 2025 23:13:21 -0800 (PST)
Received: from dcbuildsrv.ci.qt.io (ip-109-75-238-172.customer.as29154.net. [109.75.238.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2f37b0dsm5018233e87.7.2025.12.14.23.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 23:13:21 -0800 (PST)
From: Samuli Piippo <samuli.piippo@gmail.com>
X-Google-Original-From: Samuli Piippo <samuli.piippo@qt.io>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH 1/2] curl: enable SSL/TLS support
Date: Mon, 15 Dec 2025 07:12:44 +0000
Message-ID: <20251215071245.2864807-1-samuli.piippo@qt.io>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 07:13:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2784

Enable Windows native Schannel SSL/TLS support in curl.

Signed-off-by: Samuli Piippo <samuli.piippo@qt.io>
---
 recipes-support/curl/curl_%.bbappend | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-support/curl/curl_%.bbappend b/recipes-support/curl/curl_%.bbappend
index 10c234d..41342d4 100644
--- a/recipes-support/curl/curl_%.bbappend
+++ b/recipes-support/curl/curl_%.bbappend
@@ -1,5 +1,5 @@
 PACKAGECONFIG:remove:class-nativesdk:mingw32 = "openssl"
-EXTRA_OECONF:append:class-nativesdk:mingw32 = " --without-ssl"
+PACKAGECONFIG:append:class-nativesdk:mingw32 = " schannel"
 RRECOMMENDS:lib${BPN}:remove:mingw32 = "ca-certificates"
 
 # Configure tests for ioctlsocket FIONBIO fails with GCC-14
-- 
2.43.0


