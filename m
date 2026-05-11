Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0706FCD37BE
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 18:25:04 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.57553.1778523899027660382
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 May 2026 11:24:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=SR8IF6tH;
 spf=pass (domain: konsulko.com, ip: 209.85.128.177, mailfrom: tim.orling@konsulko.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bd65714dcaso49629607b3.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 11 May 2026 11:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778523898; cv=none;
        d=google.com; s=arc-20240605;
        b=dpQdOrReDrpZweMIdcTdCASYBMtACH711SYHDhqolaNIRxe4KgznCBdyjIJGYOEWWl
         mM2oRgbS1QJIKdqOD/R8PoPVO20TR8IwkuLHss8X/EIHzOhsZoqjRvOVzegvRRxuD43k
         Htv64fH/KWK4YNDL+9OI3JVD6oWoGskFJz+b3dZMjkfl0Y5cSkWcFoIqTqZpvLwcIgzm
         dvydXv5qigN5YgCyxcjnWgrmwh4jqJWpX11WO480a8Z1/row2up/UpewKGPMlk0UJRLc
         zgl9wP2cN3jd1Jp9EW1dnbnwJPOvDp2R+RxgQUNqbpR9HEr4CtgcTwp8klrzTNQYhws1
         MJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=989r4CHrevto8BPvIFuOYD5OGQgCREsUGzjsGNDVS9I=;
        fh=1xQzWt/W4EAmz/F47cA+kLIU/CAhbmRrVZxZ7KbnavU=;
        b=b8guBrMCk4JYnFGjldFLipOqtvD0PFgFzrFPaXMxMgTAzXZlWk1Bb2MFrY5RUuT+F5
         lIsrXfRcn+D2YVjseXVAzIpzuDONyPgyhktyjg2CUrouNWEf0YrmuWknCMD51nW64z+G
         08Q+sAUIA9Zf0Fxz+wJof8hR2QLjBZqernHyWkrP8B2XuWimG+3dSBmrRRUrp1Ue63Yo
         JqEpv5w0CK/7HK0qe3xZEYnmvyavmRuSeKcoIb9urpyicJGOPKafXJPm3q4QEjv+IG02
         4JVEALXAvt2tB8CaWzSUKvpY8w+YhW0drZHyTXy9gKeYb0XMke8rgXvR5firoPM4dFrk
         ao7A==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778523898; x=1779128698; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=989r4CHrevto8BPvIFuOYD5OGQgCREsUGzjsGNDVS9I=;
        b=SR8IF6tH3HaGFVjdixwImZlUBHl4eTZNL7EscdfkqLqrrEGBvXYid/klNmmkCY+N6g
         ArpvDAegC0utcNDV3bmbPydb8SS15SONJRHhFHxDmUnrdkt/0hWrmWMhmWinlzkhiiAu
         NEDKj1bvxKmviTIEPr6qE9T0NHwHG6BiOgCK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523898; x=1779128698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=989r4CHrevto8BPvIFuOYD5OGQgCREsUGzjsGNDVS9I=;
        b=EhUsUvqOsfQ+Md11exaXXcN4+YgsnqqyW9agQql2nvZo8PJ2kBuE5HdEHTb6kwyB0X
         XkAObfk9t6uuW52rnxYyaqOK2y20Lra2sNLtCjzJzykOyCHmsQHkqvEC73Q0JjDZ8Je/
         6lhA7oAusxvkrzYsRMxW1geF4V2C/8qG1wct6iZ8fqeGOvtZNdIsCdtvaJQLvbskLNug
         P24HUvscuwxpnGocRy3UjR6n1dcfRsGH8zWQJrM+EWvVad1GVTNLLinY07B6RRQ9YsCg
         Qr5jNb6mv4tPRR2ZVXRhNRcimL6yUF7s93+HEwKhfaRpuWW/kvO/VLNu7agDfvk2i68Y
         5ZFg==
X-Gm-Message-State: AOJu0Yzb71a/NrFyZNv9MsIWnl/NgF+QUpp2yxuhrxoA/cvFhwSkNptl
	Kt6aQOR4kjCt0kX6FOJjIn5VeLyiyusqGizC7NxNHId8jfQwyqR/BeW3NHOj+vOD7nd9CwmCkKQ
	nVIk/GiCcnMp1LNZ7GqVvocKdYAtPOQfUSHDIMRg3eA==
X-Gm-Gg: Acq92OGjK/jp8KgBmRghWwH/m7HjxJzjVx/dCzmg9brhoMvVWnnLfj3wp15+4XkAUfb
	NgQBUa0loRzXSyjrQ+CqlzMB/ZTdP2BxdRTznX5o5fJaG7+IetkELwDoRI6hFbXWrPOwLXruZvl
	rna6K6eTSSsvRwvX7LnzeMI8rtvl/lYf5+vIlisTUxtaUDKA+WxzV+rD6kSpcrNjSupYHoMX4HZ
	QMahwh0XssweSqUSeCxYN1LyZvq6hG2eFzUNw37Gro3ctJ0Qd9xI/ihu/WYaDcDMykwaYAXSmQB
	NY8YO+I=
X-Received: by 2002:a05:690c:d90:b0:7b8:bc4e:a4c with SMTP id
 00721157ae682-7c104da880emr101627887b3.27.1778523897902; Mon, 11 May 2026
 11:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778202125.git.tim.orling@konsulko.com> <601c281165450b2be14de46bb9601e82229ca5f6.1778202125.git.tim.orling@konsulko.com>
 <a12dbd29263557679eeeb5dbaabeac9266fcabe3.camel@pbarker.dev> <CAOyo-87Me5QSVG7=+sF4TXASvxNb8U0V4VVibVi1x-o_E=PGmQ@mail.gmail.com>
In-Reply-To: <CAOyo-87Me5QSVG7=+sF4TXASvxNb8U0V4VVibVi1x-o_E=PGmQ@mail.gmail.com>
From: Tim Orling <tim.orling@konsulko.com>
Date: Mon, 11 May 2026 11:24:46 -0700
X-Gm-Features: AVHnY4IWknNIfwZdr3z-yk1H90veEdSHx30RyJsH1F1P-dR3ziR2TXHKIYUqFe0
Message-ID: <CAOyo-872MQ5CdFtLyhr7DVMyL_JpGWgmOV-SLQ-jy7nN++meeg@mail.gmail.com>
Subject: Re: [yocto-autobuilder-helper][PATCH 11/11] config.json:
 containers-library: add mosquitto and valkey demos
To: Paul Barker <paul@pbarker.dev>
Cc: yocto-patches@lists.yoctoproject.org, yocto@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000028d4f306518edde5"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 May 2026 18:25:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3972

--00000000000028d4f306518edde5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 11:04=E2=80=AFAM Tim Orling <tim.orling@konsulko.co=
m> wrote:

>
>
> On Mon, May 11, 2026 at 2:00=E2=80=AFAM Paul Barker <paul@pbarker.dev> wr=
ote:
>
>> On Thu, 2026-05-07 at 18:25 -0700, tim.orling@konsulko.com wrote:
>> > From: Tim Orling <tim.orling@konsulko.com>
>> >
>> > Extend containers-library with two additional demo images sourced
>> > from meta-yocto-containers-demo:
>> >
>> >   * app-container-mosquitto: the Eclipse Mosquitto MQTT broker.
>> >   * app-container-valkey: Valkey (Redis-compatible) key/value datastor=
e.
>> >
>> > Signed-off-by: Tim Orling <tim.orling@konsulko.com>
>> > ---
>> >  config.json | 12 ++++++++++++
>> >  1 file changed, 12 insertions(+)
>> >
>> > diff --git a/config.json b/config.json
>> > index 7cdf91a..a9a2e9c 100644
>> > --- a/config.json
>> > +++ b/config.json
>> > @@ -1950,6 +1950,18 @@
>> >                  "BBTARGETS" : "app-container-python",
>> >                  "CONTAINER_IMAGES" : {"app-container-python":
>> "python"},
>> >                  "CONTAINER_VERSION_RECIPE" : "python3"
>> > +            },
>> > +            "step2" : {
>> > +                "shortname" : "Build 'mosquitto' container",
>> > +                "BBTARGETS" : "app-container-mosquitto",
>> > +                "CONTAINER_IMAGES" : {"app-container-mosquitto":
>> "mosquitto"},
>> > +                "CONTAINER_VERSION_RECIPE" : "mosquitto"
>> > +            },
>> > +            "step3" : {
>> > +                "shortname" : "Build 'valkey' container",
>> > +                "BBTARGETS" : "app-container-valkey",
>> > +                "CONTAINER_IMAGES" : {"app-container-valkey":
>> "valkey"},
>> > +                "CONTAINER_VERSION_RECIPE" : "valkey"
>>
>> This makes me wonder: can we build multiple app container images with
>> one bitbake command? If so, can we combine these into one step?
>>
>
> The getconfigdict() that was added to scripts/utils.py might make the JSO=
N
> definition of CONTAINER_IMAGES awkward as more containers are added, but =
it
> "should" work.
>
> I had considered using a list of recipe names and building them in one
> step, rather than a long 'bitbake <recipe 1> <recipe 2> ... <recipe N>'
> command. This first attempt was kept simple.
>
> This would also impact pushing containers, as pushing is currently
> appended as a step after 'build targets' when the push_containers boolean
> is true. Container tooling needs to push one container at a time, which
> will become more complicated with signing and attaching SLSA
> attestations. This might be another use case for a list of container
> recipes that can be iterated through.
>
> I'm open to another design if folks have better ideas for how the AB work=
s.
>
>
Capturing some additional thoughts I had on IRC:
do we have any existing examples where a step iterates over a list in the
AB?
11:10 AM
I guess all the container recipes could be in BBTARGETS... but that list
could get quite long as more container recipes are added...
11:13 AM
maybe follow the ptest-packagelists.inc pattern
11:15 AM
which then begs for BBCLASSEXTEND =3D "${@' '.join(['mcextend:'+x for x in
d.getVar('PTESTS').split()])}" ;)


