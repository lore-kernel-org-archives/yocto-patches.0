Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE935CFC28A
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 14:21:46 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12355.1763734900479965345
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Nov 2025 06:21:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BJGbvbf4;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2d6df99c5so329703585a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763734899; x=1764339699; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZSWx7XX9Lz8BNYwwPnsWa11WEO6WkI51tpN3nGM1aQ=;
        b=BJGbvbf4bbDJE3cEd7HhxWXFZk/BitNiLVS4trk91x2uONBWi7wTVCSLhM8hPnkQcX
         LBrESymvtqPYUGhmc68QOd4TBtQowvOWNpRrgUcluDBcamX0Oep0bSFyRUX4oR4V/K2q
         NOZoWGUoX/xWozp++zjI8oBmHmaU+9CdBThGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734899; x=1764339699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jZSWx7XX9Lz8BNYwwPnsWa11WEO6WkI51tpN3nGM1aQ=;
        b=LxNtKEkYiXrK9VGll+Qjt5xcEtLUoQ01mU5GsqmY4UOmT7M3+u97zHUw9iTSwaRV4i
         YbE0qjwkwAFBZj7/AyoC3SeLCJjGm6fRz0n2c50Z3Hfl+ZISAOA58BXG0uMKfht2uD29
         t23keTkRA+APlcq8owhdrQqY3Zs8lszBS6QKBP2pxHrXi2p5atpUWPZVjWbosXqILauF
         8PbouiWX+9QLGyzAZT+AvKuoG1og8OQHx7j3HdyEHK86k1yRBFRjF8ZsRUG5ADMslV3r
         Mbyn4TH7kuHaEOn7EqYxJPgNkXRbLDdXVj3b8RqUYhhTG1N8UR2OdpYI9m91fb5locZE
         2JoQ==
X-Gm-Message-State: AOJu0YwSHYwuJVRu95v7+0AU+e3fLuvmiZEOa/j5Gg7w7QtXaADQcgl7
	K7mFtl1NE9VzqYTV6jm8I7IoayLT54dED9+KGPPG19PHhug6QUtInATWjBgRWfcnU7+oT8wPZcc
	sjyQM
X-Gm-Gg: ASbGnct5gdeHXl/IWI/RguRCJolO1zKWrLAo8ikV5wXtATsky/HxUIRLs023ScXfk/p
	wLDoZC4oRfofdEhPjeNKazeUwt9UE3WQzgvJ/HusTm5samh+qoNeh7neVa2k+gD3C6u7T5u5lTS
	0c568UnF00yKv9i+JD2D9zfTBm2Vppooz8DG0t0eYtK3Hh0rbU1bKe6W5wVDKPNp14L3y30wWRf
	1Ffu0lHZEJrQCIovHL1cjgdVrRVECdagvyFOzbZ2lEjjKq5TKk8YANYaroXCk7D2fUESHbW1Scp
	UwhXwdXCjAATVkZXsX0RhRMWzBpp1HpsleqMgEW3q4Tg/x405eAXc0tqlwOBB29+mp/lFj2MWqq
	zfpZgdwUsdbRlk4fdyclzg+X1QAXrzuslY3hARdwpqIbaZcY0x+3T7JWU5aJaSJyna7xMaWMm3j
	ptiWsfNrF077fzPrb6tAne5GohNBz/FUai0d9P7kXoG67/JkDz1LENpo55TZ9G1Ug=
X-Google-Smtp-Source: AGHT+IE7wevm313jH+lwJiADp9HlOpr7zPVsaVpugEAH9tMyrfwcyaVRlhCZM6aSdz1yjj9b+RCSJw==
X-Received: by 2002:a05:620a:4151:b0:8b2:e669:9888 with SMTP id af79cd13be357-8b32ab885e6mr807782985a.3.1763734898940;
        Fri, 21 Nov 2025 06:21:38 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm374815785a.37.2025.11.21.06.21.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:21:38 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 4/6] openscap: fixes
Date: Fri, 21 Nov 2025 09:21:18 -0500
Message-ID: <3b0ee6a7b6dc0df85b237ada0a292905f13553c7.1763734538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763734538.git.scott.murray@konsulko.com>
References: <cover.1763734538.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 14:21:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2648

From: Louis Rannou <louis.rannou@non.se.com>

Fixes:
  - typo in the RDEPENDS class-target override ('-' instead of ':')
  - typo SUMARRY -> SUMMARY

Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-compliance/openscap/openscap_1.4.2.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-compliance/openscap/openscap_1.4.2.bb b/recipes-compliance/openscap/openscap_1.4.2.bb
index f1eb647..da1dbbb 100644
--- a/recipes-compliance/openscap/openscap_1.4.2.bb
+++ b/recipes-compliance/openscap/openscap_1.4.2.bb
@@ -1,7 +1,7 @@
 # Copyright (C) 2017  - 2023 Armin Kuster  <akuster808@gmail.com>
 # Released under the MIT license (see COPYING.MIT for the terms)
 
-SUMARRY = "NIST Certified SCAP 1.2 toolkit"
+SUMMARY = "NIST Certified SCAP 1.2 toolkit"
 HOME_URL = "https://www.open-scap.org/tools/openscap-base/"
 LIC_FILES_CHKSUM = "file://COPYING;md5=fbc093901857fcd118f065f900982c24"
 LICENSE = "LGPL-2.1-only"
@@ -66,5 +66,5 @@ FILES:${PN} += "${PYTHON_SITEPACKAGES_DIR}"
 
 
 RDEPENDS:${PN} = "libxml2 python3-core libgcc bash"
-RDEPENDS:${PN}-class-target = "libxml2 python3-core libgcc bash os-release"
+RDEPENDS:${PN}:class-target = "libxml2 python3-core libgcc bash os-release"
 BBCLASSEXTEND = "native"
-- 
2.51.0


