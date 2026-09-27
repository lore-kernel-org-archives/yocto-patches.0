Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB109C9830E
	for <webhook@archiver.kernel.org>; Sun, 27 Sep 2026 03:28:51 +0000 (UTC)
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30918.1790479726884017779
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 26 Sep 2026 20:28:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=siQISZAH;
 spf=pass (domain: gmail.com, ip: 74.125.229.12, mailfrom: raj.khem@gmail.com)
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so2885319eec.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 26 Sep 2026 20:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790479726; x=1791084526; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WRJ9N4xcISjSKoI+Y4vkYNuc+6l4nByR93Qdy23JU6s=;
        b=siQISZAHscp2oGDDnW/2m8Gw6lfPf4DvZweMX5/QRyXq9IXhYjgSq3TUKbkqbSScGz
         GkmC96BAkNBcB44XJlOF0v/SLgF8fXYP08+FguAShOmEn++Siro05VEpH/y910TS5A9s
         Iw7EKEmlLE2XwFvOtq15exxX168GriD4n3ZKrRk63wQKGnOeqoRaRpgFqO7gjGY4AJmf
         hykKDrLlbLvQWbovVtRra3HLFw/ecnhFZxEX/ny33DSm3qAb2kbS7VFUyVlOzEjk3jSt
         wRBQo1y/N3LkBfAmCg/DGfS+0od/Rn60CsoHcJEv8i7VTqcR6eJq2qGjeiurpjWbXOIt
         ZlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790479726; x=1791084526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WRJ9N4xcISjSKoI+Y4vkYNuc+6l4nByR93Qdy23JU6s=;
        b=aB6ytJ8TxohGluGwmXz9daomfsaFGPkjdqgR4dvyo4RwGQgMghsKrgC2mGMPxX2qeO
         ypFJJvPqRsgPByIwTqQvWzNI3pxoGF4dt9exfpNE2WWrnGGOpBC6y+AYz/i8FevCnvfY
         vRJHGF9W8onBIvL6jTR/wyKY83T7joPXDRx+8KbWbep1wmfJW7TvZzL2XdNHzIibA0Es
         kgVTlCGBhTaphJ83zE0U5wUaRjtHtbetSD01FvypQ/8NzugW0hGTxbWZUE65Gi3QJRJB
         WvyvlvXLCGQbXJ3yaUPHkL1SkdbuSINEwvhTLyjsP0k+00tcfbvr/8GxYv/0ZX0ZD8Jd
         X2dw==
X-Gm-Message-State: AFq9FYIPKrLOiW5o/vUygdewg8yuuDzt2mKHCCvjjCsnm/vkljOk9x75
	vvdqs+z90uwNQd5htGPxPynfD/ToW8sKJ2ImB4XgqdeEGeNkRgxdgxk1wOyMelJu
X-Gm-Gg: AYBFou1x3EyQK2E5Yctwr7pxoE+0lsmQm1JVYBK1xXxQkTYvgBniwGgZyKjPr00Vg8T
	HkbXKTqvCipRVSRQfmBy5blU8u1ZsCY6xD/Je5+8OCUmE1P5TxKnm2oB6JCgqjm9TnvpQdp8sRo
	CGhC8Mm7K9kKT96NKPLUK/SO96hgvPmHuF3zPFGq3+Run3tebanWaogtiKtg1QfkOXZX4U60p3O
	XR40ubyjlXFdmxAMsaaILa2BANd8x9PI4YbP2LLa2iAlfSYY+s55kpqMRzuIgEV4A/6tZyEepMM
	FRR4XelBVDQs6ArhqSTCsarkpdLxVbuAyE5w+/It/5fhu8bj3rVZVwm6/NBExKDsDldAPNmUWIf
	4JX3DY4EkgX6C6CyzqUgq3eFGmdaI95hfHwxCRya45YFAm5CNVaTXtj/t9e06nEHjg//K3PwA38
	JalYWREj7Y/rtBuIAxj46tRGhcHkpgVhLYn3sE2ioA6oTMWGhZvwRHR8tiR8q7d2nT+NY1wc0N0
	Mdlp17VRL++K2VCwuiKUAaqzluiJlh4FKkpMY0Jt2V3Dx7Ke7OV0oNKM5htUNteq9LUJr3eR6eQ
	h107DHdESw6I3MJN6LX79cUVwABzTTXyFJLsCGoNmU4iyfTjgQfXOhOzchfRcvTgaVgl7suKOri
	SnQ8+ip5fO8qUYuhKxg6dlw/367v3X5FCRTCK74vOVmcDe0iKnxaboB///ZfVOPXG6IFCz4huyY
	hxgeH8jKFtEMtxQmn1FX2UDMtog3tIll5CZUZsu2yVdLgg0Vqp
