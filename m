Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF8ACAC595
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:50:30 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web11.3151.1757443823462314620
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:50:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sxOSrIOk;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b3415bfb26so41000121cf.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443822; x=1758048622; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8I9bs/3425RpqrBVhO+YR9FloQxdRcgSz9VVO0wevQ=;
        b=sxOSrIOkwNlb5gg3pFVllilPBWE5YW1UZcaws0doEKhNEvdKAjxO9Zq1C5L/+vxLR3
         IqZkYKTJ/kKKKyVOGT8EyZjVeXLIR4MvCZnZ3xQa86KWN+cvsmWkAop0V5L58jKn2+1q
         it9aRiHvBBuxxQIu6FRDKvVqkkQFTHp4G60ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443822; x=1758048622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8I9bs/3425RpqrBVhO+YR9FloQxdRcgSz9VVO0wevQ=;
        b=s2Muw15mY+dO92RLYYXlH7Lr4q0scJGZ9nnqd6pt1wFtp9Nc+w26mCklzYZURF9TRI
         InL5LYBSiMXz0t58Zm+3PEdVCjV3onSyhYJXbZLEIMoCBuIGo8WNn7dOSV4ZrU0p5hwu
         ThnQdPMZy/nLsOzofBZjRAqABUJSCs8U6StfY6vYs6PixQ9Q5kb/ENiD/xbpMbJrAUSZ
         CUcgZzChm8z0DHcXYYEBNoDeLFR7AVyjmsB6xwP2qX584c30lu6KCEBV6fuU20S/i/ur
         FFu6detyHCjDPXdL0TXRWqh6BWEj+n6T/6tUNvAyQC1v4WSXKpOBOHO37vPSQl7DT6tA
         UabQ==
X-Gm-Message-State: AOJu0YyfPc1mjefW85FvvZJ937nTP0xg5jKWczg6LNi2L4YNSK1oaXky
	DSUUAxEzWGBb4/RSbUhwfRnVfn+J64mrCwVWBpeiydZ5feymD18ZYqJzaXpruLQ3fb0HUEiqAGh
	FKw6l
X-Gm-Gg: ASbGncvhA/niLPkLM0LUQgSnf6wzLVB3DQRG9uZ74hMVOZm8cVpr0sj1rGk+UNHOnUC
	ud2GT6Nk9r4ZrvmFXxFvrCVfolVbB4eSGng2oZxo5BLn3CXceXIlCCIPTSGcPBRrVIqgbjnRkrL
	EM4cRhQ8M/G33vK/KaFnRAY28XSC6R3iwRK/3/Yp3myUoossyLu/hz30GKgoO0BqrcDRhoGtnQj
	2J+ga5eZHm1x2MQsS+Cwv3me9IpahWd2wm5ZxcMqeMDtkejq4J2P+EWsB5aUF4mIHlSRtTxayCS
	BrA3pQA/K0s6x8a6uunSkrc/tzV3LnZPgcB19725yVZvLvZJWo2pJmoZ+xajoubxl8eCSnEzF7J
	04CVELOS4WkmWqDcguiNuKUWNNWKRv/h52QbySkIyY9OKHo8WBjoxYCc6eBVRa4Gr8HoCE8hRLS
	SzoB7o0hVh
X-Google-Smtp-Source: AGHT+IGpjavX6NMbPnr85WYl/l4piCtT8IwYz7+mGqqPdlpD5hKX/K11qIevos1XP+2UBLN8s2Uifw==
X-Received: by 2002:a05:622a:60d:b0:4b5:f815:fe4 with SMTP id d75a77b69052e-4b5f8361075mr118903891cf.10.1757443822110;
        Tue, 09 Sep 2025 11:50:22 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ec7d3c8sm161168685a.46.2025.09.09.11.50.21
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:50:21 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 3/9] recipes: cleanup CVE_STATUS which are resolved now
Date: Tue,  9 Sep 2025 14:49:51 -0400
Message-ID: <8ed4bf1919453f20d33c492897f93164dc69f4a8.1757443674.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757443674.git.scott.murray@konsulko.com>
References: <cover.1757443674.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:50:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2169

From: Peter Marko <peter.marko@siemens.com>

The don't show up in CVE metrics anymore since they were either fixed
upstream or recipe version was upgraded meanwhile.

* bind CVE-2019-6470: cpe got corrected in nvd db
* libxml2 CVE-2023-45322: version is now higher than NVD cpe
* zlib CVE-2023-45853: version is now higher than NVD cpe
* gcc CVE-2021-37322: version is now higher than NVD cpe
* python3
  * CVE-2007-4559: version is now higher than NVD cpe
  * CVE-2019-18348: version is now higher than NVD cpe
  * CVE-2020-15523: version is now higher than NVD cpe
  * CVE-2022-26488: version is now higher than NVD cpe
  * CVE-2015-20107: version is now higher than NVD cpe
  * CVE-2023-36632: version is now higher than NVD cpe
* rust
  * CVE-2024-24576: NVD has no cpe, but we have newer version as fix
  * CVE-2024-43402: version is now higher than NVD cpe
* cups CVE-2021-25317: version is now higher than NVD cpe
* ghostscript CVE-2023-38559: version is now higher than NVD cpe
* libtirpc CVE-2021-46828: version is now higher than NVD cpe
* unzip CVE-2008-0888: version is now higher than NVD cpe
* ffmpeg CVE-2023-39018: cpe got corrected in nvd db
* libxslt CVE-2022-29824: version is now higher than NVD cpe
* libyaml
  * CVE-2024-35325: CVE is now rejected in NVD DB
  * CVE-2024-35326: CVE is now rejected in NVD DB
  * CVE-2024-35328: CVE is now rejected in NVD DB

Also add comment for iputils regarding reports for FKIE/NVD2.

Also remove some trailing spaces in python recipe.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 73ee9789183aa95072af2b51ac9e08203f4e33f9)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-source.inc | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 73aa14b..8ab2c81 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -19,6 +19,3 @@ RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
 UPSTREAM_CHECK_URI = "https://forge.rust-lang.org/infra/other-installation-methods.html"
 UPSTREAM_CHECK_REGEX = "rustc-(?P<pver>\d+(\.\d+)+)-src"
-
-CVE_STATUS[CVE-2024-24576] = "not-applicable-platform: Issue only applies on Windows"
-CVE_STATUS[CVE-2024-43402] = "not-applicable-platform: Issue only applies on Windows"
-- 
2.50.1


