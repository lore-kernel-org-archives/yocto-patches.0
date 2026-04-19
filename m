Return-Path: <michael@amarulasolutions.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9669FEA7196
	for <webhook@archiver.kernel.org>; Sun, 19 Apr 2026 10:12:09 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5865.1776593522688249938
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 19 Apr 2026 03:12:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=d84f0GCw;
 spf=pass (domain: amarulasolutions.com, ip: 74.125.82.171, mailfrom: michael@amarulasolutions.com)
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso1772278eec.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 19 Apr 2026 03:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776593522; cv=none;
        d=google.com; s=arc-20240605;
        b=dPiewEUzFXDD/qJlCJh7wDggsnIL3vNYZCY9Y70XbTbOP9cvxl5/Pav+xgcxESWOa7
         yQMBHPFEl2C8JP5lgEiEP1RtWn9qKkk5/GjARG6UklUO/FyYFXanWuFpTVrkD7TUKEqq
         yLTUQ84N24+T+Pa8M9wSX6F/w6tkb8Ug+KCK/3TNuBm7v5xdlDWueMo1oym71KvfRKaK
         GagCH3vNV57uFWwEFh71B0I0jpca7ccMWRR7R2eBP+E4eT6uQ94vVrQhbBLDseVpPa7V
         Zc1YIESKBGgEAbEcj4usVS8hW/FA4Ce/crpBeTQUSbcEVtViKUb7Aovowcqv+5UqT3T0
         AdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Il3AgC7IELKR9RH1vYUitMIFDoQ2GzbAGbBXU6sOivA=;
        fh=u5y/fV0y01xno7bV/8wxhRuk/xfJv6jNQKIdWBR5KX8=;
        b=IhD7rLImIu6Vo2m45wcdIvToeigZEjk0tF5rRTbUvwvvS0ag9Js1fIc35kEtrcPJXN
         bDvtVHsRd7MfxQ01MHRSi8B0AYdMlJnOtwnKCJ7QqNfEUjFvnHWLUuZ6PSi/8Cl/KXrA
         1d4EI+XvpsFBld5d1NEfvh3wIKzmmJtFD+BetoCXvSvVCBo/WqK/WJ1NGommRYuyN7ei
         Ppp0BNe6wVucXJyXzbgNuLgdsM6DaahSqM/18uX+Tidtrkk9CEVcsb1SlVZYUk4b5jr0
         OxZnMaVAnvoXa17BIB1VYk9pEmWa9FSq1XE0/vBCIg6S18odGwotRb39Jz4spTKIeRqa
         kc2w==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1776593522; x=1777198322; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Il3AgC7IELKR9RH1vYUitMIFDoQ2GzbAGbBXU6sOivA=;
        b=d84f0GCw9EyW0KBp5eb6UpjfAXq5AP20fLlKKtQVc6DfP721W3bz2NMRPnjNtHvtNk
         zLhtRNfb7hTvJN+uMIaICexLJ179RnHYQbAszivjUgpb/BCk+flw5s+JHR9SoImLf8v+
         KoCuY+ZU+fnGzOd7ZNYBidznWn4qrdEVYPCEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776593522; x=1777198322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il3AgC7IELKR9RH1vYUitMIFDoQ2GzbAGbBXU6sOivA=;
        b=I42aovFS0DosSM1bxZlgf4/sryrrhfJmnDLvzGTQXxpxNFbLpv4XbwrZdmSGPGQ9Ou
         Q7lVqRTFn/B3ASSHgpp+pyddjmfLkF2mo41oyQkF8vtQg2rPiuRvWfUsHY3cfF/S1TZV
         MBPEdcwljLgenMG/08R68VfND8NhUVD6IW+jSvejZmpshomoagyhVQJQRT/5zKV/PlFG
         7IYeo/81BEis6Md+vHrincsqWayyu7bgX5KLMtoSjwLF7mSEsbGHBEhhK6TTaavKSOaS
         GHmfcb1Ad+3bpNWgaIJ7C1QwFu3c61Y0zEyTMo/GyXm930Czl6zUjm70lhckdJaZP9m2
         4BIQ==
