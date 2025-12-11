Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE34D41D59
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 15:29:13 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11910.1765466951710620140
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Dec 2025 07:29:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E9EFlp+B;
 spf=pass (domain: gmail.com, ip: 209.85.167.174, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-450be85b7d9so129182b6e.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Dec 2025 07:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765466951; x=1766071751; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qeNo5xCIBXoOlU8l28TZs0ID/Xmn4cK3jaTaSAUsB4=;
        b=E9EFlp+Bdp842sP7oAiVj72AGWFht062r8kditcyh3vLgvt0lV1HFoZbZzXbV03D0p
         CzoKRnsfBcCRE41Oh1GasTQcea32FXZEqo9ccj8mwOScT4FMvIzTeQPGeN/W9BIFWrQ/
         C7Z+AwHtEoNb3z6hJSFwSKBiiW/wujLONaw+N727CbGjx7heHYVNV2bZCCsa7hhnJQ/N
         fS/DrPmTre1oXMCIcCBhr4izbFUDzAgKzDyqzdcxcITCeMEwBEMXcvZN2iDwvWDid+BO
         LPnf1gRyAWazIXNwJW/sJxuDsWcwMzu3btuJ7fCNCBLa1Z5hTiuTsQxbQaXpoBmxA9c9
         Rndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765466951; x=1766071751;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qeNo5xCIBXoOlU8l28TZs0ID/Xmn4cK3jaTaSAUsB4=;
        b=SeBk8hXen9V9bKGNZKGpZYzmutUyLo+P9rpHdD0rmmnPG79RQ9Ou2urzPU2y2wMoQq
         Sn4LhbWODbrWsNih0H+QxGOwY5y3iAcJY+9/+cLgkmfSE26a7QvhUOHpS/EONZ3vp+ir
         ThJiXx+R43yY7mnnqkvS1HDpB6cjj8piQxn95Y9i2JF8BeU1/ht5aVFNNAYD9es8rJsy
         oYtYUizG5BBp+zCq9Z0r+v+AM1CZyMOdCt/vxWJM1GRuzo3EH131asdL3z8qZTQOabaa
         Y3LAfvYtLxvqdAmJvuasu0+9w59k25Kav2xjdRiMnflcZDCzkjmVpHFEhNneMxbDTocg
         erCg==
X-Gm-Message-State: AOJu0YyRQTuD+r5qiiLDn18McwaectLTVCwyg6n701IQhloEILalqT5N
	/P0i+gMoseNvIODuA5dwQtE7orUWnq4E0asQx36yPP43t8IhbFJIWxoNQelaOg==
X-Gm-Gg: AY/fxX7LHLHgWRj2Kp/iPD/0/IiwbV8kbo5uFN25yi5mKaqw9Mx496z6/r2RZLrjBXd
	U5yUrvbL5yuUImckzAbY9tmzryfEskvPAMO5CIjM2f71wktiS5FXnA6Wa/pTS5J1/F4jxGaHwJj
	WpjAbpqqbgJnsNL+ckMHQi9MJ94ZhWjVV3sj48u+TOrB/Hoi2K/TaEzUYdMMVuSFljoBKbGl6uq
	Ydne4vYqXGZ4+EDvGZjwrJKWEf3j8eHCJbEdf50FAaFHKJgW+qUuSRR+0EsTOCpCt7GIMcXWItV
	fr+03JDBASLNyB0iZgRp2s3plK+ZMPeBQhlrGUowTdUvQD/asffxl5865cojQCGCKFVswcA23Fo
	DM9QaunBGfrBaHamVcUJ+OSkGTd4jrhUtRRB/vAMz1l86pZ4GqufRo6DFF6V1sntCMk92Q36It1
	eSYqnau8ladkTICakgdTTcNWiyyZUa2ybnXvq4kQOB4cyqjuPcVvkFX6KabuFsOuFA0Dp4f8xe
X-Google-Smtp-Source: AGHT+IEe5KreffVnzwI11OSAMAYLgIke5h9PIB7LZux83L83vN/fJ1ZpAgjTxtL1ijl4onlYwTSXbQ==
X-Received: by 2002:a05:6820:807:b0:659:9a49:8fa8 with SMTP id 006d021491bc7-65b2ac0e2efmr3526631eaf.33.1765466950784;
        Thu, 11 Dec 2025 07:29:10 -0800 (PST)
Received: from [172.26.252.3] (75-166-169-44.hlrn.qwest.net. [75.166.169.44])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b35f4e9c6sm1191634eaf.5.2025.12.11.07.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 07:29:10 -0800 (PST)
Message-ID: <87bbf70e-a192-4bfd-a64c-fad77713a27e@gmail.com>
Date: Thu, 11 Dec 2025 08:29:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org,
 Scott Murray <scott.murray@konsulko.com>, rybczynska@gmail.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH] suricata: drop deprecated nss, nspr
 PACKAGECONFIGs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Dec 2025 15:29:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2766

Default add in 3f95047ae1e1d ("suricata: package update to 2.0.8")

https://docs.suricata.io/en/suricata-8.0.1/upgrade.html#id7
As of 7.0, "NSS is no longer required. File hashing and JA3 can now be
used without the NSS compile time dependency."

Removed in 8.0:
https://github.com/OISF/suricata/blob/suricata-8.0.1/ChangeLog#L647

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

 recipes-ids/suricata/suricata_7.0.12.bb | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/recipes-ids/suricata/suricata_7.0.12.bb b/recipes-ids/suricata/suricata_7.0.12.bb
index e958fad..1e6c070 100644
--- a/recipes-ids/suricata/suricata_7.0.12.bb
+++ b/recipes-ids/suricata/suricata_7.0.12.bb
@@ -37,7 +37,7 @@ CARGO_BUILD_FLAGS:append = " --offline"
 B = "${S}"
 
 # nfnetlink has a dependancy to meta-networking
-PACKAGECONFIG ??= "jansson file pcre2 yaml python pcap cap-ng net nss nspr "
+PACKAGECONFIG ??= "jansson file pcre2 yaml python pcap cap-ng net"
 PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'ptest', 'unittests', '', d)}"
 
 PACKAGECONFIG[pcre2] = "--with-libpcre2-includes=${STAGING_INCDIR} --with-libpcre2-libraries=${STAGING_LIBDIR}, ,libpcre2 ," 
@@ -50,8 +50,6 @@ PACKAGECONFIG[nfq] = "--enable-nfqueue, --disable-nfqueue,libnetfilter-queue,"
 
 PACKAGECONFIG[jansson] = "--with-libjansson-includes=${STAGING_INCDIR} --with-libjansson-libraries=${STAGING_LIBDIR},,jansson, jansson"
 PACKAGECONFIG[file] = ",,file, file"
-PACKAGECONFIG[nss] = "--with-libnss-includes=${STAGING_INCDIR} --with-libnss-libraries=${STAGING_LIBDIR}, nss, nss," 
-PACKAGECONFIG[nspr] = "--with-libnspr-includes=${STAGING_INCDIR} --with-libnspr-libraries=${STAGING_LIBDIR}, nspr, nspr," 
 PACKAGECONFIG[python] = "--enable-python, --disable-python, python3, python3-core" 
 PACKAGECONFIG[unittests] = "--enable-unittests, --disable-unittests," 
 

