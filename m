Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42B2CD6E4A
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 13:31:49 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20051.1780493503722732929
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 06:31:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RiwFv/d+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bec2ddee9bbso707764966b.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780493502; x=1781098302; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6NmKl9fcwYFr5bSCvSYLEk0wVZ14y6B9HlDZkG25yHg=;
        b=RiwFv/d+A5+Z8DJwWUCtUbISxhDPJVKN7gHweDd7RTrFUnPeY4at25B646hY9270uy
         ljxD1S965VpfwJiCPgvZquPOKxuyVr9nYfWjSX48r2HW5kE+cUAVOAlo2zWRssY7scoU
         oEjHdRNYs3oPwI6rKz9Tu+YcxsuQkRUCeQ4VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780493502; x=1781098302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NmKl9fcwYFr5bSCvSYLEk0wVZ14y6B9HlDZkG25yHg=;
        b=iq3UJG3PE21HKwJIq4HN/jq9j0zBlVlGnHpgn6Cmz5HPmRwBCz2zMT8t+dfybcqgrZ
         ZrPsqCrg5/Cx66bKs6ZalJgq3IhVBbqaDWUqH0Vm9zbx/aguDcQkpv3lnntjkHMVTS8Z
         Vx2wuCx3/PxY3TLoDIYgrLt29EOdekVPku+iB7evOHGrRFQlK6rjOjx34OCG2/Sny8h/
         PpJWld+4UH7l7nUz9pNf9j8GNyqozY+lzhrF5SpslXT57pfLdDmzaTfeMGs+kNYzd4XL
         isUEccWvjTb1Zypxjk1j7go1zaJxHB9vC6PTPQwAbs9nLokE+RIqfx/DJI288VYAO/fL
         eAVA==
X-Gm-Message-State: AOJu0YwK1Kcz+ut5Otl/NWflmBoTJBjfK8xGeilD1Mev5nUKxwRAQLFL
	aInuEE8F+p6NNw8XGtheqvLbRIirJ/due6FumjJQpAY0XGFV2/qONff2o7JZSZYVsRvH/bC+FFJ
	fJCcz
X-Gm-Gg: Acq92OGmptApYtYnARPwLUzdDcWjvGwFusITNUC6qHVUhkBMp+Nto9xPEIxLRfBfPnS
	8O8jzpHt6z1oKfWFlLbfMJnVK/xSgd0Z+dy8dssZNFvGWJiDdnPGho0ya+D7X0M1rGx4Ga2SQv8
	il1ulwzeoJZNobtiRfy6iuiXfh8ZKIhAJCKiylBGaSMzqTUvFNl5xhQCWIZXWywRAYnbRUzsiXu
	2s6YjC+BTLCcWqtSc/mE6W8rYP4frGhRDXy/UcCYa3UpfSa0b197yUR+g7cRQPRbyITWN1CyhCm
	Fwn/GSw6ssIpyGrw8VYzBA8ygFLhh3lFmGjj8LjWDIosYywZahp9me/u7rPLGlNYZ4Ax9lq8+f9
	w19KualrO2KbN4x1/gAKGmCDG6+gb3L6heSbEPsZM3xyTdNYugdSiz7Leynlp7KhUAs/MhrNV9C
	jIp2P9StHb/FEKPBe1Uk5iPEsHOPz1+FjmkQJe2zxHC4F5XB91n+m8dHA6HeOLig==
X-Received: by 2002:a17:907:c244:b0:bd4:6da5:d5b2 with SMTP id a640c23a62f3a-bf0a873ef26mr176118566b.1.1780493500841;
        Wed, 03 Jun 2026 06:31:40 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:202c:df88:9261:8b8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307a35sm156048366b.52.2026.06.03.06.31.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:31:40 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 1/3] config.json: Drop i686 uninative
Date: Wed,  3 Jun 2026 14:31:37 +0100
Message-ID: <20260603133139.1113999-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 13:31:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4116

Runing builds within the constraints of an i686 32 bit system seems
unlikely now, stop generating/shipping uninative for such systems.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/config.json b/config.json
index b27fee9..a9fb40c 100644
--- a/config.json
+++ b/config.json
@@ -1073,11 +1073,6 @@
                 "SANITYTARGETS" : "buildtools-tarball:do_testsdk buildtools-extended-tarball:do_testsdk"
             },
             "step2" : {
-                "SDKMACHINE" : "i686",
-                "shortname" : "i686 tools",
-                "BBTARGETS" : "uninative-tarball"
-            },
-            "step3" : {
                 "SDKMACHINE" : "aarch64",
                 "shortname" : "aarch64 tools",
                 "BBTARGETS" : "buildtools-tarball buildtools-docs-tarball buildtools-make-tarball buildtools-extended-tarball uninative-tarball"

