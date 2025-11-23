Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C76BCFD313
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:53 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5056.1763941551934573412
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=oypBKe5B;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2e530a748so355902985a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941551; x=1764546351; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGci2DTrEBfigQCc2w19pIJ5C2moEwL/Q5U/OTUMvbk=;
        b=oypBKe5Baw77joxp2DiIK9MdO/hJJ7zorx5J4CkzAciOoX8iSKrgl195v53UeD07wp
         rQuMwuXMe5PXDImMBEuu+STBrTcu8E+vrRUAOdD3mt698lvJZqAsxm5Bzq44RRYwYgtO
         HFHqGmi+JfrZXXsX9fZTZb25jh1JFxp4QoM+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941551; x=1764546351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aGci2DTrEBfigQCc2w19pIJ5C2moEwL/Q5U/OTUMvbk=;
        b=QT7i5ARr7dbcb1WQ6f87TAG+OIZGgtahlXVITwrhKN4DVr0IQo7jDlbedr9G1NHGaC
         fbW8EJ8jMyVs+YFuZGfoyCcj86U4yHDJLS36WYQKRSbj4w7JqqaB42x95+J/zhDIB2wz
         67UykFC5UJ/xzSQ4DMjxqKcAFtXY8VstKN4Zk/hww5BUJpbcckbtLSM4G2PWvOSZepHI
         sh7tRxW0T8a4LHazy378G0kACeHG1Wf1ZT6KDg8mNmimnj0poNLxAOrmK41PZht1MtbW
         K6J4VXDHa7AULgDEM44lXXOwlNpRMqZN10ENzTb2+QV3/VpMaRkjIeRdSzm+GYfvQfHZ
         WU9g==
X-Gm-Message-State: AOJu0YyC1XpwXXcNvBEjVGZftHCaTIs2tt4UwC90yi9sTqnsqMs8bbVL
	5n1pKoBivPLj9fQnZHlI4SW7Tnak7JZw7/MZ2TFSlDkdsl1ULhXq00u2kNzdc7ow0d1PNQ5y5rn
	iV6Zj
X-Gm-Gg: ASbGncv8QefJD/qhef+OzLANnnE1QvhbX644aD5ipREdc5uMImaLoOStMaGf9Rt6I8B
	0W/km67xge9HgAEIe8kbeZlP8da6Gl5KKO2FaInd4itAglQ2WtF4JQubOcnyRSjlbzJ96HhQBXg
	CM57XFrJOgoBHjJshB0cjk1wWf1509SgTBIxs40uSBBPlZdVBomk4jqiQNzFtQ4WLwjgcpNWUYk
	mNMHkj2tAhiMr364f9leMcAN2yxBvRmOxLGpP0lFPlzIh+8DK2++7faNxqDAtzXqXDN+z5pckqt
	kn5Fxi7nCMz2/FTUeoLtsl9/u6dm1TlDqXSIKf1tuGqamoOtwzI18tsLLi1D3ZRIdOgDT8L3ud/
	gOV66Is3kgrB5ee2FlUvHi8gRpgdgWAHqGVf2o5WGOnERRQP9/rNFSTwlyP4XhWLxB9c2XN2ot0
	T6eGdUWcm+94+x4qT0YTu+7bRzq1w6UmZaT4TIIVOgY3BMJppZZy55QzzUvX/UORM=
X-Google-Smtp-Source: AGHT+IExNGNtJOMM2csfey4EnBpp1+rARryfNtd6ddaT17eEUIaMu5Oh30KOK9/KejJSDl8wxlSUew==
X-Received: by 2002:a05:620a:2910:b0:8a2:45ba:1b5e with SMTP id af79cd13be357-8b33d1f01a9mr1284318185a.28.1763941550478;
        Sun, 23 Nov 2025 15:45:50 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:49 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 31/32] suricata: populate SYSTEMD_SERVICE for service autostart
Date: Sun, 23 Nov 2025 18:45:11 -0500
Message-ID: <282d281042995e7927812031298ca17f8a0445cd.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2689

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

https://docs.yoctoproject.org/dev/ref-manual/variables.html#term-SYSTEMD_SERVICE

Before:
root@beaglebone-yocto:~# systemctl status suricata
* suricata.service - Suricata IDS/IDP daemon
     Loaded: loaded (/usr/lib/systemd/system/suricata.service; disabled; preset: disabled)
     Active: inactive (dead)
       Docs: man:suricata(8)
             man:suricatasc(8)
             https://redmine.openinfosecfoundation.org/projects/suricata/wiki

After:
root@beaglebone-yocto:~# systemctl status suricata
* suricata.service - Suricata IDS/IDP daemon
     Loaded: loaded (/usr/lib/systemd/system/suricata.service; enabled; preset: enabled)
     Active: active (running) since Mon 2025-09-22 04:05:08 UTC; 20s ago
 Invocation: 8cfeb29631f443f0830bffeb00975931
       Docs: man:suricata(8)
             man:suricatasc(8)
             https://redmine.openinfosecfoundation.org/projects/suricata/wiki
   Main PID: 268 (Suricata-Main)
      Tasks: 7 (limit: 4915)
     Memory: 36.8M (peak: 37M)
        CPU: 2.222s
     CGroup: /system.slice/suricata.service
             `-268 /usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0

Sep 22 04:05:08 beaglebone-yocto systemd[1]: Started Suricata IDS/IDP daemon.
Sep 22 04:05:09 beaglebone-yocto suricata[268]: i: suricata: This is Suricata version 7.0.0 RELEASE running in SYSTEM mode
Sep 22 04:05:10 beaglebone-yocto suricata[268]: W: detect: No rule files match the pattern /var/lib/suricata/rules/suricata.rules
Sep 22 04:05:10 beaglebone-yocto suricata[268]: W: detect: 1 rule files specified, but no rules were loaded!
Sep 22 04:05:10 beaglebone-yocto suricata[268]: i: threads: Threads created -> W: 1 FM: 1 FR: 1   Engine started.

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
(cherry picked from commit 0b7b0629bebe98237ce3060ebe132db05cdcc3b7)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/suricata/suricata_7.0.0.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index 021575f..62baa35 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -156,6 +156,7 @@ fi
 }
 
 SYSTEMD_PACKAGES = "${PN}"
+SYSTEMD_SERVICE:${PN} = "${BPN}.service"
 
 PACKAGES =+ "${PN}-python"
 FILES:${PN} += "${systemd_unitdir} ${sysconfdir}/tmpfiles.d"
-- 
2.47.3


