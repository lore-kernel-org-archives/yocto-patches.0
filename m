Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B5EE67807
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 16:52:33 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83950.1766422344457521182
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Dec 2025 08:52:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=tgWF/cYh;
 spf=pass (domain: konsulko.com, ip: 209.85.219.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8888a1c50e8so52315346d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 08:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1766422343; x=1767027143; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwPUej0eSGRaBER1ZMd3qx5JpmDrJ1DMAzfMBDAoVsk=;
        b=tgWF/cYhxilzzDMswZpGJA2kD9xURIC/lbFrDleBm5D0JKaD6LYYIDEZPB+hcBBM7j
         7v3J2oo6ZhbVIOHmZWzeFMSxt3T9D8hC8dX1HzzTUznn08tZLBIwlDSVPQHLGLifrSao
         9McGsTdRlknIJ4N3AQMUH/3tcttAYiGovFKY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422343; x=1767027143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MwPUej0eSGRaBER1ZMd3qx5JpmDrJ1DMAzfMBDAoVsk=;
        b=nPrfuPhel0MjtuF9H5dKIlYdeTpLTRidVEPaMWNWEbBMfIMCom//smyo6pxrSAwRhF
         7NAsHKQ5tao8q5mQ7zZr9iHpFHdfzpBgH0A4Qjwy2m++M3T0WaczQcMHIGVoJbFXQJKT
         LoKkzJZpKtSA9/D/QetPz/KGMGdi//tb3kdrIAv4l1Z3FxrUsUxwYXJBECw7nQ9/Zn2v
         hldt53At3OZ1VIjAE1pPpOuhLYlgc+67PTXV+pKeTSK3xF+K1/onw6FU4luCtK2B6MLX
         VMuYIYYJ7W+eaIqqYNd4G78gIWgTBc7FVFopTrRm+GAyKAjNZO+xHp1tLiubYdZGYkXY
         uhuQ==
X-Gm-Message-State: AOJu0YzZuXaXvwfiCbSb9WSBoQ5/mq6A93GKez6VEMq6++nhVAnC1XlZ
	rsB7J3eb2D9+QRRcYzgyeIX+SmFATaU9pLu9mRRDSXeznsQvwEpH1gYcZLvLso5r5eRieyjnNvF
	I8UXR
X-Gm-Gg: AY/fxX64Hji4GpM6ZeQa0lJlanYPd+qidzEHVK3hS52mv8iTcFgedIGL27kxHWHlDV5
	stfKKgTl3M/UiUH83oNlH4ERl5SY2w7Q1TylQZdk4++WaEG0ks0tS2fgnUu37tsL+H+696ns4+Q
	ePwBkgoQe/QE3spOOvEbF5ZfWZstJuV2yD0tEktVtEB2t5nq0/ACUdBtIdZGGqurf2j0E9VZvf5
	XudJhgTIIDMBve5AVmnQTCP+xTZpGCGHx0haYU/qGLpz/aw9GYISmZhNH4wZL0RAQaJC7v1YeRY
	Pm11Lflb/hNrz23MRh5nQf8YS1IoWatcQk1d7YTOSLNaMzKTo83YcPcF0TRlLOPEsBpPrejbFYJ
	ktomUwbXlN71f+rkEj12n0VhCah7I1Shb++WQPHvMiWlW+QOm4dK0LBWPxX2EMbo94cOm7CAcxi
	SB8CV91P0CmmaUTxbxpEXQNZcqdaX9Q1nVJfwMWHi1EU8r7+oB2vAaLQYAvaU0A8vzC0FRBrGCg
	fvHbOdhW06tKB0UOIgeuBaLiC1Xry+OWWKEQq6eBNJtc/8M4HYa
X-Google-Smtp-Source: AGHT+IGxTsKyIv9Emc3zkOuEbKq2r17/VG3oCwfrBqZf2/5BxGmVRCe4/ARzl/5N5gDGdC7x69BQeA==
X-Received: by 2002:a05:6214:c8b:b0:88e:c542:f871 with SMTP id 6a1803df08f44-88ec542f937mr134613026d6.3.1766422343087;
        Mon, 22 Dec 2025 08:52:23 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fdfdsm87149726d6.5.2025.12.22.08.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:52:22 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][PATCH 5/8] scap-security-guide: add UPSTREAM_CHECK_GITTAGREGEX
Date: Mon, 22 Dec 2025 11:51:53 -0500
Message-ID: <a2018964320d084cfa6f8fcfa2809d534c030531.1766420960.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766420960.git.scott.murray@konsulko.com>
References: <cover.1766420960.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:52:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2855

From: Yi Zhao <yi.zhao@eng.windriver.com>

Add UPSTREAM_CHECK_GITTAGREGEX to check the correct latest stable
verison.

Before the patch:
$ devtool latest-version scap-security-guide
INFO: Current version: 0.1.78
INFO: Latest version: 0.5.0
INFO: Latest version's commit: b0a1b1c3db40f5fe8610c43cbc391bde92cc78b6

After the patch:
$ devtool latest-version scap-security-guide
INFO: Current version: 0.1.78
INFO: Latest version: 0.1.78
INFO: Latest version's commit: f7d794851971087db77d4be8eeb716944a1aae21

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../scap-security-guide/scap-security-guide_0.1.78.bb            | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
index 8489218..40a677f 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
@@ -11,6 +11,7 @@ SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=htt
            file://run_eval.sh \
            "
 
+UPSTREAM_CHECK_GITTAGREGEX = "v(?P<pver>\d+(\.\d+)+)$"
 
 DEPENDS = "openscap-native python3-pyyaml-native python3-jinja2-native libxml2-native expat-native coreutils-native"
 
-- 
2.51.0


