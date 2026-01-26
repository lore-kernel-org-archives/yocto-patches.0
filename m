Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D96D1953A
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:55:21 +0000 (UTC)
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35793.1769471712243715283
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:55:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=tVjznxm4;
 spf=pass (domain: konsulko.com, ip: 209.85.219.65, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-894676e6863so57307946d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471711; x=1770076511; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X34hVYCDGTsx7N0JZADCMd2BpOwcXEMIdq4hBhfaZ5I=;
        b=tVjznxm4mNv0Z7gYni6RdpUnrWCwR7Nsh16iPX42E632J59pNMZqcbFiJmTT11kg56
         DNbi0+MMwxqrDXcZuPfwViAA6XHAqun8VXN0Vf75SPr13jP7KfQiaU1VI/IiYn4MP99C
         aKymiqQpJ9xEpghsOAPP3LnPwzox2bF1k3VV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471711; x=1770076511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X34hVYCDGTsx7N0JZADCMd2BpOwcXEMIdq4hBhfaZ5I=;
        b=BKBMG/6J0DF/2fZ1awE+Vk3u3557mvY38dSarmbHrZnfstgZN+Be5YtgFW1bWtS1MB
         nZu+7o/I+dljLjuzHNGbO0SFm+JPINibgKx9EwDqXO5XBtpfozJuJs0+fMwsU+HgEKLS
         X/3ip/EybL2xqa/67UrUBKwHgmXMhJ3xfMmr0ZpOMM4A7/SpF1KISzi9rQWRbqGmAL9a
         QvZ3JOeF2OYguoDSMq0bgqQEBmZc9eRneJBEDn+kbWsuSStbEC3FJsa9rl/kwuXYcQvT
         Jb3qxugMedojVd61hyvdqTSSohkN5iYn215HTGXNJnSNd621GlfHZTRSetRG3htgxdDP
         OlAQ==
X-Gm-Message-State: AOJu0Yw5O/POw3blNewzWVUBSkhwWR2zzOiuz5FurcX1WemMYYdh8iF4
	P+X+yBjQWKRnvYC7tEMq9IobujREaogerBxAaY4ZauaDl2vlBotOZ8GLzlS7WlOw0LuQAuSSjL4
	7KUOW86zNkg==
X-Gm-Gg: AZuq6aLOmycZrhG3hXYj47Gz5rkbjoz6v/ckiCF0n8cHXq7lg0kZhtba3EyhjvElxjC
	k9nrPkZjy9z2JtoQoCdFTbhdiBw4cBgMWI73E2/cvwsoDNDunjyupFV72ggsTj5adyU6Sc/hoCk
	WQimcVOlE88R+/Y8zXSZj/vJ7HV1W8HNdrnO/7O30kWmONBV4R2ts9CWtVLvtSgBm+IVFF40ErQ
	8kw9lcCD9PFmr2CDUGHMveRZYny5+1oH/Q8DzUyYp0OOCdYuiOHxwoYsveTzkIgABXmAAXRHNjB
	ZCJrLlqRic0s5RkeaMfxm6TRsQ4TT+okdt7vxVSL0zX6kIHwT5CWyOR5mY3S2gUM2GEHKAikCm4
	YNC+gyEtTLMkUwGz3KDxdCxqDdjHGzFc1KwbeFCFdliOtj99R6aF5OFNihS9/BVTkb1cUqF1mMK
	6a0Pec4WzTjM5Piqb0UkxgRbvfys0Qu1nM1tmCrZsDgTnxBROJfI1ulSBuJnbqCmYgmi9AgBGJG
	PysF0/GaANQ8faRU2DuMWkylBKv/EdBCNS0FT9Zvo8n6jQ1XuyP
X-Received: by 2002:a05:6214:518f:b0:894:7798:8f8 with SMTP id 6a1803df08f44-894b070b3a7mr75214546d6.10.1769471710946;
        Mon, 26 Jan 2026 15:55:10 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061740885a.15.2026.01.26.15.55.10
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:55:10 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 10/10]  rust-target-config.bbclass: apply signature exclusions only to native/nativesdk
Date: Mon, 26 Jan 2026 18:54:56 -0500
Message-ID: <6baa9afeb88a4a9b4a0e82dd7e3e611438999dbb.1769471543.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769471543.git.scott.murray@konsulko.com>
References: <cover.1769471543.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:55:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3112

From: Alexander Kanavin <alex@linutronix.de>

Applying these exclusions to target builds and expecting that rebuilds
happen when they should relies on incidental
mechanisms like paths or other variables using the excluded ones.

Rather than think of possible scenarions where it works, and where
it doesn't, let's not exclude the variables from target builds, so
task signature calculation can be relied on.

[YOCTO #16132]

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 483005f752d89dacb869236a4941981f2698c29e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index bfa4adc..7cac4c2 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -415,8 +415,10 @@ def rust_gen_target(d, thing, wd, arch):
     with open(wd + rustsys + '.json', 'w') as f:
         json.dump(tspec, f, indent=4)
 
-# These are accounted for in tmpdir path names so don't need to be in the task sig
-rust_gen_target[vardepsexclude] += "ABIEXTENSION llvm_cpu TUNE_RISCV_ABI"
+RUSTCONFIG_EXCLUDEVARS = ""
+RUSTCONFIG_EXCLUDEVARS:class-native = "ABIEXTENSION llvm_cpu TUNE_RISCV_ABI"
+RUSTCONFIG_EXCLUDEVARS:class-nativesdk = "ABIEXTENSION llvm_cpu TUNE_RISCV_ABI"
+rust_gen_target[vardepsexclude] += "${RUSTCONFIG_EXCLUDEVARS}"
 
 do_rust_gen_targets[vardeps] += "DATA_LAYOUT TARGET_ENDIAN TARGET_POINTER_WIDTH TARGET_C_INT_WIDTH MAX_ATOMIC_WIDTH FEATURES"
 
-- 
2.51.0


