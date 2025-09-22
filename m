Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F38CAC5A8
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 14:45:10 +0000 (UTC)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
 by mx.groups.io with SMTP id smtpd.web11.53890.1758552307586692150
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Sep 2025 07:45:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=T9rNqksl;
 spf=pass (domain: gmail.com, ip: 209.85.166.175, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42575d46250so12321135ab.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758552307; x=1759157107; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkTb0nPO4ziO3uE5UFJMHDSq+/+d5xNy/NxZJZWrGvo=;
        b=T9rNqkslYJqXJ/Lm8nCIzhuYWtjTBLz7ySEJ79RBoDPqwmoEkVsoq87ilkmKXzTw6F
         lmFOYwFtzOdLScWjbozcoxbEOk9CT8G561l27ePpRnc1NCk+7fDjV+deKuikzExxS3Rf
         /ZCvwc8AOTo8LGekeHhEIMSElTjz/S6w7312prCC8nPFhgBEXas8Mnex1Sq3RPST284p
         w1jFHrm4T/+tpXsPtBYQj5VtdtomejLIl8GBB8owhCSCKZdxjxvr93ZPNwDGJOj1fXir
         C2TJcV9M5wEx6sOImUSten8HmZknUm+lMPuzHNSWXTgrCYVveyc2sjbXZ8N6zBojECJI
         os9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552307; x=1759157107;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GkTb0nPO4ziO3uE5UFJMHDSq+/+d5xNy/NxZJZWrGvo=;
        b=RBQrtE5eifXcggBqaAcXgAdxylK7VSSQ728GfcFSGypEBKWX9p7WhmFKEWj7LTilkS
         4al+Z3IBskSFjy/IvMTRA7zbEjjbhcRVDVmMFtF0SCp4mYGToTahgmZnEItBe4/qF7RR
         8YIhV/vJJtNfrIkNazOPGRkvO4BU7l+TMy3UHqCe48CRiG59nijJxbZN1IoI0+1SGdc7
         LPNlJQcQ4QXcgV/gAnTtRellZO4ko4yXGOAXbUxLS0DEwSfp3kwDpl9g+lGZMiD89Bgd
         GAruJAUPPZuKz9NOG45jK7Iz3yX54GPhdMoxA7HNWrLT0TiPJqEg9pwiJ/xuWEJ4kny7
         ZD4w==
X-Gm-Message-State: AOJu0YwwOcDyinVvULsxsukIgWM7mkAvEycnuWpCDzFbgS4hC2evRs6T
	RyEEsFv6atI/B6HgB05K+Hh0iW476bOr58qJ+P6vOy8So3a/FWp3IIIiZ6r8Eg==
X-Gm-Gg: ASbGncv3X7nCU7U0mc4RMEBpm90f3pyHkvx1N6WEIX3GLlAK6LhiugJEFCkASDoYmd4
	sHM2zoTAMPOGoSOYy8qTVno+sNPSgLQrQ3R028P+AVM8C3hVwlKbzGMAImae9lLqXVnrtuzwMaA
	ttCrVorPPmnDW//ZBB010SspvaB/HrPP+YJr+1Z/AnKWyM9TCQjTvWZ46PVJSQlE4fpTQfr7p9e
	aeNPRU1xFCeiBHi0cbHuQhV63aM73XZTcMhaPw0piJDfHAwSbLoqzaNnrNVxFo/f5zgv3YClenC
	f04g0rmuQ9pDtAj3Ci1CmRjXDAxCfr4EV23LWBZ3lAhgkePLV9zqVtD9V5z40mlpCuCJ3IsX9wV
	naN1XK5ogu+rc0uaQK+rnI68i79QZJ4/mAfznMkqJKpWy+9xgJ3B++5OSS/Sqi7ZgvbdgbPjrSA
	==
X-Google-Smtp-Source: AGHT+IGO6sr9bLXrcNQH0Pi2m+hV7uhmCSTS7o4UOD3Z7pjb6vRb+HkN0KcBAOUYToUCqmSChB7HMw==
X-Received: by 2002:a05:6e02:1a4b:b0:425:75c4:b54a with SMTP id e9e14a558f8ab-42575c4b7f2mr61853735ab.22.1758552306521;
        Mon, 22 Sep 2025 07:45:06 -0700 (PDT)
Received: from [172.26.252.3] (174-16-207-42.hlrn.qwest.net. [174.16.207.42])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3e337de1sm5720989173.25.2025.09.22.07.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 07:45:05 -0700 (PDT)
Message-ID: <0b29a4c4-1abe-4ebc-ab80-45d03b807b09@gmail.com>
Date: Mon, 22 Sep 2025 08:45:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org, scott.murray@konsulko.com,
 rybczynska@gmail.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH] suricata: populate SYSTEMD_SERVICE for service
 autostart
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 14:45:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2227

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
---
Sponsor: 21SoftWare LLC

Resending to add missing "[meta-security][PATCH]"

 recipes-ids/suricata/suricata_7.0.0.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index f02d343..c36fbf1 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -139,6 +139,7 @@ fi
 }
 
 SYSTEMD_PACKAGES = "${PN}"
+SYSTEMD_SERVICE:${PN} = "${BPN}.service"
 
 PACKAGES =+ "${PN}-python"
 FILES:${PN} += "${systemd_unitdir} ${sysconfdir}/tmpfiles.d"

