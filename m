Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7F0CA1005
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 12:52:48 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web10.76651.1756817562531792728
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 05:52:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bmAxM0EN;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70def6089b2so68167426d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756817561; x=1757422361; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9t/UseR82VMLFzjJ8GSlu9/ztYohtxtEydfPLALbQQ=;
        b=bmAxM0ENXO/c5po1TLHhVY1EBNoNhKWEMFmrKi8RH2uu3gfJZBnnWUkyTlFcfLESkI
         COsGMGBKs4nSDiou/iuG6q7CMibkn26i505ij4i8DtDel21VfA7x0H9KP08lWBSj4ajX
         3jv3ZB0ilgItRyenDIyNAgzevs0pfA1BZLglBQcpQB5N8ECoA19qiIdfuC7/7ZwyMfRe
         KajfqLkq+qUiW0xeJZRWgrF9T4bXzvIDD6Y+vWE/WkGA8WzC5dDYNFj9ivQJnVPsberO
         OBbNUgsezZRvdUpxH1LyTtQ7DEDVTCGSDocGKK/JVfQu5R1VcLi9ZvBSd1KMzEbtAgM8
         Z4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817561; x=1757422361;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9t/UseR82VMLFzjJ8GSlu9/ztYohtxtEydfPLALbQQ=;
        b=kXodfD2yi63/G61lSoaAHtqIr2hpGbMa6zq95c587xysOyVfjFBTJWswITGHcF5LSB
         SrNBV2Oh0CsIc6JlHpsS1cNSIE8Z2+449+A2Ed2zCAoZ3Rr/gf1ws0Wt9y/o8mjW/nmJ
         Gh8QXqJMf3F2LdXE0Gxogr9pNuxAnxNTcqoBtPPmRjkpqiT4ICi3w5vr0a2d1OFQaWl4
         qnZA1lSO7JqaOdIU5lswUyk23qrJ61Li+WvyW/YDkvyEX3YO0roxitJPYfh0KY9GkMWK
         bT+aZp+DHX09ZLaynJ+qQH0zO3dpOcQhpHYZ1cgI8VZAYpPd4k18IDL7rvF0C1Y6O2Ed
         bXGQ==
X-Gm-Message-State: AOJu0YzHugORUdAyQnrTWrA/nluPoktYcWXIUmdl52W43jh1nuwla2qJ
	X0Vxy43vUMUQanR22KowOnyFW2IVuki+gM++dvgxQ8o1k8mg5QdT3inrIERP2A==
X-Gm-Gg: ASbGncuhkYy8IRsI7gBfiDKfB1NiGst86vrVQqRtB6Gm5fNIPskVxGrDZJAATkR26HA
	3tiMPQ0kOFa36W46MiJYZHfGDkhV/DNGZy/S525jskG+dDAYKDhMgq49WQB78BrOqa8PngHFW8/
	ry+2wdXp9LjTPNHmCEwT82KoQeMCjACOb9DCKyPx+iJ0b/lu0RTxqr+Lm3/l/9tax84o8eRjzIx
	NDjaiYxlRHWQZ0ZdVNc9jxd+e2GEF2H9wNE4/1/YYk6VdwhRhhnrxxdSZrxzyDCMw7HzbPa/8JE
	5tltRP2dx42uc8b8xuOvZV6qJGe28cPBW3fyj5F227XB30wtMLpQ8d0JnM1ewcGi4qJRv5oEgMe
	Ts7IwQbMCIuobApQa3iQeVxicFenKjHqdU2EXo6MepO55JBWhAzKV9AU47cj6
X-Google-Smtp-Source: AGHT+IEkPLIUFa5IN46D47+HRMT35S8vDuEWrROz5C1YFKWNQiwl9aS1TMFj9qw57K5lcYWoAo/l/w==
X-Received: by 2002:ad4:5ae7:0:b0:71d:9d4c:1907 with SMTP id 6a1803df08f44-71d9d4c3002mr51964016d6.11.1756817560851;
        Tue, 02 Sep 2025 05:52:40 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b4947b0fsm11309226d6.46.2025.09.02.05.52.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:52:40 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:52:38 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH 3/4] orangepi-5-plus: use non -dev kernel
Message-ID: <20250902125238.GD7287@localhost>
References: <20250831114105.27494-1-twoerner@gmail.com>
 <20250831114105.27494-3-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250831114105.27494-3-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 12:52:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2112

On Sun 2025-08-31 @ 07:41:04 AM, Trevor Woerner wrote:
> Now that 6.16.y is the preferred version of the linux-yocto kernel, the
> orangepi-5-plus machine that had been using the linux-yocto-dev kernel can
> be switched to using the linux-yocto kernel instead.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  conf/machine/orangepi-5-plus.conf             | 1 -
>  recipes-kernel/linux/linux-yocto-dev.bbappend | 2 --
>  recipes-kernel/linux/linux-yocto_%.bbappend   | 1 +
>  3 files changed, 1 insertion(+), 3 deletions(-)

Added to meta-rockchip, master branch.

