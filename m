Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4C8C83F1A
	for <webhook@archiver.kernel.org>; Tue, 22 Jul 2025 13:58:43 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web11.13452.1753192714965814790
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Jul 2025 06:58:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Eb8Fz1zQ;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-700fee04941so53028586d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Jul 2025 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753192713; x=1753797513; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EQgylOPDnt0PuRuuPhLMFtBnKrdfu2WRSJEOPcvc92E=;
        b=Eb8Fz1zQjtGTRzKyfjzGsC1Pm/Ba5WhN5PSXaA9GPuEarZ8krQFhv4lM63RBHlJQD7
         aJAFZxiplU0X2llAjL1yYltefKe3k8GFHNgry/QhZV6CVbR/JELln/nxF3S8zGlMfFo+
         q0Q1/Lk9P5hAvez2v73KdzUbzuYU4m0G+5yqanZlVV2eARHReLa12ofmqe4S1WDxsgZp
         /V4yz89RrK5UBkoCRe5ozRCkY/BdZ0LtYTMkNO0SJt4h3WWUoRdHVqOSYnTHhnT+bunc
         ZALVbxvXUC1OAGdudHcd8FbCIot/nKcwfrufP1FWKaG2CwApI3vmPOVktj6AdnINiwSI
         vkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192713; x=1753797513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQgylOPDnt0PuRuuPhLMFtBnKrdfu2WRSJEOPcvc92E=;
        b=HZWURS+E/5Qcir1TOAsuI0Bn+M4ElJAttBhYDzB8AVVwg74S9J7Xar6P5aKhndSsY+
         aZ0XGPaxCL+8qhnVt0sRInVJ3+r2mAkNSwWBP8zdi6WjpWRZAWphEdkTnPEiIc71HUOj
         YeOsjIFPqVDNrL4aUXwORA74tLINeogxrLeSyrvxyYnLiCUE1T2hEIWhIb4hifadq+mJ
         jrzqvy5g+5Zb8DPbqTIZwCsSFStFnXVeipAwiRxpGW/F4IwRUU5sPtA+79HiUoAQDOdV
         FaCnc232YqqtVnjY1I6D36VVbdYrtje70xKcOSSBIRkrnr9cAn8+eWbgWu+CTBygYtAB
         kMZg==
X-Gm-Message-State: AOJu0Yzecm+MptdpzwiMfxazAjDvQiHvj0JkyLqdkonwYRFVQ9HT15T2
	ddYA5eZJ+sr1/i9C8oTEcwHSH5bJuLoLdDuuCTsOa/gGeYsGPz2w0vN4ZZrR6Q==
X-Gm-Gg: ASbGncvijCEJB43yhEy/Tv2JIMj7LXWDy/Nnt7r12JCUAGmluHNGphWg/FJnobcbqY7
	EaDzE0vxMZWcb5GQT1woeshVFvp3MDHI71XksqmCD8MWtmJFKB9hfDVQAppusxBzn204w2IYoN1
	29/bOjQShzOg+1cSQ9ck6COP9vpwdQtP0fY1YpXORinTd/l3BVzM0CVHyVn8ig96Y0q6jOVpCEz
	++vLI326YTJMLgkFecQk9kT66ApQIrvAs99jivIPwpeXbSjTmFCuoCrDoOzX8AvFn9L6lpX0m9d
	NtywcaqbcdkG8llDMNMRDCZ/v9J8zXOewGcEJSPgc4hxgqGX/r8brNbhW4pah3mUnHsV2xP/AG+
	7rrEoMbZAHnD+AXSMwJzrYfw76ae54kpyeHLVZh+maEdj6l9FLDXiMR+wYf6ECrs1wQ==
X-Google-Smtp-Source: AGHT+IG7pwD/x880jCpqnC88/hj5Kc00zprO1lekDVmHdmzJVFnDOC6XK0CtTwhzezhblM7UqGjfpg==
X-Received: by 2002:a05:6214:5c44:b0:704:7dbd:d991 with SMTP id 6a1803df08f44-705073a31b4mr346580336d6.31.1753192713197;
        Tue, 22 Jul 2025 06:58:33 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba92059sm51956586d6.83.2025.07.22.06.58.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 06:58:31 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] systemd: repart requires fdisk explicitly
Date: Tue, 22 Jul 2025 09:58:29 -0400
Message-ID: <20250722135829.25568-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 22 Jul 2025 13:58:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1821

According to [1], upstream meson's default configuration policy defaulted
to "auto", meaning that it would search as far and wide as it could
to find things like libraries and header files when deciding which
options to enable during configuration. Apparently that is no longer the
case, therefore new PACKAGECONFIG options have been added to systemd to
explicitly ask for some features.

systemd's repart mechanism needs fdisk, which was probably being found and
used implicitly before, but now needs to be enabled explicitly.

[1] oe-core: 4ec67113e1e7 ("systemd: add libblkid and libfdisk PACKAGECONFIG options")

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../rk-rauc-demo/recipes-core/systemd/systemd_%.bbappend        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/systemd_%.bbappend b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/systemd_%.bbappend
index cf6c188277db..ee4134d2e64d 100644
--- a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/systemd_%.bbappend
+++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/systemd_%.bbappend
@@ -1,3 +1,3 @@
 inherit rk-rauc-demo-features-check
 
-PACKAGECONFIG:append:rk-rauc-demo = " repart openssl"
+PACKAGECONFIG:append:rk-rauc-demo = " repart openssl fdisk"
-- 
2.44.0.501.g19981daefd7c


