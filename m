Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9879D37E39
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 14:48:45 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11806.1768402117355293307
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Jan 2026 06:48:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=PoOLdq/2;
 spf=pass (domain: smile.fr, ip: 209.85.221.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so6549446f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Jan 2026 06:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1768402115; x=1769006915; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UW3S9D5bbtaR2K3PE7wqEE6uDK/xeE115Fjb9slr4ng=;
        b=PoOLdq/20c6upTbf2jCGImFQXpGBO4092FlUFJ74KXLTYPNm6MfYAflgmRfcWBGE0w
         2+XYLwdkgKRB1eDCnGtV5hmmpuzewBihyYYW9mTG0mLm4PvBD8vAQpvjiaAgv8tOa2ZA
         JkFPsxkMjgEwfVIgJZdzCOC9U06cD9dva8rKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768402115; x=1769006915;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UW3S9D5bbtaR2K3PE7wqEE6uDK/xeE115Fjb9slr4ng=;
        b=SSPQjOwPmWo00GKeAvCpYWxKgveOVBO9thkBN1XI0HhtFk0vn7tTUi/CrdZUpql1jU
         z3EDFTCWQsn/NB2jfuDIACzC9JVJh2uiEfUtKeTrqlyFtuKsUHBaJaOwMLbat+5j/oaS
         lWWnCLG0nE2TVI3UCgGOj1SyzM51LCKaCwgnjWRXTTsTZwkCHj4eBYA+Ux890o7IhoD+
         z8uH6ACgb0P+bPtG5m1cKWRpjo+urr66VD4p2vWbILC4t0s655Gg0qnCqsaPEH4aLQpc
         lHAhTQqQyUAFw5qD5kee2B1TlMzLMKWmwGy8uMNZZZvTLfex5H6PcqjyKn+6yf2igV91
         nFPQ==
X-Gm-Message-State: AOJu0YwomhepNi28n+axKbRKR+y03o9Yls9G+S7IwzbmoE1FDMfPFJd6
	TL04Pr5i9AYg958YlLntBQ5ytTqiq+nUiFhLmjATwEyYjGgmCmlZKdBJFL3cBB4QCY2pCJ9B4+z
	NUUgnKn2sJGlm3rOkHho/UyD4uZms7tKENIOFICBepr5Q+MpJrZ9qkI0=
X-Gm-Gg: AY/fxX79Nz09PtHwZ7Iqkh6tOZYOQgvCBbiM0iP3eqiGWiXIPtpnjeqko1HftpXCyZa
	zoqYc7jYe2nX2dFcsJwyANIBqlgLovPyXS5o9YDdg9WDreez5J6rrKFEpvVmesi/195dwcdg3QC
	NmXGfnrJEpGytzl1fOUejpLGeAA3nM+lKBHj3QY/Swx5NEfGgw8WVByl7d6ByPUZMMGSv0fv4J1
	3UEG4QI0j1UMS2I2h9UF0oBj8lizNZy9OJtZtvGBhPwNchpayl03QNmnY8VBI01TT2is9eJ0g==
X-Received: by 2002:a05:6000:2483:b0:42b:55a1:214f with SMTP id
 ffacd0b85a97d-4342c4f7255mr2952687f8f.21.1768402115121; Wed, 14 Jan 2026
 06:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20260109225006.439787-2-yoann.congal@smile.fr>
In-Reply-To: <20260109225006.439787-2-yoann.congal@smile.fr>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Wed, 14 Jan 2026 15:48:09 +0100
X-Gm-Features: AZwV_Qjm38ySeY00_ZFdGIGsFcI7JQc57TBLrOJ5vRyk3lRP83GIEgv5DEAyA2E
Message-ID: <CAMSfU+5QcAvUbSXVGDd-nQCdTVL3hYqWTE-VOLnyP4f4BwoKKA@mail.gmail.com>
Subject: Re: [RFC yocto-autobuilder2][PATCH] builders: Merge build request
 priority support from upstream buildbot
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000e46cbd06485a33d7"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Jan 2026 14:48:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2954

--000000000000e46cbd06485a33d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 9 janv. 2026 =C3=A0 23:50, Yoann Congal <yoann.congal@smile.fr> a =
=C3=A9crit :

> From: Yoann Congal <yoann.congal@smile.fr>
>
> We use a custom prioritisation function to assigning build requests to
> workers.
>
> Buildbot gained the feature of specifying the priority of a
> build in v3.9.0[0] (our custom function predates that so ignore the
> field entirely).
>
> Merge the priority support added to the buildbot default sort function
> into our custom function (see [0]).
>
> The resulting order should be:
> * First priority (higher priority goes first, defaults to 0)
> * Then, time (oldest build goes first with bonuses for certain builds)
> * Then, builder name (last resort)
>
> With this patch, the priority field of the buildbot UI when starting a
> build can be used to specify a less important build that can goes after
> normal builds (e.g. set priority to -1 for hunting an AB-INT issue).
>
> [0]:
> https://github.com/buildbot/buildbot/commit/bf1cd1321067fd92408fe6fc18d00=
d2edb5f2770
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> RFC:
> * I could not test any of this...
> * I don't know if that is a real problem to solve. How often the AB
>   cluster has pending requests that can't be satisfied for the lack of
>   available workers?
>

To answer my own question: It happens.
As of now (2026-01-14 15:45:35+01:00) every worker has multiple builds and
the buildrequest queue has 6 pending requests (oldest is 1 hour old).
So, maybe this patch might be useful.


> ---
>  builders.py | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/builders.py b/builders.py
> index b7379ec..3d55e15 100644
> --- a/builders.py
> +++ b/builders.py
> @@ -244,6 +244,12 @@ def prioritizeBuilders(master, builders):
>
>      @defer.inlineCallbacks
>      def transform(bldr):
> +        # Sort primarily highest priority of build requests
> +        priority =3D yield bldr.get_highest_priority()
> +        if priority is None:
> +            # for builders that do not have pending buildrequest, we jus=
t
> use large number
> +            priority =3D -math.inf
> +        # Break ties using the time of oldest build request (with bonus)
>          time =3D yield bldr.getOldestRequestTime()
>          #log.msg("Considering %s" % bldr.name)
>          if time is None:
> @@ -254,7 +260,7 @@ def prioritizeBuilders(master, builders):
>                  time =3D time - builder_bonuses[bldr.name]
>                  #log.msg("Adding %s so %s" % (str(builder_bonuses[
> bldr.name]), str(time)))
>
> -        return (time, bldr)
> +        return (-priority, time, bldr)
>
>      transformed =3D yield defer.gatherResults(
>          [transform(bldr) for bldr in builders])
> @@ -262,13 +268,13 @@ def prioritizeBuilders(master, builders):
>      # sort the transformed list synchronously, comparing None to the end
> of
>      # the list
>      def transformedKey(a):
> -        (date, builder) =3D a
> -        return (date, builder.name)
> +        (priority, date, builder) =3D a
> +        return (priority, date, builder.name)
>
>      transformed.sort(key=3DtransformedKey)
>
>      # and reverse the transform
> -    rv =3D [xf[1] for xf in transformed]
> +    rv =3D [xf[2] for xf in transformed]
>      #log.msg("Using %s" % str(rv))
>      return rv
>
>

