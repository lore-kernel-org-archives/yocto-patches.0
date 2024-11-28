Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3C2D69110
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 13:51:57 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.95223.1732801913785410538
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 Nov 2024 05:51:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bLfbtU2w;
 spf=pass (domain: gmail.com, ip: 209.85.167.46, mailfrom: twoerner@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df67d6659so1187854e87.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 28 Nov 2024 05:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732801912; x=1733406712; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cyXSPR8BIkY+3i8lnqHCgfDK3Pyjy+q4uG8QgShQYxk=;
        b=bLfbtU2wUmC09k4HC+/neN1RRtvsLK+K7wZR0W3XmteQn21OrxAtUON6/7MRTXlrEn
         cHqnv7F0eFfG/5+IYm6btA7xCaIrIhzAyw/66esBVntexvYF0/MD+NZq4jbinhB+ckOU
         zbRmtTUhorvHLoHskyOUtuKYci0y/NJZEQZRLz6+hOY9hxWt2cRKo2HiaxcHUt2Ipq5q
         WPjsri4BEgc+VZKkzFSJqeuigqPug+NOFgl3ahVe7Zcc1i+jUsCwGakQ1nYZgYKU55y6
         025qLwt3d9qYFLRzRxwuGHsaSJzVuQlDKxJh9RA075SmjoiTGdgG6Stkp1QJMAs61Pbz
         f3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801912; x=1733406712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyXSPR8BIkY+3i8lnqHCgfDK3Pyjy+q4uG8QgShQYxk=;
        b=tMNgU5SlKQ4vRi1J/XJQL5ibqSFF+Prw/7KIejGsjvH6NABL6EYB8oMZiPw+zzQg6a
         Uk/jHl11F1NLxC/ciDXyK+dgGL02fezNvQ6B1/Y14Ru2fC/ZVK+S9oeKbDBR785CZ5ef
         p2xLFIslF8RH3Qe3/t3ZpO/L9exoON3gKvhWz3gcdfYxlCn1mP+/Q0odMDsVD4s77qmQ
         xYHPmpcMiUkW5mStiKHZgUfOjU6D/Q+sGn1xlVv7cvkXAiU2TC+J4pHvq5lfruhTVDcc
         BNfwoA+IVnRiSsuuMvzBAZ7PcsXZP5sVdpn0W0Y4S/ZP38Ow7hJwmeIrMRpkYTSBEkYy
         GCHw==
X-Gm-Message-State: AOJu0Yz0MIbnAn/YvHVMqESkfpoH5fKONVEowOLlTieRCWptRaaiJVNd
	TqG++IQAoNfmHXY3EKdDB304fP57VHo9zbysCgt87zTRSrWpujaALgZ4AmRcTJTIR1ZbVpqUes7
	V8sbcByYGQ0RlbzhM5ZQfCUiHef8=
X-Gm-Gg: ASbGncs2PJbiDinZ4mYwnPBDsxssHz6Sw+kB1G86yl2EhyK3UH0Wv3HAq3IyjRflaCQ
	uTKY3HEglErx6VD4AhHgnypDxxDyLGcni
X-Google-Smtp-Source: AGHT+IEDoxrUFMS1ZD0bcahSVKkolOsGXQnL+n+/LHFH+BrHiDOaMgoPcq0bFcJP0xT/pgC9g2JLR1eQt8qP13BErB4=
X-Received: by 2002:ac2:42d1:0:b0:53d:f09e:9a1d with SMTP id
 2adb3069b0e04-53df09e9c34mr4448273e87.31.1732801911533; Thu, 28 Nov 2024
 05:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
 <20241127-rkbin-bump-v1-1-b90b6c04a88f@cherry.de> <20241128005526.GA17984@localhost>
 <cc7d79bf-e199-4478-a290-c4926b21e27e@cherry.de>
In-Reply-To: <cc7d79bf-e199-4478-a290-c4926b21e27e@cherry.de>
From: Trevor Woerner <twoerner@gmail.com>
Date: Thu, 28 Nov 2024 08:51:38 -0500
Message-ID: <CAHUNapRvAB5OPtvApDmzM31727KGXnCO3TUe30ZTnELKqZ7YPg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip PATCH 1/2] bsp: rkbin: rkbin-ddr:
 use glob pattern for finding DDR init
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000673ea70627f96221"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Nov 2024 13:51:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/853

--000000000000673ea70627f96221
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How about a variable to hold the version e.g. 1.18 (or whatever)?

On Thu, Nov 28, 2024 at 5:23=E2=80=AFAM Quentin Schulz <quentin.schulz@cher=
ry.de>
wrote:

