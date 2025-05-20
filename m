Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CAFC54E65
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 23:42:36 +0000 (UTC)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
 by mx.groups.io with SMTP id smtpd.web10.5131.1747784548362823173
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 May 2025 16:42:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=J3SPCdVX;
 spf=pass (domain: gmail.com, ip: 209.85.166.53, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85e751cffbeso429533539f.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 May 2025 16:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747784547; x=1748389347; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRoklrAl4WM/7CV5CCb/iH+L4xXjBgdG5QIEYm/1mu4=;
        b=J3SPCdVXiptdXOPbhDcKPBh8tEpMjW/aA7qIzUFX0XODRyLs8RRbRzIGFl0b4wF9BF
         WCPVb8F55xIs3Jg5xHzyqFgY2SPjKa9fMPIy1SObyzch9CIrBdWR0ew+PxaUFh8Q0ruQ
         K4Xute9PPgFx+7ieKR/NLNNfnzOyh19PFVfSgmTSN9NzJehmlt7FPaztBTfC9jyN9nEi
         X96NpXB9VQdEcBfgQ52BL9pjcGX+UPtITTW1+Uf3KYnmsMWMpZuxF+8gOWl+BIdqWKgY
         Sdu2t+2ibCtSYdXgK/H6LRdexTgwRftK+T8c3eC5TXWqcKQSUp1f3tlNF43+eXc8MkIk
         Wx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747784547; x=1748389347;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zRoklrAl4WM/7CV5CCb/iH+L4xXjBgdG5QIEYm/1mu4=;
        b=OcC8aPhf3JztXZxz23ssuPCT6TK8fHe/XbXgvoA9UqNH4EWXxnbJr1XZLare94+v5q
         esUHNenmSAoxIiowRbbZR1XahUZfWgDEGJPIZz1ZRQmZ9hUmqx4+ZWLNfKnLn/hm3vwO
         8wX2OqeQr8688VGsfEcfwPLmTkbEGtLnV8dg9XPuPn8UH9Frja9sI3+yaEtskjwY8986
         l5ElrXLbrsbYiELda78cXBcoL7uiqxy3ZKDg5dXG+sQknN0x7veWaN4Wn8NLXzAYEKbC
         wHQ8z6RsshmNoNj0xBqITyrA3Ar4R/7Z8IdTXuHSfAV9vKkLOoK4N+Vdk6N8btYv6mbv
         tX4A==
X-Forwarded-Encrypted: i=1; AJvYcCVZj2DZpCeoCxdt/EsI5Kiv8uhH8ODZCPZPxCm29x3eh34xnuychaSvOKpyJxm9jOzz3QX8l7ua5IrM6pcF@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yx9tiMi7/rqGud/ZT7x1GkUswsllB0W98kJUu4jEarBFtEYINBw
	hoXZ3LiSnEV0r19gdF+m2ckT5c57eN/MWfDo75PXHWGbJt/mha96cw+M
X-Gm-Gg: ASbGnctIftrnwz3mKWLjYwSzGKXnCvCCo2RX6/univaAg4rKzVcjjWjwbejCNDgvMXy
	mhfXx5lGYvTuuQ/VGJ9wTACHtMpyGSW7sgM8q2yFG3MojVKiBzRdJvgmBOXtw0wXGoC8RdsJrd7
	k1g0yy2tUPKNXv8ScPwK5dKzDNxxlV7ysKcQtPJODLoN/gZVO0Jt7/eWotiD1pqVdVWtEua2oso
	peKXhc9j32EYPl5/O3zVn+lYQ5+z39Uq8Oq92hfpAAOEVsp7FbOrT7qaQuhwFULwnZ8Z8x8rOFM
	xeGBZLyY4F+nc14XOsr1uaoBFklUEtrFGfEeuJG0q+TtaxN+fmA3t2jZ6bKK9nSaPL/NLrCiVuA
	cdayOqg+kHjHd4t1ISdL1izHHyGry
X-Google-Smtp-Source: AGHT+IFCInPueUduhDZHmNuV4JQpXCy1ht4DH+FDTOyq34r+iVm95ixl8fRylqNW2WRNTabg/rBa9A==
X-Received: by 2002:a05:6602:4804:b0:85c:96a5:dc2c with SMTP id ca18e2360f4ac-86a24cd5c72mr2324977339f.14.1747784547554;
        Tue, 20 May 2025 16:42:27 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86a235e160asm230751539f.15.2025.05.20.16.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 16:42:27 -0700 (PDT)
Message-ID: <32e72fef-ceb5-45d7-921e-2367ff120a4a@gmail.com>
Date: Tue, 20 May 2025 17:42:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: akuster808@gmail.com, yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH] suricata: fix "interface" arg in systemd
 service
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 May 2025 23:42:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1571

Prevents service startup

https://docs.suricata.io/en/suricata-7.0.0/command-line-options.html#cmdoption-i

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

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

