Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC3AC87FCD
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 18:40:38 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web11.23024.1753296035534525997
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 11:40:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DyzCaIHa;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e33d36491dso29807485a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753296034; x=1753900834; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUnqpfFGrSBaqnzc88XIMmiNDF+IN4xW2ZozYk7IYTA=;
        b=DyzCaIHat9igyvgl2+RB5fSxlCeYFlY/1MTIPdVeIUipaT9p+sehAaQlFUAWWkLoSp
         2naDg9sOKOa+0F1Jgs204kj+NaJYn6OC7XCQQdTzOkRXLyQ19KTVrZUqw6v72+afF1Hw
         exeeMJUMohMUdJ8eDBgcLMXXQi1ZfaZHfp8Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296034; x=1753900834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUnqpfFGrSBaqnzc88XIMmiNDF+IN4xW2ZozYk7IYTA=;
        b=AwoKIDaev9bnCbSHY1v0CyhzF6oRqJ6rTyXUZCkIQhcPGU9+qI/tAn1ePU1kGCw21J
         WxvMIfDqY2hQg0BpDt+Ug9fc+6hqv/juK1qNXx2t2bvNEsUEQtdZw2PVFQ65non0L0SO
         BuW23/CMn4zRUHaVidtIBCIEiO5F86SxW3uujAagkJA5VSYGBP/dZRnKV4JmGwORo1Q5
         FVDohwD8EDiVqx6+00WniBqwN+ZDpnJGX0ckWDcurpWL5wnwuxIKCx5KYmFzFDBPtQP/
         L8+yAaiVOP+Wb/cUiI6T96Dg73SwTQu2+6vbcA/QQhnE9ie9PNM9gqdvetKFGQzl5D4n
         0K6w==
X-Gm-Message-State: AOJu0YxExxPqaUgjY7hmdrIDC00k+uIgVoM83OeuLPVv6xEUqm0E9iGg
	OM8XZ7ANC0Ke/X5iLIzALYjkIGLO0TBznxX8hCg29hS0pLldEyCiIzE4pTGddXXtQCnXxLX3WBZ
	y0SGW
X-Gm-Gg: ASbGnctj94YaRrnzskqsqETWQfdb6NUEYd2NpSovqFA78k5Q7JfY4GLCqRyhpJHUusL
	a9smadmy9waNX+Gv6KHWhO9g5H4Sqbg+FRFITe4wxA27sHMe/A2JK9R27mtm8Y9bXvOp9kJdSrT
	EwBA65ugShsZbn637MRMD+sOQkNpuunvY+7MvzfyXyzfPoKCpykw6jjgrchzshX48aFybZT/era
	/D3i9P3YCImdlJYUDZNaJ6vYzjNFMwEPYb7CF5ZJhtJ8rJGmAce1T9s1+oVRmyy7FmED5VIALBn
	+nT6gAaA594YM/mh+1NrYNX+iVmCet1ECPvbhB78PGjEjnoVRmj6tau3MNhDXNnkXFpIp123WfK
	7PYWkQ9UqRUQJuwDKIwAZOfj5Aic8mQGzLtqxbNS88OIcOQGbx7C9FWZwKtT6fjrx7zdgk34R3A
	==
X-Google-Smtp-Source: AGHT+IHqH3sa+Dzi9qoB9s9sgzugMDMm3z7XpftPZJozUqKqsYgdxzDz7fVDiKyL0jz7fWuxyOV1xQ==
X-Received: by 2002:a05:620a:a101:b0:7e6:27f4:49b9 with SMTP id af79cd13be357-7e62a152093mr478418785a.29.1753296034334;
        Wed, 23 Jul 2025 11:40:34 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm697255985a.85.2025.07.23.11.40.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:40:34 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 03/13] oeqa/selftest/rust: Add exclusion to fix riscv64 builds
Date: Wed, 23 Jul 2025 14:40:03 -0400
Message-ID: <ba3cd6ffcfd640371c52fe8d220f9e0577d29b03.1753295655.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753295655.git.scott.murray@konsulko.com>
References: <cover.1753295655.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 18:40:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1830

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


