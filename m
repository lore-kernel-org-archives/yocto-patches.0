Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11308C982DE
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 09:10:43 +0000 (UTC)
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44875.1789981839709133380
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Sep 2026 02:10:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=OD4xcN6E;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=w+UFQGtP;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.158, mailfrom: paul@pbarker.dev)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 08E457A00F1;
	Mon, 21 Sep 2026 05:10:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 21 Sep 2026 05:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789981838;
	 x=1790068238; bh=fR6fwR88NlIUwGjGuOHkmv8kYO06jxs4hOL8YPq2kg8=; b=
	OD4xcN6Ea1yeM0rwYqZUFfnaq7IuFjiuB6Hu6lzMfzC3R9dGS3WHP1GJPusiKJvg
	yxv6+n4OTVdX89hq/cY5pfnu8AGzvJNh/NAXIOPw9TxdboNBksh5Erqr/v27v0vu
	URfCTrql4Ff20eBXMhqzVC1PI4jK21Fb1qgp1PbmzNTklX//2Mu6K0nYi74rnR5F
	wetnYFH3EU4q2/yER4Zh2jjVEJ3G7CL0SfxQMaYF0pc7ZvcT8GSV3iiXun1Unzvt
	5RJFyImtL3fToOL+pAeGT0epSvlMbytWLnB2PKWiyZYVA21J5jSR1FHx4UrXHA8M
	XMS4ZbwOQGwVOdujtEXkKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789981838; x=1790068238; bh=f
	R6fwR88NlIUwGjGuOHkmv8kYO06jxs4hOL8YPq2kg8=; b=w+UFQGtPsOe1e4X0p
	Dec+tu+tQzYJUY/UZ/Ui1M69+LXVhme2Sih2EAvQMJa37uGML6FXRPi2bD5TmSAI
	nG8O1kVBQiRHAb9m6OIR2NoLXraw0pEQhJKejftRYy97JZl5bp5gH/d4bDnALiZH
	oZtnBHHEdV81Pt4foU06ZHwXSPj+bVWjxhs1T93FiByRQG7bL7V05zgrs4zuUf8b
	Atmtxm80taXWMZLP8112t8PDz0bKpI0OYYHv4N1pPvzUSC5s29Y5gPTd29iPDdTi
	qGtYeAGJaToI7UUYz5sENlpC6PM226FqnjjPndEofkRgRvvrMtC8FqXW0/zxEIJK
	u2xIg==
X-ME-Sender: <xms:jvSwal4SlvbXad21_2AiUYJlPYSMJ2ghHg1192crxwLqe0QzIt7Znw>
    <xme:jvSwao7loR2rrcYGYmNUNHzXJym3BK39qyPcytOa2Ydl0l5E_iZ9vPxV1sKSLhqEy
    7G2IRVH8qqDTrxkJsimdC6257RTfK5gGaUuC5cTU9dCEnWvAJ64Qw>
X-ME-Received: <xmr:jvSwaqFHXQm73loFNynsqStltxr5sLdaf7BnG48B6S5wg0vtLZpa_ZYolBQSEeWfWdSc>
X-ME-Proxy-Cause: dmFkZTGfCphX+c8v7fhURS06sAHZ44NrIPb/EJBHFCemQAsmZclHH1nw40vrN2uYHwJW79
    SPY75WA4PtU90545OziUuJbiiPfBCpY1z/E6TfwzpRplhVNELaHlfjZl2Uv9F4LhiFaKO5
    z5Z9QzXfaHSWW+s2dFbXvfCYv84Jdn3TKuQNiBzvi4ZZ/B1fsfXilcmzRzyFW8QO3XQ26t
    bGaLvemei6+2VK1vEBOYkfAZYdscsw1LjgsDYxC26XoEU8dRfBZnP3HqkgqIMTzzGYTleV
    h2PLdEFVdLe7adBOyQWxwKnMFjYcJzR3CT2qqRxVgH+j5bwv3JFv9tb8jw2ajbBOpMfmLq
    HpMwlKm3C2cZqmL7ZYBUSoZ3GpdRNxsVOYvl67ra/n9r1Q5yZJkkzBuU+BxOynyvvNZNMd
    fILP3QNSVrx7XjycWQsi4UR3nvww8eSjif7fPffl3AJE00YVR2lsRNFXAFNJoUOVaiB34r
    5NM/vpRFc9+Jc460yUm03jGBaubUSlgxLQ3c7KOB88nwk0GVrio4sxW7krnqoc/U2gBmEr
    XQJUlqounj+hGrgIWxoFYOcFQ4K2VQ7Os5cB3N5YKdsCFtX42C95O8+dcGVi8yN065Yf32
    YlVZH1paGjYbUBO4xUSbgBV8/wNfLGSKX+TE1H2XNtrzCuGn6EVwjllJpdug
