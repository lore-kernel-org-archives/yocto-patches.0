Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B39BCA1005
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 12:51:08 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.web10.76612.1756817465022623291
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 05:51:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EP6PyWiT;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b30d09dab5so56539371cf.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756817463; x=1757422263; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liVHAGnKT0NPzV9RC5ltoFzj2jDfdxo9fcZRwSpYbTA=;
        b=EP6PyWiTZcvlHofXcfDeZWX15Sdvd0l/tOPHZ1By36UaenrvoKnsqGqzPF0z+R379P
         tFdTuJUDr0XrbXJCJhjJ7JG9PtDvDtx1i6kBdQ0c74wtHTM56FNLaBk53cUcdGXIgxVQ
         cSkAizTBdUXK//BMTUeKBovNxAJX3A6pf1EOjv893CijqcuCwPsMmNBzoRhhUMJA46t6
         4ORslHOuNjSm93Ftu4ubx6++BzsBBCTavCnYNAKIhE9a+HxT35m1MjFT+dVQ8o6arGpD
         0MGIuzMInFWAEJQlqKVcJqRrJEQpEvSlqzTMzUnL7l3K2cIs8rD3uoWroODJxrSeHK76
         jvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817463; x=1757422263;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liVHAGnKT0NPzV9RC5ltoFzj2jDfdxo9fcZRwSpYbTA=;
        b=cv9v2z3ybdo8SggetMWv4HzFvEXBvmsZBC/u+Tgz0TOcK67GqnWBSFSwU7bu+HhhGu
         mGkeRgzq5M7I/ovvuhMbtqEkbKSGWmF8xIEF4IfXBpURhdtIQAL/QSR34Zz5Qei596CP
         K2FYl83hPLDq3Zt50Pcogf53LCPOZw6tqsr91iw73c8Ec2IHVhbWJqqslCTTH3Vjrtnl
         dmF2nhJXT8q7aF/NVoJRHenJ0BZrVG8DooUxD+RmCVDgFjLt9Q/Mi+LOj4kMrEURaFf6
         Vb4bjV4OS8lkKPJM3jxF6OBoOB7qF+TYGCY/wQY1d5cTxc7bMU0X0bz662plLN96CsyW
         Tn3g==
X-Gm-Message-State: AOJu0YxKeAz+wWNdmarvMZP9SXWOmlUZXqmR8gXOeKeXcStAx7KOla9u
	eqmzSIvG3ZkDJIVELLwfUWSpHCZxKz5+SwW9CP83CkCHpNhINOXu3pH3jPLZGg==
X-Gm-Gg: ASbGncvH8iq87gbFVhDHYrQl+6ipX5VkiApL2VZWLi0C7yE45LYRZlCbApW0RsBMBZ3
	pi3Y8UbF3+O0jF935Qgl1smj8RHVpCdDK2lp9AFlkSsemxpEh5RAN2OzfQmnU+8PhQCrBk93kM9
	UQkKjNPhapUnc2EmZsx9qkOOLdk7/lFU5Qbw14muTi4FF8h7vdXNpTlB/wx4oeqWw+xGQoodWaN
	WHs1ELETqqpfb29t07zi9cA8h5AIO0tWuLaWQp3okgmtCd765pqaFuqM5RaGaMQrBf2KRq4gPs1
	qPTdOUQvIlIJsH1LRk1id+CyhGg9ZUicbDaD+EJF0/sDdPvezaRvemv7960MAGkYmQj1PbLQB27
	hNszEUm1Wu3ZbC5myqJZ8VAuY/lbBYvVmqSN3bssXINJPd+iWKnv0/2xfIcea
X-Google-Smtp-Source: AGHT+IGVmjVUNf2tXxYgZ26AJ4TP5nxHm6fXnY/p+q9KGrSuh6hKDEWWipDqneclIEk17ePCgGBFFw==
X-Received: by 2002:a05:622a:343:b0:4b3:709d:1f0e with SMTP id d75a77b69052e-4b3709d2910mr6067011cf.77.1756817463077;
        Tue, 02 Sep 2025 05:51:03 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b3462c777asm11456761cf.30.2025.09.02.05.51.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:51:02 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:51:00 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH 1/4] linux-yocto bbappend: sort
Message-ID: <20250902125100.GA7287@localhost>
References: <20250831114105.27494-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250831114105.27494-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 12:51:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2109

On Sun 2025-08-31 @ 07:41:02 AM, Trevor Woerner wrote:
> Separate the entires into lists of 32 vs 64 bit machines, then sort each
> list.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  recipes-kernel/linux/linux-yocto_%.bbappend | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

Added to meta-rockchip, master branch.

