Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641FCC44501
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 22:32:59 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.849.1784154771089480134
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Jul 2026 15:32:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=mpKL5MXl;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90004d2f7b7so76212026d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 15:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154770; x=1784759570; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cox+V5NfMGBoTovzmcyCjkMvC5wJztFakUujrKVvb+A=;
        b=mpKL5MXliT9f466Til4tllpXhghhjQwnK43XLgdgDZLcGBfYZDtwPKSdB3xtbywgCQ
         fAlRlWwMq7qek3Ka/t1Z4Ye9saRoAa2AQT+RKDrcFSulLGc8jaeAaydGOAQMXBmO3cG2
         LRaBIDUcKSbyYCXgZDbyvEFZfgd7gugwJpe7radFA+HDvHVMeiEFGkvVPLEuY1Wwo4Vt
         IOehl30pGWcgrQDqWeku2nHJOo3AQfvkRwupdqRbDAnINiLB1fwNDEq/u7JYm3N+ZbZK
         d0LfZ6quz+bXN9RSZrVifTEkDAZABmulCeLa9tg6jmXlVa1wqfzc0o5wbpeZPvbGayQ0
         9U2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154770; x=1784759570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Cox+V5NfMGBoTovzmcyCjkMvC5wJztFakUujrKVvb+A=;
        b=RqZyy3dpwp0oGFxbxIvSgLaqf7uz7K9cawIvKKidKLc9TS29xckLJPphbH94tAsEoc
         opWnnJUwMD6rw8SZVxRUP71TNdrg29lvzP2kWRpYmYVkANGfszWsEmZRwbkfoZPi5zjd
         r0447a2Pf1dcEDgUM5Kr0sz7SK5vBuHY0Ht2JwrnfIOheTg+U1XYFFzyeILwelvuUilc
         OG6/vp/2gn2YqW4yCPoK1pieyn2mnnQc4nQ2VeMdOoK/mjsqRY5W4HEa8sh3ui9x7Tkj
         5GB93X2SChVKtBxXMSsn+KBNiJC+ieFE+mePrvus1sXU/2J4UtDfRjWmp8rJK4NFWoPG
         iBWQ==
X-Gm-Message-State: AOJu0YwpcQFQP9/FuM8gB6q9b8zr7Li81V5XB3ZrjDJ7VbyHY+qezodb
	6aQyJE3vz+xT4N1z620MF1w2aNOo81S+YZicSaL1z+BM9TvuoS4CgCC2v5c50w==
X-Gm-Gg: AfdE7cmOEJDOMigosvUbr3yIhkkFGp9/t7XeXLpBQO5EWAfOfgNHjNM7IUIUTgohHZr
	pOcQ0jbf8Lon1IDLwXKworQw0EQp9Z7O34kxfq1GJ638FtsX3lyfsfll8ubbso6PQxBWTzyfRIA
	n6SPFVJenwPSWJgEfk0ilJdwXQ+vfsXrEsWjyZbQOfcVXJnS59aeGHthM9ehOzYu2szLHAPzBVL
	0u8HXJwKP4o6XKO3qFmWB7dz29b/yLMhR76z+CP3fAdDTZxOqMRQ16QEZkFEDDm4s070bb9yiOA
	SGI8yfZEuPhXrLbKfzN7pfpJVAB7eSmQyFL2SFNED3+ZX5V7Z4mW0s9E/e+jpgdF/4gbNPbFWfg
	ilFSYyF/qARX43QJyyBFq3D1r61NY8LpGillhilfUHxMvZ0SIrdaFc96IwF6+LHmIfLuID8KtMX
	JcRGJK4I8DdpwQYZJgSTSYCFwaXK5eyp/R25hXVNQnGj+G
X-Received: by 2002:a05:6214:440b:b0:8f1:7a7:b869 with SMTP id 6a1803df08f44-90758deb9camr56865366d6.31.1784154769831;
        Wed, 15 Jul 2026 15:32:49 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd81f43e6sm205883726d6.39.2026.07.15.15.32.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:32:48 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 4/5] ksparser: require an explicit 0x prefix for --system-id
Date: Wed, 15 Jul 2026 18:32:25 -0400
Message-ID: <20260715223226.3371498-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260715223226.3371498-1-twoerner@gmail.com>
References: <20260715223226.3371498-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 22:32:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4488

systemidtype() validates the MBR partition type as "hex between 0x1 and
0xFF", but it converts with int(arg, 16), which also accepts a bare "82"
(parsed as hex 0x82 = 130) and a signed form like "+0x82". Those inputs
contradict the documented contract and are silently returned unchanged,
so the raw string later handed to sfdisk may not be what the user meant.

Require an explicit 0x/0X-prefixed hex string before converting, so only
the documented form is accepted and every other spelling raises the
existing ArgumentTypeError.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 src/wic/ksparser.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/wic/ksparser.py b/src/wic/ksparser.py
index 528a8180826f..dcf26f788083 100644
--- a/src/wic/ksparser.py
+++ b/src/wic/ksparser.py
@@ -132,10 +132,12 @@ def systemidtype(arg):
     """
     error = "Invalid system type: %s. must be hex "\
             "between 0x1 and 0xFF" % arg
-    try:
-        result = int(arg, 16)
-    except ValueError:
+    # int(arg, 16) also accepts a bare "82" (-> 130) and a leading sign
+    # like "+0x82"; the documented contract is an explicit 0x-prefixed
+    # hex byte, so require that form before converting.
+    if not re.fullmatch(r"0[xX][0-9a-fA-F]+", arg or ""):
         raise ArgumentTypeError(error)
+    result = int(arg, 16)
 
     if result <= 0 or result > 0xff:
         raise ArgumentTypeError(error)
-- 
2.50.0.173.g8b6f19ccfc3a


