Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4644CD8C88
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 03:11:18 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9778.1780715471077492212
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 20:11:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=B8SMjCpp;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: ticotimo@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa68cf9123so2643809e87.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 20:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780715469; cv=none;
        d=google.com; s=arc-20240605;
        b=Ih9GQ7UkyLsIxU4eGREMwdnF/7P7kUdv/8qupao5rExHVfjoDsypP/rvT/e3QB5t3c
         12OUe64fYk9uuXaHRnAlTYqAN0qrp/pw2OmvwJEtfVOVoiZzbvLpWj7OBUWm51NlRbjT
         r358RS/DxAxlZtYuZDNQX6HI4kZ0AYSDMoZ3iIgICL51ml9zWJtGAUZgUOKJU4+2ypRt
         xyg59fmxVRUsxPjwAzi0iPEED/XPCfkQCLBTUmtpQZNrRSGzmQts409BNSYoU7y2/4tW
         iaFaFK5TI3SUfp95TVmNzu1cuW7oXS7SmH+q4PDvxw0K/5QtTnvS48Dr5WdgtqYXbVHI
         d6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=uXBe2SitcediaYfICSK5p9rc6RwtC7LkbIrOWdcUoxw=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=DYGEd2RcgRo9YAjGO0SjCHbgR/A1+GM0xEaOzIccoXJoWch6z6H3sAFWH7WaQPtwZs
         rjF/YG1ZzyX20XQXsr24kPJPu1679tYKwXO5PoZ/1WnVQmspQwa+mmphQtq64roObfg9
         RUdB3Gnj6C+d3knhD4ra+8kUuh5D1boC0OXAgtyb7aWCIdPtXBvRlI7KVt1Wp7ianYkG
         x177Xb2FWiEkEpigZogqkRhgCuwtkMsgA4sREQngEaU6WEauCx3mKaLLpXw5C4IwTYyl
         NKsDPQwnklBTIDHvekipP6QZ7HTZbiU0AS7G0//PA/gzYFNdtYRA50FjSlGHN1kMqG+G
         FbRw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780715469; x=1781320269; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXBe2SitcediaYfICSK5p9rc6RwtC7LkbIrOWdcUoxw=;
        b=B8SMjCppT4irI49SokrfEPAFkyKEjWXsjnWM5VKhV8gOR2RRHxqhMiJeAMbEo9C3Dw
         GMNfP5/tDaxTpb5axCqTl2FLe03mO/hw7+MgI+PmissK2H8RsJCn8RrWnjZJL2gn0j90
         lbCEe+MpRBJ2jabAj5b44Vim06zC8q3uoVBVPKEI6/6JW9PFx4dAPBEXW66dsBAVrJc6
         ve0fWzxePnqDcx5p7SGgEPK5L4tdjCarZqJmDfpRT97jS7kC2ct722dpuAkuqvH6JxiL
         ucIIyAME70I69/ofMMOIb6T5qepvt+n0/u/ZjrzsLjWUQ8ZVFWUm+wO8TteIGkQhuL/U
         SoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780715469; x=1781320269;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXBe2SitcediaYfICSK5p9rc6RwtC7LkbIrOWdcUoxw=;
        b=siH2RMUm0D4PII9HyDvNO5vUfGIj5T8eciR6nWSjzhMO9MhwyqnS/4JsR9KcqBEQ9k
         y11bGccKFhPhzRD803+TOXY9IaCct0ZwJ0Us79dZaxFuztS5AIsknat178DF4z4+fACo
         qtIfUcNrSbdEw/r1MpbS3QIloHidpzzf8YG/lED525GCMBSgHxCDAO3/nX6sMSb8Xdht
         wnF/L0tUSpF4/l7uwADYV5CMqidE/Ifw390yYOylN5VeR0JtO4Gu7UzDj92NF2i/9QC5
         IfHok75LZwfkCfAYHUJOKYO0ox+iVmhAOXhjtiNy6QjMP/6PrRo/w8rkuznXQCHDXJ55
         hyyw==
X-Gm-Message-State: AOJu0YzOIAM1Oa4eUafkErQoGuyjmN8+erIbdDTlLHUgSUmAui/zlgfH
	UfaGukhYn7Fqf9SdnNl8NDVLqZWZx5wFp8dvph/ym+MsBo4yvK59QrESjxzGMP37hKNvCqutsrt
	L6fUtV8cQUCCRhdS4UKKzmr/OPQ736Pds0A==
X-Gm-Gg: Acq92OE071v24Xn344dKeKIeomMVoNHBErpjf5iUj+9ZvvKbWRMJ+07/OYXQyaaDP8+
	KRACP6LLEHNGlKHgK/kx+EZDIui1bL/L+B3SgQ69LknyyeyuRMZ8Cg4a2dant2iD7USNL6JQ2Eo
	wObnORmvm7ZZz8kgWLWAi3o8AujUYlIVha+rdDjMTwnlfKwAvqRACnIosuVyTfKyhYCuP9pyp5W
	eJ4Mh9Y+8Uln+4x0/02AppVOpqBC4AfHbbnjaeqj/wNJpWRx7qTp9zC3fSFl3dFdUyJIoRZQDnd
	fLxh3bdphtDkaXdfoA==
X-Received: by 2002:a05:6512:2244:b0:5aa:6b6c:ac54 with SMTP id
 2adb3069b0e04-5aa87c4bf2amr1750948e87.42.1780715469017; Fri, 05 Jun 2026
 20:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1780354513.git.tim.orling@konsulko.com> <31f010d5e7dbc1e2307dfb00f06a9b6380a19c5c.1780354513.git.tim.orling@konsulko.com>
 <ca446c8a5f4a9281fcabf9728efc6ee9f9bb6610.camel@linuxfoundation.org>
