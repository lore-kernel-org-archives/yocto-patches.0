Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1BAD5B87B
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 23:14:31 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8579.1765840461813185081
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Dec 2025 15:14:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=eb2VqTBy;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8888a1c50e8so36105176d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 15:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1765840461; x=1766445261; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3dMQPQJAx4yUkgoGb8L49HPX5583TrTtbWvrIXaiTU=;
        b=eb2VqTBypO73zMCdw40EMx4PFumxkehYTlkkTXQ5h6ah3B37TRQ2RDdnh1v8gpuI2S
         Ch/vRoLGjwk2wKBlK0jgrQJ4XP+AeYDbc6jPX8CXUmuQ/uqEgiS9mUv2VSW5lZ1byLbC
         PprpT6sxLOUNwQUcSytRJm4bdRMnAOUJT9sTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765840461; x=1766445261;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3dMQPQJAx4yUkgoGb8L49HPX5583TrTtbWvrIXaiTU=;
        b=S34Em1v9FXPVZKs3bKdwBskVb01qnMQWGoPy/pmcR216sHKQGCvB+4TmwcArnXcN4J
         RV1KeOjflhusAdoNAp178ePh/V34TmTgdgihijTi36v3fw8wyLKh7bJ8eQsxXTr/CvzH
         ieY5dpMaB4xOoR+862h+IyqA/i/kZhvSfGKMUUBWkTlvg3wvYHHYmlt80qrTa01ahGMB
         pCDSz1J6G4mW6RQjvJGnW/iBLoxLogjojsSyTi8TZeY84J9PHXQTk7aB2d6oFuQ6YMb5
         sPwSfhQ0MqhAfaoAtKMh0mPs977NExU/CfWVeENufyUljXOQsH2MRi3GvEmBvcSYxMYE
         XjMw==
X-Gm-Message-State: AOJu0YzNy9rUDUCYdOj2DulggCM784WLgATaxHrUpMS6BUlsIvfXPSNv
	ePjGLxRhmmeKgFbn2G2ZJodUtKw1joILaF7Ydl6KzAhEd9lr3yQJBZETEfb09W8tokw=
X-Gm-Gg: AY/fxX6frST99ciFmPCfm6yZ0wfpJtwl9hqElNa5Z4dcqymVvUaHezvBqdTZc1K0Q+Y
	TOjZ+ZFjFeP630fwvG8vqxi8OtGvz76m2d0oAop3GYytLgJOjKGo/1UHnfiJDUiqYhl5cK/wa83
	bJVxzuS4pPD6aKgrLPsO5l/zyF7GB6JmfkfpmRB6FiYIG/UHzj2f7KFJCNJlJ+zim0tMftI64fS
	7/Un/fbV5+hfhh2uzshVnhyepY1KS3r+nI+h3sQQKARQ7jkJ28A0n8Yda0DJwya06wlWec//IJX
	zp7MBpPk30/HYOOkAlRGR6EwV+cRkGjJg0QLGCNy00TeL+7l2WYZaKrB0zLxrzyaguffmwAUT7O
	BjwOwWPDWj4iambH2nBuNdRyGIHzJc9KSJG9EkxwCUWUXjjc/713u5pXDdnEZ3i2akj/rIt2Pm1
	8HkfM+24hoQoo6Sgz/ZFgM9TmrZl2pKPUgcO0aDrBqC7a+GFQNALN770f+E4tYQVT+tLuAPlhqR
	IxPLhAYOIsn+v3OhUksrnwdzWuhPFXKb+c=
X-Google-Smtp-Source: AGHT+IHZBQ1DWkoEMno/G3HDhFS7NBBmDEiWzINWYsuBqRTPj823rn4euc8VmbUeARZPNpJws4AngQ==
X-Received: by 2002:a05:6214:509b:b0:880:501f:5dd with SMTP id 6a1803df08f44-8887dfec80cmr199027836d6.14.1765840460529;
        Mon, 15 Dec 2025 15:14:20 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8899e7598c7sm61215376d6.28.2025.12.15.15.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 15:14:19 -0800 (PST)
Date: Mon, 15 Dec 2025 18:14:03 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: "Hemant Jadhav via lists.yoctoproject.org" <hemant.jadhav=emerson.com@lists.yoctoproject.org>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH v8] clamav: Add recipe
 for version 1.4.3
In-Reply-To: <223420.1765834327157471311@lists.yoctoproject.org>
Message-ID: <3c6cdaff-d7d9-bcee-f1f1-8e997f2fca43@konsulko.com>
References: <20251124153927.463459-1-hemant.jadhav@emerson.com> <223420.1765834327157471311@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 23:14:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2791

On Mon, 15 Dec 2025, Hemant Jadhav via lists.yoctoproject.org wrote:

> Hi
>
> Any updates for this patch for clamAV?

I was away for a couple of weeks, which slowed things down, but the issue
is it's been taking some iteration to get it to pass CI.  I fixed a
couple of issues stemming from building with INIT_MANAGER = systemd and
configuration not picking up RUSTFLAGS, but then hit what looks like an
upstream issue with it not building for any 32-bit platform.  I was a bit
on the fence whether to attempt fixing that myself, but am leaning towards
just marking the recipe incompatible with COMPATIBLE_HOST.  I'm quite
jetlagged at the moment, but am aiming to get a patch series out in the
next few days.

Scott

