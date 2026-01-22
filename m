Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D13AC44536
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 03:51:46 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30103.1769053904311078512
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Jan 2026 19:51:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QmJWdego;
 spf=pass (domain: gmail.com, ip: 209.85.167.178, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-45c819ca0f1so329268b6e.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 19:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769053903; x=1769658703; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUVeio3LHpped5oMc+O8aMTpw+Ow3CRescnMEEnxFVQ=;
        b=QmJWdego9nXgjbfuonQtRDotNgPJ+U9WryF1RXfqKCuc4Hd5fiR4PGDY78/PxN3uO1
         a9GW0048iyTq5FSERQar3EHxUPh/IxIvKdNCGNPMyda3tn1VBt7vWiaBMDufSh0uwRmw
         L8w4Qy4HosY+oLGou3XGJKlehClwV1BbxyYJm2FypEjgoSkMq3vcfyUWMRX+/KDTWfDF
         AVxjJduzpqT0iKdVsA6cXjGMVUr2gNvKWGccYSmY0aE9g4YJGMrJDcyAZ/P8FKAqDbyx
         ueozNF4t1T7hpMCAigWcjG8evLdGLC1gUoqIleks070vWbPZtQzmOXb1BYnWlYvsyPmi
         zYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769053903; x=1769658703;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUVeio3LHpped5oMc+O8aMTpw+Ow3CRescnMEEnxFVQ=;
        b=BXQ5zmblKCdTAGU3YeZU1xd3wdUzmR3w22Ax/tNyBNpzSHIiFZaboq/wFSelsaJVV3
         +pEwH2RzKzpUz6Tn8HcEBSfyjPM+88CqqNDHaj8cldqbHp/xLGj0kW6ws5Fzk+oYY9LN
         vF9AUf+a01/xDVvLgvHkoq7Logm4UjUww7BX1cBSK7ePzaXnT/yMT+cTH3r+kkaASygM
         smEl2sIqjf9LNE1dmDx0Zi8idHKk5QmoV02UTIl3V/5zc5yK8dykrLz+bZT2rHp6ZpQX
         /V+yd+UyBE+C3wZqneJ3tnCiFbI6NRwMdIfPufUhDL18nzjIh81PiSi3oSlMZeadoN+F
         j+VQ==
X-Gm-Message-State: AOJu0Yy0/hYtbqdEO8tLSHyWjAfqjntBFb6ikb4VHPAf143MtciAxKFd
	F7Jv7wLUfiuVrTAagg3ED4eVY5DD0657rOTgjdpZsT+pYkchblh1/AhlItmQfw==
X-Gm-Gg: AZuq6aKJu4gTb9FLmJhyAFZY4QKjc9e3MF59Z1YmTPbaDe+LejWzfDIIGPeSAm8gb7s
	KnfMdCGJjKdpunVS3fGSsQuqFkIryXhMJtt6No4JyLbwVI7Q7ouWgjmKVqvE8xTaDWPcimufxaO
	XeZCb9Wq4pbrV4VRBm3GrCqFtGC/djJUdju52hYyxdTvDWyeXCG3rpWTOBi1A5DmXC8jj1TwkfB
	4Xbcn0P2kNlpoZGbX0zaq4clMFveU26W8K87yaZsbuS2zFWJYbvgxPLrMM7OKxJjorEhuwR8t2r
	lcg0OkVwU207qtZwMciY3gqYzl1HfgyZFdTtEA9mfE+zz6UuipGQy03kr4NlePc8NuKclwYNfEy
	ztU5qllmaiLfqnMoYgVh3f/652MCJbZP9L5PS7imF2L1k9qpTVSQsfM+vIJuCXabUiSPlB11Ty/
	fOmkaOdaNI2+4zAWRC9jskQGvwuYNXn8d4v/0qjTuC9qeWP/0+E8NdfSxUj9YY2pK7
X-Received: by 2002:a05:6808:1b27:b0:455:e057:982f with SMTP id 5614622812f47-45ea3ce8babmr1088601b6e.1.1769053903487;
        Wed, 21 Jan 2026 19:51:43 -0800 (PST)
Received: from [172.26.252.3] (97-118-253-141.hlrn.qwest.net. [97.118.253.141])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9e03e924sm9320372b6e.19.2026.01.21.19.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 19:51:43 -0800 (PST)
Message-ID: <67c90f9d-5a63-4cec-a358-3837fde054c5@gmail.com>
Date: Wed, 21 Jan 2026 20:51:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org,
 Scott Murray <scott.murray@konsulko.com>, rybczynska@gmail.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH] suricata: improve PACKAGECONFIG[unittests]
 control
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 22 Jan 2026 03:51:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3052

Allow downstream users to explicitly select desired PACKAGECONFIG
options (e.g. via "=").

Users are currently forced to use ":remove" (with "ptest").

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

 recipes-ids/suricata/suricata_7.0.13.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-ids/suricata/suricata_7.0.13.bb b/recipes-ids/suricata/suricata_7.0.13.bb
index b0d2c82..936c057 100644
--- a/recipes-ids/suricata/suricata_7.0.13.bb
+++ b/recipes-ids/suricata/suricata_7.0.13.bb
@@ -46,8 +46,8 @@ PACKAGECONFIG ??= "file \
                    cap-ng \
                    net \
                    ${@bb.utils.filter('DISTRO_FEATURES', 'seccomp', d)} \
+                   ${@bb.utils.contains('DISTRO_FEATURES', 'ptest', 'unittests', '', d)} \
                    "
-PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'ptest', 'unittests', '', d)}"
 
 PACKAGECONFIG[pcre2] = "--with-libpcre2-includes=${STAGING_INCDIR} --with-libpcre2-libraries=${STAGING_LIBDIR}, ,libpcre2 ,"
 PACKAGECONFIG[yaml] = "--with-libyaml-includes=${STAGING_INCDIR} --with-libyaml-libraries=${STAGING_LIBDIR}, ,libyaml ,"

