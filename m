Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FDBC369AB
	for <webhook@archiver.kernel.org>; Tue, 15 Apr 2025 18:14:57 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web10.1304.1744740891919713194
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Apr 2025 11:14:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fUVKin3L;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so35169296d6.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 15 Apr 2025 11:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740890; x=1745345690; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gvHsp//6jmQyBenCqOkxccuQ6y4vixw/yvhuvExIbQ=;
        b=fUVKin3Lso+NUaWHDkS9rBeEec8PMhgcZYqQ979R6rJRPpHvWjw57ru7u2MO3H3JSa
         qUUGWwfHjIpPvvbNtmD71c3K6DN8zdn8JsPsJPAcx0ypaAuvZCWzqMlEsiT7EoXyyVqk
         sy7qulyCFvI/toetej2KC3xXVYArKTJKLnvk6It+SHF92E9adr8jxzf23lodi43k2qjt
         hNvo6pByw6Cju116howWn2bhbvt4cFeTPR9T1zt/AjNPo/u00z0uFjyGbo1AJbnrtsRU
         0nZERkUfj8NTRPYUAoufvnVccy2LFGKZVfswZEFuHTzJjDJYkC3/RDhkcA2buCq82zk3
         iUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740890; x=1745345690;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gvHsp//6jmQyBenCqOkxccuQ6y4vixw/yvhuvExIbQ=;
        b=hTlPV4vJHbCKGXOoSYROwLGwcNYHLSPQV4/tWGfPyHSm1EF8XR3gE2Dk4/viOxZtmd
         z2x+AKw5P7b2b9tiDtKXxLAJxK67JYbVGN++8Y5HejrZ5tUDF2Xiv1ADquEeD/+EyObx
         6wzSd0EEUhkvuHrPmvumutgpc+jg0RCOnK+S5pi+pghBGjwlpSlXJTHJCFb4HLVzmgTm
         io3ZwR0cZIn8+hhBhRrAZ/sa1wKHYJUDwYbTnqNAl8NvYwgDgU01bKuMbNGZwczGCmYH
         2RZ8TIp7059+oxMniHB2n4HBn1A+nBZEltF4gR/j76kZjDFurt45TvJ+grT2JTSYMZjh
         6hTg==
X-Gm-Message-State: AOJu0YyApCIbMBnSAhnsbFTQi20KhxapOUlWgDCtkOh9kt2bIwvqMLYt
	YLjmO56mJ+VjLTsuGiCUzkur0oTszy/kPKUV9w8mDasyRuOyjkN4YxomrVAs
X-Gm-Gg: ASbGncs9DCLOnEMVjZXdBoyy4R4ocrR9WV86OcPjEQ68iQH0vy6zrhOYWX+Vu852ox9
	v5EFfDSj/vnCvmcBeFX0JRG47+hA9qM1IFnOTgCisayhQ25QPSi9hkcYkxi0yH9Syiyr9rPb01d
	sGPp0NPZ4X9uJd+KC5dMgaF7LrUa4qv1c936E76VUx9l5ei3rQkqX7bDEhLfsDaratgL+PPWl59
	JXfZm6EP9EEaT2e0Nn9K7uLeQ5tv7tgs7i1pkDTQYGqO6bZ+V3uRUKJ9MxPR/pY0CxeW4XMeouz
	vwuXXCSgQQkN7Gvg/sI6e6L0IL5CXKvS2KCxXyXKm7LpkN9WKtCyPLq3+F7clHGZTAnlgYKsszr
	nnmg=
X-Google-Smtp-Source: AGHT+IGDEnRoy0OiajXGoheY6zYwjzDARGfy2PKWv3sTdd5GazyRaZspVSK4z8YGnfKdSQ0u7P5NIg==
X-Received: by 2002:a05:6214:f6c:b0:6ea:d604:9e49 with SMTP id 6a1803df08f44-6f2ad9e0507mr8143356d6.34.1744740890019;
        Tue, 15 Apr 2025 11:14:50 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de982218sm104225936d6.63.2025.04.15.11.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:14:49 -0700 (PDT)
Date: Tue, 15 Apr 2025 14:14:47 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH 0/6] rkbin: factoring
 ddrbin do_deploy, customize ddrbin and bump rkbin
Message-ID: <20250415181447.GB9633@localhost>
References: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 15 Apr 2025 18:14:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1372

On Tue 2025-03-11 @ 12:26:29 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> @Trevor, maybe you can check if that would fix your issue with the
> RK3308 DDR blob you wanted to keep on that outdated version which is one
> of the last versions where the UART you want to use exists? It'd be nice
> to get rid of the rk3308-specific recipes I believe :)

Yes, that would be nice!

If I understand all of this correctly, I tried using the ddrbin_tool.py to
unpack the parameters of the latest version of the ddr.bin for the rk3308.
In other words, I applied this patchset, set RKBIN_RK3308_LATEST = "1", and
did a build. I then unpacked the parameters of the ddrbin that was in the
deploy directory. According to the values that were placed in the parameter
file by this tool, the baud rate of the uart is already set to 1,500,000. Yet
I'm still seeing gibberish with the latest version. So I don't think using
this tool to re-set the baud rate to 1,500,000 is going to work. For the
time-being I'll just leave things as they are.

Sorry for taking so long. I had wanted to play around with it and see if I
could get this working. I'm going to try anyway, if nothing else it would
prove that this mechanism is working correctly. But it does not look like it
will fix anything with respect to the rk3308.

