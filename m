Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB973CD37BE
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 17:49:53 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.56551.1778521787219874185
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 May 2026 10:49:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Xs1Zb9Vo;
 spf=pass (domain: konsulko.com, ip: 209.85.128.173, mailfrom: tim.orling@konsulko.com)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7b4ee3a88e1so46226917b3.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 11 May 2026 10:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778521786; cv=none;
        d=google.com; s=arc-20240605;
        b=efV4gCqfkJNEqPfdlpHYz4EURoAl4sUcs/DlofjMXZBPXyZfCZXW8KY7gHg1yUYLFA
         FyyejwFIf0TLWA9WMFdEDDbc/QOcuy0tUWUZM7SS0JPmhBcFvtV5u+3tw2sOpcx+Oqsg
         8uUAsoAyzkw0qWvd8y5Ory38JwetW+DIZsPsxLI3IO7cN9aVrDCyqXTZJgf9kGsgStBC
         koTfX4nagB1PjqUaxiVfN0paDsESFsmGGFDyTdlSwxckowB+84DgtzrfbrO02wXRlqxs
         7/u8XNvEf9qCDp10xKRMUxC+FzduP8GRZGOTjUAoLx9BnMWNgmIgL44UhkerZJUPjsxc
         jL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5z2ijEmoDFgx+x9BND7IG/25UhWt4KVbNaceoyPmmnA=;
        fh=1xQzWt/W4EAmz/F47cA+kLIU/CAhbmRrVZxZ7KbnavU=;
        b=GwlEK6oApHJAzU2biJy/He2M3ha4x+iKyN38MTj+QM0/lMiHRj02m4I6CZLWllQqBD
         Vy5maR9onYUqay3cEeBAqjfbBXcK3uh4NLD7yKkecFRBiw06KLzSN5HZjnX5mRmCH3d7
         DYt4VXly1PdIUF/TfgTalj84VS7DOQ6MTaWqH4LYO3IhGV3wA8eUVtJavuHZiERnggI5
         Xv6NZQOlI5Is3R7tEpZvP7aTBNI2ZAnfPmaDUrjQQuAfiYWFGjrkOcUQdHGoabyRan4S
         t+BS+ec/0p/reSxYfICIEPZHhQf24ah/PQuoXp5Ufi/oMEG4cGEwMtkwgN7l1hSz15Q/
         HNpA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778521786; x=1779126586; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5z2ijEmoDFgx+x9BND7IG/25UhWt4KVbNaceoyPmmnA=;
        b=Xs1Zb9VoQ0Q2Efwj4c3QpbufRbiN0uwl9p5KCdt+q86wKV3nB2N0y+kABYBaTvjpIX
         qCQLxN9aQsCMGJ+RLWC0jz6EcqXkeqIdrSgpJ67Hmgy++vJ0t2nXxjE6QnnboPFSW0Hs
         ZV4NEv0jl1P9uO4z4q6jcN0zz+N5UqY9rUReI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521786; x=1779126586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z2ijEmoDFgx+x9BND7IG/25UhWt4KVbNaceoyPmmnA=;
        b=mzvriSknzWcg3DzoBAOn9BdJz9TKDepcT4HvMWKs3NbvyjvvNe9TH1ewPLn5Oxpw/Q
         /t50Bb+IxVBc+WnyRWvUUyoqjJet2A+6evytnmJsg7XoNmeQHpSLMdwXLX6asn6UILhj
         QYStnfJlaii/01fD+uOWWTwvzG7xSIxV+RWAr4SinS4yW+0tkH4m5oj61hzP0vPwQbtr
         CVlPs8vZAx9E75Z0BHoefU3E4wVREb9fR3frRfJpOJ/jaD78kpm80so47nMvGnop7mIq
         L0eJY/OykkwimwVEh7wfO85u4r+ggJmCXXO3LQ3l7j1dLs0pbSQA8vRi/iZnQXQjHZ0V
         Q6Ag==
X-Gm-Message-State: AOJu0YxdvX9YyfjtCAA0Fsg6Ielxe70A6TwH8PbWaXNXA8J1rqR8p1Wn
	6TX29NMUEBfwHkjJGgZpETdw7yosbABcotkZDqblBlSd7Ej9eG6pPk8Nb+NSmMrWsqcSWFPFHrl
	mlZ6nhJiNWAcOFUUlhd+nL4/af/UcmFHMCQdP+UDLbKs+RhwD6XDi4hY=
