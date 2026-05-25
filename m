Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D9FCD5BCF
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 21:07:33 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24569.1779743243110607476
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 14:07:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=MK/7o5kS;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so47570875e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779743241; x=1780348041; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ug2EvHvpULhrEOL1Peb4P98yB4QDmurLgKKvgQozSlw=;
        b=MK/7o5kS6E7jEX+e4Djj/+FUm0XhnWUlzwjgjsNvOFZvjJnjwBJtAZ0VmEhaPmpWK5
         Xz9DyMoJ7AquOjAdEzMFv/Poz8x0B1Gjp2c+FlA2+lztZt18lVlzvpGb1V75Qank01+Q
         3K6hi/+wlUvhqmZp3ExemyiR8FxSzOZg/RX7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779743241; x=1780348041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ug2EvHvpULhrEOL1Peb4P98yB4QDmurLgKKvgQozSlw=;
        b=ibIlqSMAyJ4iaF2U1d95SEfdzK+QRuzlUVfZS2EtdmuliPBw8hdQJGszsjrCKpueHI
         enURtT5Lt4fZxmSJVfDXA8M3kvMsisdeX3iPRcWgC3B4PVjiJvXOwzyJq8MPnyZ4wV1P
         CzMLsH57jEKTjzvEa//SmSKtwQb3rtTv4z4X5Fn5SRsOvCs9ywX+eca+mW7bdf/kQKsv
         46V/RO9q8NcIMCt2hf6RKPE12LJtFKjvKrfNjrQuWudkOCAcV6QGPRV10NAw7FmjUbNx
         Ue3fBENzPegW3chdUe0KRnkvBNED2F5gt81T1RKsjNqJQVa+to1QbYEM0WZgC6Orr2Sj
         YVwQ==
X-Gm-Message-State: AOJu0YzDDhIAwRL39gLjSLfsLhXqa/+EH+qZMEmuvsdQjzGaaxuTBl1s
	7lKaMMp2DZlivtmzRNZK8fCPTWfS0a2W0spj8atueIfcSJKdSUK+YU34LpgPqjr0+mmonf7giTQ
	Qzojg
X-Gm-Gg: Acq92OEfP/UygiydAiLvjyPhupzRPPgWJM1E2qww9W1bbLkd1IjLmnlrBcSoxrmliy4
	UQEWEckpxBDMuOtCTBOpgOLO5YSOCxuNHVfzecpcW+Xj+YTdSAb1sAGm8YNNEdZGuZO0W4mugfF
	i0xe5w1gw/iAH1x6EI9Zf6h3TyYAkcrieLjVyzNHa7TMR3dhp55cCKrkmoCF3jpPjbQm8JIRPxu
	KMSukTFiHiDbsAnUbUq2RDSjK56GYjWnI0BCpw+UGHznq/nmxDqs4KpwPnTF4sgbC1DFbiZuIRo
	SEhZDSHnFBMm2QAlVxhSjlzAxQt+jgkkOLOpW4wVcx6JSxWHIQkhdAGvEOti3/vhBAKiu26VVBs
	p2W4/P2zQXqQPyU/pp/uAqTv75rewuinNAhxJe6iYNtKf4L5qHfVyxlolUrNK8K/Qtd9zTqmsi7
	KWgI3A4O/Wq531lHGBsjvJSE7tVlb5Xv2PmpcV/nk8NzfgKCVd5TjVjc4tuScSxG355gDJPYegd
	2WNwJEJ+Ez5AXO4CGqQx4VM5DM=
X-Received: by 2002:a05:600c:3e88:b0:490:4ee0:82ff with SMTP id 5b1f17b1804b1-4904ee086a2mr189505495e9.27.1779743241412;
        Mon, 25 May 2026 14:07:21 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ac6a6sm282941535e9.12.2026.05.25.14.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 14:07:20 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: Yocto Patches ML <yocto-patches@lists.yoctoproject.org>
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH 2/4] docker: add needed rsync dependency
Date: Mon, 25 May 2026 23:07:06 +0200
Message-ID: <20260525210708.2918572-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260525210708.2918572-1-yoann.congal@smile.fr>
References: <20260525210708.2918572-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 21:07:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4050

From: Yoann Congal <yoann.congal@smile.fr>

The "Prepare shared repositories" step needs rsync.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 docker/Dockerfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index 0a2777e..793343a 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -33,6 +33,7 @@ RUN apt update && \
         python3-pexpect \
         python3-pip \
         python3-subunit \
+        rsync \
         socat \
         sudo \
         texinfo \

