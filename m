Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C305DC3DA49
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:05 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web10.32001.1721898119272651907
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:01:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FzUIsC1t;
 spf=pass (domain: linaro.org, ip: 209.85.208.172, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so17801391fa.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898117; x=1722502917; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQRgdY9LmIQTj9b3Y8m0XD9vDPCAwhGP3+U/1W/GlSg=;
        b=FzUIsC1tC3TWU9YxwvUsP86Z7Zm74JBoi0Lf5vayOhCS/GutF4Qhdu4tpz2TklSGLp
         GZfx3ssQPiXEuXBwKX9x5JjkOhgIYJMcKkVmtI64dSG5QsPf9rV1DceP6Pl7jI+mnMnF
         fg1hI0uzsnIz4KMQ32LNNw6fyllq6SagNXDCtpH6cHuO8Dr2N+hG6m8w8GPI0Mb3q+II
         s5uI7s0X4REHeoR/+pUfJ9w1GnZBNqfDmVGSx1jP2Vor7iw2Lm+mxSQbSesiEHctn4yS
         Lw1tDadCf1qAMKWJUdv/5YYEPTmgg+IlWLHoQyNUiU8Fk1NVaTkTUvaWtc9N6MHMckuN
         97TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898117; x=1722502917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQRgdY9LmIQTj9b3Y8m0XD9vDPCAwhGP3+U/1W/GlSg=;
        b=XlqvtWYi7ewuetSRA5HLRDrb8bdPaPmr5BBOZcOYQZi731OuJpFljIZBIboNZfWvrV
         dlaVW99DaJ4IEbC/YN2dPZ6NOBKHggJU0CJKxbWoAfx4IcdrAnvamY6j6LjHwu5qoz13
         peRvwbimm2wdPewdZwq3MCTenE/aTCBW+fCnybREGBX1ehYM36SrHOmcFaR2RzfNwBtW
         jJczY5W9uUM7D9Z/ZqmIdV+6mEsmP+YSZiLOT1kfF6ecYWB+bx880j965jLlFwfqtEeH
         spRqyxvv5dOTU00x3d6clUwI3KrQgI6mFqHK4ZsYfF4vKsbkR9fXgsUTrpAgEir6XB5h
         kdMA==
X-Gm-Message-State: AOJu0YzhxCdMhjS97H7viRxwnOCCc/10f+CLW8vrlU8Oz4ZKnHHNhNcX
	f15pH0g54a92t0umbjpMntHK235ITdbq5q/1K3v0KXlokHyOzsET/LpDvN3PxcOO2ZTKLvanOt2
	K
X-Google-Smtp-Source: AGHT+IEB6IzKj5Cnxm8W2z+rQvi5aSg5k41anb0n4WIMoAj9sdeYXLLX9a78/IWSb15rwb23nH/+jA==
X-Received: by 2002:a05:6512:3992:b0:52c:8a6b:6071 with SMTP id 2adb3069b0e04-52fd423fe9dmr618738e87.30.1721898116746;
        Thu, 25 Jul 2024 02:01:56 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:01:56 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 01/17] bastille: UNPACKDIR fixes
Date: Thu, 25 Jul 2024 12:01:15 +0300
Message-ID: <20240725090131.75860-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/458

New poky version uses UNPACKDIR instead of WORKDIR

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../recipes-security/bastille/bastille_3.2.1.bb      | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
index f2ef335..7074f68 100644
--- a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
+++ b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
@@ -83,11 +83,11 @@ do_install () {
 	install -m 0644 Bastille/AccountSecurity.pm    ${D}${libdir}/Bastille
 	install -m 0644 Bastille/Apache.pm    ${D}${libdir}/Bastille
 	install -m 0644 Bastille/API.pm    ${D}${libdir}/Bastille
-	install -m 0644 ${WORKDIR}/AccountPermission.pm    ${D}${libdir}/Bastille/API
-	install -m 0644 ${WORKDIR}/FileContent.pm    ${D}${libdir}/Bastille/API
-	install -m 0644 ${WORKDIR}/HPSpecific.pm    ${D}${libdir}/Bastille/API
-	install -m 0644 ${WORKDIR}/ServiceAdmin.pm    ${D}${libdir}/Bastille/API
-	install -m 0644 ${WORKDIR}/Miscellaneous.pm    ${D}${libdir}/Bastille/API
+	install -m 0644 ${UNPACKDIR}/AccountPermission.pm    ${D}${libdir}/Bastille/API
+	install -m 0644 ${UNPACKDIR}/FileContent.pm    ${D}${libdir}/Bastille/API
+	install -m 0644 ${UNPACKDIR}/HPSpecific.pm    ${D}${libdir}/Bastille/API
+	install -m 0644 ${UNPACKDIR}/ServiceAdmin.pm    ${D}${libdir}/Bastille/API
+	install -m 0644 ${UNPACKDIR}/Miscellaneous.pm    ${D}${libdir}/Bastille/API
 	install -m 0644 Bastille/BootSecurity.pm    ${D}${libdir}/Bastille
 	install -m 0644 Bastille/ConfigureMiscPAM.pm    ${D}${libdir}/Bastille
 	install -m 0644 Bastille/DisableUserTools.pm    ${D}${libdir}/Bastille
@@ -138,7 +138,7 @@ do_install () {
 	install -m 0644 OSMap/OSX.bastille    ${D}${datadir}/Bastille/OSMap
 	install -m 0644 OSMap/OSX.system    ${D}${datadir}/Bastille/OSMap
 
-	install -m 0644 ${WORKDIR}/config ${D}${sysconfdir}/Bastille/config
+	install -m 0644 ${UNPACKDIR}/config ${D}${sysconfdir}/Bastille/config
 
 	for file in `cat Modules.txt` ; do
 		install -m 0644 Questions/$file.txt ${D}${datadir}/Bastille/Questions
-- 
2.34.1


