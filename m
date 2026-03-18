Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC70FCD0CA
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 07:41:28 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8721.1773819679405943826
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 00:41:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lYv2koIa;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439c6fc2910so4947338f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 00:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773819678; x=1774424478; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWjmXUgt+djAZAyCbcSLNucM88W5+4v91MNY+1tRKrs=;
        b=lYv2koIa0tYeUX94rEJ3NenGtzNk8/KVfRbXLw8XSHWYtYAQGieX04OuClG65i3sfK
         mY3sWBeF4C8D/HIfS8QwgWFV5KQjUWbdNwxOlLNLxsm+4SvbVnv+N0Gm4NKI2aqpreqx
         zg9mU4ZiKTWSpI0Mmm1GpeZAPyVNAjYjF+zTP5W786c5NtwZEtdFNLLM5UkMduMGv6hR
         TpFV7aL3ppfHbmoQ3WBcbJO7qFaY2bBxZn2Sjfbl+7Q5t7nGWNDA1TJZ+4Z1q3XH+UrP
         YHFOTkFhl6B8dIsF9Dk/EMPaHMo/+helmogH6F+O+nYs3FX+7wv+uQLY02JMr47Ba5hQ
         Dvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773819678; x=1774424478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWjmXUgt+djAZAyCbcSLNucM88W5+4v91MNY+1tRKrs=;
        b=Tc7mDq/hFnNnDxD9qQWmcSrycRq9l4IHz9QAIhMyIO7wd9uWZnhw9Xda4KZiicOVKX
         YawLj3Rj/JBU1ZKReYO3Cg/E0pNswSBYma33p25push0ZwTsPbKcoPFSbMnFgGi4FQx9
         PaEY0SKPYc51u57IpPsKYg1xC1BUBmcQrL7tDV0Qv+OLMdNVB8zSjndv68iuRyExda5m
         VhR9BEMtjASC+ZxJJOf6RguOb/CIoQkEibzmPG2BcfewQTLiqf+dxDlo85aE2N9ZN1ul
         VQX6cP8cEa3JOKjmhu98eV7fJCsV0wJR621bOY3JLuvFhh5A2kComRe6AN9AYpUnerQI
         a+hg==
X-Gm-Message-State: AOJu0YwcCzVsu0dHY4bI2ojp/KsASzrNBTk79HBknnbumw304XRKVFzd
	Z11R/ZfZcrC8ck4gcHjaHIErzC6y4rFk5v60zwak75EVOvN/QncWok4A1omTgSGj
X-Gm-Gg: ATEYQzxc6B9NmEZOjoinm0UBM711b4eR04dSTyzlRFQIuPLk3XLC2P6Yk5mrvZX2oPf
	WoSpfBbUPlObqIvU+hPiFKXDN0F0AdsEJgEievHoz7rcBnxv0qgh/KlHjtDVDRUPGEw+YmRm86r
	+Nmhbi0OlRWpEJUWf3J9dIkevCN2RmqebAKT+QS0zszd6HOMEYvvc/CQK7ZfhmFWOBYAETczrIS
	U3siOfQquXt2Nnho1EXHEvsxg8JQmirLN7zTKxS1Yn4sUXJwpd8DrwGX5o7NkptVfW6xTHYicqR
	H4OGdxakYJ4OEVAELPhW1049ZGBcW4tAp0+S/nOO/Cf1V+J0Cad7fEM8AjwAXtd7rVvjwPGUdHc
	IRz2tPmE1lOZdhsVT6IPgewN1CLFJbOl8uT1GPaJGGCVubVIxfAlF0VxMT6zKgi5Lsu0frLofcj
	rHuIqJ4BtUK9E46c6Rlazzcq0/5w==
X-Received: by 2002:a05:6000:26c8:b0:439:cbf3:4a8f with SMTP id ffacd0b85a97d-43b527c7b84mr3400148f8f.41.1773819677414;
        Wed, 18 Mar 2026 00:41:17 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51851e43sm5239112f8f.10.2026.03.18.00.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 00:41:16 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-security][PATCH] layer.conf: Update to wrynose release series
Date: Wed, 18 Mar 2026 08:41:10 +0100
Message-ID: <20260318074110.111350-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 07:41:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3504

From: Martin Jansa <martin.jansa@gmail.com>

Changed in:
https://git.openembedded.org/openembedded-core/commit/?id=cd1179544d74026c99a4938824146cec4f5acfca

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 conf/layer.conf                | 2 +-
 meta-hardening/conf/layer.conf | 2 +-
 meta-integrity/conf/layer.conf | 2 +-
 meta-parsec/conf/layer.conf    | 2 +-
 meta-tpm/conf/layer.conf       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 7a86054..e08a58a 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
 BBFILE_PATTERN_security = "^${LAYERDIR}/"
 BBFILE_PRIORITY_security = "8"
 
-LAYERSERIES_COMPAT_security = "whinlatter"
+LAYERSERIES_COMPAT_security = "whinlatter wrynose"
 
 LAYERDEPENDS_security = "core openembedded-layer"
 
diff --git a/meta-hardening/conf/layer.conf b/meta-hardening/conf/layer.conf
index 367d3d7..dcc4fa8 100644
--- a/meta-hardening/conf/layer.conf
+++ b/meta-hardening/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "harden-layer"
 BBFILE_PATTERN_harden-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_harden-layer = "6"
 
-LAYERSERIES_COMPAT_harden-layer = "whinlatter"
+LAYERSERIES_COMPAT_harden-layer = "whinlatter wrynose"
 
 LAYERDEPENDS_harden-layer = "core openembedded-layer"
 
diff --git a/meta-integrity/conf/layer.conf b/meta-integrity/conf/layer.conf
index 23d6848..f907385 100644
--- a/meta-integrity/conf/layer.conf
+++ b/meta-integrity/conf/layer.conf
@@ -20,7 +20,7 @@ INTEGRITY_BASE := '${LAYERDIR}'
 # interactive shell is enough.
 OE_TERMINAL_EXPORTS += "INTEGRITY_BASE"
 
-LAYERSERIES_COMPAT_integrity = "whinlatter"
+LAYERSERIES_COMPAT_integrity = "whinlatter wrynose"
 # ima-evm-utils depends on keyutils from meta-oe
 LAYERDEPENDS_integrity = "core openembedded-layer"
 
diff --git a/meta-parsec/conf/layer.conf b/meta-parsec/conf/layer.conf
index 39d1265..79acc89 100644
--- a/meta-parsec/conf/layer.conf
+++ b/meta-parsec/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "parsec-layer"
 BBFILE_PATTERN_parsec-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_parsec-layer = "5"
 
-LAYERSERIES_COMPAT_parsec-layer = "whinlatter walnascar scarthgap"
+LAYERSERIES_COMPAT_parsec-layer = "whinlatter wrynose walnascar scarthgap"
 
 LAYERDEPENDS_parsec-layer = "core"
 BBLAYERS_LAYERINDEX_NAME_parsec-layer = "meta-parsec"
diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
index 582fe1e..94ca4c6 100644
--- a/meta-tpm/conf/layer.conf
+++ b/meta-tpm/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "tpm-layer"
 BBFILE_PATTERN_tpm-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_tpm-layer = "6"
 
-LAYERSERIES_COMPAT_tpm-layer = "whinlatter"
+LAYERSERIES_COMPAT_tpm-layer = "whinlatter wrynose"
 
 LAYERDEPENDS_tpm-layer = " \
     core \

