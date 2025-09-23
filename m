Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5E9CAC5B1
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 09:35:40 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.12594.1758620133038279199
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Sep 2025 02:35:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=U4ionOe3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46cb53c5900so25041415e9.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Sep 2025 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758620131; x=1759224931; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Nlsmpza+SXMMu8+TbFSzgfn21LK8Z+vUjp+Zta/2Cg=;
        b=U4ionOe3v1za3vuNO7Vh62MFwsEUps6GiczdOnlZ6yZ0yT6FjMA01G3Jy+rWV62hTg
         IIaaZi9iuapYFwGMFT+1hTjoqV+D2lq1/2vjADvdPiBg2ZdAwkXAa5aCZRXKjB6ZEHwV
         +KBb+YmU6csstLzoF9WoCmtYM9c/piIL5plaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620131; x=1759224931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Nlsmpza+SXMMu8+TbFSzgfn21LK8Z+vUjp+Zta/2Cg=;
        b=kkjKFp7K/mET1jGh162TKM4QY3GDCQ4S2R4FbfBFdpOPQLgZ6B+oiHK6uOkSgXZTsV
         OgZUFOlL0CfjnFUJbStBhlI1SJD4DZBc7FAJFHqjC+lDVR4XSLWjc8bVeWfkTVH8XRkv
         eBEQC0b2W/Sbc72w0X/o+OnzF5kgkVn6OkoNLYZKWalyRSo4UsE70JB8glgmekaEOEn3
         dNl7qMLMpqPBF+oyUlE2wEbNILCZM3iMd9Qk5rPDSma7iXIUrmyIranxN4s8pMxl9/B3
         DAjqjorq9JUw+kIIJJuFBKI0+/U3q/VuNeN4bnib5fuYYPntv96opTqXezX6Zp1qDT4F
         JG6w==
X-Gm-Message-State: AOJu0YxHVdOKs561pwdgpnR5VvO3Ru9mDr1V8iiISAsaymId6u5pMtxh
	p+FF6Judt51ojn/kb9uJyl4/uF3+EdcDf21VevPuJVxjJBulYmY3CiEcHwzTS6GBJEEA3kHtf1x
	grdcs
X-Gm-Gg: ASbGncvQLWdraGECmHTBlHbdQQTMm97bd3Eo+AHhYRHajt10rtpKgb327t9UM8QjE18
	fSh6m08H2n1y6bGk3BUucWK2BYlRoI4jnMgsWaJZ4tmV3Ud/paiTSqFB7er2vqTyKtR6n+dwhry
	YmUsE5puHeIi65bRpFsqV0OhVGuP2HlejSZ/tpaKCZ/iKVY2V+wwcE4zpi1LsCuPsq2VFIkjKI7
	VUHtuQikGOOL8wDYqfflUo/sv1No2n6gA0SkrE10RkOW+ekQtOMJN/UiB+Lp+fx8STWL9UjTjMi
	BdkczEyRn3L0n9HMnkfiDpf0/443zZ9FeMe1PtrzHy3SPTDj+B4BEYfCggTQxuXLGuIYhApMqSU
	UzUJMg4dvt5OboXsGRwRVr2KUvsfNeHnSw7sFZUieIN/j5CayxZA=
X-Google-Smtp-Source: AGHT+IHm4hplqyYTF7DqTW2/FWnmIl2mwglighLTeXctMJdkm8SniNh4kmrBeHaklQG5PLIQLi+DqQ==
X-Received: by 2002:a05:600c:1c83:b0:46d:3576:2895 with SMTP id 5b1f17b1804b1-46e1dab54b1mr23646655e9.24.1758620130893;
        Tue, 23 Sep 2025 02:35:30 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fe09:3ae7:900c:f751])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d14d212sm303264875e9.12.2025.09.23.02.35.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:35:29 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 2/2] config.py: Drop pre dunfell config
