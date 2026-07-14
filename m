Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6685C43458
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 21:38:36 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34.1784065110330260239
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Jul 2026 14:38:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=klhJyC8E;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c1efb503so6869945e9.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Jul 2026 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784065108; x=1784669908; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0d+Wfp4e07ecFxqn6rLZOVdfTUvk77KVlyXoxQuWDHw=;
        b=klhJyC8EEjB6mLDjlXD+Zor+sq6KF89dEqqaSJUJtyrwQgDCNnOTODsFFT7CgeM+mw
         EZQuaEpSHQ2OCzrcNHE1w676Xutn3fAGxmLjepUHHxGfr/uk9SDpMGCRZtZgTFJu91LE
         Vgkx1IpHxqD2GuNlTvNUGkoZqxqiwSaLBz0VItgZfYzbj1oFMk/Gu2gzB+b3dXKFrRDv
         uqpyqqqkfLbiiQkQnmgbElx8UqlfR3LyICtbycD1L7E2uB1w6G8kDl4K/k1HSyfurTWb
         HF3xz84cJeO+ka5zMNz+GwVxX9vOFjidIuEVMvaw1Te4xdbbyWquKf3Wcaj9UITljU+d
         yNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784065108; x=1784669908;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0d+Wfp4e07ecFxqn6rLZOVdfTUvk77KVlyXoxQuWDHw=;
        b=ENIh+LRxSpATgsv+oa4Kn0EP12R+lm8HCA0XUGxulXTcrbdS8OIdRnkwF985+mCbhG
         b0lrKQEZm0WD0MAI6M8kDDRoGfgP5DJBGO9JNo0BJCcdue7dYShPOtrcobht/gPaHEfN
         x2oItAJvTwAIObwbXAlmY2ZvQKZXPtOcqRqbaQwcDwhff3NAwIbuikPIct6QsoC2aF+G
         R+kx8pR3+LrmyZWFnjS63pD3IFBGU6eb7OiQIQgTPdxVLnQesbbxyKBnAXPUIO2B1Y91
         PjcO2xY1Q6RzwkKK0ICEt7Sh7PW2mBDGrqPkxs3yGu/JRoeGX1MEW+iKQE+c0qEX3ENH
         OX2g==
X-Gm-Message-State: AOJu0YyoWF4qWkh8VnH3qISLngCPs6LoT8c4HV91oy12HRLA/BG0ngJC
	tbIjxupSF6cxuZxGIh/ax0s8bV87BdRe/+76CZHUgRWZi9dQi2VE9UTZPdT203Kv
X-Gm-Gg: AfdE7cmH+QvP1jIYhexdS8cp3yW+aIwBClybPeRIjx7Nk5Oi9A3mAN6olTkyLCeKXHP
	pJw9uq10PVuXd1COeDhLAYy7vinUi2BnOf65Mu99gVjB2jT1UKFRyt6Lm/X8N1Q7H7C05FdJ4p3
	ojRLoLkUUvIF67vrdFi7IwhI+5oCPuBe5Qs3LvOSjopHhTod4nTF7Gm0IZVOp096w4TyjGPK3Gr
	XAgNO7XIBvkivnY9Vtb7szUuvY6xl7eE2T56jZf2RUnEoc+Qwh/C/ZxaCgE+5lV2Au7HzDZiyzG
	bZBElAEX6pK0iFKENqIuOgOdxqMvrYoD/MvTrL4ie3r2Zy8Bl23JkD1Ydd2vKsOfiAEHIZNi3eO
	W2oTBVTFjaDkA4OHNtEgsx/24YcPiE4Xj4CqjUlLCosSulhSX2pgfwfdHPRy7BrcY23YHxB8ivL
	1qlEsWyGkHZiRKFztuGne43gqOb8bJlmUsjYowQVfUhxBKSL4JHZQ7p8cnxWU=
X-Received: by 2002:a05:600c:848c:b0:493:b6a2:858d with SMTP id 5b1f17b1804b1-493f885b387mr81474115e9.6.1784065108453;
        Tue, 14 Jul 2026 14:38:28 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:355b:e484:ed0c:db71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32c65asm101744445e9.14.2026.07.14.14.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:38:27 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [wic][PATCH] wic: bootimg_efi: fix debug output for mkdosfs
Date: Tue, 14 Jul 2026 23:37:41 +0200
Message-ID: <20260714213742.1630284-1-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Jul 2026 21:38:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4473

Set the copy output correctly when making the filesystem in order for
the debug log line to correctly show the made filesystem.

See commits dea8d761712 ("wic: bootimg_efi: fix debug output for
part.include_path") and 5643596fd76 ("wic bootimg-efi.py: keep
timestamps and add debug prints")

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 src/wic/plugins/source/bootimg_efi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wic/plugins/source/bootimg_efi.py b/src/wic/plugins/source/bootimg_efi.py
index fe6c222..6c206ca 100644
--- a/src/wic/plugins/source/bootimg_efi.py
+++ b/src/wic/plugins/source/bootimg_efi.py
@@ -419,7 +419,7 @@ class BootimgEFIPlugin(SourcePlugin):
         sector_size = getattr(creator, 'sector_size', 512)
         dosfs_cmd = "mkdosfs -v -n %s -i %s -S %d -C %s %d" % \
                     (label, part.fsuuid, sector_size, bootimg, blocks)
-        exec_native_cmd(dosfs_cmd, native_sysroot)
+        out = exec_native_cmd(dosfs_cmd, native_sysroot)
         logger.debug("mkdosfs:\n%s" % (str(out)))
 
         mcopy_cmd = "mcopy -v -p -i %s -s %s/* ::/" % (bootimg, hdddir)
-- 
2.43.0


