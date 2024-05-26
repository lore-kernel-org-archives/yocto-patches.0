Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FE3C25B75
	for <webhook@archiver.kernel.org>; Sun, 26 May 2024 13:28:46 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
 by mx.groups.io with SMTP id smtpd.web10.6443.1716730117331314794
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 May 2024 06:28:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mIsWfLv4;
 spf=pass (domain: gmail.com, ip: 209.85.219.173, mailfrom: twoerner@gmail.com)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-df4eb08fd9eso4380090276.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716730116; x=1717334916; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYGZc9P0Z2zQOwiUGBzF+VgU4VTeMl3dzCX1z2fxceo=;
        b=mIsWfLv4EVXcCLRHlA7tfy8xCZ//EtcNX0q5zuWpdtNYmPS9/U4ckaGT+XiHH2yejB
         bn6/k4k63Z58nFbc7/ywH89yA1trMleLcNO2UaMi46OYrgYlsvOHlq3R1DJS4CTD9Nt6
         YjVlDeQn6sEK7Hlzz5zZhKE42vw0M/xes8yUG0Zl/CxXmwAes6J6Ib61C5BNIMWZFxCt
         jypHJtOwyxXlB5K/n9rtQwboHMNK4Ww0YMcCLx5HNKFVxLPLWxyaSmgKoT9nsag6Eemt
         sDhUCkm+YTOL8YdRdC2VoAYWnyTAJb4tObxl+v/TmxCrLmXuGFG5j6t/pdSB3FUpqYh9
         fuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716730116; x=1717334916;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYGZc9P0Z2zQOwiUGBzF+VgU4VTeMl3dzCX1z2fxceo=;
        b=TkJ4U+3LAeSj0X21v/9EU/eDNsHp3rHRP/BV1IQ7yCJa1Ns+bGt343DOkoqR2UKvpM
         eBxoVZmqqlsoJ+50ahpbfed567ctUnx156NTiICb601A+mtHHWLP8BYk7LQtj1syoMm+
         p7VPSQJkdziO45/TbaHTd7sTLM6eNbaACZ4dP7TZwGaWjZmuRPlGyqdi60pn8enpVtnL
         mPA0gYIPaqLDG7HMUJKVTcinAbdU3Jym8wVosH9AZ/aezyK4cSw95yfhsZ3Rec/ChNWq
         Od0kGEYEaANDaOpAqK8gQq83FWqOSuxeyrADYaL2qDI6lI+uXVyZW0bVRHw1ghgrCzm3
         quPA==
X-Gm-Message-State: AOJu0Yzl3ikhZy847/XMW/85MNwFEZOeGNHDPP5/tdGv1nIR2AWnX7vQ
	Zwc3vAPH1lSLTIb1WUii2f8iL5+cSSJxzS08Y7kwt07pKiAQbp4QM4jvJg==
X-Google-Smtp-Source: AGHT+IFe4pa7dib98QM7vqNDBYYNx60pFiJ5JD4+6BMzR8eSgjTUL05qzg3a4xXuLK90YG9JaYNx5g==
X-Received: by 2002:a25:848f:0:b0:df4:dd91:4524 with SMTP id 3f1490d57ef6-df7721e844bmr7086538276.44.1716730115751;
        Sun, 26 May 2024 06:28:35 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca59d6sm226075485a.12.2024.05.26.06.28.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 06:28:34 -0700 (PDT)
Date: Sun, 26 May 2024 09:28:33 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH v2 2/3] specify root partition type
Message-ID: <20240526132833.GB12513@localhost>
References: <20240524023724.20109-1-twoerner@gmail.com>
 <20240524023724.20109-2-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240524023724.20109-2-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 13:28:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/200

On Thu 2024-05-23 @ 10:37:23 PM, Trevor Woerner wrote:
> Specify the root partition's type according to the Discoverable Partitions
> Specification:
> 
> 	32-bit ARM: 69dad710-2ce4-4e3c-b16c-21a1d49abed3
> 	64-bit ARM: b921b045-1df0-41c3-af44-4c6f280d3fae
> 
> Link: https://uapi-group.org/specifications/specs/discoverable_partitions_specification/
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> v2 changes:
> - use lower-case for both partition identifiers (in code and in commit msg)
> - use Arm overrides instead of MACHINE overrides to identify which identifiers
>   are used for which builds, this clarifies why the 2 identifiers are needed
> ---
>  conf/machine/include/rockchip-defaults.inc | 4 ++++
>  conf/machine/include/rockchip-wic.inc      | 1 +
>  wic/rockchip.wks                           | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)

Applied to meta-rockchip, master branch.

