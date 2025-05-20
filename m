Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C61C3ABDA
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 04:00:19 +0000 (UTC)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
 by mx.groups.io with SMTP id smtpd.web10.13051.1747713610304752263
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 May 2025 21:00:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dcyIr69k;
 spf=pass (domain: gmail.com, ip: 209.85.166.170, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3da74959554so17445345ab.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 May 2025 21:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747713609; x=1748318409; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQHe2wzdM3nQtr8um6sxYsk9QdY26wSjW7Nr54+ez24=;
        b=dcyIr69kCxVr8GZh6FJNauLLYgL6EBmLJrDYiNCSZFk1rmyb7GQTrquN6iBRmPAn5y
         AmKrb57jdYxrGQWLolZzXsVhJ0ESUBcGgseam/3Yhbr0ik6AEIyemgGzU6rUbmsnNfny
         r07L65QD7Z+DYAY07vobaoKndlcZibpBk1nV32KDyLnrUEHBbEKYM8QQsfPaS+q2t0IO
         U/195YhVshiUR2HbsURQjEfMe2J61Ke1JAJmkfTePH3qlbbRGa3qWgHv+qNvRfe0u/9s
         5eV3LFLkZ98jeaePGgDNLPFbAqhUJGrBSdvnCbe4oOgSaIyIiOFF9Dubxf8k9NhV62ns
         +G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747713609; x=1748318409;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iQHe2wzdM3nQtr8um6sxYsk9QdY26wSjW7Nr54+ez24=;
        b=vW8OSuXoGBocODlvLHJPJ6wQ3pl7l/dPvlMh1Odd0nMKiQf/R5q2eHZGcA50yGP+XD
         MAx3WrJNvNY7SY7SHOpwz3otktJz9GoplHtyI8xSTsFz+oSGi0+Fa+NGcF30qiUZDQAp
         Wl0wgYB8Hdsdu4D5RMtze/tMzgzht2P2C0V/NXNqIWFIYS3KXCGg1OrdCnrlRoF+JA2s
         +q2OF2/NPdJgffQod1677wJ5xLnPwYNIhGIAN2W+v/7X2gE+ng8D8Di+1psITrxudI9e
         a0i9ZcN+ZT/VJaiDxPGEWagmiMOlk9UrI8DHy6/cZEDwS4xgzF2Kbjae3sdncfv/LZJl
         bz2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMVSwbeGO0Rg4mOmiX7JpvyYxNIeAqHRQjL0hAJsF9xDvrEjibJP2JWfy1sUmof7Lo8fSUKay/m78J+ZHL@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yzvqd7Fu0ZVeudoHrEqfQY2RskNv3UrknTH+Egh4lfN/pobhJHz
	8mJ9SmUlMg8DghlEsNhzKNN92rmpZEdhd/opupLCg1Omn/+lqDEGMF7Q
X-Gm-Gg: ASbGncuScPYycLvxbH2ril4K0sAKc/1/0mzQ9dGUcynNlwmp9WLSe1Nzq3UP/n8Kf4C
	VkOFM8cVRhrX9ENa6Pam0MF/BgGpzny+ga29732tKIalDYyrQEZU1oNMPNgh9wrTTkRuJcSv8nX
	l1MuqfrLcu+DG/7DkcZgce4AQ7pVEWqchaK1ILbpnSNm1KY1ToKBAqWFVdJO7D4ubaiweBhGSFa
	IiqkvXfXnAPLEyoTvMYGgPd9KOjhZun/jLNdGh8oOuaZ5lKESvvMydwTt9JA7C18UTuBur1w5pr
	XAVcJdLvumq8IWMtaL1K7ZuRLmI997MM/lWD0JOOSnihLdAhbMyU2H68Px+lxNeXt2Dot64wTf/
	eDKgoWhLTmzeanjZTyqI8VqVmAEF6
X-Google-Smtp-Source: AGHT+IFpEsmFmeE0OwnXKohIAnmkfMXePG+fgG+JyGHUuHUXJyhMVcOaNHrsuvF1AoDq1QpkW6SJxQ==
X-Received: by 2002:a05:6e02:380c:b0:3dc:7df8:c832 with SMTP id e9e14a558f8ab-3dc7df8d01fmr1006055ab.11.1747713609409;
        Mon, 19 May 2025 21:00:09 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4b1543sm2038450173.121.2025.05.19.21.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 21:00:09 -0700 (PDT)
Message-ID: <d7bf9670-d192-46e5-b48c-0abefd1244f2@gmail.com>
Date: Mon, 19 May 2025 22:00:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: akuster808@gmail.com, yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH] suricata: install classification, reference
 configs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 May 2025 04:00:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1567

suricata.yaml references these configs

Resolve:
<Warning> -- could not open: "/etc/suricata/classification.config": No
such file or directory

<Error> -- please check the "classification-file" option in your
suricata.yaml file

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

 recipes-ids/suricata/suricata_7.0.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index 910e21e..b083f6e 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -104,6 +104,8 @@ do_install () {
     install -m 0644 ${UNPACKDIR}/volatiles.03_suricata  ${D}${sysconfdir}/default/volatiles/03_suricata
 
     install -m 0644 ${S}/threshold.config ${D}${sysconfdir}/suricata
+    install -m 0644 ${S}/etc/classification.config ${D}${sysconfdir}/suricata
+    install -m 0644 ${S}/etc/reference.config ${D}${sysconfdir}/suricata
     install -m 0644 ${S}/suricata.yaml ${D}${sysconfdir}/suricata
 
     if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then

