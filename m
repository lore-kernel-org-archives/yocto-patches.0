Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24D2C61DC6
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 11:44:14 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34528.1787831052580935609
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Aug 2026 04:44:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=tv75rzjy;
 spf=pass (domain: smile.fr, ip: 209.85.221.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so1038014f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Aug 2026 04:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787831051; cv=none;
        d=google.com; s=arc-20260327;
        b=Ux6nCvQbtgV0y8EWzijAwTHbk3Lfmme3n5zz78QcE+1U83O84Vl0cGRCAup6rbOlT4
         pqB47dVbhIsUbwl7cqeh2Mva/azu7WRFEanUCWiNgb48Jn1ouY1lBDadFCLgZ3JnKyYE
         AdOsSYxOQORNgiCqa4mSdpeUDKel868NFHQsWgK1lAUh/6x6TNEglZpquIlCRwjXCNng
         N/DFubga1oybeVIO6wQKZxflmPFbTpQtgWnTzP+pxhkL9vp9eOw4/lz07Sv0KcqfImYQ
         +hlsYlz6DzFjrRh1COYJDOsEL52m55++NM2jwsH86+bnUG6baBYfq9eFk6XDPrtDuDWc
         4P6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5UkM/6AcZckoc7CG4AX7NV5VvZSb7QzCyIVRi7cr4rs=;
        fh=/MH4wvhPUtbRPiZV7Tvq3PiOTTSvYSOpadHYMgLRw3c=;
        b=loTDA2ZtqID9TQK99azY94zaI6wQuAhsg2nPIj6ZL/SZuTP35TzNYhxQDLj7eyTWGj
         IRJALkRNw4VY6f1o4H5g/frk55mr0Px/H+A6ekPXeEbWSaIZ8pLmgf/PC7n3ILiMNo6q
         lNcmwmoCoX62kFATmz1ciuGmdZiD1vRPbOBa9c34guH3JzZfqyTcfLS2DdIQqp15zlBe
         dIcYrhBeoUiFDyD5rnI+Xpdd6CR6mCTW0ixKT4Dan9B7w1d7/w1LdZ74mdpxaDHswLL4
         oHCtizp+EHisg+ZMsJ3Vb155joWxKoD9YpmbC1tD9uCXGItQY1m3t22eeTB99tzZAdxF
         +lKA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1787831051; x=1788435851; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5UkM/6AcZckoc7CG4AX7NV5VvZSb7QzCyIVRi7cr4rs=;
        b=tv75rzjy0Y90fUxREg6NiQ/f7AP1delG3p62FtPVMrNkuMiHG6AT2jj8ijlOm/VwDp
         iyru0rayOvzYmJ4GcGeeAaacGQFtqSKjlilVQYZbEEErlNEaFiitnpSn2LFLkf5whMOC
         dLKX6Z3fMsYbRrPOyX3iBk1v2G6ZG4ULwRx/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787831051; x=1788435851;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5UkM/6AcZckoc7CG4AX7NV5VvZSb7QzCyIVRi7cr4rs=;
        b=ldIY3ySBZY4KVlqwEjvnuLQMEgidJuMeSkeUGayyfUe3D8Y51nVg/eFo2zjdYR/qNc
         MlKvAc6VvvyCFXbY508w+p5hWA8Jvfcd//RVXVIssGX/gEsQoLltHUwzWiFe1HaHJwZ/
         tpZhVpSHWUqNWw46qI8ZsnkAB/in9LhcP+psHLScFOjSbqnEulsZT4jUrAc5+uYaas3b
         kHxaHJkbAnWNMMMj6qqMGFKLE7rHftgYnLPuJdSMb2WjdFxLUj3qlyBtNgkIO5plEZj2
         milsGpZwWmtnqfrLlQZR5/0EftAbsPhYrjjUHkBNdMF2R4g2TT28BC1dAtFB6u9p70ay
         3syg==
X-Gm-Message-State: AFuF++m0nhVXyfuYNwgvG0MUqoqHoF/HanapVbsbveJ7ABfhv4i9qsZw
	tkOrRf7GV/CpMunaCMg3cDKnax2GhkSCtjIH/6/emjnk7Cu+DalnUHMIOx1qdbfKIa5UaLqIJBs
	Gy4ZLigTo6DkcxJS/TMkqFYIuqQicZxtDtXmkgg1+hOwa/eo/DvQbDlU=
X-Gm-Gg: AR+sD12tkTcXyc7GD+v9fGFilIG7A9d3koxs7UBT4ENXRTtDvXM6INmRLwDcXJQTm74
	sfdR619aRonwo591JgspWgxuwvuix34b8NCo/yQecmNDX1ptoFFPBPLzZGZ8STALunvOFuY4Jq9
	5yB2p9tUZz8A7WFpHLxjUYhW/C2sy4wgo57aVKuSAWu0yFaRubR3Psm5Nk/9m9T2QQ4EzW+lE1c
	m+ZimsZQ4wTWYjDPrXYMwMxamG8qeFWlW19pSEtAA3U62hRPJSysfgqrvdMi8VyWhC/cZNFcPvK
	NBY4jl+9DTry4okaeuUSofocgc+IIe6MaaLGN/wKLfPoWAAa9NEGnWgfUArSexyljI0+mcx1pVf
	7pXGjay5yU6Dj
X-Received: by 2002:a05:6000:3c5:b0:482:e428:a625 with SMTP id
 ffacd0b85a97d-482e428a794mr17011783f8f.5.1787831050747; Thu, 27 Aug 2026
 04:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260827084028.1896945-1-yoann.congal@smile.fr> <b7d24922bec85c242c580ab7dd321a8a084f5685.camel@linuxfoundation.org>
In-Reply-To: <b7d24922bec85c242c580ab7dd321a8a084f5685.camel@linuxfoundation.org>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 27 Aug 2026 13:43:44 +0200
X-Gm-Features: AcwNN1UXwIcYqpWpn-HsKRrVb_PNMmVxmbWBRp2-prGL6OruJNqxqXRbxraZoWY
Message-ID: <CAMSfU+4A4WhVH3=bqOEUHD75C7h5yvYa9yt2Fy1_UdepF+HfWw@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH] config: add
 mixin-wrynose-linux-firmware repo to a-full
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000b2d0f3065a05dabd"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Aug 2026 11:44:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4711

