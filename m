Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20971.1792669657504948705
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Oct 2026 04:47:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KmoCvO6i;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2074a66beso4500175e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792669655; x=1793274455; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nuq25pt394lRBxtOp+uzdFFFCkeM8vVkT8nT9SlbgEI=;
        b=KmoCvO6i3Z7LXBUpREoJYOo2vpth2cvlyhvlB7br7Q7wjcI8Af08z5mblNn7fH86ZC
         fSy1JMNPL7OCzH70Cjsd8hAsrfn41+WFNL/qAspMmeOPolPXTZVHb5bf9Zu83mpzJkrn
         U9BYbuZtJu4Fbp7LY2iIDdrRYCuWFJ2pt/qyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792669655; x=1793274455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nuq25pt394lRBxtOp+uzdFFFCkeM8vVkT8nT9SlbgEI=;
        b=BITouBz7Dp3YDpdEL29EiDosQCx9NDeD+k/89Hx3gaVVTFAWH0xP1BEvCQIckLJyJA
         pGwNUWofqZLB62HLkr6ynatHi56qHYN2z/WWkWVTa+oMwYW846RVOt9TpNydGUW6hMy7
         T6XbNAz89N99Ct4SY2tDtjTxqvFDBQG4S9mqlbzcLBrMzje6W0FezjIEDfy2UyFzG6Sq
         nYFL3InhpuY888jF2YSvQjkxsC6Ph2DhWm472bEHIaLKfrbpT1d2JQNU+RW4aUkhLRXw
         vjwGDpGt+B5HHK/KSt2u6SqrOh/76dS9valwFcyJggbA7wTWe3mIu2F2hhl2RQYTSqTI
         QP/g==
X-Gm-Message-State: AFq9FYIls8u0EAlD50ikuRe5Kl1ltoOLU7tOgNlrJ4Ff7OE25rthqcYB
	sxdLsF4Ynqp82S2gtSciKG00ReJgJH4tFTVgF9mvkhqPBwVhe7ni/NSh2CtBy+z6Opge8DKMLdm
	gh6JQYRQ=
X-Gm-Gg: AYBFou1+zraCFRljqpOCnywEdDS3EgKV1wo8SDiSqy+X1ER2OiYGEmLnlESNDxZQ1qz
	Hpm/IZ0ePgKCkDcbcC17bzbRrlbKQ7oT2ykI62HNMXBH9TAfT8pz9516QWccGhfYiPbmnbj4mJi
	PVmiKFIgwmNU4BIVk7qzK+fFuh5GSWSRKE78WurgEHN6+VlM77soQI4LwSfKzz69R/Zx6Jx6PsO
	HqyU+T7p3CYujr+VjwBEifQ9z/2EiEQXZBjps7o9G3dtbfX8RCn8kquSIJy+0WLpb+1ppr+uuew
	BYtc/iv2C5CVMrFKwIvfOmyiFUKSEOSI0rf9/Up5EtOgI5eypO4pwMSPsI1mxKqfx20BhkxPwLr
	F5keqLQnewhJIYxdLlLKZziXrX7NnUUzBN8X9EQDaJoDf12U7SiQ/Dg07QesdNEjbG9P4PK7yBf
	f2ey6RhfhF+cpRlSVcrnUG7r7eMEntZjeZbxGSsx8RJmJKjw6P0o3t2wJoSo0hAFM+wk0U0UzUl
	D7xXlWzVdPr0XD2g8zCI38qhJMWk6MekbI5CNvH2NltR1NMp9CUdRQrvMeBzUCCanXKGwBoDVNU
	/fySfMtG
X-Received: by 2002:a05:600c:3b8d:b0:4a1:e271:2d53 with SMTP id 5b1f17b1804b1-4a1fd8a412amr111849705e9.3.1792669655552;
        Thu, 22 Oct 2026 04:47:35 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b8c1:c201:8aca:1e39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25827087sm11743499f8f.21.2026.10.22.04.47.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:47:34 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH v2 1/2] config: Add meta-ti target
Date: Thu, 22 Oct 2026 12:47:32 +0100
Message-ID: <20261022114733.3551925-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 11:47:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5133
Content-Type: text/plain; charset="utf-8"

This has a dependency on meta-arm.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.py b/config.py
index 3a36e723..89597a86 100644
--- a/config.py
+++ b/config.py
@@ -20,6 +20,7 @@ buildertorepos = {
     "meta-aws": baserepos + ["meta-aws", "meta-openembedded"],
     "meta-qcom": baserepos + ["meta-qcom", "mixin-wrynose-linux-firmware"],
     "meta-clang": baserepos + ["meta-clang"],
+    "meta-ti": baserepos + ["meta-arm", "meta-ti"],
     "buildtools-docs": baserepos + ["meta-openembedded"],
     "qemuarm-oecore": ["oecore", "bitbake"],
     "checkuri": baserepos,
@@ -165,6 +166,7 @@ builders_others = [
     "non-gpl3",
     "meta-webosose",
     "meta-qcom",
+    "meta-ti",
     "vcontainer-tarball",
     "vcontainer-tests",
     "containers-library",
@@ -308,6 +310,7 @@ builder_tags = {
     "meta-agl-core": ["layers"],
     "meta-virt": ["layers"],
     "meta-qcom": ["layers"],
+    "meta-ti": ["layers"],
 
     "musl-qemux86": ["musl"],
     "musl-qemux86-64": ["musl"],
