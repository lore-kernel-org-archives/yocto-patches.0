Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2100.1795106458193147385
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Nov 2026 08:40:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google2 header.b=akqaKuX4;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso27745625e9.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Nov 2026 08:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google2; t=1795106456; x=1795711256; darn=lists.yoctoproject.org;
        h=in-reply-to:references:subject:to:cc:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SwfJ/xygnAHmDYDzDwwg1cRX6LjWfAv3JC7lV+9tkjA=;
        b=akqaKuX45On/DkmXL9JfM0i99lIXZLxsqtyl5i+2gGQoW3xr5IXfUHlGWl7QRoUtIz
         +HuYxuNjOFNVfK+7IagvV/m3EGhoPQ8ySdLGy+jM2XBiyDG55zp/+k1aNtEthLPQ8Ojn
         lvPo59iG/1pszlJ7yi/WTAX5ereh56VI5M+2FkZ3egfqfHOu5meNxda1U8usu/0YPyFz
         q/V8whKgzj0Kpgk3xJbrk4dwXncrFWmhStc/M1J5cQYv2y2ZqL9d0MdJP3ljiBM7NZq1
         1WXAWq1CPfmuPxASLkmAtxJoDZgQ0oL9K65lvFGxxG+iDpr7HEIlUzBRSui2331jdm/J
         0lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795106456; x=1795711256;
        h=in-reply-to:references:subject:to:cc:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SwfJ/xygnAHmDYDzDwwg1cRX6LjWfAv3JC7lV+9tkjA=;
        b=KgC0hOSIt/NLymDCUyXAa1SsezfVzT1rLUDZEW7VrGNRTQeb99ifteND0d9WYlOSEN
         JpZFhDq1Wmns9H3RF4RSdoJw4cDlbOfkcosocy+xi7KCx95+UKvMzuLy9+OgYepB8cQk
         abjwJYXbPFANN7RvMEEngUi8Gaw7wgp+vcaxD7IUQb2Exq/y3DpAT5B/vIiUfpMZyMfK
         tIe/0ZNEI9GCR+jMsVk8zoMhLWO7NneGCLwMjLozCht11varNMEgvnja8BMEnnB6KV/x
         K8CS59+YYw+2j37OU8n7Y9s1Cf2/gL4uJoExpSiewctiJ3Vx2hNmvizNxMrmY/yQVD65
         senw==
X-Gm-Message-State: APuU4Z86ctennOvLBjhJo93o8rli7YBuN3DbtTQPAG05cImuxR7BZaP9
	EVxlg0M24pfcYJToB++BhNMTJGzWQAZWlRnOzZpLZ9GdnqZQpvB6X8MQ3ePI/mddGhJmpo7tg2I
	s7697oW8=
X-Gm-Gg: AYBFou1GNmE5/DrGCnWAGAV+iYqjTRNkxmpcnB7liH3R7jaj/792iKd55Re3vJEwsFr
	X55OodGiuOWX8w7LOqOU5oiEDw5fJXyZEVA3A5BHCxMI76Svm7V7AcbpytTDf5RWe2htKePjN3M
	xR8ufBR9JNFnYBtTwZjTXWKO1ipv8aWC19vlTXIvEwJ625aWGf3fInSS0lnWsgB/9pz5w1o5JCE
	UxMWKHwVIAf/0edQpDokhmTOhwHog45lpEwRLWI3GevW4AKnQ8Hq/9SHXsffMRcCcsBE4t58lct
	L4d/gOBhgQqq4WebKdO+JqciNDpuex4afWnje72IrtsNkSFiSAi4HPW910O4mLfRaHxM7MBV2Fo
	K5p58Y4v2dSEEPgE4Pr+DOv6Aw9V5jXW9AZyEoQ6C+S/Kmbv4VMe6R9CKdeYqtPG0urOscCrnuR
	imrBI0c7oHW9XINceT2dXCIG78p6nDWR7YA7aJ8z/OSl5RqCvA2KQ5ErXliZFR/byan87Rj3omm
	QDU5QTxgD4ZI8SreEOSS0K7ybO7NT0M0OzIbcZDGLduXNlRFVTu056cOAkJvL8itQysjYd6pwi8
	MDqHx4GvgS9t8xKAtYERuoikXXor4T/IbDw4tY9YonkILQCRPoun0bUIIHKiFFx9guZTGnhUV6T
	BoDjeYd0zVd7fJr77
X-Received: by 2002:a05:600c:37c9:b0:4a6:eca1:7d5c with SMTP id 5b1f17b1804b1-4bb888251b4mr786275e9.32.1795106456216;
        Thu, 19 Nov 2026 08:40:56 -0800 (PST)
Return-Path: <yoann.congal@smile.fr>
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm652515f8f.55.2026.11.19.08.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 08:40:55 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 17:40:55 +0100
Message-Id: <DMZC4P47RR7P.19LG0RODQEKBH@smile.fr>
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: "OE-core ML" <openembedded-core@lists.openembedded.org>,
 <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, "Alexander Kanavin"
 <alex.kanavin@gmail.com>
Subject: Re: [yocto-patches] [OE-core] [PATCH] pseudo: inherit
 upstream-stable-release-point
X-Mailer: aerc 0.20.0
References: <20261117164151.1362220-1-yoann.congal@smile.fr>
 <CANNYZj9Uj5v-Tb1TrA+TrxrdEyjO+qj25byZ0fWtUpiLHKH-DA@mail.gmail.com>
 <0fabfef3-dbe6-4fe4-8f7e-d5f8ad47f27f@kernel.crashing.org>
 <CANNYZj-QWR+BDPzG5b1sn2oKBjk0CzYEB8_KgyC32-QfPdkUhQ@mail.gmail.com>
 <8480f7e3-e306-4b7f-936c-44d55a87ba98@kernel.crashing.org>
