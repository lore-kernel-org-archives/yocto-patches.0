Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F776CA0FFE
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 12:51:38 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web10.76632.1756817491381012548
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 05:51:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ApJrjzS3;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b38d4de61aso1787731cf.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756817490; x=1757422290; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGJo1tHJ7zABZQHNaH2IMErA/TI+VEzNFzu3nDJBwrI=;
        b=ApJrjzS3mAkm9ocF8N8YI+DNgE0BdA5tIOkfGOJN1gviS83w9sAvBibPUfOCwLT1nv
         CnUTu491wNgny1iej5kj3TkAfuc3TgtOiMArfzXIsidjrkfRNl5bnnBowhaHkWJzEwNS
         Fdj7qvw3F6/E0JA1K7CP4DgBAOAmhSrylE7YZoeNstPvHwOZNZ4rpUzgrM57I8ZmnRP9
         +LrpBbFj4fgNfR7pIWWlq06NY/mYLBkzYRtkMO7hqITpDOss/v+NaVOZ0j6BE8M9KPLN
         3qC0g+nTJo1Os5r9AE4C9csXgaB0OVQoZmO33PPjiZwSAajulWzAEIZVVJXgx/nn4e6r
         BGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817490; x=1757422290;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGJo1tHJ7zABZQHNaH2IMErA/TI+VEzNFzu3nDJBwrI=;
        b=VZSLC7XJS6ksU3TEWaILkbBCm9cJy95UsALO5Mo8UBYg286nhXjM9q56QU799fu2qx
         tfClarO6O2nP921mGJqbyMkbhK94fMao/B51wdyvH853EPbxkoGQW6jNTg6iKhGxgzrl
         NE8SDUWzmbPp4gS3t8l3WKaq3HkU5DJwN3DEbAhRN/buPqxY1atFzZJ7dtX1qV0Y3ZLO
         494qNVo1BZmqKYG8Pfw01QwvrJVH3Y3MFgGvZ1YsBoI4sa4XWReSI2aKDgFUlJMgqFNy
         BRCDGBuuSJXF1eBttpRwFXaE/gtV/B+YxKRyXCgqWicQUgNy6WXpJK8FjdLkz5e2WFSU
         R+IQ==
X-Gm-Message-State: AOJu0YyyaiAu2sBVItXW3ZEynP03b08+IvFXV11hiGL0/MTvWg1eHgK8
	FPOwrKpeEFwN7A3iXG7tg0VNcwR5GURU5EsBWmWF2h1K/Hg6wx4qVCSf+a4MKQ==
X-Gm-Gg: ASbGncvw+GlG7up0UuL4+m9VLc73ayGPZ2E4l+njlvIJ6QBdyCPonnBacpxbJbwqh3g
	BeoZxoe8h7il2CLacmzqz01Euf+PpQostTnQcBepNuv81/KQQ0ayP32AC/kK26iKqdaR4oX3Ftr
	6DWyiAcB6quRJXyDHNomVsjxjXrkqwXvHC3w35gG1a8DncSeXmOv3s6RKaqbwMmBQ9OtLf933Z0
	GCa8/9izrzJdjteZUzfJBpVLxq38/HsQYBzV4JgLVSvRLaqEXiltz28LMUhXdJE4JgA+SrG274J
	jTBYme78ZQ8WZsqpUoiGEugyyxxc0hvibRPAeH1B511BAQifCyLvNIWjlE7QHLoXfZaR5GSyTAN
	TPsAaFTVOZF9ZGzpaNR3El0M5l82jULdn/GDfz4mCZXaVURkPqQ==
X-Google-Smtp-Source: AGHT+IEEXVTV6aT8kEbcMSsblo3e2+GIqsTtqXTJVGsDG09Uu9drTRpXKT+K3gnTWigtnU39zY/9eQ==
X-Received: by 2002:ac8:7f0d:0:b0:4b3:eb8:f6a with SMTP id d75a77b69052e-4b31dd858aamr118008211cf.82.1756817489700;
        Tue, 02 Sep 2025 05:51:29 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8069d7ad93csm129653685a.65.2025.09.02.05.51.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:51:29 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:51:27 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH 4/4] nanopc-t6: use non -dev kernel
Message-ID: <20250902125127.GB7287@localhost>
References: <20250831114105.27494-1-twoerner@gmail.com>
 <20250831114105.27494-4-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250831114105.27494-4-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 12:51:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2110

On Sun 2025-08-31 @ 07:41:05 AM, Trevor Woerner wrote:
> Now that 6.16.y is the preferred version of the linux-yocto kernel, the
> nanopc-t6 machine that had been using the linux-yocto-dev kernel can be
> switched to using the linux-yocto kernel instead.
> 
> NOTE: keep the various pieces of linux-yocto-dev infrastructure in place
>       so it can be used more easily again should it be needed
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  conf/machine/nanopc-t6.conf                   | 1 -
>  recipes-kernel/linux/linux-yocto-dev.bbappend | 4 +---
>  recipes-kernel/linux/linux-yocto_%.bbappend   | 1 +
>  3 files changed, 2 insertions(+), 4 deletions(-)

Added to meta-rockchip, master branch.

