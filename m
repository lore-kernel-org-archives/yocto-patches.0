Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50837C52D6F
	for <webhook@archiver.kernel.org>; Wed,  7 Aug 2024 04:18:46 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.25795.1723004321504751052
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 06 Aug 2024 21:18:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=GXGTsoV7;
 spf=pass (domain: mvista.com, ip: 209.85.215.182, mailfrom: vanusuri@mvista.com)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso1080734a12.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 06 Aug 2024 21:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1723004320; x=1723609120; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kfb/9BMjJFzAie6Q6/2AkUMeXzcDgDoOZVAgWh/vXE=;
        b=GXGTsoV7w5HxjjktrkG10R7q9afMXkLnwgxsFVANp+9xOHYFwWD5JM9JO9bf+58zn9
         DLVoj6SilVZ9FzGzIDW96zNuDgyTUHqno831YBbyf1zhRs8U/r1p3ipNtKAUJ5rOVxvG
         MkWOxTydHVGafVrClIwdJ/G9wYrWNIcbfNf4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723004320; x=1723609120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kfb/9BMjJFzAie6Q6/2AkUMeXzcDgDoOZVAgWh/vXE=;
        b=Vwb1Bayq+bloXte6+wS/ovUIhSs7+2OAZF8X0aXlcIsCfxhu2fBS3UzkT0Fiw5Pcbh
         j9wIo40OJ8WgFDnuCPVE0sYEsvzx4tMn116NmcrGTOyuKPeSPGAVm1PjuYXdwuhJYiTN
         imVgcES3T7wahZQhNO4+klLBl6oZBljdYhFTWXGyQVo6ShASzhP3izILNxt7XpbCyaL6
         T5VjRfPV8upPYA2nhNnzBVLlmCh6N8Ur05LYyL/qcVhdOpLM61akitFKwjs0Q+iNQQ4x
         mSEAF70ogbzuZpDzEumE8Ehada+qel0x90DsTkI856GipaOM+HncULfKRRl243j9H0MS
         veXg==
X-Gm-Message-State: AOJu0YwBHz4eukBRyOdx/PgdS3Q6oGiX4S/bnPefkF0GXWL+IqQlY0xT
	2Gmg1qX/3oLZ8qevBMvCFxj1xQtzQ5xmylHHQdeUK+VpW38aW4jHvA/kcFHMAEWT+Gy0NoSj52e
	6TVk=
X-Google-Smtp-Source: AGHT+IEvBep+oFfLgDZ/pK95u4SUkpC15J6gH7mZfgpzQwrD5P60NUsdrZe8H3WLk3IoQY2/C4JiRg==
X-Received: by 2002:a17:90a:788a:b0:2cf:f3e9:d5c9 with SMTP id 98e67ed59e1d1-2cff94581b3mr16069240a91.21.1723004320338;
        Tue, 06 Aug 2024 21:18:40 -0700 (PDT)
Received: from MVIN00020.mvista.com ([2401:4900:882d:87fe:c334:1c3f:e700:16b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b36bb52csm367592a91.20.2024.08.06.21.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 21:18:39 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [meta-security][scarthgap][PATCH] tpm2-tools: Upgrade 5.5 -> 5.7
Date: Wed,  7 Aug 2024 09:48:30 +0530
Message-Id: <20240807041830.189812-1-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 Aug 2024 04:18:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/513

From: Vijay Anusuri <vanusuri@mvista.com>

Include Security fixes:
Fixed CVE-2024-29038
Fixed CVE-2024-29039

Changelog:
https://github.com/tpm2-software/tpm2-tools/releases/tag/5.7
https://github.com/tpm2-software/tpm2-tools/releases/tag/5.6

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 .../tpm2-tools/{tpm2-tools_5.5.bb => tpm2-tools_5.7.bb}         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename meta-tpm/recipes-tpm2/tpm2-tools/{tpm2-tools_5.5.bb => tpm2-tools_5.7.bb} (82%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
similarity index 82%
rename from meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb
rename to meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
index 8119bb1..859b3b4 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.5.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
@@ -8,7 +8,7 @@ DEPENDS = "tpm2-tss openssl curl"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "1fdb49c730537bfdaed088884881a61e3bfd121e957ec0bdceeec0261236c123"
+SRC_URI[sha256sum] = "3810d36b5079256f4f2f7ce552e22213d43b1031c131538df8a2dbc3c570983a"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
-- 
2.25.1


