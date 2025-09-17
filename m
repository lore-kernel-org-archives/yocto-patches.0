Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67153CAC59A
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 20:43:15 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.web11.34464.1758141788709910476
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Sep 2025 13:43:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Dgvwr9IH;
 spf=pass (domain: konsulko.com, ip: 209.85.222.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8250869d5d8so30418985a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1758141787; x=1758746587; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVKwWfiu9fU6IEzC3bBsAStzu17JfkeqIWBwIK6lLWg=;
        b=Dgvwr9IHqrFgqGzk6f89zTL4jD6KJGSlvzpjQAL2ZP20RFXHa0xjp4uoeUrpm3rNKW
         dUyxw0oT3qbVlbP1WjfvfxyDwJAY438k2ufvNvlODsvx3RgCIF5xKcLx9Vh3QIKDz942
         s5BexYu9i+jIFc3UHKwU2cz0+3sjRl5WQXHsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141787; x=1758746587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVKwWfiu9fU6IEzC3bBsAStzu17JfkeqIWBwIK6lLWg=;
        b=rVYV8HH0f3E9Sxyl5TEbXqoiLSRM/NmkbpclH/LIvLNBnACh+ChHlBS4nxpbHGxGwW
         iqNsQgaCTvPE7W4q6viPVPXM3eCyv1MfcbgsG05rWBT7+amCa5uQxuRwjDWxpQ/D8Opn
         U3kqBlywhAAvNU0E4U2tU2PQEFp4hvXGx77VOhZj5sinC7H9vomVIfPFJSzI+KWNXE+I
         DgzLcR2fL16wt/vn62O9cW3OdDa+wEgZlVcphO9Y0Pum4ZvAo4PwrRR3bN4tctv5Tbhf
         E2yasC76GxTKmejLzZRhdqUeB8S6KT4Jh8m5CJJyKbBxwJi7DxsHVKndT/kcNupIGnjB
         HUwQ==
X-Gm-Message-State: AOJu0Yy9yiHUzZqyDfTEAuosoMhmvc31u+Q+IAh/juY00tnxI1JHjGZT
	VY8UBHfONj3Ra2ItNxzxLrs2pKfFd1SJdK3kJrR7qYNQHOsDZDYI6ZxeYbPVjPiVzgfHw4aDt5H
	DbaEr
X-Gm-Gg: ASbGncvR1qGjnNESkpCyklrGo0VGx+28EZIzqNCgaNR5NxvA/KspWbBDglZHaQxC3Pv
	3+VxDyyVj0MPRYYFSQPQ3wfoiA60RKJ7yE0dqREtVfj2RJQ2LvHWUEOJBee1A4Bdjd+tYdEl90B
	EKcIXvSAcJhzVVWMsqrSS7pOu/SFtq6CIC//JB1GsiM6jzX1DtsBGbjLggrF+lWLcriBY9vPJ5v
	Gd/0/NBP92JaKldymNc4yeSrdnprStpE37JStYjoNxObb+dsxPEc02X8qc8I76bPNu8OQfnypKm
	FDRrvMxW718Ntub04yI0ptql+ug+LVraTcsPebB1vOdEoDJ6oqgLf2hMsNBx/bNd8vJQxpWWgAY
	jOa9T5qi4/UkAbIIH/COOoun+Eyc2UuShN+FKPIyuL+E/RHo79WYokBXaPF8NPYoT5JYJ/R+xA1
	MafpPOs42h
X-Google-Smtp-Source: AGHT+IH/mUj1HR40kp8mcszhPdpZnEBEmeCuaAQcrzjLO20AF368Aq6rfVIuLbrbe5dwsmsknkI9vg==
X-Received: by 2002:a05:620a:318c:b0:827:5809:3a4a with SMTP id af79cd13be357-831143a2fafmr356297185a.52.1758141786835;
        Wed, 17 Sep 2025 13:43:06 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836260ccccasm42991385a.10.2025.09.17.13.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:43:05 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 2/5] suricata: install classification, reference configs
Date: Wed, 17 Sep 2025 16:42:49 -0400
Message-ID: <9a49fcbd05e46cafb0a2300a035a9528242bd4b2.1758138771.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758138771.git.scott.murray@konsulko.com>
References: <cover.1758138771.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 20:43:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2209

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

suricata.yaml references these configs

Resolve:
<Warning> -- could not open: "/etc/suricata/classification.config": No
such file or directory

<Error> -- please check the "classification-file" option in your
suricata.yaml file

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 recipes-ids/suricata/suricata_7.0.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index f2df09e..f02d343 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -105,6 +105,8 @@ do_install () {
     install -d ${D}${sysconfdir}/suricata ${D}${sysconfdir}/default/volatiles
     install -m 0644 ${UNPACKDIR}/volatiles.03_suricata  ${D}${sysconfdir}/default/volatiles/03_suricata
 
+    install -m 0644 ${S}/etc/classification.config ${D}${sysconfdir}/suricata
+    install -m 0644 ${S}/etc/reference.config ${D}${sysconfdir}/suricata
     install -m 0644 ${S}/threshold.config ${D}${sysconfdir}/suricata
     install -m 0644 ${S}/suricata.yaml ${D}${sysconfdir}/suricata
 
-- 
2.50.1


