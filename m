Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186E9C53219
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 17:07:45 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16611.1785344861161020275
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jul 2026 10:07:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h/n5k953;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954aff6088so11959435e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785344859; x=1785949659; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j/9oDbtDLbXUyR0yD6N1RZDkRAkAgSVRlzsNNbfi1rU=;
        b=h/n5k953v5ORxlpkX/FBocFnpslYOrBjL2kzI/spUurLosYNZTc9uV81QB1WLc+3xm
         kAmfDjvppbLqmTijLZCg1gh/T9vvGGMEO6kZCYHkR7bKxQvtZrsR6NnClZk4nVp73w/q
         H69Y0rSyOm1VfyNamoX41b/lCaCvf4i/xXXIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344859; x=1785949659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j/9oDbtDLbXUyR0yD6N1RZDkRAkAgSVRlzsNNbfi1rU=;
        b=VxFYDOC+iR3pmeJhNY19/sXuFUWmf3Q+fcYkcDDKnVjlcbFzkQ2qZvWd+jj/Lsrm07
         sRYZEnfXd6Sideu2bfvizUOr3FpozSk2IPhlL9UnLYB/a6ql/c/U9LKJi6m6tuzVozNV
         MHTDnGLWZlOBKHvIqneHG2V+MdjMy4tQrVagsicAhminfUcnnNJkMjB0qFcc0MoawFkQ
         lmdyzC87jx+SsES/lN7rNau7wjD4fbBdpaNCdrc4wsp6/DkJK30pz6IsTUYrTOiM0IEj
         btbGqFvan7hjoh8LSR29nkbwEyRd0prl2HA8XEjzW+etJo9ffvpnYE9jLS+vUoApDqsU
         3jtQ==
X-Gm-Message-State: AOJu0YzeALr7xBcTorJQXiRhwd+tnTHdYuR+f1Ou9JyrYZB5GyJEqWMo
	yNW6W9E+Eyynz8XAzA9CI6hR+++LOk3O0NCuvbwp05rUSAY/aisOcOJlRjigMGs4Y6GXmVJzXHz
	AE8OLl2U=
X-Gm-Gg: AR+sD126oIACzwYkCKH4iVhcaLFKF5BAb6nyLxWijGNUhHeLYgSdRbfQavf/VEdDkCi
	0EW61rTPKkUqNrBAqeU2EYda+dmE5SPXGrOJKLF8ixnFst5Beq/nIa4vkxkOPw0D8r4SdWr4UTC
	1zxG2xpHZtoxuXVvdkRU4lwA/lOnVfNrcZikQxVUNcQrclKsrYjapw+VcKL7/qZIAR5tDGKHB2N
	mtmVMd/JouiD9OundENc3BIZMMQPOTvf/1ipf3KGxe2sFMTSNNJ+YRw90xQ5pSPDvK7SPbicbz5
	uq6fIVLZ5yTq5NfdU3L66LbMjX8uz/JrkhRySu9LTljMJ/3nqkuEzPtYzC59BFMtbXOZS/AD5mj
	Llosyz4gidJuBwNRlG0AExpye0AZ6dDWKVv7tdwEbGJQNsNjMOeFIR4o/swoV//QZYqqHGPXQF7
	GcikjR/hetvapnQjD175ATiG+IUkoZkphVuB4uKA4QAqI3ICrfzXQ2WwyqB77g0yM5NIVOiHVXs
	SzG6b0+OshtJw7EkQ==
X-Received: by 2002:a05:600c:a012:b0:495:6a0f:200 with SMTP id 5b1f17b1804b1-496c6582ab8mr84707925e9.27.1785344859350;
        Wed, 29 Jul 2026 10:07:39 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3647:86f2:68ea:efc7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b189fbsm9350819f8f.25.2026.07.29.10.07.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:07:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 1/2] config: Add reproducible-arm, reproducible-cross and reproducible-arm-cross builders
Date: Wed, 29 Jul 2026 18:07:36 +0100
Message-ID: <20260729170737.3034315-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 17:07:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4568

Now that we have arm workers, we can benefit from wider reproduciblity
testing. Add some arm and cross builders to verify reproducibility on
different architectures/machines.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.py b/config.py
index f5ff40ad..0f72f1ef 100644
--- a/config.py
+++ b/config.py
@@ -153,6 +153,7 @@ builders_others = [
     "buildperf-debian11",
     "buildperf-alma8",
     "reproducible-meta-oe",
+    "reproducible-arm", "reproducible-cross", "reproducible-arm-cross",
     "patchtest-selftest",
     "toaster",
     "patchtest",
@@ -243,6 +244,8 @@ builder_to_workers = {
     "qemuarm64-musl-ptest": workers_arm,
     "qemuarm64-ltp": workers_arm,
     "qemuarm64-armhost": workers_arm,
+    "reproducible-arm": workers_arm,
+    "reproducible-arm-cross": workers_arm,
     "auh" : workers_auh,
     "auh-meta-oe" : workers_auh,
     "metrics": workers_centos + workers_debian + workers_opensuse,

