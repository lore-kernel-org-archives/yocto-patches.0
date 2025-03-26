Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C732C36008
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 22:27:23 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.36845.1743028034397971662
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Mar 2025 15:27:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KOrSEr1U;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so3692665e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743028032; x=1743632832; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qCjV8ADlZfiCRsabEUZIJ1+ZsXOR67YPbwKZoGPXCdU=;
        b=KOrSEr1UwWeCaUAE91GagvCPGFdAogYY+V2EIUVrQkBWsUn81xGbviUXMhltTt1Tqq
         sYGQuQCTodhS6DdyMgT+2/5u+apKSv4bx0gsSIqrUy3ukdB3kE58bkDi5CGIYLegMDbv
         W2gq50BOMi62+vtD/nfhd+X34Iuhxq/S/kaaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743028032; x=1743632832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCjV8ADlZfiCRsabEUZIJ1+ZsXOR67YPbwKZoGPXCdU=;
        b=VXqNMGb72/AtZjIyFJ+PwfxOav+ZhuoNOqI36gZ3GNpk0ksazWRaRkVlSkLxNGDlbh
         K6mrKyy7jtnLoKhSsUKcYZ/58lvW+7ORHvuaI9/Kw2s2mDthqgzTxcCyZ1H+o2M+V6rP
         p1UmtUBRfLfhdtVBkxrPAgHYO3pSQf6asv6Xq8ScqBOjP+kuu0YsOXNaz/veFV0E+x7i
         csrV8RA+1OknrxGtI+CKFCbyzAz30d504P03EQp78YkUgybKNSedHVhrMOMadXfJgV0j
         p0Dnn/9ILKGEUocFXGCirHK5yTVfeIJ6jEJ5c/yGUUL/QjMPwpL8Kxis4dolp7HnxYfe
         NDZg==
X-Gm-Message-State: AOJu0YyIQAYtrKeAsOC43WE7Zik7IDde+W9h8VEyB97VND9TbvDOpIWY
	YBIZR26CrFG7H1RYePJJzZZiQ9XEAE5oSHKcCgMtEjW9dFtnm4FP119DhdciraznDw8kjU3+jBq
	4
X-Gm-Gg: ASbGncudZrbHfm8GrP2BiLL3PnO38D2QjF8MeR3As2jrJL7rCrh5J0o1PVthOebPa3N
	R0VsFkC2E5cQYevmHh8AnVs73fwbCYuvj0MANg2L+fYGfLuXBqKDrPgPzJ5Mfvcw01UKGQPB24l
	HMSmDhRd+Nw/WMmCKw3suR5iC/HQPF/Qx9kMkEO69YNhOCHX926a+HnOPCr5OieTgCao77RocvB
	d1/SnhacA0zt4gFGqRKUGZQosezMWCSoSDCnVhYW+CLsCySFoPOP1stq3amNYev63pbY5+Hltq7
	DnpSMLHGEQDp3U2nNFcAjIfoq2n7m0NTMQe8Fpg3YZs0N624om1E2r5mZ3LFP5J4MQtbPP01Iw=
	=
X-Google-Smtp-Source: AGHT+IGUiOIIyULaZy0TeU8Qkp2necvU221fKgHvRNu2e/eU1nU1dTlsA7vg83JnLRigGjvzIQzJjA==
X-Received: by 2002:a05:600c:45c8:b0:43c:fcb1:528a with SMTP id 5b1f17b1804b1-43d84f5bc0amr10260795e9.6.1743028031862;
        Wed, 26 Mar 2025 15:27:11 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fab8:513e:e094:22ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8314b409sm16853045e9.34.2025.03.26.15.27.10
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 15:27:10 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] config: Merge selftest jobs into deb and rpm based rather than distro
Date: Wed, 26 Mar 2025 22:27:09 +0000
Message-ID: <20250326222709.959270-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 22:27:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1263

We currently have 4 different selftests running but they now rarely show host
specific differences. Merge the four into two, calling them "fedora" and "debian"
simply to avoid renaming all the target names in helper.

Since opensuse is rpm based and the fedora group has slightly fewer workers,
add opensuse to that pool.

This means builds going forward will run one arm and two x86 based selftests
which should be more than sufficient. The change is applying to all releases.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/config.py b/config.py
index 9e493fe3..e07e5587 100644
--- a/config.py
+++ b/config.py
@@ -104,7 +104,7 @@ trigger_builders_wait_quick = trigger_builders_wait_shared + [
 
 trigger_builders_wait_full = trigger_builders_wait_shared + [
     "qemux86-world-alt",
-    "oe-selftest-ubuntu", "oe-selftest-debian", "oe-selftest-fedora", "oe-selftest-centos",
+    "oe-selftest-debian", "oe-selftest-fedora",
     "qemux86-64-ptest", "qemux86-64-ltp", "qemuarm64-ptest", "qemuarm64-ltp",
     "meta-intel", "meta-arm", "meta-aws", "meta-agl-core", "meta-virt", "qemuarmv5",
     "qemuarm-tc", "qemuarm64-tc", "qemux86-tc", "qemux86-64-tc"
@@ -131,7 +131,7 @@ trigger_builders_wait_full_releases = {
     "zeus" : trigger_builders_wait_full + ["mpc8315e-rdb", "mpc8315e-rdb-alt", "edgerouter", "edgerouter-alt", "non-gpl3"] + old_arch_full,
     "thud" : trigger_builders_wait_full + ["mpc8315e-rdb", "mpc8315e-rdb-alt", "edgerouter", "edgerouter-alt", "non-gpl3"] + old_arch_full,
     "sumo" : trigger_builders_wait_shared + ["qemumips-alt", "edgerouter-alt", "mpc8315e-rdb-alt", "qemuppc-alt", "qemux86-world-alt",
-                                             "oe-selftest-ubuntu", "oe-selftest-debian", "oe-selftest-centos"]
+                                             "oe-selftest-fedora", "oe-selftest-debian"]
 }
 
 trigger_builders_wait_perf = ["buildperf-debian11", "buildperf-alma8"]
@@ -159,6 +159,7 @@ builders_others = [
     "meta-oe-mirror",
     "auh", "auh-meta-oe",
     "edgerouter", "edgerouter-alt",
+    "oe-selftest-ubuntu", "oe-selftest-centos", "oe-selftest-opensuse",
     "non-gpl3",
     "meta-webosose"
 ] + old_arch_full
@@ -224,9 +225,9 @@ notify_on_missing = None
 builder_to_workers = {
     "bringup": workers_bringup + workers,
     "bringup-fast": workers_bringup + workers,
+    "oe-selftest-debian": workers_debian + workers_ubuntu,
+    "oe-selftest-fedora": workers_fedora + workers_centos + workers_opensuse,
     "oe-selftest-ubuntu": workers_ubuntu,
-    "oe-selftest-debian": workers_debian,
-    "oe-selftest-fedora": workers_fedora,
     "oe-selftest-opensuse": workers_opensuse,
     "oe-selftest-centos": workers_centos,
     "oe-selftest-armhost": workers_arm,

