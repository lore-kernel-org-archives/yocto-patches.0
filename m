Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99217CD5BC7
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:16:04 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7104.1779624963147681974
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:16:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bBmd+0Jg;
 spf=pass (domain: konsulko.com, ip: 209.85.160.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e5c7eb565so95893101cf.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779624962; x=1780229762; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFYuBZSSoac4B53nRAocpozjYp/LOBBoLX5+1ZSzMV8=;
        b=bBmd+0JgozafhldN+i/S2o4owSQl5Xv3kYt8wrZXdJmjplWc+rkfxGcNOqPyS0j1p+
         of9vwS6989oGiL9JzUcWjUicBDb8pJHW4kR/sjfHVnuhq55XGvQF2jjF/Js1pLGBTF73
         2HQTZb/phWOh6AOr++Z31BKfZGLZKvR74y/ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779624962; x=1780229762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HFYuBZSSoac4B53nRAocpozjYp/LOBBoLX5+1ZSzMV8=;
        b=QC8xBEuhGy2zMvlxt4CpNqlpWsJa2BlOwVCTfm1Zy2v9A3bL48TRiUTUJve0tUyqOp
         T9T5DsNSPWlfhfI7n2bVUdpRJEcoHntSMMAKxYXIMaZ8H7Dti6QQjFDDbPxK221DX2e3
         NytIQCU6rk4xisQGxHiACJ2ZGmaA5q0guYo2y77vstKozNDG9X2jgdgq1pKuKCpaf79u
         dZl7CWOAFbv1bAk9+BG0Of/rItt1l4HQmh44Ct1sw88V/oGHjtZ7aH3DnI2dZJ2PzDAt
         m1MH5j9hvM6kOf23pj966fcoHM0EJpJ+tHZqs691TuZBgwGkFm6uHrJ9/VYi33KRfJVi
         waow==
X-Gm-Message-State: AOJu0YwM7loKuvDqIpDXnRNfbpXSYBifdYfF3UxaGZygkBsqnRRapOTn
	HpZ/chjgVhKMfdp6JWEm8Q2j3ha17BNKgtHWkNgWl8OUiOsxAbuEmVW+EWazI7zMNbTaXHZdqxE
	A/WSJ
X-Gm-Gg: Acq92OFBTT0ea3kpXmW9WLbwyE0anZCn+06ehaKUzo/e222RU+aSPX8RlufaappKrib
	W0AB3CNGLHePM5nfPQlqmq3eDPzIJ+XgL3NXkhP7EbmWMjXnOisLyEjrKeJw+zC/oQw2On4AGQZ
	wmPHmnDNMc3BERzxbMIoppWoJ6KTmPtHKyYiRXM1FCrbGh+XPIwXl28Thbx6X6+b3p6U9GYpvNl
	bQlaBV+beCswTKraBXLs2WUC2ShPXn/U+7YfwT048+miMzUWJbTA6Ma7knJ6RTbg3eehFnv/JeA
	qfRNGvwpieC3AV1YbZQPaZYHHUQ/VtyjE3mJphZcHxdqFlG0mXydaTK/fwYz9j0gkWwwSlfEfuB
	Cvo2N8dA9CnOepQgbzbETEYKGr3xN53ceQWPfSu++J+JIGHR3U/n3GwG3rt8UZ+k8jcuLn/rzP3
	Qw+slgUTKsOyYWa1LYF0M3RYUVIvEVoHNzbhwJGz7F+wqAUSmZGou13U7B0otFLgEiBCnFNhn+4
	U6tGvEarro7qvD2ROguuYKghOGD581ll+pbIu1QW7mSIv1rrLVOA5Ayn1uQeA9H
X-Received: by 2002:ac8:594d:0:b0:516:e062:1a83 with SMTP id d75a77b69052e-516e0622067mr88132391cf.51.1779624961995;
        Sun, 24 May 2026 05:16:01 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm82385186d6.38.2026.05.24.05.16.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:16:01 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 08/13] parsec-service: update TS group name
Date: Sun, 24 May 2026 08:15:35 -0400
Message-ID: <921b75fa4aceaeeef388acdd1a3a8e35b5afc4cc.1779624335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779624335.git.scott.murray@konsulko.com>
References: <cover.1779624335.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:16:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4014

From: Ross Burton <ross.burton@arm.com>

meta-arm recently changed the group name that is used by TS[1], so update
the group name to match.

[1] meta-arm 595cb0f1a0 ("arm/trusted-services: fix udev management in libts")

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../recipes-parsec/parsec-service/parsec-service_1.5.0.bb       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
index 0268c0e..857a3c8 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
@@ -86,7 +86,7 @@ def parsec_groups(d):
     if "TPM" in config:
         groups.append("tss")
     if "TS" in config:
-        groups.append("teeclnt")
+        groups.append("tee")
     return "--groups " + ",".join(groups) if groups else ""
 
 FILES:${PN} += " \
-- 
2.53.0


