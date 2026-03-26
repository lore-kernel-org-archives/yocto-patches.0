Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E29210AB81D
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 20:08:30 +0000 (UTC)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.58078.1774555703629154076
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Mar 2026 13:08:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=C+uqwLy9;
 spf=pass (domain: gmail.com, ip: 74.125.224.48, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64e8cdafeffso1851979d50.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 13:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774555702; cv=none;
        d=google.com; s=arc-20240605;
        b=QEzqMjs1BMQoCuTDQ/vUh08bOVJ3zQtUuBmPaG7N9VeUlHRyz4Vs9vx2E+v8s91nk8
         AEdFqROAwHAJVup1UtH17Rv8uR43TcWr9OAfFqpw8oLTfXiPSRks5LVU+Hb5txgnH/LA
         BRUSVHwtjd8SGinJjhbkWhFqt42aywIXSgrzTT2lFW0rOTHKyYiH0+5HvAORCAvg4AGZ
         0K19dP96J8KNubgj9B0pPxwUKpyyU/5Xs5A9RT8VGZF5x8RaW9X6Apo0Spu9i5ZE/Zpm
         ftXTNffMFFuvddNe/dUmS3WKeiHBuibIO4ELOjrH7lyAj9Ztrjk6nDZ92JUOBv/azTXI
         cCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=PK7DbBEnnicKX/0iS//TVVmhbzyXp+o3aR06jagnwew=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=CVEOAqWli/XIKfLOrGWqXdacvPixcpTNQTHokX5/gmdaolQl5bEwhHgTUvI0N0+7Ta
         7v+w42+w+tnwb145uTCv8TUF2NG/5qMG+UCsiq58fD2nQRuRGEyHUenqE9EE1g8IOE7D
         S+296iA2eihOCiSWK+IYFQygpXacDNifY5wf4SbxGrqoiaowZpA1uv9WgcgF7OrRUH9u
         v1B3M/BwtSCzDEI1te7CdTJ+UTE+qKgSVScUT6q1YidzKREQh/DlkJ4M4psh1jTUYOA3
         dDkjZ+GKWgiqERuT7roKsJnGk769ofA3dViS0gIyNpKvoKijCthNa0xfL6ekO4QkiFz8
         ZppA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774555702; x=1775160502; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PK7DbBEnnicKX/0iS//TVVmhbzyXp+o3aR06jagnwew=;
        b=C+uqwLy9L4iwO0iCALbSTxhV4tVP/aufC0DGPb8AJXa978120ZRAgNLOUeR/9uN1eB
         y5Y/PyWqjOxseiy9rs8pwYldE+RqT6AyPV737wSC7pSqBF6B6ghUAc2Pm77o8Qqn/GDX
         WxxL5cL88f4a6hWaTQHSEHtO7px9wNODuyzvhrd3jMLAy7iyyarpJsxwR7Ef+uFpTNHx
         d7V8WxwHvu7/9KsGW6NO+vB4TbxFwg1YqCbplcHtwLL7lFcAZ3nWxiuUvfyOdD9YpSLZ
         RC7eBE0K6UcnzK5aOXH3qUiB/BQidx2QVcdFJ325rDC/afcnTNvYBAqYecQtaXIGZLUm
         7cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774555702; x=1775160502;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PK7DbBEnnicKX/0iS//TVVmhbzyXp+o3aR06jagnwew=;
        b=o/6WXRlgGmmMLtQ3VRfLLdxvxZxIv+98ppCtPEPTcIC8zpkStpeerzmPO9glsIpsNj
         tLQIi7wouhIER9vJRuL/MVeDcOrPotWOvsPIQmySEJcuxJx1+OU580gbRYc3XwISUHGK
         Fo5jRCM7HEc7o9GnZBVBUWNOtFWnJKR4rU2MHxEFuKj6b9jGIHgKMuFAiQ/43Dgi6bAb
         dwD51tsYSqHBmOK3RAEEmZF9isirZJLhwULWF3WMbnOeBZLPsqkeFfLyS0BxlFOZ9+7d
         0hTjsRDlNoGRx0FChEPDH8DNq5swa7aZI56inK0+JIyOiaR1KGqbdS9VIh+5MKY8NV/1
         FTDQ==
X-Gm-Message-State: AOJu0YwMBuFL3N/CqD9akABj8lItWjUFeVHWIoaLgmWD6NMo5d57gDpf
	M/+bKO5mia2RE/5g8/D1GbxFgORfzIREeL7PQXyfDhJRj0JUrlC29gRh0jyq7Dr5jNO8gN1ewuS
	CIv2Y0/eryJVjLNCRqFCNJ0WypyB/GhlbkTSNI1Q=
X-Gm-Gg: ATEYQzwa44heoOck9MN1Etwc2qBL95Xh4rQghDzBDKv2mPBKKsOBUu5S0oD0zNt1QnH
	Fp7CTQ5CtVx3lVNSulWn8YeAsM0S/cJfdLdBguMj8z2ey/qJ8PL9A8YTkmLA5ihuz1lJoxF7bVO
	PYaksjP7NUfshChya7Goupbskj6FlO+KcKwASO2YAzuPkdkqkk6BhY0XWTZZac5sjW8fQ8k3LHC
	aJBNvaLm956juzJHYSwFt070fE7zz4UPjIYRxoJm5KVd9irxhSHAvsR1XRRugcerOONAnUX5weL
	Pjz2j8gXq78ir0qHkDoDivvLM8DryeDH3CHaY6fy
X-Received: by 2002:a05:690e:408c:b0:644:7479:4b1d with SMTP id
 956f58d0204a3-64fee1e64a2mr2391979d50.8.1774555701645; Thu, 26 Mar 2026
 13:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260326130653.478746-1-twoerner@gmail.com> <c653ec1d-4cfa-493d-9a12-37910a9e4937@cherry.de>
In-Reply-To: <c653ec1d-4cfa-493d-9a12-37910a9e4937@cherry.de>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Thu, 26 Mar 2026 16:08:16 -0400
X-Gm-Features: AQROBzAqKyXYPbXhzdPoCuxv0UmAws9XlT8Enj_rdZw0-MAF0K6agE_N9DYZKOA
Message-ID: <CADkTA4OA8=8WU8uNWBt0cQoXH6qrKfJ_XGTszgG3BoqZ6jq=yw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] add kprobes for 32-bit kernels
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000003b1516064df2f2e2"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 20:08:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3560

