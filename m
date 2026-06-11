Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D13CD98D5
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 13:04:15 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44954.1781183052656300678
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Jun 2026 06:04:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Gx0mMaO7;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so52861005e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 06:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781183051; x=1781787851; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CxLBhx7HxxEEAn6HlzcmwRtPOkte/X8mWCAJl51LK54=;
        b=Gx0mMaO7uIZ+YW/vjCL64j77eHhTOeFH7BqzbOPrDR3ycgau/xywMFUPV6m7HW30h6
         C4gbMaAKoEFRJgVQEdyYRC7BMmZcsHUkUEe1ROb7+oa6Cxj0fp//L+kavWo5lRpYVGEP
         ibN4M38xJsi7CiIVWpS6xnCyOxbrOjBpm9eQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183051; x=1781787851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxLBhx7HxxEEAn6HlzcmwRtPOkte/X8mWCAJl51LK54=;
        b=aNt3e91iUqU3TbvtZtqZOOLvcX6JzXvX6waIgXLB8m0EpYmBYi9ybZOmz/IzpzWypc
         wthdejaTpPnnFBP5ADYj7gCvNTUaQMbt5d3X3T2YA19rsmH99LU0MPCgxJY7rhh3L90y
         hbQtiJX4r8D+7ExRbi/tR4dpfD0JeSpnd/CUbSW/vu/59ycc4CfvSgX4F7zf9uLzQoAU
         u4m1IzN4WhEsZyE9Txl86Zu5WrGPdVu+3cLkth/z5r9xAiCdpL9Wvu3ayjJq3nUuspXi
         BfNemZ7l0s0cPwoWZQLHOnku/R/RGTJdzHIniNsdM482E+CDwx6+FuRdqZXd0mHWxIKo
         jM6w==
X-Gm-Message-State: AOJu0Yx8Jje5k+9JVhjRqqTPYLCryswIYNDLrOmAkGYEKOJfy/Svze/y
	W+F9U9++ovw4430SUxh/II8mAk5AUa7lxY49drJ8VNm6xn3yBdO6XOB6bCN9MpUJUFIUyRQZxPQ
	Mil0S
X-Gm-Gg: Acq92OHwkTTbb5hkAcVEiOWS9q6CoVdUI5sJhoClaa0cHgprPdMRPm1HpdZkNlosNWN
	q/12gt3G5xqsRBUJv30EmavN+uvcsyi/HWx9q4n6Z2TvneVfYJPK7G7YbxeyDO4JXdm15NJywRE
	SfUNe8HVBZEZkwA+NyqAvX/1S7+s6Nmnr2PgkEGi8mUNVyg8w3h5Jmeo0IlQDxxKZsXp0u+7znD
	j3UfKrmJ0Vz4H/8seehL9SfE7bV4/40WnwSR79/9d+8QQa/jZSdf46S5k7kGRw1kfLIyvOK1Ir1
	SSPMzI/OQYvBywkTLrj/dipBtWw0VxY0jLWmgLJvrWbbltYvW0NXBTiUwKE43HarQp39zSVxjQi
	/vqAtwJdWNguzEeanVc4g6rHVHUyvZJ/5YitAsN7ket4BnPpyVadXCQJJPe3NW+AlyaRMSAKodp
	Lw95jMO8wKTUZF0L8u25G16PuYVdzHhpzCdVx5Lw02oAGebQESFf+TMQ7bjlfXiRKDxHTxidewK
	AkULoOtA87QQll8zlohxUlJUW8ygF8HW5Pby3U=
X-Received: by 2002:a05:600c:3656:b0:490:bd1d:4732 with SMTP id 5b1f17b1804b1-490e5639467mr27899365e9.23.1781183050840;
        Thu, 11 Jun 2026 06:04:10 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0084744357c26c6744.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:8474:4357:c26c:6744])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e4129daesm34014685e9.0.2026.06.11.06.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:04:10 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH 1/2] schedulers: Drop whinlatter
Date: Thu, 11 Jun 2026 15:03:37 +0200
Message-ID: <20260611130338.484322-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 13:04:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4214

From: Yoann Congal <yoann.congal@smile.fr>

The whinlatter release is out of maintenance now, stop running metrics for it.
Also, its CVE metrics count dominates the patchmetrics graph:
https://valkyrie.yocto.io/pub/non-release/patchmetrics/

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/schedulers.py b/schedulers.py
index 0f41bd0..b108392 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -672,7 +672,6 @@ schedulers.append(sched.Nightly(name='nightly-reproducible-meta-oe', branch='mas
 schedulers.append(sched.Nightly(name='nightly-metrics-dunfell', branch='dunfell', properties=parent_default_props('metrics', 'dunfell'), builderNames=['metrics'], hour=6, minute=0, codebases = {'' : {'branch' : 'dunfell'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics-kirkstone', branch='kirkstone', properties=parent_default_props('metrics', 'kirkstone'), builderNames=['metrics'], hour=6, minute=15, codebases = {'' : {'branch' : 'kirkstone'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics-scarthgap', branch='scarthgap', properties=parent_default_props('metrics', 'scarthgap'), builderNames=['metrics'], hour=6, minute=30, codebases = {'' : {'branch' : 'scarthgap'}}))
-schedulers.append(sched.Nightly(name='nightly-metrics-whinlatter', branch='whinlatter', properties=parent_default_props('metrics', 'whinlatter'), builderNames=['metrics'], hour=6, minute=45, codebases = {'' : {'branch' : 'whinlatter'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics-wrynose', branch='wrynose', properties=parent_default_props('metrics', 'wrynose'), builderNames=['metrics'], hour=7, minute=0, codebases = {'' : {'branch' : 'wrynose'}}))
 schedulers.append(sched.Nightly(name='nightly-metrics', branch='master', properties=parent_default_props('metrics'), builderNames=['metrics'], hour=7, minute=15))
 schedulers.append(sched.Nightly(name='nightly-metrics-gitstats', branch='master', properties=parent_default_props('metrics-gitstats'), builderNames=['metrics-gitstats'], hour=4, minute=0))