> Hi Trevor,
>
> On 11/28/24 1:55 AM, Trevor Woerner wrote:
> > On Wed 2024-11-27 @ 04:12:58 PM, Quentin Schulz via
> lists.yoctoproject.org wrote:
> >> From: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> To avoid both having to modify this file every time the
> >> rockchip-rbin.inc SRCREV is bumped and also having to override it were
> >> a user to have to mix and match versions for different products, let's
> >> just use a glob pattern.
> >>
> >> Note that the glob pattern should only match one path, which is the ca=
se
> >> right now.
> >
> > I'm not overly fond of the glob method. It was only back in June of thi=
s
> > year that I pushed a patch to move away from globs to using full
> filenames
> > explicitly. The savings seem pretty thin compared to the potential
> surprise
> > factor when, one day, multiple files might be selected.
> >
> > Do you feel strongly about switching back to the glob?
> >
>
> I feel strongly against the status quo :)
>
> We can add a check that only one file is matched by the glob pattern if
> necessary and fail otherwise with bbfatal/bberror for example.
>
> If we don't use globs, I need to override the do_deploy:<soc> to replace
> the path if I'm building a different version.
>
> Here's what I needed to do on Scarthgap for example in my own layer:
>
> """
> diff --git a/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
> b/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
> index
> 9d381a6afadf7dd66855f6635b5f1f053eecba15..299bb2ac476bf9d988925cbd983a661=
58a8bdf4c
>
> 100644
> --- a/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
> +++ b/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
> @@ -1,5 +1,12 @@
>   FILESEXTRAPATHS:prepend :=3D "${THISDIR}/${PN}:"
>
> +# Remove once the following series is merged and backported:
> +#
>
> https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-0-b90b6c04a8=
8f@cherry.de/
> +SRCREV:tiger-haikou
> <https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-0-b90b6c04a=
88f@cherry.de/+SRCREV:tiger-haikou>
> =3D "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
> +SRCREV:jaguar =3D "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
> +LIC_FILES_CHKSUM:tiger-haikou =3D
> "file://LICENSE;md5=3D11e3673115959bf596feaaa6ea7ce9a5"
> +LIC_FILES_CHKSUM:jaguar =3D
> "file://LICENSE;md5=3D11e3673115959bf596feaaa6ea7ce9a5"
> +
>   # The files are created locally by running:
>   #   ./tools/ddrbin_tool tools/ddrbin_param.txt RKBIN
>   #
> @@ -24,3 +35,14 @@ do_deploy:append:rk3588s() {
>           fi
>       fi
>   }
> +
> +# Can be removed once the following patch is merged and backported
> +#
>
> https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-1-b90b6c04a8=
8f@cherry.de/
> +do_deploy:rk3588s(
> <https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-1-b90b6c04a=
88f@cherry.de/+do_deploy:rk3588s(>)
> {
> +    # Prebuilt TF-A
> +    install -m 644 ${S}/bin/rk35/rk3588_bl31_v*.elf
> ${DEPLOYDIR}/bl31-rk3588.elf
> +    # Prebuilt OPTEE-OS
> +    install -m 644 ${S}/bin/rk35/rk3588_bl32_v*.bin
> ${DEPLOYDIR}/tee-rk3588.bin
> +    # Prebuilt U-Boot TPL (DDR init)
> +    install -m 644
> ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v*.bin
> ${DEPLOYDIR}/ddr-rk3588.bin
> +}
> """
>
> The last part of the diff shouldn't be needed.
>
> If you don't want a glob pattern, we could maybe use a variable to store
> the path to match so that it can be overridden in bbappends?
>
> What do you think?
>
> Cheers,
> Quentin
>

