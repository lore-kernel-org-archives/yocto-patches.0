Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ABA10F285D
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 17:06:08 +0000 (UTC)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.77666.1774631161704632693
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Mar 2026 10:06:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lZX8K8+k;
 spf=pass (domain: gmail.com, ip: 74.125.224.50, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64edb56b70cso2154302d50.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 10:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774631160; cv=none;
        d=google.com; s=arc-20240605;
        b=Xsoqi+2yvtzvVLxRg6Pfx8b24JqwPJQesl7JRDYbCJEltFdlTjNHSzIozTl4TaLv2Y
         MOiUGpeIIxVkai7LmPu8ju33cyRoIm/R3InilBqG/etPZRPvk1PXQFV0yt/Rk47QHWw6
         kjmlqL9bnnOTO5W31kBbZUC1uX999yF8A+Tq5dLLihmYDRpV0W6btV6+KQIhyEzjh7l6
         VZX5xRxmDcfqshGLpaYfrqnODy/bu0JrMMU+9iawKgtEFvoZp5YGMPiKsqqF3GgR+hbl
         NDDnK06jcclGDwHrnhTWyYhCr6aQAKpLBY2BzN9COdm9pfs0dnnmEqtMCKRCT+JRUQJ5
         maBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=JGdc5c3oH6FtexVVBJiLQc3i5EjEJ397ifA6bxIYLrg=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=lK9lMSeYJUJfKSwOASmfVdFEG/cvXpo1XkZWHxdNXkdIDhlTSOBtQ7d1Uyl5HnHfRw
         RHaiPEWfSsC4K6VHrs/JsZwpf9h8jLVnAxEiVYg3GTMo3ZfBjgfl0fV9bJ8rsnFMhsFs
         F31jX2EIiPtm/UkE+ofGCH8OtO4c2BEDBj/0ZTOMh2BRsaCvBJvMgYhLsSL6dRlVH/nu
         j+2fDQy8zALKZc4TxuszP0VaYgCHR+M+allQPwcwPcnAWAR9h/4QycU+2m3KUmtGpIVl
         KR81vOdQJ8DmogrrrhAPKaLHrNI6vwNfmjiRWhSERp1mmCVgeJybQ74Ti3XuSQcvM0c1
         rq/w==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774631160; x=1775235960; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGdc5c3oH6FtexVVBJiLQc3i5EjEJ397ifA6bxIYLrg=;
        b=lZX8K8+k6UDUhDSGHZc8uJeaHgmL9SUmT1UPT+bNT675d835+9nxRL3/cryNY+TbiF
         Ac3i5YqF3qWuxdE+7eRD03GW7nkjo+5XgYkY9FZfPABfudyCwFvrRHzSCpVE9mW4Vvmb
         1GT02gweuHOTBdnED7ug17utM2TJYaOOhOCUNLyki/AUqpB2MsTkMR2GK5GQe6RPjbdY
         lLQVxOnsFFdSUI6M9WRhZIxZkYO2WKJFwlL7YlHIdh29TJYfhb7ojFu2AaOGjtA4ziVl
         cwN75VOYQGTVukGIuDfGEWTUnlOXwpF3HcnGVGyKhULXDZ0f82YjiAwjvTMmQyP8k5nK
         5E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774631160; x=1775235960;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGdc5c3oH6FtexVVBJiLQc3i5EjEJ397ifA6bxIYLrg=;
        b=NyHEvPkEz5x5PzGt3ISZuem2zjilaT/6nQH7X2gSkEq/lHDjiiRNLI36xc6AieA8V+
         yaqUZZsaxj+kIPS5lI1/mz2ByklWR/TH4OIi2k8MTxZ6CG3MaMPLawI4A4LxhteRIdBo
         VYPoyZp4Kf61xFmTi42/xDZBHuU/u5WnRi66cjB5QsjWOuEDxw+ZU8auVUeHKe61UA0i
         X0zpEpx+hh6WTHLDytEj8Wq5yJ8xPsA0obgn7/BtYRBNlOpx+mND+cC/AdtCv9/zfS3+
         sevHwhjtmxNfXpDwmsssfiaIRDwiUNsiM+aKBWLuL8vTpBULU57t9r/h9vk0uhX/BOr2
         DoAw==
X-Gm-Message-State: AOJu0YxhwiKq9JTHvRZDraq+G0ENvXlg/kaRAn4QxWDfsKW6FRwOkUyd
	QUJ/nl6sE90H4tXpRbaABy4Yy61vetyXsxjahIKuwwqdG6hJ5Q2Hr3x/HVGzN/vr3kN1V4HMG8a
	ecL0IsYwz4br3aon/Ift2AFpAK1IjWew1tACD+lc=
X-Gm-Gg: ATEYQzyGHXBaDhkazwaL8szHhmcUjm7bmRBqax2If8B8LZ4w5HdLv9reDS+EJ6DQoA8
	Hgeh/uVAdQgw8Vrbzt/rjvN2sjL2L/6NwCB/qWRweY6ZUWoYKCmMHtb4rgCN6jA1PYUMzFMQvkV
	dwDD7vmnA9RCW5uKq3a9aegv1geSNqgo4S/II0pb2Bdu4wOfKZAFy0BxqzMlaw2is1gm5yrpiIP
	h5c/vY4FDuknRo7Uu7anKm4bcZPfWXCCQH+Kv9bmt9Sdg1KmTSZINbzlDib4pVH3Dtw/79naSlv
	6KppLwSVFiR10Wa9C6WtZy5w959QaT1MQJPSRUPR
X-Received: by 2002:a05:690e:428f:20b0:64e:e47e:7f74 with SMTP id
 956f58d0204a3-64ff73cba61mr2979226d50.49.1774631159684; Fri, 27 Mar 2026
 10:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260326130653.478746-1-twoerner@gmail.com> <c653ec1d-4cfa-493d-9a12-37910a9e4937@cherry.de>
 <CADkTA4OA8=8WU8uNWBt0cQoXH6qrKfJ_XGTszgG3BoqZ6jq=yw@mail.gmail.com> <acXC2URDoReamW1S@localhost.localdomain>
In-Reply-To: <acXC2URDoReamW1S@localhost.localdomain>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Fri, 27 Mar 2026 13:06:00 -0400
X-Gm-Features: AQROBzAXDa0MrDy68Y3jLoN3DdYQvbvnuv_rd4mXRuV3bBL2XTueUggbs0nAFUg
Message-ID: <CADkTA4OcvMBTdiF+vnS6ZVf8JArN=L9fTc=X_2iS4Q-jMwknhA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] add kprobes for 32-bit kernels
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000e16c4d064e04837b"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 17:06:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3569

