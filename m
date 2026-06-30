Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01897C43458
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 16:47:35 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26013.1782838049491372828
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Jun 2026 09:47:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=XErOAuEA;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b7cd27c6so1336415e9.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 09:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782838048; x=1783442848; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BNIwtacU4vPMXlhHSeUwzTu1ESIL9ke7YFDA1x0CjLg=;
        b=XErOAuEAZDjKn0i+XgZ2hKDNZt1satNVxD9h6KueSY/4S+PWEUMwedTOBydkyNOmJj
         ychaaROpae+fKOU+xRaarx+7B59f5wgCpc6y2aWgUjNdTHZ7MpYTbWXmyJQYj7OEA2do
         RcNSlhH0qy3Be7GqPWPQ3uIm+cQ9o2G1oaHoiPVO1M5UAVwggTZnruJK31KHER/+3COm
         wHbb7hTZp4zOw3M1o42Rka/xLZTh/sD583OIDFtc8RRcNcB2sP3qEEsXCev4qF+B2h5X
         uUL61v1LETxr/2NyqqKFIkwt6y5qGm0L6rKFrr4EPBiuQ4cdtbvCCXuBB1bZIxYE3Czv
         7Ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782838048; x=1783442848;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BNIwtacU4vPMXlhHSeUwzTu1ESIL9ke7YFDA1x0CjLg=;
        b=fTbMuZqptUMcS8V7vKHGiAlCkvt6hJtI3KPE5imrwtOXOd92YNdIytUunDltAY6g1r
         26PhoXmejeN1HUljXduyVBulzpgiemT3++/Da8kJOfe5vakD1dHa5x1rjhD0Rz1O4HYv
         WOtgrPmgddLf3yflwvSfNA0C9EDnQ+zjgZNNu6AkTzP0Z6pC6K3JbMKiDK9Z+46MZRHK
         1fGu8ftPnrxpxszSJFhcN/4xXs5p3WZGuh/7mjmqQPE2Xrv1TsEM44DKlO/lyl9pkd0D
         SpaRQ/IOAsk/EONUTsThYKwPiK3IxZ3FsvgnzZzB7dNKqIGHhK9nw4/zRVstCqEtskoj
         HQiw==
X-Gm-Message-State: AOJu0YxLDisd18BqskMN1mJ3vEiKsuLhBBeYZxvvPCQKKAyGwehnZq8H
	nE5lnnGjEdLi0kVkwuok7swU2qDllyBsCPnR1n/lA0/D8UossT4h4c+9AK+H79v8
X-Gm-Gg: AfdE7ckb23W+cKvOpAv5aMJMI4MkeW33EAsYO6iRjMXkqfP0vQBaqfCZzmWBJeg7LAL
	9b8qBV56VbMBOSZtRcFpVHjULKI4E2lg3PPmEUwiXeb7PBUAOJx1S5+rQSG1KQNFUf9M1YCGgcr
	Bn6I05gCebziGQq5x44pp4+xA0MvhQGvD5KlJ7gLGUkHS6UxPuWfEn8gXGk6ZezTefB7taKG9Zu
	Y5nP69uI/1kvP7732XO5eejUQh9jMTmPnRmrXtIKcqLT2XXDScofiDlRx+U9ZwgW8gnF9DeYMew
	B5nVGyVMP/dw/WFB+lxTWp/LlmaX2sfxwTnSXjxolSS+UOjuQUWLmgSj6Rl/4YfCpl83wf/rgi8
	7AJMPChDIRDqLZa83H8bkhv78c9qRGomiiNHmcmVyidmFArlG7gTjecsXhn4KdtFDIBc/UT7dna
	gAE+spdXciDwgoFbPSSI32qAjQ+HuKKSnSPwQJeyezvRbiKsRrx9EhUVSkpUE=
X-Received: by 2002:a05:600c:5299:b0:492:5e96:e164 with SMTP id 5b1f17b1804b1-493b82c85dcmr32431165e9.7.1782838047500;
        Tue, 30 Jun 2026 09:47:27 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:be6c:923b:3e90:8d90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be45f244sm9661035e9.0.2026.06.30.09.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:47:26 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [wic][PATCH] bootimg_pcbios: fix examples
Date: Tue, 30 Jun 2026 18:47:01 +0200
Message-ID: <20260630164701.651165-1-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 16:47:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4331

The command part (or partition) takes the mountpoint as an optional
parameter. If set, mountpoint defines the path where the partition is
mounted, or swap.

This fixes the missing leading / to boot mountpoint, and replaces the
roots mountpoint, with its typo, by /.

See commit 5cc8c767e31 ("bootimg_pcbios: add help and usage comments")

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 src/wic/plugins/source/bootimg_pcbios.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/wic/plugins/source/bootimg_pcbios.py b/src/wic/plugins/source/bootimg_pcbios.py
index f87c337..a8598ac 100644
--- a/src/wic/plugins/source/bootimg_pcbios.py
+++ b/src/wic/plugins/source/bootimg_pcbios.py
@@ -54,10 +54,10 @@ class BootimgPcbiosPlugin(SourcePlugin):
 
 
     **************** Example kickstart Legacy Bios Grub Boot ****************
-    part boot --label bios_boot --fstype ext4 --offset 1024 --fixed-size 78M
+    part /boot --label bios_boot --fstype ext4 --offset 1024 --fixed-size 78M
         --source bootimg_pcbios --sourceparams="loader-bios=grub" --active
 
-    part roots --label rootfs --fstype ext4 --source rootfs --use-uuid
+    part / --label rootfs --fstype ext4 --source rootfs --use-uuid
     bootloader --ptable msdos --source bootimg_pcbios
     **************** Example kickstart Legacy Bios Grub Boot ****************
 
@@ -66,7 +66,7 @@ class BootimgPcbiosPlugin(SourcePlugin):
     part /boot --source bootimg_pcbios --sourceparams="loader-bios=syslinux"
            --ondisk sda --label boot --fstype vfat --align 1024 --active
 
-    part roots --label rootfs --fstype ext4 --source rootfs --use-uuid
+    part / --label rootfs --fstype ext4 --source rootfs --use-uuid
     bootloader --ptable msdos --source bootimg_pcbios
     """
 
-- 
2.43.0


