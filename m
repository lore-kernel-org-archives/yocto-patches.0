Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B63D1CDC6
	for <webhook@archiver.kernel.org>; Tue,  9 Dec 2025 09:00:10 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3390.1765270808337317120
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Dec 2025 01:00:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fbxTt97/;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88242fc32c9so61842686d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Dec 2025 01:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765270807; x=1765875607; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=od39g7Rx45JGHrNyOA1GywjcMHEcuZLkK5mMvnnKSWw=;
        b=fbxTt97/auGMWOk58+a5D+XXX7yi71LmJ2HUerAY9R7ll9PMlGI2kSnOLuys5omszJ
         rYSkc79XCVBqqUGFqt+xtONA+X3BDLt5OoOeH6j8Qvl7hqhdBzwj5JhMjD9qgkYrQcC1
         /+JYR1Gfv3hNE9I1Gf9c7APOph9TVDZ+Vic7WoG7vPLTBNyXIkTRFyVwrXU/kJY578ih
         8K+xSmt4fLhA7/Og2DaT8YT9/uNue8yL/8896kALqs+8LLXoww+9E0DDWTHK87Hjo2ZM
         jLa6H4MRv4pyEjtEy58sAEvWJHSXoWhWLiH6AqbjSVAltEDhX0v5mdwI75xqFGeaerr1
         N5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765270807; x=1765875607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=od39g7Rx45JGHrNyOA1GywjcMHEcuZLkK5mMvnnKSWw=;
        b=wufHuzxVIcMoT0RHXuAUGGRek11V0r7C1qi4orP7VZEcCsGA6heef/S7VWbt2OXh4Q
         Ae+pH0EB6QJmMsktgReQmQnuY/vuL8JjaPoyrn2lOFbJCLNjpyZRnlZnx5ksZC3bHzDh
         /Ea1HGRV7WMwp1syEFYEolG+fjtLQBJDPjCAxXMhYSMyGUKAt4bSMKw4vj94CYNY1Vr+
         py39UV1TnYbDVupTXd8agq7+f6RE6ziv8N+Q5Zw9VDU4Gc4bJHG/9yt4kimKu/JS857I
         ubEoB2g8/LpF3v4JFTBY4WF17qPGqmi8UCFjDoaDXJHn0v/1jKJwObo2Gks1bboCP++D
         9Evg==
X-Gm-Message-State: AOJu0YycxsRzcWkj99zwBOUue00lIqjF+yaMlgFEH7+6QeB1E5cfB9HP
	o2lgjfPY9hHKW3sB0/w1xRun5OrxHtxIkHndOzFqyYAmvD+nPMGzxWfCgVxGifR693K07zUezQP
	1t9XGjuGrLaGXUd6YasXzUlGNaRu5a40dcg==
X-Gm-Gg: ASbGncthJfvsJ6GYIQODuZ3iHBF9KO88JPlB6Et0iOTx1FZccsF6fV1MiJpvbg2bYGe
	536QVYKt2g5VLbZ90HYVTHGl4bAOtiapQCWHrqdhqRT/1BhMyyB7FIzYiuyZMVJyDAyfNrK0Fby
	cjPfv95pIfIzW4+zhA3uqGrzfbi36DmVN9Vb7AaQlz9kONA7wZB6ySzAgrQyqwFLIKLwTPZUWFs
	lKrOSgNZnZ7zz5L0qtdUUzvybtC9/TfxyrYXRLs7/G1G3vyYW7NZDMM+o/bLBWnIGdQVgJzhkoD
	zsMBVxmEEIwIITQfB3SLSvcW7Z5y+A==
X-Google-Smtp-Source: AGHT+IFNW50UFrM1Qr8NfVTfI6f9WF/zqusJyCJDY5oDJLrjszzvs9/DPml/nOh/EJdkkkuoi2gPFYjI9jF6ec4z89k=
X-Received: by 2002:a05:6214:1c49:b0:882:7571:c012 with SMTP id
 6a1803df08f44-8883dc21f12mr175730506d6.55.1765270807217; Tue, 09 Dec 2025
 01:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20251208223609.378679-1-t.f.g.geelen@gmail.com>
In-Reply-To: <20251208223609.378679-1-t.f.g.geelen@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 9 Dec 2025 09:59:55 +0100
X-Gm-Features: AQt7F2rxxXnOxRLX25MZpOVkmhYEtU6quDh-qAQKAn8eeK-fR5GbhJFLsbLaNTE
Message-ID: <CANNYZj9LOA+0fyjN_hVnN9kH1CX8xyrR1A9Sky4FG8J6Q_Dg3A@mail.gmail.com>
Subject: Re: [auh][PATCH 1/2] testimage: update package installation logic to
 use groups
To: Tom Geelen <t.f.g.geelen@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Dec 2025 09:00:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2755

Thanks, applied and pushed.

Alex

On Mon, 8 Dec 2025 at 23:36, Tom Geelen <t.f.g.geelen@gmail.com> wrote:
>
> Incorrect variable pkgs_ctx was passed to _get_pkgs_to_install. It=E2=80=
=99s undefined in testimage().
> _get_pkgs_to_install iterates groups of upgrade results and extracts PN a=
nd PTEST_ENABLED from per-recipe context via bitbake -e. Passing the wrong =
or undefined variable prevents building an image with the upgraded packages=
 and their -ptest addons.
>
> Signed-off-by: Tom Geelen <t.f.g.geelen@gmail.com>
> ---
>  modules/testimage.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/modules/testimage.py b/modules/testimage.py
> index 6377368..849a9f1 100644
> --- a/modules/testimage.py
> +++ b/modules/testimage.py
> @@ -74,7 +74,7 @@ class TestImage():
>
>      def testimage(self, groups, machine, image):
>          os.environ['CORE_IMAGE_EXTRA_INSTALL'] =3D \
> -            self._get_pkgs_to_install(pkgs_ctx)
> +            self._get_pkgs_to_install(groups)
>          os.environ['TEST_LOG_DIR'] =3D self.logdir
>          os.environ['TESTIMAGE_UPDATE_VARS'] =3D 'TEST_LOG_DIR'
>          I( " Installing additional packages to the image: {}".format(os.=
environ['CORE_IMAGE_EXTRA_INSTALL']))
> --
> 2.43.0
>

