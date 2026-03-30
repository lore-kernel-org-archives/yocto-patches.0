Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8D4FF493D
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 04:17:53 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43207.1774844269111057303
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 29 Mar 2026 21:17:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gAW0sTXr;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: ticotimo@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so4461058e87.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 29 Mar 2026 21:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774844267; cv=none;
        d=google.com; s=arc-20240605;
        b=kobmHsEXbMEYjTJMmgjtJ3iphWGWRZQWRZ6c7KyE2R2OGfAwHYtpJ79RX7ubgMcBEj
         Q0p0vP+UuFbEIhTI0Mkm0I/YhTLB61SE6GI36WNh/9BncwJPJGRPYgjr1lUCcEvT/8xu
         5/yTE0+4zZmQ2eCfJf3MnVNIzoVWXoVyg/gPRjf1pYp+BlWX32vZB5vegzOZzPDZ73AJ
         5wX/C1WN8fP7a7KSOOFUDJDrWOYjlOs8SeM6wtqjWdp0QmqFfqI3xNUCODdWK/wjpAuU
         vw4CFTRMvOHgkifJ3BPqI7S7T+EzbJw+Myv/jGS54u27R5PExaMmPoYhn7nnqKowvfuD
         CeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nJ5jRc97B1oqo7LaLXywtxTMRjvd24XBn5mJ1BIrSrI=;
        fh=jrEbHcM9NVatGxI25/yVqhLCFNkcjzfu6ylXCc39wAY=;
        b=MfD3ShhakvGfCetYiaBHqowLqs/tOvEN5rjNR64AEXaLTHO2cbfco5Tb78SfZ88uD6
         bxZLZ8nb12Q/dgTccqguxGqjcdhMnIxdYwcIbm45yPSi9IN67y9f0JexjGlAQL7yPhKn
         06HkP+SB/R2PRCY5FT8FKT/y6Tkop4GzXGLoaYCrqJSaVz60p9p9Zm34pWMC47cy7Iil
         grSJkHXvp/d1fBBluHmNXPXBc/xaGn05zeOVD46i4S2UW4zZzL9csQXwGq6nyYrfR7kh
         yU0/iY108SBe7uvyYNNvDUPTPtUy3tRkA3dSWufRnIUy1uR91mNHlMehdZuvgHuXvAh9
         w/ww==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774844267; x=1775449067; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ5jRc97B1oqo7LaLXywtxTMRjvd24XBn5mJ1BIrSrI=;
        b=gAW0sTXrPFxqLXtrS4FQ02CGveVPNN7+kCj7VBYcH6D0rb9qksb1eksjwjQrOtGrvR
         osoFVjA3vv9bUG5SGk1tbav8a+c8SfEPMLDx9byInu+ADPbB7BqUMOEX/KXHAezyrS7R
         lWqBv12538B7lRqQ6RdffVyA8sKPvOBFCqHCwf9j18uhLsuT9IzrtxlXUKJwngTRnItR
         QeUmW3yeepTwPyqqXpnge+nMyQUm2sIKwZtDzsI5nFditn2/Tynl85PY5qQtY+XY9w/o
         iZJmU+OP9id/5gTG6b491Dp8QrLyioIgCRPHE+cttx2oW/kab41zaX4qMdrH2tklwnwO
         QBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774844267; x=1775449067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJ5jRc97B1oqo7LaLXywtxTMRjvd24XBn5mJ1BIrSrI=;
        b=sJZl/cXBQPHtsywhFuibSoYOqmANBCzq9yxghymCnCcBBWkN5XLGapmFSvLZsQqMPL
         L/sns80Mxvggfd0NVyEDI8DNGvGPUC93GM6gNOdmORWSyVt9NV9aAOKq4yiG0PJUaKW0
         kB+KFj+iKwP6W2a1VZyDjNpdG9LEJiVr15IMTQ5fUDMpu5yJF66Emo2qBZz4ISYuWsfb
         n6S29YUDnB/evLn1M3cXAtTjYZNDkB7Ghx/7MT/P729ARZtg2Wcgc0svTubF6Wj/dMs+
         Gd7/iLJGXtWHm7xg3djVzSccAis+VzkaoqYK6ZKffPmI5MYf2tK3rqblvvSiFJS+VQo/
         iO9g==
