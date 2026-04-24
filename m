Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA3FFED3FA
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 18:53:15 +0000 (UTC)
Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch [79.135.106.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29554.1777056789507778377
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 11:53:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@on-the-web.ch header.s=protonmail header.b=THinPUI+;
 spf=pass (domain: on-the-web.ch, ip: 79.135.106.116, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail; t=1777056785; x=1777315985;
	bh=gk8upH6WgY2WIB3yICP/9NbTNzuubHYruBbd3yBC4Uo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=THinPUI+bfr9xHjWb2uHx6FtUupd6uPRQvVGAFq+hFi9kheXKZP7qSVxYhhhI1TUx
	 tv/IwSjMoY5RtarU/QRs+mdmJ+IFpc0cB7wUpqY3fTjswuShcZPhcepf5gB2ONBfCh
	 Hsg8DX3YKBdUg0ziZ0xg/uzhA1YcBeD1/c/ubIvA5kFLsbBqKBp7eGo1oJsjaRCF9t
	 pmHfFnMy9UQUyruXB36Hv7x7b4w88orsCX6c4CdXsm43lfRa0BZMigCWAvu4Pl3FQx
	 URPZuCIi2pr/VhwbLP9f73ZBYavwP/NVyZaLlIcR671ZHvgHVnn0zYnRqz25+lu0Tz
	 bdJNSLYwrBMoA==
Date: Fri, 24 Apr 2026 18:53:02 +0000
To: yocto-patches@lists.yoctoproject.org
From: Martin Herren <sputnik@on-the-web.ch>
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip] Backport patches to Whinlatter
Message-ID: <iQJoQfWKbRog-jkkVJwDe0fWDrDmIjvWi92pjP25nihmlNmBcKTI7i4lB0ul7Z_IVElJkBmQwkROWxapz6V_nFkCpwcOZilRyFpnVnu7erk=@on-the-web.ch>
In-Reply-To: <4f8aafff-585f-436a-a986-26d331b8687b@cherry.de>
References: <5bj70loXmt_k9cZvIDWvVux-3no88K7lhbMDcRw9jh3ylLLz-YDZhyOr6fM8PeXSnC88wg6wk34A9A3uz8ljvNTE_nEurXpatMj2VxFsw8c=@on-the-web.ch> <f458ad76-2eda-41f2-b6a5-1f6bba342752@cherry.de> <D_T0vfLiZ7iT-Zdru_yLBe3ZScLI_weV-fDDAFnDD4aJybbieGUfMXTEA-X5vakiZbsQeTAZ3DjRdyJRCZjM2FxdcR1WwxO4rk1cUUCTg7w=@on-the-web.ch> <4f8aafff-585f-436a-a986-26d331b8687b@cherry.de>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 1e460884dc03a7bcd6cf8619c6133988e84658a7
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------e72b74e0ccf4ebe69365336ce7fa27dee81832a87db041becf37d2c467184ef6"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 18:53:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3808

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------e72b74e0ccf4ebe69365336ce7fa27dee81832a87db041becf37d2c467184ef6
Content-Type: multipart/mixed;boundary=---------------------09cffec8c5b6ca26a5602bc63b234070

-----------------------09cffec8c5b6ca26a5602bc63b234070
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi Quentin,

On Friday, April 24th, 2026 at 6:45 PM, Quentin Schulz via lists.yoctoproj=
ect.org <quentin.schulz=3Dcherry.de@lists.yoctoproject.org> wrote:

> Hi Martin,
> =


> On 4/20/26 7:27 PM, Martin Herren via lists.yoctoproject.org wrote:
> > Hej,
> >
> >> Hi Martin, Trevor,
> >>
> >
> >> On 4/20/26 12:14 PM, Martin Herren wrote:
> >>> Dear maintainers,
> >>>
> >>> May I suggest the following 2 patches from meta-rockchip master to b=
e back ported to the Whinlatter branch ?
> >>>
> >>> fitimage rework: fe7cfa748bb132cfbe322c1c6d586f09557dbeb2
> >>>
> >>
> >
> >> This one is tricky. We shouldn't break existing users but this is a
> >> patch that isn't backward compatible as we would require users to set
> >> the RK_KERNEL_FITIMAGE variable to match the modifications they made =
to
> >> KERNEL_IMAGETYPE/KERNEL_CLASSES in their own machine configuration fi=
le
> >> based on the SoC machine include file. Can you tell us more about wha=
t
> >> is broken before this is backported? Maybe there's another way to
> >> implement a fix without breaking backward compatibility.
> >
> > Doing a `bitbake core-image-base` for `MACHINE =3D "rock-5b"` on curre=
nt whinlatter (including all other layers also on whinlatter) without this=
 patch leads to:
> >
> > ```
> > =E2=9D=AF bitbake core-image-base
> > Loading cache: 100% |#################################################=
##########################################################################=
############################| Time: 0:00:00
> > Loaded 0 entries from dependency cache.
> > ERROR: ParseError at /home/martin/dev/yocto/rockchip/layers/openembedd=
ed-core/meta/classes-recipe/kernel.bbclass:188: Could not inherit file cla=
sses/kernel-fitimage.bbclass| ETA:  0:00:17
> > ERROR: Parsing halted due to errors, see error messages above
> >
> > Summary: There were 2 ERROR messages, returning a non-zero exit code.
> > ```
> >
> =


> OK. So... The issue is that we don't know what third-party layers do.
> They may very well include rk3588s.inc or extend rock-5b.conf and modify
> KERNEL_CLASSES and KERNEL_IMAGETYPE to not use fitImage. I couldn't
> think of a way to not break them. The issue being that KERNEL_CLASSES
> cannot contain kernel-fitimage so we cannot check for its presence, and
> KERNEL_IMAGETYPE cannot contain fitImage anymore as well, so we also
> cannot check for its presence. Do you have an idea maybe?
> =


> I'm tempted to say "wait for wrynose" which now should be 2-3 weeks
> away.

Yes, that's fine for me. I switch to master and wrynose which is the goal =
anyway.

For info I just tested all available machines on whinlatter, the 7 machine=
s based on rk3066, rk3188 and rk3288 are not using fitImage and build fine=
. The rest, based on rk33xx and rk35xx, doesn't build out of the box. So e=
ither not used or overridden. No complaints, no real problem.

> The fact that nobody complained about this issue before is either
> because nobody uses the whinlatter branch (I don't for example) or
> because they already adapted their third-party layer to accommodate. The
> former isn't an issue, the latter is (well, wrt backporting this commit)=
.
> =


> I haven't tested but I'm suspecting you could use the content of
> conf/machine/include/rockchip-fitimage.inc and add it to your layer in
> your machine conf file after the other includes. Replace ?=3D with =3D,
> replace the +=3D with an =3D. Adapt in that same file the UBOOT_EXTLINUX=
_*
> variables to use the value as if KERNEL_IMAGETYPE was set to fitImage
> (and use =3D instead of ?=3D). From a cursory look, that may be enough.
> =


> > Applying this patch goes further:
> >
> > ```
> > ERROR: rockchip-rkbin-tf-a-git-r0 do_unpack: Recipes that set S =3D "$=
{WORKDIR}/git" or S =3D "${UNPACKDIR}/git" should remove that assignment, =
as S set by bitbake.conf in oe-core now works.
> > ERROR: Logfile of failure stored in: /home/martin/dev/yocto/rockchip/l=
ayers/build/tmp/work/rock_5b-oe-linux/rockchip-rkbin-tf-a/git/temp/log.do_=
unpack.34439
> > ERROR: Task (/home/martin/dev/yocto/rockchip/layers/meta-rockchip/reci=
pes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb:do_unpack) failed with exit code =
'1'
> > ERROR: rockchip-rkbin-ddr-git-r0 do_unpack: Recipes that set S =3D "${=
WORKDIR}/git" or S =3D "${UNPACKDIR}/git" should remove that assignment, a=
s S set by bitbake.conf in oe-core now works.
> > ERROR: Logfile of failure stored in: /home/martin/dev/yocto/rockchip/l=
ayers/build/tmp/work/rock_5b-oe-linux/rockchip-rkbin-ddr/git/temp/log.do_u=
npack.34438
> > ERROR: Task (/home/martin/dev/yocto/rockchip/layers/meta-rockchip/reci=
pes-bsp/rkbin/rockchip-rkbin-ddr_git.bb:do_unpack) failed with exit code '=
1'
> > ```
> >
> > Thus the 2nd suggested backport.
> >
> =


> We would also need 61505560d494 ("bsp: rkbin-native: fix build since
> ${WORKDIR} isn't allowed in S anymore") for completeness.
> =


> Cheers,
> Quentin

So happily switching to master now !

Thanks and Cheers,

Martin
-----------------------09cffec8c5b6ca26a5602bc63b234070--

--------e72b74e0ccf4ebe69365336ce7fa27dee81832a87db041becf37d2c467184ef6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmnru/wJEIiu+thqKlAPRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcme72RnCIQ+G/IbLG2F5Qz8coA1dZyn6bASlLBX1
tCwNIhYhBCYHlZbYUMXC4ILtW4iu+thqKlAPAAAhLAD+Kx+K0vgzCcHMBoHy
TmgBPAgCZ3SGeidQKTpEEjSvYXwBAJC7lLqD4uLItD1AE83SP9aSZRDbP2S4
uMKmgQVk9tYM
=525s
-----END PGP SIGNATURE-----


--------e72b74e0ccf4ebe69365336ce7fa27dee81832a87db041becf37d2c467184ef6--


