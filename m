Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C45CFB420
	for <webhook@archiver.kernel.org>; Sat,  5 Oct 2024 17:34:39 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
 by mx.groups.io with SMTP id smtpd.web10.16210.1728149674592495213
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 05 Oct 2024 10:34:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Z14GERdI;
 spf=pass (domain: gmail.com, ip: 209.85.219.178, mailfrom: akuster808@gmail.com)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e25d405f238so2711772276.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 05 Oct 2024 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728149673; x=1728754473; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0hgqX3a2GXWCimiqedBs8yZS/fbDk0o6zfnNyeTOTM=;
        b=Z14GERdIqUZ09lKdzN9FM9JY6xB+Gihb//W8SKM6215R5FO6vbHfW5HO1sm+uH8PyS
         RF6SqjsXgeHdmopULm38mpD2CurnyfQNwzktFw+boWynWqtGWBO6MgesaalVy6pqUFjk
         3IgI6Z0EaLP4MBQCHs+jFIh9S2AI2lijjyZMK/zH/XQFUWyAi8poC1ounIr84RJkWv1s
         L/EwhoXldKwnxsQJEL8nBKGIBD6Qz0mn7OY6fd/zwKT46iRCnEswzuG1E8hJWlbG99bI
         zxPJI8dR+NvFfmfc9V8Dd486GP6zaCt6e1L4kGUJHex7YgbgdgcuzpKinaacJCyxM3EV
         jVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728149674; x=1728754474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0hgqX3a2GXWCimiqedBs8yZS/fbDk0o6zfnNyeTOTM=;
        b=uY8pyuMvwikw5hVQQThjKVn/4DcpC8L1W1oSDIAH412yymH3oTLYoUCV+Ggez9vNrQ
         lu9M0heaHlwi8I4LdF0+cHhV8fiKCy12wmb95JcsOedJ0RLbPnE04suwsBW0hd0lsWtL
         xPnSF2oNQacsXT8PIRGFq0GLaq8ESqyWdNHpMR4AOJHNLNV+aoNl1/gOm8awyHRHwCjp
         bB9j4RiNW9UM09XOM1mC3FxBGE9HZRSNuud8UsA5G9j1FCiADucm+pefKa1xbk8KgMoI
         W6EJPu6hL6h9jHn3jmii8V1RE+FKr5rVi3cvcl3cYs/BZcFTF8+t2hhA0D4sQ7QVWbnO
         Xpfw==
X-Gm-Message-State: AOJu0YyVsal9TzZNVpL0tvg6McAXrm4OR6TjzlPitR4l/JxDKL8L7ixh
	2U2XEKs5TjECe9O4B0W2Vt48cXxYD6IVMWHXuelGu9hMKitW5oCmueb5Jw==
X-Google-Smtp-Source: AGHT+IHtpmXFgkBI8hwWzU/ySeZauTeBNIUnrInlwnekBWPtlPZVI5zACodA+i+b/zYRzVxVSH6raw==
X-Received: by 2002:a25:8603:0:b0:e26:f76:9c12 with SMTP id 3f1490d57ef6-e2893963630mr3313835276.55.1728149673683;
        Sat, 05 Oct 2024 10:34:33 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:8a15:aa34:73ec:b252])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a5c3a3fcsm345137276.20.2024.10.05.10.34.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 10:34:33 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/3] tpm2-pkcs11: update to 1.9.1
Date: Sat,  5 Oct 2024 13:34:30 -0400
Message-ID: <20241005173431.2697319-2-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005173431.2697319-1-akuster808@gmail.com>
References: <20241005173431.2697319-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 05 Oct 2024 17:34:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/690

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../tpm2-pkcs11/{tpm2-pkcs11_1.9.0.bb => tpm2-pkcs11_1.9.1.bb}  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename meta-tpm/recipes-tpm2/tpm2-pkcs11/{tpm2-pkcs11_1.9.0.bb => tpm2-pkcs11_1.9.1.bb} (94%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.0.bb b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
similarity index 94%
rename from meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.0.bb
rename to meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
index 59add84..a7d8170 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
@@ -8,7 +8,7 @@ DEPENDS = "autoconf-archive pkgconfig sqlite3 openssl libtss2-dev tpm2-tools lib
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "35bf06c30cfa76fc0eba2c5f503cf7dd0d34a66afb2d292fee896b90362f633b"
+SRC_URI[sha256sum] = "ce24aa5ec2471545576e892b6f64fd873a424371bbf9be4ca3a0e689ea11c9b7"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
-- 
2.43.0