X-Gm-Message-State: AOJu0Yx67uSh8GWZGzlFRXa8I7iJyTGrtaHMZaD0VuoQ1MM1xM7hOX5f
	dMZfyHQfnJAAEl1H3bsLajex3inR0prEGMZb0fA6PS9aiq607OveHqjKqnmSCjVDP2hS+tCxlE8
	HRp+8I/0NwrLJPXLZTk4gYqpKBI/eg0px+g==
X-Gm-Gg: ATEYQzzFcCiLIlCpbH38vlWm6orF/1XNFMwvuui2xW5Q92hpECDHoetib5v6Vnd+NZk
	hBccPx+NkyEyejGbUBHKjwXDh3gemGi906ql3FOpGT7cSe4h6oBXGiekgmUDnxiCu8V0fsv2e1I
	oM2aXsx0tUwP51WPBoVgoekm2I7VB944sIfaHF+yBfCN6aBHDJGc6QIn4evn1BqoguRZBkAuQNo
	DLiZXrL5huS6KMagEXoHEflq+5lXKYAjaCFH42mF2k2Vzc4xS/dGrDC9wLMRPIZqg7vSU//hj3W
	gSl2B/Q=
X-Received: by 2002:a05:6512:246:b0:5a2:b0be:f40c with SMTP id
 2adb3069b0e04-5a2b0bef5b8mr1577130e87.16.1774844266427; Sun, 29 Mar 2026
 21:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260329171109.34764-1-piotr@qbee.io> <20260329171109.34764-2-piotr@qbee.io>
In-Reply-To: <20260329171109.34764-2-piotr@qbee.io>
From: Tim Orling <ticotimo@gmail.com>
Date: Sun, 29 Mar 2026 21:17:33 -0700
X-Gm-Features: AQROBzDb3crQaPHCxp_SL9VjH6du-43sNHh3ONwA8zqjfV3DaUDm9iKaHVZmUCE
Message-ID: <CANx9H-DZufhnj2WfZVZEEWxHqdjEeMG_1DxPZaWT5wbC7QsYLw@mail.gmail.com>
Subject: Re: [yocto-patches] [layerindex-web][PATCH 2/3] Update settings.py to
 work with Django 5.2
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?Q?Piotr_Buli=C5=84ski?= <piotr@qbee.io>
Content-Type: multipart/alternative; boundary="000000000000083b1d064e3622ca"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 04:17:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3579

--000000000000083b1d064e3622ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged to master. Thank you.

On Sun, Mar 29, 2026 at 10:11=E2=80=AFAM Piotr Buli=C5=84ski via lists.yoct=
oproject.org
<piotr=3Dqbee.io@lists.yoctoproject.org> wrote:

