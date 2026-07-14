Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FC9C43458
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 21:40:06 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.59.1784065201693815472
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Jul 2026 14:40:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qe8ikhGN;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493bb0e2894so7262355e9.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Jul 2026 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784065200; x=1784670000; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lT+AnOZkRJrc0KU48nIbWMA6qXeKcS5SsFTr5sl+/9Q=;
        b=qe8ikhGNv0ABa64arrRPcUCs7WQoZak2+CUYoFBWOXlERauNnr/oecVWHEaEPojBYs
         1a9ZIDGuJw2Qq3GHY0kVVMtJ5RZ/u9v9eC9kvuXzdGISnWZg/BMwiTIRxC24xJ1eFt72
         +m1uoTJbuBa28twHDdvEMKokvk+bEqeneNJGlbB8bAQRSRcj7XfOttKt0brFz2neZ336
         /cpP397Ji25C2/u5DXTkfGE0HPy4GFlHB4Jo/TbdTymLN1Stx028J0DAyThCx0g8L8gF
         XwX+IvWC5F55QveSyYNxnmscUXCGwTOQ7G+7QEdJRLcHztMdHADsqZtb2HKt+0G3/QNx
         FkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784065200; x=1784670000;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lT+AnOZkRJrc0KU48nIbWMA6qXeKcS5SsFTr5sl+/9Q=;
        b=QYnu2YnfMuz6nnizWH1g6igec/cmhZPT2xMWCcs3G34UI7rqZSVVxhD3yBBuq8iTZS
         /isCZXx/4cDi41+Bro0Bxh6EWJqudvjN8S+Ni5t2SEnNfzZMCQEkgmzGd+T6VX8/yrfP
         kDSdc09T4mqM+yLNXdHW8DhDLLVv/aFbF0yC5+8WXxMNObwaXdbyVNHiwvyRPRQIN0uX
         UUVXK2ZWIbNOLTFuCYgspHluQkGRSlll3lDa1XzRLPihGwk5NGGV8aqYBTVP77Gwi3pb
         xHhO8q8AXpdKRS8sAUuEKJ/OWhUZsn8cqE7Cq4oSW3H2+aD0Kzyn7EFloXfGXELXr5Ze
         8GwQ==
X-Gm-Message-State: AOJu0YyTh7dXiDhoyj1h56Twau8p9NucVZkN0Lpyun4de1Z8tqBWl1ZZ
	nAMzHrNGjelbzzwjo3bmL1z+vV9Ii8CzqaxGe2E4m67U4bY9rxtZu/wvS4x4zoZF
X-Gm-Gg: AfdE7clxKImpXILhq4CncjUjB5UPZX6W6hVFMLD4qsCqwxUT664xb5LsSVrBmU1bpve
	Le/6ViANspAiFpL461viOFWf6vjRsoKp5SvwLqKWB6qhefpj+6xUXOD71vSQyL/Q96iTlOUHSt1
	gMzq25k6lxFvoOa0h+EB28jOvw8EC8anvM+I/ZlAWhXHUcyxhxFiMqY5eBz5MBNy04S/IAR1XPs
	W9xt/FK/72M6F0lnBvC2tYGEcl7bE4lWH1jUef7CgjwZOl6BfRzbiUdC0Y51XhxZmbEDMEMZu8S
	0XxRKd+Y3qmbDw6PymwoSnjYowfU8s3C3bTZ5pcE9y3D8MgX0O/+V5e87tvodvajC56WEf2bleh
	WMYP9Tm6XjxBgLYpJijMx9Pr27MdhM/PoB7uOwUlXFtvaHa64WU3pIQCxAYmqXvr71EblQvf822
	HhTkkJi+67Qh3++x1WzP0AQ3X24oJquy/aaAjhF4qQbyRa/Xcm4uT/UHyyTTk=
X-Received: by 2002:a05:6000:3106:b0:47f:4f98:5f81 with SMTP id ffacd0b85a97d-47f4f985fd6mr209609f8f.8.1784065199880;
        Tue, 14 Jul 2026 14:39:59 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:355b:e484:ed0c:db71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e0e4sm11864852f8f.4.2026.07.14.14.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:39:59 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [wic][PATCH] wic: partition.py: fix output if mountpoint unset
Date: Tue, 14 Jul 2026 23:39:40 +0200
Message-ID: <20260714213940.1630619-1-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Jul 2026 21:40:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4474

Set the partition number when handling partition with mountpoint unset
in order for the debug log line to correctly identify the partition.

Fixes:

	wic.WicError: File system image of partition None is larger (70993 kB + 0 kB extra part space) than its allowed size 65536 kB

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 src/wic/partition.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wic/partition.py b/src/wic/partition.py
index 435d31d..8239dd4 100644
--- a/src/wic/partition.py
+++ b/src/wic/partition.py
@@ -267,7 +267,7 @@ class Partition():
         if self.fixed_size and self.size + self.extra_partition_space > self.fixed_size:
             raise WicError("File system image of partition %s is "
                            "larger (%d kB + %d kB extra part space) than its allowed size %d kB" %
-                           (self.mountpoint, self.size, self.extra_partition_space, self.fixed_size))
+                           (self.mountpoint or self.lineno, self.size, self.extra_partition_space, self.fixed_size))
 
     def prepare_rootfs(self, cr_workdir, oe_builddir, rootfs_dir,
                        native_sysroot, real_rootfs = True, pseudo_dir = None):
-- 
2.43.0


