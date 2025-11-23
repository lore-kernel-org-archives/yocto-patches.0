Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402ACCFD340
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:33 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4862.1763941528779223601
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JOisPsrJ;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b29ff9d18cso370983285a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941528; x=1764546328; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdbl+yVp+Km2h6LY3EBesr1Nc7wab5SobWbXS0e5P8c=;
        b=JOisPsrJiW9af+JiAEe71fGCfqPLH8ODj2gh9qsnbJxbFM7ge83RaSxCBqPgW/mvoR
         epJm7ESZxoFY0akT6OsFwl9J9Vt5wq7ANHTJ5irM7Fb+TYJts+cYolE+lSpoxJr1k0PD
         E8RYeq2U4bc/6bJumkthqNCCDpgSNfBJFEfA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941528; x=1764546328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xdbl+yVp+Km2h6LY3EBesr1Nc7wab5SobWbXS0e5P8c=;
        b=XfedJuBAmV4yncjvpNq833W6Wd4wk6k77ClPxbhH8Hayl41wV1/s7AeSHt//2QCsrh
         P4SQeOviOhgWX+u4hRPz9EYkTPU79Jf2Pq6GNOcYFz2xi3nLiiuMX9xtqt4HWQ7mD2EU
         toLDKPLyFscfIxJx+Ik0KM2psy+0Y79K4E9NyYICzZ5FlwbITXMSobUca/XcnBMoirJ4
         nqMpPBUP8D+Wdbeqv3mge4aNY3zQ6kw+7yU++v+eqPvFbVXGhl1m4DULg1R0gtURlXey
         fvKdzSK7lzFaC/f3pMrpLrmygGRpotd99OxpLbS+4zlNpGG3uUCshmgPXOXmXq4zM3nN
         AurQ==
X-Gm-Message-State: AOJu0Ywhtb0oRwoCNqBT9qDz5ZySO+cGotlyzcgEF/kn/azeCLo0KwZZ
	Ow5gc3a1nIDk/e8SGuVWqUW2frH/lw/vHOLlIKTPX5gv/qpskA772UVDYwKRHAmewaer4mkDszs
	hqsZQ
X-Gm-Gg: ASbGncvg7cfqnDSo5YveeP/sj5rQ1xsRoe5Jcvp932F+7irb40U1tr8NcK2ObK/JV/C
	7aDtnz/Z4UHFNgeXzxO06LF3Kc5FxM2XGVZTVKJBi763sdaJiLsf1/6V9BAtLbMkMKc3qTtdAuB
	gDaoRwtSS4YyXwZfDqEb4zbUIEvq2RaF3Z2UBuNNDYW+8Es9Vq3dSFCrK8E4rc48eicI6wj3Akn
	dod+jHdyV7yX1BUtkV3CA8st/nOUCbKeNAvNQsWM4wbUwFpinjGEh/Qs1VTTx37eZ5hyx80FhMQ
	13VhNXfEDK6M7OCOSAF3NAfcSLXOE69zoPrHSIawFVyfpa547kfRN4vd/MKegb//pBaW1dUOyML
	EEfRqFvTEWJ8tFkIQpOzfh+K12kTigOvZg3uCpg+dTiAJ0hg3WexAMbLUxM4r8WfuZFTtsUWIYe
	YJoae27AW0W9QW5xKOWsChLNWxfB8RTlW2J3DTTZPWunrrrYuPQWxcCwgh1hU7VZIQyR7viE0k0
	Q==
X-Google-Smtp-Source: AGHT+IGhOAbqa+3P88QyOvuf5+l6/oJ4tZXn702MQuFmh1+SIXkmaropObQNhqnmkmLXnxXsztc4CQ==
X-Received: by 2002:a05:620a:4402:b0:8a4:6ac1:ae9 with SMTP id af79cd13be357-8b33d1b139fmr1250018185a.3.1763941527528;
        Sun, 23 Nov 2025 15:45:27 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:27 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 11/32] meta-tpm: Small maintainers fix
Date: Sun, 23 Nov 2025 18:44:51 -0500
Message-ID: <bb6ea607788d94378d3b707cfc081316ae8beb8b.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2669

To avoid confusion, remove stray aircrack-ng entry as it is actually
in the main layer and not meta-tpm.

(cherry picked from commit 9f1d763bb17bf105cc313a95eb3b07496b34bacc)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/conf/distro/include/maintainers-meta-tpm.inc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
index 829f198..0925eef 100644
--- a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
+++ b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
@@ -19,7 +19,6 @@
 #	RECIPE_MAINTAINER:pn-<recipe name> = "Full Name <address@domain>"
 #
 # Please keep this list in alphabetical order.
-RECIPE_MAINTAINER:pn-aircrack-ng = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-pcr-extend = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-tpm-quote-tools = "Scott Murray <scott.murray@konsulko.com>"
 RECIPE_MAINTAINER:pn-libtpms = "Scott Murray <scott.murray@konsulko.com>"
-- 
2.47.3


