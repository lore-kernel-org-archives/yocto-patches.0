Return-Path: <alba@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C031D3569D
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 14:02:53 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13576.1769608966303241165
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Jan 2026 06:02:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=s3IdbgIj;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.208.44, mailfrom: alba@thehoodiefirm.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso11163965a12.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 06:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1769608964; x=1770213764; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8KI7ZnEXAV3RIphTroGT8ONysuJq9YNK7lXmfbXtPk=;
        b=s3IdbgIjy87UwHa7nfRyt2mUX7gQ6pAGcdC5gJvh8aUPdtaVXNNO7H4DVFczaG48Uz
         VWZeQpSRDggRhz/3MGsa69K3u/Vx846wi7x9ILi+cjlTWFP6i4Fdt6Paqg3xakmWF2ns
         ATsy8Gn0PQAHsjEyuuVfmzuWKdXET+Tq3tm6lKEZWRcJlXP4wDTqsz4OwXOKZYMc0EaT
         cKwedCVOMHgtlfzFRBL4j+AJjrkr2itM1AoQQ9L8+Za+GCJMTxNBJMfxTI44bjrqh5X5
         O0KeoZyb7T4a7RYnEXNGQwD2hoJEyH5jZA/wHEZo3irplZemk3fw5pRNGlYDXwBETjjR
         /LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769608964; x=1770213764;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8KI7ZnEXAV3RIphTroGT8ONysuJq9YNK7lXmfbXtPk=;
        b=lutX+6CF+HUZaA4EjeTDVxU7ie4Uimkj0H4g6dg8Ocy4pnPr/RZHOG4Z22WionmGCz
         U+TryI+QHwOWRvKa1+dFTN5pySdpQo51a5Kumixe9Vl+25Z7U28pNR84Cq8/WhnI4oqJ
         toS/MBHTACa6a7cclNHCtTreMDTJWk9igQNiSndaxYQTbwRQsbxUOlMnRLFpaUto0Ao+
         4UDO1An545JT7OK6DbvTKoVJghDHo7xUQv7Glv+4lZbIq5xGbrV1VxWxqxqbgwu/e++p
         eRafN58sLxxL3UwEHPmfmFol2p6EeVA+hJDvULCirmIXeKIqeTVnXyI7Sz7IVnlAxYRB
         hY7Q==
X-Gm-Message-State: AOJu0YwTrvky1twzkPZb8hWmlYhMK4NIkMSLYStSQT4qzAxUOE8HIY7+
	GOhPHd2GLGXGfvsv+52vSTN5LHrHrWjWNMNMWxCG/vOf8izPMUbuXx7JA2BXTBESklhBlaBetn2
	4u+cPvms=
X-Gm-Gg: AZuq6aJzgzjIak9pFVbh87afZ0JFySMMxlh5ZKqXvCwkY4tKGFh7V+0rKpGYgFhPCj7
	d5j2unPSEdKR6BtVenPrAAmAkgdV6xAzj8Bgkn/3fs7bmSqabe7pCiiL68lrs8VA1Tui4AsW0uv
	sg6yo2lTyZw/2debGw6wWumRJ95woO7qRgtyhT2jy9sOJyxb1Sbpq8X5VHzq9PlSSXqy84bmvnP
	DCmVtS8RoHzNaUdls0ULEii5MXGyUbmkpyaAGF/WhjOoZFEKqym9MieuR3zF/P7f5Rot+p1995g
	Jl3BIkSedz2LLSR38N4m+WoF8H6qEavK3d2hsWyOFGWj8nGxVnYOtoQ9wH3v9digwUHU8Ijpql7
	mJq8t48OcL8FwDSzJ156fnNwvfHLWRvqO7FEQyPChRf0IhpL+nVvUZJPwk7QoYuIMTkwvq7msbK
	had/S6a0yDQ12EuKNJUWU5n3oYVASpfPtUZx4eW0X3YHGweRlaK5/x4+wZMhBAbVgtAn+JduBC2
	7zex8a3Bw11moA=
X-Received: by 2002:a17:906:209a:b0:b8d:cbb5:c072 with SMTP id a640c23a62f3a-b8dcbb5c7c6mr92124166b.57.1769608964208;
        Wed, 28 Jan 2026 06:02:44 -0800 (PST)