--000000000000673ea70627f96221
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">How about a variable to hold the version e.g. 1.18 (or wha=
tever)?<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Thu, Nov 28, 2024 at 5:23=E2=80=AFAM Quentin Schulz &lt;<a hr=
ef=3D"mailto:quentin.schulz@cherry.de">quentin.schulz@cherry.de</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Trevor,<b=
r>
<br>
On 11/28/24 1:55 AM, Trevor Woerner wrote:<br>
&gt; On Wed 2024-11-27 @ 04:12:58 PM, Quentin Schulz via <a href=3D"http://=
lists.yoctoproject.org" rel=3D"noreferrer" target=3D"_blank">lists.yoctopro=
ject.org</a> wrote:<br>
&gt;&gt; From: Quentin Schulz &lt;<a href=3D"mailto:quentin.schulz@cherry.d=
e" target=3D"_blank">quentin.schulz@cherry.de</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; To avoid both having to modify this file every time the<br>
&gt;&gt; rockchip-rbin.inc SRCREV is bumped and also having to override it =
were<br>
&gt;&gt; a user to have to mix and match versions for different products, l=
et&#39;s<br>
&gt;&gt; just use a glob pattern.<br>
&gt;&gt;<br>
&gt;&gt; Note that the glob pattern should only match one path, which is th=
e case<br>
&gt;&gt; right now.<br>
&gt; <br>
&gt; I&#39;m not overly fond of the glob method. It was only back in June o=
f this<br>
&gt; year that I pushed a patch to move away from globs to using full filen=
ames<br>
&gt; explicitly. The savings seem pretty thin compared to the potential sur=
prise<br>
&gt; factor when, one day, multiple files might be selected.<br>
&gt; <br>
&gt; Do you feel strongly about switching back to the glob?<br>
&gt; <br>
<br>
I feel strongly against the status quo :)<br>
<br>
We can add a check that only one file is matched by the glob pattern if <br=
>
necessary and fail otherwise with bbfatal/bberror for example.<br>
<br>
If we don&#39;t use globs, I need to override the do_deploy:&lt;soc&gt; to =
replace <br>
the path if I&#39;m building a different version.<br>
<br>
Here&#39;s what I needed to do on Scarthgap for example in my own layer:<br=
>
<br>
&quot;&quot;&quot;<br>
diff --git a/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend <br>
b/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend<br>
index <br>
9d381a6afadf7dd66855f6635b5f1f053eecba15..299bb2ac476bf9d988925cbd983a66158=
a8bdf4c <br>
100644<br>
--- a/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend<br>
+++ b/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend<br>
@@ -1,5 +1,12 @@<br>
=C2=A0 FILESEXTRAPATHS:prepend :=3D &quot;${THISDIR}/${PN}:&quot;<br>
<br>
+# Remove once the following series is merged and backported:<br>
+# <br>
<a href=3D"https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-0-b=
90b6c04a88f@cherry.de/+SRCREV:tiger-haikou" rel=3D"noreferrer" target=3D"_b=
lank">https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-0-b90b6c=
04a88f@cherry.de/<br>
+SRCREV:tiger-haikou</a> =3D &quot;7c35e21a8529b3758d1f051d1a5dc62aae934b2b=
&quot;<br>
+SRCREV:jaguar =3D &quot;7c35e21a8529b3758d1f051d1a5dc62aae934b2b&quot;<br>
+LIC_FILES_CHKSUM:tiger-haikou =3D <br>
&quot;file://LICENSE;md5=3D11e3673115959bf596feaaa6ea7ce9a5&quot;<br>
+LIC_FILES_CHKSUM:jaguar =3D <br>
&quot;file://LICENSE;md5=3D11e3673115959bf596feaaa6ea7ce9a5&quot;<br>
+<br>
=C2=A0 # The files are created locally by running:<br>
=C2=A0 #=C2=A0 =C2=A0./tools/ddrbin_tool tools/ddrbin_param.txt RKBIN<br>
=C2=A0 #<br>
@@ -24,3 +35,14 @@ do_deploy:append:rk3588s() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 }<br>
+<br>
+# Can be removed once the following patch is merged and backported<br>
+# <br>
<a href=3D"https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-1-b=
90b6c04a88f@cherry.de/+do_deploy:rk3588s(" rel=3D"noreferrer" target=3D"_bl=
ank">https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-1-b90b6c0=
4a88f@cherry.de/<br>
+do_deploy:rk3588s(</a>) {<br>
+=C2=A0 =C2=A0 # Prebuilt TF-A<br>
+=C2=A0 =C2=A0 install -m 644 ${S}/bin/rk35/rk3588_bl31_v*.elf <br>
${DEPLOYDIR}/bl31-rk3588.elf<br>
+=C2=A0 =C2=A0 # Prebuilt OPTEE-OS<br>
+=C2=A0 =C2=A0 install -m 644 ${S}/bin/rk35/rk3588_bl32_v*.bin <br>
${DEPLOYDIR}/tee-rk3588.bin<br>
+=C2=A0 =C2=A0 # Prebuilt U-Boot TPL (DDR init)<br>
+=C2=A0 =C2=A0 install -m 644 <br>
${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v*.bin <br>
${DEPLOYDIR}/ddr-rk3588.bin<br>
+}<br>
&quot;&quot;&quot;<br>
<br>
The last part of the diff shouldn&#39;t be needed.<br>
<br>
If you don&#39;t want a glob pattern, we could maybe use a variable to stor=
e <br>
the path to match so that it can be overridden in bbappends?<br>
<br>
What do you think?<br>
<br>
Cheers,<br>
Quentin<br>
</blockquote></div>

--000000000000673ea70627f96221--

