Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8CDFF493E
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 04:18:33 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43213.1774844305463656675
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 29 Mar 2026 21:18:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=KCvfq7h+;
 spf=pass (domain: gmail.com, ip: 209.85.167.44, mailfrom: ticotimo@gmail.com)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so4641742e87.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 29 Mar 2026 21:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774844303; cv=none;
        d=google.com; s=arc-20240605;
        b=GheTQDJWhce/QKWroSOlj7iExayXnWY6EJBj0/PyOGCg5+JPU8C3fpZ9MxVL0IhaJ5
         9wc/+yu41E07nn1koGwwKGtaHKgbkiZa6gerie+axHJnPnq6amU2G1aHUP6bLSRClfU2
         n+Lk5K6kx/fw+XpUVYK0PdbEGdlcypUF45BpluUu08HIrkfUe16TZeknN9Vqs1npytWN
         TqUveACkI4RBfBUKhkkKfDIY1bCtMLqQa07bl69VIAKon06WZr1UQlcKS10cOSV9g4tG
         NJk5mZNXvcWqdbGAZBtBgmXTS/Bj0xeD7LE0171ECwqhSvmUZV2WnAl6cSJrqSwZrH0F
         btmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Td4GipI+PemxZoEX0fMHXRAL2TTPxHiOANoyPiLi6qo=;
        fh=jrEbHcM9NVatGxI25/yVqhLCFNkcjzfu6ylXCc39wAY=;
        b=ONyQpyEl+Vx6qCH6FWITEHAegbTV5kIE7mnYkH9FAg7z8VukU9LkHrkor+qcF87bpX
         I4eOG1HgRzv4GudKxgMuKWC6FCK9J2X+obt1cUe8VBVHcrOf+GQZoNzgyMf6tPaXR+0u
         mbjiNGYO2bKY1C+1x6qfCksVJWItFVpmUB0Tc9Akodml1lSUh7RIgvgZ1N3H9GwoFrDu
         AAwwSvwZgZZJfrrl7YKx1fAK7wqGJZPplcjPLaFASctu4H5XteCD/O8jbJhFcqX6rPWm
         4+MvuVH4vPao86GP3mJTlGiZSmv94NnJvYv5aZ7bJTnEwrDgbOloyMjKpA9enyhJiAC1
         xYTw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774844303; x=1775449103; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Td4GipI+PemxZoEX0fMHXRAL2TTPxHiOANoyPiLi6qo=;
        b=KCvfq7h+M6r52KcSPSuyF/cINedTV8rWI5lhJQqF7gS7ZA6Q+7Id91/YswQGzAampW
         RwlJm6/UWTHBqrmQEbLSOYHd+M1nTmi3p+uxFHeGcl2ML5BOyJ37pooCYSk9xbbtYux+
         lI3AIvwnhDBYAGtPTqn0nkZNAaWU9vtWKMTy46g4f28XKJqKL//bw1jWaa48J9uJKLmH
         YliWuiR+zN1GAI664UYykU8PVeCjtrirKiBRndHKcCvNVnV6BEJym/hMsTDA5+t7qzp8
         A6O+LWvOgZV8H1udbEntEpOC9aWdfcgmaurpPgKmI8Afj0ELbqOHeJ+t8cgBB16ipDlG
         YZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774844303; x=1775449103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td4GipI+PemxZoEX0fMHXRAL2TTPxHiOANoyPiLi6qo=;
        b=fZsQZCGe+lMNYoO0c6afE/cUKe/FXF67UbzhYNFTGmcGsITd1xrmhpgNH5+KdgZfAV
         Ndz1j/HX+nhMgtD4UI39Cf4qLGyzm2nxACCK7Py+BT6U8O1FRD40xbtI2xMKDiVrLt+e
         SUk3N/JjmSfsUGMgrmJjAWMrXoz9OJ72DHqg6s59QlXCA4E4uQ0RlbYIaUI5Km4A48LG
         FKltoZNdVf0RQl56Be+VBrZGJGWFHUPUfc+0MQskqLeIHoyeRyBcJSH8Q7dmDeFOubsm
         ut6abKgIXPSihkBwAdU0VuWtFTx04d7BvXLVZq+OC4uF5W1skPu+q3pECVXz3ttP8rXS
         1Elg==
X-Gm-Message-State: AOJu0Yy8cVbzF6Qw1YIHw7dXxYUtM8DwtzlFX8IxE0L85tG3f+5N+9cD
	GMVwdSMIKA5RwkqXWKZJlSs9vArkNEX1oRWk7tR2wUR5J45cct+PJgMvAHGKvqs7032pyvYnrbf
	DbQEXFw9Mhlk5vzsoDEJJXWHLQKhD1EWK9A==
X-Gm-Gg: ATEYQzwQWCHtS9HLn0ffywYTkhXstGAxxubROdEHFZbJLUVHw5lO0hcRooc5qPUJjk0
	oX7ZVZE5p30aIaha9l3USueM93UQH6cYo18eGNr9VMdzz/zsggE3F1nUYehpoAu06LTx6i/6rOI
	CnvgoYvWecxG/5I/ACN5KhKBoVeP/Igoj8wV+scqq9yagZrhyKjYWydmQkj09DC8ji2nk+CKpef
	vQBQozcM/v0TLfaaMFwXVhlFL74ajwdoaSMzUfJQv+TRLBLjnBWp5GyQ869gN+fSjcYY8OayuOQ
	bcD3sfU=
