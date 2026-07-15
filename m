Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AB7C44507
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 22:32:59 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.883.1784154769116344371
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Jul 2026 15:32:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=mxGH9hWo;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c0cea8883so22670271cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154768; x=1784759568; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DGZA0SHlucguA9WNdVCmxl44jhm0wTT6MA5FUnD/Rqc=;
        b=mxGH9hWoaT0tp2NztBy4kJeCu5HV1YdtJfXbmZkM44tIofiqgvnVyOVf8mQf0lHXvH
         EkYju/3PZDDFmbC0rvSHX3R2wElsiRmfbQg7J2lZqI7OTZbE5EXnLIKoodKsoQxMeC1j
         f1H9iB3sCaKJArgAqhOq6vrInUaTURAvuuhOJiEYN5FEG+O69cF/svKTE/ecDfBBg84L
         eVByNGlky3iBI9qed6ojr2S0HQ35IuWrdzhakPHc757VXOW1XL6N396r/sMRTpGuoTLJ
         RYVFYtQLU5D5B7dANCP4TE4qlYmuwnb2/pIazKNfi0OFposUJOefgdX8mK7eH8lDtofl
         OSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154768; x=1784759568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DGZA0SHlucguA9WNdVCmxl44jhm0wTT6MA5FUnD/Rqc=;
        b=JVSqcHHUS9wT8Z+BK23afqybkbFPYFz09qaub+NjsEiZ04/3Ao483GNix8wArgZnEW
         WXPljjNeKLujBZLxtux6noOx1t+cWqnDNqoUd4i4kSHmBieKGCfyfGvVaHjK9iZM/7Je
         DlYmoG0CLOsGmq3Dp0t5URyOmmruNFDjDNsJPb9UGs+gZfVDc7hQFptIuhyr3qFDk2MH
         9eZHbkNCaubfVsE9LmYgSbJEjfOsXQN/CEdbfwwZJgR9Co/jK3cf9mfWi9E2jh4e5qaZ
         URc6eerQvyiIngxssBSeSMm50uV/xtuHZClBenc+U/yhuUr/VUNilmtDn25RXEJzcj6k
         uF9g==
X-Gm-Message-State: AOJu0Yz+qUnrWn4yzn6xivWtQBAS2qc+HmMxCQzyw9jHKRKtIzXE/lAx
	zIk2fTpOtWtfg2G9+h9B+lFyv0MUUUVyun56bk9XvtJvXq1Y6pCnAJHi6Ji9pQ==
X-Gm-Gg: AfdE7cmh0SnFa/0cu+uYCN7JrlV9VeqtLPT4yjcwhkNsQbYn4Mw6WaMb0lWgvXgHFSB
	ZWMGycWTNltwBDcGF2iwFr7fyKnj3b/gpBCMMk2uang0w1q2uNiVg8TPngICttC9lY+k1v5sGp4
	QKtrJLE4FOlJj26sYgJIJE/VrHn/iUmJP98xA8T/+jXsJ69IfOAXEn4k5ivaQfPigQkcqCYtmfA
	u99z9KoMAalNkFbM1NChgL88asjm3Fj38SKn6j4vrqUS1slZsFl/bfDB2K3ffBY9mtTRqVZLYK/
	Rh1Rz6pQN/YRkDCk0apQYMctleCav1LqsMxuMcwSKwA0GhIuHuEXXIsXJ7G/uTjOqAccRj09L1D
	9TPOS2Z6+iQED5W09dq/kg7zfDMjw28dNyqrDcp3m8zRhlHbzWnkJct6uv4zWvspzEzIEFR4SoJ
	2Dn++CCo3o5PsPhhLUMNVA7TikiysEFul46ww3EtYJkzXm
X-Received: by 2002:a05:622a:4d2:b0:51b:fe30:b8d5 with SMTP id d75a77b69052e-51fc1971cbamr175091cf.29.1784154767775;
        Wed, 15 Jul 2026 15:32:47 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd81f43e6sm205883726d6.39.2026.07.15.15.32.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:32:45 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 3/5] ksparser: reject non-finite overhead factors
Date: Wed, 15 Jul 2026 18:32:24 -0400
Message-ID: <20260715223226.3371498-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260715223226.3371498-1-twoerner@gmail.com>
References: <20260715223226.3371498-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 22:32:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4487

overheadtype() guards against factors below 1.0, but float("nan") and
float("inf") slip past that check: nan compares false against every
bound, and inf is trivially greater than 1.0. wic then multiplied the
rootfs size by nan or inf (partition.py does
int(rootfs_size * self.overhead_factor)), producing a ValueError deep in
image sizing or a nonsensical partition size.

Reject any non-finite factor up front with math.isfinite() so the error
is reported at parse time alongside the other overhead validation.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 src/wic/ksparser.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/wic/ksparser.py b/src/wic/ksparser.py
index a73ae56cd196..528a8180826f 100644
--- a/src/wic/ksparser.py
+++ b/src/wic/ksparser.py
@@ -15,6 +15,7 @@
 import os
 import shlex
 import logging
+import math
 import re
 import uuid
 
@@ -98,7 +99,7 @@ def overheadtype(arg):
     except ValueError:
         raise ArgumentTypeError("Invalid value: %r" % arg)
 
-    if result < 1.0:
+    if not math.isfinite(result) or result < 1.0:
         raise ArgumentTypeError("Overhead factor should be > 1.0, not %r" % arg)
 
     return result
-- 
2.50.0.173.g8b6f19ccfc3a


