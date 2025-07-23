Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4C5C87FC5
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 19:05:59 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web10.23089.1753297550091699524
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 12:05:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=llTcxDoA;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e32c95775aso29843585a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753297549; x=1753902349; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUnqpfFGrSBaqnzc88XIMmiNDF+IN4xW2ZozYk7IYTA=;
        b=llTcxDoAT6xVSIuBJepuKyWrMpBVuMV34aeJ5sFIoq85cIUPEcULYAvbObuM+1ZGAE
         /tY4aAqf4rDzHlYfUNoRKylp+qVq8PUSOiPbqc7GBiJfpG+9Dp4NPqRU+aqfUWsb63H/
         6Iu9A98ZQIUkKRa2ONjUMTWcSBaKna+JO6BkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297549; x=1753902349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUnqpfFGrSBaqnzc88XIMmiNDF+IN4xW2ZozYk7IYTA=;
        b=sS/ElLH512iGFGFbLSvxYQizX1uVM4OZgllnTWwS7HwY1oYuRudAGLujh6oTp53FAu
         7+plebOo09KFpoNROJ69o865ul1a1N3+nLqYSZIqLztHPQxjYQMiAN94K1RUDETcmp8d
         eAxu+C40WFB78F13rLgsnaLigl+6ha4NtHp9IPDgKlaWJ0f/1LVEyvrF1+TWknqEeRjR
         m71Ik5h5pTY7rpwpSDbY13ZUNnREFgKc6FCX8LtJHvYzvygj3+gLjLLRMh789g3cv2ZX
         vOzK+IjRq+fmNgdbZTwBzDxEsCBnq+RIglOuXAX8z6WU2ayoUnu4jDmSredUo5Zq85p1
         afvg==
X-Gm-Message-State: AOJu0YymmIYzGrrfvEnhYomn/wfldM2k8FLPPGxFlH5IW752zsOOw9gw
	ArPesqQMaLkwJT388N1h5muAJKPVixLDH34V0wvgxVR5MssfRHJy4idEoh30+bJQQTdv+pvh7nb
	xVfNX
X-Gm-Gg: ASbGncsI/9gzFQhHAjPlyQG5t39douvF+RJqC0F8+h19ht9E3YZEZfciduZhUl53YIQ
	1WffCIqTFWEs1WTSypnD3ifqxFmoWbaRHR5tp+HWbpHxTKQN+WRdf2b2G1qaxMnLv6msZwgxds/
	25vmqEc+FxxQInkHheoif6xGWQzBL3K/pEhPIimNBE7lYoa/2C0YIcVBpbg8YxF29GLMEf/W1jv
	2yUWMiVR/QlS3AmEezXn8x8FNLZsE/497+KYLWw9yPimCrjAIijTgf6qyKkMv73V0R+qWtJ8Sv7
	f7YZiPiq8t42oz44NPsS5dC84b4PzS3KtN7inzES6mJR5/mozIbMPoBirF/0u5vb1nxgY0wQUX4
	IXE7yky2Vl5jtsEg5bqx1L5K9Y9zM0Zu7GQtZp6GMgFyFPQHvqMoafUqj+4QTR2dWbMLJd09umt
	GoB46xjCJ7
X-Google-Smtp-Source: AGHT+IE7PE3MCho9sUyxvE/yd93PpbH+exWaW1E2OUkqEPGYitwbRAfDc3QTWdhiGvYKD30SIPx4jA==
X-Received: by 2002:a05:620a:5787:b0:7e3:412f:1500 with SMTP id af79cd13be357-7e62a191109mr470150785a.44.1753297548868;
        Wed, 23 Jul 2025 12:05:48 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm703576085a.84.2025.07.23.12.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:05:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: soumya.sambu@windriver.com
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 03/13] oeqa/selftest/rust: Add exclusion to fix riscv64 builds
Date: Wed, 23 Jul 2025 15:05:22 -0400
Message-ID: <526a893a1cef959a688c2a3171ba94f0523a0153.1753296167.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753296167.git.scott.murray@konsulko.com>
References: <cover.1753296167.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 19:05:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1844

From: Richard Purdie <richard.purdie@linuxfoundation.org>

There was one failure occurring in rust testing for qemuriscv64. Exclude
that test so we can enable in automated testing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit a7f6ea5b20aa91e4a1b00dbea7a6447effb9220d)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/oeqa/selftest/cases/rust_mixin.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/cases/rust_mixin.py
index 1098e90..806ddf6 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -86,6 +86,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
                             'tests/ui/abi/stack-probes-lto.rs',
                             'tests/ui/abi/stack-probes.rs',
                             'tests/ui/codegen/mismatched-data-layouts.rs',
+                            'tests/codegen/rust-abi-arch-specific-adjustment.rs',
                             'tests/ui/debuginfo/debuginfo-emit-llvm-ir-and-split-debuginfo.rs',
                             'tests/ui/feature-gates/version_check.rs',
                             'tests/ui-fulldeps/',
-- 
2.50.0


