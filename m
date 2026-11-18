Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10277.1795000215592029449
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Nov 2026 03:10:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=bhzKaF9x;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c1f548f87so8234366d6.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 03:10:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795000214; cv=none;
        d=google.com; s=arc-20260327;
        b=Vf+Wv5ReTMl8GcNqQKW6ffUFzkhtl8TYKoaHRGg8i3fhb1yrQ+GVJgguVlt4gwTIJp
         v0R9+I+imNSQHokQ+Kr7gYkIsibySkkZuH4eDjhUCxBLKfcModOYp+L8fXTMguJIXpAc
         3sRk9nU0QCGu800UtBvmEZqNaba/JbRvPuX95FCis5uGwr5GoMeyvQ+1lHLJaqDfgPnC
         hOsDjf8CiESskPselJOW/6j3sqty0YxyHxbhSlF3hYsnF/AzhKhyIZ6Th1tKH+8omFOc
         O5/6RbvXB25oOemyzkvOo2S3gbzqvsfRkZXaKK2WW75rAGTSeVQx46hexTy1Yg3J6f4e
         Jj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0cSejceytLKWbAea+tiN57pHDwwVUYpXZemwzoF0vCo=;
        fh=Sde2SU4bhTvod+aoMm1Wc5zdGcRPzsPQ33vSJKQzWP4=;
        b=RDF4YqXtlQI7hCNc9rKuXIS9FFRwfTXLtQXLx6XpIulJqtlupcx+8eSwk3QpwNhEYx
         i0WKHNzuKTwGPwnFY5Vtc3SAMxUnbGE59q0+WrP4TPUDBDXcYScX5YofBmg8wFM4VP1G
         txyKIN9cI5ibS6E0gm1MCQIQ9aJe5lnWESKOUIw1cSb3LTwNoXlPFhYLklDdjMVvnv8t
         v+6Yn9kMoAPy6fjZeWFHA4RjKuHF0PRdtQDKxmEoN3wVDwwrtaeRPYjdweocAZEPPPSA
         Y0c3M96657oF9AKZZrshDiaSFWYKJ0G5htxnRDOdg6x0sqFseRayQfEpPqF8GCRuf23v
         fboQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795000214; x=1795605014; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0cSejceytLKWbAea+tiN57pHDwwVUYpXZemwzoF0vCo=;
        b=bhzKaF9xnkM0QFVH1sy3YTNa4rZXwSmvxU6YLH6yIGZO6KAtXpqzwMFYn1dYIWU+jk
         Pcya5oN0SCC6CRxTfUj2i9No5yHk0qp2Wcr3VirqiOrF3/RDq6yKy8Dy2JfPhAFHMlzz
         3elsV5wKpFJk7pYFEa82l3Q7TLloyoYA0JutECX2QFDiSwWt6AsTvPbn/3EA9mZpl6h8
         Zy+IM9DYRtigDlQ3QXAZ5jQCQnmt75Wqp5UMKatroON+SvTZ6z5i2JXgqbVY4yOQIEQa
         02AhxALMdb/gDP8Jtxne+TN+TwokGEKBz400B5aop0QYe3PVxMixntZbrjpENBZGCxRs
         mtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000214; x=1795605014;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0cSejceytLKWbAea+tiN57pHDwwVUYpXZemwzoF0vCo=;
        b=gpBVqERnGNMFp2X45obkf5aO1jLwAnwlbSkXhX0r+JZy+v/EGRJRoA0DSthMdB6wEM
         I37CBTBmXplEZKXfv9frqIFKUuygzcZLstrkm4TM3yQTzINrHIE0naij2f+P2PuBJea0
         Ylq7SUPwbhkDeuJ79qoaC9irmE9zSv9LLtfUOnZrYaQPpzuvYPgd3YouVVKU2oUb7k9W
         3ElgMOweOqwUA5N9WbmSd2kNfANqghLtv+8VgHJSoA6XdDspqJmcLRtFHvWykS4t21MS
         11tyDUJsCjXIEj6l7Ye1vxsHOjCQD8UpiV/vSb01/s6m9FYfuwOUna9VbTxT5Mz54UZn
         IcOw==
X-Forwarded-Encrypted: i=1; AL+hErFoGnruRmjpLNuM8obvMLGKJsDJYZO+3i1Qh2eKKhZ4gjdiFGHhhdBPRo13WKS9PDHsFnvwnI7mWC08ibPE@lists.yoctoproject.org
X-Gm-Message-State: APuU4Z83+/SmotOTOowmry9ujAIOdT2tl5mbhAxLq/dscn0uz3sB9sA1
	r3tdVgDMeirivpeWiyWinnJz9BE08bcV9j9WLW/MWmXP53EdFIYsViHQARPixD35awweaVK7VgI
	wY/FRxAmTQ6HxrTrqN98NF/czKwzXb88=
