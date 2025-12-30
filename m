Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B107EE499B
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 19:41:05 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.71281.1767123659186860670
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Dec 2025 11:40:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=In8juy0b;
 spf=pass (domain: gmail.com, ip: 209.85.161.47, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-65cfddebfd0so6190539eaf.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 11:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767123658; x=1767728458; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8O7N4HQ2VZCyJv9BrVoEj3xIs+6dRKY13rDC17Lod8=;
        b=In8juy0bs0mn9qAvHwGZRa4eXDio56tEj8Eqyo+7BGypXO+A3I5RpdM5f9SJaJBp0W
         8ig8CpnEJagL1RU6Debv5QUtEhfQQ24WX7XEFEJmeq39CiqI9qJvC1v3CSdxdb69ZDlG
         VifabuDxvLPInNJWe2YBKyVCnWY6bYkJTicTPFecHdVrMgWQZR9ZWsVG0AClfFWEIFuQ
         c5ncRMLI4cBrtlx6seigYb0pSFMuhfVDNI+3vCJZoKaLgRqg/rYy4ocRow2ZmTli3UvM
         +z+6CPp6w751zTjYNM7ZFDIr3ieOhYz5dYjvLXZTIQPEBnHVynkuMY/yIec4qmy45aN5
         uH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767123658; x=1767728458;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8O7N4HQ2VZCyJv9BrVoEj3xIs+6dRKY13rDC17Lod8=;
        b=voeccrwmTXJiSQo9U4+t3/QKteBDLhP30ghMZ4y+DyE5ucLZxhpG8yyfsgM5T3Uc+3
         dIiqCe7jpRovlqVgkSe2YLGiGkhANDaErn++kupbQo8apXK888DUM21GKOzrBM3EcT11
         S6Byq7QyDuSvJ/Tb/i9iFMAqLsNcFYf3u9jej3JS3CQBrKVA1/aI1Ho6kT45rd00lufR
         /GVwgL+KKJaA0k0Ped+B6pjP6kQlX7X8J7A/a+MO/4qXA4X5S1O3ZTVJ5ghLhgX4NGwy
         6qauDXV3vr0tb2Foi+V6aAGryI+FA1LbTjOLvH+UQiJb6JMNCXecXtnuRBKjmVTbxW99
         Dz1g==
X-Gm-Message-State: AOJu0YxXEUEEIIlbwUI6q7eHVHCcf9hPXf9d5bTqZvwFkFQzqL5thMkQ
	YcvhtIL711LMna4X4K0l36z/F8lrpR9GKKR83iwvqgDqC+83KM9hRAAvHWpP2A==
X-Gm-Gg: AY/fxX7MmtdPGSd8LlWZDcf++qMgSmPSgS8aOkbRT2o2WN81GNPpcFxK8DpN5DqYAMv
	8/1saELPj0NlXa82yyV+C2T4ymlUMNF6GIWH81fTTopl4x0zLpje3bRJN5di+cg1SXqR5tJJ/co
	ViVx9HCDvEQNp3P/P11kjb+B1eGEvVlDJWMTRkH64Hiz0SERpI5O/LC0sCWbNDcFPUL4mRFjmwl
	ekdVm5nvfiZ/4AexdFWbdg9Fasoo3/iMe5yNEGZHrDMtxHPOe5zn5PHMOzuxNR7lvRsi43UNlnA
	jwprMDWpEGbMlwPcrX/sYUPOpUEHKx67cXVI9jbuKHNAl7GCDmRdS0nOxYdspry6KxsKFSEGKg6
	yxfP2MQLY/I+P0oD5dyYukTUI1Q2khlNQVeVeVR++9F6lJoxTyAn45rMOLIZGKpx5cspNI9lrOG
	JeCHRcoNyR7vf8cLz/n0HjrivjlxVEOXHKBXpW7aP8dH4hJ4qsqjTka7mASo9PbA==
X-Google-Smtp-Source: AGHT+IGfCkm9cJNjxRsq1TgidkgqrAQS3QeEmzkgIKXwtnLzYsmgbMEK4h+OgdxHjW6zC79nGBWSbA==
X-Received: by 2002:a05:6820:c309:b0:65d:2a0:4b57 with SMTP id 006d021491bc7-65d0e9e3c2emr9824541eaf.34.1767123658441;
        Tue, 30 Dec 2025 11:40:58 -0800 (PST)
Received: from [172.26.252.3] (75-166-169-44.hlrn.qwest.net. [75.166.169.44])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f3fb710sm20190214eaf.2.2025.12.30.11.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 11:40:58 -0800 (PST)
Message-ID: <6e6bd482-bfeb-45f6-9da3-cd90652c4647@gmail.com>
Date: Tue, 30 Dec 2025 12:40:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org,
 Scott Murray <scott.murray@konsulko.com>, rybczynska@gmail.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH] suricata: drop trailing whitespace
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 19:41:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2888

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

 recipes-ids/suricata/suricata_7.0.13.bb | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/recipes-ids/suricata/suricata_7.0.13.bb b/recipes-ids/suricata/suricata_7.0.13.bb
