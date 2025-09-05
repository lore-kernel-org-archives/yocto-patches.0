Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C24CA1013
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 12:52:46 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web10.21012.1757076766067495780
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Sep 2025 05:52:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PbIIIhCw;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7291d89185fso9692336d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Sep 2025 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757076764; x=1757681564; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k78MHvyH08JF4kg82KFKWV8rF37UinIcaQEOhlKtQMU=;
        b=PbIIIhCwkpnQxTPV3SUc5uwCZnalMe6ci0hIdip/q6m0XRDtwvAdn2WYvyVOdQPhho
         /NmsIELvapJrruTH9rY1QM232AheUN4ScSZdmubB1MGFzX7qHYYzI4WhvybMJ93eZNBw
         kBTtMLwXSCNhCF47CFn26KOfeZYeQGws22K0mcW01u765/ijqAIdH4DJMCigUrOwU1l9
         1C/IGeyauZ9BZsCvzjbCjyIWnaNeNYT1ugxNIlaLbBqSXkxCn0zf3jEMJuUMuf8GdPOW
         Q2ktatUqHkiL0ejoq8B4eQ7BeuRXKs8cDs3dpQTcRd59d4PE+pknlHkugWkTJnGlWzju
         kNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076764; x=1757681564;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k78MHvyH08JF4kg82KFKWV8rF37UinIcaQEOhlKtQMU=;
        b=Kf7em1HHYvbdlQ5RrB9CCsks5DrzmV+m4KySzYrfVUjWeNqlJMgyG8j5ZQChtCBle9
         mMFrbkl+ZhmCUSnRWUfTYVNsFW7qQ+HTio7igdRAx6Xf+S9NFn1xM2yI9MT8SkK7Ndr6
         KERC/Z2+0j16CRx6iDo6gMbsT8KTYtT8Hs/lNxY/twvEEnRWzcut7yD2OZI/TB7mmjL1
         mf4aWzuX45ipwg48latyj/V36INcIMdPbeRU21S8MazdgToD70eGhFhPu7/2Xo4l9lga
         D4RagDQ2+Q0K0zq1KEEtKNFOibkpgwmzKqfaln4K5RCSTwsXuFsRTJBw8Qiw+3jSiLYi
         4GJg==
X-Gm-Message-State: AOJu0YzM3uPpdBFsaSGObvdI83dZnIUFn/2e7ZApVUx6P3I/3PJMYRD3
	2Tis0Eh6zkFZB9Gu9TK40YHlvkJS5DS8aaCwyRnHqmE0wFKurmbjMwtZNIo7aw==
X-Gm-Gg: ASbGncsfGufhlphRbJN/GWCCWXAegSEbw5aE9ScvD2ooQtWzIYrrKJzUy8+dN18iz/n
	h3pKdgqVK53l7fv/xSoAGnswlhigZD3vclhBeX4dCQYz9FeU8Auc6AghZjuABhvjCyywqUgz7YO
	dcPmGeLMTU6LGlRxzwYtfqc0uBC1r4XEU1yf2MQ2mktWjJWemeBKrlMSG5eU/fHv/YU8yFHWsMp
	BiNxGh8g91IjIdQgklqfNKrmclyYZDA5j7F8g6C10Vpm8dEMt5SjeEVUp1LMZMeh8myztXK4+Y1
	gv1FsEIkA+CqrWdnhDxD66SaSPeNIx0Oi7qU+JWYqnO6b67QppIpwD0pM0qK0Z6qfKYF0shwQsx
	9IWFT27YX51pbkPD6ueTrTssCOLO8Y6diT7ewNKZV9T3QPp7YRg==
X-Google-Smtp-Source: AGHT+IFVK67nf19NKUJbuz1zlbNZih1O7AKUOk9qwCfSVVy+9Gyd3QDl/fgamyeAbaBoseX6nqIjzA==
X-Received: by 2002:ad4:5be4:0:b0:728:f7cf:910c with SMTP id 6a1803df08f44-728f7ee16d2mr63110636d6.13.1757076764252;
        Fri, 05 Sep 2025 05:52:44 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aa6e497a7sm472916085a.17.2025.09.05.05.52.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:52:43 -0700 (PDT)
Date: Fri, 5 Sep 2025 08:52:41 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH 2/2] nanopi-r4s: enable r8169 built-in
Message-ID: <20250905125241.GC36766@localhost>
References: <20250904194529.22656-1-twoerner@gmail.com>
 <20250904194529.22656-2-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904194529.22656-2-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Sep 2025 12:52:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2143

On Thu 2025-09-04 @ 03:45:29 PM, Trevor Woerner wrote:
> Since the Realtek RTL8169 is part of this board, enable it unconditionally in
> the kernel.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  recipes-kernel/linux/linux-yocto/realtek-r8169.cfg | 1 +
>  recipes-kernel/linux/linux-yocto_%.bbappend        | 1 +
>  2 files changed, 2 insertions(+)
>  create mode 100644 recipes-kernel/linux/linux-yocto/realtek-r8169.cfg

Applied to meta-rockchip, master branch.

