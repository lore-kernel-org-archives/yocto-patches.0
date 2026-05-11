Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9894BCD484C
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 17:36:43 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.56498.1778520995623837434
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 May 2026 10:36:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HAXkosXZ;
 spf=pass (domain: konsulko.com, ip: 209.85.128.169, mailfrom: tim.orling@konsulko.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bde9d73678so48929647b3.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 11 May 2026 10:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778520995; cv=none;
        d=google.com; s=arc-20240605;
        b=gqcVbuEETREbs9yN6FbgPdBIk/YZHRajL3jGOpf1g2QAGnYfjPvmgUTkBPDAP7lIbn
         23b1tc7033cIXRMSIoBmjJwALI7eFVYL7bctq9FCaSqz/O0k7ioygch+zalp1uQqlg4a
         ILZLKganssequlDCE/xtiaQ5nc3mLDeuBwcGr4CKsADZYxYDBaEJNW/AqG0mqasSFIJf
         gIt63hT5DXQvFs//rkz7pTdduLneJPpobDrT7KN2a7eSlEqeYw0ch9ut8NvlmoWhgtWR
         3vW8TmDNJSB+DGtc4BhXegnhiViqPxZOoHv2YRTOm2fjWpxcFaEDUo0FVOjQSQ7bT7Vo
         ipvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=p+aXM3wUy2VlufaonbLEjbWnU2PAkqFPpNj7/qxHjtA=;
        fh=1xQzWt/W4EAmz/F47cA+kLIU/CAhbmRrVZxZ7KbnavU=;
        b=FDdGDI2Riy2z6qh2Hs9SA5FK8uFPf6vq4K9bQnJo4iC3ubqad3NOOFa1CaYF6T+r7v
         RwUZ24vzzGfdGv+4zHfFNRhI7kTfnAFCbMEypcVH1ixrSMlKFMdcTqYENY5NR2EqpqKE
         f91HxEKgXO5HT/nc8hQHUdFN2m0/3No9i8waBMADjkTh8dagx3tHJ2mWTs28q4RQMCxL
         l61ekGnqDbZfN8NeoXXOhVucz9MHwkERPNYEyqna0dyWLFXPwsAd11mPrMDk2nrnWWOI
         Bruy7SobGVYPJVFGRtR2lix5cF80OPn+eenERVy5l9H58GuvAKKUugBd2EQp7bzuLifx
         f9OA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778520995; x=1779125795; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p+aXM3wUy2VlufaonbLEjbWnU2PAkqFPpNj7/qxHjtA=;
        b=HAXkosXZ1joUpa55013Tzq3Sc3F3Q716coPGRCAj7D3my1Tru6e6EMibVuusy+X0xi
         2KIbbYoZ8UGJzQtmBNOi7BngJiZ8xtlyUX52mfQXocsMBhYBEj43H8uE8nLmva3F+hnl
         xjUiNbrtLlgfg4hfCf0mdjqwMoxOBM9/wh2cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778520995; x=1779125795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+aXM3wUy2VlufaonbLEjbWnU2PAkqFPpNj7/qxHjtA=;
        b=XobQ09cgo+ltjOyrKpwl2hC8Bpb/bwSfzQwUmyHj7Lfdn5qDIt1pWKsu7lpLIGYIcU
         Ty+Ikq2PVEYjshpvZvugk69VU/XaTVnjv2kx6gYWM9pRj5wDCBTVeI6p2fyxrSa9fJoe
         Ki5zCD62SUPYati1sgMstr8ZZjHRAHeJ7HWvUbitLM7CJqMjDU59cC48tDW3uODHsRo2
         /BAqImrBcYuwNUI86BX2yO+HRII43+8QhbdULtNZSRPUi/K1qirVQEbr2Fwci7UPBpin
         Hq42KLweOXo9+T9t3whjykD5gNDGr3qBJBiuzf9oVwrcZDW/ikzQy5dJjmij6pTj+1/1
         hA6w==
X-Gm-Message-State: AOJu0YzwZJHG/yuKwrWNuqZHSoyG9Cnhy2FqvUize8kZtqeTWWFnlFyx
	V4kF+7n0p/7d/LKrO274dO0nJUh6hNtj+LrDC3jGdebjnNCwe3OyKmK10qUC8cix2hjkkQdMrrh
	bkmcAmach3KisBCx8h/aD2JsYJPPTphjtVo0bgVXZ97PHnE4JHyWQ
X-Gm-Gg: Acq92OFZi7iKpdVERiaw9O6sUAAWrlU7Bz8e2yAnAMilYUQo0kP+61hxE6l7HtpkSJ2
	uXKZ+909e1zZVw/PWBo22XJggkC/snrXlMkVaUCCRDiI1Fm8bk++Lh3Vdj+CY3KBJp88OrHL9JQ
	I7ufIP0fwkvYaNTqnRcdK4yUvDtF5rEx4SCSMryez+sO4THgnNX6Z5H6VdtC9UZPB8FoMWm0G0E
	jI0PNerkLMeeqz6vCjUdJUHjjrUzKmz3mJxHdzIKLx1Isl8/zniI0rheriftN1/PdKo2gPlymeg
	Lu8ab6uV4HlaiiPsNw==
X-Received: by 2002:a05:690c:3:b0:7b2:bf20:cdc9 with SMTP id
 00721157ae682-7c50e421dd6mr5143977b3.7.1778520994535; Mon, 11 May 2026
 10:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778202125.git.tim.orling@konsulko.com> <1c444ecb2272a384e77a786f7ca32767f791ce34.1778202125.git.tim.orling@konsulko.com>
 <dcfc99d7b81e1083ef3607adde6055f4a81d3534.camel@pbarker.dev>
In-Reply-To: <dcfc99d7b81e1083ef3607adde6055f4a81d3534.camel@pbarker.dev>
From: Tim Orling <tim.orling@konsulko.com>
Date: Mon, 11 May 2026 10:36:23 -0700
X-Gm-Features: AVHnY4Ixdb0_j5INGt40jZ_HnpQa79pnh908KOL3MQ7O_LUYruEmTam9ijDt3OU
Message-ID: <CAOyo-86bcAxxBy8bDi+dJmqnxUqbGaYhr-OXuAob0pvk9N-T4Q@mail.gmail.com>
Subject: Re: [yocto-autobuilder-helper][PATCH 07/11] config.json: add
 'containers-' build jobs
To: Paul Barker <paul@pbarker.dev>
Cc: yocto-patches@lists.yoctoproject.org, yocto@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000001aeacc06518e30d5"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 May 2026 17:36:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3968

--0000000000001aeacc06518e30d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 1:52=E2=80=AFAM Paul Barker <paul@pbarker.dev> wrot=
e:

> On Thu, 2026-05-07 at 18:25 -0700, tim.orling@konsulko.com wrote:
> > From: Tim Orling <tim.orling@konsulko.com>
> >
> > Add 'containers-' build jobs that build container images on top
> > of the vcontainer-tarball SDK:
> >
> >   * containers-meta-virt: the original app-container-* images that
> >     ship in meta-virtualization itself (e.g. app-container-curl).
> >   * containers-library: a layer for additional images modelled
> >     after docker.io/library/*, sourced from meta-yocto-containers-demo
>
> I think we should combine these into one build job.
>

For now, that is impractical unless we use a branch of meta-virt that I can
control (because the container recipes are in flux). Or I would have to
continue running builds with a custom yocto-autobuilder-helper and a custom
meta-virt branch which defeats the purpose of pushing the containers to the
official registry.yocto.io and quay.io/yocto.

Let me put it another way: the container recipes in meta-virt are a simpler
demonstration. The container recipes in meta-yocto-containers-demo are
heading towards being fully signed/attested and hardened. So to me it made
sense to keep the jobs separate.


>
> What's the plan for meta-yocto-containers-demo? Should we host that on
> git.yoctoproject.org, or will the contents eventually be merged into
> meta-virtualization?
>

I haven't discussed this with Bruce, but I think it makes sense to have the
official list in meta-virtualization, when they are ready. The other main
reason for the meta-yocto-container-demo layer is for things like the
slsa-provenance.bbclass before submitting that to oe-core.


> Best regards,
>
> --
> Paul Barker
>
>

--0000000000001aeacc06518e30d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 11,=
 2026 at 1:52=E2=80=AFAM Paul Barker &lt;<a href=3D"mailto:paul@pbarker.dev=
">paul@pbarker.dev</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On Thu, 2026-05-07 at 18:25 -0700, <a href=3D"mailto:tim.=
orling@konsulko.com" target=3D"_blank">tim.orling@konsulko.com</a> wrote:<b=
r>
&gt; From: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.com" target=
=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; <br>
&gt; Add &#39;containers-&#39; build jobs that build container images on to=
p<br>
&gt; of the vcontainer-tarball SDK:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* containers-meta-virt: the original app-container-* image=
s that<br>
&gt;=C2=A0 =C2=A0 =C2=A0ship in meta-virtualization itself (e.g. app-contai=
ner-curl).<br>
&gt;=C2=A0 =C2=A0* containers-library: a layer for additional images modell=
ed<br>
&gt;=C2=A0 =C2=A0 =C2=A0after <a href=3D"http://docker.io/library/*" rel=3D=
"noreferrer" target=3D"_blank">docker.io/library/*</a>, sourced from meta-y=
octo-containers-demo<br>
<br>
I think we should combine these into one build job.<br></blockquote><div><b=
r></div><div>For now, that is impractical unless we use a branch of meta-vi=
rt that I can control (because the container recipes are in flux). Or I wou=
ld have to continue running builds with a custom yocto-autobuilder-helper a=
nd a custom meta-virt branch which defeats the purpose of pushing the conta=
iners to the official <a href=3D"http://registry.yocto.io">registry.yocto.i=
o</a> and <a href=3D"http://quay.io/yocto">quay.io/yocto</a>.</div><div><br=
></div><div>Let me put it another way: the container recipes in meta-virt a=
re a simpler demonstration. The container recipes in meta-yocto-containers-=
demo are heading towards being fully signed/attested and hardened. So to me=
 it made sense to keep the jobs separate.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
What&#39;s the plan for meta-yocto-containers-demo? Should we host that on<=
br>
<a href=3D"http://git.yoctoproject.org" rel=3D"noreferrer" target=3D"_blank=
">git.yoctoproject.org</a>, or will the contents eventually be merged into<=
br>
meta-virtualization?<br></blockquote><div><br></div><div>I haven&#39;t disc=
ussed this with Bruce, but I think it makes sense to have the official list=
 in meta-virtualization, when they are ready. The other main reason for the=
 meta-yocto-container-demo layer is for things like the slsa-provenance.bbc=
lass before submitting that to oe-core.</div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
Best regards,<br>
<br>
-- <br>
Paul Barker<br>
<br>
</blockquote></div></div>

--0000000000001aeacc06518e30d5--

