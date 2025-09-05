Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EE1CA1013
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 12:36:36 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web10.20657.1757075787366714741
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Sep 2025 05:36:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e7ZnrDJM;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b33945989bso37668121cf.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Sep 2025 05:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757075785; x=1757680585; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JHWhY8jACIEr+GjwbNPs7XiYHBN867vkcyNvvsceas=;
        b=e7ZnrDJM/el2yksWOGlv24eAo9MTVxg5Sz76eX6Z6lQmPfefWuxXExJK27WaqZDn3W
         KVVBQpIAJSw8qwsIwCDwFT8mAKD2N9sihyrFzQPirTaFy+NrPCg8Zb3X4m7wvTLyqMUb
         OaTMYKpPLEDyyc2cLuZ4ecN9LwxF5+El/L+3YFLVzUZ2gSByNsIT1Qv8EKhR2Lc6Pphd
         Lv3md5g9wfvFOKj0KUG4Lpk3dHbEaSG/GCuwS/GZ2visMvc6A5/pHU3MUmaV93eNrVgX
         Om9C+t/E90DjT7+x0PKPApoP7bPdKuSSnfAWTfKuBcoU119vwIKqwrHs+TB1/WVHsYT6
         JRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757075785; x=1757680585;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JHWhY8jACIEr+GjwbNPs7XiYHBN867vkcyNvvsceas=;
        b=Vm2gYC9yN6h80yK2X+llG7/ygTeWWZ27JNqMNw599SJcx7x9poWmlz9b2IBb1dc9c7
         iqTg4sfpn3af4SVjPx0gOdNuV7ziMu/vAk9nd+cojj5huGY3kF27Qercz/5nH3LAM+dE
         DzI9FEgKscVj3oqzPXh1ZPwCXZtZNE3eKowvOXmzgO72CFuLoUP36qTadpDokYkjxC58
         0/CJ6c299DFpX7gF9WdCjUq2Wz4WJLPfooAellNy8hmxrpusOmNBd9VjTc/HDujzJJAI
         tD9DO4gyrtzFl9tCSbHMIAGZrmmMTB+n1nacE+cHXrXelcFWPprrQqa3wU1qoQed8PTl
         v9wQ==
X-Gm-Message-State: AOJu0YyWL+KNq4OOVmDp017Byycy3H1M6TLp8IKQJ/aCQjAzQXTM3AIr
	HZWYyA2BZ3exLwfGf/MOepyPhmqm2cUTmdNRzYbxDD+gdr1MOLhUKo2Q0BsNAQ==
X-Gm-Gg: ASbGnctl6c1tLOla9qJqo/ZVAcbb8790yrqrFQ0zt8n/uKNKfb6FJ1Eb9qv5uSKBzmD
	+BoxN+V54T7c81udm3zcWHvrcwJZODmQAsUpnhK7IKSHka14cbdA7xXUu7VnLeWltZOXm3m1x7B
	ult8WP4Klr+QExU6uewkX4y0GpKc27xJ/HgeX49MDTvHV8d3QGA2dIuQgRjmHA5RqBDJM8UN0bh
	n+oKIIMZ9OTPMKuTZ6ML1qQrsOHFHU7KLTJq18s6M6zCgXvYSs4zGHJIy3CbGgvaqyq40HTqpA2
	WBet/Lwrxvzq1oYkha/kOYRCsZFH/hi/wiDWGijIyq6zZr2mH6EIZSsJ3sJkLlJSHaUJRhh0tsK
	8tR2ugFhbBEj7n8CHZ0/qe7R2+hYx4rSW8qof2djXII2+AEPckA==
X-Google-Smtp-Source: AGHT+IH3cad1f1RSsh8cEw0pEzPZuwLazmarWzj7ScQ7qjm3OslabVUshMJ595BIaxwPQN8JlsGYYw==
X-Received: by 2002:ac8:578d:0:b0:4b3:cbc:18c3 with SMTP id d75a77b69052e-4b31d844826mr255345021cf.29.1757075785209;
        Fri, 05 Sep 2025 05:36:25 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f785d71sm46058231cf.44.2025.09.05.05.36.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:36:24 -0700 (PDT)
Date: Fri, 5 Sep 2025 08:36:22 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH 1/2] nanopi-r4s: remove 2nd eth work-around
Message-ID: <20250905123622.GA36766@localhost>
References: <20250904194529.22656-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904194529.22656-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Sep 2025 12:36:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2141

On Thu 2025-09-04 @ 03:45:28 PM, Trevor Woerner wrote:
> Pre-6.16.y linux kernels needed a kludge in order for the second ethernet the
> work out of the box. With the update to the 6.16.y kernel the kludge no longer
> applies. Fixing up the kludge so that it does apply does not seem to bring up
> the second interface. However with the kludge removed altogether, the second
> interface comes up without issue.
> 
>     # lspci
>     00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3399 PCI Express Root Port
>     01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  .../linux/linux-yocto/nanopi-r4s.scc          |  6 ---
>  ...anopi-r4s.dts-enable-second-ethernet.patch | 41 -------------------
>  recipes-kernel/linux/linux-yocto_%.bbappend   |  1 -
>  3 files changed, 48 deletions(-)
>  delete mode 100644 recipes-kernel/linux/linux-yocto/nanopi-r4s.scc
>  delete mode 100644 recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch

Applied to meta-rockchip, master branch.

