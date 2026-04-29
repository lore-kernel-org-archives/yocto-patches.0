Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466FFCD3426
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 15:40:22 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14378.1777477220814222390
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 08:40:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gXXGRcGH;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8eae9229110so145958485a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777477220; x=1778082020; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DC4EW16OUJf3E2Qs66D/ZWHtdpgMgfGalKUToBX+pgE=;
        b=gXXGRcGHUzsJbQ8+0/kAQe2/L9jPbj1PFKJLebWG2FZBJ4x4VfLjx+XDaWz24nATab
         2R1Unf4wmd7B5Ojgdu4IMmhZeFmoBzxtckH3ymXW1HZQDIR18E98fENSYnGJOxl6lvgx
         QWd+JT4oOOO+mfMNORysRBLsEuGLDnTKxg5us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477220; x=1778082020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DC4EW16OUJf3E2Qs66D/ZWHtdpgMgfGalKUToBX+pgE=;
        b=Kq7+H87CxG3ZvAK+TlVZFlGJ6RYwJrUU+btx/w9wwMNlLBr9mxmw6NfcrWMryXsQzf
         Bz6G4Go5+5LRXy5ibR7ffh+BJeGW3DYS1QogwPOQo2C4BQSj+UrW4dSKh1pT6xtLhG5v
         akQ83t3yLkjtfbyqvNO1x64ggzGdyfr8f57+9guemtTbxragkgZQPTd4L0gN68hf/Z17
         EamhJsG36SLuurNfGmayP4ILzneR/eeCrk4XpBb3DN+khs7HYDuRo1EikFIzsRkRuKDz
         VrM8l9sK2UT3P2TtEa07vj0bVDqXxUoCJzk2S+RcBi60CmAs38sBXge0OwDd8Ztq7Bde
         PtjA==
X-Gm-Message-State: AOJu0YyD1TQzF3ZUzwIt65S69t7hj8EQSLSbdOfFwcduCasaElUjEBRv
	vIk5dxxuY7xJs7Kq0wrdjigUeLU7GiPBNOkFOKIYog4sOeafv/ZIF2nQaYws4AzsyTg7sD9Vm6g
	5Ac3s
X-Gm-Gg: AeBDieuzf9Vovzq0O6PVx34Nm8U2Ne67vtFZ8uGPD7VXBZRoNROM8bebMkz+ZvkIZmP
	YnqdHbI2dDAiRE9rjjlmIeBui+NXYVgJuI/RqELz5yTiEVHf9XWxT7XY/eCfUdU3trLpIDgRgPu
	5oyCV0JsyVKmGLmWtuIMwtkDpzJ6Gf5DFZPR6BhQ+7jJpvnfortfsfGgvMW3ZCXj8W6pxHByjkR
	u7KKYJJmDxXImGTDmz/Wqe9wh3fPlg1ICxAvFSZ028Ww1BAPN7O7T3XIcJ7bcYXOxsZhI6TsskS
	5ioSfzM+H/X40g00NJJa1u7fNXje2zx/2+cN5XjuK8PiECSehNJoCzUu59mM6/3/9+tRCo/OX1y
	+R7wITj/C/UW48yGT0jenIuQ71HmOCywsSohM+6KqDuJzVTUoP3gXOsgGsD04JFjsCJ+6btnIhU
	nhuwAjYWKBoFDsUBfzr7lPk5VXkl+JP0LLiYC2FqK28IdXh7OdKiczaAVyaJMMJtKfQECcuORSz
	cNDT8YbDKoluxv3gprA7s9Qrij9v6OMFcql6haenYEo6vqgK2WPXmcRaW8bshJBZmg4FFV9Pus=
X-Received: by 2002:a05:620a:2953:b0:8cd:b44d:b1c0 with SMTP id af79cd13be357-8f7d990313bmr1115496585a.53.1777477219667;
        Wed, 29 Apr 2026 08:40:19 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940340f1csm207924185a.44.2026.04.29.08.40.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:40:19 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 13/13] README: update CI links
Date: Wed, 29 Apr 2026 11:39:43 -0400
Message-ID: <9265f142f3890df2d00d71d13b19e95a082707ed.1777476608.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777476608.git.scott.murray@konsulko.com>
References: <cover.1777476608.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 15:40:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3887

From: Marta Rybczynska <rybczynska@gmail.com>

Update CI links for meta-security

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 README.md | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/README.md b/README.md
index dae5aad..c92d3f2 100644
--- a/README.md
+++ b/README.md
@@ -1,7 +1,5 @@
-Master-next: 
-[![pipeline status](https://gitlab.com/akuster/meta-security/badges/master-next/pipeline.svg)](https://gitlab.com/akuster/meta-security/-/commits/master-next)
-
-Master: [![pipeline status](https://gitlab.com/akuster/meta-security/badges/master/pipeline.svg)](https://gitlab.com/akuster/meta-security/-/commits/master)
+Master-next: [pipeline status](https://gitlab.com/ygreky/meta-security/-/pipelines)
+Master: [pipeline status](https://gitlab.com/ygreky/meta-security/-/pipelines)
 
 Meta-security
 =============
-- 
2.53.0