Received: from localhost.localdomain (253.red-83-57-139.dynamicip.rima-tde.net. [83.57.139.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd78d3sm68522105e9.1.2026.01.28.06.02.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Jan 2026 06:02:43 -0800 (PST)
Sender: =?UTF-8?B?QWxiYSBIZXJyZXLDrWFzIFJhbcOtcmV6?= <alba@thehoodiefirm.com>
From: Alba Herrerias <alba@neighbourhood.ie>
X-Google-Original-From: Alba Herrerias <albaherreriasdev@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alba Herrerias <albaherreriasdev@gmail.com>
Subject: [yocto-autobuilder-helper][PATCH 0/4] Update dashboard, Bugzilla stats, bug triage page and autobuilder issues page
Date: Wed, 28 Jan 2026 14:02:03 +0000
Message-Id: <20260128140207.61443-1-albaherreriasdev@gmail.com>
X-Mailer: git-send-email 2.40.1
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 14:02:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3131

This branch constitutes the entirety of the work on the STA Milestones 2 
and 3 for Yocto in 2025: Improved design and unified website pages, 
concerning Yocto’s dashboard page, the Bugzilla stats page, the bug 
triage page, and the Autobuilder Issues page (abint). In general, the 
work consisted of: unifying all pages to a common design that matches 
our previous work on the CVE/Metrics pages, and also unifying the rendering 
of charts to use Apache eCharts. Also: adding proper support for small 
screens and dark mode, as well as general refactoring, optimisation and 
simplification where possible. More details and screenshots are available 
at: https://github.com/neighbourhoodie/yocto-autobuilder-helper/pull/11.

Alex Feyerke (4):
  dashboard: update to unify styles with CVE/Patch Metrics pages
  dashboard/bugzilla: update to unify styles with CVE/Patch Metrics
    pages
  dashboard/bugtriage: update to unify styles with CVE/Patch Metrics
    pages
  abint: update to unify styles with CVE/Patch Metrics pages

 scripts/abint/abint.html.j2                   |   87 -
 scripts/abint/abint.py                        |   46 +-
 scripts/abint/index.html                      |  290 ++
 scripts/abint/requirements.txt                |    2 -
 scripts/abint/resources/apple-touch-icon.png  |  Bin 0 -> 7683 bytes
 scripts/abint/resources/dark.js               |   76 +
 scripts/abint/resources/date_helper.js        |   36 +
 scripts/abint/resources/favicon-16x16.png     |  Bin 0 -> 792 bytes
 scripts/abint/resources/favicon-32x32.png     |  Bin 0 -> 1246 bytes
 .../resources/pico.fluid.classless.min.css    |    4 +
 scripts/abint/resources/shared-styles.css     |   75 +
 scripts/abint/resources/tablesort.date.js     |   23 +
 scripts/abint/resources/tablesort.min.js      |    6 +
 scripts/abint/resources/tablesort.number.js   |   26 +
 ...to.echarts.with_heatmap_single-axis.min.js |    1 +
 scripts/abint/sorttable.js                    |  495 ---
 scripts/dashboard/bugtriage/index.html        |  588 ++-
 scripts/dashboard/bugtriage/tablesort.min.js  |    6 +
 .../dashboard/bugtriage/tablesort.number.js   |   26 +
 scripts/dashboard/bugzilla_stats.html         |  256 ++
 scripts/dashboard/data/wdd-weekly-recent.txt  | 3490 +++++++++++++++++
 scripts/dashboard/index.html                  |   77 +-
 .../dashboard/resources/apple-touch-icon.png  |  Bin 0 -> 7683 bytes
 scripts/dashboard/resources/dark.js           |   76 +
 scripts/dashboard/resources/favicon-16x16.png |  Bin 0 -> 792 bytes
 scripts/dashboard/resources/favicon-32x32.png |  Bin 0 -> 1246 bytes
 .../resources/pico.fluid.classless.min.css    |    4 +
 scripts/dashboard/resources/shared-styles.css |   75 +
 .../dashboard/resources/yocto.echarts.min.js  |    1 +
 scripts/run-abint                             |    2 +-
 30 files changed, 4958 insertions(+), 810 deletions(-)
 delete mode 100644 scripts/abint/abint.html.j2
 create mode 100644 scripts/abint/index.html
 create mode 100644 scripts/abint/resources/apple-touch-icon.png
 create mode 100644 scripts/abint/resources/dark.js
 create mode 100644 scripts/abint/resources/date_helper.js
 create mode 100644 scripts/abint/resources/favicon-16x16.png
 create mode 100644 scripts/abint/resources/favicon-32x32.png
 create mode 100644 scripts/abint/resources/pico.fluid.classless.min.css
 create mode 100644 scripts/abint/resources/shared-styles.css
 create mode 100644 scripts/abint/resources/tablesort.date.js
 create mode 100644 scripts/abint/resources/tablesort.min.js
 create mode 100644 scripts/abint/resources/tablesort.number.js
 create mode 100644 scripts/abint/resources/yocto.echarts.with_heatmap_single-axis.min.js
 delete mode 100644 scripts/abint/sorttable.js
 create mode 100644 scripts/dashboard/bugtriage/tablesort.min.js
 create mode 100644 scripts/dashboard/bugtriage/tablesort.number.js
 create mode 100644 scripts/dashboard/bugzilla_stats.html
 create mode 100644 scripts/dashboard/data/wdd-weekly-recent.txt
 create mode 100644 scripts/dashboard/resources/apple-touch-icon.png
 create mode 100644 scripts/dashboard/resources/dark.js
 create mode 100644 scripts/dashboard/resources/favicon-16x16.png
 create mode 100644 scripts/dashboard/resources/favicon-32x32.png
 create mode 100644 scripts/dashboard/resources/pico.fluid.classless.min.css
 create mode 100644 scripts/dashboard/resources/shared-styles.css
 create mode 100644 scripts/dashboard/resources/yocto.echarts.min.js

-- 
2.40.1


