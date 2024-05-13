Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FA7C25B74
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 15:03:20 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.62951.1715612596468065552
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 08:03:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=h9Rt/fis;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.43, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a599eedc8eeso1099302666b.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 08:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715612595; x=1716217395; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aN0Byy1m/yXRqH6ykOyccfDvYy15XLCHro0dJZj+TYY=;
        b=h9Rt/fisSHVkjH5BVlPGLhRMg374OgI+8+7bd07c/8Lpk80EsoWJCemNeRFXIWTIdc
         EGGlxH2+jGEV+ZXoHaRtqkUFIJXznz7YQaSD4BzqudAa8CDkE+nyIImJTPdSvqE9Xui8
         xanNfLreSGylb53A4krnElW0Gn8dLA8vrcRDWow+V+NfCzBx1t4EMLcmTSnwQypEfmCu
         nlE+VHlJ9x+4b1baYzWgPnsgcFJuBs3ivqyKdg1YdQYjWaLLN9b1LJfszAnYS/Hb4x36
         3XJP8RBrcVXA3BmiecC0F6jS9N8+djc/U1n2blT4fGO4wM4lcmwLXS/laCjRtWSZEK3t
         vUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612595; x=1716217395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aN0Byy1m/yXRqH6ykOyccfDvYy15XLCHro0dJZj+TYY=;
        b=Wn2CgwBpbkiLDXakmp2GX2bk1CWUgkpOEqdTW68XizbX7t8HHDMU4+6HwGdRjjwotb
         EMVHwZERJjHCxfmIUiuEQDhO80hRdHiL/xOoUQEaJDTxbcGDZuqtRzara/MjZRb4/c8t
         +eJLaxR4QzVpS5bbStvR2T20egTAfSm2wS8PNBkcr64uGg1s87UOdwZ1RKFVsEISHFZq
         X/NDXreScXPc8AQkHKJsgUaWmBF4XQPuJ3r+FjXFpvFVgBqlN3WJy5Q0wbdh3EuH+tX4
         rTdC8dkUBp5rxD/36i6TZbuEJOPXBl8LRnKSxM4zTGh7MJ1C3ivZAOL4yF6lk0ccZEQP
         uELg==
X-Gm-Message-State: AOJu0Ywh3qqXS8Wiko91X8uc3toGirTMIU9vix3sjyj4aw0wvnK1Jlb6
	7aRAz5cW7NZB8mMVIiIN4XaA6g0uLPG0C31xYZEy8L2msZTnkTjQhrcsK9/ED/rEOOByZxnhKT9
	ZWzhNPheUjuVCrXZzidr+ZaVWEOBOgbL4iRWZjQ==
X-Google-Smtp-Source: AGHT+IEGMCNP0G0xCVheJ+gTD7tZBSOrcJE8fmoQdXtQ15eqAS+sxnM5gYRJ2xHmPVMO4dKuU2bWul6xH035aZhtCn0=
X-Received: by 2002:a17:906:8314:b0:a59:a0eb:aeb0 with SMTP id
 a640c23a62f3a-a5a2d5d0a48mr611154866b.36.1715612594864; Mon, 13 May 2024
 08:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240508153131.94270-1-ninette@thehoodiefirm.com>
 <20240508153131.94270-3-ninette@thehoodiefirm.com> <3ebe931181412a352eb719d19cee95b0f2eebe23.camel@linuxfoundation.org>
 <CAG1aeW0ySPCCTd040nwjB0VEptrPdECrfLTCrG2OULEo7fChUA@mail.gmail.com> <7986c8ecde1f7852d5f9c3f24095c25f362475a7.camel@linuxfoundation.org>
In-Reply-To: <7986c8ecde1f7852d5f9c3f24095c25f362475a7.camel@linuxfoundation.org>
From: Ninette Adhikari <ninette@neighbourhood.ie>
Date: Mon, 13 May 2024 17:03:03 +0200
Message-ID: <CAG1aeW3nhLBubrkgYh=sigE-meXRvgYnnbOuMQQLSAQtyBhfVQ@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH 02/12] patch-status: add README.md file
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Alexander Kanavin <alex.kanavin@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org, engineering@neighbourhood.ie, 
	Alex Feyerke <hello@alexfeyerke.com>
Content-Type: multipart/alternative; boundary="0000000000004a1cee0618572f20"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 15:03:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/133

--0000000000004a1cee0618572f20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Richard and Alex for your quick response.
I tested the patches to an external email and sent the patches to the
mailing list again. Hope it works this time! Thanks for your patience:)

Best,
Ninette

On Mon, May 13, 2024 at 1:05=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2024-05-13 at 12:57 +0200, Ninette Adhikari wrote:
> > Hi Richard,
> >
> > This is really strange that the patches are coming through as empty
> > for you. Sorry about that! Just to be sure that we understood
> > correctly do you mean your email client actually doesn=E2=80=99t displa=
y the
> > patches? because we can see them in the email you replied to.
> > I followed this documentation to send the patches and it worked fine
> > for previous patches. We have also pushed the patches to the yocto
> > metrics contributors branch in case you can't view the email patches.
> >
> > Please let me know if there is any other way to share the patches or
> > if I should rensend the patches. Thanks so much!
>
> It isn't just my email client, the mailing list archives also show an
> empty message:
>
> https://lists.yoctoproject.org/g/yocto-patches/message/93
> https://lists.yoctoproject.org/g/yocto-patches/message/98
>
> This means the messages really are coming through as empty.
>
> Ideally you'd fix the issue and then resend but failing that you can
> share a git branch of the patches somewhere (github or contrib repos).
> It isn't how we normally review patches, it makes it harder for people.
>
> Cheers,
>
> Richard
>
>

--0000000000004a1cee0618572f20
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Thanks Richard and Alex for your qui=
ck response.</div><div>I tested the patches to an external email and sent t=
he patches to the mailing list again. Hope it works this time! Thanks for y=
our patience:)</div><div><br></div><div>Best,</div><div>Ninette<br></div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Mon, May 13, 2024 at 1:05=E2=80=AFPM Richard Purdie &lt;<a href=3D"mailto:=
richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxf=
oundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On Mon, 2024-05-13 at 12:57 +0200, Ninette Adhikari wrote:<br>
&gt; Hi Richard,<br>
&gt; <br>
&gt; This is really strange that the patches are coming through as empty<br=
>
&gt; for you. Sorry about that! Just to be sure that we understood<br>
&gt; correctly do you mean your email client actually doesn=E2=80=99t displ=
ay the<br>
&gt; patches? because we can see them in the email you replied to.<br>
&gt; I followed this documentation to send the patches and it worked fine<b=
r>
&gt; for previous patches. We have also pushed the patches to the yocto<br>
&gt; metrics contributors branch in case you can&#39;t view the email patch=
es.<br>
&gt; <br>
&gt; Please let me know if there is any other way to share the patches or<b=
r>
&gt; if I should rensend the patches. Thanks so much!<br>
<br>
It isn&#39;t just my email client, the mailing list archives also show an<b=
r>
empty message:<br>
<br>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/93" rel=
=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/yocto-pa=
tches/message/93</a><br>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/98" rel=
=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/yocto-pa=
tches/message/98</a><br>
<br>
This means the messages really are coming through as empty.<br>
<br>
Ideally you&#39;d fix the issue and then resend but failing that you can<br=
>
share a git branch of the patches somewhere (github or contrib repos).<br>
It isn&#39;t how we normally review patches, it makes it harder for people.=
<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div><br></div>

--0000000000004a1cee0618572f20--

