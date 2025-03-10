Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D57C282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 16:55:18 +0000 (UTC)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
 by mx.groups.io with SMTP id smtpd.web10.43537.1741625713924620637
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Mar 2025 09:55:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NpkXuJra;
 spf=pass (domain: gmail.com, ip: 209.85.166.51, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85b4170f1f5so59713439f.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Mar 2025 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741625713; x=1742230513; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIkEJg0441IgtU0FpIujBpXdCcGGhVK81ZK7z5ov9FA=;
        b=NpkXuJradRr/NZ8DsMNhL5MKeW1GniQ1KzYnsjE3blHWPy8s/xj/L5lktXGBo8T+FG
         FCJ2P1UUzVLIr44fJWeZh6t4yOHcpd5VCvDDhwr1ZyWzYYUTt2NIekqqLdivDMYSNsUD
         X5FcbIGYlFShOqSe0Bt44TPgOLgBVatyOnQiaMZ/H40ZlurtMiVLhEU0xV4Pxei0lCrA
         wg4HYnE5k1Ls4ZBnlDmQRMZ3XDrRcfU1kaLgWLo9Y7ct/qg3S25mVpyVBkKS3ulUyWRf
         HUGnWeN5k7/4RzdwWkHTdH9AzmTT9nhcIqmEjUZRxwFUqlHzPVJ/kTABKoWAmmMPLnN3
         s2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741625713; x=1742230513;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IIkEJg0441IgtU0FpIujBpXdCcGGhVK81ZK7z5ov9FA=;
        b=SbRhZom3Vu39t1WAzvCJb5RBigSAuGtLl49Vpe5Qf6M9UVB/y0f/LmO7umdo+o8w5K
         j53/WSmI2u6kwiiI03CRvL3x3LTI+mMAlMTYEvti1YZKxhewdk06kAz272FoRS3JzMaF
         SpQVK4yxyYn6ygyxdBTjC2CVrhvs6p4lf0xtFmA845wXvsDwH5XKcOnWHlT3OJbD2umz
         xnnpUHokwUsSjp1bh0egqeTxSjHPKRbKy6K7Y1AQ+Dgoa2bZPkyFrVcc41OBkkgWGbuG
         5kPChpti3Z39cjur4E9swCdKhKedYkHXvQFK0RTgeqG9iChbt+33mOHjnt1yJtAg2imh
         GBfg==
X-Gm-Message-State: AOJu0Yyb7XrE65LpFT+oAKGcrCJGUmGNc8J6cHDWE7WzyZYEB9N/6fVN
	i69f8K6i5QMBmGpuV/uVZsrnKagByiLeKX+v9TtRjiLlBmjg5qGxZsGYDw==
X-Gm-Gg: ASbGncstDGe8YPkiKLkdQDMzJnu96MapgNKrTSjcTAWGGkuUl9wjhJ0+EgEB5jX6gCN
	M1iH4cwcBqy7crGcJT/BDZYa0GdKsJGIrif9RjGY9Zzkv7xF9ouh6w0sdilagA2TCAuSRe3BQq3
	U9yTvWk16gE4yDBE1JF1DZpzsfpXYe2jK30XwgMCSAlD3IX4qyif5a1HmbWfPaW8bD4NwMGEhPz
	nU6IvaTfb2L6YFFwDoImDLPDvYaJ56xrg9i0Nbv0jWD+qMkm9LV7meCLcaRYS8u0bdpuUyDJi6G
	wFduRD5Blx3KHodlCKE8vaclI2QszSxwQEz9yyxqKwCGKHNItfD3/L2xCmm1Jo0jl/+xu8fjEhe
	n0FUDSUUhU6osdZ88gg92Ww==
X-Google-Smtp-Source: AGHT+IH2uhhwVyWzoQfaQpSddOTauLgRAlMdF1F9Ldcqzb2wLYbVDRgBzHPJxvxIWGD4A2V174uNbA==
X-Received: by 2002:a05:6e02:1445:b0:3d0:2fcb:e7f with SMTP id e9e14a558f8ab-3d441735d9cmr167469725ab.0.1741625712721;
        Mon, 10 Mar 2025 09:55:12 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f216708f76sm1909926173.85.2025.03.10.09.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 09:55:12 -0700 (PDT)
Message-ID: <b61a1919-a65d-4674-8604-69ebf661cc8a@gmail.com>
Date: Mon, 10 Mar 2025 10:55:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org, akuster808@gmail.com
Cc: sekine.shigeki@fujitsu.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH] smack: Use new CVE_STATUS variable
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Mar 2025 16:55:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1174

https://docs.yoctoproject.org/dev/ref-manual/variables.html#term-CVE_STATUS

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

 recipes-mac/smack/smack_1.3.1.bb | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/recipes-mac/smack/smack_1.3.1.bb b/recipes-mac/smack/smack_1.3.1.bb
index 6c52392..7b20e6b 100644
--- a/recipes-mac/smack/smack_1.3.1.bb
+++ b/recipes-mac/smack/smack_1.3.1.bb
@@ -13,10 +13,9 @@ SRC_URI = " \
 
 PV = "1.3.1"
 
-# CVE-2014-0363, CVE-2014-0364, CVE-2016-10027 is valnerble for other product.
-CVE_CHECK_IGNORE += "CVE-2014-0363"
-CVE_CHECK_IGNORE += "CVE-2014-0364"
-CVE_CHECK_IGNORE += "CVE-2016-10027"
+CVE_STATUS[CVE-2014-0363] = "cpe-incorrect: different product"
+CVE_STATUS[CVE-2014-0364] = "cpe-incorrect: different product"
+CVE_STATUS[CVE-2016-10027] = "cpe-incorrect: different product"
 
 inherit autotools update-rc.d pkgconfig ptest
 inherit ${@bb.utils.contains('VIRTUAL-RUNTIME_init_manager','systemd','systemd','', d)}

