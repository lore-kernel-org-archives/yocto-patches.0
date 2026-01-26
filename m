Return-Path: <ukleinek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFEED1950C
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 17:19:28 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25959.1769447958276663627
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 09:19:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=SbWm0E+2;
 spf=pass (domain: baylibre.com, ip: 209.85.128.46, mailfrom: ukleinek@baylibre.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee07570deso36730915e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 09:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769447957; x=1770052757; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jgB48K0xMfoyC1YCodU/BJaZZP/33BIfNr97W9kyr+8=;
        b=SbWm0E+2rYdEpLu5UkOgJ+lELdM/1CRBV4rD1gLF9Uq6Z68hCc0CULK8zragM86lfE
         TyUfhw+nXB7SQY00Us/TZo/WCWFc+Ql6NwWVhgbxMKj6YtXWtpEWfXeT67W4ta9vUoS7
         +HUwsXdUs1EzGrHHA9i1bw1RGh0jgxYqHULlLVD1CuOLR1g2Qv0G2u3dfuQZWhposLlN
         dkSQhMieEotMUKptDx04ZDa11VFu8698C7WeA67CLgG3yThmsYwG72Pyciqgqq7pg0PK
         8E7aIKcqpypTx88ZpCltUFDPOJwNLUGJFNURl5wY3yRXbfo/6Ejf7XuxhWQPJ+wvDWp8
         11vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769447957; x=1770052757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgB48K0xMfoyC1YCodU/BJaZZP/33BIfNr97W9kyr+8=;
        b=XipQAKON8iH12a62tiPk9eTVuzZcE1+fGtRbb4uSfQfeyT4xbuEBhZvOtJGKV6Hps8
         Qaqbqf3/8qfCXs6DssYVfBG46jKdkti2xQD5d7offhjNAX3f+rxCXPOsdzKLpeoDJDy2
         /dKgmtQ10YJE93gL9a7wCUTz3wf8amSJsTJayWCbgMWP95Z8xsAilVr5y3qHklkrMUfa
         VRZ+5TRhXtgH/iiA+i7BR+3i+lHHBMEPMWW8ib3qjB9i6EkldXN/kaqwwwGVeB/yY3nB
         B11q13XrlZISHdZ57dSx+/GCAGkKaDnbn6sOR897Z2YLGjMF9BAq8RubphK5ZskuBngu
         0QOA==
X-Gm-Message-State: AOJu0YzEVr/FAQeat0iT6ltlZg4+OtbKHQB2S5UKbEUgfD2iN0wWCyOH
	DPx3P9wE9Z2GEWwr22OkTW0OExWkYFcvn30Cu3STaUwMK5utWCo6X/a9/AU8tc9Zd5YI/KVMotj
	nu1Sv
X-Gm-Gg: AZuq6aJODT7xQqkNDRdyNQlo4iPQNer8vyeDV/LWwPjz1M+jY36n+WFpFDWp/gd8pR2
	fapZxKyTCC6sXxVXr0rFKr5/VrmSZ/ro7jkddLDgK+WwEGLIZjoxZL8wuXk7spzUIjj6klXoKMi
	aPuBFMTFr4SwOcL0o7LxHYmH8eeqleDQr657+IXNoemLMN6A8+cReiraRQPLP6KdAzNoYAIplRi
	0iVgcT60D7W7qXjTcGe+n992xqbrG+fGnjNbgAi7K3J2ewqjMmY9YTtKT2rbmF1pdDTqR/Ie7l4
	7uGNfAy59F7aj9GZNFgUCc+OU7LXmcZeLvAXcLOqHSiXG+qhOoZy5yvRn4TVBHmvyCFgktl/ApX
	mRSGIX6uDjyw1t9AoLZeZnny6fHd3Xhw8qSC7BmggDSYnFZCov+56+XNVbnims/NQC67qcxD5rS
	GEfiTi1ZDcwOjBKzfov2/JHTjJS8fopEz7RpGT9mV3HiWbEV2C4m51MeWEZdAO0NG98mU0tRo8e
	L4=
X-Received: by 2002:a05:600c:8b81:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-4805d0643b5mr76306625e9.32.1769447956610;
        Mon, 26 Jan 2026 09:19:16 -0800 (PST)
Received: from localhost (p200300f65f20eb04e3c7513b867411b3.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:e3c7:513b:8674:11b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-435b1c24f15sm32518052f8f.18.2026.01.26.09.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:19:16 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] file_contexts.subs: Improve comment for /root -> /home/root alias
Date: Mon, 26 Jan 2026 18:19:11 +0100
Message-ID: <20260126171910.3239263-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=95O9OBXasXMRoqP/vVL2Vy0qXbD/DMbQgoXjVgNHCJQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpd6IOeGAe+C6ShEPf5tRBrAzo3wYfcb9Jr1oU5 l5yt0X/oNGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaXeiDgAKCRCPgPtYfRL+ TnkbB/wOWmbgPoBm4kKeQmDu2/w/6WZnKQrg1VzILB3J5/razezoLuIAXg9fjafjj3L/eKCpP/E vqUPnmGAobmM5yhwhP4jBj9KAoimMRPafTYgsH4FmsTWWEsTORNumkmeQVhFdCHpl0Ebz4EBxWG YQdnDtUEc0r8P6dICgxpdAMF6NKLdiLUHASDa7JhXydEjllBfisFD61xBRQb4zwOjJhedWpq4GH 40CHM/7RcZTSb9J5xgecR3RvH6pksrzYneKuX4SmedQqkmYA17ZE2vx6dhMXLGYuvoXfr+/R/ya 4n9O+YK9qgSSvDgLoTjZSYanjs2DnIVUcKBpPRJuKTDqZPxT
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 17:19:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3089

---
 ...le_contexts.subs_dist-set-aliase-for-root-director.patch | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch b/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch
index fbaa44ea704d..19541b57cf56 100644
--- a/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch
+++ b/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch
@@ -14,7 +14,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/config/file_contexts.subs_dist b/config/file_contexts.subs_dist
-index 690007f22..f80499ebf 100644
+index 690007f22..0e0ea22f 100644
 --- a/config/file_contexts.subs_dist
 +++ b/config/file_contexts.subs_dist
 @@ -45,3 +45,7 @@
@@ -22,8 +22,8 @@ index 690007f22..f80499ebf 100644
  /usr/lib/busybox/sbin /usr/sbin
  /usr/lib/busybox/usr /usr
 +
-+# The genhomedircon.py will expand /root home directory to /home/root
-+# Add an aliase for it
++# The script genhomedircon.py will expand `/root` (i.e. root's home
++# directory) to `/home/root`. Add an alias for it.
 +/root /home/root
 -- 
 2.25.1
-- 
2.47.3


