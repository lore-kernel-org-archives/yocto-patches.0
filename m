Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2309CA0FF2
	for <webhook@archiver.kernel.org>; Sun, 31 Aug 2025 11:41:12 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web10.27756.1756640472312283953
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 31 Aug 2025 04:41:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=c3QTzh5s;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7f889d176c2so454163185a.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 31 Aug 2025 04:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756640470; x=1757245270; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kvNE9RpUAQOoToYwyjOylZDrJyQfy0+dmLFlMJw448=;
        b=c3QTzh5sNS7GAz1VTPAb9Kz0N0ekvZqniQRdjVhcRBzLZ10p/ZL563RmeBAFvI8xxz
         d93q6qhUJKGJkyMBfHDgZywX5J/cghZBWsaGB31MngFtZwVR18wFWJFinluOzdb6fGT+
         nO0fnv0q6hCZZVIvzrlvFJXEcIiJGRH4wL5XJSjpbtJGRxXkSJg5xGWgvsEXwJYFAOEX
         pRZH40YDfI0qf1j4x37ML6Vum48FLHCCDKpas+Evy6K2eySlpIUhprMa+D6UjeNAnGZA
         FDQKT5ShRYFZwMiQurdY9etD70moEmWZtwRiQhEzDUs3LWIpEhUJTajTMh54XosiVp3P
         G8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756640470; x=1757245270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kvNE9RpUAQOoToYwyjOylZDrJyQfy0+dmLFlMJw448=;
        b=agJgWfW8atFMohgk0tHr+hxUFVMQjyIIa8jvePdm749uD19REvGShxVQNAeNjF0Gv1
         3UROWczWmIBH0szMUUbvOzK+yFE8tbEMmSYqLMieK6DtmlIkG9G+2JaT+KJMfAGFBoPn
         tAzMjAy03HD8Mkdsx+KOpgZIFcSTRfcExxT1c3iTjVFeQQiFqTmgYZ9QOqgq/QkDmaSx
         GjEN3Ux68ADhbxWGd7Kyjm81SmXnHOipPz4yv8qoEs8oj5I87Nn6CiLaEFpsq8FUtr+r
         piogzHsM3OIjmxEZgHkY7kQERooS6UvnglLVV5K2EUywZDFqbPGKYC45jJbsbAOE/cz1
         EWQw==
X-Gm-Message-State: AOJu0YyUUCesakFxOBM7edFrJ/ncNWY81bQCZrvMgQX4RxUEWfLafzpG
	eveUmJqpp8xt+HT6jPi1VVDut/PgCWxtkW+WAiIcdibxtttYG6kt1oJFLhSqPw==
X-Gm-Gg: ASbGncvTqMDHDvfTbi7jvy31pDMAUg/arLImC5EhFOWFL8xMuIx4022KqBR+/Vsqhqe
	grf7dT460uwPNIMue+tUGpFOE+tzBbecG1SA/RYzesEueh5WS6nO3VMnd2vXnYFq919GVJDv8Rm
	45C+hYAUx4sD/9UsHxYwWLzKICCUuieOYERaTK+hw0SjA2N+Iu2vzsYz3hnI/yhQLWiLAfTzbnj
	KaoColM5KHjmokXG5gBYWDA2Vw7IIZeS48/1vNbkhWQETTx7L4XFr4ynsccQLKlODi5OKZPLfwR
	pa4QOhNi0M07bQ/jEY64GiS1iXiOkscDhaMN+jGvqQx+pk36ChO5e7TpxpGGiTvLs0BlQ07YW4I
	ALFKnW2gyQg/IeXrcvauAyMy9Q3gZXA+BqWFzWZn3897bVZGInC0SDclTpZgluq4HTQ==
X-Google-Smtp-Source: AGHT+IHnfBEcVsTeSeuyj+MHCsFEikS7xzDtLEVgoFhmaFoMUm0rkcnQ47niQWGdnHJl2NkRPuzHug==
X-Received: by 2002:a05:620a:2556:b0:7e6:31f3:eabc with SMTP id af79cd13be357-7ff26f9fb97mr406885285a.5.1756640469887;
        Sun, 31 Aug 2025 04:41:09 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6fd490sm45174911cf.53.2025.08.31.04.41.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 04:41:08 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 1/4] linux-yocto bbappend: sort
Date: Sun, 31 Aug 2025 07:41:02 -0400
Message-ID: <20250831114105.27494-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 31 Aug 2025 11:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2093

Separate the entires into lists of 32 vs 64 bit machines, then sort each
list.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-kernel/linux/linux-yocto_%.bbappend | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
index 56ec9d7ea81b..cd5efcf9d25c 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -1,27 +1,28 @@
 FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
 
+COMPATIBLE_MACHINE:firefly-rk3288 = "firefly-rk3288"
 COMPATIBLE_MACHINE:marsboard-rk3066 = "marsboard-rk3066"
-COMPATIBLE_MACHINE:rock2-square = "rock2-square"
 COMPATIBLE_MACHINE:radxarock = "radxarock"
-COMPATIBLE_MACHINE:firefly-rk3288 = "firefly-rk3288"
-COMPATIBLE_MACHINE:vyasa-rk3288 = "vyasa-rk3288"
+COMPATIBLE_MACHINE:rock2-square = "rock2-square"
 COMPATIBLE_MACHINE:tinker-board = "tinker-board"
 COMPATIBLE_MACHINE:tinker-board-s = "tinker-board-s"
-COMPATIBLE_MACHINE:rock-pi-4 = "rock-pi-4"
+COMPATIBLE_MACHINE:vyasa-rk3288 = "vyasa-rk3288"
+
 COMPATIBLE_MACHINE:nanopi-m4 = "nanopi-m4"
 COMPATIBLE_MACHINE:nanopi-m4-2gb = "nanopi-m4-2gb"
-COMPATIBLE_MACHINE:rock64 = "rock64"
-COMPATIBLE_MACHINE:rock-pi-e = "rock-pi-e"
-COMPATIBLE_MACHINE:nanopi-r4s = "nanopi-r4s"
-COMPATIBLE_MACHINE:nanopi-r2s = "nanopi-r2s"
 COMPATIBLE_MACHINE:nanopi-m4b = "nanopi-m4b"
-COMPATIBLE_MACHINE:rock-pi-s = "rock-pi-s"
-COMPATIBLE_MACHINE:roc-rk3328-cc = "roc-rk3328-cc"
+COMPATIBLE_MACHINE:nanopi-r2s = "nanopi-r2s"
+COMPATIBLE_MACHINE:nanopi-r4s = "nanopi-r4s"
 COMPATIBLE_MACHINE:roc-rk3308-cc = "roc-rk3308-cc"
+COMPATIBLE_MACHINE:roc-rk3328-cc = "roc-rk3328-cc"
 COMPATIBLE_MACHINE:rock-3a = "rock-3a"
 COMPATIBLE_MACHINE:rock-4c-plus = "rock-4c-plus"
 COMPATIBLE_MACHINE:rock-5a = "rock-5a"
 COMPATIBLE_MACHINE:rock-5b = "rock-5b"
+COMPATIBLE_MACHINE:rock-pi-4 = "rock-pi-4"
+COMPATIBLE_MACHINE:rock-pi-e = "rock-pi-e"
+COMPATIBLE_MACHINE:rock-pi-s = "rock-pi-s"
+COMPATIBLE_MACHINE:rock64 = "rock64"
 COMPATIBLE_MACHINE:soquartz = "soquartz"
 
 SRC_URI:append = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
-- 
2.44.0.501.g19981daefd7c


