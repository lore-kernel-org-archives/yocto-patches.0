Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07472CD13D2
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 15:40:21 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14496.1777477211755827075
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 08:40:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=j8aRBPfI;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ef45a6d9dfso958647685a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777477210; x=1778082010; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDyVB9c+FVpxNiJUobNiuafFMmPamuEmZ7kjudrXBl8=;
        b=j8aRBPfIdPAsjOrc/N1a1vKzZBRaCeIRn+cGovlAuoGpWWypRIRdOkLXZirbKUoM4u
         Q/Cx2nIsO/MIlspnI2lszT9waQjL3jACI4zSd2iH2uFN8l26aEZqIz0HExEOYgsLdhT4
         0Y1qZphUjvknqijg8gvi0WGItXBVnUaiLbfMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477210; x=1778082010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vDyVB9c+FVpxNiJUobNiuafFMmPamuEmZ7kjudrXBl8=;
        b=npSHyfczJie70hpE+0iJsAS2FhGZdZM/h3QkoSMAODs4kkW6jX0Qu/9m+DBnjqEsNo
         cQi9m/EsXkNN6Elxev/ejSMC6tnmvywvVdSLaQppkWAj/KmsA5Ob6+QK3ESBl10bzhiI
         tHafGXBzqom97x/L8gkScXgfYR/NzECS/yyQMqeAm0AlR7B3YZWAIwQRLHuvuRbd8NXW
         fNuo27iMaJ5Rrk+jUas/t/5pB6jA5Q6lXOVq9Ho/Bgp5LB1mfZfueSEoxRUGvT6Drh6Y
         UlkMBnf2KTMC48kPwC2S3Va1sEcExAxYIaX+lFihEeueNkvt2gf38HjuzK+h7/CH27zN
         +Bfg==
X-Gm-Message-State: AOJu0Yy7IWSTY9iMR7GaKlUlxosqb/meZ5AIPInOfwnPpmuHuMW7mG6n
	XWQH1ONzgT8tBQGjkPJyWjKVPCAmVECejka84bi3x4QIKykxbtVkpaQf6W8NWr4lqqShxD+EBfr
	1tXAQ
X-Gm-Gg: AeBDieuYBT+2gH9L1cde+Vw5X0Ucz0a/y20QtJDcLBnV7PfHGAuQfSu79mDuGdmXTEm
	Vf1mRLuGHXbdGmv9JF2f13SdFeH1Bgufamx1hUOp14C1xE3XQysCq0cTAjp8Wmm1J/qxH6PDWZH
	XeEYq3Q20LXAVeGg3RqGqzeVeJ0hc+OVOVdcpl/8xBoW5wpMvK4MbqlDjUhOzJukJ54Z7oNGA7j
	YKQWm2iqaUniR6nS8whqDReb591t9MhFnkfv4JfDN6qQLAmc3MWWcTaduC2qajZ32kAKp7TtkMp
	cWjN/troSlPeeExm5+snvA1hntIiVl8DquSilM0DtKdk1GkOUX19z8+ny4tQgh9EoEPk//9Zo1C
	a30BNIVxWBXfKN+M8IspjL5Eye7064OhRRD9OCs2HPlBebAP5tlVz3SepoqpNOcFKSdVaYZ78jQ
	/lU48BMPzZANUPCd4PvoJlbcUiZAV8DZ44EwAG9dNQjC3Ld3eRGUfpJiVVoi/9Vt9v2u1YQWZuc
	Peljb10PD5yJp1oOtWUzUj36BJBitChRNoz7XOdABNZB0YURbBvoYxDlgRgQtc3ZM4U721KGis=
X-Received: by 2002:a05:620a:4115:b0:8cd:871c:909d with SMTP id af79cd13be357-8f7d9c094a9mr1115297585a.53.1777477210338;
        Wed, 29 Apr 2026 08:40:10 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940340f1csm207924185a.44.2026.04.29.08.40.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:40:10 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 01/13] krill: fix missing dollar sign in FILES
Date: Wed, 29 Apr 2026 11:39:31 -0400
Message-ID: <731c5fc0b8146a59b721567f7c045b66ac75c46e.1777476608.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777476608.git.scott.murray@konsulko.com>
References: <cover.1777476608.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 15:40:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3875

From: Wenlin Kang <wenlin.kang@windriver.com>

{sysconfdir} -> ${sysconfdir}

Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/krill/krill_0.12.3.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/krill/krill_0.12.3.bb b/recipes-security/krill/krill_0.12.3.bb
index 472bac9..2a10584 100644
--- a/recipes-security/krill/krill_0.12.3.bb
+++ b/recipes-security/krill/krill_0.12.3.bb
@@ -37,7 +37,7 @@ USERADD_PARAM:${PN} = "--system -g ${KRILL_GID} --home-dir  \
                        /var/lib/krill/ --no-create-home  \
                        --shell /sbin/nologin ${BPN}"
 
-FILES:${PN} += "{sysconfdir}/defaults ${datadir}"
+FILES:${PN} += "${sysconfdir}/defaults ${datadir}"
 INSANE_SKIP:${PN} = "already-stripped"
 
 COMPATIBLE_HOST = "(i.86|x86_64|aarch64).*-linux"
-- 
2.53.0


