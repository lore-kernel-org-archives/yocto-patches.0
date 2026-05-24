Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC13CD5BD0
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:28:18 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7244.1779625697105788720
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:28:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=riSVYAIq;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b701756684so105155506d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779625696; x=1780230496; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQaZKN6akvqTWTdzyPcNadu7Fm/4cmzUCE6/MmO51c4=;
        b=riSVYAIqfSAU2zLXkZ6qL0RZo4kF3G31Qm96l4BGKM+yyJtkzdYMCWm7CwUTBsFaQd
         GPGCD4lLsQeSerpg63kurHhRw4VnVe5NjmTt+9iaW210YlrAwMGAKfdZBvr+Rlk21zIE
         KFpT+sgGujn4hEnAxNmx5OcKX7K3fh2GvKRrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625696; x=1780230496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xQaZKN6akvqTWTdzyPcNadu7Fm/4cmzUCE6/MmO51c4=;
        b=PYOYx1LVoCsDvPUrsAnXbBp8BSSRpxGjw/xfYNO7X4jtbBEjllRsgEEDM8vTEiAHg5
         AaWs5svc2BmQ608w7ur2QZH3wHeVP4yMFzHiebm17yjA9lPm8SSR1Tooq/XUrhyxSMoQ
         rpaNip9BK/CpsJZ4/hvncAWHA6Rtf7QCU+KWyFUfE4WI/oMVvAleIjnutcdsNFEMtJgZ
         ZGYeJcn/NcnNb0lRsGIWyuibZqaXz7F+uUFyp3sjHDbmn04RWiRfqGwRtNaYzvf4Aewg
         JW7w0BP8meu/+pFKOwufqO6fotd5YEVqXavZ+LTF1yp4Sr8ekk8GUIihHOFkFhhLtI85
         vsnA==
X-Gm-Message-State: AOJu0YwMqJOsCPkiX79Flm6H1yF39ZVi0/9IHKoUkfpNpzs25oJEKMR9
	fQ+gck3XrFHYbJHqS4jjxBloPg754NtXTCu0ZaN29y/IHRB6mZZhGYDcgGcc0OZpUO3H2fxEpu1
	OUJDv
X-Gm-Gg: Acq92OHEms9zv4cH2n33YQcJQCPp7YFl9qBbVVl9gMPjfpyn1wUcz3XQSxfGEqJxFgz
	JZ6QwBu8YJ0jFxcxrKEEOBDf0OjHI797vwqqTdjcJHjNpttBYKY9JUPizpyx/wNxEG+l68gPlVm
	28dtX295tJKk89lnNBigK9oBgjrJV1/dw9EQ2Dr4fExtYMr9gvIVC79PPGB3l6n6r1UlyQ1Bwgo
	5omjwZscVayDeVP7U44A2EGTgE+xz2PD8t6LpCU8nSFX0E+QGZEUbKICLfiZFhMDL32jsrlMaLR
	UiC/IbPryfrvDAjtshHp2o0JRM39kBBeBti0uhHX1ZiwFUY7raJ5PANpqjlbK46rtLy3Lx9vszy
	NZGVxGMkopeJrWtl4I8LJNG8/p0qPEHGl6hURgxgidUz1wPPxRYkAZWR+cMqVVc/xPVCU6c9dg2
	FPBLXPYWB32mu9+CDqpoNbowSKf+0hoYxvfYv4Zu7RGuWS6D161GATJrK+yxgL8KbSTR8pAtgtc
	qdG42aJP5/ts6hT+YyDmzmg3KctziMEMMQgd+fLiiDvCDMy5byWDkH5oToFbC2z
X-Received: by 2002:a05:620a:2951:b0:914:bdfa:c782 with SMTP id af79cd13be357-914bdfb0df1mr1030537485a.29.1779625696092;
        Sun, 24 May 2026 05:28:16 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm751989385a.7.2026.05.24.05.28.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:15 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 10/13] arpwatch: fix typos
Date: Sun, 24 May 2026 08:27:59 -0400
Message-ID: <05f3f6eb2a4605f27cdea135bb14f27564071852.1779625557.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779625557.git.scott.murray@konsulko.com>
References: <cover.1779625557.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:28:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4030

From: Yi Zhao <yi.zhao@eng.windriver.com>

APRWATCH_FROM -> ARPWATCH_FROM
ARPWATH_REPLY -> ARPWATCH_REPLY
CONFFILE_FILES -> CONFFILES:${PN}

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-scanners/arpwatch/arpwatch_3.3.bb | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-scanners/arpwatch/arpwatch_3.3.bb b/recipes-scanners/arpwatch/arpwatch_3.3.bb
index 3ab5993..bb9c2b5 100644
--- a/recipes-scanners/arpwatch/arpwatch_3.3.bb
+++ b/recipes-scanners/arpwatch/arpwatch_3.3.bb
@@ -18,8 +18,8 @@ inherit  autotools-brokensep update-rc.d useradd
 
 ARPWATCH_UID ?= "arpwatch"
 ARPWATCH_GID ?= "arpwatch"
-APRWATCH_FROM ?= "root "
-ARPWATH_REPLY ?= "${ARPWATCH_UID}"
+ARPWATCH_FROM ?= "root "
+ARPWATCH_REPLY ?= "${ARPWATCH_UID}"
 
 # many configure tests are failing with gcc-14
 CFLAGS += "-Wno-error=implicit-int -Wno-error=implicit-function-declaration"
@@ -27,7 +27,7 @@ BUILD_CFLAGS += "-Wno-error=implicit-int -Wno-error=implicit-function-declaratio
 
 PACKAGECONFIG ??= ""
 
-PACKAGECONFIG[email] = "-with-watcher=email=${APRWATCH_FROM} --with-watchee=email=${ARPWATH_REPLY}, , postfix, postfix postfix-cfg"
+PACKAGECONFIG[email] = "--with-watcher=email=${ARPWATCH_FROM} --with-watchee=email=${ARPWATCH_REPLY}, , postfix, postfix postfix-cfg"
 
 CONFIGUREOPTS = " --build=${BUILD_SYS} \
           --host=${HOST_SYS} \
@@ -78,7 +78,7 @@ USERADD_PARAM:${PN} = "--system -g ${ARPWATCH_GID} --home-dir  \
     ${localstatedir}/spool/${BPN} \
     --no-create-home  --shell /bin/false ${BPN}"
 
-CONFFILE_FILES = "${sysconfdir}/${PN}.conf"
+CONFFILES:${PN} = "${sysconfdir}/${PN}.conf"
 
 FILES:${PN} = "${bindir} ${sbindir} ${prefix}/etc/rc.d \
                ${sysconfdir} /var/lib/arpwatch"
-- 
2.53.0