X-Received: by 2002:a05:7300:16a8:b0:341:4466:1cd2 with SMTP id 5a478bee46e88-34271d8bc23mr4574666eec.20.1790479725927;
        Sat, 26 Sep 2026 20:28:45 -0700 (PDT)
Received: from apollo.localdomain ([208.95.233.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3433628f5basm9514305eec.18.2026.09.26.20.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 20:28:45 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
X-Google-Original-From: Khem Raj <khem.raj@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <khem.raj@oss.qualcomm.com>
Subject: [meta-security][PATCH] layer: Add blacksail YP 6.1 to compatible releases
Date: Sat, 26 Sep 2026 20:28:41 -0700
Message-ID: <20260927032841.305194-1-khem.raj@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 27 Sep 2026 03:28:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4957

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
---
 conf/layer.conf                | 2 +-
 meta-hardening/conf/layer.conf | 2 +-
 meta-integrity/conf/layer.conf | 2 +-
 meta-parsec/conf/layer.conf    | 2 +-
 meta-tpm/conf/layer.conf       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index f0d8bba..af9b105 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
 BBFILE_PATTERN_security = "^${LAYERDIR}/"
 BBFILE_PRIORITY_security = "8"
 
-LAYERSERIES_COMPAT_security = "wrynose"
+LAYERSERIES_COMPAT_security = "blacksail"
 
 LAYERDEPENDS_security = "core openembedded-layer"
 
diff --git a/meta-hardening/conf/layer.conf b/meta-hardening/conf/layer.conf
index c95371f..ef61466 100644
--- a/meta-hardening/conf/layer.conf
+++ b/meta-hardening/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "harden-layer"
 BBFILE_PATTERN_harden-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_harden-layer = "6"
 
-LAYERSERIES_COMPAT_harden-layer = "wrynose"
+LAYERSERIES_COMPAT_harden-layer = "blacksail"
 
 LAYERDEPENDS_harden-layer = "core openembedded-layer"
 
diff --git a/meta-integrity/conf/layer.conf b/meta-integrity/conf/layer.conf
index 22d2992..e5bdc89 100644
--- a/meta-integrity/conf/layer.conf
+++ b/meta-integrity/conf/layer.conf
@@ -20,7 +20,7 @@ INTEGRITY_BASE := '${LAYERDIR}'
 # interactive shell is enough.
 OE_TERMINAL_EXPORTS += "INTEGRITY_BASE"
 
-LAYERSERIES_COMPAT_integrity = "wrynose"
+LAYERSERIES_COMPAT_integrity = "blacksail"
 # ima-evm-utils depends on keyutils from meta-oe
 LAYERDEPENDS_integrity = "core openembedded-layer"
 
diff --git a/meta-parsec/conf/layer.conf b/meta-parsec/conf/layer.conf
index e2a7a8d..fec647b 100644
--- a/meta-parsec/conf/layer.conf
+++ b/meta-parsec/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "parsec-layer"
 BBFILE_PATTERN_parsec-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_parsec-layer = "5"
 
-LAYERSERIES_COMPAT_parsec-layer = "wrynose whinlatter walnascar scarthgap"
+LAYERSERIES_COMPAT_parsec-layer = "blacksail wrynose whinlatter walnascar scarthgap"
 
 LAYERDEPENDS_parsec-layer = "core"
 BBLAYERS_LAYERINDEX_NAME_parsec-layer = "meta-parsec"
diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
index 3ea7c08..b376a93 100644
--- a/meta-tpm/conf/layer.conf
+++ b/meta-tpm/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "tpm-layer"
 BBFILE_PATTERN_tpm-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_tpm-layer = "6"
 
-LAYERSERIES_COMPAT_tpm-layer = "wrynose"
+LAYERSERIES_COMPAT_tpm-layer = "blacksail"
 
 LAYERDEPENDS_tpm-layer = " \
     core \

