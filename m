Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62547D65548
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 18:12:24 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.web11.53410.1732644739213136700
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 Nov 2024 10:12:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kpTswX+U;
 spf=pass (domain: konsulko.com, ip: 209.85.128.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ee8e894deeso57255697b3.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 10:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1732644738; x=1733249538; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+dXhoBxLUdnkEvxpNwR814Pm9EUO2cKpEEjXmgGR7U=;
        b=kpTswX+UtpnRfkGV4dmyBc8ZLYYY/2pULzsFsPCtW/U2TlySkWFrbkQC2cpklpsnwg
         w10IQ4XKhKX6ZCoQ3wbdMzny4hatgE3ZL2VG27vU3GO0bO6ke4JuBlFsCxUZTUqFgN5Y
         PRoR9tf07gIPL1iggnx6SWpy8WLglT651KBTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644738; x=1733249538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+dXhoBxLUdnkEvxpNwR814Pm9EUO2cKpEEjXmgGR7U=;
        b=CXmH1Y7EXvfbbiu2hWk5Hh3/G7j9yVBzcInX3INoPwA1ruBuuHrF9OiB4djs5rpiW5
         8jJEtnleDuKI4x5Oz3LCoepk4gVcXItBsJxw8BQ2VEIxUHMzlzsUL7qdszNLnT1qm8k9
         es0yWpxsu0Q0T1eUdeLqRD/8jbdw4H9iqDfHgrfGOQCzAbBX0E0i9DKdbxIm+y/wsgRQ
         ujDMN08qgx7LpASkbYaDW42M4hRbiZprfXFSnlPVML4IsGYEJbaemT1QdUGhGWn3ZDnS
         bRnad2JfG0mslyIEiOg3Qld+5zZ7gD4e4n7AVpAXE1ey1p4OI82tMpqg38WEGf3zJnCt
         9S1w==
X-Gm-Message-State: AOJu0YzqqUoyKqG6YMTJboVklxD2FqkorEkOUZDOjRs4pL0Q7QzOOWh9
	+MzSItYiqcU5qV8yIN04Tc9YPImLS1VNE/iXdwTxrPJPKt7oOh5oxVZHaKObSJg5ZBCO7XGfM3s
	Z
X-Gm-Gg: ASbGncuUFX1JjrXlWUV5YqWyUlhcGTFMgbS/rsPulWG818mCVGgXX/bW5sDQEEQnv+s
	a1Um7brHlWN99Eb2Dp9WGtRqVYJXJgJvD6YWZL81TF8N8zSWlbO0bfGCwmTsyJvXmJSss2uDIAj
	83+h5I8KsnTswk8CONkphYrSCZvgkyM41uD27USGD8+yVB0zSPv4fKbyegkuZebXqcho+PeIccf
	9sVjXtRxc/Q3SQt2IBWoRwCQ/CrBggDupoxklnB0P7M6BiEhfHvN04xWDMIwZ94IzOvqvioyrJ6
	hKeFXbmAod5LBQ+/GqoDr/d//Q==
X-Google-Smtp-Source: AGHT+IFkntkTu91x+tRBuW5iteSrs0bubYWbU3CVY/Fb8jbtXnik8fzItRNS05g0uV/GBgdMPO2Z4g==
X-Received: by 2002:a05:690c:7083:b0:6ee:86da:3a49 with SMTP id 00721157ae682-6ef371f3e30mr2024097b3.8.1732644738190;
        Tue, 26 Nov 2024 10:12:18 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a83ea2sm58171276d6.22.2024.11.26.10.12.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 10:12:17 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 7/9] rust: Upgrade 1.80.0->1.80.1
Date: Tue, 26 Nov 2024 13:11:38 -0500
Message-ID: <20241126181152.407253-8-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126181152.407253-1-scott.murray@konsulko.com>
References: <20241126181152.407253-1-scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 18:12:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/840

From: Deepthi Hemraj <Deepthi.Hemraj@windriver.com>

https://blog.rust-lang.org/2024/08/08/Rust-1.80.1.html

Testing Summary for rust_1.80.1

Target       pass       skipped
x86_64       18254         434
x86          18084         604
ARM64        18111         577
ARM          18067         621
ppc          18035         653

Signed-off-by: Sunil Dora <SunilKumar.Dora@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 41da52480931c5ff90884c9d658075b8885abe8c)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/{cargo_1.80.0.bb => cargo_1.80.1.bb}      | 0
 .../rust/{libstd-rs_1.80.0.bb => libstd-rs_1.80.1.bb}           | 0
 ...t-cross-canadian_1.80.0.bb => rust-cross-canadian_1.80.1.bb} | 0
 .../rust/{rust-llvm_1.80.0.bb => rust-llvm_1.80.1.bb}           | 0
 recipes-devtools/rust/rust-source.inc                           | 2 +-
 recipes-devtools/rust/{rust_1.80.0.bb => rust_1.80.1.bb}        | 0
 6 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-devtools/rust/{cargo_1.80.0.bb => cargo_1.80.1.bb} (100%)
 rename recipes-devtools/rust/{libstd-rs_1.80.0.bb => libstd-rs_1.80.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.80.0.bb => rust-cross-canadian_1.80.1.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.80.0.bb => rust-llvm_1.80.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.80.0.bb => rust_1.80.1.bb} (100%)

diff --git a/recipes-devtools/rust/cargo_1.80.0.bb b/recipes-devtools/rust/cargo_1.80.1.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.80.0.bb
rename to recipes-devtools/rust/cargo_1.80.1.bb
diff --git a/recipes-devtools/rust/libstd-rs_1.80.0.bb b/recipes-devtools/rust/libstd-rs_1.80.1.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.80.0.bb
rename to recipes-devtools/rust/libstd-rs_1.80.1.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.80.0.bb b/recipes-devtools/rust/rust-cross-canadian_1.80.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.80.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.80.1.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.80.0.bb b/recipes-devtools/rust/rust-llvm_1.80.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.80.0.bb
rename to recipes-devtools/rust/rust-llvm_1.80.1.bb
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 0cd329f..c39c954 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -11,7 +11,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=${RUSTSRC} \
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "0b9ca1e2e45b8a5f0b58db140af0dc92f8311faeb0ad883c5b71a72c02dc6e80"
+SRC_URI[rust.sha256sum] = "6ab79b70dc57737a1de378f212fcf8852d67fe6cf272d122a15b3ea13be77947"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust_1.80.0.bb b/recipes-devtools/rust/rust_1.80.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.80.0.bb
rename to recipes-devtools/rust/rust_1.80.1.bb
-- 
2.47.0


