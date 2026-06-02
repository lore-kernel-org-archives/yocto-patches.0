Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A2ECD6E57
	for <webhook@archiver.kernel.org>; Tue,  2 Jun 2026 15:12:00 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.688.1780413110886062089
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Jun 2026 08:11:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=KY1lIvWH;
 spf=pass (domain: gmail.com, ip: 209.85.167.42, mailfrom: ticotimo@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so2505733e87.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jun 2026 08:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780413109; cv=none;
        d=google.com; s=arc-20240605;
        b=Spftdp3B9L+YwEUVM/CB14HY5/XrGtP6HUx42zGHzgCQKlmY9IhiKw5+GjIu3RrWCC
         F5A6krHVVhz7oKacPJfbaIAPAwm+XF2yVNvZCkHMGiU92GfX4K+uNrz/FBMP1H9+MGN6
         WNwIi1LUIYIrHqipGhBLbRmg9QQwoHDadOqTKMlTaWZ/Rmd0aGEoKTaovu6Q779m5e/i
         6Clo0T9F+cJpUMgdvM+NAxLtVeIjHrvq/ivK3pjMqTCeD2ahDd77YQVE145Xgp74KO9q
         tJ9mctC/bmW1isdAhafXmtMo6dKzVxyaQBY/fv4TnMZ2JHI+npSYp/AE+j7vicRbOrOP
         79Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=ull4X3LoKUzoP6De7x9SAWIW3FkOo1enrtEd5l0uXJw=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=HfR+6F6gkRSAu0W5BV8zEzufdF+Ahg+wz4Kb+g8iAORK+HZgb7l9BGqZnhWmEidV2Q
         AAU34IoCyRprUKfzVREVfZdSfgMw4MJQiHiqw/76nG8CiYhfZz/FHFKYyhFsxPbo3sRQ
         qQT1D4cAO78fkqCNd36LGUvH77PTYOuoifVWgM5i2Cf127ypIupcJhcx/GV+1t3rF6AO
         zRZMn0w10hc8Os0o2EzZr1/42wy7E06h2SmIyeL7bWK4EvJEENzjOdQTpglKD+HhTc/F
         TgsqIBGWZ3wAo5ytnWEl9Nd3dDiGdvFX1c1MBp40foDGkcEuj4g5ZvbOVLRdluYn+C/m
         KosA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780413109; x=1781017909; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ull4X3LoKUzoP6De7x9SAWIW3FkOo1enrtEd5l0uXJw=;
        b=KY1lIvWHYV5ZkwfEwAScziZcmRskvyCW5OPJANoJpIuMszM3WITXHISgq3EOj2l1D7
         iqrzuQkwmRLy1MbLnyRzW/Qi2Fy+yHn2spb/oVYKmad6zmS5KX1uQx4whuaGWdhlz365
         4S3OI6mAigbjsunX/GZORXiMfuTyFwWAdx87fM5fJBDTaly3DFpDIjxkIeAWEWnb5ZET
         m+6W+RvcJdmjuei2B4x+lZErtq/LpqC2w2EbyfCGueAXOIm195WonqEt/5eylL7BMIhn
         dJs1vX6YS0jIhlTk4eOK70g7/NO4dGlElh/fEbmdFQ1ASQ5KXTemqwUFHcZSY0vjsy26
         32fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413109; x=1781017909;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ull4X3LoKUzoP6De7x9SAWIW3FkOo1enrtEd5l0uXJw=;
        b=UCkkkSATpUd07mleDjq4QEVgnOa3HE+Gcrsw3X8SKKIW9OIZGehPr8XnlYKgxckMUW
         J/Zb+760J8KDcXGuT6BF8vWSBoliQ1ryCQyYFBx55AOn/JmrC4f4yjj8gm+TyK3CLb4l
         TBbsvmHApr9HgvzTP7E0yPA7abD7susiTbIoRWlT0f2+hqN6l2rF5xd9As3dVYTSU4GE
         KA3QJ25JGuVT+mDhvh5YHEMFf5JCZWbU2R1NsXhDMAAMYMxGa8WoYCMhGU+pp5dRFIaU
         QILay7nfeJns1AIkLGMvfIDwnCF0ehO6c7/uxN6HtzdAKibUvoS4xdS+UNIiKeGTCS0L
         DRHw==
X-Gm-Message-State: AOJu0YzszpRL4pc5x90isp/ZdTfTf++Lk5rV0dytGR1kOd4cPri1I97N
	KRmt4khE2TVEP5TVo61SgI0PgchV8XkDeXOpFXZdAd64MD4eGFCFATSJJiHplIa4RA0BYl9fnd8
	GrxlmtZ4TQ6VAvWJkox1bQUeEH4F4yqQQfg==
X-Gm-Gg: Acq92OFMY1pb75gGT/BTHb8xSOMlP5TPo/m3QK4EwpWi6trbAWobeAEH4yV0p60DapL
	+dFCZvdTHFLeEgNGZwVWRmUGIGXNJEtY6DHl0N7Tl0m4Nb9jkSy1umL/ih98riSc7X0ZxnhJ4IS
	c3Klwc4+qzbjO4wSbZ6GZp+KXFbiC17Z7A+nNnUYWlq6dS9/7p/07mpt26pUz73oMCiIbnTA5xF
	qQO/tA3vrFcuPwbyC3bTb8Kitk4+jutcbolAEwm8DfnUeHa00tKvdhDrdFVbz1kdCQUacxdHFcU
	Di6PMgpNWcRhF5W7/A==
X-Received: by 2002:a05:6512:1328:b0:5aa:7129:5d43 with SMTP id
 2adb3069b0e04-5aa7129604amr2137915e87.26.1780413108524; Tue, 02 Jun 2026
 08:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1780354513.git.tim.orling@konsulko.com> <aff1838ffcfb3e4c2aa1fe455dc0f74f87effdf6.1780354513.git.tim.orling@konsulko.com>
 <a79b6c395adcfaf933968401655642f018d53676.camel@pbarker.dev>
In-Reply-To: <a79b6c395adcfaf933968401655642f018d53676.camel@pbarker.dev>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 2 Jun 2026 08:11:34 -0700
X-Gm-Features: AVHnY4LYN3h8fhKHwDAv_RPiaUlLwgFeIKXA6uHnuYjO7E_iLrKX9whWlqjXdw8
Message-ID: <CANx9H-D_2Qf2_Jw2h6AhRpHUhQfWZpMhmdGqpciQ7LFMGJSzCg@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH v2 10/10]
 config.json: add 'containers-library' build job
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000e31924065346ba39"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jun 2026 15:12:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4114

