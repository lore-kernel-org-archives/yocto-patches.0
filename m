Return-Path: <samuli.piippo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE35ECA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 06:58:28 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web11.14160.1755673098846779719
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 19 Aug 2025 23:58:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HXB+M3hS;
 spf=pass (domain: gmail.com, ip: 209.85.167.44, mailfrom: samuli.piippo@gmail.com)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55ce528022eso6517238e87.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 23:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755673096; x=1756277896; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yhzMLyNd/KJVt6Ueoamok4pj7WO5skNJSQUtNvYaqHg=;
        b=HXB+M3hSe2Xp4gyT74J3PChPMpIMJ0aeP9HUx1qe7F2BwJ7f7etlBJVC1WPQosZ+qE
         vGDqvDt9HIjUmwpDLCBCPMvf6/JDOnt5uBFH44n02tAQt/setNWsMFqF2wUU+cuJDez2
         YQHlPaGP9bknFcZ2IF+iBVbCPmS6BlJPq6OwSHr+A1+rGe1cW6S948CoMD3PD2pp5G5J
         TYMzgXgem9EmPqD4n33TI+y3rfFFusrBR7TwE0wA2NIedP6esICWqj4FcA/qWPHtWv6r
         HGYB7kJs6wa7bmD/kFnWddYcgJMbKNCNRlEX/TfySThUBo7YF8lI7jZ8XRUOtsp8Qml2
         OXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755673096; x=1756277896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhzMLyNd/KJVt6Ueoamok4pj7WO5skNJSQUtNvYaqHg=;
        b=R1sgQbW7CoLkXrX8qiH/QkspasvUT1NTpHx2mjUujZOV7v/VONtE2HkByJLYFFd3PX
         MwGIPG30HK11qY02n4Nme5bvyYAd0TiHXTNTYm75x5IktEfWJ8gKdOd4wUA0PpQ3puwo
         2xjql6W6/Ach6wFmHczcMzo89nDhix2u1Txf07GeooPCdlKviimIlevAiOCxgihTvH41
         o3lZcSeO8vSGR8AFcGYbKA4LbQkPrZSmFK442l0R4Yv+l+PuY0RA15EmooHXUy59wtvC
         XHKNlvRteTDe1Oqrd6t1wiaX5k3WXnIM+2dsty+EVM4K0OuHEJ3wfDNo11j9i38D+EwA
         Kxsg==
X-Gm-Message-State: AOJu0YytKD2zTpPloUvHwUHd6gt08IF2ydQmvsjj8Jrfef/mMRk7PgnE
	hEm/vys2xvqdmQBoETyi3u4kaSrHAtl6EZZwUWNE6tE0E6yINSH09+Z+AqUh2w==
X-Gm-Gg: ASbGncumsBVVWqvN04dU6fDq9iU0zRTxs9edhejVpdBMu3jTAYO0yJOOh6ARuwRS9az
	aIWHOkjhyL5gOvBR8Qj8mcF4YbH3LTzLbudT6JaZORrSHfdbOuWzkvQhnp6koA5+QOoTGr9JL8s
	83eyh2t32fZtnlNU6WGSjHpJgZOgZnLxxTTeyteBE3mpsLxMoE6bqGarYDAiI64VLjifC4TPL8L
	nb676PKVXuNHPeAL1YY5rODaNtZyFqBdjsXyaUyMkmoJiFWZv/g9pHSwtEnGKbLK2qeHFZRWBTb
	c4i87jnWZ+c3BZqBIesgeL5uuFtsW6a8xICwru/nHFNAVliJ/n5dgX8VCY4CCkWDgZ6q4BzMMOL
	vLF8B65qx/XxBul3LDDBoFfo/hJv4xIQ=
X-Google-Smtp-Source: AGHT+IEmJ2R5CLJpqpK8TNOXr3gvhCxrA7711995E7wgBVlCagUrQUHR9BtJZv+ZYF2LRmtDEWh68g==
X-Received: by 2002:ac2:4f01:0:b0:55b:94ea:1d38 with SMTP id 2adb3069b0e04-55e06b590abmr487238e87.16.1755673096206;
        Tue, 19 Aug 2025 23:58:16 -0700 (PDT)
Received: from dcbuildsrv.ci.qt.io ([192.89.120.62])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35163bsm2491530e87.25.2025.08.19.23.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 23:58:15 -0700 (PDT)
From: Samuli Piippo <samuli.piippo@gmail.com>
X-Google-Original-From: Samuli Piippo <samuli.piippo@qt.io>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH] mingw-w64: use correct path to license file
Date: Wed, 20 Aug 2025 06:57:56 +0000
Message-ID: <20250820065756.1295786-1-samuli.piippo@qt.io>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 06:58:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2062

Amend b7ac9777ad0c4512f1a63aa6bec4ecedd91783e1 and use UNPACKDIR
also for the license file.

Signed-off-by: Samuli Piippo <samuli.piippo@qt.io>
---
 recipes-devtools/mingw-w64/mingw-w64.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/mingw-w64/mingw-w64.inc b/recipes-devtools/mingw-w64/mingw-w64.inc
index 97315f4..a24e96c 100644
--- a/recipes-devtools/mingw-w64/mingw-w64.inc
+++ b/recipes-devtools/mingw-w64/mingw-w64.inc
@@ -1,5 +1,5 @@
 LICENSE = "ZPL-2.1"
-LIC_FILES_CHKSUM = "file://${WORKDIR}/mingw-w64-v${PV}/COPYING;md5=bb936f0e04d8f1e19ad545100cee9654"
+LIC_FILES_CHKSUM = "file://${UNPACKDIR}/mingw-w64-v${PV}/COPYING;md5=bb936f0e04d8f1e19ad545100cee9654"
 
 COMPATIBLE_HOST = ".*-mingw.*"
 
-- 
2.43.0


