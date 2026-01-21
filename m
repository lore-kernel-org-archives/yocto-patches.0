Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CF3D46943
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 14:55:52 +0000 (UTC)
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13581.1769007351802032980
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Jan 2026 06:55:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Psot3W0l;
 spf=pass (domain: konsulko.com, ip: 209.85.219.68, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-88a37cb5afdso14151576d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 06:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769007351; x=1769612151; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nA5XXNGWqiYnVEtY691vR4FRxPmW8R3DoSGyyP0CPjs=;
        b=Psot3W0lm/S1HcbK0rRHNcgU4ql0/mGKzQ4+FHqgEbh4XRleZ6wQXPh0e9UrXotl0I
         dd41tNFQrwRlZu0iM5uzpyERSpeFN4sgarEWdHZBVT36A7jnPSP9BYYQX4uNbEHlW94Z
         zelil+Yytsl6ViT7Ip0bz5pAgYQO5HiIh2yvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007351; x=1769612151;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nA5XXNGWqiYnVEtY691vR4FRxPmW8R3DoSGyyP0CPjs=;
        b=l58uNhTuaMe3VdVmCcbneTuBsa61waz/8NDSmBMngY3bn6Ip52sXGe+oYS1yRaPST+
         FdUMA2H/3FL0PQFlKV2fuF5FMoedgppD8aRECNa7j1Fy4N+mft9nViPd2Pb6dxztuxCo
         9XiL5gIAno6eZwtgUsnv6+N+MXDp/YyuIiVRisDmHr+2ibNLsN0MBJ3V6mvgxAw2DxVV
         cuMjkZTt8HzEgJi9UKKN7PqX0n9HiwvxmN75GwmRWRiZvgcAaMPVLCER9EyfAJN0nLuY
         lDSpBUhNEMC1LbBwlqihWS91T97lDwCLE7WlFNojSs0/H2xUhb7rrcVBd9zGhvdheBVx
         kSsw==
X-Gm-Message-State: AOJu0YwOhnulr5osuyE5NDj3bkU5Sp9AOKYKsF6fxR4rkGm7TL6bn57T
	dYizWrGA4CqqsCW3IjkMuTWl+U8bb/WEwyj9L/epHB+9Cn+0oCwNlah4SGODv3k7fB834vl/Cq6
	odjRqzjE=
X-Gm-Gg: AZuq6aKBj2lPXldR8q3CsbPI/jHQH7L3AjBD0+2qn1FAKgaeFeX4wolxqg07fK+KYD/
	CV6ZjaOATKT+w8rojvAxAkdm7qxYCpYZB8xmwcDFR+fgr5i6eW5fxeL2InN7F1y1Xr8NkU8TNOO
	lK6Q5qrlfs5Ux2nbBIxfTPksdRxvTUtDDcW5n6yOE9qB1eaK4okOJrKKW/LL/mpRmJxZWx5s+Tp
	BWapSvxRX/sEw4xSca2Orw3JmDuv0+1U8gwbSxBOmBHeCbe8RsjqDHyFT5ZPtFsxaBot8suHgoy
	3fAXN0PC1B4qhVrFSJMtUp8c30gtY6F7/WxwMMP57froCgafs684BOmy6UziUFPMOaEDFNYijCc
	iOg/hXM06tkV674yIv/iFrBvHTU/B1pqFHgDYS6axNXwWTLpY/3K8MThHD8TwNP9xBhVNFgMYH9
	m9IwIDJSFL507F+sMUCEDo/7he+lA5kG13dYzj6tl+wQrNu2aJ4t8BzK3fmuQAPiKk+FkxVexvW
	mPjVAu/cl9xmQByNkSPq95CePTClF5svfQ=
X-Received: by 2002:a05:6214:124e:b0:88f:ce0b:a008 with SMTP id 6a1803df08f44-89389f82fc5mr341249106d6.3.1769007350487;
        Wed, 21 Jan 2026 06:55:50 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7292cfbsm1248287885a.50.2026.01.21.06.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:55:50 -0800 (PST)
Date: Wed, 21 Jan 2026 09:55:39 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: Re: [yocto-patches] [meta-lts-security][PATCH 0/3] Assorted updates
 01/19
In-Reply-To: <188C3BD0ABF104BC.2815209@lists.yoctoproject.org>
Message-ID: <6e66d555-49f6-79cd-23e2-bdb6ba52eb23@konsulko.com>
References: <188C3BD0ABF104BC.2815209@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 14:55:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3039

On Mon, 19 Jan 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series rolls up the contributed patches from the past couple
> weeks, plus a lynis update from myself.  These changes are queued on the
> master-next branch if you would like to check them out to test yourself.
> I intend to merge these to master branch at end of day tomorrow (Eastern
> Time, Jan. 20) unless there are objections.

These changes have now been merged.

Scott

> Changes:
>
> Clayton Casciato (1):
>   suricata: add PACKAGECONFIG[seccomp] - MemoryDenyWriteExecute
>
> Scott Murray (1):
>   lynis: upgrade to 3.1.6
>
> Stephan Wurm (1):
>   dm-verity-img.bbclass: filter units from value part
>
>  classes/dm-verity-img.bbclass                     |  4 ++--
>  .../lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb}      |  2 +-
>  recipes-ids/suricata/files/suricata.service       |  1 +
>  recipes-ids/suricata/suricata_7.0.13.bb           | 15 ++++++++++++++-
>  4 files changed, 18 insertions(+), 4 deletions(-)
>  rename recipes-compliance/lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb} (96%)
>
>