--=20
Yoann Congal
Smile ECS

--000000000000e46cbd06485a33d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0ven. 9 =
janv. 2026 =C3=A0=C2=A023:50, Yoann Congal &lt;<a href=3D"mailto:yoann.cong=
al@smile.fr">yoann.congal@smile.fr</a>&gt; a =C3=A9crit=C2=A0:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">From: Yoann Congal &lt;<a hr=
ef=3D"mailto:yoann.congal@smile.fr" target=3D"_blank">yoann.congal@smile.fr=
</a>&gt;<br>
<br>
We use a custom prioritisation function to assigning build requests to<br>
workers.<br>
<br>
Buildbot gained the feature of specifying the priority of a<br>
build in v3.9.0[0] (our custom function predates that so ignore the<br>
field entirely).<br>
<br>
Merge the priority support added to the buildbot default sort function<br>
into our custom function (see [0]).<br>
<br>
The resulting order should be:<br>
* First priority (higher priority goes first, defaults to 0)<br>
* Then, time (oldest build goes first with bonuses for certain builds)<br>
* Then, builder name (last resort)<br>
<br>
With this patch, the priority field of the buildbot UI when starting a<br>
build can be used to specify a less important build that can goes after<br>
normal builds (e.g. set priority to -1 for hunting an AB-INT issue).<br>
<br>
[0]: <a href=3D"https://github.com/buildbot/buildbot/commit/bf1cd1321067fd9=
2408fe6fc18d00d2edb5f2770" rel=3D"noreferrer" target=3D"_blank">https://git=
hub.com/buildbot/buildbot/commit/bf1cd1321067fd92408fe6fc18d00d2edb5f2770</=
a><br>
<br>
Signed-off-by: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" ta=
rget=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
---<br>
RFC:<br>
* I could not test any of this...<br>
* I don&#39;t know if that is a real problem to solve. How often the AB<br>
=C2=A0 cluster has pending requests that can&#39;t be satisfied for the lac=
k of<br>
=C2=A0 available workers?<br></blockquote><div><br></div><div>To answer my =
own question: It happens.</div><div>As of now (2026-01-14 15:45:35+01:00) e=
very worker has multiple builds and the buildrequest queue has 6 pending re=
quests (oldest is 1 hour old).</div><div>So, maybe this patch might be usef=
ul.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
---<br>
=C2=A0builders.py | 14 ++++++++++----<br>
=C2=A01 file changed, 10 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/builders.py b/builders.py<br>
index b7379ec..3d55e15 100644<br>
--- a/builders.py<br>
+++ b/builders.py<br>
@@ -244,6 +244,12 @@ def prioritizeBuilders(master, builders):<br>
<br>
=C2=A0 =C2=A0 =C2=A0@defer.inlineCallbacks<br>
=C2=A0 =C2=A0 =C2=A0def transform(bldr):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Sort primarily highest priority of build req=
uests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 priority =3D yield bldr.get_highest_priority()=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if priority is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # for builders that do not have =
pending buildrequest, we just use large number<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priority =3D -math.inf<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Break ties using the time of oldest build re=
quest (with bonus)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time =3D yield bldr.getOldestRequestTime(=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#log.msg(&quot;Considering %s&quot; % <a =
href=3D"http://bldr.name" rel=3D"noreferrer" target=3D"_blank">bldr.name</a=
>)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if time is None:<br>
@@ -254,7 +260,7 @@ def prioritizeBuilders(master, builders):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time =3D time=
 - builder_bonuses[<a href=3D"http://bldr.name" rel=3D"noreferrer" target=
=3D"_blank">bldr.name</a>]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#log.msg(&quo=
t;Adding %s so %s&quot; % (str(builder_bonuses[<a href=3D"http://bldr.name"=
 rel=3D"noreferrer" target=3D"_blank">bldr.name</a>]), str(time)))<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (time, bldr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (-priority, time, bldr)<br>
<br>
=C2=A0 =C2=A0 =C2=A0transformed =3D yield defer.gatherResults(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[transform(bldr) for bldr in builders])<b=
r>
@@ -262,13 +268,13 @@ def prioritizeBuilders(master, builders):<br>
=C2=A0 =C2=A0 =C2=A0# sort the transformed list synchronously, comparing No=
ne to the end of<br>
=C2=A0 =C2=A0 =C2=A0# the list<br>
=C2=A0 =C2=A0 =C2=A0def transformedKey(a):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (date, builder) =3D a<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (date, <a href=3D"http://builder.name" =
rel=3D"noreferrer" target=3D"_blank">builder.name</a>)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (priority, date, builder) =3D a<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (priority, date, <a href=3D"http://buil=
der.name" rel=3D"noreferrer" target=3D"_blank">builder.name</a>)<br>
<br>
=C2=A0 =C2=A0 =C2=A0transformed.sort(key=3DtransformedKey)<br>
<br>
=C2=A0 =C2=A0 =C2=A0# and reverse the transform<br>
-=C2=A0 =C2=A0 rv =3D [xf[1] for xf in transformed]<br>
+=C2=A0 =C2=A0 rv =3D [xf[2] for xf in transformed]<br>
=C2=A0 =C2=A0 =C2=A0#log.msg(&quot;Using %s&quot; % str(rv))<br>
=C2=A0 =C2=A0 =C2=A0return rv<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--000000000000e46cbd06485a33d7--

