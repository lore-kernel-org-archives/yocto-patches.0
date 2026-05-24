Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7421ACD5BB1
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:16:06 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7160.1779624964365814308
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:16:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ai54ipBo;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b5de17382cso71943766d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779624963; x=1780229763; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQaZKN6akvqTWTdzyPcNadu7Fm/4cmzUCE6/MmO51c4=;
        b=ai54ipBoPI5ys67qgLf8fsL3y/bzHKVmiEWcMTYilRn6tlFachnQx+Ma6DTeSaP8Qp
         tLOYzx4+ZRCCq9SGB9HnCUe+c5nRUjYtOgRlA61lXxBuElHvyMo7nerwG6pSXPsa2zEu
         jBSJOTGfVlPNwgzJMXn9L1f1hVOueQbPBB55k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779624963; x=1780229763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xQaZKN6akvqTWTdzyPcNadu7Fm/4cmzUCE6/MmO51c4=;
        b=fpp5pW7uPOC+lffVIRCG56vtFNOmcMxbGB3NeVwQ+/5msNEHpv3aIVL/zbKearesbm
         r9dZVcV/uJroQ6RvOTTVl5sAEi1IxP9e1ukVBbwXkjqFscqncfeoQiR9/hpwQa+4L/Ln
         QK/WXcSvFmWhDuMdtQIfReOu38AR8jCYlBl/595FgbjlE+0f3fBUXTM6DA1KuZ83KMCa
         PjfJKD88oB78MGLwDPUzXlNA4m6eJ0TDqZdp6iOFv3r9on3LdQ15I6JBzOQ3VmCdY4Zt
         dAljWylHvsqZhY4FgU1qVMW8YwEU2gUT1IcZgpXcCEJe8HIXa5dC/mK+K3FgxcSikzaH
         DsdA==
X-Gm-Message-State: AOJu0YxmKUKfeFQnP8dwRc2uwdQpseIZgN/z0PWFE0ZoJ1ZjrGK3m9cL
	FKoz5N04fKAn2jklfriTtnCu1F2JGh2QpCO/uJQnZeCQ5bO3jBqD/Jc5x1xq1apoAdMjBs+ltIo
	o/yec
X-Gm-Gg: Acq92OHSuBblUyCQr2D+EQ7WgWOpAokbIL0zqLiVvls1WxJ7qH0hopjvM1Vz8ytg+sd
	yg1kgfGiHHJ2jKYoHImwWLxNBSaM/QRZdz4KIygzTG07hwEAqAj2D8h6Zb2zTPh1EwbOm6MXWzT
	enZRE3XEVAf1CH1ZdOY54Fg1JgBWx1mknS7Texbh/7BlP3KHYm04m1qCT2OGBmVCSgy8rjcJ3xr
	nxuc8kVSfJEdhifyI3j7s7VnVChXDEAa8jKqu2bqj/x9mvdw6XOGqk/E2xtWVkp5eP7Wc/5TfeI
	/uV44Z07jabdCjBjBW7n7KXbWA/RjB2OzPIXCm+rrczxmbiot4O1JemYfOreQ8arBW1oWMIHnqs
	dXTeoyGDvOCxXGph0L33TqdgNs9lDA8vz5pPgIysHmsmPuMYPk6CIdOhQbpW4sB4XQQGcADVavl
	4nyPc8HJITXiyLx5YF7OrUqpSHXwTuM4RbOAQ0jKtD1D+XAokxnT3qYmmE+46IjNEbn6e7P0U7V
	/6hjXpUttR6hpgGO5FyCtbBjF/x945aR2AospkrmvKiaMm0umCljq1hkJMtTDNqPXG6kmVaXLc=
X-Received: by 2002:a05:6214:410e:b0:8ac:bb62:fe52 with SMTP id 6a1803df08f44-8cc7b53d6eamr190558676d6.4.1779624963357;
        Sun, 24 May 2026 05:16:03 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm82385186d6.38.2026.05.24.05.16.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:16:03 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 10/13] arpwatch: fix typos
Date: Sun, 24 May 2026 08:15:37 -0400
Message-ID: <797df6dca9cbcf735afe92a49bb27e5a3637ba77.1779624335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779624335.git.scott.murray@konsulko.com>
References: <cover.1779624335.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:16:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4016

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