X-Gm-Gg: AZFdTZeyizbnpwEBfiFAKQha2So8TJN2RH5oDFydnDTrk6+eShg/RVV1Oz+u57QcDO6
	sXQJG8heIgdYfBhsP+1Ot0y8RuuIY5tQsP7nu/SnPS7L7D8pdMAX0rqE6z+CcmZAtm0u/13fa96
	tGx5nKpA1YnJ/2lyPfajjarSDEu5RbXMosy8t/cK5lrBmFcxL2Oq54Y2F+pKa36WLnLBK/tRM+Q
	zkZucfb305Z2etEXTG7BL9PAOHcdK27EDvltpDAMxpzWBf98a92rlMqWDpqGQ63vJos72uFLnW/
	p/YcWll0p1r7/EwD59jewYn76CW+pJqDdMIsjr5f6WWO4f85xDseAHT524mRXIGljRBKG+m50W9
	VB+0llHa64CXKYDGYSsQ4pYDDDUP0FpurPGHFQgakf/Bf1NAt59Rfcv47
X-Received: by 2002:a05:6214:258a:b0:91e:8f70:8680 with SMTP id
 6a1803df08f44-92114ca88f7mr32620096d6.3.1795000214344; Wed, 18 Nov 2026
 03:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20261117164151.1362220-1-yoann.congal@smile.fr>
 <CANNYZj9Uj5v-Tb1TrA+TrxrdEyjO+qj25byZ0fWtUpiLHKH-DA@mail.gmail.com> <0fabfef3-dbe6-4fe4-8f7e-d5f8ad47f27f@kernel.crashing.org>
In-Reply-To: <0fabfef3-dbe6-4fe4-8f7e-d5f8ad47f27f@kernel.crashing.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 18 Nov 2026 12:10:03 +0100
X-Gm-Features: Aa3M54qCVjnl8liTB9ViZMWTOZUCiWefM_vwwllafHFOQyBlIfn5PLlndPJj_rU
Message-ID: <CANNYZj-QWR+BDPzG5b1sn2oKBjk0CzYEB8_KgyC32-QfPdkUhQ@mail.gmail.com>
Subject: Re: [OE-core] [PATCH] pseudo: inherit upstream-stable-release-point
To: Mark Hatle <mark.hatle@kernel.crashing.org>
Cc: yoann.congal@smile.fr, yocto-patches@lists.yoctoproject.org, 
	OE-core ML <openembedded-core@lists.openembedded.org>, mark.hatle@amd.com
Content-Type: multipart/alternative; boundary="00000000000025d7f306608b0e80"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 11:10:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5468

--00000000000025d7f306608b0e80
Content-Type: text/plain; charset="UTF-8"

The question is whether point releases of pseudo add only bugfixes? It's
not about 1.9 specifically, but any future release, e.g. 2.0.x as well.

The policy for what is acceptable is documented here:
https://docs.yoctoproject.org/ref-manual/release-process.html#criteria-for-qualifying-upstreams

Alex

On Wed, 18 Nov 2026 at 11:55, Mark Hatle <mark.hatle@kernel.crashing.org>
wrote:

> While pseudo is heavily driven by Yocto Project (and OpenEmbedded)
> requirements,
> I'm not treating this as a YP/OE specific project.
>
> When I say pseudo-1.9 has a stable API, I mean that.  The intention is
> that
> development happens in master.  Stable branches can have backports, as
> required/requested by contributors, but these backports need to "feel"
> stable,
> have a stable API (don't change command line arguments, don't change
> system
> requirements, etc.)
>
> Is there an official list of what is and isn't allowed no.  What pseudo
> does is
> so specialized, I don't think I could come up with a documented set will
> and
> won't.  I also don't expect any applications to write such a list as in
> the end
> it is up to the contributors and maintainers to weigh each patch to
> determine if
> it feels appropriate to go on a stable branch.  But in practice I expect
> if
> someone using pseudo-1.9 experiences breakage due to security fixes in an
> existing platform release we'll backport the fixes there.  But I do not
> intend
> to carry forward pseudo-1.9 forever and into newer host releases.
>
> So in short:
>
> 1. New Development goes to master (or equivalent)
> 2. Backports from master to a numbered branch can be requested
> 3. Priority for backports will be given to resolve breaking issues in
> known
> working hosts, generally centered around Yocto Project/OpenEmbedded as
> that is
> our primary test vehicle.
> 4. We do not intend API changes to be backported to older version.  (It's
> not a
> stronger statement, because with the security backports happening in
> distributions, it might be required at some point.)
>
> --Mark
>
> On 11/17/26 11:13 AM, Alexander Kanavin via openembedded-core wrote:
> > On Tue, 17 Nov 2026 at 17:42, Yoann Congal via openembedded-core
> > <yoann.congal=smile.fr@lists.openembedded.org
> > <mailto:smile.fr@lists.openembedded.org>> wrote:
> >
> >
> >     Pseudo now has a stable branch pseudo-1.9 with pseudo-1.9.x tags on
> it.
> >
> >
> > Is this branch collecting only bugfixes (or fixes needed for continuing
> > operation of yocto release branches)? Is this going to be a policy for
> any
> > future point releases, or is it a one-off just for 1.9.x? There should
> be
> > confirmation of these questions, in addition to the existence of the
> branch.
> >
> > Alex
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#250463):
> https://lists.openembedded.org/g/openembedded-core/message/250463
> > Mute This Topic: https://lists.openembedded.org/mt/122316790/3616948
> > Group Owner: openembedded-core+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/openembedded-core/unsub [
> mark.hatle@kernel.crashing.org]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
>

