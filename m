Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC27E67801
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 16:52:33 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.84030.1766422345684497352
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Dec 2025 08:52:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lvXA3S+/;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88a347c424aso53618506d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 08:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1766422344; x=1767027144; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBSGjxK4Igj5n2FZcnCCrw5F3aULotH8gHYfO56XiW0=;
        b=lvXA3S+/I9B0VsremLvFtTILEnE5/Zy/PMbyHa7gKxRIpae3wnDmxt4oPwlhbd/itD
         +j61qPsanOH7aPkWi9Q6nXiRqDxCYvRxpHT/z5Qulb6cEBKd1/WKjZRyqMKa5rBdofmZ
         Z3fJKgkqHTSuOHigXXQVUpXqqNhUFzI0LQLZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422344; x=1767027144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBSGjxK4Igj5n2FZcnCCrw5F3aULotH8gHYfO56XiW0=;
        b=o7rxhs/fNeAvFd0la8uhQ/rXH5oGVVbBTHwNBqKmStG4PnhE9H+yLA/bR4FeH5iVOB
         injrrYWWrcdbO7YBBaf+rUqnuAH/Iy+6NvqMkAz4JH0pM+yKH10GSJPDm43GgeKAW2hD
         KOttJmPyJajNS6PxGbF1DjOVb9zpmpa6tb1nJ/J0yf/nHqqMhHK5WfVphOgtbw/rs3jb
         rhyEOZ4rAEtJXCb6VWCo1zO5LPMFr63Y/enwEPveMQPTPQGgSxMkukZHavQVYtrNH/Fz
         DIscm02JKXKB/Rr1GvcZ8L/T/LC+nAjUbNWNohIhKwFnYhk3d8XkiAnnM4/v8Ix2TYSe
         waYA==
X-Gm-Message-State: AOJu0YxNdpCPHL5aOmrZCs/uu0nsAFmG1fXNxSRkBnrO4QcjbpkgsgKJ
	5hIElaCYvOIdYc9Xat64Vd9gRGtq/FVQisfVsMrrSl+YOyBZDnKgQvSUd+vEA8RNoVUMuiDp7Sh
	Zy0Mw
X-Gm-Gg: AY/fxX5Bla2FpliWlR6SQubHJuXLu6Vy27WcyPIq+BJuQ5FohBohSkSvZfJTGk7r6hF
	PyrxiAGlfE7IFQ0m3c37WW973m+Vrcolqd17L+OxIPis64o7D1v+HP8ChrX85m7FqVSR/UjHhzT
	MK74wAvJJyHfJrZq61l5EZMoiTfFCMA/wFx7TvnbTumcbT0u3x/Phf7vfSwxpTR+k87evGBjvGv
	cARGdOBRqPG6/pw0NQ+CM7QnCnEilJHdj6rEg14OgNgIKfigxI+sU4kZZrVekDBC3ap6ZwAvuL+
	g2fG1raIrF1JV7t5KwCBcwEgnDM5GqGAllvQ1DycrAXaQQDV3eAALF9u0oC4FSVQC4vqePmCUVP
	Gmag7lsAFsETHO3ienIE2TPNjiWurxdROlQkHQGhDv6kXX1rUjuwZdGJcNyicouW3qIz2Mh7ZYs
	4kmby1YHfyLByu7avEiriVAJZpcjYj3ttdY/IhySajzk5ztrcOu8YuAY5M4EliKvZKsAMgrKqfR
	u+uJeFXEZwGLBKPUssbiIoL7azeuzolr/uWlqqIgNow9FIv/GIl
X-Google-Smtp-Source: AGHT+IEJt4hsX5sx/nVhu5/p+yYbI8xwsl65E7FPOSXJrFeSJ14ZVZfHmRORfCpk/tyEjRFNAUIYBA==
X-Received: by 2002:a0c:e9d0:0:b0:880:53da:fcd2 with SMTP id 6a1803df08f44-88d84432a34mr138240686d6.58.1766422344501;
        Mon, 22 Dec 2025 08:52:24 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fdfdsm87149726d6.5.2025.12.22.08.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:52:23 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][PATCH 6/8] scap-security-guide: update branch
Date: Mon, 22 Dec 2025 11:51:54 -0500
Message-ID: <fb1925ec167eec88d355d4d1a9172a55b1336290.1766420960.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766420960.git.scott.murray@konsulko.com>
References: <cover.1766420960.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:52:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2856

Switch back to the "stable" branch in SRC_URI now that upstream
has changed its branch maintenance model so it is indeed stable.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../scap-security-guide/scap-security-guide_0.1.78.bb           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
index 40a677f..919a09c 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
@@ -7,7 +7,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
 SRCREV = "f7d794851971087db77d4be8eeb716944a1aae21"
-SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=https \
+SRC_URI = "git://github.com/ComplianceAsCode/content.git;protocol=https;branch=stable \
            file://run_eval.sh \
            "
 
-- 
2.51.0


