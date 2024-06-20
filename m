Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0ABC27C53
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 02:27:37 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
 by mx.groups.io with SMTP id smtpd.web10.38507.1718850451811868974
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Jun 2024 19:27:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i2B+loXr;
 spf=pass (domain: gmail.com, ip: 209.85.160.48, mailfrom: raj.khem@gmail.com)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25ca169f861so195221fac.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 19:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718850451; x=1719455251; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03R7eqQI6BZohVVM5m9+1QWbVylBjim8r+4gX0f++54=;
        b=i2B+loXrmGM6hHcMqI0UHd2OCb25tQ13SbkR6wAZQw3AgtcMTUGQs8v9Zhd8TQ2DoB
         E0svYk9ghdWhxjaGAzUnj1MNFp3Qk42EMpzM+O6iyW0LuQFBhQg/lgu2Uii2JeONHWPk
         2pZUV6VjNu1wrEzrp7EKZR3a2o04JUUKa1U7hckc5ek4tIjwT9OvWQgm/5fvZ9rrY6NQ
         V5nnRPMNT7OoiEmkVZCdbw+iXUsT+wys7vUqsjFsBC6TXCxEBKou7d/SiuVTGuoSS07/
         vIWbDZ893Zg0enUVYxxPw7Wa3ftZ8V5y/BeXFmPpR3I847A58+ZBOF18x17AufAOVZkk
         MBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718850451; x=1719455251;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03R7eqQI6BZohVVM5m9+1QWbVylBjim8r+4gX0f++54=;
        b=v71GspiLu97xk2zgca6OZGx1j08dePBK4rs92V7b3XyLm+dMOEM1H27u0d+MTAQlBa
         XeJ768KUMlgDyNXtgtKRVxjpAVK7jNjivEN/lnZFbtAvUEICnKRWkd0iRirO/mNWVmw9
         DUNoJ7nvMl9u7+dIrx4HkCkX6Xq31oyGayMNNCf2ZuFjXGunxf5lYBaTsQaQMeX33CH+
         /+OaLIRhffu3p8T4TC0q4jVF/W4qNrTDVgACpjLH6wJ55BX3BvsCQO+D9QllS/812j7B
         wqrzNpTs4TJP5UdTek4jv/rhk38jtMAiuwy90R4SCSDBALw1KRux1Ie9fIDQI+0z44eW
         8b8g==
X-Gm-Message-State: AOJu0Yxglsy2IBYz05El3xN2OKgCHrIV5h80QKDTyssE8WabrtHX7lp9
	5LIGTPPjxyPoHHKNiek1r4T6DCaHj+GoGgUP45j2S3O4QXYaRXqgeZv3GHertzs7SuXp+k6s9R6
	mfsQR4B1w6hZzE2sEE0gZ1hoynhAiRA==
X-Google-Smtp-Source: AGHT+IH9GInBHrL4X9L39Tk5HGLhZv6uEZCx62kD8MDLE44mPKIH93aQMhwVLBsLHNC7PUy138rI8c7OIHVQLK+v/tQ=
X-Received: by 2002:a05:6871:28a0:b0:259:75eb:2e5c with SMTP id
 586e51a60fabf-25975eb3afdmr3100136fac.29.1718850450634; Wed, 19 Jun 2024
 19:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240620014904.40092-1-twoerner@gmail.com>
In-Reply-To: <20240620014904.40092-1-twoerner@gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 19 Jun 2024 19:27:19 -0700
Message-ID: <CAMKF1spnb5NDz8N=S+ThRzK4ArRrG6v-9P5npPfz9OOhn-AKKA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-torvalds-next:
 SRCREV with nobranch
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000884016061b490ed0"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Jun 2024 02:27:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/358

--000000000000884016061b490ed0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 6:49=E2=80=AFPM Trevor Woerner via lists.yoctoproje=
ct.org
<twoerner=3Dgmail.com@lists.yoctoproject.org> wrote:

> Switch back to using a SRCREV, but this time without a branch (since this
> commit is no longer reachable from any branch), so that network-less buil=
ds
> can take place (or builds that don't need to resolve the tag (over the
> network)).


Thanks using nobranch is good option here

