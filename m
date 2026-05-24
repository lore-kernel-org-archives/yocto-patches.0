Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBA3CD5BC9
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:28:17 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7243.1779625695870377593
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:28:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XvF6jrCD;
 spf=pass (domain: konsulko.com, ip: 209.85.222.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-911dfc86903so1030318885a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779625695; x=1780230495; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFYuBZSSoac4B53nRAocpozjYp/LOBBoLX5+1ZSzMV8=;
        b=XvF6jrCDH4GkY+q06KfpWZ6WTcR6wRueWzEIwmjcYf+EDsniWlwbEBihIVIi7m3vEk
         JiDV/FaNDcx8wPah00DR2BRuA+B7ZTijsuHESzYJMv4WePEcJbJsAjJmsOGTwAlzpg0F
         XZ9/pGa9RqKUS80Sd4ixyYwBuZ6JZws12+W4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625695; x=1780230495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HFYuBZSSoac4B53nRAocpozjYp/LOBBoLX5+1ZSzMV8=;
        b=njQXBHr49Y5hO3rYa+GiL3iazbnA9mbx0SBVupz9dHEH8DPyjX2cRoiwzGflu3wnw5
         Z84AxNC7euSgEOkUrH+YlIsytNILB2qb8orpb01oHqoE2AfZr7mO8Ja1aFN2QlZoLsYy
         oekr6dNnJ38iEwZjUWaGPedFtmDgaPeufSgvlmeMPJD38zZFruO+pjbujaH9eJVDYiPi
         iy1DAJzZXD1hteNxEpR4hc44vpS2OCg+3uhAtZ5r7xwdej+HJFG4sfCZsMWB2LxKRSc5
         5beQ3+jr/CsgeCKKmEfljZE3JuTu6K+5uvcn2x3jBGqGqZiyFqx+OUN8C4+bGyp7QtXB
         FYug==
X-Gm-Message-State: AOJu0YyWDCcduywSr5daOJ8YqltWuGuA36cDhXD2boJg6b/J7nzP5VO3
	XK17Ni2LEpMkvottDPnnD5vwazRj9N8DVOP2nxR8jQ26AvRBx8pc4wyuHZW2thDwOlfjtYkbN0+
	rtyBW
X-Gm-Gg: Acq92OH6rSHCc3SbINdYAlpjkc6A6kHZfMstbQ0c5zAgxe75/iy97lYuI/t3DplG4kx
	zy9suoAfKWc4Wv+xECh5Be4vbv+TAm9KJRiRA86ADviAjJyNFj7UDbWTWvMRa7DA2JwOMWLgH/f
	AIYF2yCFH/xTr6oaBOqFM1unsI2K2X9Z+STLmswI4W3yt7MdEPzEVofX5gqS1a8rrVZ3sM3RtIA
	3LETOfgJnE4wjpzVZGHb3g2ApZsMMKEg0P5skaTLDHGEsitHyTcmD7juGm8mzxSDM6ba3wJ0m49
	469MR2eHa9/ytYnCog/znBXHHq7RlujLlXt+m8Xgpfvvc65eDrRBFhFqfynpQqeTaTTIwKnHP5E
	sbh7zVfIl306YxJQwIC8kFe9ZTKU83KY86QXHzgoQC5B2wFj5+zb4dQJdRXqtOMzWbzJ9ne+mCi
	6uiPDoJ1yJ0CAI17ETUiA3b89QX0tF0DnI71mywy7XSaWnAqnvTG8Ext8JzEcvDwFa6LhPU8IYQ
	0uOF+eiwqDtUOKaP/P8od2TARR198Cjx4gqTCAPCXvAfCiEIzuaN/jyrPBjfQd/
X-Received: by 2002:a05:620a:25cc:b0:914:99f3:d314 with SMTP id af79cd13be357-914b499e2bfmr1545392085a.39.1779625694735;
        Sun, 24 May 2026 05:28:14 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm751989385a.7.2026.05.24.05.28.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:14 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 08/13] parsec-service: update TS group name
Date: Sun, 24 May 2026 08:27:57 -0400
Message-ID: <8d6cbaceb3fd51b5f9ea74a1ba7f541ad6e8a5d6.1779625557.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779625557.git.scott.murray@konsulko.com>
References: <cover.1779625557.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:28:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4028

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


