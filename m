Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1312.1792476430454471304
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Oct 2026 23:07:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=U3QK60Nk;
 spf=pass (domain: gmail.com, ip: 209.85.208.181, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ab07d956f2so13716361fa.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 23:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792476428; cv=none;
        d=google.com; s=arc-20260327;
        b=s0DEFQOUmTvznIBfdN14bRUeWlQn8ui12iAvXqNiW+BMNIgfCFf9NcBVehinX/KnBo
         Sjpcr3fTaLaT2qi/09EtHDAND7ANKKr7hoLPV3X08wyVkK0K9mz51ANx90sGq6f92FQ8
         5jwohMiWT25XvQo/R7qV3dBJovNgP16PfVdg9mB1WAYd2xarRJBD6hDFCjcqxHJpNJCO
         ZzMveBRHlMzI9ZHPJWF2eCW5LcL61N0z//f/2RnlaXYnUXcaxLbcG8UuZ5vibFji/aA4
         a5N9P0CSmhObpN5rmfPXoDt9GyqdhoiyNcV4y4v+bxGF/c6UZI/QAJFjN2MOIlIqve0I
         +64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mRYy7+589lR7Mq3DB5KVRsjIZluN2xvmMpX06YNaGe4=;
        fh=5n1l9ClUU2n8NCvynOdAYuW3ZfEeOx0UqsUvFizfswc=;
        b=iYLMYz3ln4FlCcZtCHmcxPBvDW7FMXgNstZvFTZVsTva/y3sRo2TaFol6JzwrpqPTP
         WXl3YT796X/plvrxWKmvittWfTicoNA7TBRkcKdqna72A0MV+Xj/Lr1cOCjEBpTSpB//
         dNmwjqWI4TFnzSllycRefz2TS/L3gNGrAEJzWalmOUvI70n4s5TpFbe2X0SzdStYDs6W
         1uETaXkAPLMacvE3PG6vsQ4LSm5efKSlEd5+cqu9rhKxd/ladTwDqqhIzyISem6gAOa/
         FwbXx2Yhsm88cGmsx1Y8XadLYY/aMjcaz9OyGT+Bqje5kGTuRejWIEHr7AdFUztW1Zn8
         qrNg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792476428; x=1793081228; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mRYy7+589lR7Mq3DB5KVRsjIZluN2xvmMpX06YNaGe4=;
        b=U3QK60NkFtIApUbutMRcQyzMwWyKxKoH7HCw6N+r/+NpK3IcoVGjL04Z2rPiotT4rm
         poWdfnHm/DnRO7O9rJrmAHkLK34Sr1E+syGAb+teaMvuWP2K4lre+1zfG3M19MA4z8VG
         xQJFPUeKjt40LETQltc/+TqnQTri0PxAx9Y+anDPLxGrVXy+n08IQhQnCoCREacGADIu
         sQSxIU9r22iYHRgbafpYliLvTArA/bfrInwMI0LzGVPBW3DF0mHinQ9eq3WnzM4wVNcV
         GhlRFMB1fxD5m1inKZhygjrhndrfJGYNIBO6o/NVyXPFEhFLpVKHwi2ZeUKqPD2I21rA
         /7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792476428; x=1793081228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mRYy7+589lR7Mq3DB5KVRsjIZluN2xvmMpX06YNaGe4=;
        b=hDettZayKYFluZW5eFEW6EKMfRXcYd9i0gspWB06lIp9NR5FBq6ROlHxD3dmLN+p1G
         pT3+aWooKPiWIyHCHDBOa9idmoVAzI8MoGUeNaVMscX5aphko/H1qEz6/TRxXv0mEnRP
         /z0/B6DHV4zAMi2xidXMqOXAL/bUZtqLh1y+0Wc88GwUjnnaOp13RPb9qDhKpRiJM0Ig
         l9OfSwZdGsAUsxJg36z/KIu9veivtFfbf8zzDfhZltRs7qYGsY+3zZSpJr5K7XZmamQQ
         4TX1Uaf2ty5ZcCuXH0ySu/Ggh8rHjFzajLhAYPa/O1/hB8er1WeCjDBNyNV0dJg22n/D
         YoDw==
X-Gm-Message-State: AFq9FYJ01BzMKvHN4KemtDu7xkigYDv9u+OyaKBiYuzu0uke1qNBkD/d
	QjUqHrZgY4mCBUeXXI97mIT+Wm4GLl2DbRpGAYSkn1/nzTUTDPfz9wgKTy7EbPzNydbz1c6YskU
	xdWDThgx4+prbO41RH86s9wiYa4ksAazkbBFn
X-Gm-Gg: AYBFou1IqQO6MrMDfE7Qw3SNjGFKkpGI4RiSFgRk+j9z2I78nD3Z2Im3OZiCrNxoqxa
	y4aSVH0fbH9t5mm/ub/TSTEP7l5U1XvhGjoD9dFAsUNVT5Bql641zcF2KNSZm1d62z7p/IW38tS
	KMyfv0iNkTrb7+1LXZP5h+RUNB/aWTAdpr/TXcPNdbOJ3LXdRITL4rmhoze/6H3nJhlbpD5ZtWI
	tT4puVG49pugrnYRh3Dar4xEedxZAinbkWa9GgHl5zzgfK051JPDFVNd/twRLmsDSw5RhYBF21D
	cxaYjc2IjhnKCnwmyZak2hQQ96aimPm7c5sDY59Q4eZOye2H4TlmR4M7xs/s2ypjaMHES7vUwf4
	zszQwvV9fcX1uTjMepIgHOTxr3qyq7WKJqJTU
X-Received: by 2002:a05:651c:41cc:b0:3a9:d70c:f75e with SMTP id
 38308e7fff4ca-3ab2917580amr19592321fa.7.1792476427977; Mon, 19 Oct 2026
 23:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260929081349.3858049-1-martin.jansa@gmail.com>
 <CA+chaQejuGizpQ7q0UPaLvPsc8PZhEYAanhwUPbS9=LJBmfDkQ@mail.gmail.com> <CAMKF1sp31EN0ZeKGfRzAmto4N4=hv42xSs_XcMqzV=_vczh2Mw@mail.gmail.com>
In-Reply-To: <CAMKF1sp31EN0ZeKGfRzAmto4N4=hv42xSs_XcMqzV=_vczh2Mw@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 20 Oct 2026 08:06:53 +0200
X-Gm-Features: AclHuK8xlJDBDSKSfEed9LYNUF9TXEkoGxHkMUMI9eozv79BTVaAOaM-JALNIN0
Message-ID: <CA+chaQcDE7T2iyA4Dc_gYCA_-DOK=sa4M3MAvvBAULJCodTJLQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][PATCH] layer.conf: Update to
 blacksail release
