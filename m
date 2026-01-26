Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D5DD19523
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:51:40 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36293.1769471490927009761
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:51:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=NVoHdpuw;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c5349ba802so519861485a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471490; x=1770076290; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmofS/kF1wA/X2YOsua2T/5dd4txnyqYvN3uwgVwjLg=;
        b=NVoHdpuwtpuoPxktfsjL/lBACID7x0ysR3K0h+k/RLTX7JVjP3CAaeoEeCAOZaVKWr
         zJ1GqOjEA85a+HRJYkL3tMOuI+C6g+ke33w60JzZq8g2Ee66MXrj7bSlI6jflUPpaqYB
         QsdADJlJLK/+gWYk/ZTbW177kAGB7CpQGuvsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471490; x=1770076290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QmofS/kF1wA/X2YOsua2T/5dd4txnyqYvN3uwgVwjLg=;
        b=Q6s1PvkuamSky8wP8ZI+JMvsk/k1YHLI29j6jUIOQIaXMj/YK2fxNKf+ERIPirL2bY
         iIP+1zOHLZVzhD68P3Fb5yvzYkh20pWbEvZchtQJnJ01/x4/znJEcvmTpsKAmE3CCmo9
         oFwFq2Tq/L695zASXrvvtGnxjKVBSGKtCPo2zG7Ru5dpqyJkixZqq/6WKi3GSYBQUhm2
         LfP3GGhU4+n55hDf04q4YWmmzQEYqhl/JjmFDIcC2g2C5obi0f2g9Gv1/LGwV0b0QG/0
         QPcYrfooUXG+sk0hcWeqLzAqOS0t/a+KD2rsBGaTpi35ydSyCR+a3JWZOnvG/nZkhWSF
         6m5A==
X-Gm-Message-State: AOJu0YxVDUbrVqZ1VRcS9+1ddzrx+9uIm9AC7uh+DHFxyL1JsrhO4CBe
	Kh8NRYsnmQJxYWlsqevz0f4gz6IZA5wY+RjgT/a4KPBcQpO1FQs5HzggXRdiNLNhbpjEKRQUJNS
	S5hCGQLw=
X-Gm-Gg: AZuq6aK6RpfcgEQuTAtkWEpT6cHLwjawckYOxxVJ8qvmoOF/ug58inc+grnZnlC59Xs
	o5XsyxXiZTgwb9eZHW0WymAcBlKOi+MfwvtKizEpDFtqazclzVB4VdcW/B8QH/XzAG1ZadUmxiO
	CUjsmNjIt25yxsfZddLsJOFWyeM6pCFPj6Jw3q7b02okVO9PwTHZfrfcLFbYD5ru6y98t9KhChM
	bAkh8KIVhBrOd6SL4wEkzlUSr04934eHtNW1eZJ6wjjsXExUdv+Mr2Dx+SAZ3tPfXphXuwpGob/
	c8GYQpj1IJRyDqFojfQ3rxZ7sROcM2kMJdmBuRIjXvLWmoBAK/FhwZhlKofB1vbDUnpJ84RbId8
	FTXOeG40V2X55E/ydmjYgdwira3DAuQPe0Ac6yHLeHoPPY9qF91YpmT32NleQM908DlE4HOK3DU
	ADORlpd+Mc3jAxdhjy4eM9OhZQ6zPFiSRblxK2sa/6qKVZBT5jA4UGzHzMFbtFDkD7PV8MinN4/
	gl8lntb6f5gGvBZTMk/PxPKSLQ07dcnn7KsHKfmi+ZvX5zsIUBf+M1wojVeG88=
X-Received: by 2002:a05:620a:19a2:b0:8b1:2853:673f with SMTP id af79cd13be357-8c6f95857f8mr669581685a.15.1769471489632;
        Mon, 26 Jan 2026 15:51:29 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061293885a.15.2026.01.26.15.51.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:51:29 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 02/11] oeqa/selftest/rust: Exclude tier-check and fix openssl-sys build error
