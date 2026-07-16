Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F51C44512
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 15:21:13 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15451.1784215271258352303
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Jul 2026 08:21:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=JRHausPW;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: ticotimo@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b0117dda13so3195878e87.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 08:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784215269; cv=none;
        d=google.com; s=arc-20260327;
        b=g29jBgfJYEvPT1ra58u3F9LdCt2aFNN9zQVwOuUxYWhMQq5rZaIoL5xqybuXJVIR6A
         L4xI3gLQI8+LK/wNb3VMH/UDwjb+g6cs2Frt0Cw+pn3l+IM1spYvpqcWwKzZTG9LcmuL
         xqSqDkYD17DH2Bf7yNLgEcNKYyoHrgNZeZDRNQ1JHa7KR3A2alWrS/XPWwBIX4xrHPq+
         BVhrhcCfV3X7CTbvyFmBZFqAKosMHr+t1Azr+PAwrbGwNBrRZHB/LnXnlj2T8h1JjSTP
         xL59RYl0RzbLWRlnLR8xh7Q2xSKnIYr3hMB0qHiIVPXgA2YMh/Hwt3VY5SpHtid/Y4nN
         jELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=8BQQsbe+LBOHosSGkw9Up3R85zDJOZ/ULVCvoupaL4c=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=GPtPvaIbj2R0CMIsR73jUdb+fAe7DchUDU2wquZDkCMGmKYbzNCold3rlL0P+L8hMj
         g1OmbzvvM6tAtqoacmxRTzTtCRemP5PvrGSKDuMM2ZJePlES0sxJlOxmYS3pxVp12NFG
         A/95gxDf9y29Jbfke4ZLJu5uOLibwaB+w7iF1+HUixtiyTEmHwTwpzIwGIu2bBe4OC7g
         /ysC686K4PIYfcq5Jxbmc6u2iomVw30ps7DAcflHZednmexZsgAcO11dbnlpNL2Yldm/
         L74kgJgfJKiL0awvGQ9+V1LLMR8r54gfTp6cZStqN5iNza6DvLzG4H4f4UWU39DjK5Vx
         msOg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784215269; x=1784820069; darn=lists.yoctoproject.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8BQQsbe+LBOHosSGkw9Up3R85zDJOZ/ULVCvoupaL4c=;
        b=JRHausPWuhqOyhCMWq+NlZpLg9Oax0K0oUGvg3YEKe1unRLm/YelHoLZ2hrWx4VMgj
         xZyqSz73dRbj0btc1per1d9Oo/6TmzFVlRfiKb1EhJGfXp4fCOZtf/A2DRtfGmkj++ru
         rtT2kUgDktUKqzb5jem7a8O9S7vviLl4CZ4rFCWkPyoIU+/yE9Zf8QPUUlC3ymU38edm
         E0o7B9YD+cZ6vLS4279T17ALuCfte4Nesg8VemCTCjlQIt8GV39B21X86DBpU/0Cc+8v
         v6hbPJCsS8Hsg/EoxADwrqqhn/Sor+4lEh9RKUJUXweyE6+0eaEXIPrwwu1w0ka+qQrm
         fU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784215269; x=1784820069;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8BQQsbe+LBOHosSGkw9Up3R85zDJOZ/ULVCvoupaL4c=;
        b=Ls59hMBjq2DT4TB40f3uMvcIepOhx4Eg6tDzucEXZl71RLouf9IS9Sw8IXTtZSXsni
         KtyqjDczA9NFQHx8LSDrvccncmJcTdKvOhlYljdEEh/q/D623fRQsdJTmJgCAY0+njDl
         ABuKUmSk0BUkR8Rj/RKfZLFRdDRjzM+YTSrH+bvM41A3y4+G1alZFGJndzP9FBxbAxRS
         U+k2oqvvtHmkSN1nx64OtriJdUBEP41mknVinXkYe/OP3RbcChS+WuCU+orF7TONaf3A
         Z7dI80R3eFSF+mRddyKplWmBGISfwQXiUPdJ3Izvl+RbL85Zu4XrwlrT3oZYTH9/IWQj
         4ulA==
