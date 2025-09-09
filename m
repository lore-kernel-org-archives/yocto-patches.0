Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB83CAC58C
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:44:19 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web11.2983.1757443459057339199
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:44:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GS6Whx9f;
 spf=pass (domain: konsulko.com, ip: 209.85.222.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8173e8effa1so169304285a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443458; x=1758048258; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3UwW2uzMt2EhjUQwAtE11ySuAu4TpLrfBoR4a7ygSQ=;
        b=GS6Whx9foIyEEOLn/dDgzCYmM1y7eNaq5ZlrOPm41pNWt8yuZCNozYoErZNskJUt0K
         kykVcAULbFmHsWkvylfAvtcXmBxQP8XAn93lfuL5x0xRp3jYMt6dkJL+Be6t4Ph+BR5J
         mVT0BcGMgHOrH+xeh8H9UCZerQM8MEEz+PjD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443458; x=1758048258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3UwW2uzMt2EhjUQwAtE11ySuAu4TpLrfBoR4a7ygSQ=;
        b=I4yVjDtTy4/nFJkgJNG4vBcL/X3ZIfmSgWqA+sUk+t51b/Lcj5eeufNZAm3zx3Sd72
         PxgFYtiK7YeOR2DUV05j7Ya5uA34eT8A+yZTVjN8WIvTbQzx8xGd/Is7nWwFvihRJnMf
         htn5ytGh2X1cdvijIE7e40SkoIcnS/+KJtRF5R8dwoldEFkbbY8RRUHFw1E4oJh0ws/p
         UBhS7PhReQyVopFutQtp3K5R3H9LyGfHzxSkSLdPBQYziM6xjabBszRyxiXd9hx9ypT+
         HmhtGk8rX//Z3rb1pUn/SnDjX7OlqYKJTLyJy/tGQTXY64gpBXF3wSrnND2ffRBsdO2N
         xrnA==
X-Gm-Message-State: AOJu0YzJLFxp+n6CW0nXi5cijAspqZkAVLGbm4iGLOJ/+emP1V8Tbwmz
	8BXKGfJikF2OVf4G76CJnI0ChiwCsWGtjLgVKB4/wFnWkOx2L83KCz0UAHuBfpFIDon/dY6+RS8
	R5Ksb
X-Gm-Gg: ASbGncuOnWLJPGvOXSODjbKeY9rN2xV1Rdwgq65TZUMD3CZqOTcQ/Y53PD02q5028lQ
	tNBclQFZC9RbXCEVxrLuvX5jIe4F6iQHuSqhUWdpCyPCLgyl92498cgTL7F/ylFQjahj4prX79Q
	mOe5gojwd2zgS27nZo3e44K1RHDqx2IZ0s8Cswcz1gyVjFBdPkRkvpKr0mJK8lRw5jb//aMeCuB
	cYmUqX1QBhUllHvErUmKmvOhaVodQcNpgBiGDBbReBcuPxpFuXK3QVXOQ5q7Hc5+shyJC7DAX1R
	Hm5S0CdTh05gz42EVxRr1+IwMZe/HTzc3d62pgUex4WcyNcKAT5bMtoNTDFzThmQJtZBetiGSTb
	TVqNTaK1w4RBiWbzv3ak3OQE/N0s+hYqf+Rt4f3FQTFvK0SMiRcwDKgl233r7aS9sPIEZRybtOg
	==
X-Google-Smtp-Source: AGHT+IFrGqCzQhcjTSU7ysAq7nMLYxglnq8hHZ6VPpJOPszP8Z5AoHTJNhfSJzn546rEJqhTWV4czQ==
X-Received: by 2002:a05:620a:1918:b0:80e:ce0a:404f with SMTP id af79cd13be357-813c38aac77mr1297663885a.56.1757443457707;
        Tue, 09 Sep 2025 11:44:17 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5f715c0bsm160164985a.61.2025.09.09.11.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:44:17 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Soumya Sambu <Soumya.Sambu@windriver.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 4/9] rust: handle softfp fpu
Date: Tue,  9 Sep 2025 14:43:57 -0400
Message-ID: <4771827347dd5a68f523b4fec1b3155bcf344e62.1757441699.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757441699.git.scott.murray@konsulko.com>
References: <cover.1757441699.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:44:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2160

From: Peter Marko <peter.marko@siemens.com>

With TARGET_FPU set to "softfp" stdlib-rs fails with:
error: Error loading target specification: ARM targets must specify their float ABI. Run `rustc --print target-list` for a list of built-in targets

This fpu type is set for example for arm in file
meta/conf/machine/include/arm/feature-arm-vfp.inc
when TUNE_FEATURES do not contain "callconvention-hard",
e.g. when using tune
DEFAULTTUNE = "cortexa8"

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 4d50135cb902037380915966ecc97399d32e9f74)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index 1efeabf..feaec6a 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -392,7 +392,7 @@ def rust_gen_target(d, thing, wd, arch):
     if features != "":
         tspec['features'] = features
     fpu = d.getVar('TARGET_FPU')
-    if fpu == "soft":
+    if fpu in ["soft", "softfp"]:
         tspec['llvm-floatabi'] = "soft"
     elif fpu == "hard":
         tspec['llvm-floatabi'] = "hard"
-- 
2.50.1


