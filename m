Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BD1C98318
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 16:17:38 +0000 (UTC)
Received: from mail-ed2-f40.google.com (mail-ed2-f40.google.com [74.125.228.104])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2201.1790266655961536211
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Sep 2026 09:17:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=qSAKti9a;
 spf=pass (domain: smile.fr, ip: 74.125.228.104, mailfrom: yoann.congal@smile.fr)
Received: by mail-ed2-f40.google.com with SMTP id 4fb4d7f45d1cf-6a60590a85cso71097a12.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Sep 2026 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790266654; x=1790871454; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AUyCEucMHzyocjeVljbwSEzE79z6GdVYdC87wG7QbNM=;
        b=qSAKti9aljG+EyOZ96O6+QHKGZdQuxACzrmkkhdlBc2T/IoNtWHz4IbhNZJ1M1ysji
         xNT4i+ZZyd8lJ2I7yRjBliXCX44jEJrxtxD0jODsmd75vEI5k3qY74QdSCfHXAAwyQ+k
         FfuqS5V/l2kIe1vPOfwYVUse0J5yGrWv/Q+6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266654; x=1790871454;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUyCEucMHzyocjeVljbwSEzE79z6GdVYdC87wG7QbNM=;
        b=L5DEAZVrW6K9i/7NnrMs9ebxjqkqc8NlnTs4RG05gNoTk5zLLx2FIWF60Dw2kMRG14
         yWnNZCrg/ToUJBju2SRNElCzAhW/DIqw7uwt/KV17pH2yGQF0ySCj+c5oyC/GSmXnjFM
         4bbroRdXWV0AzG7Z2Kz416fv71NP0igDUVNtFTz8CbyzQF+dN4QduhazPLhv9Mm+KZYn
         A055ifoJTMDUssEb4fOJ4WoSa3gxJ21nyXvjxHQywKIShdfepPE5YLU7WqbKN2wTyBpZ
         WKBDCiKrPUrP+GxKCgVdSG47gb0so74MLMGHA6z9hVwfVZVw5N0neotqCD75ERr5FDil
         qQJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzABzXAdrmksfPX7Q+tfJcxTMN0LhmoAtEe0wtjvY6f1A8Ed1GK8uPcwKDjCxk/kDeFGS8AcZTB2oykIKHW@lists.yoctoproject.org
X-Gm-Message-State: AFuF++kklL/2/4FUPze8nZECPoR1DqsIa61I4eHw3v7UG21KO05NXRfb
	joU9e6yW+9Bg1ypc+yj19Iug9wvnZn0BEJJDZjb5xFjlk4uG7x2xcLnmFs0DcY00XFE=
X-Gm-Gg: AYBFou2TPs2Pepe7pEINFtOWjS9uP11VMv7l7y7UMP9sUOA5YNUTSc61tgZnpU4MSGo
	TaFC4TRlE3R0ksjRmVHSa7nM+wm2AD2UwL4KismWvaYe0lPgshItoWomiKfGpbhKta3PzOYeLuT
	c3hbd1aklxdwLxcgThJgh6Wkyf23jLA7Y0bhNWZcVlS11hcd+lHsFCf1zXM9HW2Q82Pvg4Uxbt6
	+iioS2LesI002s1FvXIws0PKibJBS+Uo13Z68twWDbg5XqTVZPhos9r9CNkFyJy5NSybqjpOuL8
	HWweYMpFqie/d/BwTI1qSiayqB0pOQ/2oemtidookWUbXRep2yo/qRChMlBdSstyXt8/5gmE2S4
	5aIXerBOH+KG96sdhOVi8ajMjr1h3HkTkxGb7L0CRYnAJBzU2xvdKMYzElNe5QJ6Tg3sRPz9S4h
	08FwnUFDna/UCQrAJAemfh/Um3fXMyrchbCF7MfRNnLxxPewMABrP5SEoHXHHrSbZvLPGE4K3Tq
	eKlFaEMHPNrzEeHBqiVCI8jq90vLoaZvu1uApRdKec12GZdjceTDvnG/9aG/Y0=
