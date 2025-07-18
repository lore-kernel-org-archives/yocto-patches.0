Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2190C83F34
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 07:12:40 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.15037.1752822758667743570
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Jul 2025 00:12:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KeeHAOeW;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-555024588b1so1972367e87.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 00:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752822756; x=1753427556; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oIkVLfANdQIhtTDMG6Ky9ZBqaqyZ2NzDEokdh60J9E=;
        b=KeeHAOeWZq2Rfi/Nb54ei5OWDXsPO3kqKr0mu3U52PiikttRjpS6Erv6jOeu7i8OGh
         /sS11B77rtzIHglUrxPjfxURc7mKHCpjC0kpI7MwSNvwaqpA6RQJl509OoPHMuQvvAh0
         Z3PisbASGu7u/jr3PY8JXAwJEtXi2XeMPPlTQ00Ua49zyExT75MA5KXrcXN1ghAmva4b
         IggOt4iRyMGjhi37g4OPZ3kvGtvFFd+NAUuXJLu1A7+ka0EcP1XACDp8djTlpIxQWBXd
         rDXTAwLDh6xkApDDUFqJOgJHLyqj+XSeDf/oh+N6aOwpayINMV1DdlFelW/bgpvC+8If
         qnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752822756; x=1753427556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oIkVLfANdQIhtTDMG6Ky9ZBqaqyZ2NzDEokdh60J9E=;
        b=jDsE9P0yujSqqLIjRAxvXvjTOdqzbtj3i3dt5gKUjxM72h/5QjmIhwwqyrefKlmhHM
         hXR4PjQgbvEeL+hyz/G+8E6UeY1FCGNHvh1XO1/VxmQm5s8zZSdyhLO+vXrog7kLaWcr
         BCD0zNoARQMIjAmlUZbNI4Tfm/tgarTzKw/JFIGFYiPJhpvra1WTOFzXjhWwACPDHOZW
         /jwAA8M88q0pl00ZOnG+ZOqneB780/jksWOtVOv/E1GGRDik5c8D31PU+FuJG+WqP9Wm
         sLIjP5UZuNJnxbTZ0QmZ+5BYMmPcfivCyEA4NIToJhAPQiNw3T275d6Y9O2ESymhDzm9
         DUXw==
X-Gm-Message-State: AOJu0YyqICH/acvkYSKF1iC1iH32cve9425VyWIoV0HKaPvbpR9VC0Kd
	Z9JTJ//qWUoBoU+AC/Qvqip36JXHnP0lFKfIw6TIbykwAEUVEXnN+526Mnz/eyf9Q11eWkSaugW
	V6DvFPNmfYkaAeAgQPY/s+eL8CCSE/QE=
X-Gm-Gg: ASbGncs0CAYhBilh7tx/4b47a6wIZDIYbdlAGf5TEJx8hmFFCmDkC7FHOpWtZ1jOrlX
	sshxQcgiNQ2Z3dwKHLfYFdFj+I1pG+WBQKraUrsZIuGuhO9jfetTV4lvtfKRYFg3NDqtvacYktc
	bc+kvhffBJkGZ31WGEwg6SuRM5az99Fgi68EHHe+idpIw+3h6AYagAK8TuDfz8zsuzO0/w34d8e
	B8bfulgRw==
X-Google-Smtp-Source: AGHT+IELUP5l09x0TDjM4zGsx6/aQfgdwpenw7bnY5OPSX+Cax1WfOAJpkJ34mA1jHiHdfmkHmNcjX31FvH1w8Nt2tE=
X-Received: by 2002:a05:6512:3e1d:b0:553:3945:82ac with SMTP id
 2adb3069b0e04-55a23f48b86mr2464426e87.29.1752822756144; Fri, 18 Jul 2025
 00:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250708072436.24522-1-martin.jansa@gmail.com>
 <20250708072436.24522-2-martin.jansa@gmail.com> <CA+chaQdVAzm8au9RXWgY01gwwWO_qxO6LLM=ThTOwzWU8MrUgQ@mail.gmail.com>
 <519af080-65b3-4e68-928c-a2c5c087a5b6@windriver.com>
In-Reply-To: <519af080-65b3-4e68-928c-a2c5c087a5b6@windriver.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 18 Jul 2025 09:12:24 +0200
X-Gm-Features: Ac12FXxm2RCOUuM-RoM7TSJ7AelmOnGs_9D1s7DHjZz21Qnz33JVbvw2P-_qyds
Message-ID: <CA+chaQcakdJhrJMVjpx1pm_KsZ8J3N2cvg25Qc-DL2vLxbwGiA@mail.gmail.com>
Subject: Re: [meta-tensorflow][PATCH 2/3] bazel-native: adapt to UNPACKDIR
 changes - avoid WORKDIR/sources
To: Hongxu Jia <hongxu.jia@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org, 
	Martin Jansa <martin2.jansa@lgepartner.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 07:12:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1809

On Wed, Jul 16, 2025 at 9:06=E2=80=AFAM Hongxu Jia <hongxu.jia@windriver.co=
m> wrote:
>
> On 7/16/25 14:49, Martin Jansa wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
> >
> > Hongxu Jia looks like you've created very similar commits for
> > whinlatter compatibility recently.
> >
> > Do you monitor this ML for meta-tensorflow changes?
>
> Sorry for the missing, I will take care of it next time

OK, will try to remember to Cc you directly if I'm sending some
meta-tensorflow patches in future.

Can you please check what happened with master branch? there was
27237386b61 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS
around 2 days ago and now it's gone, did you remove it and
force-pushed master (please don't do that, pushing new revert commit
instead would be appreciated) or did it disappear due to some syncing
issues in infrastructure?

I have noticed because our CI is failing either to fetch 27237386b61
or trying to "upgrade" from 27237386b61 to previous eb5054ccf48
without any git log between them.

