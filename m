Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6083CCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 15:19:12 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15927.1762960746514420072
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Nov 2025 07:19:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FsTMt83y;
 spf=pass (domain: gmail.com, ip: 209.85.128.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-780fe76f457so9050637b3.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 07:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762960745; x=1763565545; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwXgi4UtwpdrGKMKiWLvD8PlkNZkLEacK/+JYRUSk2k=;
        b=FsTMt83yX8WLliG3I2UrJAkfcT9xqdt5v6/j0oFtN8VAi/mCozZak6W3OXfTFc95To
         KjapTgwyr4qeAR9sTYJzhVmG6l9PKuZQTMeG7sHf5CG5lhA1ecL+XX4XZRy2XXfv3kI4
         9dlgqB7y64jlT7jo6FEvbIVguOQ8Linrm5mBZLXZZ6a//IlFem30jevBUL+Z2mV4786F
         luykDGYGWqPkgwLNZtarelOxGK27U161e5YT09nxfu0y2GlQtidIbgQe66T7YHNUH48E
         BvP87KjaRLQ+CmTG3xcUMokEDBmtqqjCVNhFtDp/d9CgiBRlvcbsFW7pezCwtXHkQ5iu
         JCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960745; x=1763565545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XwXgi4UtwpdrGKMKiWLvD8PlkNZkLEacK/+JYRUSk2k=;
        b=ZvEjhOidseFELCjeEGWs7Gio40ON3d5BAyiPKJ8XnTiZu8ppU/UlV+uFK1uWGux0n3
         Qw1gYDvZtayRLtfD3fnS5iuQhhZqWIf9Xygo0/rtqwOdTXPb6+asPitSbYANkNqWetR+
         qO7IS/XrZBjucruEw79qnl14AuvCPeqjuWdy2It/+7Xm7JKNk7kY4khbdbhIZH4/fMF3
         bQWWh+fF7jBZO3UWCcxUftDRh5Zq5tE4wkE43i8e0LWL8oa0V2CDO+PxGG5I/aN3NhPR
         Uj4zA0nhpObpvN2MRu1YgD5xxNlFVB5H2gx8RD9/JDn8+e9v3PQijpeuPvxu+4NemFo5
         m0eg==
X-Gm-Message-State: AOJu0YwgICPGQjOecNxDSjBco2A72k9ssSQEutamEGZ4BAYijgEgb5lr
	5C5Jlur9d8Jp+hWN75v3v9+W4YtsHrZ59usx8GYu6qhUvokKosay34QkHQPUkEKAGKrIqBFMPBr
	KXmAN/Kmj1KvUlyszEaqJPP6F/kjNvR5h9w==
X-Gm-Gg: ASbGncsniQRaZSHv8BTAJpmjKC0Owa5Id4iZzn0AHF92U9Dn+C7oD0Nk1mT2SOaLWVF
	JARh/kXO9NG8thyIgqT3OJQaTbn3Zsakqb6Q2NHN4Z7sL+XdWOEl34QZqJYgPZ8wmqEIwdnJN9B
	Pe/ApdLiP66E/Ahtg+ZycNgJXbfmQmpUd7EAu2Wvy/a8652t87ju9UABUiZLucqcYKg2e62KIEK
	Ho0HI7qzuo9k7z4fDvYdPOvh+0VzLhTaWu09ZmDeNkhD/SBcEXzEmfp/T4hdwpZpNsrQRrkpZzq
	IheiiJl/KA==
X-Google-Smtp-Source: AGHT+IHb2bw3zyRj21Dfd/DZN3RDjG9j0isbD2q4NkSS81h4PAxd7Yaec25C1bCk/E3fuONUe3CMNssTPm4EI76eZ3Y=
X-Received: by 2002:a05:690c:5a1a:b0:784:9076:a0f5 with SMTP id
 00721157ae682-788136808a1mr38545527b3.44.1762960745494; Wed, 12 Nov 2025
 07:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20250820065756.1295786-1-samuli.piippo@qt.io> <CABXoSoUd7qmCp4p+5-cCy-E0FZ0XoKotF_pP4vBgnHH_uasyKg@mail.gmail.com>
 <CAJdd5Gbu56oteWRXkw+3URi1itmcd9RQLqiHnqLM61CYxQ=usA@mail.gmail.com>
In-Reply-To: <CAJdd5Gbu56oteWRXkw+3URi1itmcd9RQLqiHnqLM61CYxQ=usA@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 12 Nov 2025 08:18:54 -0700
X-Gm-Features: AWmQ_bkxTX8xNLMSSly6Hqxvzj_w08FLl5ZyAtFxPpGU7eL1dkT838oFC2x7zjU
Message-ID: <CAJdd5GZUjrxp6XotAYRNnbMbtt3_9oV9j6rmjGqEdzHj_Ue+bw@mail.gmail.com>
Subject: Re: [meta-mingw] [PATCH] mingw-w64: use correct path to license file
To: Samuli Piippo <samuli.piippo@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 15:19:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2495

On Wed, Nov 12, 2025 at 8:16=E2=80=AFAM Joshua Watt <jpewhacker@gmail.com> =
wrote:
>
> On Wed, Nov 12, 2025 at 12:44=E2=80=AFAM Samuli Piippo <samuli.piippo@gma=
il.com> wrote:
> >
> > The yocto autobuilder doesn't seem to catch this error as the builds pa=
ss with the patch still in master-next.
> > Should there be some improvement on the autobuilder scripts as well?
>
> I haven't run master-next build on the AB yet.

Although, that doesn't make sense after thinking for 2 seconds,
because your asking why the AB didn't catch the initial problem that
you are fixing here :)

IDK why that is TBH.

>
> >
> > -samuli
> >
> > On Wed, 20 Aug 2025 at 09:58, Samuli Piippo <samuli.piippo@gmail.com> w=
rote:
> >>
> >> Amend b7ac9777ad0c4512f1a63aa6bec4ecedd91783e1 and use UNPACKDIR
> >> also for the license file.
> >>
> >> Signed-off-by: Samuli Piippo <samuli.piippo@qt.io>
> >> ---
> >>  recipes-devtools/mingw-w64/mingw-w64.inc | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/recipes-devtools/mingw-w64/mingw-w64.inc b/recipes-devtoo=
ls/mingw-w64/mingw-w64.inc
> >> index 97315f4..a24e96c 100644
> >> --- a/recipes-devtools/mingw-w64/mingw-w64.inc
> >> +++ b/recipes-devtools/mingw-w64/mingw-w64.inc
> >> @@ -1,5 +1,5 @@
> >>  LICENSE =3D "ZPL-2.1"
> >> -LIC_FILES_CHKSUM =3D "file://${WORKDIR}/mingw-w64-v${PV}/COPYING;md5=
=3Dbb936f0e04d8f1e19ad545100cee9654"
> >> +LIC_FILES_CHKSUM =3D "file://${UNPACKDIR}/mingw-w64-v${PV}/COPYING;md=
5=3Dbb936f0e04d8f1e19ad545100cee9654"
> >>
> >>  COMPATIBLE_HOST =3D ".*-mingw.*"
> >>
> >> --
> >> 2.43.0
> >>

