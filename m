Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEE2EF8FFD
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 16:00:25 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21812.1772640018253963087
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Mar 2026 08:00:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=uTaXByKG;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48371119eacso85038845e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 08:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772640017; x=1773244817; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrqjnlCakRgpDHsNvi56ZNw25bM9xZc6JYSLvqVv2N8=;
        b=uTaXByKGqJPIAl7qMf2bO4oF8K8U9ljuaZoWDCO+LK1ZksaPugk29eOZ4nz0clY6ap
         mGOPKZvXgFWmafZwjQ/NRPDG+iE5snrmACoFlfuwaWP+94d2HYg63OJKXflMRyiNXWP5
         D1rTqh15hEyu6vtkbgwvm+iLF4ZNAJfLQdlYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640017; x=1773244817;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrqjnlCakRgpDHsNvi56ZNw25bM9xZc6JYSLvqVv2N8=;
        b=Y3qBaRFgSU0zFbXu5r1b8ImJw5J6/X4IOPFYmWDJDOIVXhecS9p4UOOB0fcwZydfO/
         pKE9m5pVnN3H+P1M9zPJ+6dj/vAL+kC5bCsnKEpROZXrFbiG0UuBYnC3Tau9ZM9x92cc
         gEBBlmT2qQJ9Txwofu9TA/MFmv+iL+0y/MW03KmAujuN7k0CcMZGN/O6VnIVYTEAzQ/a
         Omo2KrMUGavOx3kiTEHetIlHi3s6/+2RpaeZECkIvcW/Brq9gI5P946vkTj8aBDEHZes
         gzZxoARguatTqQXqx3hxgrCmddoyP/hzYtswtXBoJP0m5Z4jsZ35aS4ui6w3zscvCyx8
         FqRw==
X-Gm-Message-State: AOJu0YyyqtWT49HZqnccrMZKcn77UChSJrM7h55VANwF7LR/S9QHRq8o
	+CSE7qzV8Ory9b7guWszDsQDTMzTzCtfbW384xkGg6T+rcbszkEud0XA1j5Q5uCF1tUCK9VzFqd
	S5Jow
X-Gm-Gg: ATEYQzwUfIyQ+JkmYYD8eYwulw9N6PNb83KVjZSlovnO8CiaVyhk49jd0FVV4+J2Jxu
	z+Wml2lOzEnJ5QqYPp74bwTjY553KwFaewc7yMSOE1OukHte8BrB8fN4ui5/XwXLW3LjagBePjN
	JZclK/BU3UTggdhqghUH49bfMNgbSdtW41oW1ptew4AY9NSPMq1dW9HDVAapOacghr2gqHwmUsQ
	CX8l8eqb3fnaDUbzG9lvotSRcUAnl/VdBnQTt/UfCqW0UwFe0vp9EBom4TUNGQmINwGBFJ8aw2+
	Xy3vjLXaxki+EMvRiH4vpIE1ezuWEdOl3fLf17PDRroEjylus+M3J+emu8PqqUJZlOfNcM/oa6G
	CM+QKzVWuQOVLDzk5B0L4Uj8pK8Ab2Fc9HDChQIE3pnsHGU2F2Y86z5+hy0oVSQQWl1NWh1Wluu
	RzAtJGj1jYuZLAImHwuUrQss8G3L7gZ2qwYyi9OIiaF+6/NEOZ3ix4OBoB4rkPW/9F0dKRHSJkE
	9ywD7plRzA=
X-Received: by 2002:a05:600c:190e:b0:480:4a90:1af2 with SMTP id 5b1f17b1804b1-485198bb48fmr44859535e9.35.1772640015547;
        Wed, 04 Mar 2026 08:00:15 -0800 (PST)
Received: from localhost (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851884a7absm71029485e9.8.2026.03.04.08.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 08:00:14 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Mar 2026 17:00:13 +0100
Message-Id: <DGU4FW6MA4DZ.3KTSFSW6FMWQ0@smile.fr>
Subject: Re: [ptest-runner][PATCH 1/2] ptest-runner-collect-system-data: add
 info to logs
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: <yocto-patches@lists.yoctoproject.org>, "Alexander Kanavin"
 <alex@linutronix.de>
To: "Anibal Limon" <anibal@limonsoftware.com>
X-Mailer: aerc 0.20.0
References: <20260302174500.357368-1-yoann.congal@smile.fr>
 <CAOU5ZMtGChGdXChKgHU1X1daSa3erVOC-8wbAHaGmJkmSXOkvw@mail.gmail.com>
In-Reply-To: <CAOU5ZMtGChGdXChKgHU1X1daSa3erVOC-8wbAHaGmJkmSXOkvw@mail.gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 16:00:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3331

On Wed Mar 4, 2026 at 4:38 PM CET, Anibal Limon wrote:
> Hi Yoann,
>
> Adding Alexander, comment below,
>
> On Mon, Mar 2, 2026 at 11:45=E2=80=AFAM Yoann Congal <yoann.congal@smile.=
fr> wrote:
>
>> From: Yoann Congal <yoann.congal@smile.fr>
>>
>> Print a banner to make it more clear what is happening when reading the
>> logs.
>>
>> Add used commands to stdout by using shell's "set -x" (which prints used
>> commands to stderr, so, also redirect stderr to stdout).
>>
>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>> ---
>>  ptest-runner-collect-system-data | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/ptest-runner-collect-system-data
>> b/ptest-runner-collect-system-data
>> index ba335da..15205f1 100755
>> --- a/ptest-runner-collect-system-data
>> +++ b/ptest-runner-collect-system-data
>> @@ -1,5 +1,9 @@
>>  #!/bin/sh
>>  # Other ideas on what to do when a ptest gets stuck welcome.
>> +
>> +echo "Collected system state:"
>>
>
> Can you add a comment here explaining why `exec` and `set` are used?

Sure! v2 sent.

>
> +exec 2>&1
>> +set -x
>>  dmesg
>>  pstree -a -l
>>  df
>>


--=20
Yoann Congal
Smile ECS


