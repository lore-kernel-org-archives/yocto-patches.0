Return-Path: <emailaddress.ashish@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4B0C3ABBB
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 09:22:55 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.46121.1746436968236388905
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 02:22:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Cepf2SnT;
 spf=pass (domain: gmail.com, ip: 209.85.210.173, mailfrom: emailaddress.ashish@gmail.com)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73c17c770a7so5861914b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 02:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746436967; x=1747041767; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPCtOIhn/D8U4BVvlfV7hpWlYPOYFyCFv4cHsvumpbI=;
        b=Cepf2SnTI2hMCPnwi9WHujwn1OCCBtojf6NC8kpXjqFPGkcs1oI+J2zpH4kQ2lFelg
         ga0pOzScmFqPE1pcmuPFY+F9fjN3HGQcdrfXKtODHuyygJ6O2x6J0xc950boRMQVpHw6
         tcqKgzVYn18+MMcBfGmJnwrO+8IisH/CR2V1bGb3CNWjGubYQ0krNhW8OMOW9WDHvR48
         BSmyrE1wds8RxOgcCEUcPgDI2oOx9/otH/1B/lzL3Pf06Lt7Ws70VoDAQKIaE8+lkx7K
         gLg/VEUt7dQmv5HKnToWb566+6AAOuwkHrByn/oHZeiNhjBZSlODSMZ2juQt0Pa1jiMJ
         jneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436967; x=1747041767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPCtOIhn/D8U4BVvlfV7hpWlYPOYFyCFv4cHsvumpbI=;
        b=hwErKmEOr6s1wBNwQVPrh+1HhMT7W+uvmzbA2rz7Ei5zdzCndk7YjRdt8UfDggWvUQ
         OPLYqHZJRUhEBdxfu3TZn52T/+VZIaVsB/yTz0TSG4DjSMrXHG2jjRB+rrDBqxFa1fYs
         KIwONrxwimzF7YqPhQIFbX3bDC4id9SzJcPC3kZ+AachsSLJi1wfbl5BXj22aHPftPPG
         ZZ6QsMXJx9VBQw9CdcyHwsgarPIKRBbSJAN9XVCTJDX+3+9UTI1mMGvCYu33H944brkf
         +L9Z5nwnFqmm7j+108PzE6BppPcX0CB2mVKGE2DBjqGecA1615ceGISPmpP7hmKmXHYn
         dgUA==
X-Gm-Message-State: AOJu0YzORiwW4Q+PpHLwc5QSgXmWfwtxdhVyUdmgArm9TaU8Puip6ouB
	1e3Sqzhg4zR2asRupCvr5ZS1wA/A35hhGWftkQUFv6h5EDIu6nrecoW7XQ==
X-Gm-Gg: ASbGncuoqw1IwNgQXp45wpR3XL+nOWMKWkDVx2EDkxK51fYQa42u6q54aJyzFn4P7zL
	fmc+XjRXGTd/J7iNy4jSq/e7UzcbpjmJslp09MOQ1V/IDzYwModuoocs9w9h8M/uXlWRxLDlTP0
	VAyAm5P+tV3WEjXA7xVd+CEtnTbw+pZ0IugkX6JALBLdBTUdykWdqXwfOWPFxKJKWl5DQd+CY8Y
	vQoGiak/csKqZrrrZ14vPwX5sqBAjGebb3Jw9WM/1w9hSAV/gVz4NgKEiCPYiDo2ilnlKFrHxwq
	kIXdNDN16YlbRKMVg0sxbi9qluTbLuKf6SyifdnFid7m+oZnme+j3DN66nAqU/I=
X-Google-Smtp-Source: AGHT+IEM3yKhJMt43/MUoTWAEWk+vL8Bd8I1DhrlfKxnzUMfIuu3G/rRcg0YF/3T+G9oYLb5Nhu19A==
X-Received: by 2002:a05:6a00:3486:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-7406f1881b2mr8578298b3a.15.1746436967233;
        Mon, 05 May 2025 02:22:47 -0700 (PDT)
Received: from MVIN00210.. ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm6487611b3a.98.2025.05.05.02.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:22:46 -0700 (PDT)
From: Ashish Mishra <emailaddress.ashish@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Ashish Mishra <emailaddress.ashish@gmail.com>
Subject: [meta-java][PATCH 1/4] Updates the SRC_URI for xalan-j recipe
Date: Mon,  5 May 2025 14:52:35 +0530
Message-ID: <20250505092238.853811-2-emailaddress.ashish@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505092238.853811-1-emailaddress.ashish@gmail.com>
References: <20250505092238.853811-1-emailaddress.ashish@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 09:22:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1493

Signed-off-by: Ashish Mishra <emailaddress.ashish@gmail.com>
---
 recipes-core/xalan-j/xalan-j_2.7.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/xalan-j/xalan-j_2.7.1.bb b/recipes-core/xalan-j/xalan-j_2.7.1.bb
index 5e72a34..a1f4ea2 100644
--- a/recipes-core/xalan-j/xalan-j_2.7.1.bb
+++ b/recipes-core/xalan-j/xalan-j_2.7.1.bb
@@ -12,7 +12,7 @@ PR = "r2"
 DEPENDS = "xerces-j regexp jlex cup jaxp1.3 bcel"
 
 SRC_URI = "\
-	http://archive.apache.org/dist/xml/${BPN}/${BPN}_2_7_1-src.tar.gz;name=archive \
+	https://archive.apache.org/dist/xml/xalan-j/source/${BPN}_2_7_1-src.tar.gz;name=archive \
 	https://dlcdn.apache.org/commons/bsf/source/bsf-src-2.4.0.tar.gz;name=bsf \
 	"
 

