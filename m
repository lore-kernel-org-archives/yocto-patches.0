Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317E9CDD552
	for <webhook@archiver.kernel.org>; Wed, 18 Sep 2024 19:01:26 +0000 (UTC)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
 by mx.groups.io with SMTP id smtpd.web11.1833.1726686077418133093
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Sep 2024 12:01:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Inzct+7M;
 spf=pass (domain: gmail.com, ip: 209.85.166.41, mailfrom: twoerner@gmail.com)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82cda617e1aso4398139f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Sep 2024 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726686076; x=1727290876; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwSTiTaIEQbGTwvDIqFeORKBv/AnGChYUnb6eMuYv4I=;
        b=Inzct+7MNW6L7c+28tgCjodnp0vs8dGIRQ7XoUbB7gzxCPNc3azR4WIJtsSgolStoS
         aGi2pAVHKNa/tYd8iwnvEze+qZVEddZaUQaOP9Ztw8ggOxkRcI8FwCdhSFpsiDiijTqY
         G2/UId67hlvf2ziwGSUGwTxKtT/b7azdVk+pK6pR8aO8il6BJvBWUFgMMXgDS8s0uO+G
         546P54b7WezSn0wcS02yKWse5pWUBoj02Npw4UYffgxFT9s07Ort4IOd0koDoMSinPxm
         6SjfCpckkBatvIsmuOPHTE44ZKTUSO8+uOb8e+YJHocSWlMt0C+ki5NoHvmXhfu4Xr8b
         8fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726686076; x=1727290876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwSTiTaIEQbGTwvDIqFeORKBv/AnGChYUnb6eMuYv4I=;
        b=K1NPcWKcjmRiyPBsEOK308qIXwdTzqM99Wett9MpZKZnM1fDSKDIqQVuxt4L5E+BHD
         pR/7hb7jSnoBXnWv0FcNxd+pIUYvsYcdKIg+yjnw3ka1WmMjWxZPtwoSSz+Kthp3aFIO
         gWkpl60i27Lw3MggxJvnc0jFocdUBG5nBS32azFDV3k+0LeTf9iN3Tgq/NDIxne9WeDT
         LSQc8sFXZRNWWTJoRyJ73yoRyhbmiwY6h/TiZdQJcyW1AQcAA/MsupDP9ncmECi617RY
         T/Rko9gxt6AVoPKEKQYhRepnvYMiA7Ym3Bpr6rs0dNslvnDBNIJe48TF8vl4gJ36XaPQ
         VPUQ==
X-Gm-Message-State: AOJu0YwbyFW9pvJxC8wRYifNZXSlHUc1LokeUgvX0hCY6c6CWMwfcwc+
	32mUQjXml4E9XTFHUj/rQ4llN1jdSGmtkZU/Nz8KRqLxwwRdAJBQCbhWMg==
X-Google-Smtp-Source: AGHT+IFcSd+m+YA8ILOnm/Xc1nofWS7MX+U+Y2XL1Snzsqmothh76c84fq5efBVYh9+6MlpTCOO9+Q==
X-Received: by 2002:a05:6602:6b87:b0:804:f2be:ee33 with SMTP id ca18e2360f4ac-82d1f8c45dcmr2204439739f.2.1726686075542;
        Wed, 18 Sep 2024 12:01:15 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed597dfsm2607976173.166.2024.09.18.12.01.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 12:01:14 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] abd-partition: add runtime dependency
Date: Wed, 18 Sep 2024 15:01:06 -0400
Message-ID: <20240918190106.24278-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Sep 2024 19:01:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/658

The rauc demo implementation provided by this layer uses ext4-formatted
partitions. Therefore the tool required to format ext4 partitions is required
otherwise the repartitioning will fail.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../rk-rauc-demo/recipes-core/systemd/abd-partition.bb          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb
index 1952805f4a6d..d5cb42738e72 100644
--- a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb
+++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb
@@ -24,3 +24,5 @@ do_install() {
 	install -d ${D}${sysconfdir}/systemd/system
 	install -m 0644 ${UNPACKDIR}/data.mount ${D}${sysconfdir}/systemd/system/
 }
+
+RDEPENDS:${PN} += "e2fsprogs-mke2fs"
-- 
2.44.0.501.g19981daefd7c


