Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73700C71151
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 15:06:22 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web10.12730.1749827177213410479
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Jun 2025 08:06:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AwJShLEq;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d09a032914so190784385a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749827175; x=1750431975; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2VYkaSdkEC4Mz/J5ErhG8LqELeG/pGLkN7lgfT151o=;
        b=AwJShLEqeHbJKyl5hZkrjnYkmFl6MY/MOBu3NHjl7jezR4/SNGls9BDmc9TuIz8XK9
         i/uuuqsscTlkW3ZMYi/R/ZyWdU9iDF4jfb5dXZPnJMgZxa8McHrUHMMoLXrAoxwco7Ul
         EIbNF8VcmJYzzuUOVQHqI2FEbOUdyap8BRESBJTgD02QzbIXuIlCl1zDWd+FLCiALOyA
         g8xeaUy54z85rOxssOa6SOgI5qmJ8ow8nk8UV5zg0HgUzNd+Yl5h+APlA3X92efPhgKi
         m0snXbWCObvDaw8RCP0htjf9h5k4HZJFcHqvE3KbArulMfUtCKF/y+QgGWtgJrSml+aU
         QuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827175; x=1750431975;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2VYkaSdkEC4Mz/J5ErhG8LqELeG/pGLkN7lgfT151o=;
        b=bi7z9wwWiZqZ7E+OnbRQ3Jc/wMQP4oSxQYjo1T4hJ+RoLnRZM86+4C1b6ZaTu8SwQF
         zNNzW5YThoVtrA+UKtav273zFPGCZia8/KF89q5nwhRMH9UuZp7kf2NygUKkyT4zIzRU
         DR2m6A0cJ3EACHLwgdMJbTrQcX5//g1LdCnqeakuJZfWuganv5EM10xThXB7FulSY0su
         nwi2FygYp0kHQzrq9WesCfdZymVNHA5bujv345kup3DhrinvrT+f6V4N914K3JPhn9T4
         HzYe0xddEw1RG8m8U26wPPyEfAT+GDEOcV2IdfXsi1yOriGFpKKD2AKAOT6jKi5PpB9m
         c/8A==
X-Gm-Message-State: AOJu0YyuTfX9C82Gryb8NPhX4DP0jOySHCFx7H0yWa+qAwe3SB+dEd95
	my2MDyT4ncN+Mbq/fof/e51IBXHTz3m60HVDxYevCDkjBwmPMPXGwJKQPyvjqPFm
X-Gm-Gg: ASbGncuhO5VJiXSZlTnSoejVFXN30hxmoGTSIRyi1lVHOaofr8oxUfQeV4MIvSMkZ/l
	WNlkglRvmWpI7hDrjl2UqBLP84QYK6f7pou+KKuaS5VdUxgKcT7mndNhQ5/qe8aLspzwqMJYh8C
	4gY3bVnITZpb8s5yB0UFSpG1g2xhCeO1GGTPtYldPZyLFuFKs27u3BYSj6yK7m9bnBUfP3o9q+O
	QR9jIgNg0/pQmarnmfd0vIsT77GQ4BgUv9QDh+cZhhbW4Lr4SJx+Q9XSWkoh7orrxTrG+TxkLd1
	CwgNsOTQqx7m/hCSkOqKefVS6ihpX2f2J041fO7D9IRfMHPdQSLVDfes4p9b4KIu20kMjJXhGo8
	BkmO8gpCbcrKGtmwgQmSf+FT8
X-Google-Smtp-Source: AGHT+IGTdmj56GdnLFJQKYUHiqIgYkgNJ/akoJg4P/I60u7lZk3Yvzn7mEl87JX41fp+6ezY+wG26Q==
X-Received: by 2002:a05:620a:bd5:b0:7cf:5352:b3f with SMTP id af79cd13be357-7d3bc49850emr538459785a.46.1749827173298;
        Fri, 13 Jun 2025 08:06:13 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eac10esm180167385a.58.2025.06.13.08.06.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:06:12 -0700 (PDT)
Date: Fri, 13 Jun 2025 11:06:10 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH 1/2] trusted-firmware-a: remove
 no-longer-required patches
Message-ID: <20250613150610.GB20372@localhost>
References: <20250613102357.1539-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250613102357.1539-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 15:06:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1643

On Fri 2025-06-13 @ 06:23:56 AM, Trevor Woerner wrote:
> The two patches being carried in this layer for tf-a are no longer required
> and can be dropped.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  .../0001-dram-Fix-build-with-gcc-11.patch     | 35 -------------------
>  ...rk-already-defined-functions-as-weak.patch | 35 -------------------
>  .../trusted-firmware-a_%.bbappend             |  7 ----
>  3 files changed, 77 deletions(-)
>  delete mode 100644 recipes-bsp/trusted-firmware-a/files/0001-dram-Fix-build-with-gcc-11.patch
>  delete mode 100644 recipes-bsp/trusted-firmware-a/files/0001-pmu-Do-not-mark-already-defined-functions-as-weak.patch

Applied to meta-rockchip, master branch.