In-Reply-To: <8480f7e3-e306-4b7f-936c-44d55a87ba98@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Nov 2026 16:41:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5481

On Wed Nov 18, 2026 at 3:23 PM CET, Mark Hatle via yocto-patches wrote:
> On 11/18/26 5:10 AM, Alexander Kanavin wrote:
>> The question is whether point releases of pseudo add only bugfixes? It's=
 not=20
>> about 1.9 specifically, but any future release, e.g. 2.0.x as well.
>>=20
>> The policy for what is acceptable is documented here:
>> https://docs.yoctoproject.org/ref-manual/release-process.html#criteria-f=
or-qualifying-upstreams <https://docs.yoctoproject.org/ref-manual/release-p=
rocess.html#criteria-for-qualifying-upstreams>
>
> That is the YP criteria, not pseudo's.  Pseudo criteria is do we need the=
 patch=20
> in any particular version to deal with the hosts that we support in that=
=20
> version.  Support is very loosely defined for sure.
>
> This is why I want to be clear they are separate projects, highly related=
 of=20
> course, but separate.
>
> There WILL be a 2,0 branch, once it's created.
>
> As I said, work on master, backport to release branches to deal with issu=
es on=20
> particular host types.
>
> For example, pseudo-1.9 theoretically still supports MacOS/Darwin (it rea=
lly=20
> doesn't but anyway), Master? We removed this code as it's known to not wo=
rk, and=20
> there are no indications it's being used.  I'm not backporting that to 1.=
9, as=20
> it would be an API change.
>
> --Mark

(Sorry, I kinda feel I kicked a hornet's nest here. I did not intended
to)

I'll drop my patch. The policy you describe is not compatible with
"inherit upstream-stable-release-point" and this is absolutely fine.
It just mean I'll continue to upgrades like I was doing before.

Regards,

>
>> Alex
>>=20
>> On Wed, 18 Nov 2026 at 11:55, Mark Hatle <mark.hatle@kernel.crashing.org=
=20
>> <mailto:mark.hatle@kernel.crashing.org>> wrote:
>>=20
>>     While pseudo is heavily driven by Yocto Project (and OpenEmbedded)
>>     requirements,
>>     I'm not treating this as a YP/OE specific project.
>>=20
>>     When I say pseudo-1.9 has a stable API, I mean that.=C2=A0 The inten=
tion is that
>>     development happens in master.=C2=A0 Stable branches can have backpo=
rts, as
>>     required/requested by contributors, but these backports need to "fee=
l" stable,
>>     have a stable API (don't change command line arguments, don't change=
 system
>>     requirements, etc.)
>>=20
>>     Is there an official list of what is and isn't allowed no.=C2=A0 Wha=
t pseudo does is
>>     so specialized, I don't think I could come up with a documented set =
will and
>>     won't.=C2=A0 I also don't expect any applications to write such a li=
st as in the end
>>     it is up to the contributors and maintainers to weigh each patch to
>>     determine if
>>     it feels appropriate to go on a stable branch.=C2=A0 But in practice=
 I expect if
>>     someone using pseudo-1.9 experiences breakage due to security fixes =
in an
>>     existing platform release we'll backport the fixes there.=C2=A0 But =
I do not intend
>>     to carry forward pseudo-1.9 forever and into newer host releases.
>>=20
>>     So in short:
>>=20
>>     1. New Development goes to master (or equivalent)
>>     2. Backports from master to a numbered branch can be requested
>>     3. Priority for backports will be given to resolve breaking issues i=
n known
>>     working hosts, generally centered around Yocto Project/OpenEmbedded =
as that is
>>     our primary test vehicle.
>>     4. We do not intend API changes to be backported to older version.=
=C2=A0 (It's not a
>>     stronger statement, because with the security backports happening in
>>     distributions, it might be required at some point.)
>>=20
>>     --Mark
>>=20
>>     On 11/17/26 11:13 AM, Alexander Kanavin via openembedded-core wrote:
>>      > On Tue, 17 Nov 2026 at 17:42, Yoann Congal via openembedded-core
>>      > <yoann.congal=3Dsmile.fr@lists.openembedded.org
>>     <mailto:smile.fr@lists.openembedded.org>
>>      > <mailto:smile.fr@lists.openembedded.org
>>     <mailto:smile.fr@lists.openembedded.org>>> wrote:
>>      >
>>      >
>>      >=C2=A0 =C2=A0 =C2=A0Pseudo now has a stable branch pseudo-1.9 with=
 pseudo-1.9.x tags on it.
>>      >
>>      >
>>      > Is this branch collecting only bugfixes (or fixes needed for cont=
inuing
>>      > operation of yocto release branches)? Is this going to be a polic=
y for any
>>      > future point releases, or is it a one-off just for 1.9.x? There s=
hould be
>>      > confirmation of these questions, in addition to the existence of =
the branch.
>>      >
>>      > Alex
>>      >
>>      >
>>      >=20
>>      >
>>=20
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5472): https://lists.yoctoproject.org/g/yocto-patches=
/message/5472
> Mute This Topic: https://lists.yoctoproject.org/mt/122329726/4316185
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1317941=
0/4316185/929767106/xyzzy [yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--=20
Yoann Congal
Smile ECS

