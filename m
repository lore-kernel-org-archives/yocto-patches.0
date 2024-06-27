Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2CEC2BD09
	for <webhook@archiver.kernel.org>; Thu, 27 Jun 2024 14:51:53 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web11.9847.1719499909528802638
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Jun 2024 07:51:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eHGdyApW;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b5932383e0so5561996d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Jun 2024 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719499908; x=1720104708; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8A7OtyqxQWEjAq1rD4sRP3o6Lf6KZ2aiPGI+X4isGjE=;
        b=eHGdyApWNRqIk6d3Q+zY/VpCmdZXT29cIShgYsYQfa9LAuOo3sIJMLe4cQqNi/eiy0
         2i/jki1tYh6nzCQFy8kC/ZWoqc4I1bcxKrTm8+uzc3Xeg+0lS7HbV/T7BFz2bKeecZCf
         b05PS0PliZlNBStK0uJrQyhPTv123sa9aP080KGFKdaKSnlTaaYSzzaQXkavgP+8aRrF
         JKRNjnpXPY19qO7Bchapje541N+XuJjDvRt77HVEHkoG7v8OHIxsmKCMCbmJwxqKQdcU
         H4IuuoonHISVhZy9ScWb4RElwKskd1UL5SF4ggNaM2u0cXVeAD/JR1t74ApLOGGARkgd
         QhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499908; x=1720104708;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A7OtyqxQWEjAq1rD4sRP3o6Lf6KZ2aiPGI+X4isGjE=;
        b=AGZV+rxDYQBsjbRthPIoP78+bjYAFZh6t9Dx9xXXquSwh/ZiBYy3drOS4LbeEU0nE5
         dHA2XzWpLK+ua2HTUsKzTh4QvAbWFp/So678hG7PwjrjswzYs7yrXUFhQi6rnIcu5i1c
         Iwq0qE5c1/BQuSQA2PiG9EZVLEF+uz2O1uwrWZyNdwe3SJH9mfkciUmLpMu0KkIhQEN8
         g1ryb1QTDQGVrw5XAnzDEjEEe8R+2s6gqBe58rpxfnLF/t0jk3yB8dndth/p9f/0OPr6
         QgL8jnCdRIn1N9DJh7+uPs5y6KVW4igAkpr/2rk0TQsa5fV7n3fc2CL3s9WEZnHCoBEC
         nIOg==
X-Gm-Message-State: AOJu0Yxr5HLQ0PpecOi4WuOYBtd4akDJ/VJWOcr1s6MpFhGhVXVUXkrb
	7xNoxQmjNEM/a21s90DmjMFOJcmXFVfDvztvazGY1NmpgHOWI8i/btjkIQ==
X-Google-Smtp-Source: AGHT+IEvk4AhtAfpZDhywo64HlQnL8EzzeY8vZjD15isBHeVMzKQ1eZqThzAxnkPVnrjUEWG+frbPA==
X-Received: by 2002:ad4:48cf:0:b0:6b5:335e:8ae4 with SMTP id 6a1803df08f44-6b5632e430bmr131105556d6.1.1719499907861;
        Thu, 27 Jun 2024 07:51:47 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5929287cesm5537526d6.142.2024.06.27.07.51.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:51:46 -0700 (PDT)
Date: Thu, 27 Jun 2024 10:51:44 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v4] rauc demo: add
Message-ID: <20240627145144.GA38874@localhost>
References: <20240626213536.12343-1-twoerner@gmail.com>
 <912826d9-a007-41fe-8338-a70d552e0b61@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <912826d9-a007-41fe-8338-a70d552e0b61@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Jun 2024 14:51:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/389

On Thu 2024-06-27 @ 01:47:46 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/26/24 11:35 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Add an example of implementing rauc on a rockchip board. Adding the meta-rauc
> > layer, adding 'rauc' to DISTRO_FEATURES, and enabling RK_RAUC_DEMO will build
> > an image using the example provided in dynamic-layers/rk-rauc-demo.
> > 
> > This example uses a simple A/B + D scheme (i.e. two root partitions and a
> > non-updated /data partition). Repartitioning occurs automatically on first
> > boot thanks to systemd's 'repart' mechanism.
> > 
> > NOTE:
> > - this example only works with systemd
> > 
> > If you wish to provide your own implementation, simply add the meta-rauc
> > layer, add 'rauc' to DISTRO_FEATURES, don't enable RK_RAUC_DEMO, and provide
> > your own implementation in a separate layer.
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> 
> I think it's fine now :)
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks! Applied to meta-rockchip, master branch.

