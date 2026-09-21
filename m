Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1597FC982E1
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 09:28:36 +0000 (UTC)
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45071.1789982908861092414
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Sep 2026 02:28:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=jRAXjFml;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=rw/yn1Ng;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.149, mailfrom: paul@pbarker.dev)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D92831D000CC;
	Mon, 21 Sep 2026 05:28:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 21 Sep 2026 05:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789982907;
	 x=1790069307; bh=rcNBW5+uMzpezx7TgvlL0C+Ys8CDOzXxFoeXoHziwwI=; b=
	jRAXjFmlu2H5ghSk2Q3dj5Itc9MyJHboPk4FWD+wpxBH5SEhERkDWLkI03Pul3Ij
	jmRY0vEod9kGrtS9DWwAjLh1KqSVbQ28EomBtPftzfFcsiZOPFeKruho25nOVviN
	fFHPB//qjddqezGZn++GXtSu5aZ9L8TFHCvQaWQ/swMYvSioq1xop1XZJ9fF6j6h
	mWN3NPBujTKxZIIAEL7by2x5nAMXUvrt1O4VOtfrxKBlnH/0KUS44gRKraHyyRJQ
	kSLjN8YGDRcVN0D1uLQSGruc0C/7KYLfmU3JZ+OWq+KdngLR/oljKraWkMAHllF3
	kjS1yz18q11b5rgsvOUz6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789982907; x=1790069307; bh=r
	cNBW5+uMzpezx7TgvlL0C+Ys8CDOzXxFoeXoHziwwI=; b=rw/yn1NgTMBHUJ6Nd
	W3aoZPO2EMyAEiVxXqJ3cjXGOJQp9osPkBOTAhV4q9hNjzpKswgvy/hpcLRVsDbj
	vQiekB6L/08eeB6aB1GRcFJRBRMAqxsnFLcN/CZg5OHqVT4UZg8v36UTJqIdSWB3
	kEdQyxK83gsLeFYbqqph7G7wNpN9tpu1/5/jwhy3qtiOh7cAoJfigwtwg14oGXXs
	hNa6QvFtK7Fm4uWRa5VDRUqshYmtkzvJtRyo+nZE71rrD8exqBScSIXFTedmaOGk
	5GYSO+FMhGjmGeEltCwlhcMHPmeWVNIV1whj9ozFDieQVhey+9WrJjWjNGNCYDGn
	axz/Q==
X-ME-Sender: <xms:u_iwapeca4KxWENzvf8EUbnV0OrYrpYEDu9GAXFhiKE8sgTLVVdVQA>
    <xme:u_iwatP1SFzkdNzvzjf0McShJ1Yk7CpvZhXlENQjbqy6ou4Cj_5vJBEiE9e2NFrvi
    H1lE-7Pff0hczu5s3jgGRYm_BxLVkIKllrmLI_bXBHvOhNgO0YVAObd>
X-ME-Received: <xmr:u_iwagIzuaReSjD4Ay4r93o8fFFUDX96CysM8SCNvPeqiarp544oNvK4BQos-Ct54fa6>
X-ME-Proxy-Cause: dmFkZTGAYyvYH/Xq/bIcYep5F9zDUu2BXbGBphS4BEgBWAuYk52FmdxK9HQ/fai2/4/ATB
    NeQKQIZtoZ/W4EUNtKcawaPad5rpM7U35vnegn73W7eIA6yIgfcCsC3cgAuC3SClP5xhPL
    fNYgSZ2EvXbNQ26ibe+/8N6PD02wt7sJWzxPGuU01PxpokKgj5pnR5KODkhAod4B4h3pMV
    GNcqPLzFNuqIjCB6xjRw9QvUxTagRVxGsam5/lqgD7m9wOxFMj917McFB6gkPh/Z/QPeNx
    /++3xggrg9cyF1cxXkh3B8eh+QUFDvM/CHtbYFvWOfqJh+XRSswGcm884ejcSM1EBubPn+
    zlxULBuaI8qEAAhM0MseOCBZeeJZyVeA9VJ0bH5W3lhyeUznTD92xHy3uygMBuqs1cCCJz
    e8Eszfi6JJCmxDE0MRSmR3WxSy64TV4bS3sjbKcv4XBmXhsKmcByjjyzRB//g8+SGMx4VB
    saQVoSkxaeA+ohZ89RNvUzFD+uZ3MZY777L0rPtPzYaEvOVdB+jrfQ5ElVmtTiNNv2MEY+
    8ttU6I9Sene9WlurjJvAHqKOBhYKYYH4P8p7Cg0AEYfqbrzzq+r9XJOsJtOruiYe4fa10U
    MF0CPK1iqDeDLggQIElMP3rYNKpbChwNpsf2MpyIR30Dl7JWn2YIbsai0S1A
X-ME-Proxy: <xmx:u_iwauHMYHCtrbnlJIyATfNqDzqPC_Xwu6E2D8lDyARfK6SQvV4qGA>
    <xmx:u_iwaoTfe7i_mwPT6YMnjpswG67Mg089t3XAdVcWKe850BdHltabaw>
    <xmx:u_iwaqGu1vrzoxpTNiMlklcLLFVqRdfn-_l49gDUFIseDMcfj66f8w>
    <xmx:u_iwak-zTST6Rwtg9xA4OME55TA0rV8TarotpT9p3BCsbX7roR2BRw>
    <xmx:u_iwauvYL4Hh42lxOvuxLRYx7w2LxdCQaS4_YyK2eHIQwkKs2qHbBO0U>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 05:28:26 -0400 (EDT)