> 1. Remove USE_L10N, as it's removed since Django version 5.0
> 2. Set USE_TZ =3D False, as in Django 5.0 the default was changed to True
>
> Signed-off-by: Piotr Buli=C5=84ski <piotr@qbee.io>
> ---
>  docker/settings.py | 6 +++---
>  settings.py        | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/docker/settings.py b/docker/settings.py
> index 9a96e83..fdf09de 100644
> --- a/docker/settings.py
> +++ b/docker/settings.py
> @@ -45,9 +45,9 @@ SITE_ID =3D 1
>  # to load the internationalization machinery.
>  USE_I18N =3D True
>
> -# If you set this to False, Django will not format dates, numbers and
> -# calendars according to the current locale
> -USE_L10N =3D True
> +# As of Django 5.0 the defaults has changed to True, so set it to False
> to avoid
> +# timezone-aware datetimes which require more complex handling in the
> codebase.
> +USE_TZ =3D False
>
>  # Avoid specific paths
>  BASE_DIR =3D os.getenv('BASE_DIR', os.path.dirname(__file__))
> diff --git a/settings.py b/settings.py
> index fa303b1..bbc5aca 100644
> --- a/settings.py
> +++ b/settings.py
> @@ -45,9 +45,9 @@ SITE_ID =3D 1
>  # to load the internationalization machinery.
>  USE_I18N =3D True
>
> -# If you set this to False, Django will not format dates, numbers and
> -# calendars according to the current locale
> -USE_L10N =3D True
> +# As of Django 5.0 the defaults has changed to True, so set it to False
> to avoid
> +# timezone-aware datetimes which require more complex handling in the
> codebase.
> +USE_TZ =3D False
>
>  # Avoid specific paths
>  BASE_DIR =3D os.path.dirname(__file__)
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3576):
> https://lists.yoctoproject.org/g/yocto-patches/message/3576
> Mute This Topic: https://lists.yoctoproject.org/mt/118566580/924729
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/1023=
951714/xyzzy
> [ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000083b1d064e3622ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged to master. Thank you.</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, =
Mar 29, 2026 at 10:11=E2=80=AFAM Piotr Buli=C5=84ski via <a href=3D"http://=
lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;piotr=3D<a href=3D"m=
ailto:qbee.io@lists.yoctoproject.org">qbee.io@lists.yoctoproject.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">1. Remo=
ve USE_L10N, as it&#39;s removed since Django version 5.0<br>
2. Set USE_TZ =3D False, as in Django 5.0 the default was changed to True<b=
r>
<br>
Signed-off-by: Piotr Buli=C5=84ski &lt;<a href=3D"mailto:piotr@qbee.io" tar=
get=3D"_blank">piotr@qbee.io</a>&gt;<br>
---<br>
=C2=A0docker/settings.py | 6 +++---<br>
=C2=A0settings.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 6 +++---<br>
=C2=A02 files changed, 6 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/docker/settings.py b/docker/settings.py<br>
index 9a96e83..fdf09de 100644<br>
--- a/docker/settings.py<br>
+++ b/docker/settings.py<br>
@@ -45,9 +45,9 @@ SITE_ID =3D 1<br>
=C2=A0# to load the internationalization machinery.<br>
=C2=A0USE_I18N =3D True<br>
<br>
-# If you set this to False, Django will not format dates, numbers and<br>
-# calendars according to the current locale<br>
-USE_L10N =3D True<br>
+# As of Django 5.0 the defaults has changed to True, so set it to False to=
 avoid<br>
+# timezone-aware datetimes which require more complex handling in the code=
base.<br>
+USE_TZ =3D False<br>
<br>
=C2=A0# Avoid specific paths<br>
=C2=A0BASE_DIR =3D os.getenv(&#39;BASE_DIR&#39;, os.path.dirname(__file__))=
<br>
diff --git a/settings.py b/settings.py<br>
index fa303b1..bbc5aca 100644<br>
--- a/settings.py<br>
+++ b/settings.py<br>
@@ -45,9 +45,9 @@ SITE_ID =3D 1<br>
=C2=A0# to load the internationalization machinery.<br>
=C2=A0USE_I18N =3D True<br>
<br>
-# If you set this to False, Django will not format dates, numbers and<br>
-# calendars according to the current locale<br>
-USE_L10N =3D True<br>
+# As of Django 5.0 the defaults has changed to True, so set it to False to=
 avoid<br>
+# timezone-aware datetimes which require more complex handling in the code=
base.<br>
+USE_TZ =3D False<br>
<br>
=C2=A0# Avoid specific paths<br>
=C2=A0BASE_DIR =3D os.path.dirname(__file__)<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3576): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/3576" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/3576</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/118566580/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/118566580/924729</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13169857/924729/1023951714/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/10239517=
14/xyzzy</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticot=
imo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--000000000000083b1d064e3622ca--

