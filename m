Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A81C4450A
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 22:32:49 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.846.1784154765476818093
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Jul 2026 15:32:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PEV4Rmvh;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9034b6b7674so45007496d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 15:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154764; x=1784759564; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LJnVhbwgK3az62VYfzpnKRYs1hsdCouYMhzvSto6YWE=;
        b=PEV4RmvhkJ/3f829XBZSEDLplBMJykRK93AyRQ8+V1Zt1EW8WhMRBBU2kh+cK4Hy/z
         tjJcHxs4zYzPv6eadjAUfuz8g4E/1Ykvc7MVLCs5KbAoWGGH8HZwMAubAFGK8UQPBRvK
         AvO4cl3ekeyBhP5NkqJ20dBY4WORVVGfL8iDRggwGaZd6HaFFFgTVqpd1nxyheuqmx65
         pL5Ba0/AAQdTI68ja5sB3xyBVqEx9znCNsV5wGhqFV3lCMrlVGgNvNZGOZx+6M6Udw6k
         5SpnfL00sKDvW71C5URJwJ99VDz1WsLpyMbgkdtYyve15pdlgVH16tfKEhkzQhQcQ4xG
         zeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154764; x=1784759564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LJnVhbwgK3az62VYfzpnKRYs1hsdCouYMhzvSto6YWE=;
        b=HFEbf1PFebah8wlkKJ7aNzkXKA55OdNE78K1G2ePLhJKXjOSjLlSp10xo3tXB8/Jek
         82BQd8+TLCTHwb3NP30MhFyMFrous0yFnH4iPbhzQlMH/SQh8TRdyF9wWyA7/8LCxIqL
         3sGxq57pAEMfvy7ncZRoJnbyeSvNhBolaOR9/QGsmKxnkZQqWZrPIkj7S6v+EXhf1/tP
         GWv1KBaXzOl7vjxm/nM0qnXKf85O1u23Pq7SmAybUvnPpCmRaXAhYZZD5OIKi+8z0gfl
         z3kEUqkjI6GC4gAWhY2c0+IzkX9diSG/XjYQlbO3b2iRTKamX46dGuIdPen9x+HnCanz
         4maQ==
X-Gm-Message-State: AOJu0YxY+7Q0Sjf3rc1t/QnLvkoxFy9IVyyJcGOtFEGrBMjsi5kNbcre
	IiV2SM/q2cu8TcH310oGMF3ZloND4ERM8C0H7dPEMRkAM/mzzYvVWfQ99vnNQQ==
X-Gm-Gg: AfdE7cn7J61CG4e6x5HlJzrbNTw30OMJFw0fCNqf3C4qoYDQDtjS0OJhq/d45/O9xH2
	rCDTQ0XS4hOlfGmCnA0CXd0DSU4jioLoIxH+D+qwhYu72VOEVL7mhOBT+Fm/QFo39CXvGIi7GLu
	R0UYNbMX9pgxrnYksgWGfYt9+GTdapZjIi5jn7yBwxPUie7gdfl6AeRH8hCYKbuMz5JfNsGG4JM
	UFnSV5MmbwenlPJnKmODM5NxYhlnwJcKMorY6R6g5qfnoLNxeBibXsMori/P8ykUSegVMId7NRL
	IQ7JJ4ru7Q8Il+fvhCzp9ioRhXvnvUVDi+7mztsWqrG7uJxKCuRO8fVCSzbvpj+cL6giZ+fjMIR
	X7qoIh5ev1m3jrvr9uvYm+drXmdLng2gSL0RTTOcFIVbprkJ23JUvoYyM44cjk/9Vl2IEC6Ra1O
	KjkJBkPZ3esOI4fDKh5jDx99v9Z1F1opBBuDIUCNilLMqG
X-Received: by 2002:a05:6214:2465:b0:8ff:6304:da9 with SMTP id 6a1803df08f44-90747c2ef20mr116965116d6.6.1784154764184;
        Wed, 15 Jul 2026 15:32:44 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd81f43e6sm205883726d6.39.2026.07.15.15.32.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:32:43 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 1/5] ksparser: reject negative sizes in sizetype()
Date: Wed, 15 Jul 2026 18:32:22 -0400
Message-ID: <20260715223226.3371498-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260715223226.3371498-1-twoerner@gmail.com>
References: <20260715223226.3371498-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 22:32:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4485

sizetype() splits "<num>[S|s|K|k|M|G]" into an integer count and a unit
suffix, then multiplies. int() happily parses a leading minus, so "-1M"
produced -1024 and "-5" produced -5120 with no complaint. A negative
size is meaningless for every consumer of sizetype() (--size,
--fixed-size, --offset, --extra-*-space, and the empty source plugin's
size=/bs= params); it can only corrupt the resulting image layout.

Reject a negative size with the same ArgumentTypeError the parser already
raises for other malformed sizes.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 src/wic/ksparser.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/wic/ksparser.py b/src/wic/ksparser.py
index 8e5fbfadd81f..24c7015b336d 100644
--- a/src/wic/ksparser.py
+++ b/src/wic/ksparser.py
@@ -68,6 +68,8 @@ def sizetype(default, size_in_bytes=False):
             except ValueError:
                 raise ArgumentTypeError("Invalid size: %r" % arg)
 
+        if size < 0:
+            raise ArgumentTypeError("Invalid size: %r" % arg)
 
         if size_in_bytes:
             if suffix == 's' or suffix == 'S':
-- 
2.50.0.173.g8b6f19ccfc3a


