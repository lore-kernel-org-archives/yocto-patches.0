Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27B7FF885E
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 09:51:59 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40294.1777283516023365410
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 02:51:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lK9EDW6F;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a0323830beso66308566d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 02:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777283515; cv=none;
        d=google.com; s=arc-20240605;
        b=UkKaY97dtxWCzvjp+33vAMVG9Ggry6flE9zfUksE/tcUBtW4cS+8NbpZaJ/LdG6ey1
         I9NXShGKpr2jjU1d8+Ml+GHQY072AXfXZWHuCaDlc1sMHG+Y8e3prXG+NI8+Bmssl2tv
         HfB+CHcxJRvZOKxqXxAWXU7MzMNzFswnzobyYyrTF3NeIT5I205t8RllIxJva8taILrx
         l9NHAgHWJhewMaIQBgNO9bJKdVtEaPTlj5Oe9pfskeff3ZN9gvUicq52Xala8moYAviJ
         GpDYmKrL+3Y/9xHqiX+u+KoaC4HT4oAAjNInfak+wL3exfl83e+iqZS1V19d+8u9QHsE
         04/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QsfP5hhXzITxAxM4yWV7wGbZqzObEkcuiwqBnu9ziu0=;
        fh=B6+dp47eghNzyj8BrWGHk2n/ObAtmJy/gW8Hzrmb+f8=;
        b=bkN2FHRYI+MwxZzNdvOf8C+7try2PW1SSpy0+7IzqbDbc1f/Yqblcx78XtBl8P6xBN
         U6PpRkXioVH9xvVIgvO7+9X24cDuFeaEAeRCbXrb+2Gxh0iWKrlVRkTx2eeCXOvpOQ3W
         1h7c0dXmSeOKt0xzQfpWnsqo1290JwhN+7d2l/0fJwn/RkgBrPboxVqci7a4XymKv1e/
         nybsXR+3+JJUw58IszUM/bZ4+/NxpE6LN15mT3x8P3Uu9iOQ/qKPU7H8mBzoTNc63E4Y
         e7McULr/oB1Ytcjxi8+VpwBy+AYOfy1k7aXOdauR9IXHLPumJ6yIjYLfCPC4/0/q+dZU
         sdcw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777283515; x=1777888315; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QsfP5hhXzITxAxM4yWV7wGbZqzObEkcuiwqBnu9ziu0=;
        b=lK9EDW6FnxLJJRGVSX8cjIYAZVNZgKYGfoKzB1taIpQHMirOUOwrrD0xwi6uzm5M2r
         TdzjQjc3vokVMbVi1186MvmApfl4dALQ7tpBHWNxH4EE6eyjeHXO4JFCMvBV9hY2fJNu
         QiFpzJtvAqUx8UJjxrabOSLkM7nq5Pt9utlc+ns27NY4Oe/C1nY+1Fu/gnZTOo8sNQA0
         aJYSNRD1Hv+YDoV5xmKrE3b8nLJUOO5mNk0BhxJT+tqRd59Wy0Bf7QM78qG5xgwUyJpZ
         rV0LswcV9jEkYbg03g20Y8Az1ep3pjO/pntBQoxYN4YNoR//9ThK1dVAf7xjLVWCLIJ9
         NtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777283515; x=1777888315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsfP5hhXzITxAxM4yWV7wGbZqzObEkcuiwqBnu9ziu0=;
        b=X7OP0tzSIP5ayRSY0QIG8Cps+4CBcWrYHZ8N1kYyb21EiKmQ9ftL3lZRhW/C+knlk6
         2KIpxelqkMmXS4WZr/VnoULWSNkvWLoCJ4aGftMO2rqtTEVTFXFMnvO8Y8hGiOcw6KUq
         2Jn7J7UKuo6PbKksgjUG8IbwAF46Nkx16Yv3qbx+qLwu59PK97/YuDcnigKZBj7tcgSc
         w7nqZzVCXuzZJZzfxR5j+Z7XTurF3oxXsEMn3RA86lXmhDikEWuDk9BBnBs96ovGN9++
         HrbQNHXmy+2zm/4Zk9LYZocz2ruyONpi3rWXKYlTzUv/5sKC00w9O/lJd9JV/Q0oyRUM
         OYBA==
