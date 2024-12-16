Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49E8E7717F
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 04:09:56 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web11.49522.1734322192970093817
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 20:09:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Q8sE0ePg;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dcdf23b4edso7827956d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 20:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734322191; x=1734926991; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egfpH/kt4nUkc2pmTCQ8AYJV3k+AIGNnscJAM9IbfpM=;
        b=Q8sE0ePgMNwtOoZUsHk5Ko+e51pYCiTO3U+NFH+YRejjkTFeSVww/cTCeEDsNtepCR
         D9+s7sOfb0X6eGtu2BXONd8vY9c0km7pv2IpqRXiLhK1ss4jhTPc0zVQkOjwbpVQWOgg
         v6t35OJd0WTdCZ6Gv1pnDRofKhOAc8C5xlrEBoVp0Vn8vn4cXVcH7JTTMCZDa4RmPNW0
         I5AUqcQfsQ1c+bRyBGwgbvup5SWxz2LCzTb6Upnz+5V4lOcxVxap4GWP7eyV26n2mdm+
         1J/nf7ALtcom6LHH127QUEW/ioHoxxyQCZ5TwxYnWxMywOPIaIPbSI+HMyH16xNiRsE0
         u0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734322191; x=1734926991;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egfpH/kt4nUkc2pmTCQ8AYJV3k+AIGNnscJAM9IbfpM=;
        b=pvDbO6QF8cML8C7hJ/MWxic2+q292K4WHLIAtYevUr+jDyrxHnCtrYnuobU2RTJY9E
         vU+L1ZqUcMYCc9En4/oNm/EsPpigwJumfHFNoJWGv4cmOk1yFUJMdOo2AVhoNRAmowX9
         wkLCBZxh/pySHOruRLZOsBTIZs3OAs+Rezrq/9fWcJqLsvOgypnl5YkKuCr2JnxBTNAN
         3PFTT9xqEXvv9faVYtuaMdwJU2z3QIHS4DYuSQ/meCGqmSPYo9tu64eCUVOpDnx839Zg
         shMzxxFmsq5kQT9AxH1DuZPuLuVmMHWKJPWus4DH11hq1NCdjZ6unPao+Gx0/hnkbjf2
         uM8w==
X-Gm-Message-State: AOJu0Yz0o2rcj7aqJor/tdhlpz/TqsAmisJ96VhAb6pU6hgXFQ6/RDRV
	mHCxb3V5j3K5SHt8g3/YMdSHXDqfY83OOE0BuQd5dY+ZlhV0xVUJYX2V4A==
X-Gm-Gg: ASbGnctgBgFneB/cprvUjwu5PXD736n5QJOvZcK1WHUiZfLQxqmH687G8Y+Xm8mLoYs
	PCfVW8iQpluq5jN2XBdzp0ziaU4amibGSkfXeIWFDB7/lE7fVPpUunCG1AvcMS+CJWLOs3bhnBd
	HuBJT1Uvpb5qY2Qa6l8EWNTCZ3I3OjzdowWXRku9A+S8elmRybOhv5tEB8qZeAQopFpjeF+vn8K
	PCEKsYZbq9hMeVoXhoCwEd3ctqUtScuFJm6II+Bzo77xA7l7FfON5vE6HmCuFRIK6DgR36v7Q4S
	66DxD+aj
X-Google-Smtp-Source: AGHT+IF2GtxTm4fBRAcNtdTb1IxbB7iI3mBqTgBDNG/x41dwi5B4DanE2fFIRr3X5+5BRn3IPeLUeg==
X-Received: by 2002:a05:6214:226a:b0:6d8:9002:bdd4 with SMTP id 6a1803df08f44-6dc8caac7ebmr236886016d6.28.1734322191327;
        Sun, 15 Dec 2024 20:09:51 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd3805d2sm23019516d6.112.2024.12.15.20.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 20:09:49 -0800 (PST)
Date: Sun, 15 Dec 2024 23:09:47 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Oleksii Kurochko <oleksii.kurochko@gmail.com>
Subject: Re: [PATCH 3/3] radxa-zero-3: switch to yocto-dev kernel
Message-ID: <20241216040946.GE466@localhost>
References: <20241212195718.25203-1-twoerner@gmail.com>
 <20241212195718.25203-3-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212195718.25203-3-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Dec 2024 04:09:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/925

On Thu 2024-12-12 @ 02:57:18 PM, Trevor Woerner wrote:
> The radxa-zero-3{e|w} devices are not supported in the current yocto kernel,
> but they are supported in the yocto-dev kernel. Switch to yocto-dev until
> support is available in the yocto kernel.
> 
> Reported-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  conf/machine/include/radxa-zero-3.inc         |  2 +-
>  ...xt_%.bbappend => linux-yocto-dev.bbappend} |  0
>  .../linux/linux-torvalds-next_git.bb          | 25 -------------------
>  recipes-kernel/linux/linux-yocto-dev.bbappend |  2 ++
>  4 files changed, 3 insertions(+), 26 deletions(-)
>  rename dynamic-layers/rk-rauc-demo/recipes-kernel/linux/{linux-torvalds-next_%.bbappend => linux-yocto-dev.bbappend} (100%)
>  delete mode 100644 recipes-kernel/linux/linux-torvalds-next_git.bb

Added to meta-rockchip, master and styhead branches.