--0000000000003b1516064df2f2e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 10:08=E2=80=AFAM Quentin Schulz via lists.yoctoproj=
ect.org
<quentin.schulz=3Dcherry.de@lists.yoctoproject.org> wrote:

> Hi Trevor,
>
> On 3/26/26 2:06 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > While building the modules for linux-yocto for 32-bit machines, the
> > following error occurs:
> >
> >       | probes/Kbuild:236: CONFIG_KALLSYMS_ALL is disabled, therefore
> probe "writeback" is disabled. Rebuild your kernel with this configuratio=
n
> option enabled in order to trace this subsystem.
> >       | wrapper/kallsyms.c:20:3: error: #error "LTTng-modules requires
> CONFIG_KPROBES on kernels >=3D 5.7.0"
> >       |    20 | # error "LTTng-modules requires CONFIG_KPROBES on
> kernels >=3D 5.7.0"
> >
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   recipes-kernel/linux/linux-rockchip.inc | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/recipes-kernel/linux/linux-rockchip.inc
> b/recipes-kernel/linux/linux-rockchip.inc
> > index 6c62e849834c..4e67ff14f6e6 100644
> > --- a/recipes-kernel/linux/linux-rockchip.inc
> > +++ b/recipes-kernel/linux/linux-rockchip.inc
> > @@ -34,5 +34,8 @@ COMPATIBLE_MACHINE:soquartz =3D "soquartz"
> >   SRC_URI:append:rockchip =3D "
> file://rockchip-kmeta;type=3Dkmeta;name=3Drockchip-kmeta;destsuffix=3Droc=
kchip-kmeta"
> >   SRC_URI:append:nanopi-r4s =3D " file://realtek-r8169.cfg"
> >
> > -KERNEL_FEATURES:append:rockchip:arm =3D "
> bsp/rockchip/remove-non-rockchip-arch-arm.scc"
> > +KERNEL_FEATURES:append:rockchip:arm =3D " \
> > +    bsp/rockchip/remove-non-rockchip-arch-arm.scc \
> > +    features/kprobes/kprobes.scc \
>
> This is coming from the yocto-kernel-cache as far as I could tell. It's
> only available if the recipe actually points to it and only linux-yocto
> recipes do that. linux-mainline and linux-stable from
> meta-linux-mainline which you've said in the past you're using sometimes
> do not support that from a cursory look.
>
> What happens if there's a KERNEL_FEATURES that isn't found?
>
> Maybe we should have this in some linux-yocto bbappend instead? Or
> import this fragment into meta-rockchip (the downside being we need to
> maintain this on our own then, but it's been updated only once, 8.5y ago
> so not too much risk for this one I guess.
>

or just do what meta-virtualization does. See the yocto-cfg-fragments
recipe.
It makes the fragments available to anything using linux-yocto
infrastructure,
but for whatever reason doesn't have meta on it's SRC_URI

Bruce



>
> Cheers,
> Quentin
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3556):
> https://lists.yoctoproject.org/g/yocto-patches/message/3556
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

