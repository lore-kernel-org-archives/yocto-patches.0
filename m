Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03EAC3DA4A
	for <webhook@archiver.kernel.org>; Sat, 10 Aug 2024 16:44:40 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.web11.9221.1723308273213944157
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 10 Aug 2024 09:44:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hxIia3r7;
 spf=pass (domain: gmail.com, ip: 209.85.128.174, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-64b417e1511so27810277b3.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 10 Aug 2024 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723308272; x=1723913072; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saZexmPfDuL0mXYcUNAi1EtvUDmuoDjC9whSibZjHlo=;
        b=hxIia3r7v9ojYF8BxdGk6CP+FFcgVBnnMJ0RxV0JPa2DtpJyTOBnnxV5NJ/GpTdN0J
         GkQkwP4tR8pOe0+qNyye3ET2iAzgyjgVAe+DrQYRxJ4GatnisPZh/rd00lDfFoQ0tkOQ
         8bgsyaWlyW4WiB0UNa6Rq8TJ/XPbPYNS+OmW8vfm5BaMGczCKJJ2Lw6XZxRP/ELPCNBH
         dh2n9Ap1snNxHXv7MvtbNrxCk00FFHE6dynlzkZ12EP19ye/9eTDUBB+2LEFj3pXYiXw
         v/+KbDfDzsg76l5ZFsBX4mAUzzCYjAzHojTm+bwF7fZk46q6m9jIZrA2dZWcfAAJ5m/b
         EMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723308272; x=1723913072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saZexmPfDuL0mXYcUNAi1EtvUDmuoDjC9whSibZjHlo=;
        b=Qhpvd1VNdefgjlbMXCKomaw/whg2/0c2JlapmvoQulwsQG/MsYkKEO9FERSvxJt7k3
         4Kcm3H7BBm0CQ+rRynth9xVxBpR1Zf5BWCbe1AvhPtl22VKYu/gJdIDUp5CGIO1hyspk
         3OvpUNr65jMC3X8VxOUInsnkb/2BPui+ZPToiZkvuTT80CkLeMKXHgG3YAOVWTUql3dJ
         S658+713t7OG7xGFY2RZAIdLgKFdP12q16aXpDHDBVGjCT8tCXiJtaOGe4jxhwmAxnWl
         j1Q/1Ec02YtiTPyB3DGIVgl0iC3t5BGmIorNRlMjpZlnRr7+QIwPgc04R/Snea8FYctz
         whEw==
X-Gm-Message-State: AOJu0YzoGymLKWvGUfTwNqXgGBK0ewlgCo/5D0huWcCscZdpY+A8NNX8
	+KiG0mkRAGCX7NGNbGiuQtuQ7mjzNmkHlGwa6z6rPvLPz1UbSd5G2YGg9Q==
X-Google-Smtp-Source: AGHT+IHKSVlODFR76enwCEtdPWantOB6eyMho6B7UHE7LW6Cn4284ShSraKmEuteZectFxF+5lmDnQ==
X-Received: by 2002:a05:690c:f93:b0:665:30bf:7752 with SMTP id 00721157ae682-69ec4b0e4eamr50564877b3.2.1723308272228;
        Sat, 10 Aug 2024 09:44:32 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:ad:eb2b:7538:7504])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a09f905c40sm3015517b3.20.2024.08.10.09.44.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 09:44:32 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/2] python3-tpm2-pyts: switch to PEP-517 build backend
Date: Sat, 10 Aug 2024 12:44:31 -0400
Message-Id: <20240810164431.902604-2-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810164431.902604-1-akuster808@gmail.com>
References: <20240810164431.902604-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 10 Aug 2024 16:44:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/518

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
index ae7dcfa..57e284b 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
@@ -7,9 +7,10 @@ PYPI_PACKAGE = "tpm2-pytss"
 
 SRC_URI[sha256sum] = "20071129379656f5f3c3bc16d364612672b147d81191fb4eb9f9ff9fbee48410"
 
-inherit autotools pkgconfig pypi setuptools3
+inherit autotools pkgconfig pypi python_setuptools_build_meta
 
 DEPENDS = " \
+    python3-setuptools-scm-native \
     python3-asn1crypto-native \
     python3-cryptography-native \
     python3-pkgconfig-native \
-- 
2.34.1