X-ME-Proxy: <xmx:jvSwapRuWJkxBcKcNSa03nXeowST1X75fasYrg9mJDm9IHeT4dKEog>
    <xmx:jvSwaruKNvBOG9PCTfN5Y_ffkxaX4ShXs7U0xUilqfXlbJ0cJFIuZw>
    <xmx:jvSwagz_2PORu3hxzuWDpRLhrBw6ELRdk_LZRiO1_ToxWZYZX_wlnQ>
    <xmx:jvSwat4SLitYPx33H5-be47Wm9TUuJZGKvsgZNXfEVkkbyjUOliU-Q>
    <xmx:jvSwapIfqJSosQ0ZRH29t4nzWApEg7aUhuSNKt4FlcuHkYgtREx-s8MM>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 05:10:38 -0400 (EDT)
Message-ID: <5b84607c1f358d71df8cf00c01f5029865fbfa5b.camel@pbarker.dev>
Subject: Re: [pseudo] [PATCH v3 3/6] ports/linux/pseudo_wrappers.c: Add
 syscall support for open_tree() wrapper
From: Paul Barker <paul@pbarker.dev>
To: frezidok1@gmail.com, yocto-patches@lists.yoctoproject.org
Date: Mon, 21 Sep 2026 10:10:37 +0100
In-Reply-To: <20260907111843.26746-4-frezidok1@gmail.com>
References: <20260907111843.26746-1-frezidok1@gmail.com>
	 <20260907111843.26746-4-frezidok1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 09:10:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4919

On Mon, 2026-09-07 at 14:18 +0300, frezidok1@gmail.com wrote:
> From: Dmitry Sakhonchik <frezidok1@gmail.com>
>=20
> [YOCTO #16379]
>=20
> Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>

The commit message needs to explain why a syscall intercept is needed
for SYS_open_tree. We don't do this for all system calls.

> ---
>  ports/linux/pseudo_wrappers.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.=
c
> index b920cb2..33cba2d 100644
> --- a/ports/linux/pseudo_wrappers.c
> +++ b/ports/linux/pseudo_wrappers.c
> @@ -102,6 +102,20 @@ syscall(long number, ...) {
>  #error SYS_openat2 not defined
>  #endif
> =20
> +#ifdef SYS_open_tree
> +	if (number =3D=3D SYS_open_tree) {
> +		pseudo_debug(PDBGF_SYSCALL, "syscall, faking open_tree.\n");
> +		va_start(ap, number);
> +		int dirfd =3D va_arg(ap, int);
> +		const char *path =3D va_arg(ap, const char*);
> +		unsigned int flags =3D va_arg(ap, unsigned int);
> +
> +		return wrap_open_tree(dirfd, path, flags);
> +	}
> +#else
> +#error SYS_open_tree not defined
> +#endif
> +
>  #ifdef SYS_renameat2
>          /* Call out wrapper, expanding the variable arguments first */
>  	if (number =3D=3D SYS_renameat2) {
>=20

Best regards,

--=20
Paul Barker


