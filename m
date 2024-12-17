Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC83E7717F
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 03:43:34 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web11.74338.1734407008707881786
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Dec 2024 19:43:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dS+0QtMu;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8e8cb8605so27287316d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Dec 2024 19:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734407008; x=1735011808; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZTY6+Y4E5OjoKuO5BfaJQjydTLpPB1o2/QnJRWxLuc=;
        b=dS+0QtMuXy2SP3EYukDOwF0Cj7ONpQR4RBY7CiICy3zy1VYVrV7WGkzXqGNY8TEq4T
         49qCaIp9GdVMACgcVHTTF5EzuME4dfOubiPMJI36DI340qAqGyG9/YERCZmWAr+EssVI
         rOl27BEHJ4W/0rddg2NyRSKMLVzSCnpkf4XSvvq4DcISQuqY+fkfWj3vPkoQpS4U7+j5
         MbEzfNGm4jv25jptvpdGVpzH3f6g8ryzkYjDQN0i1fFCzIJ/VmaLi55CBwuBYviT3EiR
         pG4yFlCW/6NMWNVkkvGaqC6ZGpHNBeZqAQ3cEJbWEtU8jrK76Sh9SgSO5GSVITEqKn8R
         L8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734407008; x=1735011808;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZTY6+Y4E5OjoKuO5BfaJQjydTLpPB1o2/QnJRWxLuc=;
        b=hgniuon0V4ikiif3IvUgJgFsOynwUnFwVE3s2VQgbYwD7UaOZWx4i6pv/L3oPGBZi0
         U4WRRCJX5jf3AtSLV5RwnFP6WY/gLAQ5eNeoeDRvz3FSEzCCEDBtLwjY1hxRSNs1QcrL
         dtqB2K+46vuDG6LrC8bxvzWim6POmFRFWZE7RAh+zGI5HuIDih3OIWznw102QN+zjLCO
         2X4wXQNe6Jbo/uuGfQ+xaEsrtb1DlqV39dxmKuhavhHgubt5b0otZzCfOVP34G22CJJ7
         WZ4NA7OH6MWTA69H/1tdK7wCaqW7zsjXzSxu+fVPlqvkpHXm9UD8TRhk6oj8rXjAovk+
         gg2A==
X-Gm-Message-State: AOJu0YwPyQ7j3ePcUT7f9ycOmBwXlT5/9ZNgi6R5PIFYUHKQ96XlRsNV
	7610eQBpBSBf0Sm2b8oXRRZs3Wz7XcGQiEK07Tskf1tl19RNP6jz
X-Gm-Gg: ASbGncuD3BoHLUv9zMh1ywp+eVLe2yVa7cdbgtsOYIDoaapA9VmB3MmpvKBMei0GYoU
	whaadyBtydnWVFO4XEc5wkVpV+yaGpt9dYbYHcxqkmbrWdVUO4ttZ4H5Hm/+4TVKF/jkCcgbQw0
	9mZGy3SJXv/9SZcYkAiRH7AOuRsDgGo4XLFkGK0CnUIzoxPp1HOecmho9/7bqKW0VgI2sdyRAK3
	RZQOPFOQcwrM13h4WwqtOtIqLOWVIQpLEiyFDzEkvUv96LhvWZ1kAWWYM8m4SPEB9DtQ/nM4JET
	nmfnMfDS
X-Google-Smtp-Source: AGHT+IF6QOl9Xz1JEGkbfP1OuHs8jPCctVsR73WNdaFN282nBdkxW3+c50GZkfj8AF0ug6F2eGLnbQ==
X-Received: by 2002:a05:6214:301e:b0:6d8:99cf:d2eb with SMTP id 6a1803df08f44-6dc8ca84af2mr267220886d6.21.1734407007770;
        Mon, 16 Dec 2024 19:43:27 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2c69b10sm34684671cf.18.2024.12.16.19.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 19:43:26 -0800 (PST)
Date: Mon, 16 Dec 2024 22:43:24 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <foss+yocto@0leil.net>
Cc: yocto-patches@lists.yoctoproject.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [meta-rockchip PATCH scarthgap 0/3] bsp: rkbin: bump to latest
 commit in master
Message-ID: <20241217034324.GA15209@localhost>
References: <20241216-rkbin-bump-scarthgap-v1-0-9057e03351ad@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216-rkbin-bump-scarthgap-v1-0-9057e03351ad@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Dec 2024 03:43:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/931

On Mon 2024-12-16 @ 02:39:46 PM, Quentin Schulz wrote:
> Backport patches from master to scarthgap branch.
> 
> A choice was made to not backport the splitting of op-tee, tf-a and
> ddr-bin in their own recipes as it would break users of meta-rockchip if
> they bbappend the recipe. This will make backporting increasingly more
> difficult so maybe we could revisit this decision at some point.
> 
> Build and run tested on RK3588 Jaguar.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (3):
>       bsp: rkbin: do not add default DEPENDS dependencies
>       bsp: rkbin: use version and file variables for path matching the DDR init binary
>       bsp: rkbin: bump to latest commit in master branch
> 
>  README                                  | 15 +++++++++++++++
>  recipes-bsp/rkbin/rockchip-rkbin_git.bb | 26 ++++++++++++++++++++------
>  2 files changed, 35 insertions(+), 6 deletions(-)
> ---
> base-commit: e641dba980efa885df7e992ac5c8783270aa375d
> change-id: 20241216-rkbin-bump-scarthgap-03e1a8343005
> 
> Best regards,
> -- 
> Quentin Schulz <quentin.schulz@cherry.de>

Applied to meta-rockchip, scarthgap branch. Thanks!

