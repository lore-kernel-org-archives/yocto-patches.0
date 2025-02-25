Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3274FC021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 12:15:41 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.6689.1740485740588280657
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Feb 2025 04:15:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=J5/ccsWm;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7430e27b2so867034666b.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 25 Feb 2025 04:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740485739; x=1741090539; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJI5QV3jx2a172KLR95uZqcYNaUQ7rGppYsuprOY2nU=;
        b=J5/ccsWmRen/YE5M/Q8pHk/AK99rmV/8kRv5Ws+MgVleWqYSzHREzA9vMBN0qi+2HB
         dMQLwAtwWNCMNmNvw6RFv/hpYrUmfqwdJk6dy9oqg8VMM8114k8Aa3RWJRVpqgNldC53
         tFGEcpNJ5ZXR9tQY0CJN0CH1qQfrlumDU6DhqgexaFXFYnpm70vbnG4S2pjC2STks7J0
         xjSNUaApApC4v1yHgLPG7tccK+kt/PFk7BRxCKuZAhWC/wmOZNlAacmkDHD9mwCd6vIi
         2FDCodSYaiDqgs+M8SqYF6QbsvF+AFlNlnORBdTbsk1mVlhIxZdHermZTNXsIyvZ3q4W
         GFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485739; x=1741090539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJI5QV3jx2a172KLR95uZqcYNaUQ7rGppYsuprOY2nU=;
        b=XfeIsqvc0GgYhVZVUO6G23FVnLfGoXdYEjVmb5/nYXqk6h0F4F0k64825lVPipkNbx
         zTLlahP7zp/+8/CMwOkwejkP9xnCghWVDqpPDnSWJ40dkTDWWndaaJqu8LISimoZnTta
         R3pGmSieftOfcV4QBWgO/oP96hHSbuYbndAQXPvAROB4k/tI7V1JvIa1jOCy/H0DNc6w
         fyCuQvW5wRo8425sSiLkOHMdnmL+sq8R7HOltXBjkyjHX+4fPDA2SKMrySwmqfyDVfE7
         G/RkrfEfVi4p6FTpBfn6rNqFO0iXZgv5Okc5kcqmcoKK4WYXLS5IJiECACjCjOJX+xV+
         bf+A==
X-Gm-Message-State: AOJu0YyQWAg7GK2YCyhU7QfPUY3LIkHeZBLBcrZ7JNtIwLxXCgGTvtKH
	k/Qh8lcmVEe/hIfDbkI5+bmW+vige0Rm4XjMY/twH5CDeC2A7PHCO+JhrQ==
X-Gm-Gg: ASbGncslNr6UIv+USk2ipNarzTIm4l5g5yMY07fJ4t6YW+5yJcSCC6VAh72KgMyD179
	pxqwzYDkhcm5SAc86WAhqbDs6Ex2u/KETy2AvpRm3bkA4knoiL8byVnT3qVojV5TqnvYdGyGoMW
	8TiunQQodGkbzBXoyZ5PnMEr37vyfR3/4bWljV3m+R9LyuuOggl27Tb7nCNyvXgd41gquzb1l5o
	/AkgdnBG2CcuJL8M1CfOA/az+G0Ls/tPeFNrlvhEhiDcn9M2P+Q+C4Orw4lzomz3MhtU9xh+dtk
	4ek3qkkoi16OEqwZDeqBsx/BCqmVTMK54Gti0UcqKQTw22AIIGjhkYAnltEVmvY=
X-Google-Smtp-Source: AGHT+IGW7KfdTESTMn3VG+1xsWWllnkfKiXNhXYcpdMhnCI1/+tbL4fjj1MACRg9HDjTAE4RDJmdiw==
X-Received: by 2002:a17:907:3da0:b0:aba:246b:3954 with SMTP id a640c23a62f3a-abc0de4fa45mr1786139666b.47.1740485738884;
        Tue, 25 Feb 2025 04:15:38 -0800 (PST)
Received: from alex-lx-laptop.lab.linutronix.de ([2a02:2455:86ac:8b00:8de8:97f1:4c58:d8a6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d6b153sm132074766b.73.2025.02.25.04.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:15:38 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [yocto-autobuilder2] config.py: add a builder for providing CDN sstate to bitbake-setup users
Date: Tue, 25 Feb 2025 13:15:36 +0100
Message-ID: <20250225121536.519502-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Feb 2025 12:15:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1129

From: Alexander Kanavin <alex@linutronix.de>

This builder is somewhat tricky to define as it needs to be triggered
on new commits in stable branches (and master) of oe-core and poky
and run bitbake-setup from master branch of bitbake against
a configuration matching the branch that got new commits.

And the bitbake-setup configuration needs to be tweaked to
add autobuilder resource consumption tweaks from config.json.

The plan is to experiment with all this in a private branch
in yocto-autobuilder-helper, but that needs a builder entry
here.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 config.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.py b/config.py
index 67d80e5..f6f110a 100644
--- a/config.py
+++ b/config.py
@@ -35,6 +35,7 @@ buildertorepos = {
     "auh-meta-oe":  ["poky", "meta-openembedded", "auto-upgrade-helper"],
     "metrics":  ["poky", "meta-openembedded"],
     "meta-webosose":  ["poky", "meta-clang", "meta-openembedded", "meta-qt6", "meta-webosose", "meta-security"],
+    "populate-bitbake-setup-sstate": ["bitbake"],
     "default": ["poky"]
 }
 
@@ -152,6 +153,7 @@ builders_others = [
     "yocto-mirror",
     "meta-oe-mirror",
     "auh", "auh-meta-oe",
+    "populate-bitbake-setup-sstate",
     "meta-webosose"
 ]
 
-- 
2.47.2


