Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32704C25B76
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 13:43:27 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web11.9923.1718113397686138866
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 06:43:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=b78OtoEb;
 spf=pass (domain: gmail.com, ip: 209.85.210.45, mailfrom: twoerner@gmail.com)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f9866bd5ccso599031a34.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718113396; x=1718718196; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFblFEVBOjk00BxpssF30hU+T9/pDli+nJIvS+qwhJo=;
        b=b78OtoEbzWTnYhycP6CYgNoBh4HrvKq6biuqn0Rq39qTTUPp4MnE1cHwCev2nORX/3
         rj057VFYVBveG+TLMXe07HXJ8m696AS2TS2lurgnbGJvstc4rjBa/GkmiAheHdUEqIZo
         XCRw/xQ9Z5kcAmWX0ma7MNrkUX80C3leL0B9GqIrmNmevwdc+6u2+uyCpMho8OToQJmk
         +xXuWUQZnHdAnajS5sFxQveQRZqZDKCZrSpZknnD69y/NKeGJeHRRebAjP5eozQ1KiWR
         MW6rWh1s3TX4arK/qNon/G6YusitMrdSCTpf9KS1HTvwpqWIjtob56Cyd8ijV5YcilR+
         s+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718113396; x=1718718196;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFblFEVBOjk00BxpssF30hU+T9/pDli+nJIvS+qwhJo=;
        b=N5dbt2O0tMFieamKst6BHGJPZjKIYwbGM0nzj4axkIcQZzRx5B6ZUls7WWMQoseUJe
         v2YrDP2xRRf0E3Q+sx9XO+yxM15XE2SU/fCJrUATzk5kv8jGtO8OXVbJ8q0/vIcnZGbK
         k00tt4oNwO4/uvwvynAIBoTAqQSH5Z4+JBsSEQRsanXYnOu3kxFifAszEUqMWuT57pk4
         8zg/IR2SwLcdBjYGhOmhnNja3/RoGZgGRDCmefmqFFzInN1f03uMh0pf+IqIOu5DSonQ
         Sjin2ckIQKRCry9445VaTpLIY+7oXDP5GZU25XDS95H1Ur+F+TLF27Hqki8jxKDX0TNh
         lJ9Q==
X-Gm-Message-State: AOJu0YwJANWhu6myHpnpdS1J+UmhVu+0Fxuaf4RYcEIv+YqfwACuH+Pq
	RjnjEAy8/scZk1rBEGDjLMqnLS83ua6nzacAlvBQwBMS5hzDy9TAY2swoQ==
X-Google-Smtp-Source: AGHT+IFRs8Q3NWPnS0ZKQHPiE02TeDsrFLiU3CjwetDxhi8Up0bYs8sEECtRY+UkCIVzp1jHg62/Jw==
X-Received: by 2002:a05:6830:1112:b0:6fa:25c:2e05 with SMTP id 46e09a7af769-6fa025c2ee1mr922277a34.15.1718113395938;
        Tue, 11 Jun 2024 06:43:15 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955ad3b9b5sm274209285a.85.2024.06.11.06.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 06:43:15 -0700 (PDT)
Date: Tue, 11 Jun 2024 09:43:13 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [PATCH meta-rockchip RFC 0/2] add support for
 Panthor
Message-ID: <20240611134313.GB39107@localhost>
References: <20240531-mesa-panthor-v1-0-8cfb4d17ad3a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531-mesa-panthor-v1-0-8cfb4d17ad3a@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 13:43:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/295

On Fri 2024-05-31 @ 05:30:24 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Panthor is the open-source implementation for the Arm GPU Valhall series
> both in the Linux kernel and Mesa userspace. In the latter, the panfrost
> "driver" is actually handling this version of the Arm GPU. One therefore
> needs to enable kmsro and panfrost in PACKAGECONFIG to be able to use
> this open-source implementation.
> 
> The open-source implementation still requires a proprietary blob which
> is running on the GPU: mali_csffw.bin. Note that the closed-source
> implementation (libmali and vendor kernel drivers) also require this
> blob.
> 
> Right now, we're still missing a linux-yocto v6.10+ to be able to test
> this with everything upstream in Yocto/OE, but I was able to
> successfully test this with kmscube on a downstream kernel (6.6 +
> backported patches for GPU and custom patches for DSI support) on an
> RK3588 Tiger.
> 
> Additionally, the following patch series is required from OE-Core:
> https://lore.kernel.org/openembedded-core/20240531-panthor-v1-0-1a76fd752c1b@cherry.de/T/#t

I would prefer to commit a working patch rather than pieces.

I.e. if you want to add the necessary patches indicated above into
meta-rockchip so that a working image can be generated without any additional
dependencies on other layers.

Would that be possible?

