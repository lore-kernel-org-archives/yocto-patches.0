Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5A9CD1292
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:16:20 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13114.1762632971739091770
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:16:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JtnFfmFf;
 spf=pass (domain: konsulko.com, ip: 209.85.219.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-882475d8851so887336d6.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762632970; x=1763237770; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NinUJMA1QVpPNFNDyekNItgGbT3/YI6z6kNNsE7794Q=;
        b=JtnFfmFfKgYORVnU+v6dMJDcAHd0v7ynMjlvtymetVhykI+EA/2H6cb3jKb2G4612s
         OJY871Aqj/z8PU01qQg3nsLvGNsWO0wfflzvAypTcp0S5JbAbJT2jkprAmAT17qEW4u7
         UgX2waXxmE+TPqZ/9hCS8vh/MvZzChvfIZ8I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632970; x=1763237770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NinUJMA1QVpPNFNDyekNItgGbT3/YI6z6kNNsE7794Q=;
        b=ESAV7PkeUeV17sDpwgENZvO/3NUAlRx09FYC4C3z6QXeiqwsHsuirJ2Z11LpiCrriE
         ay+lWyiOkpWfODZMinVrAiswkxP+2aTvtn8nUEczahWjVUzdvumBR3GJ67HczQItyHd9
         veHvDY7x1xCgjkDJzF77/lP5sRA+7WhRJzWcjxLWwdW6DaRcjmiNPhzZbjVnCVEHAhcR
         qDwS1eLdbxaFQqlcev7tNgnLf819VSX8a+k9G+D3HZY+41XTvCWUNQzH+SzHAaHIXj0b
         TayORpSfTzxO0buSQnnqUI+jhxIidYwo+BKh9u+CgkBqdNXQwdg1nbFowgEJWIXozflc
         d9Yw==
X-Gm-Message-State: AOJu0YwPiXhSGghwfnLEt1KOsxMqZloQx/db+K/j/wVwp05GLCtK6GGp
	IG+pL2iMPj0Ll/HMrnXbIZMxpwwc6zPaAPHjSbYVPFmXNtf1HMRVzfHR+nWv22pdl8xGsuc5rxm
	P6fKN
X-Gm-Gg: ASbGncuSL+ftemW7NgQqwTc+oYINAiqRWtBdOl8NkfGvSOo/QAhmXdoGbfXFg/gy848
	r0rLFoWwlnGnYnW5a22sO99okWgpnw9mYzDvfvWVZHJ2g1BvRl0tWvrtUnAZYf1Zn8gxDB5BVIU
	EFUAM1AUoy1JreSox4qUPkJ1TfRMirLF7jhcvLHBVGkCQDX3wvQXq6qlmKnuHfq3sl3XQM2cgs5
	i6rJ69Tw92METUNQfjoDW23R5sU15bvIK7kUp0QQByWh+XSJmZ3L9EEddLCQh7RCLUxhhiE0gDO
	qtI7o8TPLhgJ+kQrfmo1BR3EHQLJI2n9fODES0/A4MqUonfIEr1bnQ8uaFU7MDtM2uekYtPJp16
	HzG5Clu7xjjcMa9YQuDXedmPiZ3dwfKQyowtSoDO/8nZ5mDSMe0FX44zkHy1/dhFuxum0aOGqZ/
	Wv8qRb8Vew/4sRgnzJAH+Diwgue8x2Rpqp34MYvY7eozlihcYXUH3N
X-Google-Smtp-Source: AGHT+IF7GAaBKrIW97M4LaZqqi5f0Nd7R3gV8BFt+nfzCoHRINOoYnzou+Cy8eR4Vn0yXc4p4p7wnQ==
X-Received: by 2002:a05:6214:29c3:b0:880:5042:e38c with SMTP id 6a1803df08f44-882385b56a3mr44842546d6.2.1762632970383;
        Sat, 08 Nov 2025 12:16:10 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm20001896d6.53.2025.11.08.12.16.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:16:10 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 10/11] oeqa/selftest/rust: strip debug symbols from test binaries
Date: Sat,  8 Nov 2025 15:15:52 -0500
Message-ID: <5bbdbc6f938aae72a40f25ff7c9e2c34855840da.1762632742.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762632742.git.scott.murray@konsulko.com>
References: <cover.1762632742.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:16:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2445

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


