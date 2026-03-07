Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C765FC9EEF
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 10:34:36 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6768.1772879670964012467
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 02:34:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DPfByTTp;
 spf=pass (domain: konsulko.com, ip: 209.85.219.47, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899ee87355dso87889886d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 02:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1772879670; x=1773484470; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZOJzdD+HF37QohXV8WWj4aNzV9WJawD1OcU/sNRXUQ=;
        b=DPfByTTpL2/xB48+okg8+UZI3FVvBw96aAi3ZnYJnrRRLKyuI8IKbbO0FOJAh8pwDV
         WTFc/0GuawjhhSQfwNdIybLDgKzfbjCLKQmz3TbhiyD5x3b6cgc/V0nGsD+R1pi1C8Mj
         gLDEuI2rutLS64Lk5MhIb/qu5p+/RWEfoHHvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879670; x=1773484470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rZOJzdD+HF37QohXV8WWj4aNzV9WJawD1OcU/sNRXUQ=;
        b=jnJdPdtI65rtR6iYrdDyLcmrzqWOTIxkLOOG9Sd1D9Nx2WZTV8PXN0qib9go0NuSis
         2Ap/1e+WKikQPJEWp9jmXJmiEwToTNnV0+837eY0g6r8Wur6kPG+Aq4Y5HayIBzb8CGB
         GPcIut7+lyEAGTziNq9P445U/W/U4oCylqsF+3hW6xgDQy7yD5Uo3ylcf1us7U8y76Wz
         xct/+MwVgjGw/83x6s62R+tABF/alLOVXHOhyTLvHf6LRpyLuy/1ImjNpIqpRIZq3kwP
         dhmGNpM2IImes8vs3GD+7wr6LOaqlKyhd1iP8xYNXdoQIzGoahTy0Qas2mb5rVb8KI5B
         H9RA==
X-Gm-Message-State: AOJu0Yx7R4vK/eMMmj/xODiOERBx+wxPgCLjFo/aXecL3QHJW6nMoic7
	nFC/gOmMPveuhHlIMO/kMdIKiBm9HSQpId5dmS7tAk7KrsvKuhPuHtwZwymzslJuU8rjfgQ8OXy
	DxZCBZJ8=
X-Gm-Gg: ATEYQzyXkPA8zQYpXlJJtjXuKSY5PnqUg52murKx1ya1OnWSXvobuRaGQExWdC4OGMv
	MnLJN72OlWBrebyFQ770+6qTIVGF+qjlPOYjBs8mSnIn25rrcqMb2Y0YjHzkrrDl3JmrnU4tEEs
	koov7ZLYotTS6GqTTKfmgoer+uSAOEqpvDPq+ZqA2fWcuqLeEaX7KVtBCepwmQ5OMcGTZOrknyA
	AZTXFXlZry2X6nqzTHbPJYkUK+shWVZjn3m43vhMoehGyRQBPoce3RR7riZ9IlMnBfXBW8rNz08
	u2lZDxD/CRpUPWMYXwfG9xR5t0H+JP90A8xmnks7MMQ1iuvjsgFbKu3sETcpjTsQFM7W83BZGR6
	SmI3R3nbR0/+/q6XVXe/R3VZnSUhTa7cQM2r1u+h+OLnAZHuqv7RJHZcAQ1q2J8zzDqYpDR9HhY
	PA/TnBR39Ev1Pt6scmTCI6DXZH0NjS+/4yrYOy9jiYMPdzz0Jde+JV9VoP+3cUZbOlR18xup+6A
	Q6AaWAkM10QRJISgL2eCm58A1fjhfQ7S8COM9GHu/WMgZJUFbl5viotfSTUnosCIaWGUvbT0Do=
X-Received: by 2002:a05:6214:20ee:b0:89a:125f:37dd with SMTP id 6a1803df08f44-89a30ad1d24mr73552656d6.49.1772879669736;
        Sat, 07 Mar 2026 02:34:29 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316d8936sm35653216d6.28.2026.03.07.02.34.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:34:29 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 2/2] nikto: fix branch
Date: Sat,  7 Mar 2026 05:34:24 -0500
Message-ID: <b13f1705d723650de61277670c8a76aadea4cfdd.1772879512.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1772879512.git.scott.murray@konsulko.com>
References: <cover.1772879512.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 10:34:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3374

Upstream has renamed their master branch to main, adjust SRC_URI to
match.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb b/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
index 8c21b30..1db68c5 100644
--- a/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
+++ b/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
@@ -7,7 +7,7 @@ LICENSE = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"
 
 SRCREV = "f1bbd1a8756c076c8fd4f4dd0bc34a8ef215ae79"
-SRC_URI = "git://github.com/sullo/nikto.git;branch=master;protocol=https \
+SRC_URI = "git://github.com/sullo/nikto.git;branch=main;protocol=https \
            file://location.patch"
 
 S = "${WORKDIR}/git/program"
-- 
2.51.0


