Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C5CCD343F
	for <webhook@archiver.kernel.org>; Fri, 15 May 2026 05:44:45 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28885.1778823881131218171
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 May 2026 22:44:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=hwv/fr7o;
 spf=pass (domain: gmail.com, ip: 209.85.215.178, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8095d7d75bso3742195a12.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 14 May 2026 22:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778823880; x=1779428680; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fFjsH1jB/Kk6GZC6KsZH4YvOfMyEF6qnKVf6RSPLbXY=;
        b=hwv/fr7oFvBPpnqBNt/BOf4RkiFSJqX4YcNWQthtTnysaOfxjiTz5a0is5rC7l199F
         0PFqeSt8JAH+SPzsBuOdHPAzEOLvFkQdE7PLhiJADx8JBkjkCa9q0nWBxqEiH+bO7poM
         lF6y92oumVBGmksCn+Mo4Gsbs0KdNPaAD8XTJSlNqaMiDhru63X3eDFDMYHL7XrHdhuH
         umw4l0lPbVXaWIl2UDjJqMtUu31MiwkWgbCa4jpkhhGcIJoQRk0eJERVGENEYb+lO9La
         9yVq/Xei/zeUJ8If9RvmAZ4x3PGMQSBZQ2XLSIk0RRq/nF9RikJldWEKLedjWME9qNnu
         BEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778823880; x=1779428680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFjsH1jB/Kk6GZC6KsZH4YvOfMyEF6qnKVf6RSPLbXY=;
        b=d1ISuJE+nS6CV83GvOcMXvAIZlrx8Dir70CSO5I0tY5sYNpuSElwKH9sI8/zJ1Je9B
         0zjaorFCFaVkgGe43/Qg6a4HII3ARUFaO97cKT7l8gcX/Maq2ZbcTR7sjKPk7Cdg96Gb
         2xs4iccanaeKPjlpe+PP9ryGzVFLOuB+S22v1/t3kEkgiDBAwqqkTffX+awdUqBcy92t
         7swYrj9yv4VNGgO4UGOD65q5PF34sk2Qwvzjpyqbu79RVA8NciFUg6Yl5G4MVyAUSfJD
         A1SUZpaDjt7lGLPKBnG9GnO9KtR/7AIDN+Dswg49j5BXGq0nhdO6RUwI/qBaODf5SWgh
         eagA==
X-Gm-Message-State: AOJu0Yw39xsalBfiTcVH0ZE7hIeRTktoipYMyRg2SCsmLBLPX/O2vpma
	Ez9ZRs3/QWtIrRDnPCRN7qIX1gEQzTz3qiR6D0UnFhsa1oec9bbKDHxkVJVmd40h
X-Gm-Gg: Acq92OGluwLoPGVxmisGNSFnAvftWWf3PJL4k5uekKGqfuOMTGc9x0xei80tvgDvqiL
	Yvg7YMG3s69joy2Iv9COJU4+xHKoU27KyP0RrtSPp4h5TB8Jba56tRDizzLGENY1crTgT6Xe4LL
	f6Wx3n8gfgHBAgIPmAA15cRqyx5XLnnZTvGPrM2f6fvI28VjGiJCHWdTq7u/YVuHv2Fba+FkVN3
	1RCIYJeqO/Rw3+FXBdAEU9+SRJ6CqjPf5ilPgYhPugu9RmIu39IFm4QV7WWYtqzCt6+q/KO/vKk
	b7lycGMxvUIo5tX2nBzeircwGEtr875CWzyU3wWjmW6OiquCTalZ4QvbX78qlmThxQMayAlGpvk
	nN9eZoVxyBEzGqnfSOGcMxkVixyHtSIhCjCP7FGdstVyoxBeiUT80KpqTSfCzGGn8/jWt8zEPRy
	WwN8FpF2TdUrcl4MLaCzhw2+Z84g==
X-Received: by 2002:a05:6a20:2454:b0:398:d82c:ae6 with SMTP id adf61e73a8af0-3b22ecf56e7mr2520974637.31.1778823880185;
        Thu, 14 May 2026 22:44:40 -0700 (PDT)
Received: from LL-868L.kpit.com ([49.206.134.86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb121cd6sm4321910a12.30.2026.05.14.22.44.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 22:44:39 -0700 (PDT)
From: Jackson James <jackson.james9803@gmail.com>
X-Google-Original-From: Jackson James <jacksonj2@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH] cargo: set CVE_PRODUCT
Date: Fri, 15 May 2026 11:14:23 +0530
Message-Id: <20260515054423.496349-1-jacksonj2@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 May 2026 05:44:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3994

This removes mediawiki:cargo CVEs from CVE metrics.
* CVE-2026-39837, CVE-2026-39839, CVE-2026-39840, CVE-2026-39841

Reference: [https://git.openembedded.org/openembedded-core/commit/?id=a5cb71e7df95925a5c342c341e699e244b1b84f6]

Signed-off-by: Jackson James <jacksonj2@kpit.com>
---
 recipes-devtools/rust/cargo_1.75.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/cargo_1.75.0.bb b/recipes-devtools/rust/cargo_1.75.0.bb
index 50b7e7c..309ce0a 100644
--- a/recipes-devtools/rust/cargo_1.75.0.bb
+++ b/recipes-devtools/rust/cargo_1.75.0.bb
@@ -17,6 +17,8 @@ require rust-snapshot.inc
 S = "${RUSTSRC}/src/tools/cargo"
 CARGO_VENDORING_DIRECTORY = "${RUSTSRC}/vendor"
 
+CVE_PRODUCT = "rust-lang:cargo"
+
 inherit cargo pkgconfig
 
 DEBUG_PREFIX_MAP += "-fdebug-prefix-map=${RUSTSRC}/vendor=${TARGET_DBGSRC_DIR}"
-- 
2.34.1


