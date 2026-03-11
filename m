Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB73F1125821
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 13:44:14 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21798.1773236651892010762
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 06:44:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Medsw6fQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439c944bb62so5455068f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773236650; x=1773841450; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RmQ5zfrlRGMXBtbwicC7En3OIW799V3fDIKJ+fyKVfU=;
        b=Medsw6fQtOxxmWEY5tMfvLpbStibri/y0OxBz2HdOQqBkBJJA4cqxJHKz/85X2uPEb
         BCI9OMXW3MurzfY9ji+ckxxU4xowpRExs7cVlvMZXnCMyfSdpAlH9OfhEpbucVbXkPgL
         oO56Xyai4n0EiotuQH6iLFSMU6dZGnz/8IES4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773236650; x=1773841450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmQ5zfrlRGMXBtbwicC7En3OIW799V3fDIKJ+fyKVfU=;
        b=K4f7DZ9Razc9c3Ygn+RCI+5GD6OyLqd1yPgak7ejwqBvmlP6t+oaoXsEfTp0p6WnO2
         Z3yOMvqofnockreTjyHBN/XbIZ9eXkBpQQyG/MMZot6rzJX1UVpxWpl5e5bqmfa84Duy
         x5VNi1dBDb06c26H5vHnGZBytDMICoPYR5RT5rX90oeBTy/5GzWkI0yOSq/B/S9aP9oD
         +cfb1MIRbj4QZEpzIes4xyBnD1kHFYWvZPfzdjtBB556vKDiIsbrVWGCnGjOqz/n+Xx2
         WNAGXgKHNHX9ljeWo+cMM5YhJ9GyCwglql6TYF9JPIb93ej9THxNCz3a7v2SmCYLRrbU
         ZIkQ==
X-Gm-Message-State: AOJu0Yw1mxDTv43tu7tpqfuH1E3uRsgJyonzhqPvoNwQZRa5+yqNzuPr
	5Tb18ElcjChjx41iXqd7vZM50Qwz9/6HgDszlmnX8FHXLto6RTTLQV3ZLoys5LXIFyvXMJS5jHU
	GWM5HtTQ=
X-Gm-Gg: ATEYQzxdWNkW/gCmguLQzcCk+G0Fdu/V48IPOfCZgeAwDaEk/UBa6CKQi8UrWi9FveV
	6mB6fXK9V5jdRlmpK7c/5InSiLdEbWFY2qwEX86e5LPsz/VWPry1lM8U0BrHm0EFd5qycB13HBx
	VZDUvmixd6MM2rLRYJgYAsVmhCo+PYK4SMfP4u2Joq7QuwXNCJDYm+6bbIdz9cRxmIbodHQgOJR
	0Wh6L6qGV65CpwyzQ7CyOJ9NgpUZNLn/GgwXgKiXRg5jaXQowN7WfoKy+0oAqD1FxjwPevo9ZMU
	wX8U67oexf16LCPul+iSbffFNxrybx4dxDiIKbTGTcZtbB2qHGsWbXKVARj+cyvOzbQF+V8qAcG
	SzoNYdHwN7fRAPbQwfOgY0uFYESpQIQZjmsLJlL45NasJQmv2FstT9vCiMKOf9liQ+6lJSA24WT
	H3T17VdSG2t/ZEtr3//pUQ7X7uw5n0yL+rhbzf06OVmP70fQG3Npc=
X-Received: by 2002:a05:6000:2082:b0:439:cba7:53a1 with SMTP id ffacd0b85a97d-439f81b643bmr5150880f8f.11.1773236649551;
        Wed, 11 Mar 2026 06:44:09 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7fc5:b1af:c486:ad0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f818f449sm7544470f8f.2.2026.03.11.06.44.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:44:09 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] config: Move meta-agl out of a-full
Date: Wed, 11 Mar 2026 13:44:08 +0000
Message-ID: <20260311134408.3459235-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 13:44:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3433

We will no longer trigger meta-agl from a-full.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 8aa18170..2a8ee082 100644
--- a/config.py
+++ b/config.py
@@ -102,7 +102,7 @@ trigger_builders_wait_full = trigger_builders_wait_shared + [
     "qemux86-world-alt",
     "oe-selftest-debian", "oe-selftest-fedora",
     "qemux86-64-ptest", "qemux86-64-ltp", "qemuarm64-ptest", "qemuarm64-ltp",
-    "meta-intel", "meta-arm", "meta-aws", "meta-agl-core", "meta-virt", "meta-qcom",
+    "meta-intel", "meta-arm", "meta-aws", "meta-virt", "meta-qcom",
     "qemuarmv5",
     "qemuarm-tc", "qemuarm64-tc", "qemux86-tc", "qemux86-64-tc",
     "qemuriscv64-tc", "qemuriscv64-ptest",
@@ -134,6 +134,7 @@ trigger_builders_wait_perf = ["buildperf-debian11", "buildperf-alma8"]
 # Builders which are individually triggered
 builders_others = [
     "meta-oe", "meta-virt", "meta-clang", "meta-exein", "meta-mingw",
+    "meta-agl-core",
     "bringup", "bringup-fast", "buildtools-docs",
     "qemuarm-armhost",
     "check-layer-nightly",

