Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CD1CC6B33
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 13:38:19 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40407.1792071491053856117
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Oct 2026 06:38:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=dH6ySk9Y;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C65D01A122A;
	Thu, 15 Oct 2026 13:38:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9AFC560360;
	Thu, 15 Oct 2026 13:38:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C609A10328B9A;
	Thu, 15 Oct 2026 15:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792071484; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TDgL+5U1XsPdgPoZJD9JOxQoy3EuVecjytG1E9DZgos=;
	b=dH6ySk9Y4Yqys8NMXRp01T90c9eTtxMHOqlE6Pg0lgHhmrx/8ePH5UftWzefNrdMqZUWX0
	ORfA84YauhGIxkvSwoDbSIW2t9KYxXiEhJ/8xLPNlVPcDtNic4DZCQsKZbQtvTKaCNV57V
	YKWOmgxsOduH7ayoaNjMU53k6Iu/DthfVMBz8jAgFDG9lPE2wETQZ3i4oDC9weJNurGB/o
	oBwqONaY6u1KwOg2jbY3hzPPW/ssj+I/l2oTD+E400siz6hAKFe2OH7MAuHt/BYnIjZLti
	vjbi75OG8rm3uSIXj6TznTwZl+ywmAGpyhBckvU8HpXvidPMajiy3DIVpplmyg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 15:38:00 +0200
Message-Id: <DM5GBKVJU334.34PL5P3DVVS4R@bootlin.com>
Cc: <seebs@seebs.net>, <mark.hatle@kernel.crashing.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH] pseudo_client: Fix
 xattr/rename handling with empty paths
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261014193803.3555726-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20261014193803.3555726-1-richard.purdie@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Oct 2026 13:38:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5029

On Wed Oct 14, 2026 at 9:38 PM CEST, Richard Purdie via lists.yoctoproject.=
org wrote:
> On Fedora45, we can end up in a situation where path_extra_1 (for xattr/r=
ename ops)
> but path is of zero length. The path_extra_1 codepath does not handle thi=
s well and
> corrupts memory.
>
> The issue is "partial_len =3D pathlen - 1 - strip_slash" when pathlen is =
0 (and
> hence strip_slash is also 0). This leads to invalid memory writes and if =
those
> happen to access off the end of a mapped segment, the program segfaults.
>
> Fix the code to handle the pathlen=3D0 case.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  pseudo_client.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/pseudo_client.c b/pseudo_client.c
> index 23d7b0f..002de30 100644
> --- a/pseudo_client.c
> +++ b/pseudo_client.c
> @@ -1789,7 +1789,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd=
, int dirfd, const char *path
>  	 */
>  	if (path_extra_1) {
>  		size_t full_len =3D path_extra_1len + 1 + pathlen - strip_slash;
> -		size_t partial_len =3D pathlen - 1 - strip_slash;
> +		size_t partial_len =3D pathlen - strip_slash;
>  		if (path_extra_2) {
>  			full_len +=3D path_extra_2len + 1;
>  		}
> @@ -1804,12 +1804,17 @@ pseudo_client_op(pseudo_op_t op, int access, int =
fd, int dirfd, const char *path
>  				return 0;
>  			}
>  		}
> -		memcpy(alloced_path, path, partial_len);
> -		alloced_path[partial_len] =3D '\0';
> -		memcpy(alloced_path + partial_len + 1, path_extra_1, path_extra_1len);
> -		alloced_path[partial_len + path_extra_1len + 1] =3D '\0';
> +		if (pathlen) {
> +			memcpy(alloced_path, path, partial_len - 1);
> +			alloced_path[partial_len - 1] =3D '\0';
> +		} else {
> +			alloced_path[0] =3D '\0';
> +			partial_len =3D 1;

Err, I have a doubt here.

Setting partial_len to 1 looks correct, but it was previously used to
compute full_len, that is used to check the if buffer is big enough
(full_len > alloced_len).

So if pathlen is 0, the buffer can be 1 byte too short, right? Just
incrementing partial_len a bit before should fix that.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


