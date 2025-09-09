Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09067CAC58E
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:44:20 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.web10.3232.1757443457269431626
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:44:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dsafqAko;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-80b7a6b2b47so567242285a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443456; x=1758048256; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuZ5ALOGeDJnnfc3Hyjjib2R/EQA/RmBjlpn8eYIXtY=;
        b=dsafqAkopvUDgYVie8YQ/oUz9bS1Bfa+/qW8bQb5AdlZkSRBVQWS5EQWanDHVk70D1
         Lf7uZElK1rNzecjtqYAqKxfm8I6Ajb4sSwb8n3eP9n7ci6XEI54DE2+/vStpGIljioAg
         zoAXAqAzBWRxjDOMjzWR/TzDKGvAihpN4cpVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443456; x=1758048256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuZ5ALOGeDJnnfc3Hyjjib2R/EQA/RmBjlpn8eYIXtY=;
        b=am33YoSdH7tW/qMZ2pkYxHHYRJlI36ZzekKPs8vC/Lyhvljs4IhDU4s+xLX0vz7hQS
         7HbjhBuJmCUupzJGMPQkzBZU0TjNn/5d07R8CD3Ab7MqWKlpLzNzWxjfj1e/J4cU/yp/
         NJpSOuatEwDyg+Mo41HXGsTZ8jQVWP4FGZ5bzrnRxDaTSv3uN1BUSlIVKq0G8ZjQXp5g
         z6oLrk40V9PEbr2+V1JCTmceZY2HeW/T4T7Wxk8lYPLPG79T6qHPYN9qI4+RkDBS+JbH
         pBfPXiXXsTfCyYovM9IkbUPtCzg7H8beKjnUoULMaO9NzPFfHOZQid/iom3f5YIrmX1Y
         pHCg==
X-Gm-Message-State: AOJu0YxE93M3EBpdU+9Mcc2MyG91qJ+qkJZp09i89ce1K7bc4HP4mf9J
	z8mMECCCa+2cfyOlVKgNjUqt4ComLtrKc3mhEvYw6Gb+/zHIQiO4j09A4IxzxOBirzVtgmnrXHC
	WXMlU
X-Gm-Gg: ASbGncuHPcKW0zGVA+W3RPhFKrseiYyjrwhrZvbhyiz660sxHQbzQNdxsl61uzOIA8Y
	Bjq9nuBOn+wBARz0Lqt9V1s3fAfNZcLnWzWF56CDrcVg2lh7JZU9IFImpYkwHCJyxmfhICb3iMY
	3M+FBFabEd8FYhz1DM/kW6xkLn5DFgX711lPvUVmzgKOOaHaH+xFr/l/Bp6SeHNxAu2YDR/d/7h
	oAxaZ9GHcBKfjufuRdl24v25zSlMdSimR9FfKWbiC/LgzR7IDwRMcCF7T4q3HNWPDFDFktNVy9J
	lqAbnyMJmp6nFOVo9SxJ3Jte6d+R93+kxwFHyUpjfA9SA117gtA7bbcw7PoaAKYtwq7iMQ/Gaqw
	7sZAlkb+Ka7LiQ01MgtL8h1KrTzyx4Lr/MiqWHMwY5icNyYmLPjcqUUGl7Wfve1v2PLaRWXGzDA
	==
X-Google-Smtp-Source: AGHT+IEOqNjEDu27q1olYb4rOVTxCUAxG8ZEWM12JSbGTDYbC/LW7q8bXWbc3vzU24ojVkB130UpoQ==
X-Received: by 2002:a05:620a:44c1:b0:816:2514:7ea9 with SMTP id af79cd13be357-81625148209mr1077569185a.21.1757443455754;
        Tue, 09 Sep 2025 11:44:15 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5f715c0bsm160164985a.61.2025.09.09.11.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:44:15 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Soumya Sambu <Soumya.Sambu@windriver.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 2/9] recipes: cleanup CVE_STATUS which are resolved now
Date: Tue,  9 Sep 2025 14:43:55 -0400
Message-ID: <032adacc2c8feb40abfdbde8ec32816ba3077abb.1757441699.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757441699.git.scott.murray@konsulko.com>
References: <cover.1757441699.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:44:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2159

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
 recipes-devtools/rust/rust-source.inc | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 99a37eb..8ab2c81 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -19,9 +19,3 @@ RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
 UPSTREAM_CHECK_URI = "https://forge.rust-lang.org/infra/other-installation-methods.html"
 UPSTREAM_CHECK_REGEX = "rustc-(?P<pver>\d+(\.\d+)+)-src"
-
-CVE_STATUS[CVE-2024-24576] = "not-applicable-platform: Issue only applies on Windows"
-CVE_STATUS[CVE-2024-43402] = "not-applicable-platform: Issue only applies on Windows"
-
-# These CVEs are specific to Microsoft Windows
-CVE_CHECK_IGNORE += "CVE-2024-24576 CVE-2024-43402"
-- 
2.50.1


