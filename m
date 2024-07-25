Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBC1C3DA7F
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:15 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web11.32094.1721898132256139380
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=p9U+Kjun;
 spf=pass (domain: linaro.org, ip: 209.85.167.53, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f025bc147so716792e87.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898130; x=1722502930; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4boPpXZPcduJ/g1CgwngAVZuip4tiO88+2jyE5EDQqw=;
        b=p9U+KjunClL2UmyNv8XfWbG5YrVBoznxKvZ+rm5f9qC/gCHNO4Sv7pnyVnIUYf33nh
         t0Z9cr0iNF126gJBf1yVRoxyUxYnsqfnVs3ze1qY3eb3QmWs+2fGqtRG7TW6jjUGXw22
         SuyfIfx32JJKjWjm3tYpxXndTwtsA47IjFdlSlDi6wm8w6ilCmgiw+YN+ZorJtoyOZfi
         G1qbSz7uxiFjzjlICOnpe6NFnpclqwbRGzhbA1w+7uAf63dsk30d9M3qpqfQXBD3lBjU
         uCEyLJfg6pi3Lefge48n/XRrinQ6QzI9OPvzcQxlj//8uGPJE4Mer1cOVn8F91BQk8Or
         STeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898130; x=1722502930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4boPpXZPcduJ/g1CgwngAVZuip4tiO88+2jyE5EDQqw=;
        b=ktFzjhYhtZamL3HvdlPIymq2dvcMw0eplCDraD3T+eBt5PTZN5+BJTPtmRthYQDNiH
         E3/+SJbr/Sjk1G+SSyRkHXYQ6zQFhfwpMIjdErbrd9Ev/FLckzYxmg7/c1jKpk9Y39y0
         gBayO/kH2gXIG39VdN4NMw2Jlobu2visPy0n7Y2qCFHJwEaRl5CD90S4oeAbCqZXIPsn
         UpAGpxgOT41KWzH0tY2MhSMFjuZq3jSy3Fincnt0jJfLtxpyceENK6q2Tah+ggBtDJlv
         kO5SocKz0uOlIRYe0/byJ49UMi4Vk9WrkFnj8l9Yw2XhTe5c6uWISCwswqQ+XqQfGPIT
         eKCg==
X-Gm-Message-State: AOJu0YxFzn3IEzBcyx3KJ1hg+MtGzs7f+Z/Qmt2FVifxoOsZnKTzWjYG
	p504rdVR0Xrcvs+m4JmcYemXX9F4uhj3pFvFPSyqdz90xeMAIky3Oldvm3pEefNl1smGQ54ZbI/
	O
X-Google-Smtp-Source: AGHT+IGriMWR/W7WpNWUwgb2WE2GqvbXzqm1KofpStrnxXVOMafEtDHgCR3zKQmaF0o6bd5PTBfzkQ==
X-Received: by 2002:a05:6512:10c2:b0:52e:9958:1a66 with SMTP id 2adb3069b0e04-52fd3f14166mr1592246e87.23.1721898129928;
        Thu, 25 Jul 2024 02:02:09 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:09 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 07/17] parsec-service: UNPACKDIR fixes
Date: Thu, 25 Jul 2024 12:01:21 +0300
Message-ID: <20240725090131.75860-7-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/464

New poky uses UNPACKDIR instead of WORKDIR

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


