Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6662FCD342C
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 16:21:53 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22611.1778084506859670229
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 May 2026 09:21:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GYmzi1pG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3973161f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778084505; x=1778689305; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGNGVDZuBH9R9wZkS/YC412xz8mR6ZCPukm3vcZ6CnI=;
        b=GYmzi1pGm4TrqFNpAQ4Ld8fKCQm3lqsJskjG95vKk3aWafh8RAZfmjHtMywnm6/3Um
         FScP5vG48lRaO013e52CGcu0Mpn7XywqiQUjLkm4rnuXakk/yrI4gg0SFFQqcYsqlyJM
         YfUOnbxL4PrQ2hvKSB+QZtc3INFbx5q/5cco4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084505; x=1778689305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mGNGVDZuBH9R9wZkS/YC412xz8mR6ZCPukm3vcZ6CnI=;
        b=ZOKFMZ7F52Tm25QbT1km+vKAYwqXDmDZnPSXerqUud4A1WFcrOP/4oiS2CVZDqDGU6
         u0+hz7KEqs2nNcYEDy40IuzLArekQ34Tyc2d61LMw7+KaDCiieAWQnVo4Rjk9XAGr9ju
         0cmxnp8nCLfEaOlm2ibSB7Ssm13yn1djFW2Bsqn1o72P+rKNIiFuAL90Uxxom/Dnn+2G
         KYbKTnaDo0hccM4YwRJiwLnqMyLIgVjIf2cXrkzwL4IZeEx88U+jpicqeCAgXUhkY1NO
         k6UAoLYPeblf9YKQPlzFoBmdsstC71d9lDP/Tr/q6UmrHgKa4LSiF6Wk4DA1CIW9EOew
         IlRg==
X-Gm-Message-State: AOJu0YwmMOQvd5Zmy47EwpWnWMBRtJa9Bm5lZVJX2zaDd6oAZ1zaK7kH
	ysX8fHEyM9gFH3aSbww63Z1foizvgCMw3IdZ/vZbIVp+Mr1+Xzd9lvC9jPNRpobSxTTswFFgdxi
	6EpQ8
X-Gm-Gg: AeBDieuk14EHh44eDOgP7miNdAT0eVW6nuFSvpr5QKw6VJuDal+CxqQWVDbKo/5bJMd
	8O0V+dUbEdqojRmmBGHAEvuhDl2N1geEVcKUZ5gzp+xMFaFbjYu/qzS69bSer0t4j7fXRygnC+q
	/PxD2uAslydyKdLkSTw3XosVw3UL8sFWHsK2poLHppQ/mokDU0Wiofoom73LBUi3wnqR5B3xAH7
	pZ5wFtuRxXUcfUFhDYyBuffBh1dciGr+Hio1CCvktzB0hSJturA/FRZG+IZPY4gu2MnXku06+Qj
	DxRCJinBxZkkLwfgoTpVy3j9ceyAjRr8QDcpHGJSX6ffC6ucrIhtIW80nQJPwMEKD0LW6B9wZLI
	rAE3pucKFK3eV5s1O7X/i7upLdk+sfy9bM3V0LcOg9ybsNo/hFimjPMceI639RMVUEpTM4fIHZr
	fR1XNsah2eiO2SgF+muynTxlm436BtPl8e77xQy3JR2fkSoR0isjcjh+tn41uAanE=
X-Received: by 2002:a05:600c:a10c:b0:488:b239:77ec with SMTP id 5b1f17b1804b1-48e51f40271mr55471775e9.17.1778084504622;
        Wed, 06 May 2026 09:21:44 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5409:94a2:bd3e:6c21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960811sm14318822f8f.27.2026.05.06.09.21.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:21:43 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 3/6] publish-artefacts: Drop build appliance images from releases
Date: Wed,  6 May 2026 17:21:34 +0100
Message-ID: <20260506162137.4180049-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506162137.4180049-1-richard.purdie@linuxfoundation.org>
References: <20260506162137.4180049-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 16:21:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3924

We are currenty publishing a lot of release artefacts which we suspect nobody ever
uses. Drop the build appliance images since we don't have evidence it is being used
by anyone. Someone would generate a customised version if they were to use it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/publish-artefacts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/publish-artefacts b/scripts/publish-artefacts
index 4a1e1b1..ddf6765 100755
--- a/scripts/publish-artefacts
+++ b/scripts/publish-artefacts
@@ -32,10 +32,6 @@ case "$target" in
 esac
 
 case "$target" in
-    "build-appliance")
-        mkdir -p $DEST/build-appliance
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemux86-64/*.zip $DEST/build-appliance
-        ;;
     "buildtools")
         mkdir -p $DEST/buildtools
         mkdir -p $DEST/toolchain/i686