--000000000000b2d0f3065a05dabd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 27 ao=C3=BBt 2026 =C3=A0 13:35, Richard Purdie <
richard.purdie@linuxfoundation.org> a =C3=A9crit :

> On Thu, 2026-08-27 at 10:40 +0200, Yoann Congal via lists.yoctoproject.or=
g
> wrote:
> > From: Yoann Congal <yoann.congal@smile.fr>
> >
> > Without this, meta-qcom/wrynose does not find
> > mixin-wrynose-linux-firmware in the shared repos archive[0]:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Copying in repo mixin-wrynose-linux-firmware (1787813774.7)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > tar: ./mixin-wrynose-linux-firmware: Not found in archive
> > > tar: Exiting with failure status due to previous errors
> > > Traceback (most recent call last):
> > >   File
> "/srv/pokybuild/yocto-worker/meta-qcom/yocto-autobuilder-helper/scripts/s=
hared-repo-unpack",
> line 71, in <module>
> > >     subprocess.check_call(["tar", "-I", "zstd", "-C", targetsubdir,
> "-xf", "%s.tar.zst" % args.cache_dir, "./" + repo])
> > >
> ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   File "/usr/lib/python3.14/subprocess.py", line 420, in check_call
> > >     raise CalledProcessError(retcode, cmd)
> > > subprocess.CalledProcessError: Command '['tar', '-I', 'zstd', '-C',
> '/srv/pokybuild/yocto-worker/meta-qcom/build/repos', '-xf',
> '/srv/autobuilder/repos/a-full-4593.tar.zst',
> './mixin-wrynose-linux-firmware']' returned non-zero exit status 2.
> >
> > [0]:
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/113/builds/1490
> >
> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> > ---
> >  config.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/config.py b/config.py
> > index 615c5ae..6058a9a 100644
> > --- a/config.py
> > +++ b/config.py
> > @@ -8,7 +8,7 @@ baserepos =3D ["bitbake", "oecore", "meta-yocto",
> "yocto-docs", "poky"]
> >  # Repositories used by each builder
> >  buildertorepos =3D {
> >      "a-quick": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2"],
> > -    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2",
> "meta-arm", "meta-aws", "meta-agl", "meta-openembedded",
> "meta-virtualization", "meta-clang", "meta-qcom"],
> > +    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2",
> "meta-arm", "meta-aws", "meta-agl", "meta-openembedded",
> "meta-virtualization", "meta-clang", "meta-qcom",
> "mixin-wrynose-linux-firmware"],
> >      "non-gpl3": baserepos + ["meta-gplv2"],
> >      "meta-mingw": baserepos + ["meta-mingw"],
> >      "meta-oe": baserepos + ["meta-openembedded"],
> >
>
> This implications of doing this are significant, for example master
> might start shipping releases with a tarball of mixin-wrynose-linux-
> firmware unless we make further changes. We probably need to find
> another way to make this work :/
>

Yeah OK, let's not do that.

I'll think about another solution.


>
> Cheers,
>
> Richard
>


--=20
Yoann Congal
Smile ECS

--000000000000b2d0f3065a05dabd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0jeu. 27=
 ao=C3=BBt 2026 =C3=A0=C2=A013:35, Richard Purdie &lt;<a href=3D"mailto:ric=
hard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt;=
 a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Thu, 2026-08-27 at 10:40 +0200, Yoann Congal via <a href=3D"http://=
