Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6096FC7EE32
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 11:48:32 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.6076.1750938505595627075
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Jun 2025 04:48:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mZIZqiFt;
 spf=pass (domain: gmail.com, ip: 209.85.216.51, mailfrom: rybczynska@gmail.com)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso654143a91.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750938505; x=1751543305; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KcHx/HovNiEdDpe4h1yGR5EhxC6edFSkkoDazm4bMxU=;
        b=mZIZqiFt0ZoTyJfBSP9HH3V7Nb16jpyMCHFj6E451pbD0F84Au3hGVVNm1INMyftXj
         hyNsA1USknxwoVex82z6w/4yQQeaZiIczfHeSrKwhUgsuKqjeSZ9MGvSUFTCY2O+1myt
         fJC31Om8aIEbRb1hpXWBQ8l85f081KM+Gl5hjI2y8buPOkUOnNfE1djmt+8uYe/ZmYxk
         cifyonGGI4KJ0iRznH13GLkUPTiCEBV9WYTkqH4ABpVKrD1CgKEhPI4AmK4AUezjzcgL
         Q57fZ5EdAOh9HPy+Y68ID/vDuFUJeo6Je2k9+3g4T3Q7vPcXr0rJDbok1P2C0yXNCXv1
         f6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750938505; x=1751543305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcHx/HovNiEdDpe4h1yGR5EhxC6edFSkkoDazm4bMxU=;
        b=kz2U80zrIdz1++R8ZG18Zg1u43WZ06iHEvkrS5zpnhaPHsZuy3+H33cWiAWZdrGDkm
         lkWxZefS+/JHiDMuFgzZGJCAdfzWY9fCAuv7YeAcgXFUTid52wTtTNmXZnqBSoZE/bkV
         nhujOkuvfGcGMwCLTRPaLYF9eFeK7GKM4q23vUWIBQJvGAKuKcMre3voRr35VRVEBt9+
         KpVwILmXaZtealib3wDBxZs3kTPbW5dnIH5Vvj8MrYjg96lgxUiyyjkQsr1Vg0nGXwIh
         p0Yqa3OjPcAT/6GTW+24xhMtbibJIqa1sgtCxL6yr9pxVyWefCJN5zrjG5hDrn7cb/gy
         BN8Q==
X-Gm-Message-State: AOJu0YyfQkRuy1dIis/4+M+Gnq5SkvtTRPinKZJdJzIyZBenlzQJDWma
	NYM0WSyUAmTLwa4kloPtOnzLrX6Iutv7aWpqPdwMj1Z6erXj3Stia21zK8Zc08zbUEYKXBp6/to
	ZlZEraLSqsvMPvRAnFbwdTL0YdwbfTGVTlg==
X-Gm-Gg: ASbGncu7RDu53tDbk+w79QBFeAfBkXag/tmeLgRHnoJ5+VN02fOobU89Tw9h+diMEXh
	jOq24SZGZsqRPRa6lu4ZG87Uh0EeIcU/mpS9gbjOrPWDws5ACeOXYYgKaLxjR5Q8eqWUXxLdqpE
	uZsXFTysXptwUwSuniBdrZ8g18zHjiHaJsLAZg/KSC63H5
X-Google-Smtp-Source: AGHT+IEExnIDpwbd7dS18M4Z8cFmrYVfE8A0CEZfCsAeYg+vn0P/+jnIxWrpqR+SR5UGzFjYUmILCAgsEVP+lVwft7Q=
X-Received: by 2002:a17:90b:1f90:b0:311:ea13:2e61 with SMTP id
 98e67ed59e1d1-315f26c1b74mr8307046a91.34.1750938504479; Thu, 26 Jun 2025
 04:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250623202701.12590-1-akuster808@gmail.com> <6e7dc22b840812a82fc74ba314826c0728786950.camel@linuxfoundation.org>
