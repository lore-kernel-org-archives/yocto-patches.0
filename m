Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF6CD6E79
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 09:41:18 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.75659.1780998071356302757
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Jun 2026 02:41:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CYkFhlhs;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-46015dc517aso4267358f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780998070; x=1781602870; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yo4rnm7ydtQJFWFBDxbt2vmOvNrSQW2iuT+f9pFdbro=;
        b=CYkFhlhsbArXh6tQlpvhEN5TL4vXUpXxkSUZ8BoZTk8P1bdAAu2858wwvmrQec6xvW
         xo79P1nuCH6g3ehynEU5CzvWChZYJFP57Xcpy567l+uovpPvU1Hww5Pj7AOIY6TFe+BM
         hpNiOWaSTn6qMmu5hPesXdNOXKZKtwbHc+F52iX7u4J+hycuRu2yH78w5ZlIY/eIcv9z
         Yt6GrhEysmHyMIUQHBtJz5T1Iu1M8EUHzohFekUND7+A3IzkDub2SfTYoxyXDQuNjsCU
         MsTMaAFpAQ5WFb8w/DU7ZkBYsKOwW9MfzlW+tiuup8BbcboSmfkinAAJ4j1r1S0Sk7V4
         kGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998070; x=1781602870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yo4rnm7ydtQJFWFBDxbt2vmOvNrSQW2iuT+f9pFdbro=;
        b=RE1NJXE1wairbu3Jqqanw8ZpSIBrmJJelYyxk0Bgi/srRr9e/CLNLfvRetZL9DUxYZ
         EyGr6qOQtYAFn2UY/w4Q0a7iYP9N5Jc55iA1sfp5lGLkqBPZzXah/jQSj8wd0lZr7QL3
         LuzNL+ndfIfC6rOBXaO23TBhGD2oqr5tImaICJEehs65Tw6C3YQBOg7aQhTqUrFTjBJK
         vn+WL66MVi+GKO4BKDj63atgaJ+5Q1YG2OCtA2Qlj2Icn9bNIJRmV05v3MZ1zxa6KOEZ
         wTFzfYH8VsUOC7WPwTACG5+HMc76TgIqDqEKfEBZVXmgncbH2uBRC1PIR18HhixtlrfJ
         ZHqA==
X-Gm-Message-State: AOJu0YxcqZhgWt8MBUuSvaBffMgVG3DCKAdcmcS+YgIB/47fL7FdLjvs
	ngaW0HgwWrfPNXqvJSlHDIGNAwBAuouQ/lHRON/j7nDHoqqTUMFQVUI21gig+reB
X-Gm-Gg: Acq92OGWlBbfR8d8zR8xlDWSJq89cjkSdizl4pI0BHBAYf8tG5v02mmAB/G7Jr+Xrk8
	yEbHyMh7lVC1vcs9HpBNCAqSAKHUaAYbNAUTM0DN9StayGJtz3CayclTIiApU/UFJrP9j8YWZzX
	QBVtoM0ZcaydYxZwGgHKdT//ell/H2KxMDeAbfy3b88Fieyw4WtGryYxv6NaIpi0B3nRXrLK85O
	fcEXYzdpzV2Fu3CYiKI6jR5aeu54RqtyM90oy/7Tz9GxtM3j+DS6YovQPUUjc9mLwVm0i6MCFT/
	eWqXpNwJmIx14noysbU+GzhmO/jBon9rmKaPd7b4BMjt0XJdWuU8prw/GN7D8T0NSYgco3Rrt23
	21bKwaNOPK4BgX4hCzrqr/nFXWnzb3o9OQCYS0Anx+dkieFUR2Jpzhr9ilT3QmhUZrigYONBYdJ
	oB70xmoJoNlAxIe8juG+xM+E+jLMNgnVbwI8QKtSiBmyILiCy4QxKajMUDKji7uj+PkVrAE1tv+
	9Q32mGiNL3uOGyw
X-Received: by 2002:adf:e545:0:b0:45e:e44b:3136 with SMTP id ffacd0b85a97d-4603063a715mr23172625f8f.19.1780998069476;
        Tue, 09 Jun 2026 02:41:09 -0700 (PDT)
Received: from alex-lx-laptop.lab.linutronix.de (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm63986286f8f.6.2026.06.09.02.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:41:08 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [yocto-autobuilder-helper][PATCH] config.json/auh: configure for incremental version upgrades
Date: Tue,  9 Jun 2026 11:40:10 +0200
Message-ID: <20260609094010.897937-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 09:41:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4180

From: Alexander Kanavin <alex@linutronix.de>

Please see https://lists.openembedded.org/g/openembedded-architecture/message/2349 for details.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 config.json                            | 2 +-
 scripts/auh-config/upgrade-helper.conf | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 4904439..fe9d416 100644
--- a/config.json
+++ b/config.json
@@ -1591,7 +1591,7 @@
             "step2" : {
                 "shortname" : "run AUH",
                 "EXTRACMDS" : [
-                    "../auto-upgrade-helper/upgrade-helper.py -e all",
+                    "../auto-upgrade-helper/upgrade-helper.py -e all --incremental",
                     "mkdir -p ${WEBPUBLISH_DIR}/pub/auh/",
                     "cp -rf ./upgrade-helper/* ${WEBPUBLISH_DIR}/pub/auh/"
                 ]
diff --git a/scripts/auh-config/upgrade-helper.conf b/scripts/auh-config/upgrade-helper.conf
index a0d53c4..d7c6b1d 100644
--- a/scripts/auh-config/upgrade-helper.conf
+++ b/scripts/auh-config/upgrade-helper.conf
@@ -33,3 +33,4 @@ publish_work_url=https://valkyrie.yocto.io/pub/auh
 
 commit_revert_policy=all
 
+retry_any_version_recipes=vulkan-samples sbom-cve-check-update-cvelist-native sbom-cve-check-update-nvd-native
-- 
2.53.0


