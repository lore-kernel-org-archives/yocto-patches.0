Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D12C71135
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:24:20 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web10.7228.1749810254796488879
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Jun 2025 03:24:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ffpaujth;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fadb9a0325so17189356d6.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749810253; x=1750415053; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OVEqjnWbfeR1PRkoTmcEKeVqEEKxH/jC6CA5CHsl7A4=;
        b=FfpaujthqIUooR3MPPYyDDeWkceAjqPELZdb5uaVJQIhwPspW/0mkYAd555xrOhnVz
         4sYgSIDzxykmQw2QIm639YoncuJ7/EDn6G5LhAJd981ZgXUqSOHnk3t3lo96BjNxQ3NY
         92vARpfvwTEdlRncxN2wQi2VltqKVLZNGyecXKFUG9C0/+eQJPg7xwY4eUQJUPBX5+mh
         JnT/i7KfX63cJsPtmkYC7hVzveVqRmrbIKbAVxjUSTA99nyxYI//YeXAVQMLaTZu0w/t
         R15Jf7NtdrJ9pYLFCe25IE22yXZdqysF+0O4rESVpkt9AwUgs6xMQIG8A89nT/WnsbuM
         oLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749810253; x=1750415053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVEqjnWbfeR1PRkoTmcEKeVqEEKxH/jC6CA5CHsl7A4=;
        b=SxqTt0RJTFkfuTcbLzSpstqHk4hRGV75EansB9YLvdt2E9eoG8a1vkVyBUlxiQLRTh
         jWL0ba04k+IqdBmmLoxaX2TaGJYgR9soaObysSDSiZ+K7/2E6rsiF4o/2GXyXj8dttWK
         JRwQIc6DbW/7lw3Spdl/lvIBDt/4P8gS3BjbjirmFy/Mdzrh6NVVoTixgWO7CL/zp/SM
         erai09d5nfm7/xqW1DeO4CV11qBkzoyOsYnPiWn0ItF+xxxn7u4FpqAzCJP9CSV7f85B
         fPYPDjbckmdmoi2uHPSvdYiLMjXpwPr89egMj09LguxyO/9lEVxMSqlfkh4MP/YuOhg1
         Nf9Q==
X-Gm-Message-State: AOJu0Yy8AJY46W5JkXorvsDqTxz8VC5Z5sR1KQi4DoD9MhpGQ+SsVwpY
	Sfkj8DMr3p5SbpuFWFQThP2qnRzWFbJlsTi/h8MmxV1i6m0v6DjtjpA/QnqWtpas
X-Gm-Gg: ASbGncuCQEczbyr0RIJOeBP/jLFxBTUoduSMn2PeduaEMp5Qa4q7vK3SB+lAV4R3uG6
	b1YxJ3zIzH8csbhx6xMkktW8B4cEWTuQWRICGkNsvU6o6Qow+0BOlODUPbfJYjKificVyKRtl1O
	H82khk52b9rnBejab5Ds33YpZCyMVDGPR5xQS4yVS944I4KwBdHvKI7iWx7jMFVGHJsSkDUytMU
	9Iiqobo5qrE0XibIJVjVySL1RuTBiB95tV18c55VAjU7e7yx3e0Ds4ImzUrfJhV4dBUVu4EAEpB
	c2oUkDqjlyTUXhQ5NrQrqteSrTV319VNc+97Jz3Fxm+mS76L0swhGOPNI8pCW/82c/hwXqlIpr3
	hGf7T+fJJTjEPeFklsiKHmNX7Z6LQsA==
X-Google-Smtp-Source: AGHT+IHT+Zkm/jhNgwbKJYqSLJOYXjyO05XLmhmpyAKDveuezQFx6doNBk5bf2E8ogyQ1+khD9cCLA==
X-Received: by 2002:a05:622a:4c88:b0:4a5:9b9c:2d9f with SMTP id d75a77b69052e-4a72fe80f5bmr50511491cf.2.1749810241999;
        Fri, 13 Jun 2025 03:24:01 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a2c068esm15502631cf.1.2025.06.13.03.24.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:24:01 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 1/2] trusted-firmware-a: remove no-longer-required patches
Date: Fri, 13 Jun 2025 06:23:56 -0400
Message-ID: <20250613102357.1539-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 10:24:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1638

The two patches being carried in this layer for tf-a are no longer required
and can be dropped.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../0001-dram-Fix-build-with-gcc-11.patch     | 35 -------------------
 ...rk-already-defined-functions-as-weak.patch | 35 -------------------
 .../trusted-firmware-a_%.bbappend             |  7 ----
 3 files changed, 77 deletions(-)
 delete mode 100644 recipes-bsp/trusted-firmware-a/files/0001-dram-Fix-build-with-gcc-11.patch
 delete mode 100644 recipes-bsp/trusted-firmware-a/files/0001-pmu-Do-not-mark-already-defined-functions-as-weak.patch