In-Reply-To: <6e7dc22b840812a82fc74ba314826c0728786950.camel@linuxfoundation.org>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Thu, 26 Jun 2025 13:48:12 +0200
X-Gm-Features: Ac12FXz2pVn3CGmBTHjRCmks33qbFv12VTz56-KvWFWirrFk1DfJIFNiGxYzo5M
Message-ID: <CAApg2=TCLjAjM2Q+LASBYLm79dPW8Zioe2vBR8UiOn+mqBHBBw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 0/1] Time to move on.
To: yocto-patches@lists.yoctoproject.org
Cc: Armin Kuster <akuster808@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000009548f80638782340"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 11:48:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1699

--0000000000009548f80638782340
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 10:38=E2=80=AFPM Richard Purdie via lists.yoctoproj=
ect.org
<richard.purdie=3Dlinuxfoundation.org@lists.yoctoproject.org> wrote:

> Hi Armin,
>
> On Mon, 2025-06-23 at 16:16 -0400, Armin Kuster via lists.yoctoproject.or=
g
> wrote:
> > I have been maintaining this layer for over 12 years and
> > I have had a blast being a layer mainter over those years.
> > Thanks for giving me the opertunity.
> > Its time to pass on the baton for maintanership of this layer.
>
> Thanks for looking after it for all that time!
>
> > I'll let the The Yocto Project TSC decide who the suitable
> > replacement(s) may be.
>
> I'm not sure we let you off that easily! Do you have any suggestions or
> preferences on who might make a good replacement?
>
> I ask since you're probably much more well placed to have an idea of
> who might have the right skills or who might not. Happy to take
> feedback publicly and/or privately.
>
>
Hello,
Thank you Armin for the work over the years. As you guess meta-security is
one
of my main layers.

I've been silent for a while (because we're preparing a bigger
announcement), but
volunteering to co-maintain the layer has been on my TODO for a while. This
is
the moment to do it now then.

If there are no other people who would like to do it, I volunteer for this
layer.

To say it clearly, my goal would be to make it the default layer everyone
uses.

Kind regards,
Marta

--0000000000009548f80638782340
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 23,=
 2025 at 10:38=E2=80=AFPM Richard Purdie via <a href=3D"http://lists.yoctop=
roject.org">lists.yoctoproject.org</a> &lt;richard.purdie=3D<a href=3D"mail=
to:linuxfoundation.org@lists.yoctoproject.org">linuxfoundation.org@lists.yo=
ctoproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hi Armin,<br>
<br>
On Mon, 2025-06-23 at 16:16 -0400, Armin Kuster via <a href=3D"http://lists=
.yoctoproject.org" rel=3D"noreferrer" target=3D"_blank">lists.yoctoproject.=
org</a> wrote:<br>
&gt; I have been maintaining this layer for over 12 years and<br>
&gt; I have had a blast being a layer mainter over those years.<br>
&gt; Thanks for giving me the opertunity.<br>
&gt; Its time to pass on the baton for maintanership of this layer. <br>
<br>
Thanks for looking after it for all that time!<br>
<br>
&gt; I&#39;ll let the The Yocto Project TSC decide who the suitable<br>
&gt; replacement(s) may be.<br>
<br>
I&#39;m not sure we let you off that easily! Do you have any suggestions or=
<br>
preferences on who might make a good replacement?<br>
<br>
I ask since you&#39;re probably much more well placed to have an idea of<br=
>
who might have the right skills or who might not. Happy to take<br>
feedback publicly and/or privately.<br>
<br></blockquote><div><br></div><div>Hello,</div><div>Thank you Armin for t=
he work over the years. As you guess meta-security is one</div><div>of my m=
ain layers.</div><div><br></div><div>I&#39;ve been silent for a while (beca=
use we&#39;re preparing a bigger announcement), but<br></div><div>volunteer=
ing to co-maintain the layer has been on my TODO for a while. This is</div>=
<div>the moment to do it now then.</div><div><br></div><div>If there are no=
 other people who would like to do it, I volunteer for this layer.</div><di=
v><br></div><div>To say it clearly, my goal would be to make it the default=
 layer everyone uses.</div><div><br></div><div>Kind regards,</div><div>Mart=
a<br></div></div></div>

--0000000000009548f80638782340--