X-Gm-Message-State: AOJu0YwfMHAkZGoKw0KWMoBXFp++STNs1a7KV8q2CsVZFHHGkI4/Ylxh
	yYb74susUJGMbAZdzVXq2HBgMafUHa79tVf0FHHGGttdOtYmB4X/5uQO2oixfEGAcz74iUDtR8C
	J0XNATfBDtDywvH6QDU8GxF/hO9nQWF7jn/Gir3PwjA==
X-Gm-Gg: AeBDiesAw10TqBobhjwts2ezWp2x/N0YYGdB/+elyVfIsdbd1cPQWcpHvNwOhfAQgG3
	O4JUTwQQyNvrUScW0LYfX6tXAaLQoxKozJpx8oZl/0WNixULwiFNjezrcsJJJfxS/dEEIfs2ICc
	LOEYMxt5SED6FXlr0Ld69cMVClk7fo+fq0pD0ieu9d+I+yOXfwMXkDEfPR+nADqVmgkFtAAV16R
	kJGsoMGORdveMYa/CkL9IJVjgvYnHwrw81E2RSWDW1CtLnipa8rGPOoISV+g01V+50ViThY2quJ
	qwlWJci6Lu52aCqAu1VlHdj2YaIszrJIU7qCXmvZNnYhimE=
X-Received: by 2002:a05:7300:8622:b0:2c1:7480:ff9b with SMTP id
 5a478bee46e88-2e42e6e99b7mr3838015eec.18.1776593521699; Sun, 19 Apr 2026
 03:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260419085321.3608814-1-michael@amarulasolutions.com> <CA+chaQe8uPCAAfKD6Y+n8F+MUV0oz3LKXOoa3t+aLds7QHg1yw@mail.gmail.com>
In-Reply-To: <CA+chaQe8uPCAAfKD6Y+n8F+MUV0oz3LKXOoa3t+aLds7QHg1yw@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 19 Apr 2026 12:11:50 +0200
X-Gm-Features: AQROBzDwkAj2dlTHqXB_lPKedG-7cNoAPGOn9om781K1SoS2xRj6Rg1Zc_S6QSk
Message-ID: <CAOf5uwkNYN6tR3W5BLPpiR+_eUsJHXy3d=UFZYeOKNTDkXoXXA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH V2] wic: wic need to be
 moved to files/wic within the layer to be found/used
To: Martin Jansa <martin.jansa@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000c57fde064fcd696d"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 19 Apr 2026 10:12:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3731

--000000000000c57fde064fcd696d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sun, Apr 19, 2026 at 11:54=E2=80=AFAM Martin Jansa <martin.jansa@gmail.c=
om>
wrote:

> Not sure where you're seeing the issue now, but it was fixed in master
> and wrynose branch 11 days ago with:
>
> https://git.yoctoproject.org/meta-rockchip/commit/?id=3D7bc349061e8ac3f03=
b5646f2ae1d3958ce53c460
>
>
I was quite sure to have rebased, but you are right. I have this commit
after the rebase.

Michael