X-Received: by 2002:a05:6512:3d27:b0:5a2:851a:264a with SMTP id
 2adb3069b0e04-5a2ab7f015bmr4150839e87.10.1774844302955; Sun, 29 Mar 2026
 21:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260329171109.34764-1-piotr@qbee.io> <20260329171109.34764-3-piotr@qbee.io>
In-Reply-To: <20260329171109.34764-3-piotr@qbee.io>
From: Tim Orling <ticotimo@gmail.com>
Date: Sun, 29 Mar 2026 21:18:11 -0700
X-Gm-Features: AQROBzDPo29ocmAFSQBiXVEy9_4zZETsQEruRMC6ofSsPAY-_BA_FH5zg6m-z7Y
Message-ID: <CANx9H-DW5Q+EW1t+0jjNqR8Ugh4kaqkt4EHJDeZ7oVKQ1umuGA@mail.gmail.com>
Subject: Re: [yocto-patches] [layerindex-web][PATCH 3/3] Update Django from
 4.2 LTS to 5.2 LTS
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?Q?Piotr_Buli=C5=84ski?= <piotr@qbee.io>
Content-Type: multipart/alternative; boundary="00000000000035985e064e3624f8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 04:18:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3580

--00000000000035985e064e3624f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged to master. Thank you.

On Sun, Mar 29, 2026 at 10:11=E2=80=AFAM Piotr Buli=C5=84ski via lists.yoct=
oproject.org
<piotr=3Dqbee.io@lists.yoctoproject.org> wrote:

> This change also updates other dependencies, to ensure compatibility with
> the new version of Django.
>
> Signed-off-by: Piotr Buli=C5=84ski <piotr@qbee.io>
> ---
>  requirements.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/requirements.txt b/requirements.txt
> index 767d4bc..0aea1f6 100644
> --- a/requirements.txt
> +++ b/requirements.txt
> @@ -10,17 +10,17 @@ click-plugins=3D=3D1.1.1
>  click-repl=3D=3D0.3.0
>  confusable-homoglyphs=3D=3D3.3.1
>  diff-match-patch=3D=3D20230430
> -Django>=3D4.2.28,<4.3
> +Django>=3D5.2,<5.3
>  django-appconf=3D=3D1.0.6
> -django-axes=3D=3D6.5.1
> +django-axes=3D=3D7.1.0
>  django-cors-headers=3D=3D4.4.0
>  django-ipware=3D=3D7.0.1
>  django-ranged-response=3D=3D0.2.0
> -django-registration=3D=3D3.4
> +django-registration=3D=3D5.2.1
>  django-reversion=3D=3D5.1.0
>  django-reversion-compare=3D=3D0.17.0
>  django-simple-captcha=3D=3D0.6.3
> -djangorestframework=3D=3D3.15.2
> +djangorestframework=3D=3D3.16.1
>  gitdb=3D=3D4.0.11
>  GitPython=3D=3D3.1.43
>  kombu=3D=3D5.4.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3577):
> https://lists.yoctoproject.org/g/yocto-patches/message/3577
> Mute This Topic: https://lists.yoctoproject.org/mt/118566582/924729
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/1023=
951714/xyzzy
> [ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--00000000000035985e064e3624f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged to master. Thank you.</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, =
Mar 29, 2026 at 10:11=E2=80=AFAM Piotr Buli=C5=84ski via <a href=3D"http://=
lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;piotr=3D<a href=3D"m=
ailto:qbee.io@lists.yoctoproject.org">qbee.io@lists.yoctoproject.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This ch=
ange also updates other dependencies, to ensure compatibility with the new =
version of Django.<br>
<br>
Signed-off-by: Piotr Buli=C5=84ski &lt;<a href=3D"mailto:piotr@qbee.io" tar=
get=3D"_blank">piotr@qbee.io</a>&gt;<br>
---<br>
=C2=A0requirements.txt | 8 ++++----<br>
=C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/requirements.txt b/requirements.txt<br>
index 767d4bc..0aea1f6 100644<br>
--- a/requirements.txt<br>
+++ b/requirements.txt<br>
@@ -10,17 +10,17 @@ click-plugins=3D=3D1.1.1<br>
=C2=A0click-repl=3D=3D0.3.0<br>
=C2=A0confusable-homoglyphs=3D=3D3.3.1<br>
=C2=A0diff-match-patch=3D=3D20230430<br>
-Django&gt;=3D4.2.28,&lt;4.3<br>
+Django&gt;=3D5.2,&lt;5.3<br>
=C2=A0django-appconf=3D=3D1.0.6<br>
-django-axes=3D=3D6.5.1<br>
+django-axes=3D=3D7.1.0<br>
=C2=A0django-cors-headers=3D=3D4.4.0<br>
=C2=A0django-ipware=3D=3D7.0.1<br>
=C2=A0django-ranged-response=3D=3D0.2.0<br>
-django-registration=3D=3D3.4<br>
+django-registration=3D=3D5.2.1<br>
=C2=A0django-reversion=3D=3D5.1.0<br>
=C2=A0django-reversion-compare=3D=3D0.17.0<br>
=C2=A0django-simple-captcha=3D=3D0.6.3<br>
-djangorestframework=3D=3D3.15.2<br>
+djangorestframework=3D=3D3.16.1<br>
=C2=A0gitdb=3D=3D4.0.11<br>
=C2=A0GitPython=3D=3D3.1.43<br>
=C2=A0kombu=3D=3D5.4.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3577): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/3577" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/3577</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/118566582/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/118566582/924729</a><br>
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

--00000000000035985e064e3624f8--

