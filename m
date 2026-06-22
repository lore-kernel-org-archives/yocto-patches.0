Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22DACDB471
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 14:35:47 +0000 (UTC)
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43549.1782135993235849035
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 06:46:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@b2open-com.20251104.gappssmtp.com header.s=20251104 header.b=su4oGk62;
 spf=pass (domain: b2open.com, ip: 209.85.219.68, mailfrom: cleiton.bueno@b2open.com)
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8e066990ff9so22954436d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=b2open-com.20251104.gappssmtp.com; s=20251104; t=1782135992; x=1782740792; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6d4I5iBn8xr69QuN7LdWYv85BI9iAzJerRKRBG0ZlI=;
        b=su4oGk62M3+0B0rFhUK6cZjocQRBXqLcCR12tyToMpZfTdxQ7UjJ/avKUYfIRXTRfp
         J16YHCyvz7YkZDSFWjtRStWPVUuLjFF9jUrbyqixxrPqrcsMH/vXzebYo/K/+hfr+RIl
         MgxCwts9XVaJPn/36D0mwq5eq+aTRmLH+csqMNc6i5bs01eGpUAwCAXHo7J1ZD8Gjvd8
         PotNYeNjUqwDKlXgnrn/K4Rhg5cWWguq3Yl3XVQgil9kBUNvP2DUtvlbCq1Q8GzdVk6P
         KefVWGwVRWz1ke673Vsz0PdC6gxbDn9jJ48u/2yTaGqZNme1Fw64oYUh3vUnF/++0blK
         9EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782135992; x=1782740792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6d4I5iBn8xr69QuN7LdWYv85BI9iAzJerRKRBG0ZlI=;
        b=sEgGeSnLJwhwVXbI3OXeVDXSZmuUPC4B0F6N96IVsd3tLOIA/sXSpk0xcUgO92s1rP
         KGrfHdhPLC6pPxqmvvLnL9z4ZLzhyrZE9luoQsyiiMJbTeFu6LI5A5R3yWvhWyu3smNn
         K5fIPtLmSTYcGl7LHHoRH1XPTHOH0qQS86mK8r91x5NiKviFtkW+NjnoxuBqIdOxESSp
         LafF3pOoF2oF+qHrjUoxPZBcldo1AVWDD7e9/4A0+lV+6MAFVcjNDlhDWrv/ZBSjucHq
         /sXFIkyFCQe1PXw/EggaE006yUZc1+O5vczoz+kCKhjIJR6PHcAhW1eyMxeSpsjmqTUa
         aivw==
X-Gm-Message-State: AOJu0YzbmDZluhK9P0q+VfDCg2gZVs1fVU83cq+kHjkFHqv5RfdDJlot
	cuRaVnLb7M2oQtyfburzQ5bBQk/Qs4KuQfeCeM7khCcYt99LKicM09rdcDOGvRgdDwETh2FdKwE
	RGb8yuHk5pfBU
X-Gm-Gg: AfdE7clViEostlT4TxoSwg8w9Pa4venYyPjQChEB9ESbhxy6vdlfHve/svevubUWfZl
	0pZAbNx4w5A9l+H0Fw85qCvxV0d16rngT6k7Pf3essWwnGTvUtrI57uUhrQMrVbIjm12L/X4naQ
	BHYY5NSVW6rGijDt9bPwZ/ztlmxT9d/jeWobfPGN61nS/D1c2SX9XBA5thUoMA1uXP5WFKR252O
	mNcuvUNx0yB3NlhOGjF/ivbwSbL4q72zV5hEXYK7Q5Xwe8ZrHhBUarSts4UNw5xG2mfuOiwyNaC
	ZoJUMqZqWSz2d93H9xBLDpHXZBVD241iJWvLyaTvrFgclaBoHtJ78FFWtoFxiXoh+YYL3t6P1x3
	3vb7v6WuI9rOWgOQ39M78RB8EckRUHIN4M+j543cADw6u45OdQ0qj97YBKAPZp6vkJ4aUnqUCy8
	C28On5wxv/LpY4CnFFHpDLSbvnwov94BtXEOdZhw22nZ3YIf6eoYwcF9NrrbEW2FQNADRCROPZ7
	kJVxS95NPJti4CjhCYOxLafg6fGVkBY9aak4ZzYHgECrjM=
X-Received: by 2002:a05:6214:da5:b0:8e0:c0f3:a2cb with SMTP id 6a1803df08f44-8e0c0f3b8e5mr106385046d6.0.1782135992066;
        Mon, 22 Jun 2026 06:46:32 -0700 (PDT)
Received: from b2open-a70-hyb.. ([2804:1b3:a301:76bc:f850:b260:b588:cee7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f015e50sm94247326d6.6.2026.06.22.06.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:46:31 -0700 (PDT)
From: "Cleiton Bueno" <cleiton.bueno@b2open.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Cleiton Bueno <cleiton.bueno@b2open.com>
Subject: [meta-rockchip] [PATCH] u-boot: fix incorrect commit reference (radxa-zero-3)
Date: Mon, 22 Jun 2026 10:46:26 -0300
Message-Id: <20260622134626.3616736-1-cleiton.bueno@b2open.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 14:35:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4256

The commit 8cdf606 is incorrect and does not belong to any
branch on this repository, it may belong to a fork outside of
the repository. The correct commit should be:
2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead

Signed-off-by: Cleiton Bueno <cleiton.bueno@b2open.com>
---
 recipes-bsp/u-boot/u-boot_%.bbappend | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index c939a48..9432e2b 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -3,8 +3,8 @@ require u-boot-rockchip.inc
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 
 SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
-SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
-SRCREV:radxa-zero-3:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
+SRCREV:radxa-zero-3 = "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
+SRCREV:radxa-zero-3:rk-u-boot-env = "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
 
 SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
 SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
-- 
2.34.1


