Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6094CC36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 09:50:18 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.44369.1745833813638557959
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Apr 2025 02:50:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FvDcjg3s;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54ac9d57173so5633607e87.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 02:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745833812; x=1746438612; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeAVcofXDZ/DUbXRDg4+KvzvjB0beVeyeoaZhorf6OA=;
        b=FvDcjg3sjEYri3sZxCnw8ygl6C8YUCRwsdvpCJnrRaUZAkpJ5jZY+R6brHA68bkyx0
         SpDY6l/8AFQHGCO1BUpzPlmLzE9KJhwjTjNkIAOimAYtyi2Ol7h2MVfroERmpCrCzEpw
         ntaKDWKCVWgN2/Ep56wGZCqATTlSFnJXsifZP6fwkuSVBWVrSe0KCLNcPyG0U9EYhQEt
         kRuvBNYEhxD75GnBNitZ6Gm8orkSSuFnf3XVouUJKlAD8yRpWiwAYtT0BnDVL1ZfdJdk
         WxssLdAkx/OjoJJ421CtuNUWMaGi+PfLfZ8gMb6ADewQRQfyDo2uyJLH3hQPi/RPUVqZ
         wdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745833812; x=1746438612;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeAVcofXDZ/DUbXRDg4+KvzvjB0beVeyeoaZhorf6OA=;
        b=C9JQ23B/C98ofbEcTXOxOqRiAkEhviRMCzM6XD6nan888fTmIe6iWYhWosYcIRftDq
         O/0rraq0dyu3actx/CTHQCw2/Qy4lPlOOUmEJtWST3TV/hg2O5oIDfI7huOW9gzoLtY9
         G8tKaCVonRA4ARX3uqtFjML4zTql2Xix3HTXRZGmCLqzjCvqES3k0cB+IEbBGvxH1cey
         bXV0WdklHqrcan3zCP6peddI8kSb2E+z0rt9U2S5kzg7Y3zEhcrt5aSHfOqK6KsAUSWz
         JWv6oZaTo619+W1zs4ND9siuMnj33DBdgGFaALruc1DZYhxRi9eLWriqyE1E7ogOD6kS
         SJHw==
X-Gm-Message-State: AOJu0YxRMx//iyw91IQwfm2GR93EXr5SYHZop8L0UEFQh1zQtHWMgbhF
	Mzx0Y/FETjR2J6FgiViamjhSUNfyDVfNxpp393OaPLS++LXY6PiZU75ZHykJBFhgN/OF5s0DVX9
	RpVMnaLjyDp7jJK4bVCfshOM+vJhOVQdrRzM=
X-Gm-Gg: ASbGncsHv4qLlRkvabJUYy1u5je8JgO9NVVEdVHpVZZjk33EHNiX6B7Co8NNZxkw3p5
	6I0ABr1fcvItB2vr8TdkbYHrd7HjmUPHpth6hqSlDZ8HH3tTlSuY0mTuNAsJe395k5vrGhik31b
	AjSVAvA7jKHPtmw9ZfjuFzKqdH
X-Google-Smtp-Source: AGHT+IGMCDfOSdfr5RUmglZArBFsQyla2/7/nF/4W9NxgdZ++ryOr2j2MT1AVYjfBEXUkaeuyC1CvzGoJHSOrF9/lpo=
X-Received: by 2002:a05:6512:3caa:b0:54b:e70:4122 with SMTP id
 2adb3069b0e04-54e7d6375e1mr4896792e87.21.1745833811317; Mon, 28 Apr 2025
 02:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <D926NE9BWQNP.24UZVBATV4CNF@bootlin.com> <8641.1745829497357307449@lists.yoctoproject.org>
 <962736f53e74160579c266835dacfca786d3b362.camel@linuxfoundation.org>
In-Reply-To: <962736f53e74160579c266835dacfca786d3b362.camel@linuxfoundation.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 28 Apr 2025 11:49:54 +0200
X-Gm-Features: ATxdqUG0s6VZatxOLjGhP9dShaBAMer4em6wIHRSRMAU2nBZSaoTNdImU6L04GM
Message-ID: <CA+chaQcz+_1xjqsALTA+z13qKSN77x8G6cWu8ytE+A3CqEav9Q@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][scarthgap][PATCH]
 config.json: add a builder for meta-webosose
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 09:50:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1406

On Mon, Apr 28, 2025 at 11:45=E2=80=AFAM Richard Purdie via
lists.yoctoproject.org
<richard.purdie=3Dlinuxfoundation.org@lists.yoctoproject.org> wrote:
>
> On Mon, 2025-04-28 at 01:38 -0700, Hieu Van Nguyen via lists.yoctoproject=
.org wrote:
> > Could you please merge this patch and schedule support for the
> > webosose build for the Scarthgap branch?
> > Please let me know if you need any further updates.
>
> I've merged it, sorry about the delay.

Thanks Richard, I think this might depend on
https://lists.yoctoproject.org/g/yocto-patches/message/1339 which also
doesn't seem to be merged yet.