Date: Mon, 26 Jan 2026 18:51:06 -0500
Message-ID: <b64ec7dbc0cfc8e2c1b114f44d662ba432166efb.1769470900.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769470900.git.scott.murray@konsulko.com>
References: <cover.1769470900.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:51:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3091

From: Yash Shinde <Yash.Shinde@windriver.com>

- Exclude tier-check which fails due to file not found error.

Testing stage2 platform support check (x86_64-poky-linux-gnu)
Compiling tier-check v0.1.0
(/srv/pokybuild/yocto-worker/qemux86-64-tc/build/build-st-1400964/tmp/work/x86-64-v3-poky-linux/rust/1.91.1/sources/rustc-1.91.1-src/src/tools/tier-check)
thread 'main' (163263) panicked at src/tools/tier-check/src/main.rs:16:10:
rustc should run: Os { code: 2, kind: NotFound, message: "No such file or directory" }

Reported: https://github.com/rust-lang/rust/issues/149171

- Fix following error by providing openssl in the image:
error: failed to run custom build command for `openssl-sys v0.9.109`

Failed to find OpenSSL development headers.
You can try fixing this setting the `OPENSSL_DIR` environment variable
pointing to your OpenSSL installation or installing OpenSSL headers package
specific to your distribution.

- Exclude "tests/assembly-llvm/c-variadic-arm.rs" failing on arm32.

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b71cb92f368a9bd958518f82646c6f31e5f96039)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/oeqa/selftest/cases/rust_mixin.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/cases/rust_mixin.py
index b7213f9..50684ca 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -47,7 +47,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
         bitbake("{} -c test_compile".format(recipe))
         builddir = get_bb_var("RUSTSRC", "rust")
         # build core-image-minimal with required packages
-        default_installed_packages = ["libgcc", "libstdc++", "libatomic", "libgomp"]
+        default_installed_packages = ["libgcc", "libstdc++", "libatomic", "libgomp", "openssl"]
         features = []
         features.append('IMAGE_FEATURES += "ssh-server-dropbear"')
         features.append('CORE_IMAGE_EXTRA_INSTALL += "{0}"'.format(" ".join(default_installed_packages)))
@@ -75,9 +75,11 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
                             'src/tools/rustdoc-themes',
                             'src/tools/rust-installer',
                             'src/tools/test-float-parse',
+                            'src/tools/tier-check',
                             'src/tools/suggest-tests',
                             'src/tools/tidy',
                             'tests/assembly-llvm/asm/aarch64-outline-atomics.rs',
+                            'tests/assembly-llvm/c-variadic-arm.rs',
                             'tests/codegen-llvm/issues/issue-122805.rs',
                             'tests/codegen-llvm/thread-local.rs',
                             'tests/mir-opt/',
@@ -116,9 +118,11 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
             targetsys = get_bb_var("RUST_TARGET_SYS", "rust")
             rustlibpath = get_bb_var("WORKDIR", "rust")
             tmpdir = get_bb_var("TMPDIR", "rust")
+            staging_dir_native = get_bb_var("STAGING_DIR_NATIVE", "core-image-minimal")
 
             # Set path for target-poky-linux-gcc, RUST_TARGET_PATH and hosttools.
             cmd = "export TARGET_VENDOR=\"-poky\";"
+            cmd = cmd + " export OPENSSL_DIR=%s/usr;" %(staging_dir_native)
             cmd = cmd + " export PATH=%s/recipe-sysroot-native/usr/bin/python3-native:%s/recipe-sysroot-native/usr/bin:%s/recipe-sysroot-native/usr/bin/%s:%s/hosttools:$PATH;" % (rustlibpath, rustlibpath, rustlibpath, tcpath, tmpdir)
             cmd = cmd + " export RUST_TARGET_PATH=%s/rust-targets;" % rustlibpath
             # Strip debug symbols from test binaries to reduce size (300+ MB -> ~140 MB)
-- 
2.51.0


