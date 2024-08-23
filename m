Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD834C531DC
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 12:33:12 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.15010.1724416391307730697
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Aug 2024 05:33:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Sncg8vS5;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3718cd91185so960542f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724416390; x=1725021190; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uvc+hmuv7UaadqxuiXs/n441gA3DHF/pfPa2Jzu/XpQ=;
        b=Sncg8vS5w3QvpKIcWQZhgZ5kfVfTJgOHpY0h8CjeX8p0dcoKjWUBhrdVOmXvyqFajR
         m3iVphplaStSI+3IBreg7aDnSyewY1qge6r3QkPCqbJIbfjGFShnZMVOyOLDdIe13EVw
         +aIdPRPaGUt0/2HhTzCIx8nS7tZ4So6FXSp49EIAeuc7mOe9/i3EDN8jum6PmekFy4O0
         hM8gSb5Bii+YrnktAAJw/78NujONF6G8Ho7OcKa1grEjgMWXI1+OWlB2DDGIrDA1wwjv
         3WDnGRuFANmnZLcCDcD7ItO2PQjZeQaU/QtG9SRB6ElDMsgEYTs6/Zin6/th0GnNiJMB
         Kr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724416390; x=1725021190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvc+hmuv7UaadqxuiXs/n441gA3DHF/pfPa2Jzu/XpQ=;
        b=NEBHs5OjOcamqy4F7YsdJz7+2XcP2Q1dR9gw4NNAy7xH9qh2eYjK7cBP0hOgV5tbNa
         6e0+Ycd2xU4qOqJi19F7tpFxpN+scA9UZNz1/JifAV5JTmLMoAFQiZSPsSfdgW/5U7OV
         zVpKGRQ6+BrsEXkSypYsl6ZjEWylHoKIXdmptys6HOnGktDgeL694Ze2ikW/P4PJlXI4
         Wgs1Jxa/aWZU4NCO29wtnXNMU6jFgE84NztWA2RQQGgnNwirXrH5/070+gpSjtP/A9X0
         2E4raYUmPmJmooElx5ISfibrrkf0qMiQ8WiLmb4OAM/zM/iK+jFqGGgZLthF91r0ZOoG
         n3PQ==
X-Gm-Message-State: AOJu0YzQYTCDdjIV6yvC784aW+Uqes+KvTBWFE5kksI8ZBWmkHKoPg6i
	dNaFfZM8qUbkBrS5723Xb4aBnfzIdeG0JYu2RZYwQEEAOfQ9KnouQ7kEjQ==
X-Google-Smtp-Source: AGHT+IEKu2xARZeUGzLjEfNKfU0EJ+rHEX4a9rDEtkzLcDXb3GYMlHJiE5lDH5f8dJw2/OwQf044IQ==
X-Received: by 2002:a5d:5487:0:b0:371:9156:b3b with SMTP id ffacd0b85a97d-373118eeaafmr1351200f8f.53.1724416389197;
        Fri, 23 Aug 2024 05:33:09 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48a98asm252182866b.182.2024.08.23.05.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:33:08 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-rockchip] [PATCH v2] mesa: rename bbappend to match new recipe name from oe-core
Date: Fri, 23 Aug 2024 14:32:53 +0200
Message-ID: <20240823123253.3562592-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 12:33:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/553

Otherwise it will fail to parse.

Renamed in:
https://git.openembedded.org/openembedded-core/commit/?id=f5cfb3e23603cefb2f3f6bfe776afaedefd10808

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 recipes-graphics/mesa/{mesa_%.bbappend => mesa.bbappend} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename recipes-graphics/mesa/{mesa_%.bbappend => mesa.bbappend} (100%)

diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa.bbappend
similarity index 100%
rename from recipes-graphics/mesa/mesa_%.bbappend
rename to recipes-graphics/mesa/mesa.bbappend
-- 
2.46.0


