Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44DFCCFA18
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:21:50 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13201.1762633310123842619
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:21:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mAIa9mTX;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47728f914a4so10755275e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762633308; x=1763238108; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VyEXchpZcXqjMLpzovmozQetXAo4os/uZXiinxHc6y0=;
        b=mAIa9mTXr5XEUoVIOjhaf9+a+ES0/Fe1nvP5VRcfcEi85SRx7xgs3C6ezm40IVj4T1
         z6oj0RYiWu5IsTRrkrGVqXC/JXsEGblzCglWPmXB/TbfSniarIucSO+DDhOHtdQkN6Ls
         F4TNUfUIwdLUlNd3iTYyydxmPFGdNQyvmTPbLYK0eF8tvuNOQ9FzKcjEdFvIOMY+iZm1
         mWCmAOMLKAR8h4cSy/2cj/hQTb11Z5Ms9vgYwQRRNQnwpr64R5nOxY6BolgA/laEWHpa
         rwU7GOxxbIcunVDeHArLmmgsbdnY1IUkmHZv58Wel/uUscuGkOeSPf6IFsz4UovaMT/E
         rywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633308; x=1763238108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyEXchpZcXqjMLpzovmozQetXAo4os/uZXiinxHc6y0=;
        b=DJvf0O9oKhKJfvRGdoyadijC8nHyEMbJTjfdN3sbEmtx/N7ENO8abHDUoKtvGbhayT
         L/oBVSz9zJ4yLaGP+q1b7T2hLZQ6tzy5nLJoj2dnvRmqBSenamFlPgP8XfcmxAw1EJvo
         GBZYiviirenLxm0Dsgia3O3TC+PX9CRmVTL3JbP3tQmWSXz68sK6C12WQV4cUsYASTC7
         mDh1dmEMc9MXEME+LE/bsin1cBkvo3i+k5ghxy4YlHAkq2siLLo5UafkaSe9Du02GA2v
         tJedqiK1kBd7OoWSPMBNZnLk70iPwVcgVTat2s9rXxp4DNJaPQMavlPsfN/Di5eNY3Td
         qa6w==
X-Gm-Message-State: AOJu0Yz4GzAp9IhPqOYOhcpIbtA62qGLwkFxsPSg46MxbvF2xa8jZS0L
	f1m7GNzwmQfdOO3ycpmXhvLi+dpWgK6H8VhnweNqNrNINh/knSs45bWLUeTWQGNF
X-Gm-Gg: ASbGnctsVJTYiebRIdyFlN1X0GTWV91cOlcSe8J766L9+9g994LXj82RDyu5q0ucRRf
	neSJcnS6+gx3C1Lc+du8PkEMF8Nxl6mvMlI+0Dga3kGJQvlBxkYV3p124tFPKx5D9TPqONhli0X
	hYGL0XLRsD8Zp8VGL5zrJqClODqKsClRTvdrVq4bv4UdVD0TLAIJLuj+TxUezqU9fH2i6l2Di97
	qjBKeB6v9dDol3vd6L9NP0wvcgdiVTYdB+a9kWxOBNNMwizah7l2J6ul5IFkRB5EZya/qYazBlo
	pRmAHZGE4bNrbIg25SXMxNLPElofaNu4D9IMBaqtupKEYDT3Yf50vGT8tCh3frrh4ZY+LBbky4c
	iv2OVtZUF4p3rX7gJLS2EMk2kaE5N0LJpXhFv3D9mAD7gCrcQHwHnrC1Nn3C9EEo2maq9yxwIio
	aNKYAC
X-Google-Smtp-Source: AGHT+IGC+M0M6c2Q4o7kR1PAYbm0NtMjNad/y0ZzVLtMpQmVF4b4p0sqEXv9RJ0bzq5XR6XNDJZzSQ==
X-Received: by 2002:a05:600c:6055:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-4777327b50bmr24334365e9.23.1762633308157;
        Sat, 08 Nov 2025 12:21:48 -0800 (PST)
Received: from osama.. ([156.223.140.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777838199bsm16467595e9.9.2025.11.08.12.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:21:47 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] poky: fix typo in README
Date: Sat,  8 Nov 2025 22:21:43 +0200
Message-ID: <20251108202143.13272-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:21:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2459

ut meant -> it meant

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 84f3937d1f..7cf111ed14 100644
--- a/README
+++ b/README
@@ -50,7 +50,7 @@ developing layers, we made the artificial "poky" repository construct
 as a way to let people easily and quickly get started with the project.
 without cloning and managing multiple repositories. Layers were a new
 idea with lots of rough edges. kas didn't exist, I think repo was only
-just created and it was a different world. For us, ut meant hacking up
+just created and it was a different world. For us, it meant hacking up
 a quick tool, "combo-layer" and it was really a temporary solution to
 fill a gap and it was at least as functional as repo of the era. It was
 assumed we'd work it out properly in the future.
-- 
2.43.0


