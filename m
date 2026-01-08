Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365E5D1D489
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 19:38:54 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15031.1767901128471476003
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 Jan 2026 11:38:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=P/FUITEY;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so29712655e9.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 08 Jan 2026 11:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1767901126; x=1768505926; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7G9fEXi5O2U4QJZrIna7qdoCyn/7X3AW7TmcGlj2n0=;
        b=P/FUITEYHLx+BHMHg20Ez0cEBDt6hhigfY6BKv9YOvpWd+YvxNEj/QYFECgxkcNacw
         9onHqPtBLlebPrOTyhzppE13Ec//tFqvJ3hrQR9F5GrKp2B2nlB6K9xTpH+pHcnSwkO2
         nQ2SmgnuOdkBpoYNTO2ewKTrwc9beKI9GZj0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767901126; x=1768505926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7G9fEXi5O2U4QJZrIna7qdoCyn/7X3AW7TmcGlj2n0=;
        b=rXqAPDXYbNJfQDWfT57h0ZeDdO22RHvYQBno4g4cnbyuVGPKQ3CKfLR5fOXyvwvJ9l
         m+GfxcCfxN7ph2F7px54BAasi7M4/ZjMhcqZLPUfWrf9jTPX2qw9JVwIIzN5nByw/O0y
         yQGIEEA3u2a4u/wV9AM29adqu4xqBqQE3ul2TJyDNYES7/BxSR4cdr9dy6l77WDrAcXL
         n1zC/YBcnOBq9RROtX6VcfbD0eBHgLKboI4uVfwmjaEH0JgSVg4YRIqLIW2M3bIB1GTZ
         tFOyTBuLJ9qj+QbxQ7aAeGaqsGnCkIY8fTAEGEADZNEB+BQjL4P97PhVDmJbT5bNHwYP
         SVQA==
X-Gm-Message-State: AOJu0YxjaMpv6mqPLH/VAepHu2/XCEV6/pxq9J3uttxYJN6bMhftsJiB
	Alc66gu+fH4mlxMNJNGaDackfYIcn14HXvhn3waBp8+VFXDkwSdBpXBq+YXFHyXgjqaXfKdGaez
	dZMMQ
X-Gm-Gg: AY/fxX7/+T2YLv+0RF84ukjNhpzqH1haW2mjtF5UKKcCCs1DOHOPzzolnVuNTKE3TkG
	lDUufRUSfHPh+PYJ3xDqtHWl8piNE2F4WyyuHN1KGssGFg6APoOEpDWh2YLWbTiU1v42fzQ5swC
	k/xYBkUQHxMkimVHq6SsdKvO0xb8EnZypPiSToM6XClC6XEAd/WbEwwBl/3rLx3l8/3ehsdJ2N6
	CqHJdKdF7KdvmGCKXMbu7tYRZozrV/z6pkeL/h6vSVlM+edRjiyi4k2J8eT1WxZPDUFw/+HTlLZ
	Wr86NXHa1bOU4V4czNHtVVTRYODC2RE9Re3xkbS/8/dQPnC65BGBJl9Q+qvdWMONMYK2QdkwOok
	GBV7gmUhQk4Cx31YzMMvxMVj8sWkSeOqFrofPkQegLtuIth2ZawSB0Z/9tRidnwd5LxCg3Symke
	MVgDnNm8gS98hLG0QgnYOMdrbZkxBiSnJdzJ0hB9tUwTgPPS4gS1TBTgqrrV0/KgLcFdnqfJ8eL
	uvunDdKCIGVnZg=
X-Google-Smtp-Source: AGHT+IFaCcmWvjVnjL2PjMzBsEz7eJcn+nCM7ooBZQItmaSpaF1tVGQh6aBKFEpsa2vVVsp2ztOBKw==
X-Received: by 2002:a05:600c:1988:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d84b54025mr72312605e9.34.1767901126406;
        Thu, 08 Jan 2026 11:38:46 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa000dc867f4b4d5d71e.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:dc8:67f4:b4d5:d71e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f695225sm169152965e9.4.2026.01.08.11.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 11:38:46 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>,
	Ross Burton <ross.burton@arm.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [yocto-autobuilder-helper][dunfell][PATCH] scripts: rebase before pushing patch and CVE metrics
Date: Thu,  8 Jan 2026 20:36:44 +0100
Message-ID: <20260108193643.317392-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 Jan 2026 19:38:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2916

From: Ross Burton <ross.burton@arm.com>

There's a chance that run-cvecheck and run-patchmetrics fail to push
because the remote repository has changed. Try to resolve this by pulling
and rebasing immediately before the push, and failing if we can't rebase.

[ YOCTO #15529 ]

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

(cherry-picked from commit 60e2011f34793fb638c223e520cef823025c8c26)
This backport should fix [YOCTO #16111]
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
@Richard, do you want me to test it on AB first?
---
 scripts/run-cvecheck     | 4 ++++
 scripts/run-patchmetrics | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/scripts/run-cvecheck b/scripts/run-cvecheck
index d22dc82..c6b0066 100755
--- a/scripts/run-cvecheck
+++ b/scripts/run-cvecheck
@@ -90,6 +90,10 @@ if [ -e tmp/log/cve/cve-summary.json ]; then
     git -C $METRICSDIR add cve-check/$BRANCH/$TIMESTAMP.json
     git -C $METRICSDIR commit -asm "Autobuilder adding new CVE data for branch $BRANCH" || true
     if [ "$PUSH" = "1" ]; then
+        if ! git -C $METRICSDIR pull --rebase; then
+            echo "Aborting push, metrics repo has updated and cannot rebase cleanly"
+            exit 1
+        fi
         git -C $METRICSDIR push
     fi
     $OURDIR/cve-report.py tmp/log/cve/cve-summary.json > $RESULTSDIR/cve-status-$BRANCH.txt
diff --git a/scripts/run-patchmetrics b/scripts/run-patchmetrics
index 391ac45..8e52371 100755
--- a/scripts/run-patchmetrics
+++ b/scripts/run-patchmetrics
@@ -24,6 +24,10 @@ if [ ! -e $PARENTDIR/yocto-metrics ]; then
 fi
 $OURDIR/patchmetrics-update --repo $PARENTDIR --patchscript $PARENTDIR/scripts/contrib/patchreview.py --metadata $TARGETDIR --json $PARENTDIR/yocto-metrics/patch-status.json
 git -C $PARENTDIR/yocto-metrics commit -asm "Autobuilder adding new patch stats"
+if ! git -C $PARENTDIR/yocto-metrics pull --rebase; then
+	echo "Aborting push, metrics repo has updated and cannot rebase cleanly"
+	exit 1
+fi
 git -C $PARENTDIR/yocto-metrics push
 
 if [ ! -d $RESULTSDIR ]; then

