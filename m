Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270B6CF9C49
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 16:47:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.971.1763656691961193892
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 08:38:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=korg header.b=uziNtRSg;
 spf=pass (domain: linuxfoundation.org, ip: 172.105.4.254, mailfrom: konstantin@linuxfoundation.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1A8C3601A2;
	Thu, 20 Nov 2025 16:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F0FC4CEF1;
	Thu, 20 Nov 2025 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763656690;
	bh=10hpN9TBV6AE5pm5bNBH5ksbQpFXOMmRuPpoKNvbx5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uziNtRSgcBh551H5RwMJIDHjSirND2o1ZP86g51b0TNJWTMChqRrIgeDSXZWEkTEZ
	 eMEIsJvf04mjsVPe75SuELOkdZNRs+1LbsjnrfLKhsqgtKY4rWoxTfrpr7INozKpBc
	 xqnSK6DuX8e2gUhY6lBJwEFSLBz6qP8aKWoqmDW4=
Date: Thu, 20 Nov 2025 11:38:09 -0500
From: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org, 
	michael.opdenacker@rootcommit.com
Subject: Re: [yocto-patches] [PATCH meta-rockchip] orangepi-3b: add
Message-ID: <20251120-petite-copper-chupacabra-c70e6e@lemur>
References: <1879B0158049C4B6.1423420@lists.yoctoproject.org>
 <f176e971-d19f-47a1-a591-d2a501d16079@rootcommit.com>
 <58102c94-8c32-450a-bccf-1edd16bbad3f@cherry.de>
MIME-Version: 1.0
In-Reply-To: <58102c94-8c32-450a-bccf-1edd16bbad3f@cherry.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 16:47:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2631

On Thu, Nov 20, 2025 at 11:40:05AM +0100, Quentin Schulz wrote:
> On 11/20/25 11:34 AM, Michael Opdenacker via lists.yoctoproject.org wrote:
> > Oops, it seems b4 messed up the subject line.
> > It should contain "[meta-rockchip][PATCH]"
> > 
> 
> All my patches sent by b4 have the same pattern as yours. Glancing at b4's
> code, I believe this is how it's intended to work, c.f.
> get_rebuilt_subject() in src/b4/__init__.py

I just accepted some patches into current master that should deal with
[presubject] the way Yocto lists expect that to happen. Please try them out if
you can.

-K

