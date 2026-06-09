Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5132CCD8CA4
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 09:43:08 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.75504.1780998182324421787
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Jun 2026 02:43:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FI94cQJx;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4908b92904fso61007675e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 02:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780998180; x=1781602980; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0BgenD/hUSJHECjKy9WJnpnXNAvAjMN3G8dzrwebX1A=;
        b=FI94cQJx6hGnPgjE7HmHmJyzEk/kk+naTq4Rca8L6bfaxYszWxfD/k6tIrkGXW90HD
         w+9FhRt4jrEHwJjm3DocHX6rjlc7uLLFBRn/J/WP4E+3CM8kaXDSdgB95r7bigCfsOGK
         zERUrlplZbd1pP7L4eewwYVTs+KxyUHH0tiaS5iXxaNTfdIglKEUXsKZ5gHHjs6D/pRY
         p69TjAkYo1z13P3IzTBmr6mj60SGgaOelL1Urcj1qlPUpuVf8c+2nybFdAE0iAuDhwRF
         B38x7EHhpv9O1kWzgOZkkvi2TV3I/Ci8G+wP8lRndTmobW4GhjIraSuNDZrVxBDPQwkn
         vhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998180; x=1781602980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BgenD/hUSJHECjKy9WJnpnXNAvAjMN3G8dzrwebX1A=;
        b=UzHhI9f6/5K/qnuQNqVSAW/gQynWYPKIWKyVIpTZ7eetGNefSg3spQKBBMudKrKK38
         rDlnK0ZlnRNXALaFBtGb960xbmfXLZOIxeJFi88z2akhFj9R1QedVAJfqJVdPqrO8igB
         Op/rf+NjccOt5YT6wnZ441zwwcwfQJg59CTUejqdC2v0iveHYjFgrTMO0G/eo3MB/MP0
         BRv1ymrlwq//1/qV7NcZ8uuIuC4q4H6fIROSDMgLc17huK0s0FIp6K6BAiYdo5vEAEwx
         niHR6YJMnXkxYD9ETMq9+e6wceUHgRdApI5A6M6rto3YUOQqxH9oUYFuwUOppvlQmCRH
         tlhA==
X-Gm-Message-State: AOJu0YyZPICPov8kB9pWYnxz29s7hSlDgawQ1yY2hq2AmedTSOC+XsvC
	DUVAMAr2XPSit7PYqW3Tx6TolUcZBnlz9yFPuuf24jpHJZU22Sq2podTRJpFapSf
X-Gm-Gg: Acq92OGHUtPoFwGupSUjhUYPOwRPO9OcmeYTzbRM0qLvYG12bQHu5CxuzMQdlnKdAL4
	NARklZINVMst5zKwzDHqoxRGQHDUi2FSTZAHUOWWizdXga7vPf48VDiLGC0XDwVAxg4XzNbeaGA
	qpJS4G6PdI6ks2VFbhoWLGn2jjvGrDIKPIkl39VbNLCLs/tYITlZWOtGr5iuK1b3F1/SYlzMk0A
	aCp4+nvk3YNyKk2J1ExUnxI/FiCFI1mQ4EpM8Qfr5uLoR/0xtrr3fsrY05YBUaJyDqBOV+iUUMN
	TdZZyBzMfN17zWJbqLvQbn3hbjT7UfZaQhZobprevT+ReSNilAwrlc2udHjJ3JZV2PxnIGerofS
	rw+MWywgh0i7Eb3k+mcxF36e/XvBcKTm9ZssTz2OEg05C6w2zzLDHsSmoMQ25JpS5V0wMU9vhJP
	2hT0MQx/djp5nQEpB/KjuCFiTv2WQKk7erkUk7FspuXDA3byJUiVf23FuT2OMIBePDLpR6PwKog
	M3rH6NNg3eXv9LU
X-Received: by 2002:a05:600d:6444:20b0:490:5466:8591 with SMTP id 5b1f17b1804b1-490c26e1acbmr230760065e9.12.1780998180269;
        Tue, 09 Jun 2026 02:43:00 -0700 (PDT)
Received: from alex-lx-laptop.lab.linutronix.de (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm540276115e9.1.2026.06.09.02.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:42:59 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [yocto-autobuilder2][PATCH] schedulers.py: run AUH in incremental mode every night
Date: Tue,  9 Jun 2026 11:42:55 +0200
Message-ID: <20260609094255.898524-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 09:43:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4181

From: Alexander Kanavin <alex@linutronix.de>

Please see
https://lists.openembedded.org/g/openembedded-architecture/message/2349
for rationale; incremental mode should be safe to use frequently, as long
as it's implemented correctly :)

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 schedulers.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index 21a6ccf..0f41bd0 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -706,9 +706,9 @@ schedulers.append(sched.Nightly(name='nightly-buildperf', branch='master', prope
 schedulers.append(sched.Nightly(name='nightly-toaster', branch='master', properties=parent_default_props('toaster'),
                   builderNames=['toaster'], hour=[3], minute=0))
 
-# Run the AUH twice a month on 1st and 15th
+# Run the AUH every night in incremental mode (e.g. only update things that have not been previously attempted)
 schedulers.append(sched.Nightly(name='nightly-auh', branch='master', properties=parent_default_props('auh'),
-                  builderNames=['auh'], dayOfMonth=[1, 15], hour=5, minute=0))
+                  builderNames=['auh'], hour=5, minute=0))
 
 # Run the indexing targets every 15 mins
 schedulers.append(sched.Nightly(name='sschduler-indexing', branch='master', properties=parent_default_props('indexing'),
-- 
2.53.0


