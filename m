Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F8EC3600C
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 12:13:09 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.20878.1742991186005898809
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Mar 2025 05:13:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=V6CWXcdP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-399737f4fa4so3447028f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 05:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742991184; x=1743595984; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7676/38MdDuk+o49B96YX0811tfnCIIIpKSDGmTxvIw=;
        b=V6CWXcdPT9fHnfAguBd9qrnHjhYc/y3P66QAN+ORDTHW+B4w0/bcxzRUZIavov8JZ1
         XyGcvHQeXhrGSdmuZA003ZbLMOg3OdCVyfSfXbhXgg2iXR/sStcTOveh45lIv4k9RyRx
         WCCM8GqRCC4oyLBIZF41odXLQZ4PtN8s64sBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742991184; x=1743595984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7676/38MdDuk+o49B96YX0811tfnCIIIpKSDGmTxvIw=;
        b=AR0XtcExRqzUAdwrBvl/FmILxlASfMwzF5e1Ra62yEdfQk1AykIpImu4KlznB1BBBz
         P3kfw2MnEpMZbpMF5kAxWqMmU1iXMH6eS1BIG55sa/Vek8FZbdSsIGf9EVCLyF815LtP
         LYku3yyYmKPIOR/32tCkUAe1LIRZFnBhsOCPPXq5qRxitub62h3BwyGim62lkpk66Z8X
         HqQ5lrXSlx0ZFAdVloS+LiXJWvzAMvFTkafzArdY0ofG4TFCLJioO8DooRhpyaZZ5AGQ
         dBq5JsobCsRqJWRB2zq3AyJXZni7yUfwajiI7+oDLuoT8mpCIjDHfVGTKgA3PhEjpbW+
         AM7Q==
X-Gm-Message-State: AOJu0YwpuKXbeHFRx9Gv+6/DCOIyrzyP2KV/Qw8RSh7iMtwdd2DRZ/Ww
	0dh0Q4PmLbjUHKTr0F3397MdYrW8thE4cm5c+v1w8kTGKfPuuR+v8pZUtC673GI6vYck207mOpr
	i
X-Gm-Gg: ASbGncvSeVqs48GqKu2AlqbnjEuBJdXhlNPl5SHMCIFVLRWrMS7l8NXteAUIdgow7kN
	gBcc/26ITD753c9uEzCc4kq1kb0/BqYlh6b9+9m/4Rf2SGYY8Y8oEx5pSI9bXgieCu0cCzH1SV1
	LqfVEtYLrSmLbJDj+bIF/43cZuj68Janb57YLKmWryPtbjflzw9C4VXYgFDPYST5juI9ffSGWJc
	ITMc37PcYCQbeqRPqHOzSP0/+h1z2Af5c7LoECgNBzELYAcnykiRL444g01Gimau7g9lBJ516eD
	oaie6YMhO0FZ1pz0H6GqIEamw+X3AhW/DS5wF2kw0dRrW2CWu0ipHG0Gowob5Yv7IYkPy7dgcdP
	wblpzsgFk
X-Google-Smtp-Source: AGHT+IGaeXSgJSnp8YbK7HMidlJaBXW+osAsURyC4QcQXsDLqj5Wh97sP+epJq8wAzgofwmI4cuLlA==
X-Received: by 2002:a5d:6d0a:0:b0:391:13ef:1af5 with SMTP id ffacd0b85a97d-3997f940834mr21073736f8f.48.1742991183771;
        Wed, 26 Mar 2025 05:13:03 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fab8:513e:e094:22ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39abfc2115asm10628895f8f.4.2025.03.26.05.13.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 05:13:03 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] config: Add a musl qemuarm64 target
Date: Wed, 26 Mar 2025 12:13:02 +0000
Message-ID: <20250326121302.779854-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 12:13:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1255

Add an arm64 build to go alongside the x86 ones.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.py b/config.py
index 4ceb91a4..be3829f9 100644
--- a/config.py
+++ b/config.py
@@ -145,6 +145,7 @@ builders_others = [
     "qemuppc64", "qemuppc64-tc",
     "qemux86-ptest", "qemux86-ptest-fast",
     "qemux86-musl-ptest", "qemux86-64-musl-ptest", "qemuarm64-musl-ptest",
+    "musl-qemuarm64",
     "buildperf-debian11",
     "buildperf-alma8",
     "reproducible-meta-oe",
@@ -295,6 +296,7 @@ builder_tags = {
 
     "musl-qemux86": ["musl"],
     "musl-qemux86-64": ["musl"],
+    "musl-qemuarm64": ["musl"],
 
     "qemuarm64-ptest": ["ptest"],
     "qemuarm64-ptest-fast": ["ptest"],

