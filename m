Return-Path: <gael.portay@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58123CE8E9A
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 18:43:33 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.3959.1729795407292111562
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Oct 2024 11:43:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QIOffpfc;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: gael.portay@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43155a6c3a6so1801005e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Oct 2024 11:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729795405; x=1730400205; darn=lists.yoctoproject.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lpa7GJZyVFa1ps1NQ1v48xWAj6uvAmUMTaOfsOt287s=;
        b=QIOffpfc8ypn9nRmvgfhfv5PfjZo9bgpoOFIOnkDPoCPyxlytW2HnJjGGtM+zWDgTQ
         fA9p5AF6Gky4OrtJdtXNVeb00OjzcPnyi8hNpO7CuOEHJkFVvnaqRX5EsX/GC+rH9MkN
         lPgEzA4m2PqeQ/pXLMZy1LhmX042yWN/9itmoNt7BtwN8cjK/+JIdMA3Fokjo6GF79Cd
         HsoqDLRY9fG09g1yzv8F5sSq+u4yOX/F3A1GzhUM16ucmPZgpFjz5cU+rm8Hz/IzgK0B
         hk5T7+msnMYakcs5jymzfxUXWKceQzM2zkeaNkyb4rVIttGG0OZvgtDksbgMsGdG3oy/
         IxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729795405; x=1730400205;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lpa7GJZyVFa1ps1NQ1v48xWAj6uvAmUMTaOfsOt287s=;
        b=Y54z9iA1mt13VnQJPsVKzjKT4Rdv5p5eaPwHi8hCe51mF6FPJL5OJdab19tAndgmbJ
         NWW5epwSUpHz65LtPCTn6SrfdklEa+VdANFCN5NyMrv/kriv4XJzv+SKPC1oIyr4G/Nd
         iFazT6uInmVMWAVYDs2YPtC3a0QEcBHDm7TZobqlnVz0Z0SkzsGEyKMqXujN0eYQ5nxP
         3U5CM51rJagWhQCKcrLlJqoWgUDb/iyQoygZKXFR2RzMVfIu3KG5KqYBbDRvssmyTr42
         dZBvkIVBUSh/E9hRNJbLMATTg8rPpC08F/BmGNwao0DIr7ZuZVQ3AAu49E6Xb77byi8I
         5I8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVq5rpJFQ607e7p+88vsT02Ohp6iWr0GFn2pi0JAePjTBI+SNACsgAulaSJEMVde/OpPim4cvTHn+vuMhWW@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YysLQPVgkWsiWu0m9cIkBAoZZ0W4w/xXWqRRzD/6fjlg9/D3kSe
	ET1mVQZCQl739TbJQqkc3KPH5RQIt3VfNalsx7yjqQ6dWE2SziPv
X-Google-Smtp-Source: AGHT+IGi8OrWJY/QcVNcd5bg4iStmBUoReA0PyTTiajS9xOzL4sMRaAD5xHIK9r7URcKwdrbh5XSpQ==
X-Received: by 2002:a05:6000:1f8f:b0:37d:4517:acfb with SMTP id ffacd0b85a97d-37efcf00305mr2521087f8f.2.1729795405146;
        Thu, 24 Oct 2024 11:43:25 -0700 (PDT)
Received: from localhost ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a58f29sm11878354f8f.56.2024.10.24.11.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 11:43:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Oct 2024 20:43:23 +0200
Message-Id: <D549ALWWNLVK.2MKQOVMC77307@gmail.com>
To: "akuster808" <akuster808@gmail.com>,
 <yocto-patches@lists.yoctoproject.org>
Cc: <gael.portay+yocto@gmail.com>, =?utf-8?q?Ga=C3=ABl_PORTAY?=
 <gael.portay@rtone.fr>
Subject: Re: [yocto-patches] [meta-security,kirkstone][PATCH 3/5] sssd: fix
 issue if build machine is Debian
From: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay@gmail.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240626133913.790145-1-gael.portay@rtone.fr>
 <20240626133913.790145-4-gael.portay@rtone.fr>
 <81745254-5cb8-4cd2-aa63-368803e104d3@gmail.com>
In-Reply-To: <81745254-5cb8-4cd2-aa63-368803e104d3@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Oct 2024 18:43:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/743

Armin,

On Mon Jul 1, 2024 at 1:12 PM CEST, akuster808 wrote:
>
>
> On 6/26/24 9:39 AM, "Ga=C3=ABl PORTAY via lists.yoctoproject.org wrote:
> > The configure script guesses the target system from the host if no
> > --with-os=3D is set[1]. It is untrue if cross-compiling.
> >
> > The guessed host operating system is used then to do specific things
> > fort target build.
> >
> > The commit[2] passes the downstream debian option --install-layout=3Dde=
b
> > to setup.py[3] if the host system is debian based, and thus, it raises
> > the error attached below as that debian-specific option[4] is not part
> > of the openembedded[5] world.
> >
> > This sets the Fedora operating system thanks to the existing configure
> > option --with-os=3Dfedora, that is relatively sain operating system for
> > the needs of openembedded.
>
> Won't this apply to master as well?
>

The patch serie does not apply cleanly to master; I have fixed it.

But, there are additionnal fixes to add on master (not needed in
kirkstone).

I will send the patch (shortly?) once I have retested the whole thing.

> - armin

Regards,
Ga=C3=ABl