X-Gm-Gg: Acq92OHv2ki/YXCC4K0tcS8l7PoM+0gKQBZ9jQlMuJ6ETQGqp/gnZJMdRKGliBH0E6+
	jT6L3MFVQazNFgkZmcAL4w9CgrKnFhGKODUM5/KrECuPBM1Pur5HFX8k+iW2TMUQrh3ppNWvfCE
	0QiNC9ur8FU8QPAiiY+OpaGcvsBhtlasVonUHZxgpbj+F0eFG5XI3qb1FaddRgGWJi3rTdihH7T
	hX21xqqO6s9BfQnqmjQNF44GTM3yKt9fp4LpCYn/r659vh5/CgNiKZLJrh6vT5m9GAkFObCJcKf
	B4Y64Xg=
X-Received: by 2002:a05:690c:c4d3:b0:7bd:6114:4002 with SMTP id
 00721157ae682-7bdf5efc9a4mr275339057b3.40.1778521786202; Mon, 11 May 2026
 10:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778202125.git.tim.orling@konsulko.com> <f76cfa3158594d6abef88eaea589b9e135158e9f.1778202125.git.tim.orling@konsulko.com>
 <5356ea1df2a3b640943fed7fd3a358402b9ab644.camel@pbarker.dev>
In-Reply-To: <5356ea1df2a3b640943fed7fd3a358402b9ab644.camel@pbarker.dev>
From: Tim Orling <tim.orling@konsulko.com>
Date: Mon, 11 May 2026 10:49:34 -0700
X-Gm-Features: AVHnY4JlapF4vwU2t3Q0osQAUGZSRe07wMUIp-ZzxuL85lhQ-zCtlvHI9TqQnlU
Message-ID: <CAOyo-84Hywi+Ho7MQdoOA7fjuC4dBFHWgs20te0YH8n+eH36sA@mail.gmail.com>
Subject: Re: [yocto-autobuilder-helper][PATCH 06/11] config.json: add
 vcontainer-tarball build target
To: Paul Barker <paul@pbarker.dev>
Cc: yocto-patches@lists.yoctoproject.org, yocto@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000004ae3bc06518e5f99"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 May 2026 17:49:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3969

--0000000000004ae3bc06518e5f99
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 1:48=E2=80=AFAM Paul Barker <paul@pbarker.dev> wrot=
e:

