Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE01CFA754
	for <webhook@archiver.kernel.org>; Sat,  5 Oct 2024 16:34:59 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web10.15077.1728146090486737816
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 05 Oct 2024 09:34:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Q/vgNEVQ;
 spf=pass (domain: gmail.com, ip: 209.85.128.171, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e25f3748e0so32464857b3.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 05 Oct 2024 09:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728146089; x=1728750889; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2EpoCKrgdlRJ6wfGRQQgneYGadJw3jNCy2betdLDYY=;
        b=Q/vgNEVQrGkndMrIUWmaK67Ytb3QPhbqL7R85aSr2MbMivl7nL3POP9If22Kspokjo
         aSvkO74llQXMTkWQfshMckcu7nk2OGPCag723MXcqt+QFV0b8RRzeubu/sZ6onx7dcMM
         K23ZlMB/ADdc1FzdwWFzpYBboj0/R/C6PZ6qqS0bEOudUeoVJTlUvxRf0CL6ZV2n885h
         CW2mMKlGrik6rESWvWmSCt58YDcjyA4hAl16AAhevgy0GIx0dfMvcr/IxoqyGa7XQvxz
         YIqYSR1C0MjsioBysZmwZsvE7aZvUiINkM72z3zTklcbAJNz9liO2PYdSKG/bBYPSnDo
         sjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728146089; x=1728750889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2EpoCKrgdlRJ6wfGRQQgneYGadJw3jNCy2betdLDYY=;
        b=OdwDYMmG6XtwR+YprvtPIkftFlEy6tFFvFeZR+Y8A9vXsWo43LOK+fpGkEbRjwATBx
         YsWV0XzcfKk5npoptQEurOq87qY18FOxx01bs5QLeDR7F7YzQjbaw3tSE9EqXh2AFjGf
         m84VbHUSq7rg2UBv2eITbHsiwSVkTUfjx0pWm0Ju9pKbhokZ8kSMOk9hN0BDlqTFc7+/
         nc89AFos6PEjGF13kK46cnfvZ3y4EMjlzAcK7/vUnGe4S+k5Jypvz1wAiVQZ6TErTMIe
         G/QiFXwc3tmN1C9zfHoqyl6JZQhFoviv/rU1ts21uxg2MoBh1myhjsrXN1gU3rbmJlFf
         sFQw==
X-Gm-Message-State: AOJu0Yx3yPJ/ExtkP1a160slkeFdDb1o5gzmTOrb7pKcHkmxfnUi+wTo
	gOS/goDLZWgKhC2un0erLXYL9qLJ5IJVjlhjKKzU0mIk3Z0wzDSi9qxHuw==
X-Google-Smtp-Source: AGHT+IHg00y3NBj+wLOD3lO2vpavZxxmMRWdSWcV4jzuYKsYyvN32n5HbIILIUKlsdvpGmvQTp/nuw==
X-Received: by 2002:a05:690c:668c:b0:6db:9b55:80df with SMTP id 00721157ae682-6e2c728a330mr55663637b3.33.1728146089427;
        Sat, 05 Oct 2024 09:34:49 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:8a15:aa34:73ec:b252])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93d417esm3709797b3.94.2024.10.05.09.34.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 09:34:48 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] layer.conf: Update to walnascar (5.2) layer/release series
Date: Sat,  5 Oct 2024 12:34:48 -0400
Message-ID: <20241005163448.2654849-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 05 Oct 2024 16:34:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/688

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 conf/layer.conf                | 2 +-
 meta-integrity/conf/layer.conf | 2 +-
 meta-parsec/conf/layer.conf    | 2 +-
 meta-tpm/conf/layer.conf       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index c57c8b9..84d40a1 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
 BBFILE_PATTERN_security = "^${LAYERDIR}/"
 BBFILE_PRIORITY_security = "8"
 
-LAYERSERIES_COMPAT_security = "styhead"
+LAYERSERIES_COMPAT_security = "styhead walnascar"
 
 LAYERDEPENDS_security = "core openembedded-layer"
 
diff --git a/meta-integrity/conf/layer.conf b/meta-integrity/conf/layer.conf
index 292ba21..33127c7 100644
--- a/meta-integrity/conf/layer.conf
+++ b/meta-integrity/conf/layer.conf
@@ -20,7 +20,7 @@ INTEGRITY_BASE := '${LAYERDIR}'
 # interactive shell is enough.
 OE_TERMINAL_EXPORTS += "INTEGRITY_BASE"
 
-LAYERSERIES_COMPAT_integrity = "styhead"
+LAYERSERIES_COMPAT_integrity = "styhead walnascar"
 # ima-evm-utils depends on keyutils from meta-oe
 LAYERDEPENDS_integrity = "core openembedded-layer"
 
diff --git a/meta-parsec/conf/layer.conf b/meta-parsec/conf/layer.conf
index e59b60c..614c17e 100644
--- a/meta-parsec/conf/layer.conf
+++ b/meta-parsec/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "parsec-layer"
 BBFILE_PATTERN_parsec-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_parsec-layer = "5"
 
-LAYERSERIES_COMPAT_parsec-layer = "styhead nanbield scarthgap"
+LAYERSERIES_COMPAT_parsec-layer = "walnascar styhead nanbield scarthgap"
 
 LAYERDEPENDS_parsec-layer = "core clang-layer"
 BBLAYERS_LAYERINDEX_NAME_parsec-layer = "meta-parsec"
diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
index b8df817..5f96114 100644
--- a/meta-tpm/conf/layer.conf
+++ b/meta-tpm/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "tpm-layer"
 BBFILE_PATTERN_tpm-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_tpm-layer = "6"
 
-LAYERSERIES_COMPAT_tpm-layer = "styhead"
+LAYERSERIES_COMPAT_tpm-layer = "styhead walnascar"
 
 LAYERDEPENDS_tpm-layer = " \
     core \
-- 
2.43.0