X-Received: by 2002:a05:6402:a209:20b0:6aa:e107:612e with SMTP id 4fb4d7f45d1cf-6aae10766d1mr324493a12.20.1790266654081;
        Thu, 24 Sep 2026 09:17:34 -0700 (PDT)
Received: from ehlo.thunderbird.net (2a02-8440-2502-20fe-0000-0000-1d41-5af9.rev.sfr.net. [2a02:8440:2502:20fe::1d41:5af9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab37eadd4sm3852068a12.1.2026.09.24.09.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:17:33 -0700 (PDT)
Date: Thu, 24 Sep 2026 18:17:30 +0200
From: Yoann Congal <yoann.congal@smile.fr>
To: Antonin Godard <antonin.godard@bootlin.com>,
 yocto-patches@lists.yoctoproject.org
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: =?US-ASCII?Q?Re=3A_=5Byocto-patches=5D_=5Byocto?=
 =?US-ASCII?Q?-autobuilder-helper=5D=5Bdunfe?=
 =?US-ASCII?Q?ll=5D=5BPATCH=5D_config=2Ejson=3A_fi?=
 =?US-ASCII?Q?x_cvecheck_iputils_warning?=
User-Agent: K-9 Mail for Android
In-Reply-To: <DLNDIFQAG08K.2N6SOR4IPT7Z6@bootlin.com>
References: <20260923-fix-cvecheck-warning-fdunfell-v1-1-bd0c0b400f84@bootlin.com> <DLNCINQHU830.27H37P8U5X2QT@smile.fr> <DLNDIFQAG08K.2N6SOR4IPT7Z6@bootlin.com>
Message-ID: <B60F8B94-8E5C-47FC-A7F0-BCD5930EB70B@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Sep 2026 16:17:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4955



Le 24 septembre 2026 09:37:55 GMT+02:00, Antonin Godard <antonin=2Egodard@=
bootlin=2Ecom> a =C3=A9crit :
>On Thu Sep 24, 2026 at 8:51 AM CEST, Yoann Congal wrote:
>> On Wed Sep 23, 2026 at 5:41 PM CEST, Antonin Godard via lists=2Eyoctopr=
oject=2Eorg wrote:
>>> On Yocto Dunfell, an EOL version of Yocto, we consistently have the
>>> following warning showed during the metrics job:
>>>
>>>   WARNING: iputils-s20190709-r0 do_cve_check: iputils: Failed to compa=
re
>>>   s20190709 < 20250602 for CVE-2025-47268
>>>
>>> This is because upstream stopped adding the leading "s" to their
>>> version=2E Since we can't patch Yocto dunfell anymore, as a workaround=
 set
>>> the version of iputils so that the comparison passes=2E This makes the
>>> cvecheck class show the following warning instead, which is expected:
>>>
>>>   WARNING: iputils-20190709-r0 do_cve_check: Found unpatched CVE
>>>   (CVE-2025-47268), for more information check
>>>   /build/tmp/work/aarch64-poky-linux/iputils/20190709-r0/temp/cve=2Elo=
g
>>>
>>> Which isn't shown on the Autobuilder thanks to CVE_CHECK_SHOW_WARNINGS=
 =3D
>>> '0'=2E
>>>
>>> Signed-off-by: Antonin Godard <antonin=2Egodard@bootlin=2Ecom>
>>> ---
>>> Test build (not pushed to metrics repo):
>>> https://autobuilder=2Eyoctoproject=2Eorg/valkyrie/#/builders/103/build=
s/4111
>>
>> Hello,
>>
>> Thanks! (I had that on my todolist for the longest time but never got t=
o
>> it)
>>
>> Alternatively, since the metrics is the last thing we do actually
>> maintain, we could actually fix the recipe (if the fix is non intrusive=
,
>> obviously)=2E
>>
>> FYI, dunfell had 2 recent fixes for the metrics job=2E
>
>Ha, I didn't dare sending a patch for dunfell :) Well, the same fix (sett=
ing PV to
>"20190709") could be done in the recipe directly=2E If you consider that
>non-invasive, I can send it today=2E

That should be OK=2E Depending on the sorting rules, you might have to inc=
rease PE=2E=2E=2E

I'd rather do that instead of injecting PV via override=2E

Thanks!

>
>Antonin

Yoann Congal (Smile ECS)

