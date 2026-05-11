Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC963CD4840
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 18:04:43 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.56862.1778522679091706684
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 May 2026 11:04:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=T6YGlZlu;
 spf=pass (domain: konsulko.com, ip: 209.85.128.182, mailfrom: tim.orling@konsulko.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7bd5c773ef3so47000727b3.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 11 May 2026 11:04:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778522678; cv=none;
        d=google.com; s=arc-20240605;
        b=iLkBQ1ApBi4WmDP7ICtt6ziT0f6YkN3St0fINp9eF+RNjvOIePl7FzRN9s5nnHBXWR
         rZhyn0zbyzJe22evMavSOGdKrsK8cGiUbz3ziQs/hB80RoMwVRNMcFUJTUmOtGTBf2Tc
         b77wbvLnOnt9a3EHPVL3AgSSd3XCKTMcJwTh9G8IIjKtjaEDcQu3c03DYYC29rNh5Gpq
         akA5zgjx/4SxjFz1vC9ZYTecvOUhM5w1KU1SiPCjMObZK1A1ZG0VwUzTdP944A+kinr8
         UCyU1S1Dfi31X4+8HKFmADidZVzjG3Ph6tkPOeSu06I49ys2sywEcv65fTpVyV2y7j7P
         Modg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Bfx9x45a/8R68Ks/X/Zie5C0DY1Hfq0xgvZ+l+1he2Y=;
        fh=1xQzWt/W4EAmz/F47cA+kLIU/CAhbmRrVZxZ7KbnavU=;
        b=bxNfEScwT08OWHTwhBW8DIVXvxVWevBv/ukmkLMF6aOlcCJ/eGvAn+leggtLojALh1
         Qn6eaIN+aQAHLVTduJJo5Hq0S65N4h2L824CaiO1SZ2OM8Hgn9cYPAaKQI3+04Euu/UJ
         OGLgAOEmcQjmkEKBg2O26UYDvChghb8IYuuklY3+P63rRSKXZhghf8GmxcuJ9KBTnP4E
         An9T4iIC51Eh1ltbwJ8N6w9rjFPd0eD1Uowe7u7NK4p3HIHzdrEadTLzuUISVF9GBtpT
         z0d/uH+/LtRz6pdtPfNuZmaeB1QykPXYdTibXgbAj5D7zQ/Iz5/SExRs92bzQV/NtUOK
         4DVw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778522678; x=1779127478; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bfx9x45a/8R68Ks/X/Zie5C0DY1Hfq0xgvZ+l+1he2Y=;
        b=T6YGlZluyxAPnyIEyDaXOA0u6OsIxPL4NdmN3MnrYBv86a5vPH1PGf4lSaMvUP93GZ
         sKEkIz8uks5PY7THjO4wED8HHJvsEEsAjm/9F2BkPGIK48MLL7g1qiv8PHgNdBoJ06xl
         TscdK8k8BipQ8pewdQW08QFHdAg2NgS3t3WV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522678; x=1779127478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bfx9x45a/8R68Ks/X/Zie5C0DY1Hfq0xgvZ+l+1he2Y=;
        b=emIN+L835bI0kswpfV/x6vSjenwvHpnltRWoZpj8sKAw8KGXnSb6VGB5cpkMIF0RWx
         7AoZRuLt6p6lTrXsAlMy2lLV/5E7Bh1kjPTTGjTSwBGPi+JPypcKQFC/jZRXi0mQuhJk
         P1G4sUroAllAmkNUolgPPkKm6VCqKCXbM7O6SNR+ULLOWIEbuohBrBJ088FRx3UPYS6D
         mze/UlgpmQUHO2fChMd4dAVmGNO/a1T+caochJvmyV22eDbY39/VS2shwxxJv/RBgDgf
         tHuaw1qBFyqQpjNA00IquT9ZPUgAfJ+A5YYGK/ySNMRssqsgR/j7jOEwxlDGqug7841w
         ZyKA==
X-Gm-Message-State: AOJu0YzEJ4tkz9kpF9hHlaYQXippoRQzltuIVXvOqArAhRYOS013G0a2
	m+1PnunOeMgBF/pCTuQzDJAdS6oqLCs6pg5TUE/wopbrJzSlfrwND3kDnMnfGTQLpTpZ9UyHQrM
	LXVWmURsDipLaITjIVF4p9CITbAnqtMUkchobj+tKeCvwZbquZ99KzZA=
X-Gm-Gg: Acq92OHnYEJ4CzdOPOwMZK3XEO+vvLnokZ/4+5zEJXkD8hP5fOyzleLBVQuhYE7z3BX
	o/h/1WzW5TkLKx8oPWB/a3wGlG3TYq0nQxEzzUC93fZUzzo1aG3rYQCe4IUO9cGMIJz13FqH3cC
	gE5dEAgwFm8KZ+J+pL5D7NfIJhce5Wfxsl0EJm2x5B9+FkLJOeVJy5vnNS1t5q3dzZHSeVmpoEy
	ZF+/2XKBX0ofA/fNRf5RJUCFR0M9tV1cvFBGO5wLGrwQJV0qt9kDBS3o+kpOEvcyt6bYUhP7f5z
	X2mTfsLExKQkHwS4iw==
X-Received: by 2002:a05:690c:c504:b0:7bd:8cb2:4fa1 with SMTP id
 00721157ae682-7bdf5d98fd6mr266200597b3.5.1778522678129; Mon, 11 May 2026
 11:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778202125.git.tim.orling@konsulko.com> <601c281165450b2be14de46bb9601e82229ca5f6.1778202125.git.tim.orling@konsulko.com>
 <a12dbd29263557679eeeb5dbaabeac9266fcabe3.camel@pbarker.dev>
In-Reply-To: <a12dbd29263557679eeeb5dbaabeac9266fcabe3.camel@pbarker.dev>
From: Tim Orling <tim.orling@konsulko.com>
Date: Mon, 11 May 2026 11:04:27 -0700
X-Gm-Features: AVHnY4K6-uQec08AqptTH1Xq0J6Egex30Ej2y3F78GJVzvqvgFsLzUnQbwWGyFA
Message-ID: <CAOyo-87Me5QSVG7=+sF4TXASvxNb8U0V4VVibVi1x-o_E=PGmQ@mail.gmail.com>
Subject: Re: [yocto-autobuilder-helper][PATCH 11/11] config.json:
 containers-library: add mosquitto and valkey demos
To: Paul Barker <paul@pbarker.dev>
Cc: yocto-patches@lists.yoctoproject.org, yocto@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000007484fa06518e949b"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 May 2026 18:04:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3971

--0000000000007484fa06518e949b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 2:00=E2=80=AFAM Paul Barker <paul@pbarker.dev> wrot=
e:

> On Thu, 2026-05-07 at 18:25 -0700, tim.orling@konsulko.com wrote:
> > From: Tim Orling <tim.orling@konsulko.com>
> >
> > Extend containers-library with two additional demo images sourced
> > from meta-yocto-containers-demo:
> >
> >   * app-container-mosquitto: the Eclipse Mosquitto MQTT broker.
> >   * app-container-valkey: Valkey (Redis-compatible) key/value datastore=
.
> >
> > Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> > ---
> >  config.json | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/config.json b/config.json
> > index 7cdf91a..a9a2e9c 100644
> > --- a/config.json
> > +++ b/config.json
> > @@ -1950,6 +1950,18 @@
> >                  "BBTARGETS" : "app-container-python",
> >                  "CONTAINER_IMAGES" : {"app-container-python": "python"=
},
> >                  "CONTAINER_VERSION_RECIPE" : "python3"
> > +            },
> > +            "step2" : {
> > +                "shortname" : "Build 'mosquitto' container",
> > +                "BBTARGETS" : "app-container-mosquitto",
> > +                "CONTAINER_IMAGES" : {"app-container-mosquitto":
> "mosquitto"},
> > +                "CONTAINER_VERSION_RECIPE" : "mosquitto"
> > +            },
> > +            "step3" : {
> > +                "shortname" : "Build 'valkey' container",
> > +                "BBTARGETS" : "app-container-valkey",
> > +                "CONTAINER_IMAGES" : {"app-container-valkey": "valkey"=
},
> > +                "CONTAINER_VERSION_RECIPE" : "valkey"
>
> This makes me wonder: can we build multiple app container images with
> one bitbake command? If so, can we combine these into one step?
>

The getconfigdict() that was added to scripts/utils.py might make the JSON
definition of CONTAINER_IMAGES awkward as more containers are added, but it
"should" work.

I had considered using a list of recipe names and building them in one
step, rather than a long 'bitbake <recipe 1> <recipe 2> ... <recipe N>'
command. This first attempt was kept simple.

This would also impact pushing containers, as pushing is currently appended
as a step after 'build targets' when the push_containers boolean is true.
Container tooling needs to push one container at a time, which will become
more complicated with signing and attaching SLSA attestations. This might
be another use case for a list of container recipes that can be iterated
through.

I'm open to another design if folks have better ideas for how the AB works.


> Best regards,
>
> --
> Paul Barker
>
>

--0000000000007484fa06518e949b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 11,=
 2026 at 2:00=E2=80=AFAM Paul Barker &lt;<a href=3D"mailto:paul@pbarker.dev=
">paul@pbarker.dev</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On Thu, 2026-05-07 at 18:25 -0700, <a href=3D"mailto:tim.=
orling@konsulko.com" target=3D"_blank">tim.orling@konsulko.com</a> wrote:<b=
r>
&gt; From: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.com" target=
=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; <br>
&gt; Extend containers-library with two additional demo images sourced<br>
&gt; from meta-yocto-containers-demo:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* app-container-mosquitto: the Eclipse Mosquitto MQTT brok=
er.<br>
&gt;=C2=A0 =C2=A0* app-container-valkey: Valkey (Redis-compatible) key/valu=
e datastore.<br>
&gt; <br>
&gt; Signed-off-by: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.co=
m" target=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 config.json | 12 ++++++++++++<br>
&gt;=C2=A0 1 file changed, 12 insertions(+)<br>
&gt; <br>
&gt; diff --git a/config.json b/config.json<br>
&gt; index 7cdf91a..a9a2e9c 100644<br>
&gt; --- a/config.json<br>
&gt; +++ b/config.json<br>
&gt; @@ -1950,6 +1950,18 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;BB=
TARGETS&quot; : &quot;app-container-python&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;CO=
NTAINER_IMAGES&quot; : {&quot;app-container-python&quot;: &quot;python&quot=
;},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;CO=
NTAINER_VERSION_RECIPE&quot; : &quot;python3&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;step2&quot; : {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;shortna=
me&quot; : &quot;Build &#39;mosquitto&#39; container&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;BBTARGE=
TS&quot; : &quot;app-container-mosquitto&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;CONTAIN=
ER_IMAGES&quot; : {&quot;app-container-mosquitto&quot;: &quot;mosquitto&quo=
t;},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;CONTAIN=
ER_VERSION_RECIPE&quot; : &quot;mosquitto&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;step3&quot; : {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;shortna=
me&quot; : &quot;Build &#39;valkey&#39; container&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;BBTARGE=
TS&quot; : &quot;app-container-valkey&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;CONTAIN=
ER_IMAGES&quot; : {&quot;app-container-valkey&quot;: &quot;valkey&quot;},<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;CONTAIN=
ER_VERSION_RECIPE&quot; : &quot;valkey&quot;<br>
<br>
This makes me wonder: can we build multiple app container images with<br>
one bitbake command? If so, can we combine these into one step?<br></blockq=
uote><div><br>The getconfigdict() that was added to scripts/utils.py might =
make the JSON definition of CONTAINER_IMAGES awkward as more containers are=
 added, but it &quot;should&quot; work.<br><br>I had considered using a lis=
t of recipe names and building them in one step, rather than a long &#39;bi=
tbake &lt;recipe 1&gt; &lt;recipe 2&gt; ... &lt;recipe N&gt;&#39; command. =
This first attempt was kept simple.<br><br>This would also impact pushing c=
ontainers, as pushing is currently appended as a step after &#39;build targ=
ets&#39; when the push_containers boolean is true. Container tooling needs =
to push one container at a time, which will become more complicated with si=
gning and attaching SLSA attestations.=C2=A0This might be another use=C2=A0=
case for a list of container recipes that can be iterated through.</div><di=
v><br>I&#39;m open to another design if folks have better ideas for how the=
 AB works.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
Best regards,<br>
<br>
-- <br>
Paul Barker<br>
<br>
</blockquote></div></div>

--0000000000007484fa06518e949b--