Date: Tue, 23 Sep 2025 10:35:27 +0100
Message-ID: <20250923093528.2384475-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923093528.2384475-1-richard.purdie@linuxfoundation.org>
References: <20250923093528.2384475-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Sep 2025 09:35:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2232

Anything older than dunfell wouldn't build now, drop the older configurations.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/config.py b/config.py
index 3c81c372..b578d6cb 100644
--- a/config.py
+++ b/config.py
@@ -110,9 +110,6 @@ trigger_builders_wait_quick_releases = {
     "styhead" : trigger_builders_wait_quick + ["qemumips", "qemumips64", "qemuppc"],
     "scarthgap" : trigger_builders_wait_quick + ["qemumips", "qemumips64", "qemuppc"],
     "kirkstone" : trigger_builders_wait_quick + ["edgerouter", "non-gpl", "qemumips", "qemumips64", "qemuppc"],
-    "zeus" : trigger_builders_wait_quick + ["mpc8315e-rdb", "edgerouter", "non-gpl3"],
-    "thud" : trigger_builders_wait_quick + ["mpc8315e-rdb", "edgerouter", "non-gpl3"],
-    "sumo" : trigger_builders_wait_quick + ["mpc8315e-rdb", "edgerouter", "non-gpl3"]
 }
 
 old_arch_full = ["qemumips", "qemumips-alt", "qemumips64", "qemuppc", "qemuppc-alt", "qemumips-tc", "qemumips64-tc", "qemuppc-tc"]
@@ -124,10 +121,6 @@ trigger_builders_wait_full_releases = {
     "styhead" : trigger_builders_wait_full + old_arch_full,
     "scarthgap" : trigger_builders_wait_full + old_arch_full,
     "kirkstone" : trigger_builders_wait_full + ["edgerouter", "edgerouter-alt", "non-gpl3"] + old_arch_full,
-    "zeus" : trigger_builders_wait_full + ["mpc8315e-rdb", "mpc8315e-rdb-alt", "edgerouter", "edgerouter-alt", "non-gpl3"] + old_arch_full,
-    "thud" : trigger_builders_wait_full + ["mpc8315e-rdb", "mpc8315e-rdb-alt", "edgerouter", "edgerouter-alt", "non-gpl3"] + old_arch_full,
-    "sumo" : trigger_builders_wait_shared + ["qemumips-alt", "edgerouter-alt", "mpc8315e-rdb-alt", "qemuppc-alt", "qemux86-world-alt",
-                                             "oe-selftest-fedora", "oe-selftest-debian"]
 }
 
 trigger_builders_wait_perf = ["buildperf-debian11", "buildperf-alma8"]
@@ -204,10 +197,6 @@ workers_prev_releases = {
     "hardknott" : ("centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora31", "fedora32", "fedora33", "fedora34", "opensuse152", "ubuntu1604", "ubuntu1804", "ubuntu2004", "perf-"),
     "gatesgarth" : ("centos7", "centos8", "debian8", "debian9", "debian10", "fedora30", "fedora31", "fedora32", "opensuse150", "opensuse151", "opensuse152", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "perf-"),
     "dunfell" : ("alma8", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2204", "perf-"),
-    "zeus" : ("centos7", "debian8", "debian9", "debian10", "fedora28", "fedora29", "fedora30", "opensuse150", "opensuse151", "ubuntu1604", "ubuntu1804", "ubuntu1904", "perf-"),
-    "warrior" : ("centos7", "debian8", "debian9", "debian10", "fedora28", "fedora29", "fedora30", "opensuse150", "opensuse151", "ubuntu1604", "ubuntu1804", "ubuntu1904", "perf-"),
-    "thud" : ("centos7", "debian8", "debian9", "debian10", "fedora28", "fedora29", "fedora30", "opensuse150", "opensuse151", "ubuntu1604", "ubuntu1804", "ubuntu1904", "perf-"),
-    "sumo" : ("centos7", "debian8", "debian9", "fedora28", "ubuntu1604", "ubuntu1804", "perf-")
 }
 
 # Worker configuration, all workers configured the same...

