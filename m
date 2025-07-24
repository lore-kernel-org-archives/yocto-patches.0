Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15ACC83F1A
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 07:27:21 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.6917.1753342038956741329
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 00:27:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i6wAgrlh;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: rybczynska@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ab112dea41so357479f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 00:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753342037; x=1753946837; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfCqZVP13wfx5T3ft9xNQXpigDpi2Kz9ST8JEERYcow=;
        b=i6wAgrlhhXyypO6ZaGHyVaBHwW1lbjSa2WrdPRqt0T+hCEIIprSs50iRB5ca+K9NZP
         kPbPdSVogP14W+BQWNQPuLaUKtnlW7XB0WNEn98g6k+qLj7QP9A+QBynTgLJhOLVjRDX
         oHkW7Wmwc4zCUNYc1SDKeATvwssDrcj88sSUns+xIYXo9v1NrxOb8fqUxhvDdNaBzuo1
         2sJ5G8RhmsxrX23IRYfJGL74IURbt1oISMgpygSvM72KUQm9Ons4uFBHyIx1PygqHM80
         l0bPvwS0r23za3FN8SP3zgxIXDgxOMK9LIy7JFJpV5SooXEtDGI+ZA7bfUpNs3v45TTY
         /MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753342037; x=1753946837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfCqZVP13wfx5T3ft9xNQXpigDpi2Kz9ST8JEERYcow=;
        b=M2+khbaLCHCtxE1t+w0pk3t2Vs7a4yNB1rc0W8ntzq8eMbKMxv3ds42rMp6XKhYgYE
         gFFDTCBEOE9pDNvod/qHa6iTKzEiXQyGrJzkhBYwofd1ahYM8jM+zbRrfmRk0XftgbRm
         QsgZkCrv300M1vnVKFnJLm2ltxKOvPM4xQJKQj7FbCbCmwHfQx8lqRubnT85e2Njr3Ck
         EdZugDthI8+vIBRlHpCnS7nUEXfZjlYVzJP+4+Bk/3w0PVvvMc85jwf1FyuCNmkSgUk6
         XEp29U+ofUP6ES1Nsjm84Wos7zFajh84mKC4WhyXhvpK3odxlxkq3puDZmTtW+GP+dDp
         gDTg==
X-Gm-Message-State: AOJu0YyQ9yJCIf62/AQHPM0v17k37LuJxKJkvJJckNvoxzXV66ZJvWc+
	z4aHb8sEwq3sMX1/bWNEvzp4DN97F+J05s1NH/Hi6r9kivlsuT/W34C8lZn+pQ==
X-Gm-Gg: ASbGncuw6yeYUOx3zugsvg9lShGwA472AyGudM4tdfgEkcqYPRzy5J4cnxQeRqFZobr
	1GpQpCQrESKXCO2//NCyN8TvPIyTzm0VCb6pX8Dyg3qsOGM5W4I2/i241z934FWPOIgs4olKKy+
	6axFdoChvsSDj9eqGElf15SSpPJbGXT18BVfEzJzOFgwiJjE9miV34wkzdEUl3PsHgWMt8EryNe
	QC3diKb2eyB1x60lYGbs/esznS68xex23CxN7BI++4amcfr1FIZjLeP1kaRj3/ECQZUtAPSBWQ/
	RkClX/jglpwo3PScBrz7cXAAkCO6bc/ICwNZrYItp/Uvv15J2Lf1qzitxdT8dl1WSm+RsddvUOX
	1FbNQ7O0PP8Bl4hd6Ws1x1MRA8UKbSqVkP4M=
X-Google-Smtp-Source: AGHT+IGYciOrOevLieWDt9GGB1aXZImCU6GSczyXvgmBBZJhLa1nVJbsLI/BGcPnJ65DcIMODaXtxQ==
X-Received: by 2002:a05:6000:40db:b0:3b5:f93a:bcc with SMTP id ffacd0b85a97d-3b768ef9668mr6082237f8f.35.1753342036619;
        Thu, 24 Jul 2025 00:27:16 -0700 (PDT)
Received: from voyage.lan ([2a0d:3341:cd4f:d110:cf6f:2013:cd74:cf4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm1231723f8f.44.2025.07.24.00.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:27:15 -0700 (PDT)
From: Marta Rybczynska <rybczynska@gmail.com>
X-Google-Original-From: Marta Rybczynska <marta.rybczynska@ygreky.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [PATCH 2/7] packagegroup-core-security: unify conditional adding of packages on RISCV
Date: Thu, 24 Jul 2025 09:25:44 +0200
Message-ID: <20250724072642.7358-3-marta.rybczynska@ygreky.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
References: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 07:27:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1859

The package choice was using TUNE_FEATURES that doesn't work anymore
with multiple sub-architectures of RISCV. Instead use the overrides
and make sure to take into account also qemu versions.

Only riscv32/riscv64 does not work, fail on RDEPEND for qemu targets.

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 .../packagegroup/packagegroup-core-security.bb     | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/recipes-core/packagegroup/packagegroup-core-security.bb b/recipes-core/packagegroup/packagegroup-core-security.bb
index 764ec02..77782c9 100644
--- a/recipes-core/packagegroup/packagegroup-core-security.bb
+++ b/recipes-core/packagegroup/packagegroup-core-security.bb
@@ -51,13 +51,23 @@ RDEPENDS:packagegroup-security-utils:append:x86-64 = " firejail chipsec ${have_k
 RDEPENDS:packagegroup-security-utils:append:aarch64 = " firejail ${have_krill}"
 RDEPENDS:packagegroup-security-utils:remove:libc-musl = "krill firejail"
 
+ARPWATCH = "arpwatch"
+ARPWATCH:riscv32 = ""
+ARPWATCH:riscv64 = ""
+ARPWATCH:qemuriscv64 = ""
+CLAMAV = "clamav clamav-daemon clamav-freshclam"
+CLAMAV:riscv32 = ""
+CLAMAV:riscv64 = ""
+CLAMAV:qemuriscv64 = ""
+
 SUMMARY:packagegroup-security-scanners = "Security scanners"
 RDEPENDS:packagegroup-security-scanners = "\
-    ${@bb.utils.contains_any("TUNE_FEATURES", "riscv32 riscv64", "", " arpwatch",d)} \
+    ${ARPWATCH} \
     chkrootkit \
     isic \
-    ${@bb.utils.contains_any("TUNE_FEATURES", "riscv32 riscv64", "", " clamav clamav-daemon clamav-freshclam",d)} \
+    ${CLAMAV} \
     "
+
 RDEPENDS:packagegroup-security-scanners:remove:libc-musl = "clamav clamav-daemon clamav-freshclam"
 RDEPENDS:packagegroup-security-scanners:remove:libc-musl = "arpwatch"
 
-- 
2.47.2


