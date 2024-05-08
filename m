Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7538C04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 17:33:38 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web11.3326.1715189617711726990
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 10:33:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jmzEOYhJ;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6a0ff97a9c7so8701326d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715189616; x=1715794416; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jYCVzRvMhmoAlZcCxblDyv+ORZQxgQ8GrdlVQ0zzknw=;
        b=jmzEOYhJbLYhRPhoj80CJjub5I+/zktIP6YBpvFkXk6/tna8oWZunyE5sUhfAlsKEB
         me7raEwfbQ35hd/JZ12aUTXmuYnTavNjNyDkAX/YM9qIbss6qFj5D3udZRPx0tUq2ZNc
         rOiLzOYQvY6Tzmi95eTqnR+GN86rmo3xN0nr6QOkzoMQbYj4h9E/Q05Y1a8T47Tm0vwK
         YnXuaxRox5sHFul2nH9KGcSEwhQrlcP7nTV1J+lbIil79ETz8ETMMwHw/CZw8jqXDMQ9
         M8cdYICBd0tpQ9QU1J6IZxofvvzHd/3x26CnCLTrIC2oQWwPxdKTkP6btQTxZmiNwGBe
         wEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189616; x=1715794416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYCVzRvMhmoAlZcCxblDyv+ORZQxgQ8GrdlVQ0zzknw=;
        b=eehi6G8WJiDi7KoKfBblwm3sL0beNae6hxsTEOHlggNCeilSg0RJuXmtsgSl/fFxj+
         RBQn7yOop20PE0UGLuHNed7NlEy7fQZnVMbqInRCPY0eptqDOwocyC7zPMtbZa5EpfiI
         4hROnyQt4LpNsBeE5BfK+KwCmHpOlwki5J7CM7mOCXV/1706rlzjEbGnid+FW/xcbPjR
         pLNJEm/7V5XEMvtZYz59IdIQuEyXCSqQ9Y+t17mh6CELQivivW/LMQWrlSb7nOuhKDIA
         LAdeImNwvce+Xeq5qgYPnGuxKrFogIxXdWfvI1R7wvY/eFbZCPJAVY2LROOZQVHHg03N
         QuCw==
X-Gm-Message-State: AOJu0YyCZqEGEakTBOIAWzhu4r/fpprqe2lza7wtLhXG812Za9PDpQ3b
	QHcdN7i+mbqztiMkGaloxTa4zBa77MW7bm2Lz9Bk1pA9fx/XlJHjU4K8PXQN
X-Google-Smtp-Source: AGHT+IHq+afrwjs4oP0jWWzc0GSyuTStIzaZNGSrKYCH1QYt4nslb5iMXXEdOqEnCctC6t+XpZPtug==
X-Received: by 2002:a05:6214:e62:b0:6a0:e9c9:964 with SMTP id 6a1803df08f44-6a15cc181f6mr5555986d6.16.1715189616036;
        Wed, 08 May 2024 10:33:36 -0700 (PDT)
Received: from gmail.com (pool-174-112-62-108.cpe.net.cable.rogers.com. [174.112.62.108])
        by smtp.gmail.com with ESMTPSA id j3-20020a056214032300b006a0e86b3f65sm5770055qvu.38.2024.05.08.10.33.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:33:35 -0700 (PDT)
Date: Wed, 8 May 2024 13:33:33 -0400
From: Bruce Ashfield <bruce.ashfield@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [yocto-kernel-cache][PATCH] preempt-rt: add bfp
 configs by default
Message-ID: <Zju3bQe0KEoRZcpH@gmail.com>
References: <20240508070412.2939015-1-mingli.yu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508070412.2939015-1-mingli.yu@windriver.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 17:33:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/104

In message: [yocto-patches] [yocto-kernel-cache][PATCH] preempt-rt: add bfp configs by default
on 08/05/2024 Yu, Mingli via lists.yoctoproject.org wrote:

> From: Mingli Yu <mingli.yu@windriver.com>
> 
> Userspace functionality that requires BPF is becoming more common,
> so enable it by default [1].

bpf used to have locking issues with preempt-rt, which is
why it isn't already enabled.

Can you show some logs for your testing that has happened
with BPF enabled -rt so that we can document what has been
done to prove it works now.

Bruce

> 
> [1] https://lore.kernel.org/all/20200224140131.461979697@linutronix.de/
> 
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
>  ktypes/preempt-rt/preempt-rt.scc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ktypes/preempt-rt/preempt-rt.scc b/ktypes/preempt-rt/preempt-rt.scc
> index 7ff7c0a8..a5e345f9 100644
> --- a/ktypes/preempt-rt/preempt-rt.scc
> +++ b/ktypes/preempt-rt/preempt-rt.scc
> @@ -39,3 +39,4 @@ include backports/backports.scc
>  include features/rt/rt.scc
>  
>  kconf non-hardware preempt-rt.cfg
> +include features/bpf/bpf.scc
> -- 
> 2.25.1
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#89): https://lists.yoctoproject.org/g/yocto-patches/message/89
> Mute This Topic: https://lists.yoctoproject.org/mt/105976633/1050810
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13171493/1050810/607820704/xyzzy [bruce.ashfield@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

