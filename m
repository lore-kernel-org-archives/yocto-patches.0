Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341FBE9A047
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 13:42:42 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12103.1771422157529279662
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Feb 2026 05:42:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Q581HhQV;
 spf=pass (domain: smile.fr, ip: 209.85.221.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4327790c4e9so3956151f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Feb 2026 05:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1771422156; x=1772026956; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TRSegcPCpp4LwYIU/lTX8gBKI//jvhem9W0LGqwE1c=;
        b=Q581HhQVKsOOzAxe9pkTF8Vl5Oj9c+4rESYDWT4etEX7nnTzjTGF7ygs0f4RrAcCsg
         e3tTI3BFP4eYvMpU3Iz3EiFd7ZJXGTIk4FFUHQFLFr9z9tWQrnjKyhMMEW9OXTmsBuoo
         as6Pz9gfWOaiIdVslL0QcZbzxF1DG9xyMDCaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771422156; x=1772026956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TRSegcPCpp4LwYIU/lTX8gBKI//jvhem9W0LGqwE1c=;
        b=EgrpmAUbHnKVenqL7cIdI4vpvjVziBKSTAX8K8O3btlrTpcJklcmBpDzVGzaNW0CDZ
         O3qETvPMANCpgwCiQnpdI50Y5aIcz5q+I5PpA+4ryYtGYyL2kmcrcT7W+zEi2gXhsMg8
         ZBTH7knYVDyZjqpdLHo+8exexlrcF1eev0NgyQBtfhWMCuTp+lpdWxP0lhK5p6p+L627
         gndC8QCIbIh2qlJL8RDJtCKXxnTjJAjRr2bdQmTz57ba4ccr4u1FwQqT1bhKJkkm269N
         c/jP0yQzkYHNTNwVX/6vjMeIgsKxrWrSk47NioYLuWO9l4r4/U7yAf/xZbksI4vDz1jy
         S6rA==
X-Gm-Message-State: AOJu0YxCFh0qaI4ROf5x3tmkAFhlnd2UbbUzkZ6YV5tYDjeSq+0P/QBg
	hsNQQvzukJ1Sef4A/LUvawQJ4YbjJ+OcQkRLDoCaSG6d+z7Y/8CREVJfsQ07+fWrzbxwj2I7rA6
	HcVVx
X-Gm-Gg: AZuq6aJi4KbQIEVv0erLmZR3736XQZhqvEGs4Vljpa3o0ySqybs7lADwmpYmp3aTqea
	FfW/VRIutd4dU1az88XTpkI4V2/FAC1jEBLoN9Sh8pCF2GSNsu+K3BlZqXBRRh5E8U0Ws0W/KTg
	do2AOMGzW9R2wy2xypvi5lqtPtsVJT23pnr7xoXykyd/uPi1A2KMs5sGYsdR4ah1sje/IvUMHKf
	xHFdmBG1FHzpIl1YLbxRkE1VMc1fVNZx4xbfHdE6/dXsdjlKoa+L8m+LD390KFocgNAbcHQRgiF
	3y+BmoQJOZOVQPN9VB+MmTG3LdRYu/A4oMqMIaYtF3ulLaVV7M7cnuYogMY1xP8w7OVw4Yr3XIg
	b1Ev8majbLwpz8/GMRQkc6K5qcaYvBJq3tLUrANM/lVD91BNuhN+5LfArXiVlCfWzdP9s1a5Drz
	twDh8J4nli0+kjUy86pv+3z6XNPWN+WDsgn4YPHvkC5nc8vNgZtJttWugthT7xDnB1v5tiiOTYC
	hfYxreuIaWey0uHzjrxW0wL5op+C0CR0VkBZute5M/7
X-Received: by 2002:a5d:5848:0:b0:436:3155:43e4 with SMTP id ffacd0b85a97d-43796afacffmr30245010f8f.51.1771422155601;
        Wed, 18 Feb 2026 05:42:35 -0800 (PST)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-437969fd36dsm44081345f8f.0.2026.02.18.05.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 05:42:35 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH] config: add fedora41 and rocky8 workers for scarthgap
Date: Wed, 18 Feb 2026 14:42:22 +0100
Message-ID: <20260218134221.538641-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Feb 2026 13:42:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3254

From: Yoann Congal <yoann.congal@smile.fr>

Fedora 41 and Rocky 8 are claimed to be supported in the doc[0]. Enable
testing on those.

[0]: https://docs.yoctoproject.org/5.0.15/ref-manual/system-requirements.html#supported-linux-distributions

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
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

