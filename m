Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55406FF6E9D
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 23:29:13 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2782.1773790151608011860
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 16:29:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=ARDvkcH7;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so17456845e9.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 16:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773790150; x=1774394950; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zJZhAkrpmnte2jUdYkDwz8tTnzxWk+wzuBabH3qfHBU=;
        b=ARDvkcH7VWLaRcXTjzAqcElxSBHr4fEyKYLlt9iyCMS3fJWZ4SvveqT8InJnUbvQwg
         5/OAi8nwcaG1GU3nBoDCVmmqhBIyAn/lL4oUzZpuD/pcwLlvQTq/GtiZt85ZcazNIcUO
         yBChXTlcuniKyOCMiVc5RWVQSi2QQcx0wkuoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773790150; x=1774394950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJZhAkrpmnte2jUdYkDwz8tTnzxWk+wzuBabH3qfHBU=;
        b=XT9vL+KV8HymX7ABRMv3UCQ++KYiXqlcq22Uw30eC1KuDbFYDlqYZzvCXQczfD+fhP
         anVYH5zJ/5EYCbOPeTcbjcveN3/2Wp8gZrTDHmtzWZAOPjpUA+ZTZ9RPMQnXxj5hy/nA
         QuQZb8DWnVciMcswR3Tb6H74YJM4Ds8SSVnfF1cEoLuG6djF0kA3rDkWcdfh7baa13jS
         TIGFNZPQWFyX/6Io8qB4fvVxI+QTK4p1XGazAC0YXOARxLJR9r4LbBNXBi0FauL0n7xf
         eTOYnVAUkfeVuwJpDGE8SIQtXbIE3WdHRiU4W7iFphUdu77Ra4enmAI8UNVNVNr4segw
         lTmw==
X-Gm-Message-State: AOJu0YywFLfAWYkBjH139aLiBIpaoGgfEaH/SLGlsdO7qMOdSCEKnJ05
	Mwq5Gt41Lj0l7J5G/HzPds253AdIWy7gsB2jcd/K6Y+i140AU1QXgD8bGcTf4C/sBB64oMOM2s8
	IgoNl
X-Gm-Gg: ATEYQzz9wO9fUsEkMLBEsVryl/kqo2gOAYLvsFc5jYvG+ix/AwBU9UuN94J9PGSBIWC
	PCwpNbXraLcRv0S8M89f4OMYhmqJ2MKIF9Wb6qzHWmOAaNddB7TF4Ws3W0bpHGdWu2J7BhIuduu
	mMvmuNkPsH3SK613BDVjuJT4OioE4gjV4T5BgVti9jzHtGfJPwLyWqo6IFAb300iOuTZq3s5noO
	+wVWGZNSF25n/9MHKpNGTxejjzRP9pTIHhZp8qq3EslfS4LAEp27NZFrdAcYkdJjnaOMRvB2VdE
	XYnh4S1m6uE8atlfx5J3jon0j9vzqhCuMhYc/DO4vaalvfDt8C89XZCkO5xoWphQYQvT9JzmnvH
	ZXaVl29/1Exi7pHOs2TxfWrmECijlH9syYdzMofg5X9mMtR8UW9iGuz74Uu4Yn7AFHiTiLcwArj
	tp5mg131wiHEl+4YPBZXVfykyU7PxmYZdURIaTivN40/ufFQm4JyheQ3VzpirZKj+EX9GHnnCdA
	W/9TVqGf7jfJjFv5R8P9ENRNw0=
X-Received: by 2002:a05:6000:2681:b0:43b:40ce:c198 with SMTP id ffacd0b85a97d-43b527cc9c4mr1889536f8f.50.1773790149763;
        Tue, 17 Mar 2026 16:29:09 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892234sm2807644f8f.24.2026.03.17.16.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:29:09 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH v2 1/5] dashboard/bugtriage: Add newline at EOL
Date: Wed, 18 Mar 2026 00:28:58 +0100
Message-ID: <20260317232902.2404326-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 23:29:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3495

From: Yoann Congal <yoann.congal@smile.fr>

This avoids changes created by opinionated text editors to repeatedly
adding it back.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/dashboard/bugtriage/index.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/bugtriage/index.html
index 5bbfd25..3ea5494 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -741,4 +741,4 @@
   </script>
 </body>
 
-</html>
\ No newline at end of file
+</html>