> On Thu, 2026-05-07 at 18:25 -0700, tim.orling@konsulko.com wrote:
> > From: Tim Orling <tim.orling@konsulko.com>
> >
> > Add the vcontainer-tarball build target which produces the
> > meta-virtualization SDK used by downstream container build/test
> > jobs. Modelled after the buildtools-tarball target.
> >
> > The target uses EXTRACMDS to reset BBMULTICONFIG for the worker
> > shell, places the extravars in the per-step config, and includes
> > a publish-artefacts step so the resulting SDK tarball is staged
> > for reuse by container-tests and other consumers.
> >
> > Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> > ---
> >  config.json | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/config.json b/config.json
> > index ab0ad7c..9e6898d 100644
> > --- a/config.json
> > +++ b/config.json
> > @@ -1869,6 +1869,32 @@
> >          },
> >          "toaster" : {
> >              "EXTRACMDS" : ["${SCRIPTSDIR}/run-toaster-tests
> ${HELPERBUILDDIR} ${HELPERBUILDDIR}/../layers/bitbake"]
> > +        },
> > +        "vcontainer-tarball": {
> > +            "NEEDREPOS" : ["bitbake", "meta-openembedded",
> "meta-virtualization"],
> > +            "ADDLAYER" : [
> > +                "${BUILDDIR}/../meta-openembedded/meta-oe",
> > +                "${BUILDDIR}/../meta-openembedded/meta-python",
> > +                "${BUILDDIR}/../meta-openembedded/meta-networking",
> > +                "${BUILDDIR}/../meta-openembedded/meta-filesystems",
> > +                "${BUILDDIR}/../meta-virtualization"
> > +            ],
> > +            "step1" : {
> > +                "shortname" : "Build vcontainer-tarballs",
> > +                "BBTARGETS" : "vcontainer-tarball",
> > +                "extravars" : [
> > +                    "DISTRO_FEATURES:append =3D ' virtualization
> vcontainer'",
> > +                    "BBMULTICONFIG =3D 'vruntime-aarch64
> vruntime-x86-64'",
> > +                    "INIT_MANAGER =3D 'systemd'"
> > +                ],
> > +                "EXTRACMDS" : ["sed -i '/vruntime-aarch64
> vruntime-x86-64/d' ${HELPERBUILDDIR}/conf/auto.conf"]
>
> What does this sed command achieve? EXTRACMDS run after building
> BBTARGETS.
>
>
Describing the reason was accidentally removed while refactoring and
slimming down the number of commits.

Original squashed commit message:
"
Since meta-virtualization is the first layer removed by 'remove-layers', ou=
r
BBMULTICONFIGs become invalid immediately after layer removal and throw an
error.

In scripts/run-config, EXTRACMDS runs after BBTARGETS, but before
'remove-layers'.
Use 'sed' to reset BBMULTICONFIG to ''.
"

The error in the 'remove-layers' step can be summarized as:

bb.parse.ParseError: ParseError at
/home/pokybuild/yocto-worker/vcontainer-tarball/build/layers/openembedded-c=
ore/meta/conf/bitbake.conf:824:
Could not include required file conf/multiconfig/vruntime-aarch64.conf

Best regards,
>
> --
> Paul Barker
>
>

--0000000000004ae3bc06518e5f99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 11,=
 2026 at 1:48=E2=80=AFAM Paul Barker &lt;<a href=3D"mailto:paul@pbarker.dev=
">paul@pbarker.dev</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On Thu, 2026-05-07 at 18:25 -0700, <a href=3D"mailto:tim.=
orling@konsulko.com" target=3D"_blank">tim.orling@konsulko.com</a> wrote:<b=
r>
&gt; From: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.com" target=
=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; <br>
&gt; Add the vcontainer-tarball build target which produces the<br>
&gt; meta-virtualization SDK used by downstream container build/test<br>
&gt; jobs. Modelled after the buildtools-tarball target.<br>
&gt; <br>
&gt; The target uses EXTRACMDS to reset BBMULTICONFIG for the worker<br>
&gt; shell, places the extravars in the per-step config, and includes<br>
&gt; a publish-artefacts step so the resulting SDK tarball is staged<br>
&gt; for reuse by container-tests and other consumers.<br>
&gt; <br>
&gt; Signed-off-by: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.co=
m" target=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 config.json | 26 ++++++++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 26 insertions(+)<br>
&gt; <br>
&gt; diff --git a/config.json b/config.json<br>
&gt; index ab0ad7c..9e6898d 100644<br>
&gt; --- a/config.json<br>
&gt; +++ b/config.json<br>
&gt; @@ -1869,6 +1869,32 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;toaster&quot; : {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;EXTRACMDS&quot; =
: [&quot;${SCRIPTSDIR}/run-toaster-tests ${HELPERBUILDDIR} ${HELPERBUILDDIR=
}/../layers/bitbake&quot;]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vcontainer-tarball&quot;: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;NEEDREPOS&quot; : [&q=
uot;bitbake&quot;, &quot;meta-openembedded&quot;, &quot;meta-virtualization=
&quot;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ADDLAYER&quot; : [<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;${BUILD=
DIR}/../meta-openembedded/meta-oe&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;${BUILD=
DIR}/../meta-openembedded/meta-python&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;${BUILD=
DIR}/../meta-openembedded/meta-networking&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;${BUILD=
DIR}/../meta-openembedded/meta-filesystems&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;${BUILD=
DIR}/../meta-virtualization&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;step1&quot; : {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;shortna=
me&quot; : &quot;Build vcontainer-tarballs&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;BBTARGE=
TS&quot; : &quot;vcontainer-tarball&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;extrava=
rs&quot; : [<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;DISTRO_FEATURES:append =3D &#39; virtualization vcontainer&#39;&quot=
;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;BBMULTICONFIG =3D &#39;vruntime-aarch64 vruntime-x86-64&#39;&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;INIT_MANAGER =3D &#39;systemd&#39;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;EXTRACM=
DS&quot; : [&quot;sed -i &#39;/vruntime-aarch64 vruntime-x86-64/d&#39; ${HE=
LPERBUILDDIR}/conf/auto.conf&quot;]<br>
<br>
What does this sed command achieve? EXTRACMDS run after building<br>
BBTARGETS.<br>
<br></blockquote><div><br></div><div>Describing the reason was accidentally=
 removed while refactoring and slimming down the number of commits.</div><d=
iv><br></div><div>Original squashed commit message:</div><div>&quot;<br>Sin=
ce meta-virtualization is the first layer removed by &#39;remove-layers&#39=
;, our<br>BBMULTICONFIGs become invalid immediately after layer removal and=
 throw an<br>error.<br><br>In scripts/run-config, EXTRACMDS runs after BBTA=
RGETS, but before &#39;remove-layers&#39;.<br>Use &#39;sed&#39; to reset BB=
MULTICONFIG to &#39;&#39;.</div><div>&quot;</div><div><br></div><div>The er=
ror in the &#39;remove-layers&#39; step can be summarized as:</div><div><br=
></div><div>bb.parse.ParseError: ParseError at /home/pokybuild/yocto-worker=
/vcontainer-tarball/build/layers/openembedded-core/meta/conf/bitbake.conf:8=
24: Could not include required file conf/multiconfig/vruntime-aarch64.conf<=
br><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Best regards,<br>
<br>
-- <br>
Paul Barker<br>
<br>
</blockquote></div></div>

--0000000000004ae3bc06518e5f99--

