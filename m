Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195DAC55175
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:24 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4583.1785497603580048141
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=frOPc0eo;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e50979c71so77071085a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497602; x=1786102402; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RBa3eK5bF3nzm1nFmEPxOBdCbiYkfeXe/5zBjXBgg7g=;
        b=frOPc0eo8PwuoXQhZHpz1WPJYjt02sWSoR4L9rKdBleOt+J48ip6est93KEKQcoCq/
         PNWuB9wUryxZ6GRngS7BKsIUgBW1K9yXoGqUdLnZzg8ZLa4jEJAYB5rRSWBaeSqpzrXA
         x95+C42Ztjj/jFyJ6I+rHMIv6Q4y0CAme6z+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497602; x=1786102402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RBa3eK5bF3nzm1nFmEPxOBdCbiYkfeXe/5zBjXBgg7g=;
        b=GqmyYImh0eRQ+IEftIdYIvzhujpVaX4fTPBCnITbK+ikGuitpsNLpFeZ63OXx4qgmo
         wn6dr3iU8+uhe5ItCk1qLkbutuH5ED9YscIj+MM8C9Akiw+epJ1iy8m5Vf0/HYpSTliV
         sGwA6i8Pg9XjL9kzR/JiUFLkJVx688xsm8wpHoK/1kx035WCItMdGo4p+maA6HEKVIji
         nnN44VX1d59bzpE11TP3nUF153RWzEfjibzUF9Q5kz+4np0Pb/Rik0NpmV1eLg0qWAfE
         NCxdnW0wD0ITvxVCHYzwt/ePNyGJFMlPF0ePCdbE29pvl6/nJTtPU336ey6p4/ECAiR3
         ocDQ==
X-Gm-Message-State: AOJu0Yxg6KqOrWWcf5BsYgsnM7zDK+qEx6eYgwzYCgWGAVLJl0v9WJkL
	SlSPng/81ULs8Q1QuIrh1AyhBtaTNjq1tIMudZdkpUxhCKz9zoELpwiFPDY4gcVSE7bop4wTdNR
	Z+FBd
X-Gm-Gg: AR+sD13O1PfCmlTkJ1BRcZFWJR5lEgU0ir3rzFxIpJJq5Z+uItRZe05Cw2d9dCiT9uI
	hjWfcg3csVXWMR/VvAJc54ZX2XeewfAvIRv2ktX7tbOVzJs+DkTRgsoOAmkID0fkHqW5K2Nh16R
	3yVI4DaaU4+NRUYMr8JNAWTJZ62Te1up+/Zr85PCT3otdgBRhtVWt0e8/gGCxq1EJ7O/kYSPKJV
	2LMjGIehAQIr1J0szve1FAxNwDA7jLNjhF3wEGUJMHVhRNaClA9+3vGx3NNo0QHCX129Qb7KUAR
	vOL7M7s5h0ACG1J2nUic+3JHiG/oCYN9hemZFxum9y5e0XBbUqlx2fpunDpTrC4pF1yGYxdxAkN
	CxGcgts/zhL8LXOYgDGSVcys0NqcYstMMYcDyEVNdWShQ6XAuZRpjnwCDgaBDRjS2Ki0J+vxP2H
	+zgHxdpOce5eJowsF8UDwXs3yCnTeicz9kLcf6ShLZf4uBQszUXK1NV5ortZaqIO/9o2OSgjVYE
	oL/nCH0PvfscGvxLiS3qpPTntZxIxlW/BU+KQHOlACR8wVJ7457ydPFZ8DP3Yf7o7un8CqWAgkK
	s9w1eBzDsby7kZbAx2AoLaS3aQ==
X-Received: by 2002:a05:620a:90c3:10b0:930:f271:6784 with SMTP id af79cd13be357-934967c7019mr176220285a.38.1785497602356;
        Fri, 31 Jul 2026 04:33:22 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.21
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:22 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 06/35] cargo-c: Move recipe out of rust directory
Date: Fri, 31 Jul 2026 07:32:36 -0400
Message-ID: <51e098a4d1e2cc3d0755729fbaad6341ff314802.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4582

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

cargo-c is an external Cargo extension used to build Rust libraries
with a C-compatible ABI and generate C headers and pkg-config files.
Since it is not part of the standard Rust toolchain, move it from the
rust directory to cargo-c under recipes-devtools for better organization
and maintainability.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit a91d977917fba29f0c994d896dfec898e1b46d77)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/{rust => cargo-c}/cargo-c-crates.inc             | 0
 .../0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch   | 0
 .../{rust => cargo-c}/cargo-c_0.10.20+cargo-0.94.0.bb             | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 rename recipes-devtools/{rust => cargo-c}/cargo-c-crates.inc (100%)
 rename recipes-devtools/{rust => cargo-c}/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch (100%)
 rename recipes-devtools/{rust => cargo-c}/cargo-c_0.10.20+cargo-0.94.0.bb (100%)

diff --git a/recipes-devtools/rust/cargo-c-crates.inc b/recipes-devtools/cargo-c/cargo-c-crates.inc
similarity index 100%
rename from recipes-devtools/rust/cargo-c-crates.inc
rename to recipes-devtools/cargo-c/cargo-c-crates.inc
diff --git a/recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch b/recipes-devtools/cargo-c/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch
similarity index 100%
rename from recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch
rename to recipes-devtools/cargo-c/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch
diff --git a/recipes-devtools/rust/cargo-c_0.10.20+cargo-0.94.0.bb b/recipes-devtools/cargo-c/cargo-c_0.10.20+cargo-0.94.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo-c_0.10.20+cargo-0.94.0.bb
rename to recipes-devtools/cargo-c/cargo-c_0.10.20+cargo-0.94.0.bb
-- 
2.55.0


