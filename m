Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D356F3D614
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 17:11:28 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33271.1774804286259742146
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 29 Mar 2026 10:11:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=FqwzKZEq;
 spf=pass (domain: qbee.io, ip: 209.85.167.49, mailfrom: piotr@qbee.io)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a27b5ad832so4249397e87.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 29 Mar 2026 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1774804284; x=1775409084; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHwRipdYL4xXPDESTg02wk/YuzgzJcuSsn7mxTk12ag=;
        b=FqwzKZEqH9Y04LCBDVDQZKcayLTKCzI3JavvSF1a9ZCZ8wpaKTxDe1fys+g55YKZoV
         vGetz4+8mQ1EEyXvUuAwDJKSBIxPoqPjYr+zM8uPQVsQuSaHNWUmUobvw6YklRlW1llc
         BXZIIklcLuiDhN7OZgmjbt2D2o8uyD46tfDwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774804284; x=1775409084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHwRipdYL4xXPDESTg02wk/YuzgzJcuSsn7mxTk12ag=;
        b=DRULcUvUgHsX58gye0LqCQ5TBIqJRH9LoYv/dOHMctgv9deL6x1RnIOXToxajyPI7Y
         k+CXJug7DQvKD3WkGUIqeXb1+dBeH0wPbMi6UwM+Kmd087rwPGoY+0LIR6fZrE12tfyh
         bUcBzkmhuOS4jPaAKg2EzokFLWOgxhXwG0TlJ+mQYXdsVC76xNaU7kF1SggLjwTv+1D6
         hW4ZEBicGqQD8ponh25l9OfrsMslbVtwe7/KreecRl6g8kdRhCLBz+tvWHNoUsXYhuN7
         j9NB6a9XO1lmxmB+m8u2ib72J+1UglRWsCgb4zqJW5+IiRx0qu8jt0F6Tmzy4SsgvPzk
         Pz1g==
X-Gm-Message-State: AOJu0YyQP/KhNXBSCeQZWlE9Qv/mCryiMp+5i7h93VGfNcdYI6644+Ba
	rZu1LO+tZNeAtzxRBo+s2lKrWPUjDyi40EqpbVCuJ1DXNIeYSaUgHrB/XDVuN6P6ugjhKoJ2iKD
	i0eE20jbZ1w==
X-Gm-Gg: ATEYQzyhu3yq+P/rcNn2/iVGEjchHSQjzFZbC3RYwnamWbmGu0/hx3AdNVUm7khiF6o
	CJFQQtv9TEfRjg9XCKA0k/kJJ2QA9l7TxKJvg/+CbIvzolyO4KLojDfeImZkNbKje6fBde7erbV
	7H8Q2Hw0hARVCs4a3OjNIrH6tMWv7rv0HeywqajdJk9Yg5pAY27jmKIuak5GxJ7X/dE2zK4gACC
	yE65n0qEt4T5vqxY5k3i13jIn3cXB66Vv9+zbMp1eTnB0gzj1fLcnn1g3f6PDvkD5Bd/ZnlS8r9
	uwX/wtmoeGxKC3jCG3chOFRcQdWwSx1HZIDEryqDdPoUp4Mg6ZcoKMqu2PrT8LSxRm0a85Dm4JN
	uw7q2Zo6mXPyYFdDhBgdWrf0iVtE7atrqrR9/toeaFlX+bGguu5cYuLkMI+fD8pLVr37rug/QUn
	lmiJ7Cln7uwVZxtwx/cJRlPb+irhdjDyqgrUvK4I5/eZpPVgK97h+1
X-Received: by 2002:a05:6512:1381:b0:5a1:448b:317b with SMTP id 2adb3069b0e04-5a2ab934c4amr4109550e87.42.1774804284163;
        Sun, 29 Mar 2026 10:11:24 -0700 (PDT)
Received: from localhost (80.89-10-247.nextgentel.com. [89.10.247.80])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5a2b144f25csm1165029e87.58.2026.03.29.10.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 10:11:23 -0700 (PDT)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH 3/3] Update Django from 4.2 LTS to 5.2 LTS
Date: Sun, 29 Mar 2026 19:11:09 +0200
Message-ID: <20260329171109.34764-3-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260329171109.34764-1-piotr@qbee.io>
References: <20260329171109.34764-1-piotr@qbee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 29 Mar 2026 17:11:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3577

This change also updates other dependencies, to ensure compatibility with the new version of Django.

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 requirements.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/requirements.txt b/requirements.txt
index 767d4bc..0aea1f6 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -10,17 +10,17 @@ click-plugins==1.1.1
 click-repl==0.3.0
 confusable-homoglyphs==3.3.1
 diff-match-patch==20230430
-Django>=4.2.28,<4.3
+Django>=5.2,<5.3
 django-appconf==1.0.6
-django-axes==6.5.1
+django-axes==7.1.0
 django-cors-headers==4.4.0
 django-ipware==7.0.1
 django-ranged-response==0.2.0
-django-registration==3.4
+django-registration==5.2.1
 django-reversion==5.1.0
 django-reversion-compare==0.17.0
 django-simple-captcha==0.6.3
-djangorestframework==3.15.2
+djangorestframework==3.16.1
 gitdb==4.0.11
 GitPython==3.1.43
 kombu==5.4.0

