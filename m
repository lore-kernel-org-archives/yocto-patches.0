Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B1EC27C53
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 11:41:23 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web11.18569.1718797282952421933
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Jun 2024 04:41:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=J7P3Bxlf;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44051a92f37so5942281cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718797280; x=1719402080; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y9ZDcdY+jHdOsOwfWJV5e7E8epZ3r6gyXSMtZtxBqw=;
        b=J7P3BxlfsYIjgghYBdOE/yRxH1FZgKZwHIblQ2/SacsKf8ym53CapzIuN4T73OdTp6
         SACeUuHeB6J/5bFZVDZtt0o4zC+Afjddp5x2PoiyuXzWzJytMYDxeExjaBI3wKkZmjkH
         1TzKXhf9SB3V8Lish9mB1SB0jgYo5iZzlvf3I5kzzjaCiO5glhsd3Td3S0I9rjoIqksC
         UHLcX7fTvPFeHNabEzJ2w+hmBn81qwZpv6t3QUUvkOBi8SOIv6jG+A2ilTir9OjzawEW
         et/yFemb5oIdLYggvKGI7J1wQ42hihlZrgAAzFaq0qONqQJwd+lZp5OA3l384V2fhTmj
         aJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718797280; x=1719402080;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y9ZDcdY+jHdOsOwfWJV5e7E8epZ3r6gyXSMtZtxBqw=;
        b=m86HZ4z9vppT4gpy+hlfr5v1q247StyTPlz9ERkgFL7MjIRdKzvBoQm+QLccoEcC6U
         9T8qpqW+lDwIFqC1FO5PJ40jb3Trm+KEahrvMkio75sRtGDswxCDlYlYIEZa0GyHYola
         C5dNK1wpZCSaK9VR7lMhqJYhrRg5DNtZYDH8KBafrbxXzMWe3TwjDlRKwLlQVyO0jvhr
         rrRHYLPpZxZtZZU8oNoJQGsM4+lvN5L2KoY4ImPeLfxXGaEziBp/vmEoKb3tVcl5Cz1F
         7Asq13bU9i/15A8jTU+Q9jtWTFoV4BFUv/oCzGReFcCCBbXqa12Ek81qKN7Jsp7Ed6jB
         Vfug==
X-Gm-Message-State: AOJu0Yy06BkK6ooZab8KJx8SyzuCaXnjaiXIctGv5nUoj+1NeBj5y6vw
	wilI3CzBLmqh5JL0wduGBpLVejCAkF9sZnkhURqf2iH0qcHNMFHf5IuHOQ==
X-Google-Smtp-Source: AGHT+IGdUEP/XqwTELEcAPCYTRpCWu0cmvSrF79Cmp6+DpGMQkIaXMOCj+QUrhmw2VOHroECWOp69w==
X-Received: by 2002:ac8:5d4a:0:b0:440:2a5b:ed6 with SMTP id d75a77b69052e-4449b8cc933mr92539551cf.5.1718797280230;
        Wed, 19 Jun 2024 04:41:20 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef4f1e3csm64692661cf.25.2024.06.19.04.41.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 04:41:19 -0700 (PDT)
Date: Wed, 19 Jun 2024 07:41:17 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH v2] linux-torvalds-next: use tag
Message-ID: <20240619114117.GA7390@localhost>
References: <20240618171619.9303-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618171619.9303-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 11:41:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/349

On Tue 2024-06-18 @ 01:16:19 PM, Trevor Woerner wrote:
> Use the tag name specifically; note that it is no longer reachable from any
> branch.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  recipes-kernel/linux/linux-torvalds-next_git.bb | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Added to meta-rockchip, master branch.
Thanks for the review!