--00000000000025d7f306608b0e80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The question is whether point releases of pseudo add =
only bugfixes? It&#39;s not about 1.9 specifically, but any future release,=
 e.g. 2.0.x as well.</div><div><br></div><div>The policy for what is accept=
able is documented here:</div><div><a href=3D"https://docs.yoctoproject.org=
/ref-manual/release-process.html#criteria-for-qualifying-upstreams">https:/=
/docs.yoctoproject.org/ref-manual/release-process.html#criteria-for-qualify=
ing-upstreams</a></div><div><br></div><div>Alex</div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, 18 Nov 2026 at 11:55, Mark Hatle &lt;<a href=3D"mailto:mark.hatle=
@kernel.crashing.org">mark.hatle@kernel.crashing.org</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">While pseudo is heavily=
 driven by Yocto Project (and OpenEmbedded) requirements, <br>
I&#39;m not treating this as a YP/OE specific project.<br>
<br>
When I say pseudo-1.9 has a stable API, I mean that.=C2=A0 The intention is=
 that <br>
development happens in master.=C2=A0 Stable branches can have backports, as=
 <br>
required/requested by contributors, but these backports need to &quot;feel&=
quot; stable, <br>
have a stable API (don&#39;t change command line arguments, don&#39;t chang=
e system <br>
requirements, etc.)<br>
<br>
Is there an official list of what is and isn&#39;t allowed no.=C2=A0 What p=
seudo does is <br>
so specialized, I don&#39;t think I could come up with a documented set wil=
l and <br>
won&#39;t.=C2=A0 I also don&#39;t expect any applications to write such a l=
ist as in the end <br>
it is up to the contributors and maintainers to weigh each patch to determi=
ne if <br>
it feels appropriate to go on a stable branch.=C2=A0 But in practice I expe=
ct if <br>
someone using pseudo-1.9 experiences breakage due to security fixes in an <=
br>
existing platform release we&#39;ll backport the fixes there.=C2=A0 But I d=
o not intend <br>
to carry forward pseudo-1.9 forever and into newer host releases.<br>
<br>
So in short:<br>
<br>
1. New Development goes to master (or equivalent)<br>
2. Backports from master to a numbered branch can be requested<br>
3. Priority for backports will be given to resolve breaking issues in known=
 <br>
working hosts, generally centered around Yocto Project/OpenEmbedded as that=
 is <br>
our primary test vehicle.<br>
4. We do not intend API changes to be backported to older version.=C2=A0 (I=
t&#39;s not a <br>
stronger statement, because with the security backports happening in <br>
distributions, it might be required at some point.)<br>
<br>
--Mark<br>
<br>
On 11/17/26 11:13 AM, Alexander Kanavin via openembedded-core wrote:<br>
&gt; On Tue, 17 Nov 2026 at 17:42, Yoann Congal via openembedded-core <br>
&gt; &lt;yoann.congal=3D<a href=3D"mailto:smile.fr@lists.openembedded.org" =
target=3D"_blank">smile.fr@lists.openembedded.org</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:smile.fr@lists.openembedded.org" target=
=3D"_blank">smile.fr@lists.openembedded.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Pseudo now has a stable branch pseudo-1.9 with pseu=
do-1.9.x tags on it.<br>
&gt; <br>
&gt; <br>
&gt; Is this branch collecting only bugfixes (or fixes needed for continuin=
g <br>
&gt; operation of yocto release branches)? Is this going to be a policy for=
 any <br>
&gt; future point releases, or is it a one-off just for 1.9.x? There should=
 be <br>
&gt; confirmation of these questions, in addition to the existence of the b=
ranch.<br>
&gt; <br>
&gt; Alex<br>
&gt; <br>
&gt; <br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#250463): <a href=3D"https://lists.openembedded.org=
/g/openembedded-core/message/250463" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lists.openembedded.org/g/openembedded-core/message/250463</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/12231679=
0/3616948" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.=
org/mt/122316790/3616948</a><br>
&gt; Group Owner: <a href=3D"mailto:openembedded-core%2Bowner@lists.openemb=
edded.org" target=3D"_blank">openembedded-core+owner@lists.openembedded.org=
</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/openembedded-=
core/unsub" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded=
.org/g/openembedded-core/unsub</a> [<a href=3D"mailto:mark.hatle@kernel.cra=
shing.org" target=3D"_blank">mark.hatle@kernel.crashing.org</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; <br>
</blockquote></div>

--00000000000025d7f306608b0e80--
