Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B19C3ABA1
	for <webhook@archiver.kernel.org>; Sun, 15 Sep 2024 15:27:53 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.web10.116693.1726414068614901042
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Sep 2024 08:27:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QclN6mXi;
 spf=pass (domain: gmail.com, ip: 209.85.128.170, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-690aabe2600so17214177b3.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Sep 2024 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726414068; x=1727018868; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YQfttntqHkEmLYTMUgL+1EaKZMKzpn+ugjRfRyDLGyA=;
        b=QclN6mXi9sByBhxkpLymXpasnHYcdTrgjCF628cXxXvi7fyiYVNnpg50zYUfltxdcf
         aUBG/ywV7cYY1vl228GABPwCdwSLr0ozk7oHAVJXl7M912+usbKHbkoYODmcsnxuESge
         iwYzj5VcWg9vxFcDdFOmgo/FtZGI0OYmlTWfjfmjXoWrdtDJckB/I8xIZoG/ZXaSQgpk
         z4CmS/dF9IzGahjr7EHvoLCYTdvdQJpOY6f4zsOpYuAbw3VSyYWNCDi2uMqviYpci1CI
         V8PVa9h44pbrCAM+cU+5ZNDgMkBIw8P/KjQ04EaAz5j86t0E35EGYf4/PKBGbkPHkK2I
         T35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726414068; x=1727018868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQfttntqHkEmLYTMUgL+1EaKZMKzpn+ugjRfRyDLGyA=;
        b=TzCwPlLIKZytcS5aGz6Wwo1MuRHBl1k/nLClCBIOZrPBp7H1pyaGtDZh3O8YnmGVUI
         Plk4pmV49I0TV0Br+mfoDS3MYLNj84e9UCJ+6DSwoBWhI34Vi5iOWsO+838KGeFojWHU
         YcQ2RX2k/soq94XpHs/mA+B9nkkjs+vREyC2o6FixBT5xoN+hJDhxhl0wXPgIA3AVs3M
         anDpcqfPPUCdbKEwCny7D+3G72ZbTc6YqJwZ8g2n/hQHXjM3GNYY8C7CoPcQ7RNOombQ
         A0U2PxZqiG2OA6/Jk6EpRhRZntKjxC/ep/ELdOOLbOHPSMBaZnA7v6XTdrefRvU08jxt
         4m3w==
X-Gm-Message-State: AOJu0YxqtUEADUNcsfyFECOswiH+hg5am6c0S5Cxb8nglafZAsBNgnGd
	mqQEm2jLNR1OuWPiqwXz08lNjoH6BQ8v6watL+9hPgSmucZ4sb6NmmmdWw==
X-Google-Smtp-Source: AGHT+IGKlCKh2XkrbmWxk6KIqFGu0uUdquZKYLqJkUDx5CANjRGZAS2Moyr50M83EGJdYQvwO66Qqw==
X-Received: by 2002:a05:690c:6301:b0:6db:e045:3b07 with SMTP id 00721157ae682-6dbe0453be5mr44201587b3.17.1726414067459;
        Sun, 15 Sep 2024 08:27:47 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:971b:923e:7e7f:305e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe53b309esm5194547b3.87.2024.09.15.08.27.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 08:27:47 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] layer.conf: Update to styhead release name series
Date: Sun, 15 Sep 2024 11:27:46 -0400
Message-ID: <20240915152746.183717-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Sep 2024 15:27:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/657

few more layers to fixup

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-hardening/conf/layer.conf | 2 +-
 meta-integrity/conf/layer.conf | 2 +-
 meta-tpm/conf/layer.conf       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/meta-hardening/conf/layer.conf b/meta-hardening/conf/layer.conf
index 8da050b..f5db751 100644
--- a/meta-hardening/conf/layer.conf
+++ b/meta-hardening/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "harden-layer"
 BBFILE_PATTERN_harden-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_harden-layer = "6"
 
-LAYERSERIES_COMPAT_harden-layer = "nanbield scarthgap"
+LAYERSERIES_COMPAT_harden-layer = "styhead"
 
 LAYERDEPENDS_harden-layer = "core openembedded-layer"
 
diff --git a/meta-integrity/conf/layer.conf b/meta-integrity/conf/layer.conf
index aab9652..292ba21 100644
--- a/meta-integrity/conf/layer.conf
+++ b/meta-integrity/conf/layer.conf
@@ -20,7 +20,7 @@ INTEGRITY_BASE := '${LAYERDIR}'
 # interactive shell is enough.
 OE_TERMINAL_EXPORTS += "INTEGRITY_BASE"
 
-LAYERSERIES_COMPAT_integrity = "nanbield scarthgap"
+LAYERSERIES_COMPAT_integrity = "styhead"
 # ima-evm-utils depends on keyutils from meta-oe
 LAYERDEPENDS_integrity = "core openembedded-layer"
 
diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
index 58b61d4..b8df817 100644
--- a/meta-tpm/conf/layer.conf
+++ b/meta-tpm/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "tpm-layer"
 BBFILE_PATTERN_tpm-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_tpm-layer = "6"
 
-LAYERSERIES_COMPAT_tpm-layer = "nanbield scarthgap"
+LAYERSERIES_COMPAT_tpm-layer = "styhead"
 
 LAYERDEPENDS_tpm-layer = " \
     core \
-- 
2.43.0


