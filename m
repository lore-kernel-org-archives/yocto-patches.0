Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE9CC52D7C
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 16:48:38 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web10.1094.1724431709630285432
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Aug 2024 09:48:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NJ9JTKjY;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a337501630so141109285a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724431709; x=1725036509; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ra3SeK4U5YDoP6JmHDwAFwIXOAY96PWvXI+eeFIddBI=;
        b=NJ9JTKjYtBAJgBvtJLkGTJLDwYSUk6Jf85r6/azC/WO3g5IKnw/aJKlTmaAGux5aYP
         fN4fl2GLKDV6U66nAMmmJtqKHPUWb2WfrfUcOw/l+LXJsKpEgU00APBWYhX4TRIKKZ66
         CdVQt3RXS1G3KStG2SLFIICQmY3fAglSzCu/3v4F+e2WMtL5zIMnDL7D6QOl/cAc0d/n
         yFbRm9sZfD/uOUWgUhHvFTAi/eh7qUdVuf/8EQZqm8f91Ww1krt6r9J2R0/KR0dZzAHB
         z78JOQqIShuQuKD2PUHXJvVndnAvR2lsGO78Q98V4ahnPD+u67nc/3fGMWtY8Mk9fHyA
         76ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724431709; x=1725036509;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ra3SeK4U5YDoP6JmHDwAFwIXOAY96PWvXI+eeFIddBI=;
        b=v/9qjAPCmgQX0dSVSrBBXY3S8DVK8nIoaUGmN8m1zTKSmvtNGMivi8mSD6UBl5dqh4
         5xF218MewpaRLpHWl0XFBT5QxMrXlOIggV36Ps1jp5NQjMhgghD6HNSk0kLyEaOK3Dg1
         cTSN/jlBHWxEDgZis2Y2/SATm4uzQ+GuztL6yXqn7UtxIHZZsPAsnAKQ8QYi3sYzrZ+0
         LXVFZsjf8BsFmlqzuc5ZkBLENkBwkI1HS5rJs/0HLaIkzvaWWHqE829yQOCTT9sQRevl
         oYQlbzj7vZQJ9Gbi/7YwBC0xaK08r3tXHBpegAPBsfd6MkRzV0Qf6N9nzCywiGNWdK29
         AUPQ==
X-Gm-Message-State: AOJu0YzuZPToedodmabIRnl1mLYGGGR4ZMH08PChEkFZC69jLSFoi/H8
	oKFgnFM8IU9q1BbR/PdCr643XYBG1nKxcrOyuOQYYoPmoHcaXXzA
X-Google-Smtp-Source: AGHT+IGjbMmAk8aN14w/bEZP4gG05ZnDP+g70SaA7quzZMNtDh78ICr9PWd5B4B3DDQwWJkJszxyrg==
X-Received: by 2002:a05:620a:1a83:b0:7a2:ccd:9672 with SMTP id af79cd13be357-7a6897a6de7mr320727685a.67.1724431708638;
        Fri, 23 Aug 2024 09:48:28 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f418814sm194232385a.127.2024.08.23.09.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:48:28 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:48:26 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip] [PATCH v2] mesa: rename bbappend to match new
 recipe name from oe-core
Message-ID: <20240823164826.GA3259@localhost>
References: <20240823123253.3562592-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823123253.3562592-1-martin.jansa@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 16:48:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/559

On Fri 2024-08-23 @ 02:32:53 PM, Martin Jansa wrote:
> Otherwise it will fail to parse.
> 
> Renamed in:
> https://git.openembedded.org/openembedded-core/commit/?id=f5cfb3e23603cefb2f3f6bfe776afaedefd10808
> 
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
>  recipes-graphics/mesa/{mesa_%.bbappend => mesa.bbappend} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename recipes-graphics/mesa/{mesa_%.bbappend => mesa.bbappend} (100%)

Applied to meta-rockchip, master branch. Thanks!

