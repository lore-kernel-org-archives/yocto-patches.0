Return-Path: <max.oss.09@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B91ECE57B
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 09:59:13 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.49446.1725875945107500406
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 02:59:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jUe6nhYA;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: max.oss.09@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d3e662791so83994866b.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 02:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725875943; x=1726480743; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A35NMP7uzM3yWbLoD/Pfm5XWiALpMVRuMTO973eQL98=;
        b=jUe6nhYAOxs3tAsAc16cWsp1Owyx3sACrUuY4jcfx9g//TZCFKaP3I8t/XhxEjy98g
         b2JTYUX/4V7T7nmEyLUmlUsyYHmJkzGiGDg8/UEqG1YUoOBvRhJWt1HbtqBUpsQvtb0l
         57EjvdfiPH2D+ushRenVL0AfTzFX72dRAbEDu1BJ7wHWBsflxgTNiEk8RdnrZ2tTkMaB
         XMTJq5t7QcZ7uzhlGqbkvnKLIwteXerJ1h2Dw8IrAB6+PkvJdZulbV3mWM8q1bCX3B6G
         l/Oa8RF4qwG6wXg40ccNoHnRHzjF5ukdcXJ3jtWeDlFPdpEVL+JcdYv72k6weP9Fi3TM
         04sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725875943; x=1726480743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A35NMP7uzM3yWbLoD/Pfm5XWiALpMVRuMTO973eQL98=;
        b=BLJq5D82WNVzs3DahJ5CyCidmB9FTs4pEvDTy1BYHsONPnNycV7V8NqF32clFVWnfE
         F/4aUjeONa5Z2Js88NTlCr17zW/AzUSBxRNsEWolJ2tw5Je2r6sQRT9IMyaeIjTMTdjN
         0P2tu9+TxCEgcuMVy7nyFgaiCVzWGFh9UVWNjtsIzXBpLYFs5/cohJH+Ei7rKy94Dwki
         tHMFMumsY4+WM8+/Jh9E0rn4WUiEOQEXon5yIQhuP/4WXZ65FGJ/bghYmwlXese3/vs3
         PXe1iDFQHWAHC0rczuDYi0AalZJBUfNw6rD2FQ7rDtKl9M6r/ECDY8bIGwARvDA3oZDk
         F6ag==
X-Gm-Message-State: AOJu0Ywoz/1SkaDEtX7CUWbs6rx5t5NHUWxNPhfCzNOAgTuaADf/a5NC
	7b5o40e31UaGR86IVXyCnZWpOXWfk1UevwN6IG1TJm9JCaLmYA4pJbD9Ew==
X-Google-Smtp-Source: AGHT+IGUlZO/wDZOsz0R2xR5zUpIgTKJDRjs2PDcXeFaVQAPQ+qMEspJDL6yiDvHY5NA5d+I9/clrw==
X-Received: by 2002:a05:6402:2114:b0:5c2:60ac:fdda with SMTP id 4fb4d7f45d1cf-5c3dc796f65mr10579606a12.17.1725875942324;
        Mon, 09 Sep 2024 02:59:02 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd41c65sm2794488a12.16.2024.09.09.02.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:59:02 -0700 (PDT)
From: max.oss.09@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Max Krummenacher <max.krummenacher@toradex.com>
Subject: [meta-security][PATCH] layer.conf: Update for the styhead release series
Date: Mon,  9 Sep 2024 11:58:36 +0200
Message-ID: <20240909095836.2801648-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 09:59:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/622

From: Max Krummenacher <max.krummenacher@toradex.com>

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---
Martin already sent a patch for the top layer.
https://lore.kernel.org/all/20240906163930.3167870-1-martin.jansa@gmail.com/

 meta-hardening/conf/layer.conf | 2 +-
 meta-integrity/conf/layer.conf | 2 +-
 meta-parsec/conf/layer.conf    | 2 +-
 meta-tpm/conf/layer.conf       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/meta-hardening/conf/layer.conf b/meta-hardening/conf/layer.conf
index 8da050be18fe..f5db75119f1f 100644
--- a/meta-hardening/conf/layer.conf
+++ b/meta-hardening/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "harden-layer"
 BBFILE_PATTERN_harden-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_harden-layer = "6"
 
-LAYERSERIES_COMPAT_harden-layer = "nanbield scarthgap"
+LAYERSERIES_COMPAT_harden-layer = "styhead"
 
 LAYERDEPENDS_harden-layer = "core openembedded-layer"
 
diff --git a/meta-integrity/conf/layer.conf b/meta-integrity/conf/layer.conf
index aab965225090..292ba21b02fd 100644
--- a/meta-integrity/conf/layer.conf
+++ b/meta-integrity/conf/layer.conf
@@ -20,7 +20,7 @@ INTEGRITY_BASE := '${LAYERDIR}'
 # interactive shell is enough.
 OE_TERMINAL_EXPORTS += "INTEGRITY_BASE"
 
-LAYERSERIES_COMPAT_integrity = "nanbield scarthgap"
+LAYERSERIES_COMPAT_integrity = "styhead"
 # ima-evm-utils depends on keyutils from meta-oe
 LAYERDEPENDS_integrity = "core openembedded-layer"
 
diff --git a/meta-parsec/conf/layer.conf b/meta-parsec/conf/layer.conf
index e9d02306c249..6c563237f326 100644
--- a/meta-parsec/conf/layer.conf
+++ b/meta-parsec/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "parsec-layer"
 BBFILE_PATTERN_parsec-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_parsec-layer = "5"
 
-LAYERSERIES_COMPAT_parsec-layer = "nanbield scarthgap"
+LAYERSERIES_COMPAT_parsec-layer = "styhead"
 
 LAYERDEPENDS_parsec-layer = "core clang-layer"
 BBLAYERS_LAYERINDEX_NAME_parsec-layer = "meta-parsec"
diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
index 58b61d4d2b00..b8df817b7b83 100644
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
2.42.0


