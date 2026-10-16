Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A58CC6B38
	for <webhook@archiver.kernel.org>; Fri, 16 Oct 2026 06:12:52 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15560.1792131162937048595
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Oct 2026 23:12:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=hMeZDEZ7;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EE50AC6220E;
	Fri, 16 Oct 2026 06:13:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 23D426075D;
	Fri, 16 Oct 2026 06:12:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 898F210328C79;
	Fri, 16 Oct 2026 08:12:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792131159; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Oj+Pu0nS9plVL7RAzv1/5sfYbC+lVld0tfRMjF65vko=;
	b=hMeZDEZ7L3ptgx7ocT92uaeH2CcZAGn945mbUVBUHpxRXzOdPM0Eoem0cHitJt/9cXN/da
	Nowh/251EsJ0EboojiqnLBs4Sc5Bxtnvq4xppp3fKJTfGDOhyFuSGrQIWFlRu9CzRtI6rM
	o41ibykfiRn2qCpiXIcNa1UblvIZ3ZBy6Bsqtwyo/GJ5JQ0vsGo2yAyitDJSaBACp0HWSQ
	sGabeKNbuUomLAEiTKd8w3QDO/plm8PFkWTrjSDtJGz4GkaRLa0b+S8GVi2BRDV/YQcWoo
	934HDq10GggdyUETfac9KbM9zS3kPsVpvZBs3pBqe4SdptmSzKCNLwR7JF5Lmg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 08:12:34 +0200
Message-Id: <DM61H2PIVOOH.2ZEU6CJ6BQST7@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH v2] pseudo_client: Fix
 xattr/rename handling with empty paths
Cc: <seebs@seebs.net>, <mark.hatle@kernel.crashing.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261015220227.794655-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20261015220227.794655-1-richard.purdie@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 16 Oct 2026 06:12:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5034

On Fri Oct 16, 2026 at 12:02 AM CEST, Richard Purdie via lists.yoctoproject=
.org wrote:
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
>  pseudo_client.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/pseudo_client.c b/pseudo_client.c
> index d83175e..1c742ba 100644
> --- a/pseudo_client.c
> +++ b/pseudo_client.c
> ...
> @@ -1806,12 +1810,14 @@ pseudo_client_op(pseudo_op_t op, int access, int =
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
> +		{

Typo :)

But aside of that, I believe it's OK now.

Thanks,
Mathieu


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


