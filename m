Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FDAC43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 13:13:52 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44675.1782911623369440769
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 06:13:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HADKotyZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4926bd21aa1so4087985e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782911621; x=1783516421; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRyT7VxF6JnWAf2ODdelGILCLECir/PuCBUMYYiWxeo=;
        b=HADKotyZODEZ0roXuaAfimYvjMU40QQAtH0VZlrOT+FlzKsjBxkqt5+PGUo4HR4Q3L
         Zo5XLSXuAa8Ypp5ZSLU/nxDLuap9PvcLKID+j1jLhjVd5FH3dIeFP9GSPOP4C4rndkzn
         dtBpmiINhhxIGM+vu0hs1o7fRor/RPBOw8ZJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782911621; x=1783516421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XRyT7VxF6JnWAf2ODdelGILCLECir/PuCBUMYYiWxeo=;
        b=O2D4dlM7fxJ/HGLeaHmRukOmlXYD3k1NjrlCNF7KXWzYIUvrF5+Y9r2/nzxZJaRVBw
         s1Ot3L/xoHgjFkQX0y2eK8IQjyR8NS9tsnq5eZRdwIN2I7nvMk1DGftqtMoXCPdcgKnb
         2TUQP9eKfCfSrzgdDLpg02toDXPxSiR04BT5mc974igZ26FjffDzP10HKcI3P+MXEoEx
         MJpN5j69uzBIZJ3nxGRMmqV8iUGRQW+WfiDsXG9wTUmYwx7NGJ4kInyWouyA5mvbLXcs
         RdiPyn5J5LBYMhKyZa7w6SeCngJcbb+Kky+p6yB0Fj86Wbt+lOtheVlW7J6S6STTb3dg
         c7RQ==
X-Gm-Message-State: AOJu0YxGUi/FM41N2yi2+hFzZnLCtu5v1m/davGnETI1ptm+sz5pp+iA
	AIvStsOWYbm6pFw1NQWPq8fS96kLHFxHaAmfWCSdVgNsuw9AhBL2nP2Gn44K5yS8d1HME8R+Tmg
	ZbkDL
X-Gm-Gg: AfdE7cnxc/hTkWYvY9ZKlF1PGNvnyzPI85dRDj089fNvdL949HdkpMnemjIvpbZ8buU
	4cerbUIlFpTXvMpb+NV1Abw61R5ZOoFhy1QdScQzCkdZwdJwjVnl4H2Lw7XYvCqOefS+kku5eY2
	z+/NEUvU2EF+HAi12O9RMwGImR7/mifdedVt76MWQPKUP+5i5+ODrjx1Ne9aujR7t6gUukeFeM8
	ldKZg8W6rOIu1TKnJaXj1H3EwqbuQ1xpfiLj5u6WmBG4OnP7C098Prja6sc3qcdnByttCEg0jrD
	xAILIFGHEBIr4Uc0aFn1Tb5rDsFq0ouY5N1aQYAiX8IZVC3KErv2OuHvxvPUz4dMZZUtisvVyOE
	eKPgxBOumX+kgVCQiXsc1wfB77qLIWKuoNYZYHh449qiqSDprGggJ6s6KQz1vwdZcDdONSr5Vr9
	DsZethbfkrqCuGlj0OChzLQD9l7MX2RZG3rmD/raaClg==
X-Received: by 2002:a05:600c:8715:b0:493:bed7:6d7c with SMTP id 5b1f17b1804b1-493c2b8943dmr23653255e9.25.1782911621517;
        Wed, 01 Jul 2026 06:13:41 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6b3f:20f2:ee05:f032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567884770sm17568280f8f.33.2026.07.01.06.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:13:40 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 4/7] pseudo_util: Avoid a memory leak in pseudo_dropenv()
Date: Wed,  1 Jul 2026 14:13:33 +0100
Message-ID: <20260701131336.3578279-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
References: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 13:13:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4346

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 pseudo_util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pseudo_util.c b/pseudo_util.c
index 126746f..5e77977 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1000,6 +1000,7 @@ void pseudo_dropenv() {
 		} else {
 			SETENV(PRELINK_LIBRARIES, "", 1);
 		}
+		free(ld_preload);
 	}
 }
 

