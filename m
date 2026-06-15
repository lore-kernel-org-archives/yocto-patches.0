Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F34CD98C7
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 10:30:33 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.126599.1781519423732342332
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Jun 2026 03:30:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=JPkynIID;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490cdae130cso14970845e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781519422; x=1782124222; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a85CeYR877AfLCNUfVDKsdCRCOdnNlAwVX3B7sbq3aY=;
        b=JPkynIID/gDSytGzzeKMiyErW3MpWAbrcFLqfR8hgBZzo75uOJzcS6IRI9uR4tMrfH
         ydX1ooMao5iA2YxJfgFWVcmbpuNjlf8ETHh4ygP9/czXNvqEo/BJAfQzMo9WDgFyKNl7
         qLs/AuNqYqY+tPAXdPzmoXZNbQT03PEyl0Gto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781519422; x=1782124222;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a85CeYR877AfLCNUfVDKsdCRCOdnNlAwVX3B7sbq3aY=;
        b=WNmYs3pCy55W1tpdTbuuAqfPRuU7UftNjvvLv/oX4lr0o1Cuq464vJTi/cc02MsIJi
         62+hZIURlxqHWwZ31s8jGP194gYl8jESq3ke+oDB/yxbeIJx5VZH8/JNWav1udmmEwJ1
         GW3bfm9uq4cYHy5PQ2PfKKD2s0o5BMqYrQsTFQOoT8tLDONT0VV/7cO9grZG/v8tD0MH
         YQBixlff9O2d4MUp7JEkqcTDvj8NRhWj+j2b5i2d3po0zpiX+o8+USYPjKw0eHR1uqGe
         YQomW0chm5sMSvcuJ35Lm+1FJkaEQphLhSeRmXDI7SFaPhWLobYnWDw3o/hK+P1SKymb
         XNKA==
X-Gm-Message-State: AOJu0Yx+y/nfT7T/baTkY5PWRk1Dtn0cvVdkj7/U6xuHbW39pmRq0haY
	b1jkhBDeGEofHTPmjBOMgHzE6291Gwulo31oQkZgKqCl7CSgGa2awbYBVeRq/kTvXoo4yrt13Ag
	amo/N
X-Gm-Gg: Acq92OHuEF4raaUt4kaYFZWty4Nffv4Cd/OwCy48C+Ym+3IhDFBpltQ5l/w4XIm7SkN
	s2pT/0I5DgarCrO+WKdGo/vciPCSA9f/QPXmLiMKAGe+iBLtc7tlx9v7P7iyyU9hfqOUrm28Vqi
	aoUUJcb6iAsqGnozCjdcPPcV9fmB5WPtbj/zzkbA6QopR4dG3hxWv1vIIE/70mTDp8aVRZPbRDf
	rYkZNDP5ICoxkRJK+9QzAjkp5BSW+PHwLSOgJX31gHG1JFxDKcBR8wL2Is7a7wq9Ea3mp6lBGau
	lOn0cb4mE+L89Br8NEobV19v4zF6OI5llYxZ5YJgzb1UNc9dgsw8HAKrlT8TcqwsfnrAvegz4ES
	G/Zppj/S/mYYKOh2Gs1rXcaxdbJIUDYlyDJfNdZG3vvCcEhuglRM6PmDCRZnlcL3ddfhAQy97GU
	ZGIC1gONeAb2LPLHpEiCR0ETLt3JyAiARg1s33lYuVArnsYThKvLep4evEpmfm+/8UKDQP/mMTS
	r5xjYubSgzRorpT4RQFtFgjNA==
X-Received: by 2002:a05:600c:5288:b0:490:c0d8:d517 with SMTP id 5b1f17b1804b1-49220051691mr122942865e9.3.1781519421678;
        Mon, 15 Jun 2026 03:30:21 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c51dsm229353565e9.1.2026.06.15.03.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 03:30:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 12:30:20 +0200
Message-Id: <DJ9JXFIN92RM.UTKIGP8ZBT1K@smile.fr>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2] schedulers: Switch
 meta-agl to unagi branch for scarthgap
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Mathieu
 Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.20.0
References: <20260615-mathieu-agl-unagi-v1-1-5c2b5b28bd44@bootlin.com>
 <DJ9J47WKVRKJ.1GDBA84GBBGVP@smile.fr>
 <359cd363e6d79716d2d9cf2b960f27ec2c33ac0e.camel@linuxfoundation.org>
In-Reply-To: <359cd363e6d79716d2d9cf2b960f27ec2c33ac0e.camel@linuxfoundation.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 10:30:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4227

On Mon Jun 15, 2026 at 12:23 PM CEST, Richard Purdie via lists.yoctoproject=
.org wrote:
> On Mon, 2026-06-15 at 11:52 +0200, Yoann Congal via lists.yoctoproject.or=
g wrote:
>> On Mon Jun 15, 2026 at 11:38 AM CEST, Mathieu Dubois-Briand via lists.yo=
ctoproject.org wrote:
>> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.co=
m>
>> > ---
>> > =C2=A0schedulers.py | 2 +-
>> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>> >=20
>> > diff --git a/schedulers.py b/schedulers.py
>> > index 0f41bd0c7ca6..e5f0684fcb34 100644
>> > --- a/schedulers.py
>> > +++ b/schedulers.py
>> > @@ -161,7 +161,7 @@ branchdefaults =3D {
>> > =C2=A0=C2=A0=C2=A0=C2=A0 'scarthgap': {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch': 'scarthgap'=
,
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_bitbake': '2.=
8',
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_meta-agl': 'master=
',
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'branch_meta-agl': 'unagi'=
,
>>=20
>> This looks correct but note that I don't test/use this anywhere on norma=
l
>> builds.
>
> There are automatically scheduled jobs that do test yocto-check-layer
> with it on scarthgap though.

Oh right. Found it: https://autobuilder.yoctoproject.org/valkyrie/#/builder=
s/85/builds/1217

Thanks!

>
> Cheers,
>
> Richard
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4226): https://lists.yoctoproject.org/g/yocto-patches=
/message/4226
> Mute This Topic: https://lists.yoctoproject.org/mt/119812813/4316185
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1317941=
0/4316185/929767106/xyzzy [yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--=20
Yoann Congal
Smile ECS


