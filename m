Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB6CE9A02C
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 14:08:32 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12620.1771423704193162832
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Feb 2026 06:08:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=NU5xU0sg;
 spf=pass (domain: smile.fr, ip: 209.85.128.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso43476005e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Feb 2026 06:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1771423702; x=1772028502; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6yJklqZlLpedsTy3T0VTXTwR/eKxm4Fbph+KZLgcw6I=;
        b=NU5xU0sgSxTlEatUPg2hjgl+xEEiWorFihe697d7IuUDhx3eWQFuWN+BZZ51lAODWb
         xec/f0/yLwEzTBb/3L9TntyyoaXVEUZrR8NfDsDbyfJyHYC2ia9CS2fr5ayqCG7DcwtG
         kdt+tXzdHaIlUes0khHrd953bRkNir8iNhzV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771423702; x=1772028502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yJklqZlLpedsTy3T0VTXTwR/eKxm4Fbph+KZLgcw6I=;
        b=OX5/DU/+ZM8Uz8DcdpEGDS3teOTMBg0MtUmBa/lApbgetZIfFbzpyojPrwVoHrSOAW
         oI8EgyV5L3Q/FnnN2HXltT3B6OcDPXWc1LQ1Bdpwcw2Ls2l5OTf3HdIBusTmiJvEYSY0
         3DAg7gDGfHlu+vhg73gOaKqqmbNA/qbYUcnOjQJCcncc1Yz0dDuYygbG2vPJEZdch2ME
         NEGCgDkAUZRO0UqECCLP6IwAESziiGtO+V6FN3HIxTtZRLPBLRQkj85Qe/WmGEKQs1lS
         KZkWejHIl0ZFDD9saNMICNqx0PA3ohjx4nE/zErGoGSk9D0zIKi9TRZMjEkyZ1U6rwte
         3JZQ==
X-Gm-Message-State: AOJu0YxlDWd54jOBE+MmKHrea/VpTiKP4LAgBL+8P49jbTilRjAEiia6
	qrw771Ulqy+VARYcSDyOhel85J2wAoi7U6pfH+9bE+CQw2FNhAqn0acI5UwoISsGk6dJG+hO33x
	dFLbV
X-Gm-Gg: AZuq6aKRvVoV5FbWru8CtXG4j9tD2HndZ6tyoORi6t9qCWwEFP7xyuaGHaoKkVOcU5g
	cUGbMZSAjFDBNr05pSnpQUwwk1XrqrUCWKBGnHz56Mw8X3Wq+1NYGSXgwwL6SbDxAPpuNnjlwno
	E1dyf5wTTK/gliIFXJAHNB9T0gtms1QszzuIEaGyUvXrTrhvsHnvsqeGQWuqe/mrPoJclpD1wVk
	T25XSTw7hCplY884czD8HzUUybm5XjXCrEQ8st4qCYYjvMTw2DDa1q2+4HLFFZLJu6fdWOz222m
	wKMvpmDaxNWCdszzFFTFZINTnVDd+sIQ5VZcb04KQDALuZmxsXn8hKREPfBqO9dO0yP7JJydVxN
	mqke3u5fNIto5nsd3G7Z6pSJOl7AUXsardB1KgPtM1nOiqy0eBN8y/bbs9+dXaUGw3lDl6MPmJb
	lqZYH9h28tTi8y5UpbCkWLFsTFoL/inxIIc2cvhSVp7kxU7RNN7oxIoRf4+OZXal8GuGkz4Z2ZH
	Sd1duZqTkJIEhUARAp2r/Gnb63OizruMw==
X-Received: by 2002:a05:600c:c176:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-48398a4267dmr37730425e9.1.1771423702109;
        Wed, 18 Feb 2026 06:08:22 -0800 (PST)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dfb4bd4sm536278225e9.7.2026.02.18.06.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 06:08:21 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH v2 1/2] config: add fedora41 and rocky8 workers for scarthgap
Date: Wed, 18 Feb 2026 15:07:29 +0100
Message-ID: <20260218140729.541081-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Feb 2026 14:08:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3255

From: Yoann Congal <yoann.congal@smile.fr>

Fedora 41 and Rocky 8 are claimed to be supported in the doc[0]. Enable
testing on those.

[0]: https://docs.yoctoproject.org/5.0.15/ref-manual/system-requirements.html#supported-linux-distributions

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
v1->v2: no change (just added patch 2/2)

 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 70f11a1..07dce84 100644
--- a/config.py
+++ b/config.py
@@ -191,7 +191,7 @@ workers_prev_releases = {
     "whinlatter" : ("alma8", "alma9", "debian11", "debian12", "debian13", "fedora39", "fedora40", "fedora41", "fedora42", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2204", "ubuntu2404", "ubuntu2504", "ubuntu2510", "perf-"),
     "walnascar" : ("alma8", "alma9", "debian11", "debian12", "fedora39", "fedora40", "fedora41", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "ubuntu2410", "perf-"),
     "styhead" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
-    "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
+    "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "fedora41", "opensuse154", "rocky8", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
     "nanbield" : ("alma8", "alma9", "debian11", "debian12", "fedora37", "fedora38", "opensuse153", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "perf-"),
     "mickledore" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),
     "langdale" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),

