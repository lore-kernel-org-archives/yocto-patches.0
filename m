Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E880BC021B4
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 14:18:42 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.50288.1740061120911484464
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 06:18:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=ebicme5F;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.46, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso1519366a91.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 06:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1740061120; x=1740665920; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDlviF49OsaeGndVBI3jmm4tZcvcln6kxA4CCZpDqPE=;
        b=ebicme5FhNoII+KfjX3qayrcWJ7cmq04As/s63I2y9qwVZhpoj2rjfeq/KXWfCcpwj
         Av3jegjLudCnNALV0ebibfBbiOyhQ49nqrmxHatzjn2X6zySKj0BTNaByo98ncFEMEDa
         ZBt8C+5zkHG3CkvJRvJ/JYHskuSo/0Mk1Fb3w9vp2HhPDKGoVJNxYGxlu8eZ6PmTXpsv
         HCSC0GQ7rwJsm7L3TTWkfbJANy3/bVKa+OYJlOCRZMaaCDXQrs/apXo55XiLaMFSWE0t
         HTrOV5XzBws6HvbKBblo8gDYslvCzdu5DYw6djo3vL/rUs/iqB/0mpxnjXBrQFc1aUEE
         sxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740061120; x=1740665920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDlviF49OsaeGndVBI3jmm4tZcvcln6kxA4CCZpDqPE=;
        b=CtWF/Q4jhZ4DDb6oAjTqG7A78ofYy3H5+sOr7nLcRX13Q7zhbnFB+bS9ClL43Gcu1H
         +9cE6zQecT9DCGGHc36tENtuRN3mK66V2GtaefEwExUzccevz1jd7GVENJ6kir68kfb4
         XxkbjD7wniW1PNeHnXFlHCDwInr92kMdvTkw2PHWkbhOZQqwcGz6dDnFy4QI2yxxUXNW
         Trg00tvZV7t3kNAAaGl+8VRM2NfsKuXjYG1yRqa6+3o92P55I1gMybi4b9Ur+2gsCc0g
         eJHd09MH35hzCRdCmScHuMhSJ4jYeI4YWycIfF/D40zvg9gew18uRIqw4s2uXTO/GCIb
         KeiA==
X-Gm-Message-State: AOJu0YxoHhyF4rmXP3RHdMFbHXiDSUBxAQE7popWachK/bhyFHmgCnHm
	tHpLaAAq9DMXl2osP8rE+YLWnl+cOmSn2bueJet/feyEfXtZ21zBtU0VEYJlbnwJSoQHzvxA6BW
	7
X-Gm-Gg: ASbGncvyuzcBj5g64udFH+r/0uaO9XVRShSQiey8Gje1glhD0+A3/c6BYA6veMRbm99
	l18Xk7j1B3qBlugtQDIF7QGcjnrX6j9+M6U0peIY12h6fgYPz6hBzf6MIdLxRkKQx7zu3lBgGij
	2lsae48jDamwgFtkHunaPnjh9r7WVS/wnKpzib3q1U8Yft7dq+I7OSXRk5liEIK4V+ioJ72QbqR
	SDKyo6Xfq/q16s1IjPU02OeZgs3r6qsx9axxTNBm4j6mkK51HHqdlwmckeW5xXCAxnKLS5WjDXp
	NfrULVw=
X-Google-Smtp-Source: AGHT+IHRQREp52kBA5J+9uglz23CKHbyVYBJZ+nwm9EtKP3O6og8GVZrV9m+lV5nOVSIQ4ew0exRHg==
X-Received: by 2002:a17:90a:ea93:b0:2fc:a3b7:10a2 with SMTP id 98e67ed59e1d1-2fcb5a39f2amr14025696a91.17.1740061119808;
        Thu, 20 Feb 2025 06:18:39 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:1a6d:8c40:c67d:b510])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13b913easm13496198a91.39.2025.02.20.06.18.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:18:39 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] config.py: add ubuntu2404 to workers_prev_releases for kirkstone and scarthgap
Date: Thu, 20 Feb 2025 06:18:26 -0800
Message-ID: <15c923890dafab0e727116e2152c5405613325b0.1740061045.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740061045.git.steve@sakoman.com>
References: <cover.1740061045.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 14:18:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1101

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 config.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.py b/config.py
index 8e2797a..67d80e5 100644
--- a/config.py
+++ b/config.py
@@ -190,12 +190,12 @@ all_workers = workers + workers_bringup + workers_buildperf + workers_arm
 # Worker filtering for older releases
 workers_prev_releases = {
     "styhead" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "opensuse155", "opensuse156", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
-    "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "perf-"),
+    "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
     "nanbield" : ("alma8", "alma9", "debian11", "debian12", "fedora37", "fedora38", "opensuse153", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "perf-"),
     "mickledore" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),
     "langdale" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),
     "kirkstone" : ("alma8", "alma9", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "fedora36", "fedora37", "fedora38", "fedora39", "fedora40", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2110", "ubuntu2204", "perf-"),
-    "honister" : ("alma8", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2110", "ubuntu2204", "perf-"),
+    "honister" : ("alma8", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2110", "ubuntu2204", "ubuntu2404", "perf-"),
     "hardknott" : ("centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora31", "fedora32", "fedora33", "fedora34", "opensuse152", "ubuntu1604", "ubuntu1804", "ubuntu2004", "perf-"),
     "gatesgarth" : ("centos7", "centos8", "debian8", "debian9", "debian10", "fedora30", "fedora31", "fedora32", "opensuse150", "opensuse151", "opensuse152", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "perf-"),
     "dunfell" : ("alma8", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2204", "perf-"),
-- 
2.43.0


