Return-Path: <michael@amarulasolutions.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADC3EA7193
	for <webhook@archiver.kernel.org>; Sun, 19 Apr 2026 08:53:34 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4860.1776588808640019764
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 19 Apr 2026 01:53:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=GYTg6vXA;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.208.46, mailfrom: michael@amarulasolutions.com)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-672c23aa064so3777149a12.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 19 Apr 2026 01:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1776588806; x=1777193606; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jSN/I961sig5FJOR0SXIHLb6saX4FEhE+uUwTtItPGQ=;
        b=GYTg6vXA7GdRdodAnUYz8F26yXtkJOaeeXhTZaWIIllsK6jlm9CkdEHFKpD3NR4Tvd
         gwzwBRGP02TGnqWqhKGd6IGHDfEzbRR9iUVjHeP1qPMvFgwGtNFN9J6E9PHnmOJtLsAB
         VYuY4MJKjSeSSwSTbOPzFX7Eb8HOHjIts1lbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776588806; x=1777193606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSN/I961sig5FJOR0SXIHLb6saX4FEhE+uUwTtItPGQ=;
        b=TnzSzJgOboejsGRxH/A+ryFyhg9Qa4ELGoTuEtjo5KUqhB7QDICy0Rl1m7dRunL+zD
         yohg8Qkn+DQFBi+vqljHHaJgkqGF8CZDAfSmdlH/LyOKuTkRJHK+F6KP2XCjcYMxMx4D
         Q4NNGM3ERbLXXZ2oieEATb61L+yAuQ9wmnVPaEW3tOHdDpNn8tW3iVxr0yg2da6k+HPS
         dgJdDH1yvc4qk8TzKNelLhgtjiqIcWgdDqK59UjPhespLWgsdvPEXgJWnQoTOMSHN7yn
         3RAUox+ZdEe+7sFCwtYXP1qc6cNuSr7k/aGlrSoghDMXQXdrjxvSc/8QBmW9h1aPfuys
         1QVA==
X-Gm-Message-State: AOJu0YwRLJ6C8UAE9RVBQtE1yB+1vORx1Ek2FWNuB1khcJ5pZWnHO5mq
	SLwaO6RnHBaOpf4ovhNdc/dePLHbjGAkAp3naLrhsF5sgIwqpyBUav/ZAeEiSLmBVhCEYyUv8+g
	Yh7jI0UkjGg==
X-Gm-Gg: AeBDiesSAd/gGpr4v7cp/pE7kvtKupkOK0uexrjj7S6T0FzBYZI9h6UJIoO2nLJIdPI
	SG8xRktF5uZGp4t31v5GfEhLhczZGyrZXUT2nPQg6fzD3lmGXdCiFcMSRCPpQQ7RV1+zvKgov1Z
	Z34lyeKWyxMMPmL7Cwt5xm8bm8Vz2OZCNzQqvD7A86ZQD9aixAJuqYaUf95K2hgqPxSVgVr1wd+
	xA2oUzRJd4PM6KJVoetLj6VNsKfw2+WSFYI2ezmccLN4uoz4+l3EW6wUcHjY/8ZANUzTmv5qoWm
	9m4X+AedGx1XmK3ykcKHqIuo6PZFLTONuZmBOoWBQSXXFawCW2qHeXHopQTRl5tt8pJueLXfMPA
	j66NT+iAVhp7OHgG6d24XdgHRPMtBvgBYJeutmAm6Fv7bh3iNDfWkkv1tVATIRtywIwV8zZYwcV
	UCfFzDfId2Lw/9cRoLyX4qjlzNYpERu5triGwclQSsTduxgY0cN8BwD8dZkwdftkKdeYRUQ12zX
	Gsd9EZpvc1fZDK6jOU3JNw4a+yOHRMZEgVMLdIDq2A=
X-Received: by 2002:a17:907:3d10:b0:b9d:8697:73b8 with SMTP id a640c23a62f3a-ba419654967mr430074166b.22.1776588805749;
        Sun, 19 Apr 2026 01:53:25 -0700 (PDT)
Received: from panicking.station (mob-5-91-87-238.net.vodafone.it. [5.91.87.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c4d5de13sm1385879a12.26.2026.04.19.01.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 01:53:24 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [meta-rockchip] [PATCH V2] wic: wic need to be moved to files/wic within the layer to be found/used
Date: Sun, 19 Apr 2026 10:53:21 +0200
Message-ID: <20260419085321.3608814-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 19 Apr 2026 08:53:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3729

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
V1->V2:

- Fix correct directory to be wic

---
 {wic => files/wic}/rockchip.wks | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {wic => files/wic}/rockchip.wks (100%)

diff --git a/wic/rockchip.wks b/files/wic/rockchip.wks
similarity index 100%
rename from wic/rockchip.wks
rename to files/wic/rockchip.wks
-- 
2.53.0


