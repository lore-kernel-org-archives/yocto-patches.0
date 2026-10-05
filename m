Return-Path: <marcel@solidxs.se>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5140BCA5FCE
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 11:28:09 +0000 (UTC)
Received: from mail.solidxs.nl (mail.solidxs.nl [135.181.160.165])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17927.1791199684646472905
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Oct 2026 04:28:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@solidxs.se header.s=2026a header.b=O8TRDMGD;
 spf=pass (domain: solidxs.se, ip: 135.181.160.165, mailfrom: marcel@solidxs.se)
Received: from debian (unknown [IPv6:2001:2042:bc22:2b00:dea0:b917:5daf:b679])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.solidxs.nl (Postfix) with ESMTPSA id B44272DA0069;
	Mon, 05 Oct 2026 13:28:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solidxs.se; s=2026a;
	t=1791199680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mlmPR147qPZ5N7/I/Jqo+XYgDnSL9udrRqyJXXhJSV0=;
	b=O8TRDMGDbkyUIqQfgwJW6F/1a4eKA8OXstGZ38dmO+2NPGCKMD5zJQZhcdQy263b13BxGN
	uBP2N3fXfuDkgEZbFCykaWwOKUpEwvfEMxIzGLP3QrkxfMVJNK3CsL8yCk3H7Itv0kxr+G
	KzDdaCn6rZ3z4kaxegH8fj/ReOY3N2pvS+CSGe85XLaqiah3cgvDPxQwsjjiZmGGNgCWsc
	y5FGR5iy0v+92/36i9gKoSQVQPY4fwfAo3U5U1f5TMjheOH2OfuNJCdgzJPIlg0jOrjLqe
	BWy1+du3uFQXqEXHmtqz7vx/wEVzmHoMRUAe3bmnjPbCp8d7ROdfdWb1+d+MKA==
Date: Mon, 5 Oct 2026 13:27:58 +0200
From: Marcel Hamer <marcel@solidxs.se>
To: yocto-patches@lists.yoctoproject.org, twoerner@gmail.com
Subject: Re: [yocto-patches] [wic][PATCH] wic/plugins: allow timeout of 0 for
 systemd-boot
Message-ID: <asOJvoJhF9ejKGC1@debian>
References: <18CF5E858E7BBEE2.642712@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18CF5E858E7BBEE2.642712@lists.yoctoproject.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 11:28:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4990

On Wed, Aug 26, 2026 at 03:38:17PM +0200, Marcel Hamer via lists.yoctoproject.org wrote:
> Setting a timeout value of 0 for systemd-boot evaluated to False and
> caused for a default timeout value of 5 to be set instead of 0.
> 
> A timeout of 0 is a valid loader.conf value for systemd-boot.
> 
> Signed-off-by: Marcel Hamer <marcel@solidxs.se>
> ---
>  src/wic/plugins/source/bootimg_efi.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/wic/plugins/source/bootimg_efi.py b/src/wic/plugins/source/bootimg_efi.py
> index fe6c222..1f73f85 100644
> --- a/src/wic/plugins/source/bootimg_efi.py
> +++ b/src/wic/plugins/source/bootimg_efi.py
> @@ -145,7 +145,8 @@ class BootimgEFIPlugin(SourcePlugin):
>          loader_conf = ""
>  
>          # 5 seconds is a sensible default timeout
> -        loader_conf += "timeout %d\n" % (bootloader.timeout or 5)
> +        timeout_val = bootloader.timeout if bootloader.timeout is not None else 5
> +        loader_conf += f"timeout {timeout_val}\n"
>  
>          logger.debug("Writing systemd-boot config "
>                       "%s/hdd/boot/loader/loader.conf", cr_workdir)
> -- 
> 2.47.3
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4688): https://lists.yoctoproject.org/g/yocto-patches/message/4688
> Mute This Topic: https://lists.yoctoproject.org/mt/120937070/10601239
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/15379525/10601239/1389662109/xyzzy [marcel@solidxs.se]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

Hello,

Just wanted to a gentle ping on this patch proposal. Just wondering if
this was wrongly addressed or if something is missing.

It seems a similar solution is proposed in:

https://lists.yoctoproject.org/g/yocto-patches/message/4960

Thanks!

Kind regards,

Marcel

