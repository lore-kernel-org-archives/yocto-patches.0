Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED37AC2BD09
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 11:12:54 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
 by mx.groups.io with SMTP id smtpd.web10.16963.1719832369726456444
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jul 2024 04:12:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l/qCKtMq;
 spf=pass (domain: gmail.com, ip: 209.85.219.174, mailfrom: akuster808@gmail.com)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so2915890276.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 04:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719832369; x=1720437169; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ea7OlDPJ7vgDOuiSzLQd5Je/V6L8l0XWh0IDGwawmhQ=;
        b=l/qCKtMq4mhkXsnw8ttNhoHKV959zOUSDx1G0alV198+qIPTHU1EYublv/NHy/s1bN
         Mw69xp2JQaaq2vVNni/inIEX7C7tV3/bz7tCJPEZPn+Ko6M5XEv56Nh8Iu3LRZTO1Pt7
         wiOGiZ1mN0nYDrSVpZZ09hez3CP3ToZsQHqoUeYHu50rd48PpfWHDBlU/I9vVeY2MglB
         VL2tPdPDWnLQIz3AzOdD6YKyrmDQSMOhrKIru/jsBFadMgJBMajP33H4RdIkNzEcOE3z
         FfZUfQ6pHgVyZRLAsZB9llEaQmFyuw+eqb5E5YzTrsTSEcjHGdIG2OfeBOZD0/hTc+73
         GdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719832369; x=1720437169;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea7OlDPJ7vgDOuiSzLQd5Je/V6L8l0XWh0IDGwawmhQ=;
        b=A67tOdL7hnPFCTumY7+v2bNRPiB82XSwv1vIik2BICEsLiX2JzTl+XycioDKv1y+95
         KoKwM6sz1+P6YwT3/nsuRNrFaji+CPN4hESqVHgK8iYgz+PRYQFx2xhhlWK/hJ7n/mk9
         YwMwSB/s323rlYCdQGICsiSZlW0qOine8pelnM9JL/L4rBmVacCnEFTEz5nHl52i3Vh5
         vFDrOoqBPNbEuG7NlmBvn6+Ljg125XEQLSpvN0fQNvkH0jxJa7AlT97FnEbT6Z1YvwIl
         vP5HMJB7KtszBgrtasJKZXpIY1pRwrkvBWIKhrXUCQrCVMnY5+3vlu+Mk0XT1WSef/8u
         HyVw==
X-Gm-Message-State: AOJu0Ywto6AYVkAdv+5kkh8tijUPwnG0Ug1ermggpA6dZ7O5xQKeQoIe
	6X5+9fNpbqDBbma1ILvFex39MkNzlLiyV7tpaZYAk/Wmd0mPIW4qXyRxFA==
X-Google-Smtp-Source: AGHT+IHixNxxEH0kSJDp8bCneDHFr2AdcyvjPYqjWFMUyh7mztSbi66KOKrKNpNJU/wartb95JXLmw==
X-Received: by 2002:a0d:e887:0:b0:64b:3e44:e4f4 with SMTP id 00721157ae682-64c71145d29mr55363627b3.7.1719832368765;
        Mon, 01 Jul 2024 04:12:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:45dd:7000:978e:d840:6c32:150a? ([2600:1700:45dd:7000:978e:d840:6c32:150a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a99c71985sm13387587b3.16.2024.07.01.04.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 04:12:48 -0700 (PDT)
Message-ID: <81745254-5cb8-4cd2-aa63-368803e104d3@gmail.com>
Date: Mon, 1 Jul 2024 07:12:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security,kirkstone][PATCH 3/5] sssd: fix
 issue if build machine is Debian
To: yocto-patches@lists.yoctoproject.org
Cc: gael.portay+yocto@gmail.com, =?UTF-8?Q?Ga=C3=ABl_PORTAY?=
 <gael.portay@rtone.fr>
References: <20240626133913.790145-1-gael.portay@rtone.fr>
 <20240626133913.790145-4-gael.portay@rtone.fr>
Content-Language: en-US
From: akuster808 <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; keydata=
 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
 ApZ86eOP
In-Reply-To: <20240626133913.790145-4-gael.portay@rtone.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 11:12:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/396



On 6/26/24 9:39 AM, "Gaël PORTAY via lists.yoctoproject.org wrote:
> The configure script guesses the target system from the host if no
> --with-os= is set[1]. It is untrue if cross-compiling.
>
> The guessed host operating system is used then to do specific things
> fort target build.
>
> The commit[2] passes the downstream debian option --install-layout=deb
> to setup.py[3] if the host system is debian based, and thus, it raises
> the error attached below as that debian-specific option[4] is not part
> of the openembedded[5] world.
>
> This sets the Fedora operating system thanks to the existing configure
> option --with-os=fedora, that is relatively sain operating system for
> the needs of openembedded.

Won't this apply to master as well?

- armin
> Fixes:
>
> 	| (...)/build/tmp/work/aarch64-poky-linux/sssd/2.5.2-r0/build/src/config/setup.py:25: DeprecationWarning: The distutils package is deprecated and slated for removal in Python 3.12. Use setuptools or check PEP 632 for potential alternatives
> 	|   from distutils.core import setup
> 	| usage: setup.py [global_opts] cmd1 [cmd1_opts] [cmd2 [cmd2_opts] ...]
> 	|    or: setup.py --help [cmd1 cmd2 ...]
> 	|    or: setup.py --help-commands
> 	|    or: setup.py cmd --help
> 	|
> 	| error: option --install-layout not recognized
>
> Note: Upstream has introduced the "unknown" operating systemd with the
> upcoming version 2.10.0[6][7]. The change can be backported.
>
> [1]: https://github.com/SSSD/sssd/blob/2.5.2/src/external/platform.m4#L1-L31
> [2]: https://github.com/SSSD/sssd/commit/e6ae55d5423434d5dc6c236e8647b33610d30e2e
> [3]: https://github.com/SSSD/sssd/blob/2.5.2/Makefile.am#L32-L35
> [4]: https://sources.debian.org/patches/setuptools/68.1.2-2/install-layout.diff/#L7
> [5]: https://git.openembedded.org/openembedded-core/tree/meta/recipes-devtools/python/python3-setuptools_59.5.0.bb?h=kirkstone
> [6]: https://github.com/SSSD/sssd/commit/7b32dc0ab877a9061b52868b8efe6866c3144b63
> [7]: https://github.com/SSSD/sssd/pull/7398
>
> Signed-off-by: Gaël PORTAY <gael.portay@rtone.fr>
> ---
>   recipes-security/sssd/sssd_2.5.2.bb | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sssd/sssd_2.5.2.bb
> index 98a4b5e..9991667 100644
> --- a/recipes-security/sssd/sssd_2.5.2.bb
> +++ b/recipes-security/sssd/sssd_2.5.2.bb
> @@ -73,6 +73,7 @@ EXTRA_OECONF += " \
>       --without-secrets \
>       --with-xml-catalog-path=${STAGING_ETCDIR_NATIVE}/xml/catalog \
>       --with-pid-path=/run \
> +    --with-os=fedora \
>   "
>   
>   do_configure:prepend() {


