Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D6EC83F1A
	for <webhook@archiver.kernel.org>; Mon, 21 Jul 2025 17:08:34 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.46728.1753117713679554840
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Jul 2025 10:08:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VaVLqpfx;
 spf=pass (domain: gmail.com, ip: 209.85.210.180, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-75001b1bd76so2841083b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 21 Jul 2025 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753117713; x=1753722513; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FJy1h0fxRfJTRN3/dEdDZZtq/b0qMro5rzTdAhwQ4I=;
        b=VaVLqpfxpplBPsZtwC3PGOjnDrfbAiOSvuqqsJvvnh9JCauUDF+UryB07wOMaqCaJ7
         gaiMN03+Y3FYQu1ghbM0hWZcqD/HFJRpM/bz/tmITR59Eyo7Pw+cE2D1HGSo4WHzEf7+
         D2onfjIhJyk21LkX7VmO+k3lOJa3qFE2oEike49JymseR5kE+Yw5/92ULvGTM1x2UpF/
         WMEIm/5HrEAt3ru1kR1O17cKoR7m/eFdv3PeCJugGlqNyMkrfeh52j7+9pi4dsKold7h
         n2NK4PtIiisCcjcCWFjhMFbGoW1uk5Amd11kJJ+yUq+NaW0T/XvmPgupLmeofTaH8THf
         AzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753117713; x=1753722513;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0FJy1h0fxRfJTRN3/dEdDZZtq/b0qMro5rzTdAhwQ4I=;
        b=vOQbKI8XYJr5cGuUQL7dibtcWnJIleBeoLid1VmC/6tYQpuwpPRQefg3GuVk/jvUS5
         sFj+gEsBD/RudsDjXte1dhqPAK9Is4ZJhKh2sjkSm29dRzMiwoSlqPaG6fHr6cON1yOx
         hepdkOeBnRQlrKfnZYIQdjOGjiOiM2l6+HF8bkry0rNAVOOInyebD1268e8bZCbzfEgk
         BiKjjDnJsKhTIyqTcC5maTbUjgQy6Fd7mTwSz4qw3uan5GMX0mqYIU43dylsz5oCW6aM
         EaECpf/mgGY4R7lDRJbmX5NQulyvKI4pKFow05W1Gq5zfTlNhIppjI4I/uAMlSNr+C0q
         dBAQ==
X-Gm-Message-State: AOJu0YxabPAdHUdIsn+/mzkCIhX7efNZk0etMgtDd4jNBXYvOMRlpCIy
	C/SWNHGIc1dm3JBhx/Rothu0Zb1/WfQvH7x/rWRLQaS9V83pk1j/9aK4Rllw+A==
X-Gm-Gg: ASbGncuWE77/Tw6wSLUW77zPgbNG8viROGCIKLqqBN88MWmyTuNJC/sudWyajxmh0lk
	XEddt5S9XX1CUudqQyPUhqi0rBW22SIX6gWnTdS6jk88aVUEmDaOB61cwMjGakbAWo9l1DYRCeA
	gjQAfIzEDdOe2HuTI94En1jviG6R6pGVm+tSPqncRsF2rS17TzM1kUnCQKOdPvfcEhbbCoJ3pO1
	Nnq8pYvXdlYLKBnpp8I2MUaWV+mxq1tOXDBphys41wYCNdtEEW1j1elSx63YBvJmqeCH4yNi+xW
	qs31npVV5slzAqlSjNGaHvFbRswHDClkrQoLZqibcDd7L/rk0FQB24saKESBO8b+boclcrGmiZ8
	ezS3s2RZon7XbWgy4nOfgoSAGMAvWdF85Q5mXlphSBSE/N4Co1pyKXq3UW/it0b0EDm4=
X-Google-Smtp-Source: AGHT+IH/QC/Tl+uPyhvSkFVbMrUcTxadGknR1qxkaohGqHr7iDsmoHKVx3ciezXjf0xWzIp++MFaCQ==
X-Received: by 2002:a05:6a21:62c1:b0:216:1476:f5c with SMTP id adf61e73a8af0-23812b50d6cmr35339174637.25.1753117712992;
        Mon, 21 Jul 2025 10:08:32 -0700 (PDT)
Received: from [172.26.252.3] (70-59-40-14.hlrn.qwest.net. [70.59.40.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbf5a13csm5955386b3a.162.2025.07.21.10.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 10:08:32 -0700 (PDT)
Message-ID: <0272a677-57d5-4dbc-b053-8833c6771928@gmail.com>
Date: Mon, 21 Jul 2025 11:08:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org, scott.murray@konsulko.com,
 rybczynska@gmail.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH v2] suricata: install classification, reference
 configs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Jul 2025 17:08:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1818

suricata.yaml references these configs

Resolve:
<Warning> -- could not open: "/etc/suricata/classification.config": No
such file or directory

<Error> -- please check the "classification-file" option in your
suricata.yaml file

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

v2: rebase patch, alphabetical order
v1: https://lists.yoctoproject.org/g/yocto-patches/message/1567

 recipes-ids/suricata/suricata_7.0.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index f2df09e..f02d343 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -105,6 +105,8 @@ do_install () {
     install -d ${D}${sysconfdir}/suricata ${D}${sysconfdir}/default/volatiles
     install -m 0644 ${UNPACKDIR}/volatiles.03_suricata  ${D}${sysconfdir}/default/volatiles/03_suricata
 
+    install -m 0644 ${S}/etc/classification.config ${D}${sysconfdir}/suricata
+    install -m 0644 ${S}/etc/reference.config ${D}${sysconfdir}/suricata
     install -m 0644 ${S}/threshold.config ${D}${sysconfdir}/suricata
     install -m 0644 ${S}/suricata.yaml ${D}${sysconfdir}/suricata
 