--0000000000003b1516064df2f2e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 26, 2026 at 10:08=
=E2=80=AFAM Quentin Schulz via <a href=3D"http://lists.yoctoproject.org">li=
sts.yoctoproject.org</a> &lt;quentin.schulz=3D<a href=3D"mailto:cherry.de@l=
ists.yoctoproject.org">cherry.de@lists.yoctoproject.org</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Trevor,<br>
<br>
On 3/26/26 2:06 PM, Trevor Woerner via <a href=3D"http://lists.yoctoproject=
.org" rel=3D"noreferrer" target=3D"_blank">lists.yoctoproject.org</a> wrote=
:<br>
&gt; While building the modules for linux-yocto for 32-bit machines, the<br=
>
&gt; following error occurs:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0| probes/Kbuild:236: CONFIG_KALLSYMS_ALL is =
disabled, therefore probe &quot;writeback&quot; is disabled. Rebuild your k=
ernel with this configuration option enabled in order to trace this subsyst=
em.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0| wrapper/kallsyms.c:20:3: error: #error &qu=
ot;LTTng-modules requires CONFIG_KPROBES on kernels &gt;=3D 5.7.0&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 20 | # error &quot;LTTng-modu=
les requires CONFIG_KPROBES on kernels &gt;=3D 5.7.0&quot;<br>
&gt; <br>
&gt; Signed-off-by: Trevor Woerner &lt;<a href=3D"mailto:twoerner@gmail.com=
" target=3D"_blank">twoerner@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0recipes-kernel/linux/linux-rockchip.inc | 5 ++++-<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/=
linux/linux-rockchip.inc<br>
&gt; index 6c62e849834c..4e67ff14f6e6 100644<br>
&gt; --- a/recipes-kernel/linux/linux-rockchip.inc<br>
&gt; +++ b/recipes-kernel/linux/linux-rockchip.inc<br>
&gt; @@ -34,5 +34,8 @@ COMPATIBLE_MACHINE:soquartz =3D &quot;soquartz&quot;=
<br>
&gt;=C2=A0 =C2=A0SRC_URI:append:rockchip =3D &quot; file://rockchip-kmeta;t=
ype=3Dkmeta;name=3Drockchip-kmeta;destsuffix=3Drockchip-kmeta&quot;<br>
&gt;=C2=A0 =C2=A0SRC_URI:append:nanopi-r4s =3D &quot; file://realtek-r8169.=
cfg&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -KERNEL_FEATURES:append:rockchip:arm =3D &quot; bsp/rockchip/remove-no=
n-rockchip-arch-arm.scc&quot;<br>
&gt; +KERNEL_FEATURES:append:rockchip:arm =3D &quot; \<br>
&gt; +=C2=A0 =C2=A0 bsp/rockchip/remove-non-rockchip-arch-arm.scc \<br>
&gt; +=C2=A0 =C2=A0 features/kprobes/kprobes.scc \<br>
<br>
This is coming from the yocto-kernel-cache as far as I could tell. It&#39;s=
 <br>
only available if the recipe actually points to it and only linux-yocto <br=
>
recipes do that. linux-mainline and linux-stable from <br>
meta-linux-mainline which you&#39;ve said in the past you&#39;re using some=
times <br>
do not support that from a cursory look.<br>
<br>
What happens if there&#39;s a KERNEL_FEATURES that isn&#39;t found?<br>
<br>
Maybe we should have this in some linux-yocto bbappend instead? Or <br>
import this fragment into meta-rockchip (the downside being we need to <br>
maintain this on our own then, but it&#39;s been updated only once, 8.5y ag=
o <br>
so not too much risk for this one I guess.<br></blockquote><div><br></div><=
div><div class=3D"gmail_default" style=3D"font-size:small">or just do what =
meta-virtualization does. See the yocto-cfg-fragments recipe.</div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">It makes the fragments avail=
able to anything using linux-yocto infrastructure,</div><div class=3D"gmail=
_default" style=3D"font-size:small">but for whatever reason doesn&#39;t hav=
e meta on it&#39;s SRC_URI</div><div class=3D"gmail_default" style=3D"font-=
size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small=
">Bruce</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
Cheers,<br>
Quentin<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3556): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/3556" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/3556</a><br>
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

--0000000000003b1516064df2f2e2--

