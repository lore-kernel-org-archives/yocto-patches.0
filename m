Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E93DC44507
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 22:32:49 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.847.1784154766961523451
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Jul 2026 15:32:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=OX7ymLax;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e5c9211d2so465444085a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154766; x=1784759566; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X9+QoDSp9pMkV1VzPHZkid1oJcoMg6nv+SazO+k7r+4=;
        b=OX7ymLaxu2JvaFNPYpJop2H4Bituzlg/2fO41cinyVaM4RxQgNbs9y1p+yH5mdG1te
         1r/Sm37uJn/MW9ObHQhwXkSVIbdDqrAJNs0EWOyEEue482aZEzdk129n2pFWu+n/cGPX
         F648Ghzpn/pXTnU9ctbVgbiz94ymKszla0uEIZ2bFmE39pUrSU3llE+iumY1O5woJR7H
         T1CQnZE5Hr5UsKQ76HXx1sN/+uewDRIfdU5CQdYeMi7XAHkLNX5xE6YFoGVdVqYGqzOU
         Ou+6UKeknZn8Ydjr2Uz5HjnlHcYTzPKedQYULKnnJBe/yEWjG0PNhVFOll7Kubv3jHLw
         oYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154766; x=1784759566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=X9+QoDSp9pMkV1VzPHZkid1oJcoMg6nv+SazO+k7r+4=;
        b=BqEMNlD2wK3n9sS7QmQlAUQh90njf+mrpo1uOvL8FyXfJ0FXPMWYZw8c3JzMQGstvi
         IvbqhIMURYULF4y9PdOi0KZdSYlc1L+ymYUcQ+XyQNgNdM1c4aTyKoMdC+FCQECC3AhZ
         JwA0E2ue/IONPb7H0E1gzTCeFz+Kca09+cZmx2k+ZVEAoi038m/gWun7X/RtbRHbWE/1
         4VKi4VGP8i1DU5L+F6LBKC1TXUfs7IeVmV1voCiFxWEUqnqVVTrAD4289rK9/Xr0pkt9
         JwwIehMtNYog4dSoYrpRwaOUiifPaxPNVDTQkoVc3EQz31b6BKjivpdgEVKNM2QL7Vdz
         sVew==
X-Gm-Message-State: AOJu0YwvTeKYtzNRlgEbfe0C74xURBq3dqxE8FmNPOHdQLRIvkEfl8zC
	COUNZHpeVQaCJ3XwyIJroO0Kbkxbu113LhrllgYPzGQYLwcy0MV7PVAdcSO4eg==
X-Gm-Gg: AfdE7cmYTjTaIqqVEQZaHISr/40kaBL+uVKw/QTNhAP8z1zqk1gMmtZOHgfKzpK085n
	z6QfBbFmY3M35+yfnRjzZx2zpisg/Iz2aHV9UB/6pq91gb8ZZMsqpTqoUP/9Lqkl2RfjMvne3rv
	Sgy0yQJzUPJW6vOvzSB4EGX20YkZ92AhM+QbMSvEMb5QukfY9UYzR0HgU1PFoaYl76z1CT4TdoU
	mJBUNwqUHZg8k3GcqHTx3HKNqEIBoZEAx5nOKfkuInN23pugoULKH4GKVamlvs1zHqXlbqJ4xW6
	YqQTyHtLp52Dmp6oB+LGmEk8yABqhVZZJyLpWiJqhRdHxp4gc9V2Ug2nPTnoTE3gedhJZgGLyR4
	R/OXsi3QvzOwQayJhQlikhjyBhDQDNN0wbUkZkxwfZxfXO1cZdYoWOT0KKaMyT/Wid0q1JGYaZc
	ZYHHAgApf3hWI2Q9TBoQt0f90SlrzYlt1ru4zNZV4qd0zg
X-Received: by 2002:a05:620a:25ca:b0:92e:c118:18b5 with SMTP id af79cd13be357-930963feca4mr515121085a.84.1784154765584;
        Wed, 15 Jul 2026 15:32:45 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd81f43e6sm205883726d6.39.2026.07.15.15.32.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:32:44 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 2/5] ksparser: fix crash on out-of-range overhead factor
Date: Wed, 15 Jul 2026 18:32:23 -0400
Message-ID: <20260715223226.3371498-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260715223226.3371498-1-twoerner@gmail.com>
References: <20260715223226.3371498-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 22:32:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4486

overheadtype() rejects a factor below 1.0, but the error path read

    raise ArgumentTypeError("Overhead factor should be > 1.0" % arg)

The message string carries no %-placeholder, so the `% arg`
interpolation itself raised TypeError ("not all arguments converted
during string formatting") before the ArgumentTypeError could be
constructed. Every out-of-range value (0.0, 0.5, -1.0, -inf) crashed
with an opaque TypeError instead of the intended argument error.

Add the missing placeholder so the offending value is reported and the
correct ArgumentTypeError is raised.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 src/wic/ksparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wic/ksparser.py b/src/wic/ksparser.py
index 24c7015b336d..a73ae56cd196 100644
--- a/src/wic/ksparser.py
+++ b/src/wic/ksparser.py
@@ -99,7 +99,7 @@ def overheadtype(arg):
         raise ArgumentTypeError("Invalid value: %r" % arg)
 
     if result < 1.0:
-        raise ArgumentTypeError("Overhead factor should be > 1.0" % arg)
+        raise ArgumentTypeError("Overhead factor should be > 1.0, not %r" % arg)
 
     return result
 
-- 
2.50.0.173.g8b6f19ccfc3a


