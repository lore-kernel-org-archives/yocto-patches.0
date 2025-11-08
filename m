Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A619DCD1292
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:20:10 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13177.1762633203370871917
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:20:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=mROtLbXU;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b26b12be9eso12141185a.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762633202; x=1763238002; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NinUJMA1QVpPNFNDyekNItgGbT3/YI6z6kNNsE7794Q=;
        b=mROtLbXUfRKySpMV5IUFm9bq8KW+F+lBFN7zzSqUxm9fIcMN2uKup/sTP1qvk8wKBy
         xOP17OsZntu60/OUfHOvEXW7VjGezYdj0GTiDQ2JxXiQ1FwtjhJBeW/eh15XBMS8zsP+
         QHH5hxM8kIwIGGOR9WTkIjpUDrJ8fn8we15Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633202; x=1763238002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NinUJMA1QVpPNFNDyekNItgGbT3/YI6z6kNNsE7794Q=;
        b=gyWLojq+FnO6stp6lW1GN+e7RhoWDMyAxd3qgbeUEwCfY1mWDDYYDUU9KC3QcJ2x/H
         KjaGAc2jV/71ovDsCMaO0rCQSumEifpwrQtu8d/Y6GjG3yNa+i58lwb9nmCZ/FqNVtLO
         gaWa5dNWm4bIjOmIEcCiN3J/HIV/xrSpL9PyXQEAGfdZx/X4VWyldPKfKlfVHpzNWqnP
         1Zx7lbd3KyLiJwnMg9vC4ldMQqwL2NqLYp2+TU0+s+VLioL05IcBiG9mDCI+wo5v7TM2
         2OWY1mlP2MIhuZo1oab6EA5eAHR2HXpyriGb8p0f17KBSi1BvUed7ZqRvKAkQABe8MVz
         Feaw==
X-Gm-Message-State: AOJu0YxGpuw8sAXZeeXw8L0rKYVNj10E+kZDL21XMlOPvKHmbi5udACh
	lUjAmuXMBMtxdf3+Rpmf/qeAVpop8RXt6VS2lkOPNA/jZCepoWZyIiebl0mWYZUumA9sLMo2d4k
	ErKNk
X-Gm-Gg: ASbGncv5MXzCfSSBLhi+b8Om67owEsUn/+FcxzmD4/67nVsAdZSZyzXnwhgBPcEL99J
	glD2KhcVpSQvjKhIo10saR9GffSSr3/zqGFgxh/H7zAlPE4VwHU0SBXMvFwU93aieqmoTnaWCZe
	dlpuG4zGLkPSoipp5+k9QkJSoMXZiSeoM6mOEeFESfYPv24/vjpfJcGnuhsBuhtSOHBQuAR+FDI
	mWpbdyREwq+9RZERshyBiHv8b3KM/tT2Nk6P9J2XC+bWedDkLRgzJDQQLfiUquYeEGvsgagGC/T
	FwI6oNo/KIB97yQ7dUVKktmKr56cFvz8T13Ir6uCvWJN67mwBDWtavMzTp3VhrIrCnJcoVUeKx0
	rrY+BYMZFZgcFlPW90fquCgto60o9cSneHM2feUSRp1cxHRCZm7S9v+Q3GDCifzKhbtEe4s51Ay
	fDteCXzUBMAx/k5GwYBuOXr9m3gAXtnCu51uB1ytVbHkMFMM57Gy5K
X-Google-Smtp-Source: AGHT+IHo3ekrSbMc8st6KJu4rOoudn8QzlkmkJgsyrmaNQkGtRlxUpSTA2L/Q4o6ldq3+hELURYGBQ==
X-Received: by 2002:a05:6214:628:b0:880:5193:10fb with SMTP id 6a1803df08f44-882386eba88mr41767206d6.54.1762633202013;
        Sat, 08 Nov 2025 12:20:02 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238ba36d4sm19786856d6.58.2025.11.08.12.20.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:20:01 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 10/11] oeqa/selftest/rust: strip debug symbols from test binaries
Date: Sat,  8 Nov 2025 15:19:45 -0500
Message-ID: <363761fad5ceac7fad12c05451a32b9db942fd36.1762633051.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762633051.git.scott.murray@konsulko.com>
References: <cover.1762633051.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2457

From: Peter Tatrai <peter.tatrai.ext@siemens.com>

Strip debug symbols from test binaries using RUSTFLAGS='-C strip=debuginfo'
to reduce binary sizes from 300+ MB to ~140 MB.

This is especially critical for PowerPC mac99 which has a hardcoded 768MB
RAM limit in QEMU. Without stripping, test binaries uploaded to /tmp (tmpfs)
cause 'No space left on device' errors during test execution.

The size reduction also benefits all other architectures by reducing
memory pressure and upload times during testing.

Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit ede3ac6f587507f98ffbe9a8b07e21e57c27c986)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/oeqa/selftest/cases/rust_mixin.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/cases/rust_mixin.py
index 95859a9..b7213f9 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -121,6 +121,9 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
             cmd = "export TARGET_VENDOR=\"-poky\";"
             cmd = cmd + " export PATH=%s/recipe-sysroot-native/usr/bin/python3-native:%s/recipe-sysroot-native/usr/bin:%s/recipe-sysroot-native/usr/bin/%s:%s/hosttools:$PATH;" % (rustlibpath, rustlibpath, rustlibpath, tcpath, tmpdir)
             cmd = cmd + " export RUST_TARGET_PATH=%s/rust-targets;" % rustlibpath
+            # Strip debug symbols from test binaries to reduce size (300+ MB -> ~140 MB)
+            # PowerPC mac99 QEMU has 768MB RAM limit, so we need to minimize test binary sizes
+            cmd = cmd + " export RUSTFLAGS='-C strip=debuginfo';"
             # Trigger testing.
             cmd = cmd + " export TEST_DEVICE_ADDR=\"%s:12345\";" % qemu.ip
             cmd = cmd + " cd %s; python3 src/bootstrap/bootstrap.py test %s --target %s" % (builddir, testargs, targetsys)
-- 
2.51.0


