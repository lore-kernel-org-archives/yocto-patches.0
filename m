Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5F9CCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 15:16:32 +0000 (UTC)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15865.1762960588641087192
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Nov 2025 07:16:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JQcgX5t8;
 spf=pass (domain: gmail.com, ip: 74.125.224.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63fbed0f71aso837496d50.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 07:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762960588; x=1763565388; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KERbHtkEbHbPyGPA46X7B/ezz+tr7w2bQJeSoLGe6c=;
        b=JQcgX5t86ngvfP7lVA1JeVxtbgXXKsCvMbxjicAlxgbOF1apmaDoGgwiBm6Ewb4ka+
         Y/TD8XUXlsTlRP3x7a4CQq9f1S5BIRFpYWfAsaupdRRONzQgDeGNGnNoL1b8zuVV0ppo
         B4BzwxZXQZmA9V7eLw3tuGFAeOdwioaYNucuuL8ip97mUEB108tD1Nk01RgM7hO6E2Ge
         +xPZrlhjXeJScvURlyZB795BgVp/OiKl5ijvJQMRSss8aYsqooz+5ifFgKeJCLSvKyw4
         bpWFmnGdKfq4Fxaow85BeP8Uh6NpvbZrofgbay9H5/3FOA2x72VQfjS9cQ2vivG6o0Rq
         hLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960588; x=1763565388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5KERbHtkEbHbPyGPA46X7B/ezz+tr7w2bQJeSoLGe6c=;
        b=LGSKOS1yOit/ZganzBbUTHAO+nNfflkCZ0qNNX5cXs+3pBNlzD+wz2toRjXdx/ETuh
         hLaujpJhw55WdCEfvnBjvTwNm0t2VVLKEaT36UUMz0tSFUIZiXnZ/yuKVdX3Nuabu9rB
         856cNeyE62prbrIt9htS22DOLtEC3uRJA6iK7h3EKork5nkoAPXZgPuzfv8vj8YVTkRb
         ysVzpHxtItsK/fcmix/pKBXnrJhItCyCu0hegDvzUT0AB5ki1I3mbcPkvoOPlxBPMGKQ
         OuvxihGikFzYF8T/cPUaF/QmcdZ4W4T2nJmnB8MHuvHn22M1Y6lH32mKJPEDw9CRcG8i
         EUSw==
X-Gm-Message-State: AOJu0YyVKWHvR94CM4jGq7kUeiAFhO4+BuSd0aI6KiwsazUoTN6Cman7
	RVQTkY8g3YJw4ydfY6URP0zzIUMj3uQkDKyyvsMzUB//5m/4SztF9r/sDR0Kn8CrSXQj6j+ifTs
	VlInQN5PvIBbhYiwTF44whm1kXEwaxVg=
X-Gm-Gg: ASbGncuNxbERNDXV5G5HMUZ9EAX5ndEv/DRU1P4ihGu2oNtFNoT++UQASPfQ0kTdj2Z
	Nwvp93b1XhFiMKD6Z0dJwk6P7NUhRf3lQlzEW7ECrABBJQvYNHpo1LMenzoBtdohBoWy4ilOU6R
	MOzZvQ3YYtsqdJWsNPV/NLPH6Z9CNovvzeHTFGnVRaO8hRaInOvmL4jwjxCHwc/Hztq1g8xIpq4
	4PyYHdKqi3/IvQ8Mpb4SVVNYO7PT0FhP8YgFPvSMsbJRWZbhsnO1/PdlH6kMIGoLpgyUSsyxT8=
X-Google-Smtp-Source: AGHT+IG6YC+5DoHRSseS8Iy9TpjoSq22WXCq6OAp9E6r1nofX+784p4ty2/REDuWFAF6f+uryTX/E5CgzbcyjLlEieI=
X-Received: by 2002:a05:690e:4363:b0:63f:ab00:1a0d with SMTP id
 956f58d0204a3-64101b66c8cmr2399006d50.40.1762960587551; Wed, 12 Nov 2025
 07:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20250820065756.1295786-1-samuli.piippo@qt.io> <CABXoSoUd7qmCp4p+5-cCy-E0FZ0XoKotF_pP4vBgnHH_uasyKg@mail.gmail.com>
In-Reply-To: <CABXoSoUd7qmCp4p+5-cCy-E0FZ0XoKotF_pP4vBgnHH_uasyKg@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 12 Nov 2025 08:16:16 -0700
X-Gm-Features: AWmQ_bkDh2d4wpADAHXutGCLQCev_upSG29AZne4w3oHZYQv1bhz_LOIejMSG8c
Message-ID: <CAJdd5Gbu56oteWRXkw+3URi1itmcd9RQLqiHnqLM61CYxQ=usA@mail.gmail.com>
Subject: Re: [meta-mingw] [PATCH] mingw-w64: use correct path to license file
To: Samuli Piippo <samuli.piippo@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 15:16:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2494

On Wed, Nov 12, 2025 at 12:44=E2=80=AFAM Samuli Piippo <samuli.piippo@gmail=
.com> wrote:
>
> The yocto autobuilder doesn't seem to catch this error as the builds pass=
 with the patch still in master-next.
> Should there be some improvement on the autobuilder scripts as well?

I haven't run master-next build on the AB yet.

>
> -samuli
>
> On Wed, 20 Aug 2025 at 09:58, Samuli Piippo <samuli.piippo@gmail.com> wro=
te:
>>
>> Amend b7ac9777ad0c4512f1a63aa6bec4ecedd91783e1 and use UNPACKDIR
>> also for the license file.
>>
>> Signed-off-by: Samuli Piippo <samuli.piippo@qt.io>
>> ---
>>  recipes-devtools/mingw-w64/mingw-w64.inc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/recipes-devtools/mingw-w64/mingw-w64.inc b/recipes-devtools=
/mingw-w64/mingw-w64.inc
>> index 97315f4..a24e96c 100644
>> --- a/recipes-devtools/mingw-w64/mingw-w64.inc
>> +++ b/recipes-devtools/mingw-w64/mingw-w64.inc
>> @@ -1,5 +1,5 @@
>>  LICENSE =3D "ZPL-2.1"
>> -LIC_FILES_CHKSUM =3D "file://${WORKDIR}/mingw-w64-v${PV}/COPYING;md5=3D=
bb936f0e04d8f1e19ad545100cee9654"
>> +LIC_FILES_CHKSUM =3D "file://${UNPACKDIR}/mingw-w64-v${PV}/COPYING;md5=
=3Dbb936f0e04d8f1e19ad545100cee9654"
>>
>>  COMPATIBLE_HOST =3D ".*-mingw.*"
>>
>> --
>> 2.43.0
>>

