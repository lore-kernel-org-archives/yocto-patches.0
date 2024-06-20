Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F884C27C79
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 16:26:52 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web11.52123.1718900808025289449
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Jun 2024 09:26:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QvCqAWZW;
 spf=pass (domain: gmail.com, ip: 209.85.128.177, mailfrom: twoerner@gmail.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-63bc513ade5so9594037b3.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Jun 2024 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718900806; x=1719505606; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utXQiSW7ecASwX2M8xXauHmxQjaAePT/qug+j+37FCE=;
        b=QvCqAWZWAYx6F6OmoWZSURbC1/UinDirgTnUCXSONZuGrHMRbGX90s7vF7LCiVQjAj
         Jolb/qQQA//b82AwmuhenexSpJiPwPpzT5BmcXycyunGL/osGGJxOr8hRRQ2n14vde4D
         wMjkOzzXVW2RbZHb3XUgdH5Zckfx8sUDT2Mfk63/yu+u/4xAjcHMf6OGia9sdvrma1kg
         JR33AgjYtgSasC94QZUNyfoT4/gzw9i/Choc+jsoLVxrgxLPPlt6m5fx9A0tRcZCmvOj
         W1QjmtFkDe7QSiO/qZz2CZI9fTQBXlQN6UWQkVxnTHUnArOCWorM7Hxx2qXFy9IQVkHB
         PmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718900806; x=1719505606;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utXQiSW7ecASwX2M8xXauHmxQjaAePT/qug+j+37FCE=;
        b=lP1noB9OlDKr+AVL3puLPKp1hSyoniwMggo6jayhjywK0qKZomfzW3g8Z3QpWHfuuU
         aeD4bcvDxvlbdGKFGeNhRh5KMJCjPSMk9FsdfaYQuRYTq6GzzWppaGa3DAWadVWEHum5
         FBAETmHbnBNTKgMWLTtDlNj0GdOeyFZ8GvVmDbRtXFPL4MTCv91bDbuhf0P0iz+0zUBs
         SAAquArzdGBmPQmbXhZ2OerIEL0om0MZBCl8hbPSxwPShFBOV9wzGeAmDWzX5TrVVv1N
         j4OCdDG/3VmqNUfzdp2aWIU1l1fBiKFVCG/h6Gm1OvFjDopzaxgsNfw4eLdvSvkr0g2T
         vB1w==
X-Gm-Message-State: AOJu0YwfCzPqvqtY+zOAuKNVGpXamfF3nVh5kcnGpZHEsLODVCxPdtyF
	aml2a4wUW7iHMKlmkZtieb3NMFYhFX66JKD6CSNPf3lH5C7bcqNCPw5tNi51
X-Google-Smtp-Source: AGHT+IGShhQD2debWR8WV/MOzgKF1TQpghe4J7hxTmTqc5AhOJfzaS91FBPjkd/bV4nNJ0mcLHrJzQ==
X-Received: by 2002:a0d:eb01:0:b0:631:4e00:2c06 with SMTP id 00721157ae682-63a8d82c7efmr62090387b3.2.1718900806423;
        Thu, 20 Jun 2024 09:26:46 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-631183d7842sm30771017b3.24.2024.06.20.09.26.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:26:45 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:26:42 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH] linux-torvalds-next: SRCREV with nobranch
Message-ID: <20240620162642.GA14580@localhost>
References: <20240620014904.40092-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620014904.40092-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Jun 2024 16:26:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/360

On Wed 2024-06-19 @ 09:49:04 PM, Trevor Woerner wrote:
> Switch back to using a SRCREV, but this time without a branch (since this
> commit is no longer reachable from any branch), so that network-less builds
> can take place (or builds that don't need to resolve the tag (over the
> network)).
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  recipes-kernel/linux/linux-torvalds-next_git.bb | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to meta-rockchip, master branch.