Message-ID: <6307d52fb41715013cddf71e6493373f672f46e2.camel@pbarker.dev>
Subject: Re: [pseudo] [PATCH v3 1/6] ports/linux/guts: Add open_tree wrapper
From: Paul Barker <paul@pbarker.dev>
To: frezidok1@gmail.com, yocto-patches@lists.yoctoproject.org
Date: Mon, 21 Sep 2026 10:28:25 +0100
In-Reply-To: <20260907111843.26746-2-frezidok1@gmail.com>
References: <20260907111843.26746-1-frezidok1@gmail.com>
	 <20260907111843.26746-2-frezidok1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 09:28:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4920

On Mon, 2026-09-07 at 14:18 +0300, frezidok1@gmail.com wrote:
> From: Dmitry Sakhonchik <frezidok1@gmail.com>
>=20
> [YOCTO #16379]
>=20
> OPEN_TREE_CLONE is not handled since it requires CAP_SYS_ADMIN and is out=
side the common pseudo use case.

We should at least log an error if OPEN_TREE_CLONE is seen instead of
silently ignoring it.

>=20
> Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
> ---
>  ports/linux/guts/open_tree.c | 46 ++++++++++++++++++++++++++++++++++++
>  ports/linux/portdefs.h       |  9 +++++++
>  ports/linux/wrapfuncs.in     |  1 +
>  3 files changed, 56 insertions(+)
>  create mode 100644 ports/linux/guts/open_tree.c
>=20
> diff --git a/ports/linux/guts/open_tree.c b/ports/linux/guts/open_tree.c
> new file mode 100644
> index 0000000..6c2aad9
> --- /dev/null
> +++ b/ports/linux/guts/open_tree.c
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright (c) 2026 Yocto Project
> + * guts/COPYRIGHT for information.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-only
> + *
> + * int open_tree(int dirfd, const char *path, unsigned int flags)
> + *	int rc =3D -1;
> + */
> +
> +	struct stat64 buf;
> +	int save_errno;
> +	char *pseudo_path;
> +
> +	if (real_open_tree) {
> +		pseudo_debug(PDBGF_SYSCALL, "open_tree, calling open_tree.\n");
> +		rc =3D real_open_tree(dirfd, path, flags);
> +	} else {
> +		pseudo_debug(PDBGF_SYSCALL, "open_tree, calling syscall.\n");
> +		rc =3D real_syscall(SYS_open_tree, dirfd, path, flags);
> +	}

The commit message or a comment should briefly explain why we need to
handle both ways of invoking the real open_tree syscall.

> +
> +	pseudo_path =3D pseudo_root_path(__func__, __LINE__, dirfd, path, 0);

This should be after the (rc !=3D -1) conditional, as this call could
clobber errno.

> +
> +	if (rc !=3D -1) {

Nitpick: To save indentation, we can check for (rc =3D=3D -1) and return ea=
rly.

> +		save_errno =3D errno;
> +		int stat_rc;
> +
> +		stat_rc =3D real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (fl=
ags & AT_SYMLINK_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
> +
> +		pseudo_debug(PDBGF_FILE, "open_tree(path %s), flags %o, stat rc %d, st=
at mode %o\n",
> +			pseudo_path, flags, stat_rc, buf.st_mode);
> +
> +		if (stat_rc !=3D -1) {
> +			pseudo_client_op(OP_OPEN, 0, rc, dirfd, pseudo_path, &buf);
> +		} else {
> +			pseudo_debug(PDBGF_FILE, "open_tree(fd %d, path %d/%s, flags %d) succ=
eeded, but stat failed (%s).\n",
> +				rc, dirfd, pseudo_path, flags, strerror(errno));
> +			pseudo_client_op(OP_OPEN, 0, rc, dirfd, pseudo_path, 0);
> +		}
> +		errno =3D save_errno;
> +	}
> +
> +/*	return rc;
> + * }
> + */
> diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
> index 1f1a41a..565fed9 100644
> --- a/ports/linux/portdefs.h
> +++ b/ports/linux/portdefs.h
> @@ -82,3 +82,12 @@ extern int unshare(int flags);
> =20
>  #define SYS_openat2 __NR_openat2
>  #endif
> +
> +#ifndef SYS_open_tree
> +
> +#ifndef __NR_open_tree
> +#define __NR_open_tree 428
> +#endif
> +
> +#define SYS_open_tree __NR_open_tree
> +#endif
> diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
> index 3cea20a..a51e9a0 100644
> --- a/ports/linux/wrapfuncs.in
> +++ b/ports/linux/wrapfuncs.in
> @@ -10,6 +10,7 @@ int lchown(const char *path, uid_t owner, gid_t group);=
 /* flags=3DAT_SYMLINK_NOFO
>  int __fxstatat(int ver, int dirfd, const char *path, struct stat *buf, i=
nt flags);
>  int openat(int dirfd, const char *path, int flags, ...{mode_t mode}); /*=
 flags=3D((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EXC=
L))), noignore_path=3D1 */
>  int __openat_2(int dirfd, const char *path, int flags); /* flags=3D((fla=
gs&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EXCL))), noignore=
_path=3D1 */
> +int open_tree(int dirfd, const char *path, unsigned int flags); /* noign=
ore_path=3D1 */

Does this need preserve_paths=3D1 (similar to openat2())?

That would require us to account for a possible chroot in the
open_tree() guts, but it would avoid us running pseudo_root_path() on an
already canonicalized path which may introduce problems under a chroot.

>  int mknod(const char *path, mode_t mode, dev_t dev); /* real_func=3Dpseu=
do_mknod */
>  int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* rea=
l_func=3Dpseudo_mknodat */
>  int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev); /* fla=
gs=3DAT_SYMLINK_NOFOLLOW */
>=20

--=20
Paul Barker


