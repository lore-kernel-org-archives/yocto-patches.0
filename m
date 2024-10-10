Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F71CF11D3
	for <webhook@archiver.kernel.org>; Thu, 10 Oct 2024 11:58:49 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
 by mx.groups.io with SMTP id smtpd.web11.41591.1728561525876287979
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Oct 2024 04:58:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=cvku1vZM;
 spf=pass (domain: limonsoftware.com, ip: 209.85.219.179, mailfrom: anibal@limonsoftware.com)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e2914e73ea4so24031276.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Oct 2024 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1728561525; x=1729166325; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MPZm1aH2fAWH00CDymNsek2jyIW1ZoJJ9eR38N+lIYc=;
        b=cvku1vZMOgLQDuhbqvSuHiRAviceqLIIYFRcbVdPc3pqW8DForZ/unyQrzxoGiqugS
         42Oaw/20rFEve6EAe3Q4vAT21eZiCVxsFEoT/mdIu6WFSBHgJvuU7dnfDBq9rma2hOil
         QvT3bK/6R28HsvcyRi/8/7pT7l8ZTxd+sbtuCJy9o1BKFFEtoaXl5ENmxrhoBUhVQrMF
         I5xgGQd4MACImdIQuaUC1j7jdlBcy4BT754DI/l+nikT9QqGTn6OmDJJzF+HHPewC1qq
         kfrXEZMtaWhVXJ3uDgKFovW+ztg3HPx4DcIfZYiOwCKJaqoeReMYy5evms0B4y97zV0r
         9IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728561525; x=1729166325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPZm1aH2fAWH00CDymNsek2jyIW1ZoJJ9eR38N+lIYc=;
        b=mTpsjyDYpJc914IuyzJBuyPVyW10RZv0YSkMHA8fcv8IxnVNARewqVuZXWk3NX2yZQ
         DwN7y9Imx5gMUKk2ve5TO2pt8wCKb5pXCRKRSWshSTWHiashtwOqasakzNDjkT2J6A+m
         L/Pn3rxlP+D6GS93z4paP6N++L2afMLH7YK0Ltoov4BhgZCNrZcvkdYJdsQdVss1edMx
         OkSrK5ti+3C5Scdiuqc/JGNCfh6p0RtVlIQTAro9yTyr9Pyn7idIYlLBo9BARReDF8bm
         F+ONp940QhBrDOFEIOYKDbFZdE3OZ9LXFGuGZcGCUTFzF2OuAvFMW+CaRZUFyxR0Pa2I
         gPYQ==
X-Gm-Message-State: AOJu0YytxgZwCIY3gv0phiFyfbTUBrzA8u2oZWDcB15I/IqUFNso/e73
	GFegG1wqgtgPqh7Hf9d9Sm9PJEqaa42PZ1OKhSrIRhhWdly9GVf2iLHX5NBy9xmCwIv+XHCGbgv
	S38ldUZGLjOWXEUbdFryQxr1gEsH0MU5RPkXaMw==
X-Google-Smtp-Source: AGHT+IFgUWrblQKDyuuu8OVnPFlVy/V2ErGHi61iIwr2k/9nOljMXhpS0GjrDJYsKmR2Mvw4UgTtNrO6cTFDy+f/n2w=
X-Received: by 2002:a05:6902:1281:b0:e28:f6ba:b68d with SMTP id
 3f1490d57ef6-e28fe32e08fmr6053770276.5.1728561525040; Thu, 10 Oct 2024
 04:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241010113509.3874077-1-ross.burton@arm.com> <20241010113509.3874077-2-ross.burton@arm.com>
In-Reply-To: <20241010113509.3874077-2-ross.burton@arm.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Thu, 10 Oct 2024 05:58:34 -0600
Message-ID: <CAOU5ZMsXQuSZNL59-kLGSxAdCVJDuDY_q9ZeLqMzAhYvMk8TEw@mail.gmail.com>
Subject: Re: [ptest-runner][PATCH 2/2] Makefile: use pkg-config to obtain
 libcheck flags
To: Ross Burton <ross.burton@arm.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000ac441a06241e17b9"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Oct 2024 11:58:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/701

--000000000000ac441a06241e17b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied,

Thanks!,
Anibal

On Thu, Oct 10, 2024 at 5:35=E2=80=AFAM Ross Burton <ross.burton@arm.com> w=
rote:

