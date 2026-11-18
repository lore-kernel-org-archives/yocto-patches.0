Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13650.1795011830081801668
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Nov 2026 06:23:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AIENj7g3872764;
	Wed, 18 Nov 2026 08:23:45 -0600
Received: from [192.168.2.97] ([192.168.2.97])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 6AIENiJg006682;
	Wed, 18 Nov 2026 08:23:44 -0600
Message-ID: <8480f7e3-e306-4b7f-936c-44d55a87ba98@kernel.crashing.org>
Date: Wed, 18 Nov 2026 08:23:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [OE-core] [PATCH] pseudo: inherit upstream-stable-release-point
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: yoann.congal@smile.fr, yocto-patches@lists.yoctoproject.org,
        OE-core ML <openembedded-core@lists.openembedded.org>,
        mark.hatle@amd.com
References: <20261117164151.1362220-1-yoann.congal@smile.fr>
 <CANNYZj9Uj5v-Tb1TrA+TrxrdEyjO+qj25byZ0fWtUpiLHKH-DA@mail.gmail.com>
 <0fabfef3-dbe6-4fe4-8f7e-d5f8ad47f27f@kernel.crashing.org>
 <CANNYZj-QWR+BDPzG5b1sn2oKBjk0CzYEB8_KgyC32-QfPdkUhQ@mail.gmail.com>
Content-Language: en-US
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <CANNYZj-QWR+BDPzG5b1sn2oKBjk0CzYEB8_KgyC32-QfPdkUhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id 6AIENj7g3872764
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 14:23:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5472



On 11/18/26 5:10 AM, Alexander Kanavin wrote:
> The question is whether point releases of pseudo add only bugfixes? It'=
s not=20
> about 1.9 specifically, but any future release, e.g. 2.0.x as well.
>=20
> The policy for what is acceptable is documented here:
> https://docs.yoctoproject.org/ref-manual/release-process.html#criteria-=
for-qualifying-upstreams <https://docs.yoctoproject.org/ref-manual/releas=
e-process.html#criteria-for-qualifying-upstreams>

That is the YP criteria, not pseudo's.  Pseudo criteria is do we need the=
 patch=20
in any particular version to deal with the hosts that we support in that=20
version.  Support is very loosely defined for sure.

This is why I want to be clear they are separate projects, highly related=
 of=20
course, but separate.

There WILL be a 2,0 branch, once it's created.

As I said, work on master, backport to release branches to deal with issu=
es on=20
particular host types.

For example, pseudo-1.9 theoretically still supports MacOS/Darwin (it rea=
lly=20
doesn't but anyway), Master? We removed this code as it's known to not wo=
rk, and=20
there are no indications it's being used.  I'm not backporting that to 1.=
9, as=20
it would be an API change.

--Mark

> Alex
>=20
> On Wed, 18 Nov 2026 at 11:55, Mark Hatle <mark.hatle@kernel.crashing.or=
g=20
> <mailto:mark.hatle@kernel.crashing.org>> wrote:
>=20
>     While pseudo is heavily driven by Yocto Project (and OpenEmbedded)
>     requirements,
>     I'm not treating this as a YP/OE specific project.
>=20
>     When I say pseudo-1.9 has a stable API, I mean that.=C2=A0 The inte=
ntion is that
>     development happens in master.=C2=A0 Stable branches can have backp=
orts, as
>     required/requested by contributors, but these backports need to "fe=
el" stable,
>     have a stable API (don't change command line arguments, don't chang=
e system
>     requirements, etc.)
>=20
>     Is there an official list of what is and isn't allowed no.=C2=A0 Wh=
at pseudo does is
>     so specialized, I don't think I could come up with a documented set=
 will and
>     won't.=C2=A0 I also don't expect any applications to write such a l=
ist as in the end
>     it is up to the contributors and maintainers to weigh each patch to
>     determine if
>     it feels appropriate to go on a stable branch.=C2=A0 But in practic=
e I expect if
>     someone using pseudo-1.9 experiences breakage due to security fixes=
 in an
>     existing platform release we'll backport the fixes there.=C2=A0 But=
 I do not intend
>     to carry forward pseudo-1.9 forever and into newer host releases.
>=20
>     So in short:
>=20
>     1. New Development goes to master (or equivalent)
>     2. Backports from master to a numbered branch can be requested
>     3. Priority for backports will be given to resolve breaking issues =
in known
>     working hosts, generally centered around Yocto Project/OpenEmbedded=
 as that is
>     our primary test vehicle.
>     4. We do not intend API changes to be backported to older version.=C2=
=A0 (It's not a
>     stronger statement, because with the security backports happening i=
n
>     distributions, it might be required at some point.)
>=20
>     --Mark
>=20
>     On 11/17/26 11:13 AM, Alexander Kanavin via openembedded-core wrote=
:
>      > On Tue, 17 Nov 2026 at 17:42, Yoann Congal via openembedded-core
>      > <yoann.congal=3Dsmile.fr@lists.openembedded.org
>     <mailto:smile.fr@lists.openembedded.org>
>      > <mailto:smile.fr@lists.openembedded.org
>     <mailto:smile.fr@lists.openembedded.org>>> wrote:
>      >
>      >
>      >=C2=A0 =C2=A0 =C2=A0Pseudo now has a stable branch pseudo-1.9 wit=
h pseudo-1.9.x tags on it.
>      >
>      >
>      > Is this branch collecting only bugfixes (or fixes needed for con=
tinuing
>      > operation of yocto release branches)? Is this going to be a poli=
cy for any
>      > future point releases, or is it a one-off just for 1.9.x? There =
should be
>      > confirmation of these questions, in addition to the existence of=
 the branch.
>      >
>      > Alex
>      >
>      >
>      > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>      > Links: You receive all messages sent to this group.
>      > View/Reply Online (#250463):
>     https://lists.openembedded.org/g/openembedded-core/message/250463
>     <https://lists.openembedded.org/g/openembedded-core/message/250463>
>      > Mute This Topic: https://lists.openembedded.org/mt/122316790/361=
6948
>     <https://lists.openembedded.org/mt/122316790/3616948>
>      > Group Owner: openembedded-core+owner@lists.openembedded.org
>     <mailto:openembedded-core%2Bowner@lists.openembedded.org>
>      > Unsubscribe: https://lists.openembedded.org/g/openembedded-core/=
unsub
>     <https://lists.openembedded.org/g/openembedded-core/unsub>
>     [mark.hatle@kernel.crashing.org <mailto:mark.hatle@kernel.crashing.=
org>]
>      > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>      >
>=20
