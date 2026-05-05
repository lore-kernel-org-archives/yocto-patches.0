Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367FCCD342F
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 08:06:00 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34154.1777968359281771516
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 05 May 2026 01:05:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=SXwAWZ3r;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b5de17382cso29236176d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 05 May 2026 01:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777968358; cv=none;
        d=google.com; s=arc-20240605;
        b=HqTXTv+VKt41kaGr3eMPkNV1iatbjtew7YAtsJn4f+0gY/HSRTEwFbFmrn7vECaRBv
         sS/nPr2WEGBmCmsLCoQvB4ZWA4B8TiUr+d1n56REPLcUm1RcerwKvEhul1YZ0IUb0uD7
         9IBJaHE19D0O+Dr1E1fFQ2IKpMH8uyhf+uVNGTDiqx7QkcIFzWcXew0SduG4dwz42Ae7
         X3vNy1HZlNMImqWkSokxVR/0mzv/lq6xR4dpffy2Y1ZcoJd8+nEqqnr+z/ZyrbufZYJM
         e8D9/I689Cxm67n8mPh9MdmgQx//g8AR4k2zLFCMdbrZGtmqCM+H57qrWgXThIEJDdAo
         mnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y78QsZZyjREiylfMQKh/S3Vffxd5erohIw3XbwcMBPY=;
        fh=5f3juoVmFZAcDZXxw6MpSCyKznmuK5IWEecktzwNVBw=;
        b=DIHHJY4/S/7lXaH8m3B7mami9tEpvxaxXe2871ghPtduwCZ542OCT2ks72R6hN7ZKZ
         cbf6N1VZ7G6deW/PCJ+5DFpaxoED2fjsjc5qKo8wI8iSdKDfVG1nIhRkw54GAjQ5E3hZ
         eXBMe2WlZFFCOpMsDjeiHpyklbOgXqTGxkc4rWY0Y2uC0+kOcFhuJzwsjP1m/aomp20X
         nRZYgZRb94ABqbyeenePkk776G8D7Rm+R38LY93LXHkKqaClOh3Zy60XtCR8BG05ci/e
         TDSp1oX6iLYG/XJe9dGDsmv9hxFutinoV8X9Ifb5Od7WphAowupVY0sfIbGqyrPweWX2
         nAHw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777968358; x=1778573158; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y78QsZZyjREiylfMQKh/S3Vffxd5erohIw3XbwcMBPY=;
        b=SXwAWZ3rSQyeFvIZg25nDp6+Z7a3FT8ybAMooLGdH1UUCtntdWlaf2OmuIk4gU++O4
         7/7b8FlWB+3Wxr4CyvFj5Ur3MPzsIQooDBGyhoOyOk2TeiwZMqVUQ3jgcJtp2BBulnx4
         4Wcmpo0B+ljz9tNr94354vVVAOsCeblMoq1+azGktuAFySjA2MlE7do9eFLuX1hpViY6
         lveMskjbp4/j0Tz2PHytSv7D5EXdCwvI/Z6q8CPABPli1EQIBQVaC/bjEGVeICokcCoJ
         Gw3vtHFNa89LAsRd3iv3vIOtFlxsNsnCh4ZhjN9GYiL6p76dpMAiMzJupL5MI6OM7O8W
         /v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777968358; x=1778573158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y78QsZZyjREiylfMQKh/S3Vffxd5erohIw3XbwcMBPY=;
        b=hLsNejoUBNOzCyEwecUaLYsu8vIn69zfyDwV3BFaQuH6rMJndBPnVq1BW8vAMVPKNy
         jkRDxHsDfOux5rk5+N4cTZdBw+Uno4PN+pc8MElFcmA6FC9j6Af/rOg6a47V49e8TASi
         fDjzeKMLdHqlLbkCsh4muFuE/9cm67Hzkeix8aJF0hUTtg0VJCtHv6wapLFttYDK//2c
         MMSMwypw3BspFUwtyvbx+Ma24nXfcQm0tZH+HsqCmFldJx6z6aSBC3ToQkjGrWkeCbge
         ++rav7umAXZjpije/CUEi/HyiDNulAMjR6n9/3EawCUUD6wgfQxucqxlbiwf/knKZae1
         pyzA==
X-Gm-Message-State: AOJu0YyO0Xc1j2eYEe73GomeWMMrmnAfk20tuOhDnxdX0Ghl3AUMFXRv
	9zkgQvtHWJw4ewqp1mKBi2qT9zanneZw1huy0xG2GNNRCjYrplmRxDZPbD1iPzDFt6XQjy9sTTr
	7zfPcvqRtl32NUvhp13T5+F5zPGr5lwo=
X-Gm-Gg: AeBDieumE7V21Ef5WiRCkUk0JbGyZBEIYKZqLu/3Jtb8J45ULyvSN28g724Tbf6jObQ
	ie7rrFroa61IJhkhyD6GQOjWtHf/mik5qKDmAxwzshrfpDPAkVnuZXjL2T3kHyABdJrAETJVLwM
	k+ttzyhHJy+3awpSxfsQ8nPILNP2ntk5x2umWKzIko1Yjd7Vjk7H1/j9AC4py4L3gatYIGD/QPq
	YStWf9l3+iNDFOGTaMvWb7NbTBwN3fW23lu2w+AL15r3TuPfebYpTQmwsAC0T0DVQpP98H/V3i4
	8b4xrqHqVR+iUCyV0d27h/OxDAwsVsCBxDw14Au2N6PnNf8ekfr32xJ2ANG/SO8=
X-Received: by 2002:a05:6214:5246:b0:8ac:b1ad:3a1f with SMTP id
 6a1803df08f44-8badb59c080mr31862176d6.35.1777968358149; Tue, 05 May 2026
 01:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260504063614.3831203-1-daniel.turull@ericsson.com>
 <20260504063614.3831203-5-daniel.turull@ericsson.com> <CANNYZj_UU10pV=pHBi_GOK5m0NsC5EzLB828k9Q08mG3K-wj=A@mail.gmail.com>
 <PA3PR07MB1072178ACD37973C762EAE17E8A3E2@PA3PR07MB10721.eurprd07.prod.outlook.com>
In-Reply-To: <PA3PR07MB1072178ACD37973C762EAE17E8A3E2@PA3PR07MB10721.eurprd07.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 5 May 2026 10:05:46 +0200
X-Gm-Features: AVHnY4J2g_JixbSyLxCyjDFcsGCx2nS-Hb7lGLZFo0X4_DG_r68yuPZrPztdf6U
Message-ID: <CANNYZj_ogpJFafzS=zXzg+iPZL64qURsHAugwwSvSrrB3wy03Q@mail.gmail.com>
Subject: Re: [AUH][PATCH v3 4/4] upgrade-helper.py: Add resume option to skip
 already attempted recipes
To: Daniel Turull <daniel.turull@ericsson.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>, 
	"paul@pbarker.dev" <paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>, 
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 05 May 2026 08:06:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3912

On Tue, 5 May 2026 at 08:49, Daniel Turull <daniel.turull@ericsson.com> wrote:
> > > +            if 'workdir' in g:
> > > +                if any(g['name'] == s['name'] for s in succeeded_pkggroups_ctx):
> >
> > This is more complex than the condition in the removed block below, why not
> > use that:
> >            if g in succeeded_pkggroups_ctx:
> >
> I'll add your suggestion.

Please be honest. Did AI introduce this inconsistency? Catching and
correcting such things is on AI operators, not on reviewers.

Alex

