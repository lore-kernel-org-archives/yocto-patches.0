Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDA5CD8C89
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 03:08:58 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9619.1780715335354289115
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 20:08:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=kGfpxzF0;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: ticotimo@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa68d9d4a3so2732669e87.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 20:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780715333; cv=none;
        d=google.com; s=arc-20240605;
        b=Ou+aZtIYn7a6aEZ8usdnOAd9HNuk4nC/VLQAGTzqSAhGC36DGmFUbvomZNO6PKKUor
         CG2PTTRl1WSoxkgdhY/SDplxL/ev+VVFkQhB1qr8jHlvW7YBClhlTuoazyPNeA+R2bey
         i1sqrbd/YewnrwtCPfUgnMUgVTXTg4jNU5wGavSem46Vg+Tgn/L5LWn+ZZtsZ9wgnQPx
         0+73zE78TbGTtu2amf8MOQ8/K5kDsErLPGzybiXL2c3x4B2noydgqWMG7vRXex9ZQ7CQ
         pgi1ocEjA/q+kO5VI+EoikyXDV71MT8ZZSmeJcYeujCnfWZ22e0cYiDIsEm6ZYjXwzQ0
         fA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=DL25TBFb448tr7JAlq398PF8Weotkd4TXCXH9FnQH8E=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=a3Qeb1Dzsmg95jjj/fYIF82ofWBbxX37Qyvi3ez+oC/F2K1MIVUIwHkFQU3fIQpebx
         Rx67FCbH0RX2uHHzEalJaug2xEteJoaTje/sUZVz7z+qcyZLNHhL67ri1PF6laktkEbL
         ELX/Nb74flNQtUUdU1REAYJv9U5iYH9CVNfuyCLslwz5HhBiSjTKd17QH8L6uu+V1SMW
         76VvT+51f5GV3nxwzTQPmSCrUS2e9tEg3h8MW5xVPXRFEBU/IYdICBXJWSw1jMdSO/1l
         +qHeXmEzMryQSop9XOVy/Ksjmo7gtxFfmKCRIWGy7c6kL16QAbz7Lhlyu4KaTwHw3PVE
         PgHg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780715333; x=1781320133; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DL25TBFb448tr7JAlq398PF8Weotkd4TXCXH9FnQH8E=;
        b=kGfpxzF089kQQBEyEl8nXVaWXVsHv+HqGWW/YQyH6AKxP32LrEqyMbUtEl4MaW47wn
         RkmM5gsAcZVcRfLh8qcytfkgh6+0CBzefdLHLuCs+B9JGk4Mwj/V9PGqiyBfAhcOGoh5
         WldJR4czsxMrZrL/PJch7teBWHgqR/BdQd4pVQw0cFFuOA5BUQT2526XAqDW+8ERqYv3
         lmpzH1JvLYMvWW4I7Kq6eLNMPgc7KlSvCmAG4swQ/HP6q4xiQ5kwInEecxL3ueC7trOs
         ujCssM48hHlpNH4T6TFTintxbUE1EQ64jzr6tehQJ8awQvhuMJyI98pbuCGRbZO5ryGc
         m9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780715333; x=1781320133;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DL25TBFb448tr7JAlq398PF8Weotkd4TXCXH9FnQH8E=;
        b=jNuhJkdsLSzUp9IPzfPTQo7/JAxBP9NW9RVSDeKds47EdS+ksXePiIubYHB89M3AnX
         MgaNmAy3bxC+MywycmjmFCktNon76kAEWL7poHb4OtJqv7ZWPP1JehAhUTlsn3InOO4O
         VfdzQ4FlFzRR7k4FqCyjUPNZ3Jsh1l3yfXN7khAdtbTebR14Bg3svAaPrUOso66foMR8
         ClN5huk/frHu1V6+PkF/wM0xLNck5LSfDblIH+DJuabnJc9pav+WlDLk7KpDGrop5WBc
         kQYyYWCEbkd+57YMdnGbwia7cw/nW2oWuti6C5GpPqfpH2QGALpX9EGzTE8Dg0rY0X3B
         Uu1g==
X-Gm-Message-State: AOJu0Yyj+bvGJHmHfzX4wDqldNv4HMbqAvdPHaVG3lsSF8H39Cax0XpT
	a1PWi3HtOXfzO3K1ph4nEpRTA+7Bgcoyirt1Aq97kM0fYzyboOeYZJE1JNUDK67pA6JIDWUVk+n
	bNQpyGqHG+HqgcjyXN7VAjteu+wFDrH18uA==
X-Gm-Gg: Acq92OGjDsCvYTbheQD2/E7gTBj4mXpEQjwfOMClF9yKZq2IiW8eMjacxFJBZYjkTER
	6pD199EWMG6MckZbzhM8kpkvr6H5OfyqDh5XyL6a4T4HvDfZX4uy7ZXXNooCVjnKjoxYEMHTGZO
	nnptXFrre+BKgr+4qhGWrkKRVObnUTEi1iHKMCyH/6YvhpJFJ4ITdbi1TnNgzGRLuXzl3PwcciH
	Qu53rdkUkhv+fmXgkahAz+qE9fXwtARE7GhU1W3pXHe9rwl3djeYo6/q224VQ1fxyVi6Qb+Jrdy
	mrOHlQrkmq1zasZ1Og==
