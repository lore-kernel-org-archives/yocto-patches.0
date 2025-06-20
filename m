Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBC6C7115D
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 12:08:17 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.6259.1750421295878461049
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Jun 2025 05:08:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SzLkuxZA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so1149165f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750421294; x=1751026094; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QZmiITgpnomGTL3i11lYTqNTgEonVsQXyiJ4XSvrss=;
        b=SzLkuxZAyxQGcLstmGZpRzYNept+BgFQioN1KXGtNtMMlU+/bkH21DqFD3Z20AV/Ab
         4dnyeBhcrYqN6Vzpnv0YXHK0pKq5UKiZKyKR21wsiUIBRDKSSyXi+S1yc3Ig2wPLIYsl
         LIpYPIA4TbQ8NfQQehMNaOcREFGqQWI1GM/UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750421294; x=1751026094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QZmiITgpnomGTL3i11lYTqNTgEonVsQXyiJ4XSvrss=;
        b=rmHXqEEyUgK6j3p/389GRDzHtYKUeYfcyRiuoNjVEqwN2YnuUrlekPcZjp5Ox9M1Iv
         ZKo2fe67s44khXxHtPj44TLY/taK9gksvoSdPY4mttxtoNNvSvxOUl7l7dnkqxKbFxbZ
         jjcrK7Ij5tBJs9akKBr1lMdq0xuDDjCDqC9uGr+h+kcJdE6620jjhhL0DsntUZjSyP8Y
         lkiX9xINaSy4QsvTpF2KZkyiGS+fwPm6G4YOgoERZRu1Wiu/rSJwnjpat4Mr0fsAQ+Oc
         7LKdG4xKJsiDS+mDdpHyUT93dQrQ4PtWTpUQHAh78Q3l/gO52TzdOuWqayHQycxMtEoj
         VOLQ==
X-Gm-Message-State: AOJu0Yw1Y8irAw2f2CW46wxy8NLOuMM9vyoQ4YEn+TMGd1z4Kkp122Z2
	0KSkyL6irIfBPDjbRY9/QWqwwNdWIGd5ZTbIwDYQsSWDi+gazRF2w4ew4Aqo7p7G7w6ctxolnWr
	YBdYiX1I=
X-Gm-Gg: ASbGncvgdQ8qGEp76nr/Bk6l2ByRRP0AIJQu2ya5+mu3cD7SZJmYo6MS/wiF1aHnNSf
	nSR9UoMcFCzb6trxzHlJbF+Oz/nfpt3wuJZcke+IjbpD/Ykth7sqcO6S02jonEZouexessgQ9q6
	e7Jy4dn+e6K7ciAjgAKlV/j864Ax1KIJ7xPDBPMHC+ltjQLwpobu2NWpZX++2NDPbCK0EXANDRt
	k3DlPPanfyu+dtXLSDYNuqUta35gUcwuPKDbLoCKR4NOXmfEuS5AHZsKQLK/dowEQYBZyHCCIET
	FQQlPru5Qc+RfUxrkJW13Q5MsvXPIkabyIdluPl9NmnOK7yJ8aCi+Chzntz16/m7GeGeVJj9x6P
	kyJmy1HARLKXDJS+SnprLcVsNVA==
X-Google-Smtp-Source: AGHT+IFCFHk52l87nybucwXbA2A++pg5R4FFaD9ak0gl/9D8MqHxQyb0Rrjot7kt4bLck71BORSh0g==
X-Received: by 2002:a05:6000:270e:b0:3a3:67bb:8f46 with SMTP id ffacd0b85a97d-3a6d12ed87bmr1498628f8f.57.1750421293876;
        Fri, 20 Jun 2025 05:08:13 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b606:370e:6752:7b3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f104d4sm1939656f8f.11.2025.06.20.05.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 05:08:13 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH 2/2] layer.conf: Update to whinlatter release series
Date: Fri, 20 Jun 2025 13:08:10 +0100
Message-ID: <20250620120810.2480232-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250620120810.2480232-1-richard.purdie@linuxfoundation.org>
References: <20250620120810.2480232-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 12:08:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1671

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 9fb0473..0a00dd3 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -16,5 +16,5 @@ addpylib ${LAYERDIR}/lib oeqa
 
 LAYERDEPENDS_meta-mingw = "core"
 
-LAYERSERIES_COMPAT_meta-mingw = "walnascar"
+LAYERSERIES_COMPAT_meta-mingw = "whimlatter"
 