X-Gm-Message-State: AOJu0YyJPjkpJmDvjviDvsbMnze+KPn4Qtpqr4voWV+ytKH3E/W94Ypd
	5EEgyd2vzTyclEvqxsxPeB8wc2jpjZ0dLOe2qwDQTXPEn8H4xPiBIZZbvOsgmZyGQ0VKTuVlnIV
	Kvwqzd/Sqrds8dAmcE+WQnJz/NHA5A/RpAGMy
X-Gm-Gg: AfdE7cnZLmItlnOkXMb/0o6nDtsZcD9OCwZoBS+FTdh+g0gzX8VrEs65ZMdfdFIAQYG
	mR1shBmKIIv2oWDnUi+oI7gjNP5rMZ49FGnesKwcs5aUpGFpdoutAXYSr6eP8FJq5gfycNKO1Da
	3bUiKTA/QEvvUfuiVFYz36s3fmgocXjCkyirX438eXU7AgYAzJAMvEkayPeB9VOEKOyG4z0hwMq
	QKpGy3xBTvtEnS56AKlKVjefQUA1ArOB++/A8sqUdYFIBSBr8Dilv9vGXb5Aw==
X-Received: by 2002:a05:6512:334b:b0:5b0:12cf:ae10 with SMTP id
 2adb3069b0e04-5b02369d686mr6128237e87.34.1784215268334; Thu, 16 Jul 2026
 08:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1780710041.git.tim.orling@konsulko.com> <cover.1783371914.git.tim.orling@konsulko.com>
 <33fd6cf552070e50949e104771ed72746ff5921b.1783371914.git.tim.orling@konsulko.com>
 <e645c8e9df3e28a87b9daa07f220f023ee6287ca.camel@pbarker.dev>
In-Reply-To: <e645c8e9df3e28a87b9daa07f220f023ee6287ca.camel@pbarker.dev>
From: Tim Orling <ticotimo@gmail.com>
Date: Thu, 16 Jul 2026 08:20:55 -0700
X-Gm-Features: AUfX_mzzOjRuWgEypjQ5BtPgmiXAQ-EAIdBFTqhLQel64N_23yri1ZcZA5-c3nY
Message-ID: <CANx9H-Aj+Hib9vcB8=c0hg6F7SQL1ACXktV+FqAy0chs6i3-ZA@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH v4 03/11]
 scripts: add run-vcontainer-tests for meta-virtualization
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000459f8c0656bbfd11"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 15:21:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4495

--000000000000459f8c0656bbfd11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 12:09=E2=80=AFPM Paul Barker via lists.yoctoproject=
.org
<paul=3Dpbarker.dev@lists.yoctoproject.org> wrote:

> On Mon, 2026-07-06 at 15:05 -0700, Tim Orling via lists.yoctoproject.org
> wrote:
> > Add scripts/run-vcontainer-tests, the test runner used by the
> > vcontainers-test job. It sources the vcontainer-tarball SDK,
> > discovers the meta-virtualization pytest suite, and runs a
> > configurable set of suites (vdkr, vpdmn, memres) against the
> > checked-out layers. Suites can be selected per-step so the
> > top-level 'vcontainer-tests' job runs the container engine
> > agnostic tests:
> >
> > - tests/test_container_cross_install.py
> > - tests/test_container_registry_script.py
> > - tests/test_vcontainer_auth_config.py
> > - tests/test_multiarch_oci.py
> > - tests/test_multilayer_oci.py
> >
> > The 'vdkr-tests' and 'vpdmn-tests' jobs run only their respective
> > suites (including memres for each container engine):
> >
> > - tests/test_vdkr.py
> > - tests/test_vdkr_registry.py
> >
> > and
> >
> > - tests/test_vpdmn.py
> >
> > The purpose of this script is to test the just built vcontainer-tarball=
,
> > so that it can be considered "known-good" and be published for use by
> > container building jobs that need the vcontainer-tarball installed.
> >
> > AI-Generated: Claude Cowork Opus 4.7
> > Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> > ---
> >  config.json                  |  31 +++++
> >  scripts/run-vcontainer-tests | 212 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 243 insertions(+)
> >  create mode 100755 scripts/run-vcontainer-tests
> >
> > diff --git a/config.json b/config.json
> > index 972682d..ae13c5b 100644
>
<snip>

