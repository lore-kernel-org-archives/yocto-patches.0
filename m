Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0704CFC282
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 14:21:46 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12352.1763734897730927908
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Nov 2025 06:21:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hYS6rZls;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b1f2fbaed7so165368085a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 06:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763734896; x=1764339696; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBn6EmjY1m7kR32rMDQaENNdi6XsTRzw7Sv5Q0KmMB0=;
        b=hYS6rZlsGrjml7bJag1ApLOZC2GfqF7M3bcXcxJmstiQF0+ZAAWdR1UN6KMN0PPBGA
         7FX/1kdLm53ct7n6H4Tzm8XFH9lcx9TxXSeSArKEiGxPDWfq21YRgp73JyTYEzX3QWVB
         zjWv9gonl4lTkHnZ1hc8JMUcMXP+RnngVxbV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734896; x=1764339696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EBn6EmjY1m7kR32rMDQaENNdi6XsTRzw7Sv5Q0KmMB0=;
        b=LrD+QSf5MKwkBoI5HA1ESjHoUKEU3yxI3WQ0BqwkS116v2qG2uCtNfsUOHlOkbZ0yK
         NTlFaqMYB9EC8d1nsBrsNfQ+E2k4SPiQHdrzB++s4NqrU1t1uvOCcTQn5gDvbQtiCaHU
         2EjP85zkt68i9+YQBVbmLhc8OVdDQxyPKW9WXk75K+eHbKqwi542XBnX9/edtCvTfsah
         Rb0Hw1OOKD7HX/AFiUK9dLAPbdDs2bnYJ+437rrsKPsaMpGhozR8S5gRDvGLJ21FLItR
         72rnw5i3JbRF4zfbQAjVY+5ivdy6O7ALUWaao2zDKC8WRUtc2j37gACQNsvd2VoBjX+o
         w6HQ==
X-Gm-Message-State: AOJu0YzBombhNDjlNmIe20Db+rGjWFqk5CyyBCBHBsMBIuk1zIeWT2yR
	f/Y5i/pTZMghIxcUMw7X7so7t1z65T1+PcCsMJkLaRbsuuEV7ziKUC2Q4bZhWLRe/PHZOxtUoGr
	3IPuK
X-Gm-Gg: ASbGncupX9paEWVu3LFExu3Dsrn6lnNasCrI7ADSJ7i6wEdUipfGfsnEjySNrGzEJK0
	cO6/8L6hKswBnCDSwwuAVXjZqiV6skymnB1WjgL8ZDixsSw6xcoBLwMjzSZvOKPFFJ/dTJnwexM
	OEPs6I8EluD397t440BoaNWMZQUiJRtLgvi+yvhY+l1jlLrrU9G2V+ZBYj/ktIoJusUi2C3XBoZ
	HQOkumgeDFe/8ZnaglZaRX/+zjh+Mk0qeAljczz8ZBU/1GWGG2hHzLfc7qBURORTRZIEYWdPNGt
	qo8tMitXRcI4rOxl26Kqb2boouwxZ1Wt/gsOdvlCMPWd/Nf2pd7Bid8dpUzikXqL2bIzDtJk05q
	a9Pk0Z05KFSj3z0uEVziNtDe/7TOtUI/HLC+6QB1tPmBTLS80ny+FOKxKUChYkEDzs4EWqxYdXt
	OdfmYn/dZWd3rYDfhm9Jrc7vLpcZNU+LHb6NZh0AfEEMif646qPfGYhatQdASEb+Y=
X-Google-Smtp-Source: AGHT+IGlZ7va52Spgm8oV8UtbGitku5AazE6RUt1o1fTZIC3iXmdUdT7EcUaJtyIjJJnCUc+tXmYlQ==
X-Received: by 2002:a05:620a:701a:b0:8b2:1568:82ce with SMTP id af79cd13be357-8b33d4680b0mr252576485a.37.1763734896252;
        Fri, 21 Nov 2025 06:21:36 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm374815785a.37.2025.11.21.06.21.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:21:35 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/6] openscap: upgrade 1.4.1 -> 1.4.2
Date: Fri, 21 Nov 2025 09:21:15 -0500
Message-ID: <15d2fac0bb51590b1276737a9804c634c1a4b417.1763734538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763734538.git.scott.murray@konsulko.com>
References: <cover.1763734538.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 14:21:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2645

From: Yi Zhao <yi.zhao@windriver.com>

ChangeLog:
https://github.com/OpenSCAP/openscap/releases/tag/1.4.2

Disable building on musl as scap-security-guide already does.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../openscap/{openscap_1.4.1.bb => openscap_1.4.2.bb}         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
 rename recipes-compliance/openscap/{openscap_1.4.1.bb => openscap_1.4.2.bb} (97%)

diff --git a/recipes-compliance/openscap/openscap_1.4.1.bb b/recipes-compliance/openscap/openscap_1.4.2.bb
similarity index 97%
rename from recipes-compliance/openscap/openscap_1.4.1.bb
rename to recipes-compliance/openscap/openscap_1.4.2.bb
index 3e5f00a..f1eb647 100644
--- a/recipes-compliance/openscap/openscap_1.4.1.bb
+++ b/recipes-compliance/openscap/openscap_1.4.2.bb
@@ -13,7 +13,9 @@ SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
            file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
           "
 
-SRCREV = "23a8ea3de3c4fd6017db4067675a81287177166e"
+SRCREV = "e9b2a41f5796f5ead3d1e2d9df1fb06818a569ac"
+
+COMPATIBLE_HOST:libc-musl = "null"
 
 inherit cmake pkgconfig python3native python3targetconfig perlnative systemd
 
-- 
2.51.0