> On Sun, Apr 19, 2026 at 10:53=E2=80=AFAM Michael Nazzareno Trimarchi via
> lists.yoctoproject.org
> <michael=3Damarulasolutions.com@lists.yoctoproject.org> wrote:
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> > V1->V2:
> >
> > - Fix correct directory to be wic
> >
> > ---
> >  {wic =3D> files/wic}/rockchip.wks | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename {wic =3D> files/wic}/rockchip.wks (100%)
> >
> > diff --git a/wic/rockchip.wks b/files/wic/rockchip.wks
> > similarity index 100%
> > rename from wic/rockchip.wks
> > rename to files/wic/rockchip.wks
> > --
> > 2.53.0
> >
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#3729):
> https://lists.yoctoproject.org/g/yocto-patches/message/3729
> > Mute This Topic: https://lists.yoctoproject.org/mt/118901614/3617156
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13388836/3617156/669=
60823/xyzzy
> [martin.jansa@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> >
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

--000000000000c57fde064fcd696d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Apr 19, 2026 at 11:54=
=E2=80=AFAM Martin Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.com">mart=
in.jansa@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Not sure where you&#39;re seeing the issue now, but it wa=
s fixed in master<br>
and wrynose branch 11 days ago with:<br>
<a href=3D"https://git.yoctoproject.org/meta-rockchip/commit/?id=3D7bc34906=
1e8ac3f03b5646f2ae1d3958ce53c460" rel=3D"noreferrer" target=3D"_blank">http=
s://git.yoctoproject.org/meta-rockchip/commit/?id=3D7bc349061e8ac3f03b5646f=
2ae1d3958ce53c460</a><br>
<br></blockquote><div><br></div><div>I was quite sure to have rebased, but =
you are right. I have this commit after the rebase.</div><div><br></div><di=
v>Michael</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
On Sun, Apr 19, 2026 at 10:53=E2=80=AFAM Michael Nazzareno Trimarchi via<br=
>
<a href=3D"http://lists.yoctoproject.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.yoctoproject.org</a><br>
&lt;michael=3D<a href=3D"mailto:amarulasolutions.com@lists.yoctoproject.org=
" target=3D"_blank">amarulasolutions.com@lists.yoctoproject.org</a>&gt; wro=
te:<br>
&gt;<br>
&gt; Signed-off-by: Michael Trimarchi &lt;<a href=3D"mailto:michael@amarula=
solutions.com" target=3D"_blank">michael@amarulasolutions.com</a>&gt;<br>
&gt; ---<br>
&gt; V1-&gt;V2:<br>
&gt;<br>
&gt; - Fix correct directory to be wic<br>
&gt;<br>
&gt; ---<br>
&gt;=C2=A0 {wic =3D&gt; files/wic}/rockchip.wks | 0<br>
&gt;=C2=A0 1 file changed, 0 insertions(+), 0 deletions(-)<br>
&gt;=C2=A0 rename {wic =3D&gt; files/wic}/rockchip.wks (100%)<br>
&gt;<br>
&gt; diff --git a/wic/rockchip.wks b/files/wic/rockchip.wks<br>
&gt; similarity index 100%<br>
&gt; rename from wic/rockchip.wks<br>
&gt; rename to files/wic/rockchip.wks<br>
&gt; --<br>
&gt; 2.53.0<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#3729): <a href=3D"https://lists.yoctoproject.org/g=
/yocto-patches/message/3729" rel=3D"noreferrer" target=3D"_blank">https://l=
ists.yoctoproject.org/g/yocto-patches/message/3729</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/11890161=
4/3617156" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.=
org/mt/118901614/3617156</a><br>
&gt; Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoprojec=
t.org" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches=
/leave/13388836/3617156/66960823/xyzzy" rel=3D"noreferrer" target=3D"_blank=
">https://lists.yoctoproject.org/g/yocto-patches/leave/13388836/3617156/669=
60823/xyzzy</a> [<a href=3D"mailto:martin.jansa@gmail.com" target=3D"_blank=
">martin.jansa@gmail.com</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;<br>
&gt;<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Michael Nazzareno Trimarchi<br>Co-Founder &amp; =
Chief Executive Officer<br>M. +39 347 913 2170<br><a href=3D"mailto:michael=
@amarulasolutions.com" target=3D"_blank">michael@amarulasolutions.com</a><b=
r>__________________________________<br><div><br></div><div>Amarula Solutio=
ns BV</div>Joop Geesinkweg 125, 1114 AB, Amsterdam, NL<br>T. +31 (0)85 111 =
9172<br><a href=3D"mailto:info@amarulasolutions.com" target=3D"_blank">info=
@amarulasolutions.com</a><br><a href=3D"http://www.amarulasolutions.com" ta=
rget=3D"_blank">www.amarulasolutions.com</a><br></div></div></div>

--000000000000c57fde064fcd696d--

