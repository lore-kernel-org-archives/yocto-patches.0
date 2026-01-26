Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A2AD1952A
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:51:40 +0000 (UTC)
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35708.1769471497844572384
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:51:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=M2R3cB0c;
 spf=pass (domain: konsulko.com, ip: 209.85.222.196, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c530866cf0so582771485a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471497; x=1770076297; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tj6k+Q88wia/hqIxlRygVmI7KgKLdW14pfs+Izpu0hg=;
        b=M2R3cB0cuXYYSRlWBbu3ypAb4e8TfbIci98SqV1mIzaiR7+ebbvp3FJNwC2vAvMk41
         wdAt14XcsDP5guVpbXvyd+DjQBPGTjqH5TSu3vzX+RlB3cmr1li3JJOJ/YEH52BY3Wik
         6BO6Wdjujk/TPAAZYjfitUEfajxlua0PBgqW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471497; x=1770076297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tj6k+Q88wia/hqIxlRygVmI7KgKLdW14pfs+Izpu0hg=;
        b=m4JwwILD+ApZfO4X3uB2IlPblQFARw7UnPsJNdZ2sNrio6rxBtnnTThTxdEYsMeDTu
         A/+E9Q3RmSNXnDSUycBz1jgD9OIrPl0hMM4qM04Rw4Ix2iSyj4vNdVf1p7S94qWORo5s
         l4Isl3njh21eEM5OwUfuM/iSaTsvlPu2LZZ13mlwWiz19pdNW8roePRHcBpV2XIhkkaN
         /eU7kElIZC6KujAOn3gcXXNWEunRPKzrRTzcvB3G4Xj5d87EWc4HP91Ue6WOPKMydDrv
         KWRZkRjE3lbehYR398cPYSBzxs2ebeaRaCcK8R0gtWZoKV6FwfwWZq+e57j3HHJRWfkz
         j1Cw==
X-Gm-Message-State: AOJu0YySe/dqRl1tDxOiDNs4bal1ZxeUfas6VOqcrmWtqmQU4WClYbKo
	t0ySFGLoco+gQTV3hYJi7knNsemkeWbdg9Svw/DGgqsvM7ahencwlBXD91kp8qtHlOq1nDfio7l
	pvONC0Ex/cg==
X-Gm-Gg: AZuq6aJFmG9CuMifbaQPtJuV+Pwy//qBQOtL1QmL/px0O6FDaEIY0mJVADt48afgRt/
	d3NHm4MS5iUNCYQ3NRGMmVRRwxYZ8SeLJKn/50nUCgZc/eQh67qeLLNy435sT6GzUt2VNthTDbW
	haTwuGOI5zxKB3i9MSHpsLGed6vTaM2s8WAwGYDGnQhGpieirtqIwGZKJm1GmhVfW6+KDhAOnkv
	UJTloQEull5ewm8YJPFDuKX1ILgPPP8HDa/Ero0PUWr84GuprTe0sNVP7O2IbaI1NkX436k+307
	1bQgkG9rh96vTtxsHwS2ll0h6YbX64aMReAud8iAMWqBM3oVE9aqzr0aW2EHBSrYnmCFzrkaQzn
	3P2ZsrUj10wz0Xa4ebHg+7aQ3k7XJ1Sll8mZFHuR/N4v6l+guj2oAH7pFdSOSSFA2dSzPANC3Np
	ahNldaoukUP+jQl7i+rx76sRjHj0nfDkSqXbzAorDtSRgPDe3QyqwAkZvDfIbl6L2dD2X4DyDBs
	1dkQo47iWRDHU2CF//q9gVMubCAbzc7tauoIO6clR6cWy/Jvpv0
X-Received: by 2002:a05:620a:4002:b0:8c5:2032:3766 with SMTP id af79cd13be357-8c6f959a272mr779150285a.35.1769471496644;
        Mon, 26 Jan 2026 15:51:36 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061293885a.15.2026.01.26.15.51.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:51:35 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 09/11]  rust-target-config.bbclass: add RUST_TARGET_ABI to sstate signature exclusions
Date: Mon, 26 Jan 2026 18:51:13 -0500
Message-ID: <0b09e58edb7fd57bf5583e7d80e40a390d1e2642.1769470900.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769470900.git.scott.murray@konsulko.com>
References: <cover.1769470900.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:51:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3099

From: Alexander Kanavin <alex@linutronix.de>

This was overlooked in
https://lists.openembedded.org/g/openembedded-core/message/218953

and caused non-reusable sstate for rust-native when
the target is one of risc-v machines.

[YOCTO #16132]

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 9993e62f35c96aa8fce39a583f6cc391c0cbba99)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index 41e5362..73f13fd 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -416,7 +416,7 @@ def rust_gen_target(d, thing, wd, arch):
         json.dump(tspec, f, indent=4)
 
 # These are accounted for in tmpdir path names so don't need to be in the task sig
-rust_gen_target[vardepsexclude] += "ABIEXTENSION llvm_cpu"
+rust_gen_target[vardepsexclude] += "ABIEXTENSION llvm_cpu TUNE_RISCV_ABI"
 
 do_rust_gen_targets[vardeps] += "DATA_LAYOUT TARGET_ENDIAN TARGET_POINTER_WIDTH TARGET_C_INT_WIDTH MAX_ATOMIC_WIDTH FEATURES"
 
-- 
2.51.0


