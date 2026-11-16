Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6316.1794870787810514820
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:13:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WQH4rOUs;
 spf=pass (domain: konsulko.com, ip: 209.85.221.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so4123408e0c.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870787; x=1795475587; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GQ9PggARF0ssI5d42ePCyHxrATISOzXurKCoV3Q5w9Y=;
        b=WQH4rOUsNCcNJM+ntLVdH+iTr1K1RJqKgaQNh3dZBgH6nuQGObKqeBSZ5XrFug9q0Y
         SLLzWVkMqmylHz5viKvAqeozpcyOxBJXT7rolqm4qqwdploLhHI3VaZFj28bdHOiUduu
         XqTtG1QtygWOZuWiXekLCoP4VxkiBE9XPnZMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870787; x=1795475587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GQ9PggARF0ssI5d42ePCyHxrATISOzXurKCoV3Q5w9Y=;
        b=0ArdkoGcEWnjDkAT567INlxtS1x1RBy6UTDxtK7uLClZKHhu3nLAbLf0vpykrtscPd
         XauA8pEhrKnSEsAze5DamYakOKfHwvbg4VnqfsbH+jDAuholvZsn8wGHi7f4i8CLzaPv
         2b8bEY6FH5Lx2eYwdqkTHEjGXhOiCcBcddxsRAmLattNkLPsHipQlWfczMyu6/pUoocD
         GrvGQath2aoHvoHFtABI+pCiQjxi0P2NwvTQ/Hwen/2v1bSyGEolMBymF6HS8O54cjxX
         BGv+x1On9/AZ7gXdk6vt3Kgf6qikOzjE9Rwwxn7sptqRilCQdiMd/GiTzt65eTU5Vo2P
         FBgA==
X-Gm-Message-State: APuU4Z/c89F89twEMcij5FIhkF6xXiT00oZvQUPCYIiv9Nkjktw6JsTi
	qX4w6RMxbtloNa5MeD5tBnQZZG/YqMRoxZ7odg5fSeEHt4Tdi4BiL5RP209bnaIhBW0Z54QY3B/
	pnW5TJPs=
X-Gm-Gg: AYBFou1uDyKlCAsMy6DFJLY9TfOEunz+bDCh0T2r92pLfu9x4VzzTqZOk5bGAtW5tnZ
	AWRXfHE7daqLK+oxI8fmRFMe0bawUd7ynkd9Jfm3IAh6GPtrSTnz5YOXNGcNIvxjrE0yYtImyHU
	PAusgoWGhAPvRp/mlw4MgqyvZdr6VRcFABc1mDEFB4PSpzRWMEuAfeEZJkoIZZ0MY5ROp6qfX8W
	tsWYNUP0LBkYxSozY4TQ6BVqELSEOkwN7BGslaLZ0gM7modpB+O3FLWlQ0GsbCXJYSyW+tinx4K
	jkV99xpAGmdqZhLO7GYwjJ6ZP6XNOi6uOvB4ewUG/aa94QCG+VXv7WdAucJ6+tFuyeNna8rxb4T
	bha6TuTW9OVb+z6imfT0uVpH0TrjCozw6Q7afPmplbBKe2byMmK6TDHP5mQr++sHK1vAMeC9087
	DsuwaLUAm4rJ/hHis2SzftRPdZUyZ7KjE0VfrAgXN+V7tt2z5BHTDmbT0uJV6JVKndzpV5sOV1c
	s3UBTJG0KxYfv+jYem4XmXjUKNCBaRjmcxtik9R/AHwhmBULDILsFMz87mzr16u2cWtw8kkGRlq
	qRjitkt3W1wfqH5Tw4b6xEs/B3cVmHq35mlkaRnbKPLIez3daeDA8CgXUPYnNM6Vir+lRYRiHP5
	RFjbeTg2KY8qjTdrua10JtA31K0wdylQX9lNoFm+l2o3gia8tTXq1sduGvSKHUbyVPg==
X-Received: by 2002:a05:6122:181f:b0:5d0:1207:b693 with SMTP id 71dfb90a1353d-5ee34670bcemr4944036e0c.1.1794870786411;
        Mon, 16 Nov 2026 15:13:06 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.13.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:13:05 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 17/19] rust-common: Use 64-bit time_t libc layouts for riscv32 musl
Date: Mon, 16 Nov 2026 18:12:38 -0500
Message-ID: <69e21a6fa77a6d1c295b1ea94896d34f74eb86c5.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5456
Content-Type: text/plain; charset="utf-8"

From: Khem Raj <raj.khem@gmail.com>

musl on riscv32 only has a 64-bit time_t. The libc crate
before 0.2.190 still uses 32-bit time_t struct layouts for riscv32 musl
unless asked otherwise, so e.g. std's stat() passes a struct stat that
is about 24 bytes smaller than the 128 bytes musl writes. This corrupts
the stack, and any Rust program calling std::thread::available_parallelism()
or std::fs::metadata() crashes:

  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

This affects std, which uses the vendored libc 0.2.189 in Rust 1.99.0.
Upstream fixed it in libc 0.2.190 by always using the musl 1.2 layouts
on riscv32 [1].

Until then, opt into them for riscv32 musl targets with the
libc_unstable_musl_v1_2_3 cfg, which libc 0.2.189 reads. Earlier
versions are not opted in: 0.2.174 to 0.2.188 read the
RUST_LIBC_UNSTABLE_MUSL_V1_2_3 environment variable instead, but their
riscv32 time64 layouts lack the timespec padding (up to 0.2.182) or
fail to build with duplicate __pad1/__pad2 fields (0.2.183 to 0.2.188),
and older versions have no musl time64 support.

[1] https://github.com/rust-lang/libc/pull/5508

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit e4a1edaade3fdf413074e2006bc33097a450f827)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-common.bbclass | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/classes-recipe/rust-common.bbclass b/classes-recipe/rust-common.bbclass
index a4278af..87d4d43 100644
--- a/classes-recipe/rust-common.bbclass
+++ b/classes-recipe/rust-common.bbclass
@@ -18,6 +18,9 @@ RUST_DEBUG_REMAP = "--remap-path-prefix=${WORKDIR}=${TARGET_DBGSRC_DIR} \
                     --remap-path-prefix=${TMPDIR}/work-shared=${TARGET_DBGSRC_DIR} \
 "
 RUSTFLAGS += "${RUSTLIB} ${RUST_DEBUG_REMAP}"
+
+# Delete it when every crate moves to use libc > 0.2.190 crate
+RUSTFLAGS:append:riscv32:libc-musl = " --cfg libc_unstable_musl_v1_2_3"
 RUSTLIB_DEP ??= "libstd-rs"
 RUST_PANIC_STRATEGY ??= "unwind"
 # See https://bugzilla.yoctoproject.org/show_bug.cgi?id=15976
-- 
2.56.0

