Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1901C3600B
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 17:08:20 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.28150.1743008897327723973
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Mar 2025 10:08:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TlHGdgR2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso6655279f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743008895; x=1743613695; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=muD16lQ06cTrR+0IBwAhEW96RRD8i/J3maPyo6k8x9E=;
        b=TlHGdgR2fsYOkxlYEqdTO4FjEMuMKLrrOofHle+5JAQuMXU8A3rciy/gaMWphr9h0E
         bEGQfTrADGgTC5sQ+1QoALDYuH9niLkL+s7rFNU5NcqNrIo94uSeX9/vAFCmyMu+cOAW
         uzXRA0VYzC2CRugITOcVMGJuFU0nbyg66qxGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743008895; x=1743613695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muD16lQ06cTrR+0IBwAhEW96RRD8i/J3maPyo6k8x9E=;
        b=oc7ozqiIJ74qMua7SrG8MQz5NIgJEvQ+socLoSIEgPuY5aGXVkMODRiX34WgAUbxwK
         bUrMXgJ01L89LOYfW/kTa12DYcYlR4luEcmQfAD2FVY/b6zV9lk6r3zRrmNrlJSx1v3w
         kpd8CJydSzgl+e7N6rdoz2/YVOGYXBLXx1/IBIppRMNbhEQrx9MkvY9wfaIZadkfn7uS
         1/MGo/XEf25TFiXLpRvjgk8MOzBr+6Prz94VXLMUtP9egOQagJfNNEezGKYNxzyE+F/j
         RRoyVLCmQg5Af1iciaXfjYahXN5g15j/R625n8trGojcFMobu1deG9A2apC+t6YwrN95
         H6xA==
X-Gm-Message-State: AOJu0YwoflmXzCG0NLQJWTv0ijohajjfCEe39rUH7+aRQWfGQR/6HWrp
	FFSzEzr3V/sRQqRT/DogZkpfBe6DjdM3RpEorUf3+oxcrG9VTVeFiP88+r5aPbtsMMaeyAHIbVz
	S
X-Gm-Gg: ASbGncvSv0yDr8DcT5PVPlzmmJcIp/zD+WIOr/Y8szAjmN+q0tCYT08sCTQxVYyfabk
	pHJinuSPUCCP7CtG41NvosZ1EfepibEuwSo/PiqG+U06aXsU/wihlAWTZOaR1CjdcKd9/JDb/Q4
	GlHyX1Sdyu9KS/6WUWiKQjPAkqSyY79w7JQgi/9DCEvCq+72iecVGC1qvpKRIr1xndSNWV9lUDQ
	ah4WsIYsUp/TLxRJcQv+/PmyoMyZ+ZnlxWRn2i1P+TAz5ViS5cxRd4SCJKt5FaF9qvNfnUDc6a+
	M4CTFY0s5OadSYLfiLubdO4jh8PDsRlEpS8Nl2O95ozXS9CTcc4tPONNY+Q8VzeY7o6Zet1X2A=
	=
X-Google-Smtp-Source: AGHT+IGFSvVmCUSDhdi5WyR39UZon9+aw/ddtiXvztyEPml3lB6P/GGi5a7dC5DnlO11U55SslINJA==
X-Received: by 2002:a05:6000:4203:b0:399:6d26:7752 with SMTP id ffacd0b85a97d-39ad178db83mr189478f8f.38.1743008895218;
        Wed, 26 Mar 2025 10:08:15 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fab8:513e:e094:22ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efc90sm17620570f8f.98.2025.03.26.10.08.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:08:14 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 2/3] config: Add walnascar worker/target tweaks
Date: Wed, 26 Mar 2025 17:08:11 +0000
Message-ID: <20250326170812.840424-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326170812.840424-1-richard.purdie@linuxfoundation.org>
References: <20250326170812.840424-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 17:08:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1260

Prepare for the next release and add walnascar metadata based on master.
Also update the worker list for styhead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 47d51323..a8aa4e31 100644
--- a/config.py
+++ b/config.py
@@ -124,6 +124,7 @@ trigger_builders_wait_quick_releases = {
 
 trigger_builders_wait_full_releases = {
     "master" : trigger_builders_wait_full + ["meta-clang"],
+    "walnascar" : trigger_builders_wait_full + ["meta-clang"],
     "scarthgap" : trigger_builders_wait_full,
     "kirkstone" : trigger_builders_wait_full + ["edgerouter", "edgerouter-alt", "non-gpl3"],
     "zeus" : trigger_builders_wait_full + ["mpc8315e-rdb", "mpc8315e-rdb-alt", "edgerouter", "edgerouter-alt", "non-gpl3"],
@@ -195,7 +196,8 @@ all_workers = workers + workers_bringup + workers_buildperf + workers_arm
 
 # Worker filtering for older releases
 workers_prev_releases = {
-    "styhead" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "opensuse155", "opensuse156", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
+    "walnascar" : ("alma8", "alma9", "debian11", "debian12", "fedora39", "fedora40", "fedora41", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "ubuntu2410", "perf-"),
+    "styhead" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
     "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
     "nanbield" : ("alma8", "alma9", "debian11", "debian12", "fedora37", "fedora38", "opensuse153", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "perf-"),
     "mickledore" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),

