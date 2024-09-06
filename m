Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B331E6FE2F
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 16:39:46 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web10.3553.1725640782751777717
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Sep 2024 09:39:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=euShrm7x;
 spf=pass (domain: gmail.com, ip: 209.85.208.41, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c3d209db94so1969110a12.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Sep 2024 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725640781; x=1726245581; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVR4qpJy5cT3+XR8uPiJQXUqSBf8mcOa9ZpF7QBdcB0=;
        b=euShrm7x0VVkQXUmrG6EkWRiyyO69/Eyi8T0jzqPiKoyWoMCMVMngp8gYy4RIGBfay
         VgdkOTeLuPeYbnJdsPq9M4KMr7guW1ORUeYBCEnHe5l4ib8Pf3yzXXGpwJPw0BH1j6Jm
         3l7ipdj3gkSQnwDLIRw6OpSaYi3x+YEzB3gCey6Ml8QtI1m1/TyPbetAvaiWKKJhvopW
         C9FHZzzk8hlingiPp3GbOqheFU3p3ZO5vdlJWWgmRaKvVemsKnmNaEGKY8hbACr38hwu
         J4Vz/w8KekGce0qKmBHfxeKlT8TkssePk/VK+CmUZ85br6xCoYA2zjjzMhQpQqGkr3g1
         JMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725640781; x=1726245581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVR4qpJy5cT3+XR8uPiJQXUqSBf8mcOa9ZpF7QBdcB0=;
        b=kc1aGWaV0gCeXX3KB778B2OCEPOXXMy9wbXPYR91DqOtOTSJpNENpYZHZbKvLNie9A
         +NbRsLxBLgnpk3HKRbMcXhpDnUVU3MWXdBAzePpzNGkUeICa7RZBfuKwxmTHLJY+PtW1
         wr5iBOzS2q5nK4Jl4W7175EyRv0/MJgh+JTkkx+FlcXv4vmEc23O3hgcec+RSHm4vXrd
         YrvOYzR0fE3K1g7yIuH4an1xYLthRdWq/WL34TJepTkyvMcdvk1L97pxE9F6Ns40QHne
         kRbUZQdspxIM6V40xUwwvZCFJh49enR94bNPc94lRXWx9WJ6qOuk0ZrKu36QKUwJIzac
         mC7A==
X-Gm-Message-State: AOJu0Yw2KuMfV9F4+chy8aYBUnGx/U41tF5Ex7QdaQVYReY44mWRenzr
	uMmBgN3DR15yYTmI0HWH4TCjIy2bCFt1EoNJc8VJHh/OvnzpIFYmOupTrA==
X-Google-Smtp-Source: AGHT+IFRg8l1XbRRTOSrma7jlvcjucpFkTyQX5mPjqWiFtKRUhG5c5NnmN0gO+VgGaX9iGq81FfKvQ==
X-Received: by 2002:a05:6402:50d0:b0:5c2:4ad9:6d9f with SMTP id 4fb4d7f45d1cf-5c24ad97198mr15722536a12.1.1725640780313;
        Fri, 06 Sep 2024 09:39:40 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc56a876sm2590517a12.51.2024.09.06.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:39:39 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-security][PATCH] layer.conf: Update to styhead release name series
Date: Fri,  6 Sep 2024 18:39:30 +0200
Message-ID: <20240906163930.3167870-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Sep 2024 16:39:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/615

oe-core switched to styhead only in:
https://git.openembedded.org/openembedded-core/commit/?h=styhead&id=b4cf6d5236a3eacaf56ca2f805b006efac65b26c

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 471674c..c57c8b9 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
 BBFILE_PATTERN_security = "^${LAYERDIR}/"
 BBFILE_PRIORITY_security = "8"
 
-LAYERSERIES_COMPAT_security = "nanbield scarthgap"
+LAYERSERIES_COMPAT_security = "styhead"
 
 LAYERDEPENDS_security = "core openembedded-layer"
 
-- 
2.46.0


