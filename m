Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5527CCD193
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 11:50:16 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web10.15989.1760961015355324880
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 04:50:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jUGqAh1G;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87c103928ffso64961466d6.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 04:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760961014; x=1761565814; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OyPaDEA3ruykRJ3B1YKUT8u/5NZdaCbfQp4S0COi8AE=;
        b=jUGqAh1GBETnFdrfGTOzvhNk9bTy1kzfzafLCjVdz60eRSLpmC6Stot1QSqvWZtijz
         VYfK/xruN/wHhO+ib5ThChEI4JDc3bGyF0jCitZ9DuztJK+FNmm/fSPRVYRD48XgekSy
         Wlx963037nrbCRItanUwDUpo+1oYV8Qv0L6XEpORKphjQVrvKaP+/ZO8gdODJekX51DW
         jOnEY80K8tkQicA7h75lavJVn96pBaYK/Oy8w345YhnKRvL/6GP1bqm6Tfvyyip3yeWY
         zWzeFcMci+u35iR5YqI8RASOUPOmdYOf4s222awMOrwEoN7MxRc1mn7XE76rCk1/SJeN
         00NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961014; x=1761565814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyPaDEA3ruykRJ3B1YKUT8u/5NZdaCbfQp4S0COi8AE=;
        b=IocHqHVClvqr0s0IYebNAzk6W9L74fKXcQM+9p80kndzKN475i6qgdkXdtRVFyQNHS
         RgPx/WahYfSXd9SQdeikPbUOMeWbTheikdjN/ZCXCulFSgUnSb9P6G+1bV3ndInN6XrX
         /OPzGKJnb+m9mvux8XVeK0a0fVIyjlxZPkTbRQGDvn7rNGd6e9QT8eftUhXH79NTzg2x
         pPRuYxSUmKZAKWdF1ut66h3EC1Cm18y2QtfX/hOTt6MGC3D1t9Uoui+AurtU94Nt0rzm
         3TkNHR5roHK+njdodgm1vZUNUQ3f0z5UWFEifBAJWMbTYxH5AxBxszwiy0bc1fLvdPYD
         tuqg==
X-Gm-Message-State: AOJu0YypkiZ9bqtqHdp9esjFP5Qjh6KYtJpXRTUnRD/v81W81CFTF7AA
	8jdK9HKbelg9TnF/BKUEl/E0iqiT3U/Hpk5rSKCPMqerfOy0tm6Q1Lbt5jT/L/yOP2ZD/RzXwFW
	/ynviASkVsOyvQ2JTGiDSeZ1ZHVQWDQ5fLg==
X-Gm-Gg: ASbGncudPCax3ujkl/3iUl+GCS3wbS2Y4PmmhlIKuNyBxy/1gKEtkmUIwHJz9XyLzEJ
	SULu/yy4KCDJmBNVclZlLUYaqH2elyB2z8qcL+sWwAJI+xxIsuOD7dCNTykg/WF1Y1v+k/qCaGV
	lm7FCsAMTHhOuySG9YJFtaO2ZcPkDnrI1NuD2KgDsunpdgmuQySzgrzoFiGqy9lsG2ZkWajXLen
	37YWAdFX18TrwtsQW1WETZTLtLXRR7Uwnoupi4t7HwE9Iqitq6x4TqM9Ma0sP626DYpzPP4pnrw
	En6Adm10HpT6Pr1G8llFzsVvI304sngHnv9umnELShai2Yjq6fyDqEeSvQM0+gY1F0SQJjdo0fq
	RBg4qnJ1B+67Kt2+2XQ==
X-Google-Smtp-Source: AGHT+IHXBfuAaVA4b+oOrr17/LHCJuDKZ+0SjH0CIG952OH+v5hxAeX/D/aBn0Qsojcykm+6liR2rMgMXttKmAlernU=
X-Received: by 2002:ad4:5c61:0:b0:816:10d4:e50e with SMTP id
 6a1803df08f44-87c2057f9a9mr164214696d6.23.1760961014269; Mon, 20 Oct 2025
 04:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102344.645363-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20251014102344.645363-1-richard.purdie@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 20 Oct 2025 13:50:03 +0200
X-Gm-Features: AS18NWCGRuA_CFK6AuwtS2LfjIOI6w5vwj8TdPdRPRotFV4eckgy6INFGdVut24
Message-ID: <CANNYZj-KXPZ0dOLoHTuVmnZoXtKy0eJ0Rgk8qmm5_FFWfFVcCA@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper] [PATCH 1/2]
 config.json/scripts: Switch to use bitbake-setup
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:50:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2366

On Tue, 14 Oct 2025 at 12:23, Richard Purdie via
lists.yoctoproject.org
<richard.purdie=linuxfoundation.org@lists.yoctoproject.org> wrote:
> +            "EXTRA_IMAGE_FEATURES ?= 'allow-empty-password empty-root-password allow-root-login'"

This should be in its own fragment, and testimage class should check
that the features are in place, and print something helpful when
they're not. Probably the poky login banner should mention the
fragment too, so that people aren't baffled when they expect behavior
from the old poky default template, and typing root without password
isn't working.

I'll come up with a patchset. :)

Alex