> >      },
>
> Hi Tim,
>
> Would it make sense to merge the vcontainer-tests steps in to the
> vcontainer-tarball job defined in patch 2 of this series? Essentially,
> build the tarball (step 1), test it (steps 2-4, merged from this patch),
> then publish it (step 5) only if it has passed the tests.
>

I contemplated that, but the tests were not passing [1][2][3] and I felt
it was out of scope for me to try to fix them now. If we can work with
Bruce to get the test cases to be more stable, this is a good idea for
the future.

In the earlier stages of this work, I relied on vcontainer-tarball
extensively since all containers were single-arch and pushing used
vdkr/vpdmn. Currently, on the AB, the use of the vcontainer-tarball is
for pushing single-arch containers (which is limited to the alpine
container ATM). When I figure out how to do run-time container
testing on the AB, that would be a second use case.

I was also not entirely sure how frequently we need/want to rebuild
the vcontainer-tarball (e.g. buildtools tarballs are not not published
frequently).

[1] https://autobuilder.yoctoproject.org/valkyrie/#/builders/118/builds/3
[2] https://autobuilder.yoctoproject.org/valkyrie/#/builders/118/builds/4
[3] https://autobuilder.yoctoproject.org/valkyrie/#/builders/118/builds/5


> Best regards,
>
> --
> Paul Barker
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4481):
> https://lists.yoctoproject.org/g/yocto-patches/message/4481
> Mute This Topic: https://lists.yoctoproject.org/mt/120148311/924729
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/1023=
951714/xyzzy
> [ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000459f8c0656bbfd11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 15,=
 2026 at 12:09=E2=80=AFPM Paul Barker via <a href=3D"http://lists.yoctoproj=
ect.org">lists.yoctoproject.org</a> &lt;paul=3D<a href=3D"mailto:pbarker.de=
v@lists.yoctoproject.org">pbarker.dev@lists.yoctoproject.org</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, 2026-07=
-06 at 15:05 -0700, Tim Orling via <a href=3D"http://lists.yoctoproject.org=
" rel=3D"noreferrer" target=3D"_blank">lists.yoctoproject.org</a><br>
wrote:<br>
&gt; Add scripts/run-vcontainer-tests, the test runner used by the<br>
&gt; vcontainers-test job. It sources the vcontainer-tarball SDK,<br>
&gt; discovers the meta-virtualization pytest suite, and runs a<br>
&gt; configurable set of suites (vdkr, vpdmn, memres) against the<br>
&gt; checked-out layers. Suites can be selected per-step so the<br>
&gt; top-level &#39;vcontainer-tests&#39; job runs the container engine<br>
&gt; agnostic tests:<br>
&gt; <br>
&gt; - tests/test_container_cross_install.py<br>
&gt; - tests/test_container_registry_script.py<br>
&gt; - tests/test_vcontainer_auth_config.py<br>
&gt; - tests/test_multiarch_oci.py<br>
&gt; - tests/test_multilayer_oci.py<br>
&gt; <br>
&gt; The &#39;vdkr-tests&#39; and &#39;vpdmn-tests&#39; jobs run only their=
 respective<br>
&gt; suites (including memres for each container engine):<br>
&gt; <br>
&gt; - tests/test_vdkr.py<br>
&gt; - tests/test_vdkr_registry.py<br>
&gt; <br>
&gt; and<br>
&gt; <br>
&gt; - tests/test_vpdmn.py<br>
&gt; <br>
&gt; The purpose of this script is to test the just built vcontainer-tarbal=
l,<br>
&gt; so that it can be considered &quot;known-good&quot; and be published f=
or use by<br>
&gt; container building jobs that need the vcontainer-tarball installed.<br=
>
&gt; <br>
&gt; AI-Generated: Claude Cowork Opus 4.7<br>
&gt; Signed-off-by: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.co=
m" target=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 config.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 31 +++++<br>
&gt;=C2=A0 scripts/run-vcontainer-tests | 212 +++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 2 files changed, 243 insertions(+)<br>
&gt;=C2=A0 create mode 100755 scripts/run-vcontainer-tests<br>
&gt; <br>
&gt; diff --git a/config.json b/config.json<br>
&gt; index 972682d..ae13c5b 100644<br></blockquote><div>&lt;snip&gt;=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
<br>
Hi Tim,<br>
<br>
Would it make sense to merge the vcontainer-tests steps in to the<br>
vcontainer-tarball job defined in patch 2 of this series? Essentially,<br>
build the tarball (step 1), test it (steps 2-4, merged from this patch),<br=
>
then publish it (step 5) only if it has passed the tests.<br></blockquote><=
div><br></div><div>I contemplated that, but the tests were not passing [1][=
2][3] and I felt</div><div>it=C2=A0<span style=3D"background-color:transpar=
ent">was out=C2=A0</span><span style=3D"background-color:transparent">of sc=
ope for me to try to fix them now. If we can work with</span></div><div><sp=
an style=3D"background-color:transparent">Bruce to get=C2=A0</span><span st=
yle=3D"background-color:transparent">the test cases to be more stable, this=
 is a good idea for</span></div><div><span style=3D"background-color:transp=
arent">the future.</span></div><div><br></div><div>In the earlier stages of=
 this work, I relied on vcontainer-tarball</div><div>extensively=C2=A0<span=
 style=3D"background-color:transparent">since all containers were single-ar=
ch and pushing used</span></div><div><span style=3D"background-color:transp=
arent">vdkr/vpdmn.=C2=A0</span><span style=3D"background-color:transparent"=
>Currently, on the AB, the use of the </span>vcontainer-tarball<span style=
=3D"background-color:transparent">=C2=A0is</span></div><div><span style=3D"=
background-color:transparent">for pushing=C2=A0</span><span style=3D"backgr=
ound-color:transparent">single-arch containers (which is limited to the alp=
ine</span></div><div><span style=3D"background-color:transparent">container=
 ATM).=C2=A0</span><span style=3D"background-color:transparent">When I figu=
