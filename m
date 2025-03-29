Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537EFC36008
	for <webhook@archiver.kernel.org>; Sat, 29 Mar 2025 19:21:18 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.web10.17310.1743276077522920059
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 29 Mar 2025 12:21:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lOdF5DU/;
 spf=pass (domain: gmail.com, ip: 209.85.128.178, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6febf391132so31357787b3.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 29 Mar 2025 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743276076; x=1743880876; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zoy9j3AwYwYCWAhGtEV8yN+EmOPMa2moZVye+e0qmpM=;
        b=lOdF5DU/G0/GCG7PXFm5UKrPViqTSLOWehSw0dC/2K2h8hLcR72iOpXgddbyUZ5Y6P
         EtnlZEvntsemBv3jNLkwsSafXDE+p5u1/UybHhfoXlLDuLDTKOF/kJrfjStpdEE7AyL+
         uGjuaU4xtYiFhRA9f4gJRG5TQFYLHzM6FAKG2Pz/VdDnD17upBylQc+aDNbLnzOmM+eb
         FqAbBjqzimQlOS7Sw+quS/q5tdRfp3VwYPPnprQrV16lVMi0xW1LMxDljGj6927vSgRK
         BmQ7IlpffecW7DOoSKNyZ8c5UwIThyaqY7eyrph1c0OpupDyDyTYbKyQraZ6xJElsAD9
         0xlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743276076; x=1743880876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zoy9j3AwYwYCWAhGtEV8yN+EmOPMa2moZVye+e0qmpM=;
        b=NVNC7VMlypBSOKTT15waKoSDQNqrPS9GFwNaJd4nNChCkPRmxLMMnxpmvhiuItnqeb
         z03IaJhK8KOcX9mIF0DNUKRkhgy541KOxCwk5kB0suM7hP47hxbspNGn+k1Bi0vSrxz5
         jfuAtrkOqN5CP4oPPADS01pwt5urrmYsr/jCCvfxHoNhoBqoTdINIb3rKcsTkzXAq4qs
         A3uvcI++I63sIFA8TQVhtr4+F2WgdoYW3HKc2Nk88JQfe6u3MmliwcPHnHXb8kwwJcaj
         1y68NXorb8W99kX7M5sO9L/LbBKqkV2DndMv8rLir6XAJjkqjeoKwyBlUbT4fyiQi4//
         aZvA==
X-Gm-Message-State: AOJu0Yx/o1phWe664OpA3NmzfJepy+kogUtEbSTj+KHw1c/01xr+rrYo
	IcE9i1AtIdOuCe17FBEwz1BW+tcd0692mCikLtq7JAdd8CHXADq/0OVMbQwl
X-Gm-Gg: ASbGncv9Vz+TJ5rPpB5VMkFDuEiPQelzWpKnapGNfFEBaZNwVuSo0FcBk4N3NbWUUqk
	r+6IX8yB2tb0v0yR2J3SIKkkvfLHnzP2WrZyQ+jluUXGHJeX9Fv/+fqnkx9SNEWJn4Nh5OspBRV
	3Uonnez6Ee3KxD+M/lF8sBP2OwBU3fSpp/4qiCbX2sIBTirCZ+I6qiRg7W3gIUptBRWW3wXg2HZ
	JXGCBIBob7LjULSC06lYihl6o8ZdwcVIJEdBS4kKKRpP9sho7NQqUlbxmjH/b3mYA8Hf7AH6rfI
	Jpr56/12Nh7Fqtu6j+zXQCGbht50MsXy6SxJpfhNW1GIbkyeRXxQG9v6efY=
X-Google-Smtp-Source: AGHT+IFOFHxYIFIVDIRf9MvK8j+s7Mj/lWL9l+DNgK4eWpa2caua6j9GnKWKDPbT4FCQtFbQxrnFnA==
X-Received: by 2002:a05:690c:4905:b0:6f9:ad48:a3c7 with SMTP id 00721157ae682-702570fc50bmr52467427b3.21.1743276076525;
        Sat, 29 Mar 2025 12:21:16 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:e1a8:da73:9f2c:90fb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7023a3c6d35sm13456047b3.53.2025.03.29.12.21.16
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 12:21:16 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] layer.conf: Update to walnascar (5.2) layer/release series
Date: Sat, 29 Mar 2025 15:21:15 -0400
Message-ID: <20250329192115.875857-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 29 Mar 2025 19:21:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1272

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-hardening/conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-hardening/conf/layer.conf b/meta-hardening/conf/layer.conf
index f5db751..a7e32e5 100644
--- a/meta-hardening/conf/layer.conf
+++ b/meta-hardening/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "harden-layer"
 BBFILE_PATTERN_harden-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_harden-layer = "6"
 
-LAYERSERIES_COMPAT_harden-layer = "styhead"
+LAYERSERIES_COMPAT_harden-layer = "styhead walnascar"
 
 LAYERDEPENDS_harden-layer = "core openembedded-layer"
 
-- 
2.43.0


