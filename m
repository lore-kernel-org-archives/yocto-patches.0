Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8441ACAC5AA
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 14:40:40 +0000 (UTC)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
 by mx.groups.io with SMTP id smtpd.web11.53793.1758552032901684501
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Sep 2025 07:40:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WpRiAzg4;
 spf=pass (domain: gmail.com, ip: 209.85.166.182, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-424b20f8b7eso12763195ab.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758552032; x=1759156832; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/T3u8vekaJHwHkcg0zw9c7evrPa5o2vpVZeW+ORm/34=;
        b=WpRiAzg42O/BnvC04mXt+5bygwLH9fzSny0WChqCmbWHFqmWMavNKVn77N6kl0SgSZ
         A2roN0Z5N+5yf93G+F2XM5xdbyKfdXYDMHGhiFeVAmF7mCruNKRSB8Wq/lVMwexHOz7i
         std6WFYQBygdzMkpla5VgBtyewHqQND6+nvh6lg7EGKWxdi3kDuKKu2PlJAIFVNIhQaU
         qBDlZcbnelUchTiHeAarMyQxc9bAMYT+dZ5il7FzLyZnMg7aEreN8rHDYtuE3qOomXhb
         eyFDpmxLFiKUHIcLQoQDXXdrRqXOs7XHN+hCkLLAU5lEqvHqFQrgUoaJlCSL8+SI6Y5T
         pD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552032; x=1759156832;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/T3u8vekaJHwHkcg0zw9c7evrPa5o2vpVZeW+ORm/34=;
        b=tsDznO8I27ofbyb/V789S3RcxsMT1dRnFf5MzRWr74xQoRLopMedojM+z4Bma5cfLb
         w0S1fZShRF/oUAQ3X3MHMF1lDMw0inNTT4cjNRcullM9CPorxuCUU7UP/2zYsPrKVzv7
         xSPqbgD8uYiYvLIFus3aN3Tt010FLaj4CMsG5puUwjQxXj+OiTzsAh/lzp7YzLk0fc4c
         gs4arS9OJIDUyHVKH5JABVq1px3NLZK148p0KSfeUnzQYj7fP2BWoBDLUW531mDuknQX
         gp3KDK2/jtnMdugWGjHUsUG5EiFfB7DHbPrqkN74SbW/r+w3w228PCMofDoJXMtHvnT5
         BWSg==
X-Gm-Message-State: AOJu0YytLs59XNv26cn9uAwEne7ukMS09sXAs4K+bp/vVXcSTKzydcFl
	EwVXLwjYA9aVCk/jYKUNi+L9+XBQaQwy3gwwJUWhMOt74OnNgaX9qF2peWAmXg==
X-Gm-Gg: ASbGncuJhp5Qh9nb7gVI1nY/MoTQXgovaSqf3Ol8ER+VaZ5Qn8UOPQ5McHbaSJnuUzS
	OmDPkMK0RzqzMfDJZTESa3EjUeA4JxgIi7O7W8zbJNOu/YGUvqi2SNM3DQxO31/Lt3Jv37WW0Gx
	sMi2ILNnwDEwbgD+Pc2Jdf4E8Dsf8fJrKEScfh5LzxlKmhe+zeXrZq7JNUnXJrDurz3J9fGNs+4
	idqwVPHPBOlfh+yzReLrCrNF2050GRCSmUS22eRWebamHvHC+J1fe8hgueMNS7YX+M05EgogHcS
	nVZumEc0RmmCQsS5fBSt/zXuoxHgmAC4rA01gYO9ixfft2dTByMowW5nPuqA/s+OmLX9qCxEvMV
	Hu97NTnyqgwhaO6UAgQplqKHKcq6jEocKvRufV7Og+X8x5QRPz+FVmFUcCAXSuBT/QoHbNXH23A
	==
X-Google-Smtp-Source: AGHT+IF7MUFQuceCevuvVZvg7CR9nIvgHJhxSbraBSPHZ5ZpafGidTpGSrlOS2HFnYzAwkpEXDthEw==
X-Received: by 2002:a05:6e02:1c05:b0:425:7974:fe32 with SMTP id e9e14a558f8ab-425797500a1mr54998595ab.23.1758552031896;
        Mon, 22 Sep 2025 07:40:31 -0700 (PDT)
Received: from [172.26.252.3] (174-16-207-42.hlrn.qwest.net. [174.16.207.42])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d539906dfsm5678364173.56.2025.09.22.07.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 07:40:31 -0700 (PDT)
Message-ID: <1dfffdff-0125-41f4-b5ae-b4670cc45152@gmail.com>
Date: Mon, 22 Sep 2025 08:40:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org, scott.murray@konsulko.com,
 rybczynska@gmail.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: suricata: populate SYSTEMD_SERVICE for service autostart
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 14:40:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2226

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