X-Received: by 2002:a05:6512:a90:b0:5aa:8823:e310 with SMTP id
 2adb3069b0e04-5aa8823e36amr1442269e87.46.1780715333168; Fri, 05 Jun 2026
 20:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1780354513.git.tim.orling@konsulko.com> <2cf468a3da7c7db15ee42c14404a71aaacab0f28.1780354513.git.tim.orling@konsulko.com>
 <83eab955b09ab5c2bc61fd2a7c0c229f1aea6fd9.camel@linuxfoundation.org>
In-Reply-To: <83eab955b09ab5c2bc61fd2a7c0c229f1aea6fd9.camel@linuxfoundation.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 5 Jun 2026 20:08:39 -0700
X-Gm-Features: AVVi8CdeFZURZ-daIWw8Hy7p_xOg34I4GSi_Vh-YcFMT3ALR3kkZ_SerXwHBwBQ
Message-ID: <CANx9H-ABidb1bc1pNX50nHvkMPja2CEUcEUKaszhUP9F0f0YTw@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH v2 05/10]
 scripts: add vcontainer-tarball setup, integration, and publishing
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000e1324706538d187d"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 03:08:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4163

--000000000000e1324706538d187d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 9:26=E2=80=AFAM Richard Purdie via lists.yoctoprojec=
t.org
<richard.purdie=3Dlinuxfoundation.org@lists.yoctoproject.org> wrote:

> On Mon, 2026-06-01 at 16:18 -0700, Tim Orling via lists.yoctoproject.org
> wrote:
> > From: Tim Orling <tim.orling@konsulko.com>
> >
> > Introduce the vcontainer-tarball SDK plumbing used by container build
> > jobs. The vcontainer-tarball is a meta-virtualization-derived SDK
> > (modelled after buildtools-tarball) that ships the container build
> > toolchain so worker jobs do not need to rebuild it for every step.
> >
> >   * scripts/utils.py: add setup_vcontainer_tarball(), and add an
> >     env_glob keyword argument to setup_tools_tarball() and
> >     enable_tools_tarball() so the vcontainer-tarball can source its
> >     specific environment-setup-ci file rather than the universal
> >     glob.
> >   * scripts/run-config: source the vcontainer-tarball environment
> >     for build-targets / cmds / test-targets / plain-cmds steps,
> >     gated by a new NOVCONTAINER step variable so individual steps
> >     (such as the dashboard indexing step) can opt out independently
> >     of NOBUILDTOOLS.
> >   * scripts/shared-repo-unpack: invoke setup_vcontainer_tarball so
> >     workers extract the SDK during unpack.
> >   * scripts/publish-artefacts: publish the vcontainer-tarball
> >     artefact so downstream test jobs can fetch a stable SDK.
> >
> > AI-Generated: Claude Cowork Opus 4.7
> > Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> > ---
> >  config.json                |  1 +
> >  scripts/publish-artefacts  |  5 +++++
> >  scripts/run-config         | 19 +++++++++++++++++++
> >  scripts/shared-repo-unpack |  1 +
> >  scripts/utils.py           | 22 ++++++++++++++++++----
> >  5 files changed, 44 insertions(+), 4 deletions(-)
> >
> > diff --git a/config.json b/config.json
> > index 7df4271..16d8a04 100644
> > --- a/config.json
> > +++ b/config.json
> > @@ -1433,6 +1433,7 @@
> >              "step3" : {
> >                  "shortname" : "Populate/update dashboard site",
> >                  "NOBUILDTOOLS" : true,
> > +                "NOVCONTAINER" : true,
> >                  "EXTRACMDS" : ["${SCRIPTSDIR}/run-dashboard-index
> ${HELPERBUILDDIR}/../"]
> >              }
> >          },
>
> Why is this step needing to opt out of a vcontainer? vcontainers are
> only enabled for specific steps and off by default?
>
> I looked further and realised you're basically using a vcontainer
> everywhere as far as I can tell? Why do we want to have the overhead of
> doing that outside of the vcontainer builds?
>
> For buildtools, it makes sense we need it everywhere except where we
> configure otherwise but I think for vcontainer, you want to opposite,
> you only use it in jobs where we actually need/use it?
>
>
The simple answer is that the 'buildtools' pattern was followed and an
attempt
was made to reuse the 'buildtools' code as much as possible. Upon further
review, the 'extratools' pattern is a better fit. This was addressed in v3.

