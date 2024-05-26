Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF714C25B75
	for <webhook@archiver.kernel.org>; Sun, 26 May 2024 13:41:26 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web11.6746.1716730876645395166
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 May 2024 06:41:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QCvpBHBf;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-794c3ae6db2so705085a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716730875; x=1717335675; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSZDYbkkRJk7no6OnxjmpmNEYq09IJ4ERqWhF9WAw8o=;
        b=QCvpBHBfkOTKA9G6d9MvIGz73SqJDjvUaiKqZQyt5pW9KuUDuwhDel+ndnt9Lj+qAg
         KdhDGQZ4Ui9+rc8bXWpLZtWVHmBfM8oGmnz0UQ/oyrJ5vX0xhqLbcS97OHIgc3eXM0qm
         D3zknR4GWGvzvLAKtLOMpu6xUvTqxmITdCGOpXqHzb889rs6ixMvms2cp0cUtpGnQ6Oy
         Fl26Z80bwqt/IFBibWPEFDSNXvWengfCWqxOJRwtLxgwMnTSnBiJWWx2bjR8GKHgAEPB
         oaqXwH7a5qqK2VuRGs+emzJtSQnOdj8MQ/BPuZU5cVHzY5d+lQOPfqM3q1KX+aSNqXSK
         naEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716730875; x=1717335675;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSZDYbkkRJk7no6OnxjmpmNEYq09IJ4ERqWhF9WAw8o=;
        b=HE+6Ry/yypy7qOgunmS4vGlATlzLRMZ1Ld6VgAUYJLNe5keJ69B19/B5pwrLoqaAZ2
         FDRx65O4i8Jf64ontu111pWhtVgyjHLq8ppfuX5j4t4MfqkdFKEXFlEOttXvvZcSKOGW
         5jRg/VSVYm5V6ie/p5pNBj+0m/lqdWTtDnbLwmAYySulT0lySJ1Amq1VwnISrhLBKTzG
         dxkFYiBqJptP+voXtN2HcuvPn74M6NynCG5uyjOI1E1UwN3dWgBm96iis/QnVLYmpRnT
         dGG5N3X50F150KA4grK2LOJyZ376mndJbL/elHsHzenSYmW0Jm8Vb2aLu549NuGsJ45c
         OKRA==
X-Gm-Message-State: AOJu0YxO2H8WAEuMyd1A7AFzvRRpdalJ6dfsInRgrETW4B84RQCmrqZn
	r5eaLfxIY0XM3aUug9HvI5YNAja7x44ea8dHOB3sV7gWCukictxNzLEC7g==
X-Google-Smtp-Source: AGHT+IHbgo7+7Tc6Of3MSyFjmgr5rIphvC7Ptn6PsV4UDTJiMAwoXz8wtJ53JF3oVuA9P1lwR1SJtQ==
X-Received: by 2002:a05:620a:535e:b0:793:f38:c486 with SMTP id af79cd13be357-794ab05ae46mr678920985a.7.1716730875053;
        Sun, 26 May 2024 06:41:15 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca58e6sm227254785a.18.2024.05.26.06.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 06:41:14 -0700 (PDT)
Date: Sun, 26 May 2024 09:41:12 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [PATCH meta-rockchip] add basic b4 config file
Message-ID: <20240526134112.GA16482@localhost>
References: <20240524-b4-support-v1-1-2e6e5d84781c@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240524-b4-support-v1-1-2e6e5d84781c@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 13:41:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/204

On Fri 2024-05-24 @ 03:42:32 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> b4[1] is a very nice tool for mail-based contribution. A config[2] file
> exists to set up a few defaults. We can use it to set the To recipients
> to always add, in our case the mailing list.
> 
> This shouldn't be necessary if we had a script that b4 prep --auto-to-cc
> could call to find the mail address(es) to send to. While we could do
> that, this opens the door to people trying to add a way to notify some
> people (e.g. a MAINTAINERS file) which is not somewhere the project
> wants to go right now, and this also makes sure the address is always
> added even if one forgets to run b4 prep --auto-to-cc (which is part of
> the typical workflow for U-Boot and Linux kernel, but is not necessary
> thanks to this patch).
> 
> Additionally, automatically provide a default prefix so that one doesn't
> need to not forget to run `b4 prep --set-prefixes meta-rockchip` for
> each series.
> 
> [1] https://pypi.org/project/b4/
> [2] https://b4.docs.kernel.org/en/latest/config.html
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  .b4-config | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Trevor Woerner <twoerner@gmail.com>
Applied to meta-rockchip, master branch. Thanks!

