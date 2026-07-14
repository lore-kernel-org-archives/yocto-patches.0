Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0AEC44507
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 21:47:46 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.199.1784065665596179932
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Jul 2026 14:47:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FAz9D+gh;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-46f88060e8dso747832f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Jul 2026 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784065664; x=1784670464; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=30V5SVqG/XQJO8Wnys8p1XaQQnGbmUUdpsbywqxq6TA=;
        b=FAz9D+ghBE5RbtEwrAf6iZ8esNHacFYLEejQ1E4Oa9mueCXLYsL6RVB/6SZkxO23ek
         YtAeKSsYK2+rXj+Gqfl+YYSBpy1h2av4TbefOKYvpnQ8MW9H34uCXkBpy4q/QlUDoeZc
         HpCs5E1Ev1A05P+tkiXc8K76Jy2fQzBMH0SSveV5SEM3uIv3AEePLm1zHGyR/7DiI63W
         SnrQ1++3fMWW3/xpZ5YdJS4zuLJxEV+KG9wvUQr+lPsuI89AkoCIroUXL8l3km3EZfqZ
         IdpmHu6EL4PPwXbMEEBZs6npzySMIE4FCNp17LJL2VATGU2OtGRb8boZ1UbpGnuf8yxt
         0V0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784065664; x=1784670464;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=30V5SVqG/XQJO8Wnys8p1XaQQnGbmUUdpsbywqxq6TA=;
        b=GTuvyqKn8Q/2eNSfYuySqj+fYTlSL53WbrBr5aBsaFimo5PkTwSezHrFI0qoZKFoHE
         HroN7ZgJdPeAbPcgKM6N+L9E56fotemdXByveTr5lTsAU6cJWyTyYUB7BLh3za0vl1L8
         lBqPtM/URc0zY4tiCtmc/iY4iovJ3oa4ZT1IJvmgU0vCZJiA3W8PGVcbznHynmmiGsU4
         wg/xYr0Kw3+UUlJFBB+ek7tUoDrNa5REPFxaMPaCuQxshBjkyjNLtv1Q2RYf166mTeeJ
         bTooD+EzAEuyHJ4z7y1YBBS+BKf5XdDFPSz7SgyzwExj6a/hIEMsrQ7nzQvdKWqDSwbY
         L+iw==
X-Gm-Message-State: AOJu0YwmYhR2ivJDhewG2bWdnHZ2k9RwOg0djjbzwk/ecDMwGGFTTBbU
	TtyFtVk4uhvHoKWyPohZVbtG9E4cn+ZPV+VXGqQsoqCjdrDUo2AEVpi8tuG41/Nn
X-Gm-Gg: AfdE7cm+WcKjY6S7SGqGPC9TvL4qZbEUhAN6+DjC+K3Vb4+xd4LZolhVXGA42+wbFgk
	5Id1BInCuFxtnTlCPDHbYZEy7nxEbInQLaiViQlkG7pPezUj6RCrKQVBVA+Q0sllVJ0seqBZEcL
	A/Bsb47zxQ3eLW6x+SznHRHQ0BjvowU/L6dpgoiqdc7d6VBnHuySlYOa8JtaMT8bMM0JqGW1X0c
	LO9JT4RaDLK05kEFTOZivNbf371fnY6LM205T5eixGk1UWC/wxAxcSk+ggleafBTJCPjGWOR6vD
	95h8GObq7Jq6ZJ+Tj6EF3lIKKtAmP2GMCMcRYw6Kiq38xrtL/nUJzHvYn48tiEZGVqKLH6XMFtw
	B/ZZckeWpWX5ThZCtQZbTTC4qbDTcMjeglWpBCKb5fbH9KpBlpgC4LQT8tsG9CWfZj2UtLVDzGR
	KPJZhLx+elCsZkfuoQqSoefbq3MEZwsLPAoxrwcs6SFqj3BXCTOZxKyhT63uU=
X-Received: by 2002:a05:600c:4444:b0:493:f965:2b85 with SMTP id 5b1f17b1804b1-493f9652c65mr90675235e9.4.1784065663736;
        Tue, 14 Jul 2026 14:47:43 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:355b:e484:ed0c:db71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f9402sm106456515e9.13.2026.07.14.14.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:47:43 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [wic][PATCH] bootimg_pcbios: add debug prints
Date: Tue, 14 Jul 2026 23:47:33 +0200
Message-ID: <20260714214733.1631804-1-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Jul 2026 21:47:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4475

Add prints to see what is being copied to boot partition.

See commit 5643596fd76 ("wic bootimg-efi.py: keep timestamps and add
debug prints")

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 src/wic/plugins/source/bootimg_pcbios.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/wic/plugins/source/bootimg_pcbios.py b/src/wic/plugins/source/bootimg_pcbios.py
index f87c337..8310cd5 100644
--- a/src/wic/plugins/source/bootimg_pcbios.py
+++ b/src/wic/plugins/source/bootimg_pcbios.py
@@ -299,12 +299,14 @@ class BootimgPcbiosPlugin(SourcePlugin):
         label = part.label if part.label else "boot"
 
         sector_size = getattr(creator, 'sector_size', 512)
-        dosfs_cmd = "mkdosfs -n %s -i %s -S %d -C %s %d" % \
+        dosfs_cmd = "mkdosfs -v -n %s -i %s -S %d -C %s %d" % \
                     (label, part.fsuuid, sector_size, bootimg, blocks)
-        exec_native_cmd(dosfs_cmd, native_sysroot)
+        out = exec_native_cmd(dosfs_cmd, native_sysroot)
+        logger.debug("mkdosfs:\n%s" % (str(out)))
 
-        mcopy_cmd = "mcopy -i %s -s %s/* ::/" % (bootimg, hdddir)
-        exec_native_cmd(mcopy_cmd, native_sysroot)
+        mcopy_cmd = "mcopy -v -p -i %s -s %s/* ::/" % (bootimg, hdddir)
+        out = exec_native_cmd(mcopy_cmd, native_sysroot)
+        logger.debug("mcopy:\n%s" % (str(out)))
 
         syslinux_cmd = "syslinux %s" % bootimg
         exec_native_cmd(syslinux_cmd, native_sysroot)
-- 
2.43.0


