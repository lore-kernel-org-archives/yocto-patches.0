Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E073104951F
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 09:44:35 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17313.1773222269619883480
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 02:44:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E8bm2n/p;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899fbf92bdbso138351006d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 02:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773222269; cv=none;
        d=google.com; s=arc-20240605;
        b=TeVDaiWI5y/9JFbQwaNELDc/1aX6lbOxNMOAtPyPtIwXL6yRf9D1inQVWN/94Pf04d
         pv6MPHMdwaFa7yrDPcBXVDkpGwzduFXUJQT79dxKJI4ioSLxllLkVsKdiXXhNmf8IlN4
         7T+V0bn8LdVdqNK7t45KowQXLF4ltMKB+IEdGS5fzJMGJqIh0ssGewRtag4W5RhxuA1I
         VsbQQNB8fRs78vUXFmZklORfL13UpnRSep7wRBnQZQSyXLu0E8N/J9h7JBCzEA2wL0Ri
         xV66rMx6fQ2cPJn9k9EIlEtgzESE2TkE//W4dqN8VctQgqrnMlC6q3TEYblk5JrrxAyw
         ST4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BxfiaSL5wkqIWGu4Bynu9nlGqSrGm6nJsjo9oc0++s8=;
        fh=/MH4wvhPUtbRPiZV7Tvq3PiOTTSvYSOpadHYMgLRw3c=;
        b=jz/9WAq+yPgOn99uFR2KSy4IpnBbhlpXPP5xxceZ9TyAs0DfBubw+gnJHCNw0XYZep
         jsMwBIUcE35HppyGMtsBznlC3Zvcuah9+qRMWLjgSWLY0cBKlwB8Rplk1f/WO+VTKmqZ
         xTkg1smLzSDRAV7lQbDN8MiM8kwvcEkAnLzk+XNcgnmx6GmlKpMrIt2PfK+otQEbKaC1
         TZpYtqOetHz1rpgtlW4p2/AiJkYVPsflHK2mtsdRyuEugEa1PuRs2tk0lx5/YDD8m4pW
         +5iFD/IpJaLeFrOUhl0pXYuA90MuT3IEeImmc/wIqJ3nM1z+ZELrQkSKW7O/CDrDR8el
         OBQw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773222269; x=1773827069; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BxfiaSL5wkqIWGu4Bynu9nlGqSrGm6nJsjo9oc0++s8=;
        b=E8bm2n/pbQhfu2w+S1oGB4DTZ+keK8EnR7MX2alojhjWAdHTi0L/69Hl5aPUYyyM8Q
         WUK1giMDY5DUmVxv0HWv9DZsF3orS6YpNM6hRdNLQu0oh+pdj+KoBJenlF+IwpY23C7R
         VmPrT2wz5EHRbh1LPSoxmOey0OYlML+m3nBpmWX3Wv5k0xvwF5HPZ/H1X4qKUu+Y/NNE
         D/o+raSqO+RyPEG2pCpcG5mA/6A/pZBcHoLZNPaJTXA47VjRcFw1NXSiIinHMN7OQ9XL
         gVh0XJq5CPwpPIvR3fUe1DDNGW+Vfb3RCQgQHBffx77D+duRLnha7BSngwquGlOTiUSG
         xY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222269; x=1773827069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxfiaSL5wkqIWGu4Bynu9nlGqSrGm6nJsjo9oc0++s8=;
        b=pDsgXYNjqVnQKmT0+pGD7bzXHM2NLk1rJfHBuqGBUpMncXL0lKg6S/mbVwzboHd4bK
         jEV9FBzVCLRvqsLfUL6XW5M3aKgqg43d5b/BqYUr8wA9QzZ/+f9uAKRQDh0GSiKn4toa
         iL6NYIdoBbnJkYiBGrUJZoL2j60l2JBwbouWN0qY8MWe4e0d/AJv5FciGbREbh7hERHD
         dZPL562PH4L6533sZaUp4cZeYUDQPTZ+vYG3/Y/YApQxJPEzK5aRiM3PXGh43m/pK/Xl
         OTMva7M9RXVSNXYnjVL3SfH40XytiEn2/xodEQ8xla3jCsz/T7nhmY084ISmCNcVUU0i
         F0+A==
X-Gm-Message-State: AOJu0YzYzQcbzsI4ivN5S7H5jdemk5OVZrx7Cgj3ltyIf//xVzMqSUIi
	p5wkvB3KIBLRBez4RgKZ25j5iryRIsjfhfds4X03RapIymH8rqPA0HiIC8cz0c/pFWTPL5QA7f9
	+h0gUXPT45F1gcZidkTiHMCLFxqmqyvQ=
X-Gm-Gg: ATEYQzywvc8AhP57VlJGiOqt9DI6Yhg+OQptbpfrnMK/xfuQoN59ZzLAJtYdfR1kUJw
	Pb03KrQ5mhbiZBuA/yZlmmYfWMs8FEYdZZSAo8atw7Gh/P2xtIEbsmCGnFgVrJlJXZzvzRId26L
	qzgWYrozHCIKINklqmlrauqpK4JSejWJwcZTAVDOoZxmmsRLQrYjQnhJxAuwmMiQv+m1BOBUC63
	5NeOulZ5MVWk4IhhhmK55kyR923N53DNNgrDoe6Xe0gLUoLeNd3lAGwysYNOpjeEEBJW+0No80W
	n/6ly6TgUiT2JwXGKlxvfc5hdh0m2EhkXUWjMyz4Se/30RgU9r7/
X-Received: by 2002:a05:6214:2681:b0:89a:3bb:3c4d with SMTP id
 6a1803df08f44-89a66a8241amr22421256d6.34.1773222268534; Wed, 11 Mar 2026
 02:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <189B9F01010B1521.2412760@lists.yoctoproject.org>
 <b8f3d35149f5b2a8e144da24fa6d1b4e777c6419.camel@linuxfoundation.org>
 <189BBF57BD2F5917.2412760@lists.yoctoproject.org> <CANNYZj-Ex5LUpa=5TO6QSHDaSDZTRjRMLUmJsAJzgk3OJhRNUA@mail.gmail.com>
 <294e7021b4370ce4b3a0b9ddac188ca842a9955c.camel@linuxfoundation.org>
In-Reply-To: <294e7021b4370ce4b3a0b9ddac188ca842a9955c.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 11 Mar 2026 10:44:17 +0100
X-Gm-Features: AaiRm532VBWurF-qQzG7KBQRfPOtoj-6vmUHDXwWkgr5F8GprxGlKot_xrnGIF4
Message-ID: <CANNYZj9CBhbBudgMecv_w9KoHN1Hk1Gvjn4=Yc=1c_N-8wgH2w@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper] [PATCH 1/2]
 config.json: Drop vnc usage
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 09:44:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3431

On Wed, 11 Mar 2026 at 10:39, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> > One option is that the test would start weston-native in headless
> > mode, and direct qemu to use that (via WAYLAND_DISPLAY). No special
> > setup needed on the autobuilder.
>
> If you have a patch for that, I'd take it!
>
> Is weston-native able to build and run effectively currently?

I don't have a patch. It's all thought experiments, triggered by your
email :) Weston-native variant is not even available currently.

So please don't hold any patches, as long as we can maintain existing
tests. SDL/Gtk qemu frontends, and accelerated gl pass through from
the guest into them are important use cases.

Alex