lists.yoctoproject.org" rel=3D"noreferrer" target=3D"_blank">lists.yoctopro=
ject.org</a> wrote:<br>
&gt; From: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=
=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; <br>
&gt; Without this, meta-qcom/wrynose does not find<br>
&gt; mixin-wrynose-linux-firmware in the shared repos archive[0]:<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; Copying in repo mixin-wrynose-linux-firmware (1787813774.7)<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; <br>
&gt; &gt; tar: ./mixin-wrynose-linux-firmware: Not found in archive<br>
&gt; &gt; tar: Exiting with failure status due to previous errors<br>
&gt; &gt; Traceback (most recent call last):<br>
&gt; &gt; =C2=A0 File &quot;/srv/pokybuild/yocto-worker/meta-qcom/yocto-aut=
obuilder-helper/scripts/shared-repo-unpack&quot;, line 71, in &lt;module&gt=
;<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0 subprocess.check_call([&quot;tar&quot;, &quot;=
-I&quot;, &quot;zstd&quot;, &quot;-C&quot;, targetsubdir, &quot;-xf&quot;, =
&quot;%s.tar.zst&quot; % args.cache_dir, &quot;./&quot; + repo])<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0 ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
&gt; &gt; =C2=A0 File &quot;/usr/lib/python3.14/subprocess.py&quot;, line 4=
20, in check_call<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0 raise CalledProcessError(retcode, cmd)<br>
&gt; &gt; subprocess.CalledProcessError: Command &#39;[&#39;tar&#39;, &#39;=
-I&#39;, &#39;zstd&#39;, &#39;-C&#39;, &#39;/srv/pokybuild/yocto-worker/met=
a-qcom/build/repos&#39;, &#39;-xf&#39;, &#39;/srv/autobuilder/repos/a-full-=
4593.tar.zst&#39;, &#39;./mixin-wrynose-linux-firmware&#39;]&#39; returned =
non-zero exit status 2.<br>
&gt; <br>
&gt; [0]: <a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/builde=
rs/113/builds/1490" rel=3D"noreferrer" target=3D"_blank">https://autobuilde=
r.yoctoproject.org/valkyrie/#/builders/113/builds/1490</a><br>
&gt; <br>
&gt; Signed-off-by: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.f=
r" target=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0config.py | 2 +-<br>
&gt; =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/config.py b/config.py<br>
&gt; index 615c5ae..6058a9a 100644<br>
&gt; --- a/config.py<br>
&gt; +++ b/config.py<br>
&gt; @@ -8,7 +8,7 @@ baserepos =3D [&quot;bitbake&quot;, &quot;oecore&quot;=
, &quot;meta-yocto&quot;, &quot;yocto-docs&quot;, &quot;poky&quot;]<br>
&gt; =C2=A0# Repositories used by each builder<br>
&gt; =C2=A0buildertorepos =3D {<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &quot;a-quick&quot;: baserepos + [&quot;meta-=
intel&quot;, &quot;meta-mingw&quot;, &quot;meta-gplv2&quot;],<br>
&gt; -=C2=A0=C2=A0=C2=A0 &quot;a-full&quot;: baserepos + [&quot;meta-intel&=
quot;, &quot;meta-mingw&quot;, &quot;meta-gplv2&quot;, &quot;meta-arm&quot;=
, &quot;meta-aws&quot;, &quot;meta-agl&quot;, &quot;meta-openembedded&quot;=
, &quot;meta-virtualization&quot;, &quot;meta-clang&quot;, &quot;meta-qcom&=
quot;],<br>
&gt; +=C2=A0=C2=A0=C2=A0 &quot;a-full&quot;: baserepos + [&quot;meta-intel&=
quot;, &quot;meta-mingw&quot;, &quot;meta-gplv2&quot;, &quot;meta-arm&quot;=
, &quot;meta-aws&quot;, &quot;meta-agl&quot;, &quot;meta-openembedded&quot;=
, &quot;meta-virtualization&quot;, &quot;meta-clang&quot;, &quot;meta-qcom&=
quot;, &quot;mixin-wrynose-linux-firmware&quot;],<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &quot;non-gpl3&quot;: baserepos + [&quot;meta=
-gplv2&quot;],<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &quot;meta-mingw&quot;: baserepos + [&quot;me=
ta-mingw&quot;],<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &quot;meta-oe&quot;: baserepos + [&quot;meta-=
openembedded&quot;],<br>
&gt; <br>
<br>
This implications of doing this are significant, for example master<br>
might start shipping releases with a tarball of mixin-wrynose-linux-<br>
firmware unless we make further changes. We probably need to find<br>
another way to make this work :/<br></blockquote><div><br></div><div>Yeah O=
K, let&#39;s not do that.</div><div><br></div><div>I&#39;ll think about ano=
ther solution.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--000000000000b2d0f3065a05dabd--

