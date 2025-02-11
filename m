Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E63CC021A1
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 19:17:47 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web11.1802.1739301465759798758
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 11:17:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=j5U5aXzH;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7be3d681e74so537286785a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 11:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739301464; x=1739906264; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbJw+9+GiMYkyShAmY1Kxu24/NhY6sQ3vYH+IyL9UXw=;
        b=j5U5aXzHlNC7tcy6opYUOLqIYbvH3JzUINwph3F1MRajlUadZavhEpeWZbfSZ66NqQ
         iyaY2HPU1M3Muqg5RmmrTM3zrXCQnaSxMNoOYiS5fwDY9kOHo5f7hASflYxVs1FEbOps
         WsvXdsJWmIrN2tP+c2y91goAnGJH6OdDxwcuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301464; x=1739906264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbJw+9+GiMYkyShAmY1Kxu24/NhY6sQ3vYH+IyL9UXw=;
        b=mw9T6pK0m8LAXuMf1FNUNAspZ92X2hSNwRqPpB1RNwvumqxlPnYgxa9N/GhzBH9lxM
         InSxQ4iqHTSg9Slwk/L+OXIVFSNWntnxJV0m7zLS0e58ipt8SiAhPzhM1OImfhi808e3
         EXzf42EwhCxt1Kla4fI7rjcurBbSZJ6/trABxEgRMP4v+MhuSWEAJBf03Z503bXdc3RK
         tpS3NWOO/jdKR1R+fCK1lTSxZvwP7Mfy4BKDflAGAX8YfRWBhzagV70PEHLzm/+g86sq
         LZQ4zKLpSdNSK9Nq7tH1xjplCrtiPJIcvG0OuT8/R70iKyRtOPZHhyrN57YTc06X9r2G
         nzWg==
X-Gm-Message-State: AOJu0Yw+8rTu+tdBmYeYatP8uS6Pk4g+yrw7wJ4Ci7089i9R4FWOHyyC
	NkqJxqU7dETkifUsV0vx22pm5jKmhJAfkvpkSuGXV7oTX4JGKQ/ENdGEXzAiaFMDADsmwp6h/s5
	x
X-Gm-Gg: ASbGncsDJURAcAijgVC9F+KMVRDq4h9pRh+Urmnqx6/qe6ZGFGceNSAFcA/O9WHdC7X
	tIrd3iSDX4n7fmqiMX4GcvkMgPpzOEkGL3JUn/SQsjlwU3NQdnnEYmZV9rn/BxgDfFcxk5+UJlg
	yRvt381CWljDo1JNnM6noWebLrrzTTRtsSDPfyONE6eHdvUsLqhQQQRdt2OEAcasDqkqL0NdOs8
	7WHlNoLKOmikhDEzCVcrzx5OlpBUWUVNXzD7IN37iMrj2y5T9zKh5K5y0Jw3sWBtgFYh4Wzg1IU
	3Tat/7b5cw8QlSa67w/yNM4gApGwj3kB4/K/1iMngCVfFsp+Ulrf4LEU0s/OsXL6w7E=
X-Google-Smtp-Source: AGHT+IFe6/R6XLzPK0R52UJMR9FZGiUEgJ+XRdBFSF6bdx+AgDqBlneTxIB/d4ZOmFu7Oc+CstPHJQ==
X-Received: by 2002:a05:620a:1983:b0:7b6:eb2b:b49e with SMTP id af79cd13be357-7c0706f44b9mr22707685a.6.1739301464503;
        Tue, 11 Feb 2025 11:17:44 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c05e374867sm318561085a.111.2025.02.11.11.17.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:17:44 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 04/10] cargo-c: convert to target recipe
Date: Tue, 11 Feb 2025 14:17:17 -0500
Message-ID: <65ba76e1d4b2892456ffb01546cacd973ecb0a74.1739300779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739300779.git.scott.murray@konsulko.com>
References: <cover.1739300779.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 19:17:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1069

From: Alexander Kanavin <alex@linutronix.de>

This was prompted by sstatetests.SStateHashSameSigs2.test_sstate_allarch_samesigs
where adwaita-icon-theme would fail due to new librsvg introducing
cargo-c-native into dependency path.

Rather than look into why is that, I simply converted the recipe
into the standard 'target + BBCLASSEXTEND' approach.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ...e_0.10.5+cargo-0.83.0.bb => cargo-c_0.10.5+cargo-0.83.0.bb} | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
 rename recipes-devtools/rust/{cargo-c-native_0.10.5+cargo-0.83.0.bb => cargo-c_0.10.5+cargo-0.83.0.bb} (85%)

diff --git a/recipes-devtools/rust/cargo-c-native_0.10.5+cargo-0.83.0.bb b/recipes-devtools/rust/cargo-c_0.10.5+cargo-0.83.0.bb
similarity index 85%
rename from recipes-devtools/rust/cargo-c-native_0.10.5+cargo-0.83.0.bb
rename to recipes-devtools/rust/cargo-c_0.10.5+cargo-0.83.0.bb
index 7c768a1..ff5cc1f 100644
--- a/recipes-devtools/rust/cargo-c-native_0.10.5+cargo-0.83.0.bb
+++ b/recipes-devtools/rust/cargo-c_0.10.5+cargo-0.83.0.bb
@@ -8,9 +8,10 @@ LIC_FILES_CHKSUM = " \
 SRC_URI = "crate://crates.io/cargo-c/${PV}"
 SRC_URI[cargo-c.sha256sum] = "5bfa9ba93806384d940e71dafbc185316e0a6a47561b33b7105fcf67f99df70a"
 
-inherit cargo cargo-update-recipe-crates pkgconfig native
+inherit cargo cargo-update-recipe-crates pkgconfig
 
 DEPENDS = "openssl curl"
 
 require ${BPN}-crates.inc
 
+BBCLASSEXTEND = "native"
-- 
2.48.1


