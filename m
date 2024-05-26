Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55DFC25B75
	for <webhook@archiver.kernel.org>; Sun, 26 May 2024 13:27:56 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web10.6425.1716730072108073776
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 May 2024 06:27:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HyB2lrd1;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ab9d00f727so13523146d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 06:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716730070; x=1717334870; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W49DFp2KtNTFTXQnCfnpV+0SYdvdWqXxsCyqeGZuSKI=;
        b=HyB2lrd1+jMTGxW79wc1zLq2I3+DfYWn6UxyGBcEVSBbaxz2htArjHdkOGUT4pJRjN
         slricgIfBVA5vJ6aEqbKBqNHzYdIwgEJz4cq2MB7+v2J4AZkC7pvOjn2poePA7lsF411
         nzwd+F0ZY5e2I2kie0ae3sJczSz95mzLe40EnIOGN20pnzlVIic3Yb7QIIc7jrmXwDx/
         DKQEnzCok1gqmmohYt8Aw5HImG/F9ylfLn6aR/snAOnTA5zreZtBnaoslpaCszyDgsau
         F1faSQNcCQpx78SV4fk9JuFEUZQYKu29tFY67gu3JRb4CUYEPI7ce0tblz3hqOr82mm6
         rKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716730070; x=1717334870;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W49DFp2KtNTFTXQnCfnpV+0SYdvdWqXxsCyqeGZuSKI=;
        b=lVxaHsGaV8XM94l8gHyPPyAmiVFGUurqwaFTtAGGUnGB1VBatLtHffNeqNqxtNQ3pX
         9WOt8YbeJZGzeVn+gvtwtpdX3NfdHyagaJFrGWM8W//H+bQAlzI8/aY97cTSqvNTUNm7
         pXNirgGh3Pfh6Ze+4WzXKPgEqLLrDDe9z5NwS7NEYBFVDdqSRf8YIrMl2OsRNv+w/PX2
         eZ0wU0d83a+3jB+IrX3LcRHhsyncIsUwmUFObWVuuKMV6/Mdevt4MJIgvhBQZbgQ6hi/
         1dKxWI1hapCt50jDUlD0a1JXh2FRQk3xRgjqZBT9ECaX4HkUVAbhZgIOdKwxO94zZD8f
         29Lg==
X-Gm-Message-State: AOJu0YxZB/Wz4p6cIqfiXMhGfnIhp7H7H7NYCj0UI6g5DqYfZ7D6Lzhu
	psASAn5pQ0h3Cl4XK5CaJ+Ko+vilcG6h4Hdkx3J4XqxtQl2+G0U+Ancncg==
X-Google-Smtp-Source: AGHT+IFg/LUCZKY7y2RIoVWCw3rUT3Id/34quSzfT2qNgnh2QUlIv7H97w6jXvF9a03AWThe6spQdA==
X-Received: by 2002:a05:6214:54c2:b0:6a0:def6:6c8f with SMTP id 6a1803df08f44-6abcd0d400cmr66396686d6.47.1716730070309;
        Sun, 26 May 2024 06:27:50 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad653e0a21sm18285276d6.81.2024.05.26.06.27.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 06:27:49 -0700 (PDT)
Date: Sun, 26 May 2024 09:27:47 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH v2 1/3] rename root partition
Message-ID: <20240526132747.GA12513@localhost>
References: <20240524023724.20109-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240524023724.20109-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 13:27:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/199

On Thu 2024-05-23 @ 10:37:22 PM, Trevor Woerner wrote:
> Rename the root partition to "rootfsA" in the off-chance the user may someday
> be interested in implementing some sort of whole-partition update mechanism.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> v2 changes:
> - (none)
> ---
>  conf/machine/include/rockchip-extlinux.inc | 2 +-
>  wic/rockchip.wks                           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to meta-rockchip, master branch.

