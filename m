Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93BFCD5BAC
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 10:14:18 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33290.1779358458035328597
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 21 May 2026 03:14:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=y1BcDMoO;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so636019f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 21 May 2026 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779358456; x=1779963256; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1lTHarQoq7k//kEp50shwfWk8FSb6nHA18jg31HX7BY=;
        b=y1BcDMoOQeScApVWL1Av91TCXuDIZK/UXC3Z69n8jnQNPK4xee9yWQ5NOciZDQzUns
         qch7JEsjMG2x2VN/pYsb1fDIpt571mszHoSfEKdM2116aDJ9WFac75vVll7q5appXryO
         MO6Hvsg7s+ZIAcYO2b0sHBi3D8zYciIsXB3q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358456; x=1779963256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lTHarQoq7k//kEp50shwfWk8FSb6nHA18jg31HX7BY=;
        b=O2Rtc4XewC4/eONfSCjLN+z7RvpDiCo6rdRudZErjOQmx51olicGmWCm9OWktaJj3s
         U1qP7VDlyUEwhH/D179Xd3iFk0LO/f1RdyM2RLvLZEMJbgtBLrfLSVaGnH61U1tqgkf+
         07TkRIr1wzimYrRNnDzO3ix7g5zitXf8EwvMtIpCor2e42GeuYpMA9ej5Ln53I7J8YTw
         m6cbpbZNJmzYaHZdDV4S57xc+Gf9U8GBhpClilfmOK9NekxTtsCBj3YeHXghfZzfZTnH
         W21nVED+id+lg94L8Lu3xD7086Rv4C7+2bG2dMmWnuP4T8lPADJ4d9hbZy61NgQ3rt5U
         jqbA==
X-Gm-Message-State: AOJu0YxWuuCSd/7D0bEb2dSRnnDOYapVhblGT/ALHEjRJnNN+qbN/Qkj
	7VFEZZPlf7J9od2JvZKpi/zdXn4m5cOkN8OZJ0GWOzjd6228oH3H3CQfS8d70w8mh5AZzUtzDkb
	lpvRT
X-Gm-Gg: Acq92OEAQ/1Nx+I9QaxN4lnYQMEpAqAEHs4AFp/bPBESX1a9pCiS+PRKPsFJ0oIwe2u
	7aAKqLTuZ2BA/3au77mxQLMG540zgiWUclQYf5W3PDujGbRk8hPlwLbuWZVJx3ohi43zYRI0b2F
	P3pjQ8EqtU+4sljCii+D7BzpJpCmCG79tci5oMTydw+LWvCHDxd7wD7a98FoyMkA07KWp+vwppY
	T+JwFMPKw5frYcedkmhd2cqCIl54nu6dTEIhnsSVtK8Bjc+ntoMF0TEfUJLrWg6+SuAhnEGPVRc
	zPuxBcUawEl5NP9n3NzFMlebJWc+kRCmzRdOKwUzYmlYaLg1T4fZ8zfVP/OqfJCwxhicDdbKxo9
	6qVR3EKlJLRWjAvbcBRcL1/85evEUUH9KXB/EmGQ05FKnDdiSIUOiN6fCgNGuyvrabGqL75e0Uo
	zr/mB1XEQGE9hvujZI0A2JJjR2BHY6zVYwIi1CXUkdvdsVZ6fOkrosZTfv57fpl2761EyqhJ3+f
	O+f2fAXn9yhkNbnWbisa8+EzXc=
X-Received: by 2002:a05:6000:2403:b0:43d:733f:aee6 with SMTP id ffacd0b85a97d-45ea3ae85d0mr3627472f8f.10.1779358456345;
        Thu, 21 May 2026 03:14:16 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7cdcc3sm1856710f8f.8.2026.05.21.03.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:14:15 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH] scripts/release-parser: allow whinlatter to go EOL
Date: Thu, 21 May 2026 12:13:57 +0200
Message-ID: <20260521101357.2316629-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 21 May 2026 10:14:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4004

From: Yoann Congal <yoann.congal@smile.fr>

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/release-parser.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index 5947dcc..4f928b3 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -23,7 +23,6 @@ print(f"Reading tag information in {GIT_REPO}")
 SUPPORTED_RELEASES = {
      "yocto-6.0": "LTS until Apr. 2030",
      "yocto-5.0": "LTS until Apr. 2028",
-     "yocto-5.3": "Stable Release until May 2026",
 }
 
 CURRENT_ACTIVE_DEV_CODENAME = "Blacksail"

