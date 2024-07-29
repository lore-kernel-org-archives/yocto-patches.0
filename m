Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7086C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 11:08:15 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.web11.53841.1722251295436363446
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jul 2024 04:08:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A8CkFdeD;
 spf=pass (domain: gmail.com, ip: 209.85.128.176, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6694b50a937so22266267b3.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 04:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722251294; x=1722856094; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aEfwHYDNAHUr3RtQR0dLJ4qntrcYr6wbj9VOk9XbBeA=;
        b=A8CkFdeDl0X7jgeV7BnJSrzw12XaYzEVNomRL/NKqbYMid6TiuKDPJG4UnMPAJNG6L
         x7U+Xuhg7wUQqG+4F8GmXEUe4UQsh5C7e1B/7zRhtBOPK+uFXhrxVvBPB8PhPLS0NoJq
         qul/DoITj1c8xbKDD5bMZfUZ6SquFra1wtY2iTu45gQHgIgBPb09/iIILT0JUI/GbzmX
         52ZqPYTp8wMsHySZb9n/j+jfZF9kT3P8hTAR5QmUuDjovXiE/apHKoVASvUhxYQIqcTV
         w12Wf8cucY57ct6YOPfCF9kqDMSokTGiZU3FwPZZ7DtQSJegSBOK/HHVSDEbW5Sy1CgW
         eYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722251294; x=1722856094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEfwHYDNAHUr3RtQR0dLJ4qntrcYr6wbj9VOk9XbBeA=;
        b=fFoL5OSl8RYrE+vUBkDCQ7RomWhCpcpZB7x021pw9/VPKqkxGyZ7JrVtavRkt1qYOH
         A6ND3kJ686kDkgxZjGJCnws4w+aw1uWVOQxgpjI+yfdVmkK4LOoXFgaKRWAV/t+rzEZk
         ai7qiU66CLFsnUCsSIa+w7VZ7qnTwstzVQ/QoamG0tCUmGL5rhuK9KVo9UAFT8AxoNAi
         yI5Cj5dgH2crpi4Xm3rH8uRfdfpFmRPmRtksu0rkw4qoAjAVzltnuUnZ7PP5yL7nA3Rx
         zpHlv5ycSoPWphX0j0Mheyyaz4yrd4I6Q+LULsn/IfoKlvETf+/30I4f1A7txthbM95H
         u3AA==
X-Gm-Message-State: AOJu0YxXCdv7FUUey3xJ23vqGsYvqhirjiRRSdn/G5Tzjc33JSOd8kq0
	Q0PiqsCJ41Iez+YeUxt9/FogmWw/EuJfgLwCAWKIfJHZ1zPK8W3H0a6n2w==
X-Google-Smtp-Source: AGHT+IFAM0ZWxTwpCaps3NUE7hpRjPHI/afXDCq8E29oHiO+RB3S1t/MEy1Ii4Nz+3dXPLpMoM34YA==
X-Received: by 2002:a81:8187:0:b0:64b:75d8:5002 with SMTP id 00721157ae682-67a055ca8d2mr84940627b3.9.1722251294302;
        Mon, 29 Jul 2024 04:08:14 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:47bc:453d:d517:b47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67567c3f17asm20139527b3.55.2024.07.29.04.08.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:08:14 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] basille: convert WORKDIR->UNPACKDIR
Date: Mon, 29 Jul 2024 07:08:13 -0400
Message-Id: <20240729110813.2013781-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 11:08:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/491

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../recipes-security/bastille/bastille_3.2.1.bb    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
index f2ef335..b95ec2d 100644
--- a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
+++ b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
@@ -35,7 +35,7 @@ SRC_URI = "http://sourceforge.net/projects/bastille-linux/files/bastille-linux/3
 SRC_URI[md5sum] = "df803f7e38085aa5da79f85d0539f91b"
 SRC_URI[sha256sum] = "0ea25191b1dc1c8f91e1b6f8cb5436a3aa1e57418809ef902293448efed5021a"
 
-S = "${WORKDIR}/Bastille"
+S = "${UNPACKDIR}/Bastille"
 
 do_install () {
 	install -d ${D}${sbindir}
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


