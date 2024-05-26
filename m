Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77E9C25B75
	for <webhook@archiver.kernel.org>; Sun, 26 May 2024 13:37:16 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web11.6660.1716730633098786788
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 May 2024 06:37:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PPw8uqjv;
 spf=pass (domain: gmail.com, ip: 209.85.160.51, mailfrom: twoerner@gmail.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-24cbb2b71b4so941527fac.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716730632; x=1717335432; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTys3h3IxpG9yLihj+RrAh2L3wReLHio83XTRTwmuDI=;
        b=PPw8uqjvcCcITI5qj5g4u23Ei5eYHD20GKDphjBe/DvqCDUQphdFioMbpNoDOs87ut
         XJiFponKQ/qAfO0n6dz5Opjqnxxjd1ON0HQ3VPGoayVphXpprGFXQxNZ8DPqnbXE6jY8
         guThEBSpfhCWvAqtEBm6gMOBN75lhXjjn8gYRP84n2843iu9QKyaxUmmDibhszr6OTKv
         BLIpe6GiMLuIXisYLbki/kpG0+El+5xMHDP+wS775wKY1a1J8zBffmUAT4T9aHD72kg7
         HdCK9s9sNyrLsiHHtRCQmwaIlZeldhntIzmag+Ce52Ff86uC0hb33uMDiLeTqpx5Ll2q
         TWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716730632; x=1717335432;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTys3h3IxpG9yLihj+RrAh2L3wReLHio83XTRTwmuDI=;
        b=jvsNtNpuHaFE3MWHR/NtblKbzfajxWrnjSoVNSujff4NqDF53Bn2UEt7n+T5gAmiKQ
         K6twrKFlUUW6/0lopE7nGOAIKmNB5stOARKH+sJE3ZNqDIOL10fyv4X8wzdjU7ZEdVg9
         eacJ9ccKBLPzh9hOqtlfE8xdyOBHHLrZMCrdRLuk9/PqNXih4M079Eq1IMEzhUyyBCwF
         yD/j5o56RSMcjj2vlsTONZU0nUrWMpBDmhPwE0oxXAuSc0QgRcEBVIib1nPgDWZEQy/a
         /MWN5HgHRm2arYRYYGtPyjPG91hNqp95VsjRsF1kIc1zBTeyLyDXCp9YlIoHfzEAs12m
         uUxg==
X-Gm-Message-State: AOJu0YyzMOOeQrLO45Dj+d8rGA1FKZ17VOGa8fbAx5VTDNnNAfSQBDLR
	81Ylzv1OiEiVvHUsazpK+RWb5FCppKIExcE0RGeswzHO4QnfdYO4g4AUFQ==
X-Google-Smtp-Source: AGHT+IGjwlhHuvQxptprAabUaWXF8NzkfNDTis/hCfXkUiC2ktM1tBrrPM4GQJnwHw0Tsa3dRcJ3vQ==
X-Received: by 2002:a05:6871:722:b0:24d:9c4d:f609 with SMTP id 586e51a60fabf-24d9c4dfd85mr6210325fac.38.1716730631742;
        Sun, 26 May 2024 06:37:11 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd4406esm226732185a.128.2024.05.26.06.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 06:37:10 -0700 (PDT)
Date: Sun, 26 May 2024 09:37:09 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [PATCH meta-rockchip 1/2] rockchip-extlinux.inc:
 handle multiple DTs in KERNEL_DEVICETREE
Message-ID: <20240526133709.GA15238@localhost>
References: <20240522-nonfitdt-multi-dt-v1-0-c75dffd3aa7c@cherry.de>
 <20240522-nonfitdt-multi-dt-v1-1-c75dffd3aa7c@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240522-nonfitdt-multi-dt-v1-1-c75dffd3aa7c@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 13:37:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/202

On Wed 2024-05-22 @ 08:26:43 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> KERNEL_DEVICETREE may contain more than one DTB, the first one being the
> default one. Therefore, let's split on space first, to get the first DTB
> before stripping the directory name from it.
> 
> This doesn't add support for creating multiple labels for each DTB in
> KERNEL_DEVICETREE.
> 
> Fixes: 3b51866f2251 ("remove /boot partition")
> Fixes: 13316b796814 ("KERNEL_DEVICETREE: 32-bit re-org")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  conf/machine/include/rockchip-extlinux.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Trevor Woerner <twoerner@gmail.com>
Applied to meta-rockchip, master branch. Thanks!

