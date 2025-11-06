Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B8CCCFA05
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 21:58:22 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9737.1762466299288446067
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Nov 2025 13:58:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Wh+iR5sK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.214.179, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2953e415b27so853815ad.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Nov 2025 13:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762466298; x=1763071098; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbt8rj0FJbJzai6DQIO5JApaKaFWKhWfZ4IahL8Pesw=;
        b=Wh+iR5sKxK84RhbboZi1/9vzwj3Tzzs3+3NiSTI7f+8A9/VhKyjhI2CK46A/6owvGg
         yhcZ1OWMzKUth57ncXiGHWWbdHzbcxaMyVQ4Lsrosl1ag5gNP6ZpGanxlFqe++n6h8Eb
         GtZLv92E878nm9pa2nw6JcboY6FuCLblgAlRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762466298; x=1763071098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tbt8rj0FJbJzai6DQIO5JApaKaFWKhWfZ4IahL8Pesw=;
        b=j6HPTSYTWucEfCDOdDqND3k2ZUiNQCahnYHePiq3x8on+SDJ3bkEF8YwEEzsv/Cl7w
         4bVJIqM7Gp1cLXJOEg0lpRw1blHrzBkC3vBIbklcwcuNJOTbWl0eGLYB3MSZetjmDzGc
         /kRRTrucdgwASSkHzvz9JWNi0Zoe2dI3xhCQcWgvfY6WQLsf/tn80sqFTfCfHGfE6rKm
         eF+xhAKaOD5gxgVN3CeEhsrHxi1isl9tPvwQBvjsjGWO/J0CaIbD/vlVum4X4tsyIvzM
         ls2n3ntKRNMfy5+YYkiZ61mmUjFlJKXJrlVMNKtplInBI2ppw+HybA6M3cFt1sPvv4KX
         UBMQ==
X-Gm-Message-State: AOJu0Yy1niFjkx+zK03j+dWNdkJXTfD0Zy+z93YksxGaeXPQYwGCxPv1
	sExPSNDkY1Z4RxdF7bMpYUKuwWHaP1+Hx2oygyw0vdIhocNH6XM/9wHgAaYX+ra3tWG0g5vgBRq
	cYQLh
X-Gm-Gg: ASbGncvWVhFmYoCNSPvp3Hz0xipHdVBvoL756ieLaQv+taiGDGzRxX95xbg3usQMZjr
	uS1vP4VmmW63S6NaBqOidT3+93/FNZw+TnwPLINOvde4CJ5GsSA0//CdAdRhiFL9mNPL71nn1Aa
	Ym4l9ycU5IIlyjzLo9BMfKPqhshPAmr9vqwYAL2dGwhf8szZO+MhyMAwKjzxUUzJzaL9Q2IAcSI
	rgk+lA75lrXXMpJ1qDQpzMrZHo5DncKG9Xm8PY1UvIPB6NjND5OUPHq5EJ6GSENWE60x6Xj/JTD
	YEdoZEdq/dUIkp1fwPCLFvJrmVeWmWxSV7396cRErRzmAxBN6HBLgP3hPU6titG90FcTmEMiy8b
	CG9072zIUna+6ZuwANomBjKsTjmZ9JhP3H5NOUPvot6QPbbrsmNIPWpgSk1LPDILO5+Q21MXJ/1
	weBZoRXZfanIMOZrjtCmBkueD9qLDFfvqZQB546jmCinxryIQasTmVw57RLz5Cu07jPKRo25iiW
	o+H9w==
X-Google-Smtp-Source: AGHT+IE/qMHuAljrPWKdTDR0Fr2wEf8mD+1cd9dnODD8aD0FxEQ7MJdDCjDqPc+vnzoB/GHXi2zRYQ==
X-Received: by 2002:a17:902:da48:b0:27d:6f49:febc with SMTP id d9443c01a7336-297c038c617mr13330885ad.1.1762466297757;
        Thu, 06 Nov 2025 13:58:17 -0800 (PST)
Received: from yoctolap.taild15c8.ts.net (static-23-234-80-56.cust.tzulo.com. [23.234.80.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1b8csm39464035ad.85.2025.11.06.13.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 13:58:16 -0800 (PST)
From: Michael Halstead <mhalstead@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Ryan Day <rday@linuxfoundation.org>
Subject: [yocto-autobuilder2] config: add second debian13 worker
Date: Thu,  6 Nov 2025 13:58:00 -0800
Message-ID: <20251106215759.61976-3-mhalstead@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106215759.61976-2-mhalstead@linuxfoundation.org>
References: <20251106215759.61976-2-mhalstead@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Nov 2025 21:58:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2427

From: Ryan Day <rday@linuxfoundation.org>

---
 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index a3c7dc1..2dd36d9 100644
--- a/config.py
+++ b/config.py
@@ -165,7 +165,7 @@ web_port = 8010
 workers_ubuntu = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1", "ubuntu2510-vk-1"]
 workers_centos = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1", "alma9-vk-1", "alma9-vk-2", "stream9-vk-1", "rocky9-vk-1", "rocky9-vk-2", "rocky9-vk-3"]
 workers_fedora = ["fedora39-vk-1", "fedora39-vk-2", "fedora40-vk-1", "fedora40-vk-2", "fedora40-vk-3", "fedora40-vk-4", "fedora41-vk-1", "fedora42-vk-1"]
-workers_debian = ["debian11-vk-1", "debian11-vk-2", "debian11-vk-3", "debian12-vk-1", "debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9", "debian13-vk-1"]
+workers_debian = ["debian11-vk-1", "debian11-vk-3", "debian12-vk-1", "debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9", "debian13-vk-1","debian13-vk-2"]
 workers_opensuse = ["opensuse155-vk-1", "opensuse155-vk-2", "opensuse156-vk-1"]
 
 workers = workers_ubuntu + workers_centos + workers_fedora + workers_debian + workers_opensuse
-- 
2.51.1