--000000000000e31924065346ba39
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:02=E2=80=AFAM Paul Barker via lists.yoctoproject.o=
rg <paul=3D
pbarker.dev@lists.yoctoproject.org> wrote:

> On Mon, 2026-06-01 at 16:18 -0700, Tim Orling via lists.yoctoproject.org
> wrote:
> > From: Tim Orling <tim.orling@konsulko.com>
> >
> > Add 'containers-library' build job that build container images on top
> > of the vcontainer-tarball SDK:
> >
> >   * original container images from the intial "container-cross-install"
> >     branch of  meta-virtualization
> >     - container-base
> >     - app-container-curl
> >   * additional images modelled after docker.io/library/*
> >     - app-container-python
> >     - app-container-mosquitto
> >     - app-container-valkey
> >     - app-container-nginx
> >   * Tag containers with versions based on the recipe to which they are
> >     mapped, e.g. python:3, python:3.14, python:3.14.5.
>
> These version tags may exist in docker library/hardened images, but are
> they actually appropriate for the images we create?
>

They are tagged with 'wrynose' and 'yocto-6.0' (and release builds would be
tagged with full 'yocto-6.0.n').

We need to think about container consumers, not just Yocto users. Container
consumers want to know
what version of the tool is in the container they are consuming, so we
should follow the same tagging
pattern. Tags are cheap (they are just an alias for the same hash).


>
> I would expect python:master, python:blacksail, etc tags which track our
> branches.
>
> Best regards,
>
> --
> Paul Barker
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4112):
> https://lists.yoctoproject.org/g/yocto-patches/message/4112
> Mute This Topic: https://lists.yoctoproject.org/mt/119603250/924729
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/1023=
951714/xyzzy
> [ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000e31924065346ba39
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 2, =
2026 at 4:02=E2=80=AFAM Paul Barker via <a href=3D"http://lists.yoctoprojec=
t.org">lists.yoctoproject.org</a> &lt;paul=3D<a href=3D"mailto:pbarker.dev@=
lists.yoctoproject.org">pbarker.dev@lists.yoctoproject.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, 2026-06-0=
1 at 16:18 -0700, Tim Orling via <a href=3D"http://lists.yoctoproject.org" =
rel=3D"noreferrer" target=3D"_blank">lists.yoctoproject.org</a><br>
wrote:<br>
&gt; From: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.com" target=
=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; <br>
&gt; Add &#39;containers-library&#39; build job that build container images=
 on top<br>
&gt; of the vcontainer-tarball SDK:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* original container images from the intial &quot;containe=
r-cross-install&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0branch of=C2=A0 meta-virtualization<br>
&gt;=C2=A0 =C2=A0 =C2=A0- container-base<br>
&gt;=C2=A0 =C2=A0 =C2=A0- app-container-curl<br>
&gt;=C2=A0 =C2=A0* additional images modelled after <a href=3D"http://docke=
r.io/library/*" rel=3D"noreferrer" target=3D"_blank">docker.io/library/*</a=
><br>
&gt;=C2=A0 =C2=A0 =C2=A0- app-container-python<br>
&gt;=C2=A0 =C2=A0 =C2=A0- app-container-mosquitto<br>
&gt;=C2=A0 =C2=A0 =C2=A0- app-container-valkey<br>
&gt;=C2=A0 =C2=A0 =C2=A0- app-container-nginx<br>
&gt;=C2=A0 =C2=A0* Tag containers with versions based on the recipe to whic=
h they are<br>
&gt;=C2=A0 =C2=A0 =C2=A0mapped, e.g. python:3, python:3.14, python:3.14.5.<=
br>
<br>
These version tags may exist in docker library/hardened images, but are<br>
they actually appropriate for the images we create?<br></blockquote><div><b=
r></div><div>They are tagged with &#39;wrynose&#39; and &#39;yocto-6.0&#39;=
 (and release builds would be tagged with full &#39;yocto-6.0.n&#39;).</div=
><div><br></div><div>We need to think about container consumers, not just Y=
octo users. Container consumers want to know</div><div>what version of the =
tool is in the container they are consuming, so we should follow the same t=
agging</div><div>pattern. Tags are cheap (they are just an alias for the sa=
me hash).</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
I would expect python:master, python:blacksail, etc tags which track our<br=
>
branches.<br>
<br>
Best regards,<br>
<br>
-- <br>
Paul Barker<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#4112): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/4112" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/4112</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/119603250/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/119603250/924729</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13169857/924729/1023951714/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/10239517=
14/xyzzy</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticot=
imo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div></div>

--000000000000e31924065346ba39--

