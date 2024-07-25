Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CFCC3DA49
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:15 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web10.32012.1721898134897317680
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FPv8N42B;
 spf=pass (domain: linaro.org, ip: 209.85.167.52, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f00ad303aso856164e87.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898133; x=1722502933; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Slg8itjqGvaAIgoxgl9v6aG0skZ4WEQLBzskDoekWRs=;
        b=FPv8N42BEiyYL2kA37BokssShjOEvoubvWCaBDY1/S9Ql1OorCuOWXOX5xQRBCXfIR
         rMUrLR82NsP5qSU9udUEyyqewylQwXyy463LuaZR7eFHD4Dy4J8Hof3nFQWskQiRbmEa
         U6abhqHxAjZqpIHRXaNyH1OOnk7y7kEzcw3HCoiOUvFCPR7zAq3ORxRgRbclsEHvmG+/
         18F0AhLiu/k/OVPBYw9dahZCsQw0YX/HK8PL8R0B/q6sUbbEHqCRoTe5KV+hGfrbLtRb
         RmElqKl8U7w6VayhSngSFc96kMS7vEkGuhnsr3mQfxRJQHJbCB9i49PiorVwH7XPqP/h
         IHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898133; x=1722502933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Slg8itjqGvaAIgoxgl9v6aG0skZ4WEQLBzskDoekWRs=;
        b=fxMeGNr9/E82qCD/sDB72k6x+ui9ALVtDuunEbUP1vZmBFEUQCVHkD/8T2L/99Ry92
         8NwHgfF4No8ibhrsjqHm09CzkNuwkw4yc2gVTXKja0IkbG8c88Vya7x9QKoUt0wgVVFC
         Q5fQZVzlR5uitbYl0cRQyJnT2RwcNiFPBsYbB7TSK6ZODZoKavHGxwMBW1iSslpcZsac
         11e0C94W1IFzNL9XgsJLjlhFjVRO5T3lzjp3Zonc8X5SW62TQ4EspW4Vb/+fBT1PkEkm
         K1VPNMS0gkb/7ZXD8gepayqAcyPf4wf0YRv/33jzQHcIOEoV+F8NtZX6qqwYabnDnldf
         wnfg==
X-Gm-Message-State: AOJu0Yz9mSu+W6vOU2lZZiYLQ/T3fDc6GP6K0DhvjYfurRCfYgyPeA8X
	t+G3CeNJUbC76Rr1JRWudTSL+Nu2P7IFTZkXr2PtfYL4eLa5R66a73E9802Iwq1Xc461gPE5o3p
	B
X-Google-Smtp-Source: AGHT+IGy4A2SQhyjO3+CW2++csgEzOKhEvK5hI1ZygoK5ZZAOy58CAQENQoHUNpnNAuIsG97kXfnfA==
X-Received: by 2002:a05:6512:1391:b0:52c:dd7d:3fd4 with SMTP id 2adb3069b0e04-52fd3f1c857mr1611983e87.25.1721898133098;
        Thu, 25 Jul 2024 02:02:13 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:12 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 09/17] aide: UNPACKDIR fixes
Date: Thu, 25 Jul 2024 12:01:23 +0300
Message-ID: <20240725090131.75860-9-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/466

New poky uses UNPACKDIR instead of WORKDIR

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 recipes-ids/aide/aide_0.17.4.bb | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-ids/aide/aide_0.17.4.bb b/recipes-ids/aide/aide_0.17.4.bb
index 52ddc43..b1b9f10 100644
--- a/recipes-ids/aide/aide_0.17.4.bb
+++ b/recipes-ids/aide/aide_0.17.4.bb
@@ -33,9 +33,9 @@ PACKAGECONFIG[posix] = "--with-posix-acl, --without-posix-acl, acl, acl"
 do_install[nostamp] = "1"
 
 do_install:append () {
-    install -d ${D}${libdir}/${PN}/logs   
-    install -d ${D}${sysconfdir}   
-    install ${WORKDIR}/aide.conf ${D}${sysconfdir}/
+    install -d ${D}${libdir}/${PN}/logs
+    install -d ${D}${sysconfdir}
+    install ${UNPACKDIR}/aide.conf ${D}${sysconfdir}/
 
     for dir in ${AIDE_INCLUDE_DIRS}; do
         echo "${dir} NORMAL" >> ${D}${sysconfdir}/aide.conf
@@ -50,7 +50,7 @@ do_install:class-native () {
     install -d ${STAGING_AIDE_DIR}/lib/logs
 
     install ${B}/aide ${STAGING_AIDE_DIR}/bin
-    install ${WORKDIR}/aide.conf ${STAGING_AIDE_DIR}/
+    install ${UNPACKDIR}/aide.conf ${STAGING_AIDE_DIR}/
 
     sed -i -s "s:\@\@define DBDIR.*:\@\@define DBDIR ${STAGING_AIDE_DIR}/lib:" ${STAGING_AIDE_DIR}/aide.conf
     sed -i -e "s:\@\@define LOGDIR.*:\@\@define LOGDIR ${STAGING_AIDE_DIR}/lib/logs:" ${STAGING_AIDE_DIR}/aide.conf
-- 
2.34.1


