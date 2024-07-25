Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0224C3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:25 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web10.32013.1721898136685930094
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=pAixE6d3;
 spf=pass (domain: linaro.org, ip: 209.85.167.42, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efd8807aaso908981e87.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898135; x=1722502935; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vJ3vRGG+GDMIUxU8VFQuVTHJf5vs8l7UM944rfIiYs=;
        b=pAixE6d37gKhFiAn9NKYh7/nvFwE10du99LGnSnb42FTAwbyjsXJ0Ga2DZRcLPdkN5
         gSy/jTWE40vHfn6b6L4TuDbKLeE0uD2LjqtYbefguoWjh2cI1ssP7Srj2IhGYZ6dZyCl
         uf0Ie+BT7W6Nog9Vs2QKTDByszoSY2z5Bz6jQP+Eokhzzw6dAUKh3BvZithupJhikYCY
         xfs4C8WTDLuI0CFn4FyyK1rx0+QuD7O1hbpAt5eA+O3cm4yuKnreUyL8y1TwPqH0LGZF
         w5r1+DXD2NatFZj7HSRY+p6mkXvfK/le0VhnKmnPVnlYIxfcMFxofrRg0/65CzcXWKHJ
         9RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898135; x=1722502935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vJ3vRGG+GDMIUxU8VFQuVTHJf5vs8l7UM944rfIiYs=;
        b=geOrEtLChbAzmO6V2kitcESYmzoO/EN/jUxxDDicvTASSm/FuEPp8sHd+1qxwVzXbh
         nCfm9yh4E1UXFlqx6KOSDjQMMJXMfxfL7+zcAi7ufi3Wia956eOw95ZoqqSY7F6dRV/o
         6Q4uEjf2yMe/WlvUbutExoZ8HYCBXrX94r4q90/PoxHp8XNeWGJ6nFsXJen0o2hWKXgX
         +rKX4rqR1M1I8PGOsjnLTd1uBecJg0HwcSFSZQ1D6gTsO7Ro2iKSpuYz8M1OmiMXgkR0
         wuGJ86U8AaacAmKnNZPmb4lrg/1TlthvQ/Hir0kURgFQ/qMthVhgbahy7+TtSUTBBkLX
         2OBQ==
X-Gm-Message-State: AOJu0Yx6lNbr9kzJ/p0kZ9uQDO1aoddpQvHgfh2T65kgxNU2yTw0wg2P
	JPea+a5jXGQ1sj6AiOnFdRgCGedxDfzJCPgu+LC7zPhLDwvO2QgkvhxsqafkpuDogwQ10SouY71
	2
X-Google-Smtp-Source: AGHT+IFkTniaUL4l+5RylYMH2HUfscSec+fB8DcphV6+sWluGYJmH0+NxSr6H6Jtho/JeGFjFi9Jhg==
X-Received: by 2002:a05:6512:b85:b0:52c:d943:300f with SMTP id 2adb3069b0e04-52fd3f6bd76mr1732684e87.38.1721898134835;
        Thu, 25 Jul 2024 02:02:14 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:14 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 10/17] suricata: UNPACKDIR fix
Date: Thu, 25 Jul 2024 12:01:24 +0300
Message-ID: <20240725090131.75860-10-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/467

New poky uses UNPACKDIR instead of WORKDIR

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 recipes-ids/suricata/suricata_7.0.0.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index 21d4306..d87cebd 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -91,7 +91,7 @@ do_install () {
 
     if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
         install -d ${D}${sysconfdir}/tmpfiles.d
-        install -m 0644 ${WORKDIR}/tmpfiles.suricata ${D}${sysconfdir}/tmpfiles.d/suricata.conf
+        install -m 0644 ${UNPACKDIR}/tmpfiles.suricata ${D}${sysconfdir}/tmpfiles.d/suricata.conf
 
         install -d ${D}${systemd_unitdir}/system
         sed  -e s:/etc:${sysconfdir}:g \
@@ -100,7 +100,7 @@ do_install () {
              -e s:/usr/bin:${bindir}:g \
              -e s:/bin/kill:${base_bindir}/kill:g \
              -e s:/usr/lib:${libdir}:g \
-             ${WORKDIR}/suricata.service > ${D}${systemd_unitdir}/system/suricata.service
+             ${UNPACKDIR}/suricata.service > ${D}${systemd_unitdir}/system/suricata.service
     fi
 
     # Remove /var/run as it is created on startup
-- 
2.34.1