To: yocto-patches@lists.yoctoproject.org
Cc: hongxujia83@gmail.com, jiahongxujia@163.com, jiahongxu_hycx@cetc.com.cn, 
	hongxu.jia@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 06:07:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5106

Hi Khem,

I think it's just gmail showing it in a wrong thread (I've sent very
similar change to both meta-security and meta-tensorflow at the same
time, but in patchwork and my sent e-mail has right meta-tensorflow
tag in subject:
https://patchwork.yoctoproject.org/project/yocto/patch/20260929081349.38580=
49-1-martin.jansa@gmail.com/
and already applied (through your change) meta-security:
https://patchwork.yoctoproject.org/project/yocto/patch/20260929081259.38560=
73-1-martin.jansa@gmail.com/

I've used older windriver e-mail in Cc, so I've added the 3 e-mails
hogxujia83 currently uses in meta-tensorflow (and updated in the
README there recently).

Cheers,

On Tue, Oct 20, 2026 at 3:26=E2=80=AFAM Khem Raj via lists.yoctoproject.org
<raj.khem=3Dgmail.com@lists.yoctoproject.org> wrote:
>
> Martin, a small nit, subject says meta-security, changing it to meta-tens=
orflow might help catching maintainer's attention
>
> On Mon, Oct 19, 2026 at 7:24=E2=80=AFAM Martin Jansa via lists.yoctoproje=
ct.org <martin.jansa=3Dgmail.com@lists.yoctoproject.org> wrote:
>>
>> ping
>>
>> On Tue, Sep 29, 2026 at 10:13=E2=80=AFAM <martin.jansa@gmail.com> wrote:
>> >
>> > From: Martin Jansa <martin.jansa@gmail.com>
>> >
>> > Changed in:
>> > https://git.openembedded.org/openembedded-core/commit/?h=3Dblacksail&i=
d=3D37623ffbdd34a5c6b3e12ee33195f8e82343f198
>> >
>> > Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
>> > ---
>> >  conf/layer.conf | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/conf/layer.conf b/conf/layer.conf
>> > index c3bd464..bad8eb1 100644
>> > --- a/conf/layer.conf
>> > +++ b/conf/layer.conf
>> > @@ -11,7 +11,7 @@ BBFILE_PRIORITY_meta-tensorflow =3D "10"
>> >
>> >  LAYERVERSION_meta-tensorflow =3D "1"
>> >
>> > -LAYERSERIES_COMPAT_meta-tensorflow =3D "wrynose"
>> > +LAYERSERIES_COMPAT_meta-tensorflow =3D "blacksail"
>> >
>> >  LAYERDEPENDS_meta-tensorflow =3D " \
>> >      core \
>>
>>
>>
>>
>>
> _._,_._,_
> ________________________________
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#5105) | Reply to Group | Reply to Sender | Mute This =
Topic | New Topic
> Your Subscription | Contact Group Owner | Unsubscribe [martin.jansa@gmail=
.com]
>
> _._,_._,_
