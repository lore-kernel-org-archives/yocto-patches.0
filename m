Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EC9C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 18:10:35 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.3725.1716833431982040333
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 11:10:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ceeEjJXZ;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so140934681fa.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716833430; x=1717438230; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QA5aApx4dAD2YC5o9QQIW4yrmRmA40LCMnVdEYrlKwY=;
        b=ceeEjJXZ/GJde5Yza87Ryh3mDpzlZVU83Xh3vvPcToC11yAPrRjGF6FIUD7/LAGXUb
         Z/q9/khamgQNsQ1YBD2+v/3ZlUEYUFLOc5BUjsCWCm+K+WKY+ZrhgtVLmHnZ4MhZfhib
         RsDVIlrKCl0YnjUFlizARymOly7bB/42cGeMJ0I+kmHrY0PDQuSWkJce6uCU0OerrR+B
         RuN7KzD9J05cekz7WnkEVYR7RljRJsBr1jHHHZH/7THYE1KQJjRsc0zLNoFFrBmm2d5y
         c2ORwU9fvE5vuQzHVzi4ERGoWFLZTe/DeDpTba3+haKvH5Udt+awF61F6KxMNPrrqkg8
         h7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716833430; x=1717438230;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QA5aApx4dAD2YC5o9QQIW4yrmRmA40LCMnVdEYrlKwY=;
        b=Hfej1qKGn9/hANPznvEcSaHILQFZHEZR4fsLmjOn6ZKYi0RMHR9WxVwdwAXDac2Srz
         37kRdY8ofmOcsF5FN9KDoXXf/+CF6RLs4ZzijK3HolYjtB5aZObbXoZZYDsLzJ0rnoCN
         DXBUr+zq/PMVl3sH/DyDBo+JAT1dzvkYDuviSwmLmEQ0rzZim2+09dC/7FPHgaZ8VE90
         NnZB7SWB0+alCz0J11nlZX487etbrfBXHhCUxjTq5zD2jQTZ64Fr+OJ3XZunVeGZBk+c
         AW+MzoJMWTMTVPUKOrgCKtvihAGTdUVEFVMoZd8VYO4eUdBWZXfDgDxRUznmjzHU/A/X
         vJ8A==
X-Gm-Message-State: AOJu0Yw/kDlDz/4z0IRoQK5lWxulR3x352AZFXlDvjh2XUmIAhjGxJeV
	uAWTTWXmhXs3IJX+SyIjuvx+Qo00ceqFRMU4kNPNnuv3byFYUgc5gTIaW5dIq+wPLOpSvVe52em
	wTHtYnzZjBy+CJnFLRGtmearczrN4BZJl
X-Google-Smtp-Source: AGHT+IFtlCudfCVbkKRPovYsjzjlwutiotLeN3SNDTeK1GHQTZIRC+ZyWJ6bBnPQ31uYfnBPI/TZYbctlVfFimZ+TmY=
X-Received: by 2002:a2e:820b:0:b0:2e5:4c78:1227 with SMTP id
 38308e7fff4ca-2e95b0c241amr70362291fa.31.1716833429744; Mon, 27 May 2024
 11:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240527175850.1256122-1-tgamblin@baylibre.com>
In-Reply-To: <20240527175850.1256122-1-tgamblin@baylibre.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 May 2024 20:10:18 +0200
Message-ID: <CANNYZj9NxxYo3jTYmNVhGPvv9VoeZN8M779TmDwfgsbDzdoEtw@mail.gmail.com>
Subject: Re: [yocto-patches] [auto-upgrade-helper][PATCH] upgrade-helper: fix
 testimage check
To: yocto-patches@lists.yoctoproject.org, 
	Trevor Gamblin <tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 18:10:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/213

remote: ##############################################
remote: Invalid author Trevor Gamblin via lists.yoctoproject.org
remote: ##############################################


I could probably fix this up, but perhaps it's better to do it on your side.

Alex

On Mon, 27 May 2024 at 19:58, Trevor Gamblin via
lists.yoctoproject.org <tgamblin=baylibre.com@lists.yoctoproject.org>
wrote:
>
> AUH's testimage logic is still checking for BB_ENV_EXTRAWHITE instead of
> BB_ENV_PASSTHROUGH_ADDITIONS, and INHERIT += "testimage" instead of
> IMAGE_CLASSES += "testimage". Update it so that checks for the correct
> variable names.
>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>  modules/testimage.py | 2 +-
>  upgrade-helper.py    | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/modules/testimage.py b/modules/testimage.py
> index 0fc1adb..fb2e467 100644
> --- a/modules/testimage.py
> +++ b/modules/testimage.py
> @@ -53,7 +53,7 @@ class TestImage():
>          self.logdir = os.path.join(uh_work_dir, "testimage-logs")
>          os.mkdir(self.logdir)
>
> -        os.environ['BB_ENV_EXTRAWHITE'] = os.environ['BB_ENV_EXTRAWHITE'] + \
> +        os.environ['BB_ENV_PASSTHROUGH_ADDITIONS'] = os.environ['BB_ENV_PASSTHROUGH_ADDITIONS'] + \
>              " CORE_IMAGE_EXTRA_INSTALL TEST_LOG_DIR TESTIMAGE_UPDATE_VARS"
>
>      def _get_pkgs_to_install(self, pkgs):
> diff --git a/upgrade-helper.py b/upgrade-helper.py
> index 869dc3f..e307d60 100755
> --- a/upgrade-helper.py
> +++ b/upgrade-helper.py
> @@ -262,7 +262,7 @@ class Updater(object):
>          enabled = False
>
>          if settings.get("testimage", "no") == "yes":
> -            if 'testimage' in self.base_env['INHERIT']:
> +            if 'testimage' in self.base_env['IMAGE_CLASSES']:
>                  if not "ptest" in self.base_env["DISTRO_FEATURES"]:
>                      E(" testimage requires ptest in DISTRO_FEATURES please add to"\
>                        " conf/local.conf.")
> @@ -271,8 +271,8 @@ class Updater(object):
>                  enabled = True
>              else:
>                  E(" testimage was enabled in upgrade-helper.conf"\
> -                  " but isn't INHERIT in conf/local.conf, if you want"\
> -                  " to enable please set.")
> +                  " but isn't added to IMAGE_CLASSES in conf/local.conf, \
> +                    if you want to enable please set.")
>                  exit(1)
>
>          return enabled
> --
> 2.45.1
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#212): https://lists.yoctoproject.org/g/yocto-patches/message/212
> Mute This Topic: https://lists.yoctoproject.org/mt/106334515/1686489
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13197349/1686489/315264618/xyzzy [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

