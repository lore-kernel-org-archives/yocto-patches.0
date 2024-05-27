Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431B6C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 20:21:47 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web11.6623.1716841302700505023
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 13:21:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nIJAQg/E;
 spf=pass (domain: gmail.com, ip: 209.85.208.170, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e95a1eff78so988021fa.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716841301; x=1717446101; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1I94XSNGIyAaLlyQZv8t9t61Ut6Yg0yoR2Z/T9S7lyE=;
        b=nIJAQg/Em+fl3fAsbzMWjOmykYzcyEy1JVFouiLhrvHinz4ZlP9XaGwSNUhYdlh943
         TgYgUXj2qVavd0ekwMu3MeMktIamc20KTAncEj+dAXfLs3Qt3Pz6/vdJXyh9yymkw7jq
         SoZr606ewd8vfa56k00s7EcwNXju+BsN/ePr0DNJgkEQTNzCjv7MNwYw85qpOw1MPxes
         nb9qRyaUkJY39WIbZTgTTiLsdzbvegsmpzhSucU+6YuyfWXC8P92UFAeR/vDM2Ew/en7
         t5dFpFYXUUenR9UCuibyZj1H8N4EO4cqhZPfUuS7ZAKbyTj+Kc6TMlliUpTmM8+Gzphr
         Tp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716841301; x=1717446101;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1I94XSNGIyAaLlyQZv8t9t61Ut6Yg0yoR2Z/T9S7lyE=;
        b=rr+enGceBk/6vadFQT5Mr/xYmzXUjBG8U8GrvsCgl3DIumTMcNuDmbzNSXJjO3p/uY
         V1txaGjrsaHHQRbS737+zkrW5vo3Od8wcJwyCU7dlYn2i6RT3Zt7mI0rgrsm2f4Jdue+
         463eBxoc2VrDdaLNBKiyuwDVxiB79cZDltOyZuG4PFW3vU1GyPQ4OIIiJc+xKNp/7NsX
         H/khOu6TKReIQSqDx57gdYC8IQyUsEKbB/kQcL7iE4MUIozO9UFuSnwdFullr1wPFnI0
         e2B8ljGL2ycBtgmYX2cWPMWbD718oP24gVZ71UJ5InwMle3GkcC/OTha3Azyh6w8ursn
         H7VQ==
X-Gm-Message-State: AOJu0YwMyta/IP1oOObQgoxOUH6+is+g+GGCy3FHG7fENoiFIlSQjjVD
	X5D0tBuYefL5S7Wo8w3ZS/prLT/mDDj/ZXCmnCPMSvxbJZOfeHZRvvIwXBE0s1R4sk6MdALX67I
	1Rf0Dgcau5g7uyYDpXiLXKDBNulhiPQ==
X-Google-Smtp-Source: AGHT+IG5Yh+cw7airI4ZDNp2SGQVVWP7svnbbFyLW2ClpR7LQqnu4pV66i/N/XoQGrItO6YqV5ukigc/bt8fLzaiJGI=
X-Received: by 2002:a2e:950e:0:b0:2dd:ccb6:e836 with SMTP id
 38308e7fff4ca-2e95b0c4ddcmr88397801fa.25.1716841300261; Mon, 27 May 2024
 13:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240527201838.1258614-1-tgamblin@baylibre.com>
In-Reply-To: <20240527201838.1258614-1-tgamblin@baylibre.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 May 2024 22:21:28 +0200
Message-ID: <CANNYZj_PnXhX06po1QDj+mqRvc7M4-KgsM5QPQ_75waCS2gtWw@mail.gmail.com>
Subject: Re: [yocto-patches] [auto-upgrade-helper][PATCH] upgrade-helper: fix
 testimage check
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 20:21:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/217

Sadly still no From: line. You need to experiment with private sends first.

Alex

On Mon, 27 May 2024 at 22:18, Trevor Gamblin via
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
> View/Reply Online (#216): https://lists.yoctoproject.org/g/yocto-patches/message/216
> Mute This Topic: https://lists.yoctoproject.org/mt/106334515/1686489
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13197349/1686489/315264618/xyzzy [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