--000000000000e16c4d064e04837b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 7:35=E2=80=AFPM Trevor Woerner via lists.yoctoproje=
ct.org
<twoerner=3Dgmail.com@lists.yoctoproject.org> wrote:

> On Thu 2026-03-26 @ 04:08:16 PM, Bruce Ashfield via lists.yoctoproject.or=
g
> wrote:
> > On Thu, Mar 26, 2026 at 10:08=E2=80=AFAM Quentin Schulz via
> lists.yoctoproject.org
> > <quentin.schulz=3Dcherry.de@lists.yoctoproject.org> wrote:
> >
> > > Hi Trevor,
> > >
> > > On 3/26/26 2:06 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > > While building the modules for linux-yocto for 32-bit machines, the
> > > > following error occurs:
> > > >
> > > >       | probes/Kbuild:236: CONFIG_KALLSYMS_ALL is disabled, therefo=
re
> > > probe "writeback" is disabled. Rebuild your kernel with this
> configuration
> > > option enabled in order to trace this subsystem.
> > > >       | wrapper/kallsyms.c:20:3: error: #error "LTTng-modules
> requires
> > > CONFIG_KPROBES on kernels >=3D 5.7.0"
> > > >       |    20 | # error "LTTng-modules requires CONFIG_KPROBES on
> > > kernels >=3D 5.7.0"
> > > >
> > > > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > > > ---
> > > >   recipes-kernel/linux/linux-rockchip.inc | 5 ++++-
> > > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/recipes-kernel/linux/linux-rockchip.inc
> > > b/recipes-kernel/linux/linux-rockchip.inc
> > > > index 6c62e849834c..4e67ff14f6e6 100644
> > > > --- a/recipes-kernel/linux/linux-rockchip.inc
> > > > +++ b/recipes-kernel/linux/linux-rockchip.inc
> > > > @@ -34,5 +34,8 @@ COMPATIBLE_MACHINE:soquartz =3D "soquartz"
> > > >   SRC_URI:append:rockchip =3D "
> > >
> file://rockchip-kmeta;type=3Dkmeta;name=3Drockchip-kmeta;destsuffix=3Droc=
kchip-kmeta"
> > > >   SRC_URI:append:nanopi-r4s =3D " file://realtek-r8169.cfg"
> > > >
> > > > -KERNEL_FEATURES:append:rockchip:arm =3D "
> > > bsp/rockchip/remove-non-rockchip-arch-arm.scc"
> > > > +KERNEL_FEATURES:append:rockchip:arm =3D " \
> > > > +    bsp/rockchip/remove-non-rockchip-arch-arm.scc \
> > > > +    features/kprobes/kprobes.scc \
> > >
> > > This is coming from the yocto-kernel-cache as far as I could tell. It=
's
> > > only available if the recipe actually points to it and only linux-yoc=
to
> > > recipes do that. linux-mainline and linux-stable from
> > > meta-linux-mainline which you've said in the past you're using
> sometimes
> > > do not support that from a cursory look.
> > >
> > > What happens if there's a KERNEL_FEATURES that isn't found?
> > >
> > > Maybe we should have this in some linux-yocto bbappend instead? Or
> > > import this fragment into meta-rockchip (the downside being we need t=
o
> > > maintain this on our own then, but it's been updated only once, 8.5y
> ago
> > > so not too much risk for this one I guess.
> > >
> >
> > or just do what meta-virtualization does. See the yocto-cfg-fragments
> > recipe.
> > It makes the fragments available to anything using linux-yocto
> > infrastructure,
> > but for whatever reason doesn't have meta on it's SRC_URI
>
> I get the feeling this isn't a rockchip-specific issue necessarily. Are
> linux-yocto kernel builds for other 32-bit (probably Arm) machines
> seeing the same thing? Is this something I should be looking to solve
> more broadly?
>
>
The standard kernel type always includes kprobes, so they don't have
this issue.

Bruce



> >
> > Bruce
> >
> >
> >
> > >
> > > Cheers,
> > > Quentin
> > >
> > >
> > >
> > >
> > >
> > >
> >
> > --
> > - Thou shalt not follow the NULL pointer, for chaos and madness await
> thee
> > at its end
> > - "Use the force Harry" - Gandalf, Star Trek II
> >
> >
> >
> >
> >
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3561):
> https://lists.yoctoproject.org/g/yocto-patches/message/3561
> Mute This Topic: https://lists.yoctoproject.org/mt/118517725/1050810
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13171493/1050810/607=
820704/xyzzy
> [bruce.ashfield@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--000000000000e16c4d064e04837b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 26, 2026 at 7:35=
=E2=80=AFPM Trevor Woerner via <a href=3D"http://lists.yoctoproject.org">li=
sts.yoctoproject.org</a> &lt;twoerner=3D<a href=3D"mailto:gmail.com@lists.y=
octoproject.org">gmail.com@lists.yoctoproject.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Thu 2026-03-26 @ 04:08:=
16 PM, Bruce Ashfield via <a href=3D"http://lists.yoctoproject.org" rel=3D"=
noreferrer" target=3D"_blank">lists.yoctoproject.org</a> wrote:<br>
&gt; On Thu, Mar 26, 2026 at 10:08=E2=80=AFAM Quentin Schulz via <a href=3D=
"http://lists.yoctoproject.org" rel=3D"noreferrer" target=3D"_blank">lists.=
yoctoproject.org</a><br>
&gt; &lt;quentin.schulz=3D<a href=3D"mailto:cherry.de@lists.yoctoproject.or=
g" target=3D"_blank">cherry.de@lists.yoctoproject.org</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hi Trevor,<br>
&gt; &gt;<br>
&gt; &gt; On 3/26/26 2:06 PM, Trevor Woerner via <a href=3D"http://lists.yo=
ctoproject.org" rel=3D"noreferrer" target=3D"_blank">lists.yoctoproject.org=
</a> wrote:<br>
&gt; &gt; &gt; While building the modules for linux-yocto for 32-bit machin=
es, the<br>
&gt; &gt; &gt; following error occurs:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0| probes/Kbuild:236: CONFIG_KALLSY=
MS_ALL is disabled, therefore<br>
&gt; &gt; probe &quot;writeback&quot; is disabled. Rebuild your kernel with=
 this configuration<br>
&gt; &gt; option enabled in order to trace this subsystem.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0| wrapper/kallsyms.c:20:3: error: =
#error &quot;LTTng-modules requires<br>
&gt; &gt; CONFIG_KPROBES on kernels &gt;=3D 5.7.0&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 20 | # error &quot;=
LTTng-modules requires CONFIG_KPROBES on<br>
&gt; &gt; kernels &gt;=3D 5.7.0&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Trevor Woerner &lt;<a href=3D"mailto:twoerner=
@gmail.com" target=3D"_blank">twoerner@gmail.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 =C2=A0recipes-kernel/linux/linux-rockchip.inc | 5 ++++=
-<br>
&gt; &gt; &gt;=C2=A0 =C2=A01 file changed, 4 insertions(+), 1 deletion(-)<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/recipes-kernel/linux/linux-rockchip.inc<br>
&gt; &gt; b/recipes-kernel/linux/linux-rockchip.inc<br>
&gt; &gt; &gt; index 6c62e849834c..4e67ff14f6e6 100644<br>
&gt; &gt; &gt; --- a/recipes-kernel/linux/linux-rockchip.inc<br>
&gt; &gt; &gt; +++ b/recipes-kernel/linux/linux-rockchip.inc<br>
&gt; &gt; &gt; @@ -34,5 +34,8 @@ COMPATIBLE_MACHINE:soquartz =3D &quot;soqu=
artz&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0SRC_URI:append:rockchip =3D &quot;<br>
&gt; &gt; file://rockchip-kmeta;type=3Dkmeta;name=3Drockchip-kmeta;destsuff=
ix=3Drockchip-kmeta&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0SRC_URI:append:nanopi-r4s =3D &quot; file://real=
tek-r8169.cfg&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -KERNEL_FEATURES:append:rockchip:arm =3D &quot;<br>
&gt; &gt; bsp/rockchip/remove-non-rockchip-arch-arm.scc&quot;<br>
&gt; &gt; &gt; +KERNEL_FEATURES:append:rockchip:arm =3D &quot; \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 bsp/rockchip/remove-non-rockchip-arch-arm.scc=
 \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 features/kprobes/kprobes.scc \<br>
&gt; &gt;<br>
&gt; &gt; This is coming from the yocto-kernel-cache as far as I could tell=
. It&#39;s<br>
&gt; &gt; only available if the recipe actually points to it and only linux=
-yocto<br>
&gt; &gt; recipes do that. linux-mainline and linux-stable from<br>
&gt; &gt; meta-linux-mainline which you&#39;ve said in the past you&#39;re =
using sometimes<br>
&gt; &gt; do not support that from a cursory look.<br>
&gt; &gt;<br>
&gt; &gt; What happens if there&#39;s a KERNEL_FEATURES that isn&#39;t foun=
d?<br>
&gt; &gt;<br>
&gt; &gt; Maybe we should have this in some linux-yocto bbappend instead? O=
r<br>
&gt; &gt; import this fragment into meta-rockchip (the downside being we ne=
ed to<br>
&gt; &gt; maintain this on our own then, but it&#39;s been updated only onc=
e, 8.5y ago<br>
&gt; &gt; so not too much risk for this one I guess.<br>
&gt; &gt;<br>
&gt; <br>
&gt; or just do what meta-virtualization does. See the yocto-cfg-fragments<=
br>
&gt; recipe.<br>
&gt; It makes the fragments available to anything using linux-yocto<br>
&gt; infrastructure,<br>
&gt; but for whatever reason doesn&#39;t have meta on it&#39;s SRC_URI<br>
<br>
I get the feeling this isn&#39;t a rockchip-specific issue necessarily. Are=
<br>
linux-yocto kernel builds for other 32-bit (probably Arm) machines<br>
seeing the same thing? Is this something I should be looking to solve<br>
more broadly?<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">The standard kernel type always includes kprobes, so they =
don&#39;t have</div><div class=3D"gmail_default" style=3D"font-size:small">=
this issue.</div><div class=3D"gmail_default" style=3D"font-size:small"><br=
></div><div class=3D"gmail_default" style=3D"font-size:small">Bruce</div><b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; Bruce<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Cheers,<br>
&gt; &gt; Quentin<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; <br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; <br>
&gt; -- <br>
&gt; - Thou shalt not follow the NULL pointer, for chaos and madness await =
thee<br>
&gt; at its end<br>
&gt; - &quot;Use the force Harry&quot; - Gandalf, Star Trek II<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3561): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/3561" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/3561</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/118517725/105=
0810" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/118517725/1050810</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13171493/1050810/607820704/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13171493/1050810/6078207=
04/xyzzy</a> [<a href=3D"mailto:bruce.ashfield@gmail.com" target=3D"_blank"=
>bruce.ashfield@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">- Thou shalt not follow the NULL pointer, for chaos and madness a=
wait thee at its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star T=
rek II<br><br></div></div>

--000000000000e16c4d064e04837b--

