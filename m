Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF28CE6F086
	for <webhook@archiver.kernel.org>; Tue, 23 Dec 2025 20:11:45 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.108086.1766520697642642533
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Dec 2025 12:11:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SbeslxQG;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88a2d21427dso52979126d6.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Dec 2025 12:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766520697; x=1767125497; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ekRlS0TDnIi+iT3qFR9jxCyb9jpdj7owGtZmX0p6x4=;
        b=SbeslxQGi6xYG/5QlYKYo1EjKTsj/44aNFeCxSQj0oVtASybBn3Z+lYil2Thccu4lF
         YH6J+scvbOAfFiygOryIBkD4KIPPPcbSvRTM/aw5zAx71S7hTwIq6GZOPupBJnEC12fh
         OyfZx5DAawWoE5p/yvhjYe1+aUe73U1zp6NnfOk6zfSkG6ejWxN9UVOLCEsncB8rbzh8
         ROwzr5v4Lp9zHp61TO94c/qlSgSpJ/sYnHbBc7OU6MleezbF9qk2ZLuW/fzVpbrWt7vu
         mIKsZgRP+mupgexlgJJmtTdz1EP0xe0vK8L0QW6upLS8YVHFP0aHprGT+3TacotQoTic
         4Gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766520697; x=1767125497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ekRlS0TDnIi+iT3qFR9jxCyb9jpdj7owGtZmX0p6x4=;
        b=YGRAwEHF6mSnaJWEeQdd29md+CEdUWjs6LuU9TwZ1r09qDlwkBLcqj/4wjlUwe8xMR
         Y4XAfUKdwr1KldpKh7H7u5KT0mjIbLbI4czTp3TOdChUOB/c7BN7er4Nkk8dh1Rt7IOW
         N57RtEKz83gogDoYG1dqfVrH6hYr24IlOkuu5EjwU30nn4wGO1OWI/NHpEtpAbbM4i7S
         jDsdaxUGch4I7AZxvRoqqDdLcNy9sQ3SOHvSwHLK9LIOvbDlc3+2sSiB+rW/zg7woZ4j
         ZXYCnKJBKalV9blVVbI8fdJ5Tu6NzPiMbtV41YZs9xIEwWkqdERGPDUtL++ANh3MaCRl
         OSBA==
X-Gm-Message-State: AOJu0Yxcl4Kwv3V7Y50WEFo51zhfPvG7wMRuL5KssSt0pbMfOBhKzXl9
	pMKTR3cDo5TwYRQS3Kxtoya7NXF5UZ8ZEbEWyQPjpX1RwObc+qRhzkKv9rgLmE6u48cd1dEzxu6
	0hoGrN93XrX1JyBt3aRyAPmrphTBzOmmA/jVw
X-Gm-Gg: AY/fxX4OHNAjyX/P5BWbMRXWr8OlQHK7COltaC1EVBBzVjTBVOoFaLlWQ++fuvnpoJF
	9FB26x2OSHqZJ2A4IU0aSBg/6u4ZpTKIHTjM2LYcTHbmvXTv7AdmIrmtHGd9AULIHQVW5tDPL1Y
	RVrEh9ELBzaXwadEv0uErRH7K67HcynaagoYEJqjwh1k+sDR3ZUcc5i9gG9ZEP4JDOmiTGKDyqa
	GtzHcNX0cd5KNBHXCbzN23MT8sez+bJ5grDiHbDMr3ad37eUj8yaDBc63x5OJBEBTxzMA==
X-Google-Smtp-Source: AGHT+IFwJx/ad/JCnpRfCFaIbh+0rdTkZMJxL0wA2ui1JK4OMOitKxXXhLI9ohfak9v1rx5bd74VuBEQqT7Zx8D7L+8=
X-Received: by 2002:ad4:5e88:0:b0:880:278d:d4aa with SMTP id
 6a1803df08f44-88d844345ecmr267694536d6.7.1766520696566; Tue, 23 Dec 2025
 12:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20251206070923.2254134-1-chee.yang.lee@intel.com>
 <CANNYZj8i7_nR1x+eAt_zXmiYvTvRRNV96YjADJBE87ZDkNSkuw@mail.gmail.com> <a813fc85-9309-4c82-895b-5fb6f8eb8022@amd.com>
In-Reply-To: <a813fc85-9309-4c82-895b-5fb6f8eb8022@amd.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 23 Dec 2025 21:11:25 +0100
X-Gm-Features: AQt7F2oiFHw1Pn7YbrxrTpHZFbTeYFFWV1cgteZ0dEBPSgBxAMKi1DC0rCDdN0w
Message-ID: <CANNYZj-v+8-k2n1o3at5vUUEf=4OHMZUtr9AYo2dU8OHqwrxig@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-zephyr][PATCH] README: drop reference to poky
To: yocto-patches@lists.yoctoproject.org
Cc: Lee Chee Yang <chee.yang.lee@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Dec 2025 20:11:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2865

On Tue, 23 Dec 2025 at 20:12, Sandeep Gundlupet Raju via
lists.yoctoproject.org
<sandeep.gundlupet-raju=amd.com@lists.yoctoproject.org> wrote:
> [Sandeep]: Alex, I'm having hard time to use bitbake-setup, does
> bitbake-setup will clone and include dependency layers? For example
> meta-zephyr-core depends on meta-python (depends)-> meta-oe. If so we
> can simplify the instructions.

Take a look at https://git.openembedded.org/bitbake/tree/default-registry/configurations/poky-master.conf.json

You need to specify what repositories need to be cloned first, then,
separately, what layers need to be enabled. For example, there's one
entry for cloning meta-yocto, and then from that repository two layers
are enabled in a build:

            "bb-layers":
["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],

Something similar can be written for meta-zephyr dependencies.

Alex

