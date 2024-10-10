Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E065CF11D5
	for <webhook@archiver.kernel.org>; Thu, 10 Oct 2024 11:58:59 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web11.41592.1728561531058722871
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Oct 2024 04:58:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=sjqiE4qm;
 spf=pass (domain: limonsoftware.com, ip: 209.85.219.171, mailfrom: anibal@limonsoftware.com)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e290d5f83bcso559894276.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Oct 2024 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1728561530; x=1729166330; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rp9Ds4b9bk7/Ke+ymOXzuiFslSBq3XuQpPtdq53P6tc=;
        b=sjqiE4qmDgd75hSq8S9jzeQ5vSsU6N0ap89UJ9WqCR5DZVq4iT0ECEMJXspOR6sShV
         bsJOSJpaXQQIwNTPqPgmFEZwUZrPX099GkqGH/4lv7g0ZOPpCW7DEdgyxbktvAYoxuyp
         L0K452yh/iNsjFvNROFeCEeVYEIDhE9+DW/WrwQnEOzj6BU0VtbeYjG8EP1nh/zbdQ0M
         U8LsMAsmT3XSZ4Ou7/F0T0aGo3p4KHC54qjCfSSkrQZ6h0uox6GIETQXqV739Tp8FKW8
         3exbXfQbpio0CcB2tKCtdVFQ9jlrb3meZoislfqAM8hhYFT+do+zxuQssTQqT5j+7XMF
         PIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728561530; x=1729166330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rp9Ds4b9bk7/Ke+ymOXzuiFslSBq3XuQpPtdq53P6tc=;
        b=X/o/kJItMRliTAZWEJT4xV053dXOVIcQHM+6EjUCFsVJvJe2MmBs6WeX42BxCdI5iP
         E3UuZZeW/r1b1azkDIig7hampkNhAgKeXsBrC9rxbC2w4G4vXvhDhT8jgdOhwktVEdbQ
         +XnV8m/Rx2ps1bRTEMUkREfI85sZNlBUG48txJ7JIzjRMhrX+4hKcifpBkMDzC5zhKrx
         RENKd8pg+YM31W3KYFuCf4KC3x0Sew9fV/7XM9DyqcdOaXKdLQ9uYpiXQiciQGRyjPD8
         e4E8FZ538CmRsVMaXt8aSen83SDAiIoctLi8MyCTgiKk1I5ix+UTqIujH2CW1+c2kFFD
         8j5w==
X-Gm-Message-State: AOJu0YwjWphODY4oX0mwhg3Ri6nip8yp2al4OSO3BTvG+HIXgER8M4wF
	9dBf6fnfn2wm57PYhF63quGc/p7vM0p2zUlY+DqksHhTAD+8GT86/tSeszwIgFQvK9ist+g5sXE
	H2xryzIrM3erpwxlRVkKJH8UIuzaWz9R2bsVw6GNjsz81GmiqyJc=
X-Google-Smtp-Source: AGHT+IHF52UntBU4SGQtMRzro655mPp6VXGVnsILbMOy1EMizcyS3K4ncJ2gT2APr4BoGrwHZpXjaRNARv9aJtEWXmg=
X-Received: by 2002:a05:6902:2788:b0:e29:1374:6dff with SMTP id
 3f1490d57ef6-e291374798amr379485276.33.1728561530280; Thu, 10 Oct 2024
 04:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241010113509.3874077-1-ross.burton@arm.com>
In-Reply-To: <20241010113509.3874077-1-ross.burton@arm.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Thu, 10 Oct 2024 05:58:39 -0600
Message-ID: <CAOU5ZMsaW0xJGZ2Ddh+VsQ1rd1dNuMYgZbDruVzMRUeZjmCTEQ@mail.gmail.com>
Subject: Re: [ptest-runner][PATCH 1/2] Makefile: remove redundant rule
To: Ross Burton <ross.burton@arm.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000fc413206241e17cd"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Oct 2024 11:58:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/702

--000000000000fc413206241e17cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied,

Thanks!,
Anibal

On Thu, Oct 10, 2024 at 5:35=E2=80=AFAM Ross Burton <ross.burton@arm.com> w=
rote:

> Make already knows how to build a .o from a .c.
>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
>  Makefile | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 168cf5a..08bc19c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -45,9 +45,6 @@ $(TEST_EXECUTABLE): $(TEST_OBJECTS)
>  check: $(TEST_EXECUTABLE)
>         PATH=3D.:$(PATH) ./$(TEST_EXECUTABLE) -d $(TEST_DATA)
>
> -.c.o:
> -       $(CC) $(CFLAGS) -c $< -o $@
> -
>  clean:
>         rm -rf $(EXECUTABLE) $(OBJECTS) $(TEST_EXECUTABLE) $(TEST_OBJECTS=
)
>
> --
> 2.34.1
>
>

--000000000000fc413206241e17cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied,=C2=A0<div><br></div><div>Thanks!,</div><div>Aniba=
l</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, Oct 10, 2024 at 5:35=E2=80=AFAM Ross Burton &lt;<a href=3D"m=
ailto:ross.burton@arm.com">ross.burton@arm.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Make already knows how to bui=
ld a .o from a .c.<br>
<br>
Signed-off-by: Ross Burton &lt;<a href=3D"mailto:ross.burton@arm.com" targe=
t=3D"_blank">ross.burton@arm.com</a>&gt;<br>
---<br>
=C2=A0Makefile | 3 ---<br>
=C2=A01 file changed, 3 deletions(-)<br>
<br>
diff --git a/Makefile b/Makefile<br>
index 168cf5a..08bc19c 100644<br>
--- a/Makefile<br>
+++ b/Makefile<br>
@@ -45,9 +45,6 @@ $(TEST_EXECUTABLE): $(TEST_OBJECTS)<br>
=C2=A0check: $(TEST_EXECUTABLE)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PATH=3D.:$(PATH) ./$(TEST_EXECUTABLE) -d $(TEST=
_DATA)<br>
<br>
-.c.o:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(CC) $(CFLAGS) -c $&lt; -o $@<br>
-<br>
=C2=A0clean:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf $(EXECUTABLE) $(OBJECTS) $(TEST_EXECUTAB=
LE) $(TEST_OBJECTS)<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000fc413206241e17cd--

