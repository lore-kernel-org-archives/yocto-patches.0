Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A618CF65E8
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:55:11 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35785.1769471703009661890
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:55:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kA8c38JY;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c6a0702b86so508516585a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471702; x=1770076502; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmofS/kF1wA/X2YOsua2T/5dd4txnyqYvN3uwgVwjLg=;
        b=kA8c38JYtIfl7dS2Z4NiRNx63y6y3eNXqZzCHCHrn4MT0ahjz2eaOGIIZNWZXUe46y
         9NjB3/RcLVVztU5I4lnYSAIP3TO6oNEhgPPe5cc4r8BakLEGyOFGS2PNlkw9WJFYGxYw
         tIvUbu6cO5U1D0Fq6Qm59aC0LVlteQ+pL+nns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471702; x=1770076502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QmofS/kF1wA/X2YOsua2T/5dd4txnyqYvN3uwgVwjLg=;
        b=EDPmdd5/LRe/Q0MXR6iFkJNkyXjiCG2FTComFzm2flRGv+yhCoaX25h0Y2IyOs5jrB
         1p3zIt7lsI0QKJjUS+3Tlv78ojVvEePNNjZqYVChF2PEC1MHOjGJqSVQePryVzBKu/Vg
         Oa9lLLBsutS4VAXgd4gEmu/3+S0AvJkKEddwYNaJSmoM9Eo6LSK/ZpG8l2awforYG2m8
         k+CuoiBDY82xqaaki1RhDCSnvpINpdh/UqKO1rEI+Hqc6r0G7tR0v3TEQDRxXexiHAMT
         vESzef64iIXYTsvqf6PTmUbV+ZNKnbPpF4/Q6revdeE802ro/+vocl5RBWOOyE2SiCAB
         0SzA==
X-Gm-Message-State: AOJu0Yx/02s1BGz6+Eweqh4CMRpUI0hdhswJNePd+yZLMkN/rPdluQn1
	rcCOKaRcfT1qs4DFVoDypYbSQV67bonKwq2RPqpaHTZWe9YI8XSv9z/iCoqdef399Gc8tfTh4Vi
	+YX+ShzY=
X-Gm-Gg: AZuq6aLZtkSxPzpDbZpvaskyGbM0ItDY4S0zcX69RiURhLt+t4HbE6YSqP6Jg+yXoDw
	e3P8vup5+hZGwobazkOtP5HDESlekxS96MUlERkayXmMSTKd2ydFthU0YPqJA43hJUHVKuO0Vdu
	ESwNhsVgIFNbmVxgOW/8RxHSdMWnKiSIlnr9vb5pzB6zi6XBB838ql/AjvgHYc4ywyvERsjcBp4
	akR5Ykqz/N4JY+0au+/wprVlcK1B2eyxV/xEcrOCOEEvgWGWvObTQfsabO5/PkdgjRx3V2KSmYz
	NHDkiHp8U9kV6rvPAuGXwh3r+V0ZVZ6/WFYv/Cnwnqf0pq949BZ785cijDFKbTdIsoHkUkrIvEm
	jRyCGc9yA61FHO5XThYa95biKw8MyRq8cYqxNPz4wI0iGZQp9TsBwf5U6fag2G88MfnE6Qqpcrs
	6XAGIQLfNa+qicT1cGUsGw4WTqMgZ+Lczmeo8PMzZdnytRYyrH1lGAHu2SI6SYOReFgvy3/aRxI
	i47dtnwZ5xsimFdILAEEG9sOUNuJvODVyjpc3TcPJDpk6VkDzTd
X-Received: by 2002:a05:620a:17a5:b0:8b2:f9ac:a88b with SMTP id af79cd13be357-8c6f95c6de3mr721038785a.21.1769471701688;
        Mon, 26 Jan 2026 15:55:01 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061740885a.15.2026.01.26.15.55.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:55:01 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 02/10] oeqa/selftest/rust: Exclude tier-check and fix openssl-sys build error
Date: Mon, 26 Jan 2026 18:54:48 -0500
Message-ID: <a032ef9a71847a33e8e930c7df49794b09dd809f.1769471543.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769471543.git.scott.murray@konsulko.com>
References: <cover.1769471543.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:55:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3103

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


