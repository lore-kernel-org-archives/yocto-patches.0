Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B66D4417C
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 16:07:01 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.25193.1732032410806520183
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 19 Nov 2024 08:06:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DPz7qhgc;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315b0bd4ddso6231475e9.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 19 Nov 2024 08:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732032409; x=1732637209; darn=lists.yoctoproject.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2jp/iiAffUYfIEt1nZKTmLGa0OoJDz4BZBDirJ0P2Rw=;
        b=DPz7qhgc/sJesT9iADDrJUZyIGFOL7xpViNUjaTKypLY5UNTaXVvAd3Q3Hu+VCP+6v
         OCWZggyG7OJDIYCiT7/3TauWm+ZgiU2sA+kNOttWp6GO+NS8DuMtErCqBpjm4YUFkQvx
         tLMZvWvIxzXIoAVoxj3r/iETlKIikFrPTmLzr8pByrR77n/fKkObYPnploTARwACdYCr
         zyP4Np3nrRHio7WAeFSljsP8FKqMy3XfkmdB3/yV2Uu7jXoKHjCXWfBiVLFe4g3zJ3gg
         d3v2uCQFeaPnzPuONkowONRxXz8YABKPgMf4KrHTwSyz4/5gNNHbq5uTUDyF3TcAB4w0
         cJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732032409; x=1732637209;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jp/iiAffUYfIEt1nZKTmLGa0OoJDz4BZBDirJ0P2Rw=;
        b=G7142+w//Gw8R1BdcWPKZNCRjyhl4VHaTUE2s8NGP+taaRSqoIgE5ks/gJOSoR7lBG
         UoUc8rcJ7ss0UgOmiSGspSxfBOcwBGcXB6etVwjzlQ3+E4bYHxi5vhvY6IXak7rXwpZD
         m6rd7y3YPgmDoiM+VOYYnQw9yN/iRfBZ9aBeWhb/5al/Y+MGaThtL4eha1Kl0BFCCsqH
         DZmlakHyK8GNMg69JE3MdsVhBOEn1pMtYIbYJsgZ6QaDZu9S8LPc4VwVZqBNUgyfDZwK
         AC24Ry0ntojgFjZA1fgfmBdMZy4ebnvQ8LHqS+GQO/jjCWRbkVOS4kXurAN6K9Pv8qJB
         4TWg==
X-Forwarded-Encrypted: i=1; AJvYcCWWWqSOS2n/3Dmkp0HlHU3kxVY6Y29VbeENtJnNCQP4btyRotcdUkKp1ImeabwI//S+HHPhBDCa4s9d/rBZ@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzDpAcCu0rV6SHuO48arRRURmUNHSC2Q/tfbbXEIUZ/qn8rCN30
	FYza6FTI09Rnz/HWyrnr5zc985AnPe2h1PvLYh2ZhllIp1f75opAjh66WtCs
X-Google-Smtp-Source: AGHT+IGZ00BUYp1V8KvlwBufnByy5xI/OkVkbswFwS+bZt2PRZ2P6s4mt4+Ng8kKQ73VSnaKtkgQ6g==
X-Received: by 2002:a05:600c:3589:b0:42c:c59a:ac21 with SMTP id 5b1f17b1804b1-432df7229eamr63122165e9.2.1732032408799;
        Tue, 19 Nov 2024 08:06:48 -0800 (PST)
Received: from localhost ([2a01:e0a:ce:f2f0:3a7c:76ff:fe01:6f05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2445d4sm206176405e9.5.2024.11.19.08.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 08:06:48 -0800 (PST)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 17:06:47 +0100
Message-Id: <D5QA8VMRVDZS.Q270JPNASBIV@gmail.com>
To: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay@gmail.com>,
 <yocto-patches@lists.yoctoproject.org>
Cc: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay@rtone.fr>
Subject: Re: [meta-security,kirkstone][PATCH 0/5] sssd: fix python3 support
From: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay+rtone@gmail.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240626131256.785609-1-gael.portay@rtone.fr>
In-Reply-To: <20240626131256.785609-1-gael.portay@rtone.fr>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 19 Nov 2024 16:07:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/824

On Wed Jun 26, 2024 at 3:12 PM CEST, =3D?UTF-8?q?Ga=3DC3=3DABl=3D20PORTAY?=
=3D wrote:
> Dear Maintainers,
>
> This patch series brings several fixes to enable the support for python3
> to the recipe sssd.
>
> I have tested the build on the branch kirkstone with following change to
> enable python3:
>
> 	PACKAGECONFIG:append:pn-sssd =3D " python3"
>
> The command below runs successfully since then, however, I have not
> tested it on scarthgap (yet?).
>
> 	$ bitbake sssd
>
> The patch series creates the new target package sssd-python; tell me if
> is not misnamed (thinking about python-sssd?) or if the python script
> and its modules should be part of the target package sssd instead.
>
> Also, tell me if you want me to apply these changes on top of master.
>
> Important: I am no expert in python packaging at all, so I have probably
> made not-the-right choices in the first commit! Sorry...
>
> Kind Regards,
> Ga=C3=ABl PORTAY (5):
>   sssd: fix missing python3.X-config script
>   sssd: fix ac_cv_prog_HAVE_PYTHON3 value
>   sssd: fix issue if build machine is Debian
>   sssd: fix shipping python script and modules
>   sssd: fix path to python3 interpreter
>
>  recipes-security/sssd/sssd_2.5.2.bb | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Armin, do you mind backporting these patch serie to kirkstone since they
are part of master-next[1]?

What is the process, should I resent the serie?

Also do you want me to make the patches for scarthgap as well?

[1]: https://git.yoctoproject.org/meta-security/log/?h=3Dmaster-next

Kind Regards,
Ga=C3=ABl

