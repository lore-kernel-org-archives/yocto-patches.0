Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F88EEEC02
	for <webhook@archiver.kernel.org>; Fri, 13 Sep 2024 02:58:07 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web10.65045.1726196281863512767
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Sep 2024 19:58:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CEj1UIoz;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c351809a80so12512076d6.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 19:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726196280; x=1726801080; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygeIt7HH+fhLh8FSOrQTkKxVDdAnXqlFliYDGRHwLGg=;
        b=CEj1UIozAYPuJaZ0zp/KZA2DQSbxwW5oCmbA9drAYeIWtgn7cxEkW5aoSMuqfMipHv
         eDGZvkwdlWRxysLutRzIbqPI70ozT8AyXDDV9U/yFHxuX7LDZMDcWegUVHiSs2Wt5rJ5
         7z1aSHrNJULrLTYRZERm3fDSxmEFRPXXlumDkknWzOAU8NWcc0gNEWBbHjpd1QVGbxfy
         GvcdRkCyJ+4iqfCH+CSmm9CoXv52kzZhMVZxfieEwGlpMvJurGy3YdQWQhh9Vb1Z2Ina
         G7T2HpXHNzhGUxzsGAJ4NzeN0QC6Z8pHdksCGhLMx9Zp0PNTOQ7lop6t5yeqN9FqXc+O
         +N4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726196280; x=1726801080;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygeIt7HH+fhLh8FSOrQTkKxVDdAnXqlFliYDGRHwLGg=;
        b=FuhJFbM0ojveTtoBlVHKdie5rVitJ/SAdsgbqc5UC3/vpwo/nGKD3EtP7ilVW0pWom
         KbJ062E0996rxhTqy9WEkrJIsDjPcU3XReqpYLHUcIWx7R/i4TWcXs6XV+lQ1V39Lolj
         G14xs1IcDO9RV0nEc3i+NTgZeuWPGfBJxpHvJDwXyKES2QboNwFWnx+waMpQj8qqP1c1
         x5UKlfsSZd/5+Q3btG39ZImP6stJPAtgkImPHo4b8BZ76OJMUV21CZbQnXqDJ5O5EIO8
         y22u8XFhm4bERuQNe9h/+n+nwx3RvJOITkQJNiqZeEMU5lGMW7vRQrpU6Hdq/vwdUl7i
         nBjQ==
X-Gm-Message-State: AOJu0Yy4QhDQyv6drj24vn2EuDT/WAxgtH75a+DGWydPszI69KWr/Tfg
	Ofdjc2RU37sd4ZBn/vMc+/MDRdQmrHm98OGXd5m+YycMD0OeQ0Yud739dA==
X-Google-Smtp-Source: AGHT+IGQo83gabsADreWpewo3PmpDe9sWMBHbEzkBhzqkAxFJI0othlYMPngy5mlCkdRZ4SO540wfQ==
X-Received: by 2002:a05:6214:3289:b0:6bf:65c3:fc10 with SMTP id 6a1803df08f44-6c573557706mr68209686d6.15.1726196280211;
        Thu, 12 Sep 2024 19:58:00 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5343295c7sm61173316d6.13.2024.09.12.19.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 19:57:59 -0700 (PDT)
Date: Thu, 12 Sep 2024 22:57:57 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <trevor.woerner@amd.com>
Subject: Re: [meta-rockchip][scarthgap][PATCH 00/10] scarthgap update
Message-ID: <20240913025757.GA36586@localhost>
References: <20240909145530.25301-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909145530.25301-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Sep 2024 02:58:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/655

On Mon 2024-09-09 @ 10:55:20 AM, Trevor Woerner wrote:
> From: Trevor Woerner <trevor.woerner@amd.com>
> 
> Update the scarthgap branch with all the relevant patches from master.
> 
> The scarthgap branch did not get the UNPACKDIR changes that went into
> master/styhead, therefore any patches that addressed that change were not 
> picked, and any patches that added features with UNPACKDIR were modified to
> revert back to WORKDIR.
> 
> On master, it took a couple patches to get the radxa-zero-3{e|w} machine
> added and working fully (i.e. with the kernel tag). All these patches were
> squashed together into one "add radxa zero 3" patch.
> 
> The rename of the mesa bbappend patch is not required on scarthgap for 
> reasons similar to the UNPACKDIR feature.
> 
> Boot tested with:
> 	- nanopi-r2s
> 	- radxa-zero-3e
> 	- rock-3a
> 	- rock-5a
> 	- rock-pi-4b
> 	- rock-pi-s
> 
> 
> Marcin Bober (1):
>   mesa: build panfrost for RK3566 boards
> 
> Quentin Schulz (3):
>   mesa: enable lima on all rk3328 boards
>   mesa: build panfrost for RK3568 boards
>   enable HW VPU decoding for SoCs that have stateless VPUs
> 
> Trevor Woerner (6):
>   user-selectable wic compression
>   rockchip-rkbin: bump SRCREV
>   radxa-zero-3{e|w}: add
>   README: sort MACHINE names
>   rauc demo: add
>   linux-torvalds-next: bump to next-20240904

All of these patches, except for 09/10, applied to meta-rockchip, scarthgap
branch.