>
>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  recipes-kernel/linux/linux-torvalds-next_git.bb | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb
> b/recipes-kernel/linux/linux-torvalds-next_git.bb
> index 1369ba1d707f..c0ac1de22005 100644
> --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
> +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
> @@ -13,9 +13,11 @@ LINUX_VERSION =3D "6.10-rc3"
>  KERNEL_VERSION_SANITY_SKIP =3D "1"
>  PV =3D "${LINUX_VERSION}+git${SRCPV}"
>  SRC_URI =3D " \
> -       git://
> git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=3Dht=
tps;nobranch=3D1;tag=3Dnext-20240611
> \
> +       git://
> git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=3Dht=
tps;nobranch=3D1
> \
>
> file://rockchip-kmeta;type=3Dkmeta;name=3Drockchip-kmeta;destsuffix=3Droc=
kchip-kmeta
> \
>         "
> +# this is tag 'next-20240611'
> +SRCREV =3D "a957267fa7e9159d3d2ee1421359ebf228570c68"
>
>  inherit kernel
>  inherit kernel-yocto
> --
> 2.44.0.478.g7774cfed6261
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#357):
> https://lists.yoctoproject.org/g/yocto-patches/message/357
> Mute This Topic: https://lists.yoctoproject.org/mt/106773121/1997914
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13340786/1997914/645=
821814/xyzzy
> [raj.khem@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000884016061b490ed0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Jun 19, 2024 at 6:49=E2=80=AFPM Trevor Woerner via =
<a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;tw=
oerner=3D<a href=3D"mailto:gmail.com@lists.yoctoproject.org">gmail.com@list=
s.yoctoproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">S=
witch back to using a SRCREV, but this time without a branch (since this<br=
>
commit is no longer reachable from any branch), so that network-less builds=
<br>
can take place (or builds that don&#39;t need to resolve the tag (over the<=
br>
network)).</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks=
 using nobranch is good option here=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x" dir=3D"auto"><br>
<br>
Signed-off-by: Trevor Woerner &lt;<a href=3D"mailto:twoerner@gmail.com" tar=
get=3D"_blank">twoerner@gmail.com</a>&gt;<br>
---<br>
=C2=A0recipes-kernel/linux/<a href=3D"http://linux-torvalds-next_git.bb" re=
l=3D"noreferrer" target=3D"_blank">linux-torvalds-next_git.bb</a> | 4 +++-<=
br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/recipes-kernel/linux/<a href=3D"http://linux-torvalds-next_git=
.bb" rel=3D"noreferrer" target=3D"_blank">linux-torvalds-next_git.bb</a> b/=
recipes-kernel/linux/<a href=3D"http://linux-torvalds-next_git.bb" rel=3D"n=
oreferrer" target=3D"_blank">linux-torvalds-next_git.bb</a><br>
index 1369ba1d707f..c0ac1de22005 100644<br>
--- a/recipes-kernel/linux/<a href=3D"http://linux-torvalds-next_git.bb" re=
l=3D"noreferrer" target=3D"_blank">linux-torvalds-next_git.bb</a><br>
+++ b/recipes-kernel/linux/<a href=3D"http://linux-torvalds-next_git.bb" re=
l=3D"noreferrer" target=3D"_blank">linux-torvalds-next_git.bb</a><br>
@@ -13,9 +13,11 @@ LINUX_VERSION =3D &quot;6.10-rc3&quot;<br>
=C2=A0KERNEL_VERSION_SANITY_SKIP =3D &quot;1&quot;<br>
=C2=A0PV =3D &quot;${LINUX_VERSION}+git${SRCPV}&quot;<br>
=C2=A0SRC_URI =3D &quot; \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0git://<a href=3D"http://git.kernel.org/pub/scm/=
linux/kernel/git/next/linux-next.git;protocol=3Dhttps;nobranch=3D1;tag=3Dne=
xt-20240611" rel=3D"noreferrer" target=3D"_blank">git.kernel.org/pub/scm/li=
nux/kernel/git/next/linux-next.git;protocol=3Dhttps;nobranch=3D1;tag=3Dnext=
-20240611</a> \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0git://<a href=3D"http://git.kernel.org/pub/scm/=
linux/kernel/git/next/linux-next.git;protocol=3Dhttps;nobranch=3D1" rel=3D"=
noreferrer" target=3D"_blank">git.kernel.org/pub/scm/linux/kernel/git/next/=
linux-next.git;protocol=3Dhttps;nobranch=3D1</a> \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 file://rockchip-kmeta;type=3Dkmeta;name=3Drockc=
hip-kmeta;destsuffix=3Drockchip-kmeta \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<br>
+# this is tag &#39;next-20240611&#39;<br>
+SRCREV =3D &quot;a957267fa7e9159d3d2ee1421359ebf228570c68&quot;<br>
<br>
=C2=A0inherit kernel<br>
=C2=A0inherit kernel-yocto<br>
-- <br>
2.44.0.478.g7774cfed6261<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#357): <a href=3D"https://lists.yoctoproject.org/g/yocto=
-patches/message/357" rel=3D"noreferrer" target=3D"_blank">https://lists.yo=
ctoproject.org/g/yocto-patches/message/357</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/106773121/199=
7914" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/106773121/1997914</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13340786/1997914/645821814/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13340786/1997914/6458218=
14/xyzzy</a> [<a href=3D"mailto:raj.khem@gmail.com" target=3D"_blank">raj.k=
hem@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div></div>

--000000000000884016061b490ed0--

