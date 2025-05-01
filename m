Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D02C3ABA9
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 22:16:14 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web11.6811.1746137764106709853
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 15:16:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=MNDUPXC5;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c559b3eb0bso100053985a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 15:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746137763; x=1746742563; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnGOXR6noMjOO+PYxqABh5bK+OszWgRs+sFklmHt1g4=;
        b=MNDUPXC5Sru5QqOmCtSz+SwQE5DiOZjbxHCSJC+eCPPT8XrJGd2SNUC/p6tEmnYRJP
         Pgtc89T7Ua3M7tfmbDXBgS1LWsKitemb5av5fZRZScuAJD8llHpil7ySdyX/i0w6Yv0H
         IkNBDR3DEw2hVQqdFF2qVbM9LkGucXeKOXa7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137763; x=1746742563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnGOXR6noMjOO+PYxqABh5bK+OszWgRs+sFklmHt1g4=;
        b=qYDPQVhP9X59W6AE7S46RpIjy4dEuYY1GbSMK4xcduPB1yTre1GvuecL6hnHl3Mrks
         VOWLvCIZu42Ow4Pj1H9MNoFCQ77KPwJU8g3/+8Y/4IYRd8WHTMcU1JN2s1FDhSd0crAM
         F3akF+NMJ2d3UT43gvuoZBAfr+AI924x1b5B0BG2Q/94Gjh1rnrReID0oFcY8+YlfGG7
         ceUHcJTsQsO76E4VuabWfQnb292DO3McPbkcuEnjLtJFjS5RU+oNl+N7xygvBEHAR7Sp
         2Ar5ngD+zUMKM9pfXLRQUlGsclkSJNgusw8mTcNjGyhEMMGvQhENId37YO3+6pxWwuVI
         yjkg==
X-Gm-Message-State: AOJu0YxU/7EwhEeYaeFmrKgxtCWAWoBjeWBXcaUgYUdv4NyU9JfLSi9m
	Eg2Gwx1JIAyyq4DscsZ0XTi8yiHoH2iTGZeAVXoqsOk3bWyy0NqH4Bf2/xld2baS1FJcEAO0Qal
	N
X-Gm-Gg: ASbGnct/S/72U6RVCzxLw60oJCcCe2ZRbdZRlP4lVHIsLZWURwz9G/EXS33O8wKWX6f
	/ZfcD9hi5yLGvulUbCIxDcchbpIYANUUvA3c75LIx5M8SHoFwYsLxIpITtdq/hoDskTSz8x3pnz
	+h2JsmNvfGwZyvIABuD+LdYSok2bnjmpM3XfjSvN8Uh46LB2YTpHJxUf9cKLp82DCMIop1ov7rc
	W11H9xQnRztG9u4Pzz+Vw7wQi28uLQgiZANeMD62QqGMB4VlivJmUw0AR/krARRmWmqFlMb00uu
	Dl9gAlyCJSt5a/uhur4itDLj9tWP79C/0BK8EFfh0HQXJp50679x/CEmFO8R86tbeLm0YkHw67z
	9izlQfR84kaZL7DoayUu5ssFwDcM=
X-Google-Smtp-Source: AGHT+IFrIUDRIhqGSK/dONAjjHZtpIh7tHCdyM0xCA9f6aP703YADiHkjdlqYzEL0nnrdQIMJ6XAiw==
X-Received: by 2002:a05:6214:d05:b0:6e6:4969:f005 with SMTP id 6a1803df08f44-6f5155eee1amr14429626d6.30.1746137762730;
        Thu, 01 May 2025 15:16:02 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c3329sm9975366d6.28.2025.05.01.15.16.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 15:16:02 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 3/7] libstd-rs: Correct the license to use Unicode-3.0
Date: Thu,  1 May 2025 18:15:39 -0400
Message-ID: <d45c185453e0d2b08a2810258d3600fdb3385fe7.1746137462.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746137462.git.scott.murray@konsulko.com>
References: <cover.1746137462.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 22:16:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1468

From: Peter Kjellerstedt <pkj@axis.com>

This was missed in commit 3130069fdebb92f20b962fa8074564a27c3fb6b9.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit 1378a4b39e7a0c38c74e0133f31df7f70ed7d6ea)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/libstd-rs_1.85.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/rust/libstd-rs_1.85.1.bb b/recipes-devtools/rust/libstd-rs_1.85.1.bb
index 1994368..00802f0 100644
--- a/recipes-devtools/rust/libstd-rs_1.85.1.bb
+++ b/recipes-devtools/rust/libstd-rs_1.85.1.bb
@@ -1,7 +1,7 @@
 SUMMARY = "Rust standard libaries"
 HOMEPAGE = "http://www.rust-lang.org"
 SECTION = "devel"
-LICENSE = "(MIT | Apache-2.0) & Unicode-TOU"
+LICENSE = "(MIT | Apache-2.0) & Unicode-3.0"
 LIC_FILES_CHKSUM = "file://../../COPYRIGHT;md5=9c0fae516fe8aaea2fb601db4800daf7"
 
 require rust-source.inc
-- 
2.49.0


