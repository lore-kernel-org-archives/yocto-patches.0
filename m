Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12777CF0453
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 11:06:00 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web10.13608.1728471950037056862
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Oct 2024 04:05:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PFwt+NNy;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539885dd4bcso8391149e87.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Oct 2024 04:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728471948; x=1729076748; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJV4piT75g6KCQLXIPfqtkBQ8+f/yW2EmIrxcbQ9W4A=;
        b=PFwt+NNyU1I+lzQSHukXOo8fe6h3vjQRVCxD9k8idenG4j+DP64fcxXCMK2uoher7b
         Tqz5Sx17KqMXqcaX/w78ljfx/AvsNKUg7CsH/R4PsVyb+U7ogXIu+ksPm1FCxxpSnRNI
         997QCbKQBEIUfRXnV1Mf/68PhWAdmvRzwl9IQlalCY3XmuJzqLdE9OUUb2yflCRmO7ie
         lLi1gG00tG27wl0dTVHWl3eppOtSm2iLiaTp0JHbY/qcAkMsvHfScKUYdfy4wv3orCbO
         xL4pRvsr+r8gpF1MYMQrYn5DOoZ/2N0g5M9fEPTIJbHTVZTXFOFVGGWgTy4CQjuaImOS
         GzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728471948; x=1729076748;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJV4piT75g6KCQLXIPfqtkBQ8+f/yW2EmIrxcbQ9W4A=;
        b=qTVLosJpjrzQdI3o2suWqW4MDsYGBz/w0F9fVDapCbSSFkCCbhXMQvC00Nl86v/37Z
         V0xC2H/kxIpKfxlTbd/01NIykjodym695ADdU+/zx45ym+8/XcF4D3i/kQ/ICiQO437l
         FLilvQMfrxCfDCOzRrfqMImqC6ebY2VWVQoJsOIMeCzPZaa3WW0KMcKQJS23gPhW2bzX
         hbMvERnvv0zPvDoBwnWGw9TIPp0XIr5hiUciisOB7pbBcoAa5W3sZCBXn4UNk7psqWUZ
         zKOCPGxS2Uf+xQ+4CySNFZcgF9qwpcj7FhE67DJbXmlMsL/O2Ur88lHYX8CqwpOharHX
         9trA==
X-Gm-Message-State: AOJu0YxmenYXEpX5ypLN3ejQxl0SZvYZF5PTq+ATe4kniN8W6C8sOhLy
	Xmjm9xIVaTaRupS2taNQhXGU01MgcQUQUeFAn+TLMO+8WgMTaur4ni8iw4ONhR2UwPIJuUpwkrt
	YmTavdE0PCCOrJWszvU1djNnTCZGJUQ==
X-Google-Smtp-Source: AGHT+IF5rOa9UW/cstyvENYderajOyYP0KMjmbKLXlsDQNFRn9zldNRmtfLMGedFDAs8ra3Gp5Vb7urHMMWqcc2ylKg=
X-Received: by 2002:a05:6512:114c:b0:52e:767a:ada3 with SMTP id
 2adb3069b0e04-539c4958844mr1020400e87.47.1728471947706; Wed, 09 Oct 2024
 04:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <17FCC3D507819241.22523@lists.yoctoproject.org>
In-Reply-To: <17FCC3D507819241.22523@lists.yoctoproject.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 9 Oct 2024 13:05:36 +0200
Message-ID: <CANNYZj91GubAR+mJ+swX5_VnCMb+c4GHyNURHofndw=iVUWE3A@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH] config.json:
 disable pgo in python's buildtools
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Oct 2024 11:06:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/697

Actually hold this. On second thought, maybe it's better to simply
restrict the subset-subset further to the tests that still pass.

Alex

On Wed, 9 Oct 2024 at 13:01, Alexander Kanavin via
lists.yoctoproject.org <alex.kanavin=gmail.com@lists.yoctoproject.org>
wrote:
>
> pgo requires running a subset of python's test suite under qemu usermode
> emulation. With python 3.13 upstream added a strict requirement of making
> that test suite pass, and this has uncovered that:
>
> - we've been incorrectly running only a small subset of that subset
> (7 tests out of 44)
>
> - when restoring to the full subset failures occur all over the place,
> due to attempting to run cross-compiled python sub-interpreters
> (qemu usermode won't insert itself when sub-processes are started
> from an emulated executable) and other differences between
> native and emulated environment that I didn't look closely into.
>
> This is not unfixable, but requiers significant effort which I simply
> can't allocate now in the scope of 3.13 upgrade.
>
> Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
> ---
>  config.json | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/config.json b/config.json
> index 13977d9..5d866b9 100644
> --- a/config.json
> +++ b/config.json
> @@ -1109,9 +1109,6 @@
>          "buildtools" : {
>              "BUILDINFO" : true,
>              "MACHINE" : "qemux86-64",
> -            "extravars" : [
> -                "PACKAGECONFIG:pn-nativesdk-python3:append = ' pgo'"
> -            ],
>              "step1" : {
>                  "SDKMACHINE" : "x86_64",
>                  "shortname" : "x86_64 tools",
> --
> 2.46.2
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#696): https://lists.yoctoproject.org/g/yocto-patches/message/696
> Mute This Topic: https://lists.yoctoproject.org/mt/108906627/1686489
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13197349/1686489/315264618/xyzzy [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