In-Reply-To: <ca446c8a5f4a9281fcabf9728efc6ee9f9bb6610.camel@linuxfoundation.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 5 Jun 2026 20:10:54 -0700
X-Gm-Features: AVVi8Cd9e3WleZ4_l0q1b02ly1o8Zbn0yc_0pAchxpcCpScY0QJvluBk0G-I020
Message-ID: <CANx9H-BvJRxn1QtOxmPf0Oc6-srscjRT7E1sbRR2KRF-pUHViw@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH v2 08/10]
 scripts: add container registry push, auth, tagging, runtime selection
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000fa167106538d203a"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 03:11:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4164

--000000000000fa167106538d203a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 9:11=E2=80=AFAM Richard Purdie via lists.yoctoprojec=
t.org
<richard.purdie=3Dlinuxfoundation.org@lists.yoctoproject.org> wrote:

> On Mon, 2026-06-01 at 16:18 -0700, Tim Orling via lists.yoctoproject.org
> wrote:
> > From: Tim Orling <tim.orling@konsulko.com>
> >
> > Add the push-containers infrastructure that drives the
> > post-build steps for the 'containers-library' job. After
> > each build step the runtime container store is harvested
> > and pushed to one or more registries with derived per-step
> > tags.
> >
> > * config.json: add CONTAINER_REGISTRIES, CONTAINER_AUTH_CONFIG,
> >   CONTAINER_RUNTIME, CONTAINER_TAG_CMDS, CONTAINER_VERSION_RECIPE
> >   and CONTAINER_IMAGE_MAP configuration knobs.
> > * scripts/run-config: drive push-containers as a post-step
> >   action. Tags are generated from recipe and distro metadata
> >   (yocto- tag uses major.minor on snapshots and full PV on
> >   releases) with CONTAINER_VERSION_RECIPE allowing a step to
> >   source PV from a different recipe than the image itself.
> > * Registry auth is staged via .../config.json or podman
> >   .../auth.json using CONTAINER_AUTH_CONFIG, replacing an
> >   interactive login that could hang. CONTAINER_RUNTIME picks
> >   between vdkr (Docker-compatible) and vpdmn (Podman) runtimes.
> > * Robustness: skip gracefully when no registries are configured,
> >   fix the OCI directory path, handle memres already running,
> >   and avoid hanging when memres has not yet come up.
> >
> > AI-Generated: Claude Cowork Opus 4.7
> > Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> > ---
> >  config.json        |   5 ++
> >  scripts/run-config | 129 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 134 insertions(+)
>
> This is adding way too much code for a specific use case to run-config.
> This needs to be in a separate script (in the same way docs builds or
> other things are).
>
>
Agreed, and I already had the sense that this "wall of text" was too much.
Broken out into a dedicated 'run-pull-containers' script in v3.

Cheers,
>
> Richard
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4152):
> https://lists.yoctoproject.org/g/yocto-patches/message/4152
> Mute This Topic: https://lists.yoctoproject.org/mt/119603248/924729
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/1023=
951714/xyzzy
> [ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000fa167106538d203a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 5, =
2026 at 9:11=E2=80=AFAM Richard Purdie via <a href=3D"http://lists.yoctopro=
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
&gt; Add the push-containers infrastructure that drives the<br>
&gt; post-build steps for the &#39;containers-library&#39; job. After<br>
&gt; each build step the runtime container store is harvested<br>
&gt; and pushed to one or more registries with derived per-step<br>
&gt; tags.<br>
&gt; <br>
&gt; * config.json: add CONTAINER_REGISTRIES, CONTAINER_AUTH_CONFIG,<br>
&gt; =C2=A0 CONTAINER_RUNTIME, CONTAINER_TAG_CMDS, CONTAINER_VERSION_RECIPE=
<br>
&gt; =C2=A0 and CONTAINER_IMAGE_MAP configuration knobs.<br>
&gt; * scripts/run-config: drive push-containers as a post-step<br>
&gt; =C2=A0 action. Tags are generated from recipe and distro metadata<br>
&gt; =C2=A0 (yocto- tag uses major.minor on snapshots and full PV on<br>
&gt; =C2=A0 releases) with CONTAINER_VERSION_RECIPE allowing a step to<br>
&gt; =C2=A0 source PV from a different recipe than the image itself.<br>
&gt; * Registry auth is staged via .../config.json or podman<br>
&gt; =C2=A0 .../auth.json using CONTAINER_AUTH_CONFIG, replacing an<br>
&gt; =C2=A0 interactive login that could hang. CONTAINER_RUNTIME picks<br>
&gt; =C2=A0 between vdkr (Docker-compatible) and vpdmn (Podman) runtimes.<b=
r>
&gt; * Robustness: skip gracefully when no registries are configured,<br>
&gt; =C2=A0 fix the OCI directory path, handle memres already running,<br>
&gt; =C2=A0 and avoid hanging when memres has not yet come up.<br>
&gt; <br>
&gt; AI-Generated: Claude Cowork Opus 4.7<br>
&gt; Signed-off-by: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.co=
m" target=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0config.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 5 ++<br>
&gt; =C2=A0scripts/run-config | 129 +++++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt; =C2=A02 files changed, 134 insertions(+)<br>
<br>
This is adding way too much code for a specific use case to run-config.<br>
This needs to be in a separate script (in the same way docs builds or<br>
other things are).<br>
<br></blockquote><div><br></div><div>Agreed, and I already had the sense th=
at this &quot;wall of text&quot; was too much.</div><div>Broken out into a =
dedicated &#39;run-pull-containers&#39; script in v3.</div><div><br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
Cheers,<br>
<br>
Richard<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#4152): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/4152" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/4152</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/119603248/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/119603248/924729</a><br>
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

--000000000000fa167106538d203a--