> Don't hardcode the linkage, instead use pkg-config to find the required
> flags.
>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
>  Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 08bc19c..662ced7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -27,8 +27,8 @@ EXECUTABLE=3Dptest-runner
>  TEST_SOURCES=3Dtests/main.c tests/ptest_list.c tests/utils.c $(BASE_SOUR=
CES)
>  TEST_OBJECTS=3D$(TEST_SOURCES:.c=3D.o)
>  TEST_EXECUTABLE=3Dptest-runner-test
> -TEST_LDFLAGS=3D-lm -lrt -lpthread
> -TEST_LIBSTATIC=3D-lcheck -lsubunit -lutil
> +TEST_CFLAGS=3D$(shell pkg-config --cflags check)
> +TEST_LDFLAGS=3D$(shell pkg-config --libs check)
>
>  TEST_DATA=3D$(shell echo `pwd`/tests/data)
>
> @@ -40,7 +40,7 @@ $(EXECUTABLE): $(OBJECTS)
>  tests: $(TEST_SOURCES) $(TEST_EXECUTABLE)
>
>  $(TEST_EXECUTABLE): $(TEST_OBJECTS)
> -       $(CC) $(LDFLAGS) $(TEST_OBJECTS) -o $@ $(TEST_LIBSTATIC)
> $(TEST_LDFLAGS)
> +       $(CC) $(LDFLAGS) $(TEST_OBJECTS) -o $@ $(TEST_CFLAGS)
> $(TEST_LDFLAGS)
>
>  check: $(TEST_EXECUTABLE)
>         PATH=3D.:$(PATH) ./$(TEST_EXECUTABLE) -d $(TEST_DATA)
> --
> 2.34.1
>
>

--000000000000ac441a06241e17b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied,=C2=A0<div><br></div><div>Thanks!,</div><div>Aniba=
l</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, Oct 10, 2024 at 5:35=E2=80=AFAM Ross Burton &lt;<a href=3D"m=
ailto:ross.burton@arm.com">ross.burton@arm.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Don&#39;t hardcode the linkag=
e, instead use pkg-config to find the required<br>
flags.<br>
<br>
Signed-off-by: Ross Burton &lt;<a href=3D"mailto:ross.burton@arm.com" targe=
t=3D"_blank">ross.burton@arm.com</a>&gt;<br>
---<br>
=C2=A0Makefile | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/Makefile b/Makefile<br>
index 08bc19c..662ced7 100644<br>
--- a/Makefile<br>
+++ b/Makefile<br>
@@ -27,8 +27,8 @@ EXECUTABLE=3Dptest-runner<br>
=C2=A0TEST_SOURCES=3Dtests/main.c tests/ptest_list.c tests/utils.c $(BASE_S=
OURCES)<br>
=C2=A0TEST_OBJECTS=3D$(TEST_SOURCES:.c=3D.o)<br>
=C2=A0TEST_EXECUTABLE=3Dptest-runner-test<br>
-TEST_LDFLAGS=3D-lm -lrt -lpthread<br>
-TEST_LIBSTATIC=3D-lcheck -lsubunit -lutil<br>
+TEST_CFLAGS=3D$(shell pkg-config --cflags check)<br>
+TEST_LDFLAGS=3D$(shell pkg-config --libs check)<br>
<br>
=C2=A0TEST_DATA=3D$(shell echo `pwd`/tests/data)<br>
<br>
@@ -40,7 +40,7 @@ $(EXECUTABLE): $(OBJECTS)<br>
=C2=A0tests: $(TEST_SOURCES) $(TEST_EXECUTABLE)<br>
<br>
=C2=A0$(TEST_EXECUTABLE): $(TEST_OBJECTS)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(CC) $(LDFLAGS) $(TEST_OBJECTS) -o $@ $(TEST_L=
IBSTATIC) $(TEST_LDFLAGS)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(CC) $(LDFLAGS) $(TEST_OBJECTS) -o $@ $(TEST_C=
FLAGS) $(TEST_LDFLAGS)<br>
<br>
=C2=A0check: $(TEST_EXECUTABLE)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PATH=3D.:$(PATH) ./$(TEST_EXECUTABLE) -d $(TEST=
_DATA)<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000ac441a06241e17b9--