X-Gm-Message-State: AOJu0Yywe1VQBN5+QeOk1KRrX6G/hBgGlxwMYH63QSocmht3ElYm2XGJ
	czFds+pjzgiJFc5befV1N2akEgk/uAU0Q5D9IzR4Br5ll14oOfMo3Lf5/oF0wiFx0y89W48uiRH
	vzHj1B783y6wSwhPBv6rvjlLrz2lIoi8=
X-Gm-Gg: AeBDievcgofY5DJtcBreb8I5hwwhOyKtYEmJz+HMPcYKdXmEo1q+soqCGt9ObFWLDxw
	tEn0bVNxPd9f+O8HnuFCRE+MJS2kyVCVOWl/xp3aiWeaMlb9UBeLTjWrmu6PN0zPrKLU32U9D5K
	koNElB8lhUjEVyoq18Ew/utS+Bf2unSmhckepV9FtBsOYxPnTBi2pFUX7Jl7WLINkeKh/vP4k/F
	QjMTuvJIlTgUQWbgbB9qil1FLqbqhSnvAXRjXMfOLu8b3OTa7wm5Yq3Gomp6jDZuAVWBIH/t9fp
	FYIH9vitQmg5xRfLOlK6/RGKwTuwVDnFFH0Tsq9OCIzQ0NyopIjpFU4/JxIPPuU=
X-Received: by 2002:a05:6214:4507:b0:89c:c3ac:e5b5 with SMTP id
 6a1803df08f44-8b02818e863mr668310556d6.23.1777283514888; Mon, 27 Apr 2026
 02:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260424114603.2444938-1-daniel.turull@ericsson.com> <20260424114603.2444938-4-daniel.turull@ericsson.com>
In-Reply-To: <20260424114603.2444938-4-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 Apr 2026 11:51:43 +0200
X-Gm-Features: AVHnY4JEfNFDHc9l-tdfOmzyYDwWdNQqqG7qfPDCNvNid9_bNMmHynm8ftOWa4o
Message-ID: <CANNYZj9hfFoUiGQP+AxDFd2Y6g24h3O4aHGLBOAJCJCmCcgwyA@mail.gmail.com>
Subject: Re: [AUH][PATCH v2 3/9] upgrade-helper.py: allow to set the git
 directory from layer-dir
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev, 
	ross.burton@arm.com, yoann.congal@smile.fr
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 09:51:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3832

On Fri, 24 Apr 2026 at 13:46, <daniel.turull@ericsson.com> wrote:

>              self.git = Git(self.opts['layer_dir'])
> +        elif settings.get('layer_dir'):
> +            # allow to set the git repo directory without enabling layer_mode
> +            self.git = Git(settings.get('layer_dir'))
>          else:
>              # use scripts_path to get oe-core directory
>              self.git = Git(os.path.dirname(scripts_path))

I don't understand. scripts_path is set thusly:

scripts_path = os.path.realpath(os.path.abspath(os.path.dirname(shutil.which("devtool"))))

What is the layer layout that causes the 'wrong' path to be picked by
this? Either you use integrated poky repo without oe-core, or you use
oe-core without integrated poky, but you shouldn't be using both.

Alex

On Fri, 24 Apr 2026 at 13:46, <daniel.turull@ericsson.com> wrote:
>
> From: Daniel Turull <daniel.turull@ericsson.com>
>
> Replace the assumption that the poky directory is the first PATH entry
> and reuse --layer-dir to setup directory for git repo.
>
> This is useful when not using poky and each meta-layer is its own git.
> Without this fix, commit_changes fails in non-poky layouts:
>
>   git add .../openembedded-core/meta/recipes-support/gnupg
>   fatal: '.../openembedded-core/meta/recipes-support/gnupg'
>   is outside repository at '.../yocto-scarthgap'
>
> Assisted-by: Claude, Anthropic
> Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
> ---
>  upgrade-helper.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/upgrade-helper.py b/upgrade-helper.py
> index 98391f3..df927d1 100755
> --- a/upgrade-helper.py
> +++ b/upgrade-helper.py
> @@ -184,6 +184,9 @@ class Updater(object):
>                      _layer_settings_error(s)
>
>              self.git = Git(self.opts['layer_dir'])
> +        elif settings.get('layer_dir'):
> +            # allow to set the git repo directory without enabling layer_mode
> +            self.git = Git(settings.get('layer_dir'))
>          else:
>              # use scripts_path to get oe-core directory
>              self.git = Git(os.path.dirname(scripts_path))
> --
> 2.34.1
>

