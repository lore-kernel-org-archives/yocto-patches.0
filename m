Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AAFFEDA03
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 18:23:42 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83052.1773771819358127093
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 11:23:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=RP31c4/R;
 spf=pass (domain: smile.fr, ip: 209.85.221.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so152584f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 11:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773771817; x=1774376617; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aQcjL+yGRW1XTaYECGAvyt/hGWHSCwIPT1JZmVK7Ow=;
        b=RP31c4/R64Kbvf5NUf5cjmqgS12t31UHJkuHgM7Wrl9wee6H8wmz890KMyG8oS8t1h
         2QmORMe1MZ0ghQI6TS9E6NU5g7bX7TtHFfaqVoS0tueABlfMdeLo3by/kjTfrAfoOr7R
         pBeaHgLiJav7E90+VXaK70FSHKDiVCMVQcG5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773771817; x=1774376617;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+aQcjL+yGRW1XTaYECGAvyt/hGWHSCwIPT1JZmVK7Ow=;
        b=bu1qMdF6xI4wPBcSn5TOWZkQnCEvEu2Wr3/2XuoTDUKvmZgUuazHxjM1y/RsvFXsCw
         pXFhx0NUA2ccxety/ZNqhCIwR0zMjiVNmc0Dl2P34WNyRSu0LQSWQXEQ20OPC/IrJGr5
         nCIKKg9Au1LXTcQ2MqceWWl0HnuIzgld0dcaAUqT7RP8jzVsHutyJyW3/p86grceRwCK
         zlvWndAHvGHM/Brd+JVjiN9s+DEbvYKH5QMIa1/FG7VF+0R/9Z5iL3foPqp3LbpfTnGT
         wQWYzYilhRK2pwYgbvU+i8Map7xNG8n4QGEAfEjFpCypghS6sgIyIlcRUIYe/WjzgroX
         6eRQ==
X-Gm-Message-State: AOJu0YxQvZZFHcLR5POa2gDQriZCaiT+JGExy/JnsR5BlRKUxLbH+m1P
	RH5cdzvmq7O1hxuQHpZHn8aNplVFDgX9tUM3Yl3H4EG7kV2BzhQnr9YtTpmp0ekHw+su07hLibi
	NXEwm
X-Gm-Gg: ATEYQzwgWQCNbTAPpbW18FkRhSCkEWsytPo3nLW5SA9jHzsudOLbOnPnEwgDOE6sYbg
	Qan2MLEY3cedoxMSu9qx4N4uDuMuOAfVHXrFFnZZG+gfWU73KiZoSiYpk2Ipoua0OSAHtr6g04h
	VX4I1Rd57hAXKIa4n73cFSukerRJ4e1or9zRnZC27a6ofO+U0xToP7JQslgtYJ317djX46i1oFr
	IBejaQWCdY8hpioQoYXCS/FsKel96AZhC9JQl6yDRoAKx2LVGCqP4esQEeQqsx0jpFPK+dGex5r
	sezn4/P+5b9F8PPHwV69NhlHPjCRylNDDrOZ7Gz9O8D3yAECVWSRFUZ90DkTlFQgayk00CU4mY8
	of469EKLYDygV69FeFXbxNKRts1dkvXPjTv28gPx/uTUkR/FKurxrxHNs2A4rELMSx0GSvwrPdA
	+rQG+GxeKehOOmm18IBDpPo/buP13f1XfbCLB3JgWAouEwDMwEisi3o9moQUdHUFKtXmxdNmZYL
	SeoN5x3CCCP7g==
X-Received: by 2002:a05:6000:4029:b0:439:c24b:ec15 with SMTP id ffacd0b85a97d-43b5191ffc4mr1278523f8f.5.1773771817222;
        Tue, 17 Mar 2026 11:23:37 -0700 (PDT)
Received: from localhost (2a02-8440-2506-1dad-b794-fb49-51fa-9eb9.rev.sfr.net. [2a02:8440:2506:1dad:b794:fb49:51fa:9eb9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b5189970fsm1283170f8f.27.2026.03.17.11.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 11:23:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 19:23:35 +0100
Message-Id: <DH59MQQ8LHWC.25HPETRJUAGLI@smile.fr>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: "Yi Zhao" <yi.zhao@windriver.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
To: <yocto-patches@lists.yoctoproject.org>, "Richard Purdie"
 <richard.purdie@linuxfoundation.org>
X-Mailer: aerc 0.20.0
References: <20260213154238.4093604-2-u.kleine-koenig@baylibre.com>
 <baff51f1-f0d9-4ae3-ba7f-bcbf1c0272c3@windriver.com>
 <14ad3c9da707249caf3f5157cf9be0b936ebfe5e.camel@linuxfoundation.org>
 <pfqfrlcduuigcvfdvn5ljjmjomee2wwn7xxu5ikibinoz57udn@dusca2fnhwja>
In-Reply-To: <pfqfrlcduuigcvfdvn5ljjmjomee2wwn7xxu5ikibinoz57udn@dusca2fnhwja>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 18:23:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3492

On Tue Mar 17, 2026 at 6:40 PM CET, Hiago De Franco via lists.yoctoproject.=
org wrote:
> Hi Richard,
>
> On Mon, Mar 09, 2026 at 02:21:51PM +0000, Richard Purdie wrote:
>> On Mon, 2026-03-09 at 20:23 +0800, Yi Zhao via lists.yoctoproject.org wr=
ote:
>> >=20
>> > On 2/13/26 23:42, "Uwe Kleine-K=C3=B6nig wrote:
>> > > With SELinux enabled for the target it makes sense to have SELinux
>> > > support enabled for the native tools, too.
>> > >=20
>> > > Note that for native packages DISTRO_FEATURES is filtered, thus up t=
o now
>> > > it never contained "selinux". Append to DISTRO_FEATURES_FILTER_NATIV=
E to
>> > > make "selinux" propagate also to DISTRO_FEATURES for native packages=
.
>> > > ---
>> > > Hello,
>> > >=20
>> > > I use this on scarthgap, but the patch applies fine to master, too.
>> > >=20
>> > > During a debug session it took me quite a while to find out why
>> > >=20
>> > > 	ls -lZ "${IMAGE_ROOTFS}
>> > >=20
>> > > at the end of selinux_set_labels() didn't show the labels added by
>> > > setfiles.
>> > >=20
>> > > Best regards
>> > > Uwe
>> > >=20
>> > > =C2=A0 classes/enable-selinux.bbclass | 2 +-
>> > > =C2=A0 conf/layer.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
>> > > =C2=A0 2 files changed, 5 insertions(+), 1 deletion(-)
>> > >=20
>> > > diff --git a/classes/enable-selinux.bbclass b/classes/enable-selinux=
.bbclass
>> > > index 3dc61d6931ff..0c9f52e74cec 100644
>> > > --- a/classes/enable-selinux.bbclass
>> > > +++ b/classes/enable-selinux.bbclass
>> > > @@ -1,3 +1,3 @@
>> > > =C2=A0 inherit selinux
>> > > =C2=A0=20
>> > > -PACKAGECONFIG:append =3D " ${@target_selinux(d, 'selinux')}"
>> > > +PACKAGECONFIG:append =3D " ${@bb.utils.filter('DISTRO_FEATURES', 's=
elinux', d)}"
>> > > diff --git a/conf/layer.conf b/conf/layer.conf
>> > > index 4e04e5cc7e6a..ca981db57019 100644
>> > > --- a/conf/layer.conf
>> > > +++ b/conf/layer.conf
>> > > @@ -25,3 +25,7 @@ LAYERDEPENDS_selinux =3D " \
>> > > =C2=A0 "
>> > > =C2=A0=20
>> > > =C2=A0 PREFERRED_PROVIDER_virtual/refpolicy ??=3D "refpolicy-targete=
d"
>> > > +
>> > > +# With target support for SELinux it is very helpful during debug w=
hen the
>> > > +# native tools support SELinux, too.
>> > > +DISTRO_FEATURES_FILTER_NATIVE:append =3D " selinux"
>> >=20
>> > Can we add this to the doc (e.g. README) instead of enabling it direct=
ly=20
>> > in layer.conf? Since we haven't directly enabled DISTRO_FEATURES =3D=
=20
>> > "selinux" in layer.conf either.
>>=20
>> I just wanted to add that putting that directly in layer.conf will mean
>> the layer isn't Yocto Project Compatible too.
>
> I am going to send a v2 and take over this work, already asked Uwe about
> that.
>
> But before doing it, I was wondering why changing layer.conf will make
> the layer not compatible with Yocto Project anymore. Can you explain to
> us the reason?

I'd guess it is from this criteria of the Yocto Compatible layer[0]:
> Inclusion of any layer in the submission does not change the
> behavior/configuration of the overall system without the user
> explicitly opting into those changes

By putting a 'DISTRO_FEATURES +=3D "selinux"' in layer.conf, the
configuration changes globally without explicit opt-in of the user.

[0]: https://www.yoctoproject.org/compatible-registration/

>> Cheers,
>>=20
>> Richard
>>=20
>
> Thanks!
>
> Hiago.
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3491): https://lists.yoctoproject.org/g/yocto-patches=
/message/3491
> Mute This Topic: https://lists.yoctoproject.org/mt/117794339/4316185
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1317941=
0/4316185/929767106/xyzzy [yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--=20
Yoann Congal
Smile ECS


