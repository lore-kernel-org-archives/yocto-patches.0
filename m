Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EC5C0218C
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 15:26:43 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.18514.1737473198803759932
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Jan 2025 07:26:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dgAlLMw3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso40422835e9.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Jan 2025 07:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737473197; x=1738077997; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PR9MLa8sB5CFn3ti60Vgm6pltsh6MY+HXIE2YZ4SbHs=;
        b=dgAlLMw33f/xgWuocfLeoVo8fS90CmE9h49muxWdgq8TIKxKZ4lYXd75+ZtWriswdf
         AX/UHtIdi59nHYMlMHkrKbRZXuAY0XsWvgUo34TDmJfPu2x1nC+EsNkvSKN1shD/VDg2
         Df67Lcf6tuN+Z0SOujlmye0MSiMYr4Jpg55JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737473197; x=1738077997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PR9MLa8sB5CFn3ti60Vgm6pltsh6MY+HXIE2YZ4SbHs=;
        b=ZKPAspFehpf8nVDky7yARi9CFQGcHzTbx9hPLUB5R7bT/YjT6NWxlAZNRLkAlsy67j
         P0ICSuanI+RAkAP3XOKcCWoo5FXHDM1y8kXsKC8QRfKWPZhYd/avM8cQqe33Tue8/jMv
         2Z1AT3khXvD5e2VWWG/UJ7gB0DfD919Kpw+T407BtrHktCRIUSzT1jSOEwmOdqQtHJUA
         ag9WJaJK5lrtGrGgNSf5ae1SF2huBE2fMJdkFFeJ6LkQAip7EP8o/aPZx6Lr9ZHegR1G
         gb0HcydjHDJ6MtWqSmoppko5eB4E7kQp7/VCWbmuKgMobKt+ezt6zhY4QN+ShRjy7XAg
         /HzQ==
X-Gm-Message-State: AOJu0Yy6qQtC0JWAcW3DJEusI9uYd8NkPB8JsmfQKh1ROoj6StGCq4E7
	s9LNA5IAfbe51Ptx6boDi7oDpf5E3wSLI0K+88GAvxZUcOR9egZhExHnlzERb0itvMqWjqxsGlp
	6yfM=
X-Gm-Gg: ASbGnctfEIzymbiebVLIjSmJvyTAniHSTKwDR3vxu9FjSnrdI3Do+S2LIT1sR7eB8pa
	2Cl2Xd1YiKOVuec6jHMiuu94zW3OLKpf9FkSA2ZXpcURbH9F6c32Z6KpfXYlScA9Y/c4YS29Zsp
	O/zTk+83Hr0wfVZ2ch62l/QQiK6B7+rudddvwTmgxB5lQmOZaWwfsxdWN8SKdqCpW1zlr+w/x82
	tXWLcabV+D3c66+pr/TM1Zhl7zDFIt6ll94rSrSXdqoK4E22qAoyuvVoAR1rd3ckmzKL7nX41jG
	5+E45zO3u6Dn+BC5u1bMT5E=
X-Google-Smtp-Source: AGHT+IEEgLNxBA067MND1Lkhqkw2ALzp3D/hEQQrPNAUaS7HfNJDHNcIXn0eZC/JjJLG3DF9q5r1Mg==
X-Received: by 2002:a05:600c:138f:b0:436:ed50:4f8a with SMTP id 5b1f17b1804b1-438913caeb9mr188506285e9.10.1737473196628;
        Tue, 21 Jan 2025 07:26:36 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fff5:d00b:f6db:4bc7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221dc7sm13530928f8f.24.2025.01.21.07.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 07:26:35 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH] mingw-64: Update for core virtual providers change
Date: Tue, 21 Jan 2025 15:26:34 +0000
Message-ID: <20250121152634.1828780-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Jan 2025 15:26:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/999

With OE-Core changing virtual/XXX-gcc provider names, we need to update
to match.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../mingw-w64/nativesdk-mingw-w64-runtime_12.0.0.bb             | 2 +-
 .../mingw-w64/nativesdk-mingw-w64-winpthreads_12.0.0.bb         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_12.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_12.0.0.bb
index 6d01d35..0cdbbd1 100644
--- a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_12.0.0.bb
+++ b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_12.0.0.bb
@@ -12,7 +12,7 @@ inherit autotools nativesdk
 BUILDSDK_CPPFLAGS:append = " -isystem${STAGING_INCDIR}"
 
 INHIBIT_DEFAULT_DEPS = "1"
-DEPENDS = "nativesdk-mingw-w64-headers virtual/${TARGET_PREFIX}gcc "
+DEPENDS = "nativesdk-mingw-w64-headers virtual/nativesdk-cross-cc "
 
 PROVIDES += "virtual/nativesdk-libc"
 
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_12.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_12.0.0.bb
index fb7e54e..6cae85e 100644
--- a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_12.0.0.bb
+++ b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_12.0.0.bb
@@ -8,7 +8,7 @@ B = "${WORKDIR}/build-${TARGET_SYS}"
 inherit autotools nativesdk
 
 INHIBIT_DEFAULT_DEPS = "1"
-DEPENDS = "nativesdk-mingw-w64-runtime virtual/${TARGET_PREFIX}gcc"
+DEPENDS = "nativesdk-mingw-w64-runtime virtual/nativesdk-cross-cc"
 
 do_configure() {
     oe_runconf

