Return-Path: <michael@amarulasolutions.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ED6EA718F
	for <webhook@archiver.kernel.org>; Sun, 19 Apr 2026 06:37:24 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3967.1776580636676733229
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 18 Apr 2026 23:37:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=bZvuBb1U;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.218.50, mailfrom: michael@amarulasolutions.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9910707d82so307106966b.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 18 Apr 2026 23:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1776580634; x=1777185434; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yAmgv2lVZpE/SE7DC82GpSZeFh3YqtMiZpzr9WufvnE=;
        b=bZvuBb1UwA5fgri2YdAVVY3Qk9jBR9g5atJwfmw/k0YyZHDcZEZoGLYgsG5eSIGcWR
         Ie66+JD8KywDF2za+Jjxw94uM2JhwodlEC4tcR2OyrRx3srisURWficIb/99glPf2fS+
         kdP5Is1iE69MmTFpLRl52+1Y37XFwmGb7I3KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776580634; x=1777185434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAmgv2lVZpE/SE7DC82GpSZeFh3YqtMiZpzr9WufvnE=;
        b=QGE35BPf++EgoenS2BVu0Qy4KqWmbgQv3Cn9QIcpG6Sx1mTDpIF8hqas+Cu79Ft6V4
         ewzJ2KU/ndLpFLABSOcBJsWfQvS9yvaeHeJeXIyDV9EqE75mwNfkss2OCljPpIK3rtWn
         fYQSD9QFpAZ2AMn1THEXfuM/Knljus8ryReGXcUx7evK1SjougsbVDDfsPHqi/X4ruzG
         QclHs9uzRaVfFuuSm1YRE5WhPwSVcd443av9ycLCYDCQfykQjSlhuIZuNWeRHgloOiWg
         AqytI+547DxQXETnPNu/9A3RfQteAMbQAIiDGcxff2hUkIROf7f2CW2XGe9OJEK8YT/q
         ELoQ==
X-Gm-Message-State: AOJu0YwIaWNyrnJirypxHvIquC2DdXgX40KXWtmGVGnmwQXqqXmMXaPV
	mvnfE65FSYcW86ZGNeyeG7ualCgG2YIqPxLlFZmcHMJPb6R6/XtE3LwMpA1ZnW9rUrdv8Tl3JId
	F5sGbhG6e1g==
X-Gm-Gg: AeBDievwWpNUSMZN4C8x0ADvBcB5ZBh+iLNE2dr/357U/RfXQWayoOsz6SPnXaOmpUD
	35eumgmqd9GqU0qaI1Ct9Pze68YLb6sGffIH6fGPWE128AYKRb6nH704LItCxuwSHliCCX/rNJN
	/GJpacp852e+sw5KE6pUPBCJeqx8pxYniQl6eokeQLr3vdW9bFU0eEnSdorfXL+Be23cCgxFVD9
	F+ftwYPqwDZNnig7pqHcQfMmZFTkXR53myxDHH/HGBqaIfut2ePz0Y3HHG+NBpTCimcqpKfdtF9
	NxFQWmLcGKclGpbV0BLWJ1r5kUhepfzAmWQbBZzUAi2y8Jv04IpCNQBgDu9iPoeQu1SfHwUfchn
	+/WVuXb9aMIvg8FKgSQEa3AxuhVg0EA9VfQdueQRUQ3vm8OVFTkgsKTYGKf3TAy/S+YDcrKhalQ
	Vol64RAz9kGDwuBXW/5TRpddN3WT4mlFE6jW7yCXpNMvLQ02qnybb2q49udSBjkGDNsPei7AZ7f
	jjjikHIxxJUlise4CSK7RjDVaDwMvo42d3d+4G+088=
X-Received: by 2002:a17:907:9453:b0:b9b:5164:9057 with SMTP id a640c23a62f3a-ba4189818ddmr444804366b.3.1776580634338;
        Sat, 18 Apr 2026 23:37:14 -0700 (PDT)
Received: from panicking.station (mob-5-91-87-238.net.vodafone.it. [5.91.87.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45503c414sm230333866b.44.2026.04.18.23.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 23:37:13 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [meta-rockchip] [PATCH] wic: wic need to be moved to files/wic within the layer to be found/used
Date: Sun, 19 Apr 2026 08:37:04 +0200
Message-ID: <20260419063704.851653-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 19 Apr 2026 06:37:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3728

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 {wic => files}/rockchip.wks | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {wic => files}/rockchip.wks (100%)

diff --git a/wic/rockchip.wks b/files/rockchip.wks
similarity index 100%
rename from wic/rockchip.wks
rename to files/rockchip.wks
-- 
2.53.0