Cheers,
>
> Richard
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4153):
> https://lists.yoctoproject.org/g/yocto-patches/message/4153
> Mute This Topic: https://lists.yoctoproject.org/mt/119603244/924729
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/1023=
951714/xyzzy
> [ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000e1324706538d187d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 5, =
2026 at 9:26=E2=80=AFAM Richard Purdie via <a href=3D"http://lists.yoctopro=
ject.org">lists.yoctoproject.org</a> &lt;richard.purdie=3D<a href=3D"mailto=
:linuxfoundation.org@lists.yoctoproject.org">linuxfoundation.org@lists.yoct=
oproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On Mon, 2026-06-01 at 16:18 -0700, Tim Orling via <a href=3D"ht=
tp://lists.yoctoproject.org" rel=3D"noreferrer" target=3D"_blank">lists.yoc=
toproject.org</a> wrote:<br>
&gt; From: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.com" target=
=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; <br>
&gt; Introduce the vcontainer-tarball SDK plumbing used by container build<=
br>
&gt; jobs. The vcontainer-tarball is a meta-virtualization-derived SDK<br>
&gt; (modelled after buildtools-tarball) that ships the container build<br>
&gt; toolchain so worker jobs do not need to rebuild it for every step.<br>
&gt; <br>
&gt; =C2=A0 * scripts/utils.py: add setup_vcontainer_tarball(), and add an<=
br>
&gt; =C2=A0=C2=A0=C2=A0 env_glob keyword argument to setup_tools_tarball() =
and<br>
&gt; =C2=A0=C2=A0=C2=A0 enable_tools_tarball() so the vcontainer-tarball ca=
n source its<br>
&gt; =C2=A0=C2=A0=C2=A0 specific environment-setup-ci file rather than the =
universal<br>
&gt; =C2=A0=C2=A0=C2=A0 glob.<br>
&gt; =C2=A0 * scripts/run-config: source the vcontainer-tarball environment=
<br>
&gt; =C2=A0=C2=A0=C2=A0 for build-targets / cmds / test-targets / plain-cmd=
s steps,<br>
&gt; =C2=A0=C2=A0=C2=A0 gated by a new NOVCONTAINER step variable so indivi=
dual steps<br>
&gt; =C2=A0=C2=A0=C2=A0 (such as the dashboard indexing step) can opt out i=
ndependently<br>
&gt; =C2=A0=C2=A0=C2=A0 of NOBUILDTOOLS.<br>
&gt; =C2=A0 * scripts/shared-repo-unpack: invoke setup_vcontainer_tarball s=
o<br>
&gt; =C2=A0=C2=A0=C2=A0 workers extract the SDK during unpack.<br>
&gt; =C2=A0 * scripts/publish-artefacts: publish the vcontainer-tarball<br>
&gt; =C2=A0=C2=A0=C2=A0 artefact so downstream test jobs can fetch a stable=
 SDK.<br>
&gt; <br>
&gt; AI-Generated: Claude Cowork Opus 4.7<br>
&gt; Signed-off-by: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.co=
m" target=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0config.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +<br>
&gt; =C2=A0scripts/publish-artefacts=C2=A0 |=C2=A0 5 +++++<br>
&gt; =C2=A0scripts/run-config=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 19 +++++++++++++++++++<br>
&gt; =C2=A0scripts/shared-repo-unpack |=C2=A0 1 +<br>
&gt; =C2=A0scripts/utils.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 22 ++++++++++++++++++----<br>
&gt; =C2=A05 files changed, 44 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/config.json b/config.json<br>
&gt; index 7df4271..16d8a04 100644<br>
&gt; --- a/config.json<br>
&gt; +++ b/config.json<br>
&gt; @@ -1433,6 +1433,7 @@<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &quot;step3&quot; : {<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;shortname&quot; : &quot;Populate/update d=
ashboard site&quot;,<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;NOBUILDTOOLS&quot; : true,<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &quot;NOVCONTAINER&quot; : true,<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;EXTRACMDS&quot; : [&quot;${SCRIPTSDIR}/ru=
n-dashboard-index ${HELPERBUILDDIR}/../&quot;]<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },<br>
<br>
Why is this step needing to opt out of a vcontainer? vcontainers are<br>
only enabled for specific steps and off by default?<br>
<br>
I looked further and realised you&#39;re basically using a vcontainer<br>
everywhere as far as I can tell? Why do we want to have the overhead of<br>
doing that outside of the vcontainer builds?<br>
<br>
For buildtools, it makes sense we need it everywhere except where we<br>
configure otherwise but I think for vcontainer, you want to opposite,<br>
you only use it in jobs where we actually need/use it?<br>
<br></blockquote><div><br></div><div>The simple answer is that the &#39;bui=
ldtools&#39; pattern was followed and an attempt</div><div>was made=C2=A0to=
 reuse the &#39;buildtools&#39; code as much as possible. Upon further</div=
><div>review, the &#39;extratools&#39; pattern is a better fit. This was ad=
dressed in v3.</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
Cheers,<br>
<br>
Richard<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#4153): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/4153" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/4153</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/119603244/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/119603244/924729</a><br>
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

--000000000000e1324706538d187d--

