Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE38E7717F
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 04:12:46 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web10.49692.1734322358701606302
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 20:12:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cs1cgMXO;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d900c27af7so43781476d6.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 20:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734322357; x=1734927157; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gN7XUrT5wAaVhnJiCRFofIXJLwt1zfF8Z+SV/0hcugk=;
        b=cs1cgMXOn8cvN/OFwM9n7KE5gq0OyXcLAWsqEoXZnZm3MAizhcTNt1jaD/enYiaCZv
         Uae3EGrcXa4Kw/CsPmv5LdA0pxreZ3PTl8GrZVYsWHrW9sgm97+U9R1JpxVa5qoL20ih
         vDEs3lx939gVR+uW14IiUz8p28+L1T7vuncbthTJTWdIiovDNMQYrkmlzXlgAtziofwC
         u2KsTo+OyvPC+b19Ry+CkMYsSmZ3mfpAmAwW1vrlQE0WlJr97wIEHpA9i8yrkCL1EA2r
         EHVw1q290SIU3cR2nEf80b5UeZbgPJ5ij/VE8HdPZftHFj/9b61oBi4MUXE2VtnSswkj
         RUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734322357; x=1734927157;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gN7XUrT5wAaVhnJiCRFofIXJLwt1zfF8Z+SV/0hcugk=;
        b=ICieO3Y58h6jAOeFFbP17dGalZhp/L81boHFwKswGmZqMSd9Q9MtlP4tsunoJkZcx7
         eM2nQsj+S0gW3YvaazjzuSuQARbU8wohs/k98u8f4DU4c6H/EzxUKZkKZRxnYem0Z01M
         ph9CqxgNvU5mOCCeS03s+ur5XyHz99LYCws7ugvjs7vTpcCsOwN8LctJ20RtCo2j7c0L
         i84iKxTOX8AlyW/PiPSWPH004ZLGWsUrSkmBRLWketrN703Xoa3GlulROwcg5xAsEXRY
         jDVm/2RR1BYp71wan41QelZGdNCcqxZhBW8NKNLjeU2+RKGVVsfc8Mov0tHjw/PXL2u1
         GQ6A==
X-Gm-Message-State: AOJu0YxOdiVBnwXa9Fl+XVoyGfzgSXp6bMzxL4Bv5Kc/Aa5kRkOPYrN8
	NL66o3M5SevhogKfUIISUmfLS24AG6Di6m0wEnP09qLE2Yo9bMT73rD8Ww==
X-Gm-Gg: ASbGnctv2+6Ym9r2Mg6q3dy2XliBD5xK9EPVrhmweGMoz+gbG684t1M7gnj4W04ySt1
	I51IhAUXWod9bejAoouN18f55iNJEgZUz2P+XgdFSDr4A4JC/mqj8xKZVwrWlqcXEvj3LYG/z7c
	zAkRlHKDLZQ5pexdyrbhA7BU1WHYmITXQjqtWUnRxqwi3rbqco284Z0jFVIVfEZo6I4uwKSfUbV
	iWXUtGHW7JwCBC3Hs7o2UsFnODt0/SQ5nvKeS3f7vEKRbZD+uclQleALjqCxHwT4D6jcfeKOLRw
	OHo8bS+R
X-Google-Smtp-Source: AGHT+IFfTacmllGjvVrxXK86zstJs5f9abM0gV+K3NKUvgx54JQc6q75UqLULzrOweUZhvLSWu1+ng==
X-Received: by 2002:a05:6214:ac8:b0:6d8:ab3c:5c8 with SMTP id 6a1803df08f44-6dc96890057mr205303776d6.49.1734322357035;
        Sun, 15 Dec 2024 20:12:37 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd363142sm23043616d6.81.2024.12.15.20.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 20:12:35 -0800 (PST)
Date: Sun, 15 Dec 2024 23:12:32 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Oleksii Kurochko <oleksii.kurochko@gmail.com>
Subject: Re: [PATCH 2/3] u-boot: use upstream for radxa-zero-3{e|w}
Message-ID: <20241216041232.GF466@localhost>
References: <20241212195718.25203-1-twoerner@gmail.com>
 <20241212195718.25203-2-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212195718.25203-2-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Dec 2024 04:12:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/926

On Thu 2024-12-12 @ 02:57:17 PM, Trevor Woerner wrote:
> Upstream U-Boot 2024.10 (the latest release supported by Yocto) has support
> for radxa-zero-3{e|w}. Therefore switch away from the fork where the initial
> U-Boot development for this board had been added.
> 
> Reported-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  recipes-bsp/u-boot/u-boot_%.bbappend | 4 ----
>  1 file changed, 4 deletions(-)

Applied to meta-rockchip, master branch.

