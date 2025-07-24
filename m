Return-Path: <raitosyo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1CEC83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 08:55:22 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.8037.1753347312837274948
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 01:55:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=THh5cDah;
 spf=pass (domain: gmail.com, ip: 209.85.210.180, mailfrom: raitosyo@gmail.com)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74af4af04fdso1406562b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 01:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753347312; x=1753952112; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6bRA8lvX6CKCO+9fp1DPfk7BpePkMYqUubWX7MeFr0=;
        b=THh5cDahwSiS23o7Caie8afVSoViePJIRFqL3PSzJAqN4WVPVPFUqeosASGwC1i9uW
         ZI3eCzDDgQpVk6ncsWoJoYogjbiv7ZAtCrxIn4Z2Hl6q40BooRWinOsJLyLqF18wxIXq
         pnGnB+2amG7UtsS549+fg5uD/tfMgF4uBjSOlbjmQTiqOPiS2nZfBJMzouE4kXa+c+ok
         frE3SfMqS+o8hLL7Z2Z1Y5m6Tmz4cl5Qy6m4rYUWnBZiAvg4jrdo3p+hBKJwaFXEbyM1
         bp0GbBc4rZwxktpPUua3RZliVuUpmoPh9UnvANqgvqyFXFYgSI6wuH+QSmF/GzWTfl21
         wtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753347312; x=1753952112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6bRA8lvX6CKCO+9fp1DPfk7BpePkMYqUubWX7MeFr0=;
        b=dvShghG6Y4k/Fq5I5vsEh2JTozUUQDhGud7ghWFm2zAy2Kb1yX4zJeV5A6Oru5b858
         IvBvTQBdgRVxP+qoRseDN8FbQMN/FSOfpZbqjQzLpcm0i7h2fuhEi99e3CvQ+NmMrlzP
         n+5E60H75CoPGH3+TZ9fEPUbh9FiD6KvRKttCJplSeM9OnYb/HB96mY7ZjGPKzGMLqbW
         PZfCY2u0bX07/hwn+sD/svrnvgQXhlYhfbD7B+axB/sC9Q0jFXoWDvyJiWzk2stFXxj1
         Hvq1Ffp8QZX7moTkCPmDySxPk8KgusPOOknKuWWk6DWdfxWqOQsN8RDnDfRxhTG2bsOf
         9U4g==
X-Gm-Message-State: AOJu0YzCYqELbAa5ac6XkE67lUABCx0w7E1xYckXIXl1wlQ458YEAs1N
	YfSwe8T6xmo6bMSvHnf4SZAAl2cmT/VG8JB64/4cKxBYEVt/7EydRbwQxh+p4A==
X-Gm-Gg: ASbGnctXZPgr5wSWgCtyirTz6ox+8Ly7sHDfVJNQEWcNbF8xT1ljS3yfXC4/FQHaiSg
	MAWefKq8gfps2qnxm/B65A+dkHvsEmniJRAgSUjOIBlUN3l+l00NLHmgqeD8sUC81FTB98/GC7c
	PXPR3uKJuDJTzm/pr+Djzjad8O9emia8aFsOYhht9jeGEup+0Z3sBLdsUPFUPrzigbfrgFZ5sKD
	kSFTD0Is99ZA5vMxMF3t77o0EITyN9d6Q3Zq+idnm0IUim6mjd5TFZJO2NRpQHSycR2CqcPxFru
	Wv9PopKI1mKKDPZA1n+FI8elavwwgrOiSm4w0C3UE55BQouK09pn5rHPydvZxrPsmWzlyGWq6NY
	OuVwWNBDA0YFwC68=
X-Google-Smtp-Source: AGHT+IFuC6k/TBnjfCnJad6q2ghvk+xkLWnMRcGfbIM+Nla7SIvAy7JprlP70NCTbNRXQMyExMOcXQ==
X-Received: by 2002:a17:902:fc4e:b0:236:4d78:d528 with SMTP id d9443c01a7336-23fa5cf9bdfmr17277845ad.6.1753347311972;
        Thu, 24 Jul 2025 01:55:11 -0700 (PDT)
Received: from fedora ([240d:1a:3a7:a400:9a57:aa11:487a:b54f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476f48dsm10665135ad.70.2025.07.24.01.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:55:11 -0700 (PDT)
From: Ryosuke Saito <raitosyo@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: ryosuke.saito@linaro.org
Subject: [meta-cgl][PATCH] ocfs2-tools: Fix autoreconf error
Date: Thu, 24 Jul 2025 17:55:03 +0900
Message-ID: <20250724085503.116641-1-raitosyo@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 08:55:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1865

From: Ryosuke Saito <ryosuke.saito@linaro.org>

Add autoreconf macro search path or the errors are displayed:

  | configure.in:419: error: possibly undefined macro: AM_CHECK_PYTHON_HEADERS
  |       If this token and others are legitimate, please use m4_pattern_allow.
  |       See the Autoconf documentation.

Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
---
 meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
index 03a1333409aa..62479e515602 100644
--- a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
+++ b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
@@ -53,6 +53,8 @@ EXTRA_OECONF = " \
     --with-root-prefix=${root_prefix} \
 "
 
+EXTRA_AUTORECONF += "-I ."
+
 do_configure:prepend () {
         # fix here or EXTRA_OECONF
         sed -i -e '/^PYTHON_INCLUDES="-I/c\
-- 
2.50.0


