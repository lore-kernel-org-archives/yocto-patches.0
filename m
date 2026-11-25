Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3162.1795645897666796168
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=rhDatsYS;
 spf=pass (domain: konsulko.com, ip: 209.85.160.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5365d26ccbdso70310681cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645896; x=1796250696; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jBX+8198t6UlX/G2it2doIZGleMFhtySIZuRM2vtKCU=;
        b=rhDatsYSsQCcSdSRodonr/wVHww7bup6wWrCYQNm0ns0E+pf7q0RA7BDBLqSqRCL9E
         NC+YvZHozzQR6uAq74TWAj5iDsJoZC/k92KL0RcomoHCrRu60s5LdBLcEU3ccdnpHvtx
         j8yrfeqBFIZUfQtzlIvuYZCe8q1gCfAqenZWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645896; x=1796250696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jBX+8198t6UlX/G2it2doIZGleMFhtySIZuRM2vtKCU=;
        b=RB8ePB0J/Oqti1PWHB0OnFWXcImgR0y/MZswzi3CQ7c4VOQrTTA6qK3x0OnNP3AaBH
         8QdcscYMDJdyrdzFXHc4HmHp/Z5kMn8nuhMFXN9EtMnx36WrDYm9uxYzhiSzKhInjzXu
         GnNoxlHm5ngUW2LSdwvm+pbhh4+EMp2ZtCqVq/vAhmdUE92wb42DdDQG7r1IgfLLtr9P
         hfX05mJUUe/dvafdq5wNSF5N9aZxl7tOXy35/F3BHlcOHN2M4pmjawS8+kVQbISiFo9y
         7YHWhTDArYt9lohfCcHZUudTLPulwoziln9rkX1eIeLGhYNRxyhGy99lylALojkhZGTL
         XZ1w==
X-Gm-Message-State: APuU4Z/B36iA5d9QiBSPMCGwd2d5iQF82p4QBWPg/EiKv2wQf4u1ihnL
	DmFfus6rWytJd5Z4VOWW1C17qfes4eC9+lDxeGOdPnKZE/rAB8QDcqeTaO+uA9NwufUJxXQhn55
	2sDLw
X-Gm-Gg: AZFdTZePmrn5VxiQmY4O+ihuNcT+LTMMKq8u/lONdFJxBfn4HAKESWR+Tf+KWBCpK5a
	heSGL60N4wyNO/CefUxWNyWes3lhC4BP+fXJElVhoJg9j3ebxBxSBFMV/mKPhQQ2JtfR/+zZZqg
	6fKyg/fTQFMkfIDtwW4VcwQPcxmvAh5Y+5EqMm3i7I2fnH25TnMRTmQhp7VjK/nbEc6PZrri4XY
	WBlYVnFYLKbovLTPr87/Hvqw8tzUFVNNINRoo4x3kxPBqU3LW5T2GRuO3R20g2gPGC4yKCU9aTH
	jHaHvFNdd1zq/yKeJUNcxS25KIo0YHLGY4lEiSoYQutOYBChVIziUpoRIpQpTMZYNpajZXtX+tT
	fWge4najvhYnUj2k+9cJlUadbpcQ6bcJo1uR31fnFAobi64AeoB8fSVrYEGWddSFE5Zdn2zGztk
	X+qSO+3IYzTkuSY6YsQA9P2EhDlBiKuuCWRYPHu1JDbPTFPhBHLyGdNPFlUzsv/d9YkN1LdeIMa
	8On5DTd2t3Z14jzdDXJCqtWgca1FgO0iPRpIhIKOyva+EWqVOj4SnAeYJXKJ6WYDLTvOeQMVhIV
	opoYEr829uzIj4ARAGo1m5r/G6Pkki4U0N2Ndhd1+xiQCpn9gP+0wlrsyDFciZ6ci4bmrwu/rFU
	uPblrzZnhZN9PHUOWMhUy8kBAaKcOQDsarS9nHDy9FMduQlJKRnW/CrmnXSxtUxZ3Kw==
X-Received: by 2002:a05:622a:5ce:b0:536:72b4:b84a with SMTP id d75a77b69052e-55d76a218afmr369697081cf.42.1795645896421;
        Wed, 25 Nov 2026 14:31:36 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:36 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 17/19] rust-common: Use 64-bit time_t libc layouts for riscv32 musl
Date: Wed, 25 Nov 2026 17:31:08 -0500
Message-ID: <78d28e65bc74da2b9ad9797fb32c60250fc6fbde.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5536
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
index a1d7dd2..efedbec 100644
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
 
-- 
2.56.1

