Return-Path: <aleksandar.nikolic010@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDB1CD5BB1
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 16:27:19 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19394.1779726435626640320
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 09:27:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=jvaI/WO/;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: aleksandar.nikolic010@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so5932942f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779726434; x=1780331234; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kdSh6B+zNnuU2tRJWs7MItaB/0+l4mv5GN5EF2zEXKM=;
        b=jvaI/WO/WGis1/pqGaZQpg/whpoS27qHgfteD8/SBBcBnqE4/3BBQpC6JKPSZTlMtx
         6N9i1/6NmIHk6frXIP/sFhVImQBnnNftHMn7GRJ/ekGAfMBuSx3L38y6/4gDRtT9s9Iu
         ZQ0s38FNEy3fGZD7p47iEoe9XwLpLWvVpG9iH5V2eBMUJ4Sic5tl/jLH7KKen9XMKXz+
         p+9Kws5AYc7IK5xmaHFpCW4XWS0n5NdG4r1BtuVFWn+24Euw5zTFTN1UoUT2v5PczPDn
         lM6CD3A1QDLEBwZ/Aeg8C/FVeJgxJnlPuJnKnC4EChYjJWyN38nwIl31BCKApediYFrL
         ogQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779726434; x=1780331234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdSh6B+zNnuU2tRJWs7MItaB/0+l4mv5GN5EF2zEXKM=;
        b=jxfnHYXFt4njMhBJsxPcFhHYCRXMP/qpbtfE7Wiu+FsQ3JElWzbD8f33u7g5Q45UvO
         zacS2F6Dd2SGHyrtKMKAul6Goe2AZpmsntJPgxLtU8ctPArVIyS2NgfJgVYcfsd5L6Az
         HHy/drBlaBspoVzs2WvQq9u0IVEY3RR49NvCZTEid9oAV0CatJokhNzaxWE3NHdZ7Yq/
         tvaLf8vDvUtg5MT8xS0wZHEYSisuFjRk+CkAxcTLrp8j/hEVxidg40qVH9CsmKxVAvuP
         4Dclj0VRxO3uHyZdnQm5u2L0sJJ0UHf6m+g+TjGum0ZYzEAKtw+UYwoxVLo9R1jRzgVJ
         ltlQ==
X-Gm-Message-State: AOJu0Ywmkg+SkSVuki/4JgbtksVQIr/cTSCieFjbdiUW/qZm1WUFUvvr
	mYFuTiZnTbjnf2l0sZWJTljwdvkYAP+zy5vO6IQMFjMmPttTxaS8DDEEUgVihQ==
X-Gm-Gg: Acq92OHL3AM2eUZE4fVbNyN+raWd+fhHEI/BAUA3aik13k8F0UdITbbMb2Z5vWIobgv
	7FSzihYpPhJhb8i/Q5DYZwyKCMhPDybDly3wRmFc459bkGcuA4UoaDX3k26GrTOp13QJNC7SGoC
	b2lZ6YhCUGPZC7u2BV+sjZdMr06hcpJYzphVgiKD4MOsHXKQyTVfU0lkRvUL8lcWeEWz7PVALh5
	DA15e5gU9rsWuFhhzQtSL1PsVCluTOjMXElvso72057P2+FfgKtRANGPcRc84+trSdBO/Ftgagy
	78GOHl6IVAQYi+OaZf5Ips/f3EtA5ZB29Xo37YG7LCNgfcq6U3oQ0BFxE30+qEFOBjO0XUCryEn
	5ei3gUtsYOaxEiLNITjna1PuWW4CumV28mcHY9DaEkXMMN3SN8LjRCnNXNqpYds1hTaAPPnclUJ
	JHXUFb6INdez6kM9qdM2G7sbeUZ8coStSvHBy/
X-Received: by 2002:a05:6000:2481:b0:43c:d665:3830 with SMTP id ffacd0b85a97d-45eb39e963bmr27212319f8f.32.1779726433822;
        Mon, 25 May 2026 09:27:13 -0700 (PDT)
Received: from acert-swift3.. ([2a02:810d:60a:2b00:aced:52e:5917:f55a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6bc5479sm30174442f8f.0.2026.05.25.09.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 09:27:13 -0700 (PDT)
From: Aleksandar Nikolic <aleksandar.nikolic010@gmail.com>
X-Google-Original-From: Aleksandar Nikolic <aleksandar.nikolic22@pm.me>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Aleksandar Nikolic <aleksandar.nikolic@zeiss.com>
Subject: [wic][PATCH v2] wic: Fix updating fstab for nvme devices
Date: Mon, 25 May 2026 18:27:11 +0200
Message-ID: <20260525162711.282346-1-aleksandar.nikolic22@pm.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 16:27:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4046

From: Aleksandar Nikolic <aleksandar.nikolic@zeiss.com>

In case wks file references nvme, update_fstab() function will not add
prefix 'p' before the partition number, as the if condition only takes
mmcblk into consideration.

In case of nvme0n1 this leads that following entries are added to fstab:

    /dev/nvme0n11
    /dev/nvme0n13

instead of:

    /dev/nvme0n1p1
    /dev/nvme0n1p3

The patch fixes this as it extends the if condition and adds prefix 'p' for
both mmcblk and nvme.

Signed-off-by: Aleksandar Nikolic <aleksandar.nikolic@zeiss.com>
---
 src/wic/plugins/imager/direct.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/wic/plugins/imager/direct.py b/src/wic/plugins/imager/direct.py
index 832d0e6..76d0f73 100644
--- a/src/wic/plugins/imager/direct.py
+++ b/src/wic/plugins/imager/direct.py
@@ -134,8 +134,8 @@ class DirectPlugin(ImagerPlugin):
             elif part.use_label:
                 device_name = "LABEL=%s" % part.label
             else:
-                # mmc device partitions are named mmcblk0p1, mmcblk0p2..
-                prefix = 'p' if  part.disk.startswith('mmcblk') else ''
+                # mmc and nvme device partitions start with prefix 'p'
+                prefix = 'p' if part.disk.startswith(('mmcblk', 'nvme')) else ''
                 device_name = "/dev/%s%s%d" % (part.disk, prefix, part.realnum)
 
             opts = part.fsopts if part.fsopts else "defaults"
@@ -269,7 +269,8 @@ class DirectPlugin(ImagerPlugin):
                 elif part.label and self.ptable_format != 'msdos':
                     return "PARTLABEL=%s" % part.label
                 else:
-                    suffix = 'p' if part.disk.startswith('mmcblk') else ''
+                    # mmc and nvme device partitions start with prefix 'p'
+                    suffix = 'p' if part.disk.startswith(('mmcblk', 'nvme')) else ''
                     return "/dev/%s%s%-d" % (part.disk, suffix, part.realnum)
 
     def cleanup(self):
-- 
2.43.0