diff --git a/recipes-bsp/trusted-firmware-a/files/0001-dram-Fix-build-with-gcc-11.patch b/recipes-bsp/trusted-firmware-a/files/0001-dram-Fix-build-with-gcc-11.patch
deleted file mode 100644
index 120ea0bd3635..000000000000
--- a/recipes-bsp/trusted-firmware-a/files/0001-dram-Fix-build-with-gcc-11.patch
+++ /dev/null
@@ -1,35 +0,0 @@
-From a09a1de53aba422249a8376b0d95024200021317 Mon Sep 17 00:00:00 2001
-From: Khem Raj <raj.khem@gmail.com>
-Date: Tue, 11 May 2021 11:55:31 -0700
-Subject: [PATCH] dram: Fix build with gcc 11
-
-This is a redundant assignment which GCC warns about.
-
-Fixes
-
-plat/rockchip/rk3399/drivers/dram/dram_spec_timing.c:781:11: error: explicitly assigning value of variable of type 'uint32_t' (aka 'unsigned int') to itself [-Werror,-Wself-assign]
-                twr_tmp = twr_tmp;
-                ~~~~~~~ ^ ~~~~~~~
-
-Upstream-Status: Pending
-Signed-off-by: Khem Raj <raj.khem@gmail.com>
----
- plat/rockchip/rk3399/drivers/dram/dram_spec_timing.c | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/plat/rockchip/rk3399/drivers/dram/dram_spec_timing.c b/plat/rockchip/rk3399/drivers/dram/dram_spec_timing.c
-index 3cdb7a296..76bc5ee96 100644
---- a/plat/rockchip/rk3399/drivers/dram/dram_spec_timing.c
-+++ b/plat/rockchip/rk3399/drivers/dram/dram_spec_timing.c
-@@ -778,7 +778,7 @@ static void lpddr3_get_parameter(struct timing_related_config *timing_config,
- 	else if (twr_tmp <= 8)
- 		twr_tmp = 8;
- 	else if (twr_tmp <= 12)
--		twr_tmp = twr_tmp;
-+		; /* do nothing */
- 	else if (twr_tmp <= 14)
- 		twr_tmp = 14;
- 	else
--- 
-2.31.1
-
diff --git a/recipes-bsp/trusted-firmware-a/files/0001-pmu-Do-not-mark-already-defined-functions-as-weak.patch b/recipes-bsp/trusted-firmware-a/files/0001-pmu-Do-not-mark-already-defined-functions-as-weak.patch
deleted file mode 100644
index bd4d2b594e44..000000000000
--- a/recipes-bsp/trusted-firmware-a/files/0001-pmu-Do-not-mark-already-defined-functions-as-weak.patch
+++ /dev/null
@@ -1,35 +0,0 @@
-From 9d963cd69faf94bdcb80624132fd10392f57875b Mon Sep 17 00:00:00 2001
-From: Khem Raj <raj.khem@gmail.com>
-Date: Tue, 11 May 2021 12:11:51 -0700
-Subject: [PATCH] pmu: Do not mark already defined functions as weak
-
-These functions are already defined as static functions in same header
-Fixes
-
-| plat/rockchip/common/drivers/pmu/pmu_com.h:35:14: error: weak identifier 'pmu_power_domain_ctr' never declared [-Werror]                                                                                      | #pragma weak pmu_power_domain_ctr                                                                                                                                                                             |              ^
-| plat/rockchip/common/drivers/pmu/pmu_com.h:36:14: error: weak identifier 'check_cpu_wfie' never declared [-Werror]
-| #pragma weak check_cpu_wfie
-|              ^
-
-Upstream-Status: Pending
-Signed-off-by: Khem Raj <raj.khem@gmail.com>
----
- plat/rockchip/common/drivers/pmu/pmu_com.h | 2 --
- 1 file changed, 2 deletions(-)
-
-diff --git a/plat/rockchip/common/drivers/pmu/pmu_com.h b/plat/rockchip/common/drivers/pmu/pmu_com.h
-index 5359f73b4..3f9ce7df9 100644
---- a/plat/rockchip/common/drivers/pmu/pmu_com.h
-+++ b/plat/rockchip/common/drivers/pmu/pmu_com.h
-@@ -32,8 +32,6 @@ enum pmu_pd_state {
- };
- 
- #pragma weak plat_ic_get_pending_interrupt_id
--#pragma weak pmu_power_domain_ctr
--#pragma weak check_cpu_wfie
- 
- static inline uint32_t pmu_power_domain_st(uint32_t pd)
- {
--- 
-2.31.1
-
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
index f2b666c127ae..4c7fc3c4c180 100644
--- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
@@ -9,13 +9,6 @@ COMPATIBLE_MACHINE:append:rk3566 = "|rk3566"
 COMPATIBLE_MACHINE:append:rk3568 = "|rk3568"
 COMPATIBLE_MACHINE:append:rk3588s = "|rk3588s"
 
-FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
-SRC_URI += "\
-    file://0001-dram-Fix-build-with-gcc-11.patch \
-    file://0001-pmu-Do-not-mark-already-defined-functions-as-weak.patch \
-"
-
-
 # code bloats with clang and results in error below now
 # | aarch64-yoe-linux-musl-ld: region `PMUSRAM' overflowed by 3928 bytes
 # this needs fixing until then use gcc
-- 
2.44.0.501.g19981daefd7c


