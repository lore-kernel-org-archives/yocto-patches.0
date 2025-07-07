Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E45C71130
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 19:12:48 +0000 (UTC)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
 by mx.groups.io with SMTP id smtpd.web11.583.1751915560400599672
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Jul 2025 12:12:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LNucvksX;
 spf=pass (domain: gmail.com, ip: 209.85.166.45, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-873501d2ca1so68340139f.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Jul 2025 12:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751915559; x=1752520359; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SjFYPVjcqI8aA29zKgHrGE0XxZZWQPeuL4moPdsN+s=;
        b=LNucvksXS84CxtVTUCT93W8/mdcDi4Mimugv1St4Hx0txiEvBk4jL8T+z8Va7UTFv7
         DJYeAGtzfgw/51XtCYYX5aWRA592A84O4SNtTark5QnoGtvwbc9JEwgXbkB3BPMXmOn3
         MX/aHHeOduL4g6PGw8IAfvghMvM4CxmgSkwSTZV0l3Yhbje7CoeQkqTuqW8swFFrzm4s
         lxGCu6o6yP9VTHI88i/0kwSnGKcYWnRxsVzmTE6no+/4gM8ATgNptooPW10wovKL8QqB
         ObQHelJwwuyNWKLdLtETrb25xAOhMqbQeYmVqIPsa6mNPclUObWCVuU4gpVCBmvUb7z4
         6l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751915559; x=1752520359;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9SjFYPVjcqI8aA29zKgHrGE0XxZZWQPeuL4moPdsN+s=;
        b=MVWs9FCvWb0KzSq8dYKUtBDZYIknUjabvRijs96p2lImye0gaL6RXWK3/FlBs9g4Kr
         uz1aJN1qJgq/DkGXXn4imwW8RvcRZVQ/GN8MAAFt6t4lawYgGa8RPHpGInMAVDDaloU6
         iUI2e5uM2zZSQsWcKXUOv12It82830Tq/qYxfIxXVcGtps/f5GGJ+h2+w4FKa3vupvTT
         GJ3+6slxxJgy7NePPCfV5u+ZZRbEvOvwPj+LaI9qRvrK7dMMFMf1pS1k/aJY24WKtpRW
         4kSuBwCBJOaAqwn+C0RSpwoxaH4QJbcoRe3XvIAq89KD+s/5KYlsVUQdomEzQ1YAtii+
         WnYQ==
X-Gm-Message-State: AOJu0Yxpocoq37L624gnGaITW7yKmrcCm1G+4wTloXLIW5NNfPdWE+3y
	0xWXOx1yPcR5iM7VifsP1TJg0wsWKY3EHUJChoI5Wnmkf5yhGB7ytmvSbs71CQ==
X-Gm-Gg: ASbGncsnU/o9fwzoEj0EVhwxV5F06Ay/dy+QxvW5EX04N/6J1yv08DHC3PWqQ+nt5j/
	cXCiHCntZaYuTtPLxqOSMGvxL39DbmseqNr8gtGlHrAyNtA8JS+bcU1z+SX5Hln/2TJRaQiGALP
	8z97XGm3Qa5tYRxVBsWedkb3uE/KvmIgrOla1UTvhPCIu8b2tFa8+ytULY2CUNfqMs9bhCiCanm
	/LgDCPU3GlSRRBV86Mh660kU1lk+XMWiH6+cAH8XbBSredxBv8hIoJ270WsewlfGKyeUplao2op
	Y0X2A0Ljjs8KSEGBAsVmgOKrdRca0daPG/KBgnF54MjZdIXbhPhi3p7rPQfEm9zbNxgb7IqiUG+
	VsVyaFEhhsuh1H/BX2C1c00QFktPANY9EOBsis1M=
X-Google-Smtp-Source: AGHT+IFP8qO5f67bPjW1vurr9AK+IWfB9J9dSvOPK3Y8Gc757jgQ4WPbHv0UWUdfcS7UtLSfB4PVrQ==
X-Received: by 2002:a05:6e02:2510:b0:3dd:8663:d19e with SMTP id e9e14a558f8ab-3e136fbc625mr100824795ab.10.1751915559497;
        Mon, 07 Jul 2025 12:12:39 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b59fe4bdsm1782769173.53.2025.07.07.12.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 12:12:39 -0700 (PDT)
Message-ID: <8b7d92ee-d8ba-4639-b3cc-3e32d7984a57@gmail.com>
Date: Mon, 7 Jul 2025 13:12:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH v2] suricata: fix "interface" arg in systemd
 service
To: yocto-patches@lists.yoctoproject.org, scott.murray@konsulko.com,
 rybczynska@gmail.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Jul 2025 19:12:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1779

Fix service startup

https://docs.suricata.io/en/suricata-7.0.0/command-line-options.html#cmdoption-i

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

v2: use imperative mood in commit body
v1: https://lists.yoctoproject.org/g/yocto-patches/message/1571

 recipes-ids/suricata/files/suricata.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-ids/suricata/files/suricata.service b/recipes-ids/suricata/files/suricata.service
index a99a76e..bd7010d 100644
--- a/recipes-ids/suricata/files/suricata.service
+++ b/recipes-ids/suricata/files/suricata.service
@@ -9,7 +9,7 @@ Documentation=https://redmine.openinfosecfoundation.org/projects/suricata/wiki
 Type=simple
 CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_RAW
 RestrictAddressFamilies=
-ExecStart=/usr/bin/suricata -c /etc/suricata/suricata.yaml eth0
+ExecStart=/usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0
 ExecReload=/bin/kill -HUP $MAINPID
 PrivateTmp=yes
 ProtectHome=yes

