Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5557D19528
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:51:40 +0000 (UTC)
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36301.1769471498726570142
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:51:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=VPu1kqEC;
 spf=pass (domain: konsulko.com, ip: 209.85.222.194, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c5265d06c3so669761085a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471497; x=1770076297; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crBbSeKHohzuEtKhNllQNs7e6RXihrZTrSFArcQN+M0=;
        b=VPu1kqECkEMTatviPzpV3lfB3A7fMyfc/zeG2xyjAeisdfMpCI1jLG8X1FsItiw8Wi
         14bUzD3iUVgz845FaUD8+SQcM1rpPSgudiPzunhThxrO8bGfqymlz2UegodSHXQZjgL+
         FvRzHiDGlKVBkOzIXro/2mYDwtryj3Zw7MpKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471497; x=1770076297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=crBbSeKHohzuEtKhNllQNs7e6RXihrZTrSFArcQN+M0=;
        b=ZW0aeMeijypJvIuPWwxywwLX8N0uB7YKnlqVOV6UQauXQOpqAl29mWHM3ovVtnSHNZ
         9ZXsO8TQ+gMtgfjCmwg6nP+NegIoPuYpqppRX4fC4CjiIOdSMAUbxNTwlJPKWErbdCa4
         Xkx8GrwFX9STYzWBtJ8hNsy1hcZinPtWxxC/c5yUwN55kcn9NORiBI3jUYCBMq2KyM1J
         rmEsxlnSRKAZSoKJqm1jjfsd728Bj/VYk3wvo4ch70hvvD30S0fNCOcBfu6IlhcCtOBM
         xZEo2dnriknSXtsaP0wrsRqzJZD/rizPeGBk6UDF60a47dXvE4n+kw/Ir2QZEz7OYU2F
         Uekw==
X-Gm-Message-State: AOJu0YxAtVUFZvGmMeRFQ3Ecg9qrgK6k0uk/DV+WVdSaAwmPy8HD8L6u
	nLQaVjytL3dUZl+Iy9vKBzCEZxKivR5vI1G8zhYRrfa5U/bAnkT4lfh/TQXZnSLxBVo52eXx55f
	ttZzqoHNyyQ==
X-Gm-Gg: AZuq6aJAQSZPEC2i4AZ1os/LsJbPOqo7Iun86ctJqFv4Lq9MsEdrkT8k6qNpgy/P2Z2
	g0T6+lVFfy7C+0G0fUuO308gT7F/Yky/HWNtDkK1ZOtiiau0Y29xx6pVmv0JhRP4t6amhM67NhO
	279knlso9St1Fx6R4eNt2+X7oD0J0Bh3GVuN/BCLiZFKMpzQDRyy3BQe3c1d0KHavfqa1FbTCDI
	4whU+mND9AZqgmuewHiUa5vP1EW2BjMYBFrBxtFYjOHkrvV5iu25QeJNGj5QRZtg00ZpgNqp2Y3
	YVcphevq7mSj2QsedRVuF3YATOXmNx0TKTqFNeuI9F4EEjFKWgji5zdHnWtUxC3rxmDNHB/h11D
	mF1yYgpM893D84m7Ze8VOnwLAl8NXRweMHd/+pgpQp3Qd3BUdI6uuqJ1F94aFUtLW3LepnVUuBp
	oWoUWQbgg2EH7Cy1Al+Q9LnViUHltfllLwByK+mdJS3kBx2D+6zxFp6j6YvGBxL/gvIsvByIzQr
	CNl1k/vAjgTFZFsNf6MOA6RqkJM3D3vQsfDNFby+gumya/M7JLC
X-Received: by 2002:a05:620a:17a2:b0:8a2:bff5:40e3 with SMTP id af79cd13be357-8c6f98ca9b0mr695210285a.38.1769471497486;
        Mon, 26 Jan 2026 15:51:37 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061293885a.15.2026.01.26.15.51.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:51:37 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 10/11]  rust-target-config.bbclass: apply signature exclusions only to native/nativesdk
Date: Mon, 26 Jan 2026 18:51:14 -0500
Message-ID: <5996211fb8f22ce9e55e0fd876c5e3c73b29a06d.1769470900.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769470900.git.scott.murray@konsulko.com>
References: <cover.1769470900.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:51:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3100

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
 classes-recipe/rust-target-config.bbclass | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index 73f13fd..0f1e2e1 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
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


