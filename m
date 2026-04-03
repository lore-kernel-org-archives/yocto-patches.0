Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52216E7E351
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 09:03:12 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7943.1775206985861325290
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 02:03:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RKw3bsNP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48896199cbaso9060865e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775206984; x=1775811784; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVBxZ32oqb9MrJN6NRuL5DhJP+GY5zq9Wa2k7smGbu8=;
        b=RKw3bsNP3eVtVAjYVC00G2LWtL7UQT/MV2tquqZcsoaklOLFH5vaAt3sXPAvXsubME
         fHd9MtTfFjHBHWvBnndr5O0YkGF1LAAiv9xtR5dvztrOqZLiRlLGMfwiR1/Fyits7ZQj
         e3aAY8wy5lC1JSSDhzkjn0mM+gul5cW5RB8AA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775206984; x=1775811784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVBxZ32oqb9MrJN6NRuL5DhJP+GY5zq9Wa2k7smGbu8=;
        b=in/hcr6WnKVS/lFtTWzIysEVoAvqTvvT2VOdXNzwfdUqVMVwH/Q88HVu3WX+srJqhm
         xCZ9DDByDJ2dHy1tvpm3OBXorJSNVB/MyQCSDOgATaBkex313VBebSs2D7M8JnsxSIvD
         IEmB3Rtk8kwJG0ZrPU3HYRinYpryY8BVnU+Udr63qVyV0S0PTTQVaJE4WDCyrt89iMSE
         SA2oGFj/JLztv/3zMdNswoMtASLPvHd+Rw+xK6jyVcF3CYJRYreDXzq68JSCw3TVRtod
         viaFbTHTnhQU+hD5x4FxUlRNBkmWMPA/fN9VXuv0xEYgMEIUPDcOZXpdWoLn1Mw8beA3
         kmMw==
X-Gm-Message-State: AOJu0Yy9ysNpGP+bnofJIPJ5rTjVw4Jw9QuSbjaX5SDYRIH39THYtrUc
	V2RXTlpQOkqUz8XelUFXWzIRUwYHIblTsBLJF/sqwLc1wh2PctDV57JkZOS53fcGNXwv7nF4UEH
	Ooq+4
X-Gm-Gg: ATEYQzwmaPocholQLuDkuR6lMDrs0+y3eLEI+ZnFVpOheQVLeYh4fw4wSJ3eD014+ED
	eCcTH0ChnSHlbSiZSShC61cH16WdsqBWIBfdq7JB8zp/HantFsvGSXXk0ouBV0EQLj1Z6dOd2wc
	T5vaiX05XGbFsBLOHyd5Xq5RVo5kP3d4ZCZI1UpxDXWCjOU8ergl9fZRHer6prpI3hE0yRParh5
	IE6UB6BGr38Tg9eq/8eZ2N0QJoZvNDr6Q3W/fNevEA2GJRdvfHEmGU+21ShaPxCl+/m2Y6dVpQP
	mHNIhS+fOG+KcGJgb8Wjp2sXJZpa6aG5vQ4KpymKOTmmCXnv+8F2x3Ckk1J9YtFN5z0YBix0yEh
	9aK+nzDKpykAG/oOdUm2Xb8wrmjSs5Hyx2aIsv1CBBVEC/wGPRUO+DS8QWlw/9vPZdRq4mZbiRX
	KEUKlWRkcsLVMAVqAkvuUuGbjs4iemQFQMHGJDh5K5fdTwfLQDPoU=
X-Received: by 2002:a05:600c:1d1c:b0:488:8577:d9cc with SMTP id 5b1f17b1804b1-488997c83f8mr34825735e9.20.1775206983611;
        Fri, 03 Apr 2026 02:03:03 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d1f2:4cb0:580:188d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a7165aasm165674945e9.14.2026.04.03.02.03.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:03:03 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] workers: Add stram10-vk-1 and opensuse160-vk-2
Date: Fri,  3 Apr 2026 10:03:02 +0100
Message-ID: <20260403090302.700265-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 09:03:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3624

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.py b/config.py
index 86a6f5e0..a44fd1d4 100644
--- a/config.py
+++ b/config.py
@@ -178,14 +178,14 @@ workers_ubuntu = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubun
 workers_centos = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1", "alma9-vk-1", "alma9-vk-2", "stream9-vk-1", "rocky9-vk-1", "rocky9-vk-2", "rocky9-vk-3"]
 workers_fedora = ["fedora39-vk-1", "fedora39-vk-2", "fedora40-vk-1", "fedora40-vk-2", "fedora40-vk-3", "fedora40-vk-4", "fedora41-vk-1", "fedora42-vk-1", "fedora43-vk-1", "fedora43-vk-2"]
 workers_debian = ["debian11-vk-1", "debian11-vk-3", "debian12-vk-1", "debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9", "debian13-vk-1","debian13-vk-2"]
-workers_opensuse = ["opensuse155-vk-1", "opensuse155-vk-2", "opensuse156-vk-1"]
+workers_opensuse = ["opensuse155-vk-1", "opensuse155-vk-2", "opensuse156-vk-1", "opensuse160-vk-2"]
 
 workers = workers_ubuntu + workers_centos + workers_fedora + workers_debian + workers_opensuse
 
 workers_bringup = []
 # workers with wine on them for meta-mingw
 workers_wine = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
-workers_arm = ["debian13-vk-arm1", "ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"]
+workers_arm = ["debian13-vk-arm1", "stream10-vk-arm1", "ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"]
 workers_buildperf = ["perf-debian12-vk", "perf-alma8-vk"]
 # workers which don't need buildtools for AUH and are able to send email to mailing lists
 workers_auh = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1"]

