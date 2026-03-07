Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5B0FC9EE9
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 10:30:25 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6730.1772879416791272149
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 02:30:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CUmCOwwA;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899e87b04d8so118710446d6.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 02:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1772879415; x=1773484215; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jly7b2QktzWCwokrfMQUZlY+djLML0IrYcPyuIeG4+s=;
        b=CUmCOwwAZK3nwIiXcqnCrAgKFC0llkX0/Q7q7YxYQwOIiXn2dnsWIEqjz45iZkWoan
         Za5tUPPCQ1dF1Ue+2MIOZ8ecSGz45A8VJ87EvDk208S5GRCxoeDu7No75Wbvlzwai8Ms
         KnvWzdVxnRewxvAYb5tXb7fLoLEPgL9UQ1sHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879415; x=1773484215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jly7b2QktzWCwokrfMQUZlY+djLML0IrYcPyuIeG4+s=;
        b=Uy3jmumwZGO/5MOh2wCf2sohZ+WnhtFpCTXj7s/gBmPluZHeOYC480tZe8Rrk3OgHF
         GabzT2wvH90tze/pPOR0YKdb0FJIMJwe59dph9E2PCQZ3vjjs4QV4VhlZ9SDMYHisrqt
         UAKSPFyheTqeUN/eS3V/HvXaauOBv2qd9mqVPgOZg/gyhKRSQt1hAz75bVDxAOaiOMha
         Lu3qNDxFU7OOAryWrGtfxZ8wmaNfXgdIRYsiMbVazv4jRM5TBVPOJujUikdjl9caR3u4
         kfoaoSUOC478Rxm7yGSo6wNX7SDqeeD9kQtzZqTZZcW3a/RLy3hrmiCgQqBoBpwsnBIL
         3R0g==
X-Gm-Message-State: AOJu0YyTBqbl7qJp+w9Sjgz+r/Xyp4OVluWNsVM+KTO0en0MvvvtRR27
	5bie8l8y3woO/k2EQv4K8g8RKwGqmldjlyhgr480OoUaWGCbJtCLe0bQrDW+xJ0UxLHOfJaggvA
	tO2JO17E=
X-Gm-Gg: ATEYQzyt2XQUdOlgfg2UkdpjmO8uk6Sains/6HIaC5o/uX8/egww0SWQS+sLxyR3JOH
	cxSW0fsfH4f+36w0dKXjD0U5pkZ1iz6IHexV5c5Z+y+2VwU5e9fKDiWcGtv0ZBpXUPyd+0bx7wN
	5KzTvOPawen598PMy1dZrE7G4AcvHwTNpl/4zY4LrLJm7wc3tG09d+RyjM7mWRDIZW+kjyvjQLg
	VBFSwKJMHAPKSz22Z0RAsHuoQ/1YwhLPcs2VkZ5w+XDLnOUk/UPFqdb50hT1M6mX7+M63MbI8Ny
	lH3yNrN+2F4TDjb4zRipFeGxebMMpu3Uw2bvuDVCATQ2AeXWbcrGBmc/pqR4OnbwcG8C164YPbA
	Vmtjm/LwvBEIkigkQPYmZdSbSGfEIIpRFyfY64VahGPg2qUubrXonIer64NWMY9j2nhnEBz0AU9
	uBKFdsC7t8sswWKvmn2xtEk4T2K0ke8zFo0J4BgMm1BCgOp4Msw668R4F7M+PBNGqEi+hZ+XIx0
	oJHbxQ1sfgbG4zH0IPfztNchovN6lrGilW54HPuObdNob+4Sg8wTvY++V2TQdX0
X-Received: by 2002:a05:6214:2a88:b0:899:fc12:f21e with SMTP id 6a1803df08f44-89a30ad6bc6mr76035106d6.40.1772879415289;
        Sat, 07 Mar 2026 02:30:15 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316ea1b1sm31472556d6.36.2026.03.07.02.30.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:30:14 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 3/7] fscrypt: Correct the spelling of DESCRIPTION
Date: Sat,  7 Mar 2026 05:29:57 -0500
Message-ID: <5d6f6b3a042cf2b49c942ea492f221145e66a78b.1772879169.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1772879169.git.scott.murray@konsulko.com>
References: <cover.1772879169.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 10:30:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3368

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/fscrypt/fscrypt_1.1.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/fscrypt/fscrypt_1.1.0.bb b/recipes-security/fscrypt/fscrypt_1.1.0.bb
index 6ccb8fe..665648c 100644
--- a/recipes-security/fscrypt/fscrypt_1.1.0.bb
+++ b/recipes-security/fscrypt/fscrypt_1.1.0.bb
@@ -1,5 +1,5 @@
 SUMMARY = "fscrypt is a high-level tool for the management of Linux filesystem encryption"
-DESCIPTION = "fscrypt manages metadata, key generation, key wrapping, PAM integration, \
+DESCRIPTION = "fscrypt manages metadata, key generation, key wrapping, PAM integration, \
 and provides a uniform interface for creating and modifying encrypted directories. For \
 a small, low-level tool that directly sets policies, see fscryptctl \
 (https://github.com/google/fscryptcl)."
-- 
2.51.0


