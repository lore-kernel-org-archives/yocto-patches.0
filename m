Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4164C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 10:25:25 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.53045.1722248722687428832
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jul 2024 03:25:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=nD4fZgZN;
 spf=pass (domain: linaro.org, ip: 209.85.167.45, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efba36802so5585045e87.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 03:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722248721; x=1722853521; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IE67wwvEwFJjVUdP+P1Zp3zXQY+c0KWjcoqS069Zac0=;
        b=nD4fZgZNCJsWPsaH1JMclt7GKn7HDDJyC/pkVIlxsC8X/3ncjYfFLTtwNfI8BO/mz9
         zuvZDjMY75WiGzBj2MieUqLIGggxoBDA8RMgNLg/X9wwJEYlQWifM3fUJODQqjSBkzI2
         Mb1SVNxMBi4TuNVYIaGNfdacOByqcjZHemYvSzQUD3Iuu4czFkR82k6APaDmRGE+2J8N
         v5KGJF3yXUja68YsolzyMM1hxPhpe2VvFySREs6MKr2RkYwrhgyxM0bcMX3UaWDiUCMb
         AGDCOOHAkE2U0hCjdynLr1bUXoalQV+5KR4cRdRbsPK/AGUn3RQ46z/EYSITSnB+/+Q3
         S2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722248721; x=1722853521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IE67wwvEwFJjVUdP+P1Zp3zXQY+c0KWjcoqS069Zac0=;
        b=k3EpDLwn+rocq6LiH3pyULVD9OuXNOio9Ut6mLp1ShOys04ItwWw3etqQ3N57HRpo6
         x4thdImSdRii0n4f27eBlPMy0E9lqTzNtf6BUwQ23j/Om2xlg8CtxUrszItUGdk5Q56c
         qwT4yWOZg0Ln0onQaO4FZbTweFagT/mDbflH/OKS8Cd7xDELEozx/5QVFURuzCm4NHkz
         NdWizfH9JZx1ZiFb/rvU++/cMpIkALl/Bje/gQU/V2W8b6mKILNyW0NjIZ2qBruF4Lhk
         Fv1L4VZaYPuLbKMULWyx5FqpL54huWzln3tjZfbWn0ncQIUXc5jHZN5NXpTy0UslF/Nj
         53Ew==
X-Gm-Message-State: AOJu0YzgvgRfdr+gkHeLDJlrEd1rRT+lKK6gK8/TLbrPgP5jd3tTqRct
	1ysb+bYzitI8aaZB1wwjx545IoN6sq1PFJOjr+hEPKKLnbNLU+KT9lZjFCU+ostvuSpi1FMnzDP
	a
X-Google-Smtp-Source: AGHT+IHrZDPRATmdsbwh7+J2JzClEHp0FeI/i1hOxndQF62R4fsj7+6/M8jnn8GgLgyKQd/1z18UAw==
X-Received: by 2002:a05:6512:3611:b0:52c:dd3d:85af with SMTP id 2adb3069b0e04-5309b27a53emr4727577e87.25.1722248720760;
        Mon, 29 Jul 2024 03:25:20 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c09088sm1434516e87.120.2024.07.29.03.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 03:25:20 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>,
	Anton Antonov <Anton.Antonov@arm.com>
Subject: [meta-parsec][master-next][PATCH v2] parsec-service: UNPACKDIR fixes
Date: Mon, 29 Jul 2024 13:24:43 +0300
Message-ID: <20240729102443.19766-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 10:25:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/489

oe-core now uses UNPACKDIR instead of WORKDIR

Cc: Anton Antonov <Anton.Antonov@arm.com>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../recipes-parsec/parsec-service/parsec-service_1.4.1.bb     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
index 2d55c24..3aa0b0a 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
@@ -61,12 +61,12 @@ do_install () {
         install -m 644 ${S}/systemd-daemon/parsec.service ${D}${systemd_unitdir}/system
 
         install -d ${D}${libdir}/tmpfiles.d
-        install -m 644 ${WORKDIR}/parsec-tmpfiles.conf ${D}${libdir}/tmpfiles.d
+        install -m 644 ${UNPACKDIR}/parsec-tmpfiles.conf ${D}${libdir}/tmpfiles.d
     fi
 
     if ${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'true', 'false', d)}; then
         install -d ${D}${sysconfdir}/init.d
-        install -m 755 ${WORKDIR}/parsec_init ${D}${sysconfdir}/init.d/parsec
+        install -m 755 ${UNPACKDIR}/parsec_init ${D}${sysconfdir}/init.d/parsec
         # Data dir
         install -d -m 700 -o parsec -g parsec "${D}${localstatedir}/lib/parsec"
     fi
-- 
2.34.1


