Return-Path: <tokita.hiroshi@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93E6FF8875
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 08:54:08 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15899.1777539247370527922
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 30 Apr 2026 01:54:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=WCxCfqpB;
 spf=pass (domain: gmail.com, ip: 209.85.216.42, mailfrom: tokita.hiroshi@gmail.com)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35fb16e56efso405474a91.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 30 Apr 2026 01:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777539246; x=1778144046; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihMwv3kqoP6QvvYhLM7LIYtaxecCbYvx7rNcP9CliRk=;
        b=WCxCfqpB7U57sCw9TG6UEXOkCfwpIEDLYDLvTzbSoA7aZ5y6n3dcQHbugNjWlROfvJ
         cZltkhAx6E1GnR2+TZI28nnK5TfDhsmQCAjZFtIpaSE6Jt9i4mSBsYqsWtRlgHzNEHwC
         imgn0QidSC3sMII7WuwHL7uCiE1BfDExsnCtDMJRlrsAo7zkfx0B9St2JyqbJseGO1+f
         3aww4sR9f/dYolN7Yvu0nlOGG3dCiZuNGdHK4TekTQ24SkhaK33o/6C1dqNamwlSdcxn
         BGQtW4XRtugA7vI75VxNM3KCNZHVTTxvauJWO7KobaXksopw+3mg6rK9lH9qvXnUhsr0
         ueRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777539246; x=1778144046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihMwv3kqoP6QvvYhLM7LIYtaxecCbYvx7rNcP9CliRk=;
        b=JkS2Kvnc1NDnHDFY61hkeRxYbQLJKUkovV+Gc1Pq+9Eij+ZuovFQHxrsPuo6WatuLd
         Cpb+Tteg2xAgJc0FxbDHKaibmS/Xj9m7/1bT4UdRgY7T3zXScHUFuaX8dtzAN2pE5SH5
         99vwQ9IObw7wK1LcZbK33/rHBDIktDqviL0ub0CIPQ/dBThM0LuOEX+7jo9eJ0KRnauo
         OCsA3GRQ+zwVbeV78dF/Ys/tPTw4cu93QQt1GDL9SDAV2ZTHMPvJDXf0DBTHTWvUvA+E
         Gq7B3Wam6jjjIMmyst5i1bgqsGH+k2GOWHaCBV2zLYSymGm+/NTRz2xk0gG+xKd4ZXsq
         nl2Q==
X-Gm-Message-State: AOJu0YyNz9hc+6yiOY62tWyd7ZPa7/GUK9W4JmMD8R/DbAurEqqNnHcp
	qKsdKRc11mSxUpJT3vbtQN1Wb8HVcRrshtVuXr+Yc66bvTTemjyk1coen6r5uz4E
X-Gm-Gg: AeBDietU24QQiilUrt5BDvG1mP+I7mzJLensgmzs75SCWQeh/xgaFHVMI9nNY0EEdm5
	/Bvj5xZgXZoTupbz/m6laUGDJFuTFetHOSUqqyPVWE+LlOh586E+27sHeKFMUoxPxoowQ+9sDUn
	CVyb42KdUlhg1KW6KUKwX2Dk4b2hga7bnhlvirF9kaXKiIl9nuIyN+xVBVQFNTshVKT7etOXDt6
	KDMvv2AnfMUzIgt4MdPgKoFaEuM5UOb1fSaw+SUIA5owRNGi3xRz85+wGgYwmZ2DHg6OE2kA+Dk
	iKROfZNysy6tM4Qs8VQic+4rAemsl7q/BIVRs37wSkmQI4SmewhjQE2EaJ0pxuF0jrmCLTuejRK
	b94jYhtKp7uRjzd8RtRoAkvAelqVhtKXfnAkpumef//whJGbYEl316+fkoPrFTpr7XQyoczsuzH
	x3Irui/DvRYhYLvOczn4jLHwgEvslSxBHWyZW+xnggmYb6e1ZPHXX75pbxziFQp7SnCyD+wgoMl
	Gh8U04X771Y
X-Received: by 2002:a17:90b:3909:b0:364:7464:12a3 with SMTP id 98e67ed59e1d1-364c2f40d6dmr2316695a91.10.1777539246639;
        Thu, 30 Apr 2026 01:54:06 -0700 (PDT)
Received: from um890pro.localdomain ([240b:10:2f01:2600:a981:9d52:29db:4e78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879cb5esm48285685ad.27.2026.04.30.01.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 01:54:06 -0700 (PDT)
From: TOKITA Hiroshi <tokita.hiroshi@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: TOKITA Hiroshi <tokita.hiroshi@gmail.com>
Subject: [meta-zephyr][master][PATCH] zephyr.bbclass: Add support for Zephyr snippets
Date: Thu, 30 Apr 2026 17:53:57 +0900
Message-ID: <20260430085357.2071082-1-tokita.hiroshi@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 30 Apr 2026 08:54:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3893

Introduce ZEPHYR_SNIPPETS, which accepts one or more snippet names
separated by spaces and passes them to CMake through SNIPPET.

Signed-off-by: TOKITA Hiroshi <tokita.hiroshi@gmail.com>
---
 meta-zephyr-core/classes-recipe/zephyr.bbclass | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/meta-zephyr-core/classes-recipe/zephyr.bbclass b/meta-zephyr-core/classes-recipe/zephyr.bbclass
index cebde0b..f0e8d72 100644
--- a/meta-zephyr-core/classes-recipe/zephyr.bbclass
+++ b/meta-zephyr-core/classes-recipe/zephyr.bbclass
@@ -14,6 +14,11 @@ TERMINFO = "${STAGING_DATADIR_NATIVE}/terminfo"
 KCONFIG_CONFIG_COMMAND ??= "menuconfig"
 KCONFIG_CONFIG_ROOTDIR ??= "${B}"
 ZEPHYR_BOARD ?= "${MACHINE}"
+ZEPHYR_SNIPPETS ?= ""
+
+def zephyr_snippet_args(d):
+    snippets = (d.getVar('ZEPHYR_SNIPPETS') or '').split()
+    return (' -DSNIPPET=' + '\\;'.join(snippets)) if snippets else ''
 
 # qemuboot writes into IMGDEPLOYDIR, force to write to DEPLOY_DIR_IMAGE
 IMGDEPLOYDIR = "${DEPLOY_DIR_IMAGE}"
@@ -27,6 +32,7 @@ python () {
 }
 
 EXTRA_OECMAKE:append = " -DZEPHYR_MODULES=${ZEPHYR_MODULES}"
+EXTRA_OECMAKE:append = "${@zephyr_snippet_args(d)}"
 
 python do_menuconfig() {
     import shutil
-- 
2.43.0


