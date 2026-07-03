Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B17DC43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 11:27:20 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.90345.1783078030949100254
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jul 2026 04:27:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Em7DMRTo;
 spf=pass (domain: snapchat.com, ip: 209.85.128.42, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso4595065e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1783078029; x=1783682829; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=415iwzifaP/1JzTxyFmoJIMkeBtRPjERkipHikNDVgw=;
        b=Em7DMRTo5jFErN4O1wy4uwVo4vdJcHZ9OLh1Ci4VcCdwvCLd/vThTksKaVvUbH1isH
         GG9WO4q8kH+GfF7alV9rGFHiGxUHMaS/Ge8/8kxFOfXqLxxuFHVJdFVcp7cos5iNaY54
         8nKNls/lwIAqXZYFG3w38qdmtqVmYgUtqvipE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783078029; x=1783682829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=415iwzifaP/1JzTxyFmoJIMkeBtRPjERkipHikNDVgw=;
        b=Nw5bLwlhW+ZuL6pY7yHPcF9+anokwgw7Ee2WajBYv6CEz5XJ/Fkw0+DWqF26M82mEa
         GQY+5QMHL7swgf5Rw297vzA1EqXbLjC07vNooQlrHhYzUdOmzXe9DO82fMrW9Cti5D/D
         M62TtmpkYs+cdsraf/1mY9c40faceZJWZIq1bIY6q/CykXLqDY3O5LjqyJ8x9BEL21fA
         FB8SwSbB0nJ+wTwNfjp0nY4HUdRB835mR9mgFuHkOI0wmYJUZNl7nDjmEt94uK2VE1K9
         iHDKLcHOYNJ/G4PFJmF11VI034aFNDMoQVkCLFz3ZAVQcw6K5qabzNOxlBHZG8gzSk+5
         Y1zA==
X-Gm-Message-State: AOJu0YyAiK6Z3mkuLvjY5X/s60RxocEhp3Lf5z9w4wuocI5ZisV8CbvY
	IAmZ7/MYTPQI8TkkGPE68+nXMwQvXUgRZLA0BKHn93m1vF+rv7snFw6BFutvGmiuk3M5t0o2+1/
	8tbpAH2I=
X-Gm-Gg: AfdE7clEAy/LMCsIXRzC1fkuv7pb1wnqGJSl9lRwqQ8jXrBTggAEhjmRaog5rT0csSg
	czF9yRgN0uyT5SmS/qyqWLyOK6Xf5Na6O9TaKVOB6+PcfFnDRFm+t/0dZPW7/aS05URsrbC3D60
	takiq44sK0Zoa47gndk24h+QZLWUy/qJBeC8+PvJJ62clAh1CLVudRcHB41sP2t/I6wj+qK2V7A
	v66tgS0Pq0x3MMwwW9OSd+2ZL5WAsdaMVBIm9pc1LKAyNdzWt22fZWJPA8CYhLByYmkuBkYBDRc
	/qXkMWwsTGOJIjuzo9kZ7Epgd3X63GLlk+7sUGNkoUPIQoeaWe4070866aFQ2guicojVPbgCL/s
	Z5+T1IqlRU3rfJz3Y1hzG9oCsKuPjZopVBRrhNtA+1C9Fgg2Ng40vXdwXHLd9XNzDOcVjg4n7oD
	NkoD0ZXTziLl1TpamcHGyGIBlgO/2zKBm9uBZYsHEqLKLFtaAEPGwJrW9c1w==
X-Received: by 2002:a05:600c:6b6c:b0:493:bd73:c77a with SMTP id 5b1f17b1804b1-493c2b8fcfdmr102659955e9.29.1783078029054;
        Fri, 03 Jul 2026 04:27:09 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccb4cafesm42465575e9.0.2026.07.03.04.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:27:08 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH] openssl: fix wrong override syntax
Date: Fri,  3 Jul 2026 13:26:35 +0200
Message-ID: <20260703112635.646530-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 11:27:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4393

From: Etienne Cordonnier <ecordonnier@snap.com>

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-connectivity/openssl/openssl_%.bbappend | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/recipes-connectivity/openssl/openssl_%.bbappend b/recipes-connectivity/openssl/openssl_%.bbappend
index 3b0674c..0ca016b 100644
--- a/recipes-connectivity/openssl/openssl_%.bbappend
+++ b/recipes-connectivity/openssl/openssl_%.bbappend
@@ -15,11 +15,11 @@ do_configure:darwin21 () {
     perl ${B}/configdata.pm --dump
 }
 
-RDEPENDS:remove:${PN}-misc = "perl"
-RDEPENDS:remove:${PN}-ptest = "openssl-bin"
-RDEPENDS:remove:${PN}-ptest = "perl"
-RDEPENDS:remove:${PN}-ptest = "perl-modules"
-RDEPENDS:remove:${PN}-ptest = "bash"
-RDEPENDS:remove:${PN}-ptest = "sed"
-RDEPENDS:remove:${PN}-ptest = "openssl-engines"
-RDEPENDS:remove:${PN}-ptest = "openssl-ossl-module-legacy"
+RDEPENDS:${PN}-misc:remove = "perl"
+RDEPENDS:${PN}-ptest:remove = "openssl-bin"
+RDEPENDS:${PN}-ptest:remove = "perl"
+RDEPENDS:${PN}-ptest:remove = "perl-modules"
+RDEPENDS:${PN}-ptest:remove = "bash"
+RDEPENDS:${PN}-ptest:remove = "sed"
+RDEPENDS:${PN}-ptest:remove = "openssl-engines"
+RDEPENDS:${PN}-ptest:remove = "openssl-ossl-module-legacy"
-- 
2.43.0