>
>> Best regards,
>>
>> --
>> Paul Barker
>>
>>

--00000000000028d4f306518edde5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 11,=
 2026 at 11:04=E2=80=AFAM Tim Orling &lt;<a href=3D"mailto:tim.orling@konsu=
lko.com">tim.orling@konsulko.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On M=
on, May 11, 2026 at 2:00=E2=80=AFAM Paul Barker &lt;<a href=3D"mailto:paul@=
pbarker.dev" target=3D"_blank">paul@pbarker.dev</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On Thu, 2026-05-07 at 18:25 =
-0700, <a href=3D"mailto:tim.orling@konsulko.com" target=3D"_blank">tim.orl=
ing@konsulko.com</a> wrote:<br>
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
 AB works.</div><div><br></div></div></div></blockquote><div><br></div><div=
>Capturing some additional thoughts I had on IRC:</div><div>do we have any =
existing examples where a step iterates over a list in the AB?<br>11:10 AM =
<br>I guess all the container recipes could be in BBTARGETS... but that lis=
t could get quite long as more container recipes are added...<br>11:13 AM <=
br>maybe follow the ptest-packagelists.inc pattern<br>11:15 AM <br>which th=
en begs for BBCLASSEXTEND =3D &quot;${@&#39; &#39;.join([&#39;mcextend:&#39=
;+x for x in d.getVar(&#39;PTESTS&#39;).split()])}&quot; ;)</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div class=3D"gmail_quote"><div></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
Best regards,<br>
<br>
-- <br>
Paul Barker<br>
<br>
</blockquote></div></div>
</blockquote></div></div>

--00000000000028d4f306518edde5--