re out how to do run-time container</span></div><div><span style=3D"backgro=
und-color:transparent">testing=C2=A0</span><span style=3D"background-color:=
transparent">on the AB, that=C2=A0</span><span style=3D"background-color:tr=
ansparent">would be a second use case.</span></div><div><br></div><div>I wa=
s also not entirely sure how frequently we need/want to rebuild</div><div>t=
he vcontainer-tarball<span style=3D"background-color:transparent">=C2=A0(e.=
g. buildtools tarballs are not not published</span></div><div><span style=
=3D"background-color:transparent">frequently).</span></div><div><br>[1]=C2=
=A0<a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/builders/118/=
builds/3">https://autobuilder.yoctoproject.org/valkyrie/#/builders/118/buil=
ds/3</a></div><div>[2]=C2=A0<a href=3D"https://autobuilder.yoctoproject.org=
/valkyrie/#/builders/118/builds/4">https://autobuilder.yoctoproject.org/val=
kyrie/#/builders/118/builds/4</a></div><div>[3]=C2=A0<a href=3D"https://aut=
obuilder.yoctoproject.org/valkyrie/#/builders/118/builds/5">https://autobui=
lder.yoctoproject.org/valkyrie/#/builders/118/builds/5</a></div><div><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
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
View/Reply Online (#4481): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/4481" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/4481</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/120148311/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/120148311/924729</a><br>
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

--000000000000459f8c0656bbfd11--