index 0635bf3..7298f1b 100644
--- a/recipes-ids/suricata/suricata_7.0.13.bb
+++ b/recipes-ids/suricata/suricata_7.0.13.bb
@@ -40,18 +40,18 @@ B = "${S}"
 PACKAGECONFIG ??= "jansson file pcre2 yaml python pcap cap-ng net"
 PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'ptest', 'unittests', '', d)}"
 
-PACKAGECONFIG[pcre2] = "--with-libpcre2-includes=${STAGING_INCDIR} --with-libpcre2-libraries=${STAGING_LIBDIR}, ,libpcre2 ," 
+PACKAGECONFIG[pcre2] = "--with-libpcre2-includes=${STAGING_INCDIR} --with-libpcre2-libraries=${STAGING_LIBDIR}, ,libpcre2 ,"
 PACKAGECONFIG[yaml] = "--with-libyaml-includes=${STAGING_INCDIR} --with-libyaml-libraries=${STAGING_LIBDIR}, ,libyaml ,"
-PACKAGECONFIG[pcap] = "--with-libpcap-includes=${STAGING_INCDIR} --with-libpcap-libraries=${STAGING_LIBDIR}, ,libpcap" 
+PACKAGECONFIG[pcap] = "--with-libpcap-includes=${STAGING_INCDIR} --with-libpcap-libraries=${STAGING_LIBDIR}, ,libpcap"
 PACKAGECONFIG[cap-ng] = "--with-libcap_ng-includes=${STAGING_INCDIR} --with-libcap_ng-libraries=${STAGING_LIBDIR}, ,libcap-ng , "
-PACKAGECONFIG[net] = "--with-libnet-includes=${STAGING_INCDIR} --with-libnet-libraries=${STAGING_LIBDIR}, , libnet," 
+PACKAGECONFIG[net] = "--with-libnet-includes=${STAGING_INCDIR} --with-libnet-libraries=${STAGING_LIBDIR}, , libnet,"
 PACKAGECONFIG[nfnetlink] = "--with-libnfnetlink-includes=${STAGING_INCDIR} --with-libnfnetlink-libraries=${STAGING_LIBDIR}, ,libnfnetlink ,"
 PACKAGECONFIG[nfq] = "--enable-nfqueue, --disable-nfqueue,libnetfilter-queue,"
 
 PACKAGECONFIG[jansson] = "--with-libjansson-includes=${STAGING_INCDIR} --with-libjansson-libraries=${STAGING_LIBDIR},,jansson, jansson"
 PACKAGECONFIG[file] = ",,file, file"
-PACKAGECONFIG[python] = "--enable-python, --disable-python, python3, python3-core" 
-PACKAGECONFIG[unittests] = "--enable-unittests, --disable-unittests," 
+PACKAGECONFIG[python] = "--enable-python, --disable-python, python3, python3-core"
+PACKAGECONFIG[unittests] = "--enable-unittests, --disable-unittests,"
 
 export logdir = "${localstatedir}/log"
 
@@ -81,7 +81,7 @@ oe_cargo_build () {
 }
 
 do_compile () {
-    # we do this to bypass the make provided by this pkg 
+    # we do this to bypass the make provided by this pkg
     # patches Makefile to skip the subdir
     cargo_do_compile
 

