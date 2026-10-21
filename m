Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7288.1792573416380423184
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Oct 2026 02:03:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=r9sbv3BO;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=jXVoFD8E;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.152, mailfrom: paul@pbarker.dev)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 96E267A00FD
	for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 05:03:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 05:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792573415;
	 x=1792659815; bh=q7YQ8EhPyjWDvShyLCrHoFXN+w71swCX0uBoqdGC29w=; b=
	r9sbv3BOc6SQtrLkVY6iN6Y4J8uXSOUVfZ/CByCL8u6Ei3DhWj/p4hMCh2G+0sYp
	ccH31MldhRTrw20OIQUomiC0agXQHhQjXQTqDJ+bxBrwsu6HZsIxbt6PszvEfN0b
	PpERQlh1TRTS/O/V+NfNe870QJ4rQVGdrkqVkJnWQK14Q5d6pxysA7R3pmkaqd75
	UYyKo87f5zfbnry37t/+R1VuYBB68jOSXueVznIyHqJzpCoTd6pYDddk6J/OR6vh
	ML85Op1Bm7w6GniJZh3TwxGlSotilZhMNUBHPgkvklyABAaD/QGcPPxugJz9FXUB
	+2RD8poOUktZ12fQhjzHNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792573415; x=
	1792659815; bh=q7YQ8EhPyjWDvShyLCrHoFXN+w71swCX0uBoqdGC29w=; b=j
	XVoFD8EA/qPXk7RXbD5RnavU0I04MgLkVZ4/gsgclFJEYMxkUrE5X9r1vk3H5V0E
	84fCXOd6ffGPwAUdGHf0+gh/wx7V2qsfHRWboDinc5vsOJjADUB9yY7NhazV5etJ
	7nlm5u2HUwX17a1NvPGN7nQmmNDzCFatMQB2fbbJx5pIhYdiaFMpExwCbMfPMuMT
	ilVkdz8BeS6fzTr9w1BGbIAx02IVVKwpsUjOBnFLsmqylQaGNC4D215xdZHjUCS0
	rMUVgmn2nuq5MyVBCTyHin8n5hMStV7VsdLai/wRSXhqrzTTb17JkSY+aTW8wEvL
	+gBvXZeJN/IYLEdQNlHdw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pbarker.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792573415; d=pbarker.dev;
	mf=PHBhdWxAcGJhcmtlci5kZXY+;
	rt=PHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4=;
	s=fm1:rsa-sha256:QQUNqkTS4ALKHXyMPtxCBKAEqVs9kVF5TiUu5TxVsRidygl
	VUt9xYG81hSU1sWoVJ0SMU6JNo6ZRrtZn4gGW19mX+ZpdoIWGWmBs9ZNqFwB9Rz1
	WT57t+NOoczFbJLpeiJVkGRqxDTHve+c3QQccojKLdPNUYrohp/Su06sx/Y0wNhC
	eDi84PsAW6UfoOCTAt1yt4mF2QBdByBtBrnWhBDe6tKOVo4YRk9roy8UixCbIe/6
	qRpCdoWoZillFTXBL8QsbFFkTmgrfv3+HlA+vsJMheOzXuqhozZBlDjc6C94E6OK
	JbKBxVQM8wKttkhn25oPi8pryoUv3UvVxQt2veg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:icGg9ik+MvHY+DpmnTuncgYxYgOsTSR7cGEpfytgfBE=:Rha9Gg11HEvoZAJXfkxBinl37WuWjMMF5fghMuUS7gg=;
X-ME-Sender: <xms:53_YarqpITwqvgoiMSt0aMI8VaavHbef8LYfDhlp79z-4Ofq1bTSvw>
    <xme:53_YatFXHE62MkfH9GWhUrEtGeF3Nw3O8NNrQoP5l_hqjP9SJE52piolD1ca9TbOP
    24KFsw3xak8vab4mMvDzN4-nywVLDdACSEfm9jtJKSachdv42vcJUiA>
X-ME-Received: <xmr:53_YalkyISDwB3BD3F6AZXsz2DZ0Wu_iGTKtQ0WfL289MRuSetzA5hYLw85ZYfTsxAsYanJWJ9Rz08tuhiGk7XSPs0eTl_FL8g4tJ3o>
X-ME-Proxy-Cause: dmFkZTFfjeGnf++BNDIA5C434pwekk/kI/WbzPAI3CrpSETr1UlirTpCOGEdq6LhNI7+X2
    3gmzTc6r0NlPVTGN/2Yu4EhZfP5+RuGXz2wSCWZWOOmgfeFqepfD9nRspNRr2XC2IpFrty
    JIlZhnpZjwlECumWS9bAHj2Eu1k/VaoQp6oUaUgA1eR5b10ppcZBsOF7EXTpwO2wfRhT+8
    J8tA114ed6+jInJsvk1xWB0IPeb6DLODOjlJ+/tUNWjyIsSSrevmftQIuMg68kvhPTAZ8L
    08zIHypPIx92znJhKgCaYqBJAx3JtKPqQztL5KUgGE6xb+QvhC/inahJX8kji7BZfmZqtf
    00CA+XmCcWjIy471rY9iOsLMh8dQu/AMjjIlNkos4DMAtwkDGtCA4wgABHYKL2g8U++A+6
    IuLfvougcAUWav+4A13hk0yrY2VJ4A50jgXfWlp4k7t2SDGlmWEne/5DRXAA1sLAbPBTn/
    IuhbQDApSfyR4j7R1WkOdWulTx1/soCwzjVTemZHTrXjZLHMjshg8ep5k3u6V7cLXr6DcH
    SOFj/SCHbxFqyUgBMDUAm9+IForFXJstrytTHMAF6Z4i66FEq14Apqt7fo4CD8KpYFJM1j
    njQ6QWA96ikkoVnN47fCwmDdp3DCb7a9ttRX6J9G+9xNy/oKRJmnMmWGs6uA
X-ME-Proxy: <xmx:53_YaonpNALcajNv98fDgIhHDIJBJlpAX_7vUJ8EUBBu-mw5kE4tfA>
    <xmx:53_YausABv3ohuoLy8sH8fejXajck1_C2xVadsKEUsxzcpzw86AlMA>
    <xmx:53_YajkHl838mAjDVj6Px8H9BPWGyaU4NX9RBou8EBsUO-mcAyR8SA>
    <xmx:53_YahtTKr6ruD5tXJB_r1JfH3sQLh6wEzHXo2k2fE0jiyUayBXdJg>
    <xmx:53_YanakIS9YWEl_qsFNMrYsFXpEnkZIfzjbP2DAeACa1hILoEZxXSOL>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 05:03:34 -0400 (EDT)
Message-ID: <b791c7d9759e55e3c6b75c2c4270398cc9f4a1ba.camel@pbarker.dev>
Subject: Re: [pseudo] [PATCH v4 1/6] ports/linux/guts: Add open_tree wrapper
From: Paul Barker <paul@pbarker.dev>
To: frezidok1@gmail.com, yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Wed, 21 Oct 2026 10:03:33 +0100
In-Reply-To: <20261005081127.107126-2-frezidok1@gmail.com>
References: <20261005081127.107126-1-frezidok1@gmail.com>
	 <20261005081127.107126-2-frezidok1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 09:03:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5119

On Mon, 2026-10-05 at 11:11 +0300, frezidok1@gmail.com wrote:
> From: Dmitry Sakhonchik <frezidok1@gmail.com>
>=20
> [YOCTO #16379]
>=20
> OPEN_TREE_CLONE is not handled since it requires CAP_SYS_ADMIN and is out=
side the common pseudo use case.
>=20
> Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>

Hi Dmitry,

This patch has now merged to master but I've spotted a problem... Please
could you send a follow-up patch to address this? A similar change is
also needed in open_tree_attr().

> ---
>  ports/linux/guts/open_tree.c | 59 ++++++++++++++++++++++++++++++++++++
>  ports/linux/portdefs.h       | 16 ++++++++++
>  ports/linux/wrapfuncs.in     |  1 +
>  3 files changed, 76 insertions(+)
>  create mode 100644 ports/linux/guts/open_tree.c
>=20
> diff --git a/ports/linux/guts/open_tree.c b/ports/linux/guts/open_tree.c
> new file mode 100644
> index 0000000..ca299a1
> --- /dev/null
> +++ b/ports/linux/guts/open_tree.c
> @@ -0,0 +1,59 @@
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
> +	if (flags & OPEN_TREE_CLONE) {
> +		pseudo_diag("ERROR: OPEN_TREE_CLONE is not supported\n");
> +	}
> +
> +	if (path && path[0] =3D=3D '/') {
> +		/* If the path is absolute, we should account for a potential chroot *=
/
> +		path =3D pseudo_path;

pseudo_path is uninitialised here.

I think we're missing the comment and call that's present in the
openat2() wrapper:

    /* This wrapper is not called with modified paths, therefore we have to=
 handle this ourselves.
       We can't use the standard mappings since the function needs relative=
 paths to be preserved,
       they can't be our usual absolute paths. An example difference:
       openat2(AT_FDCWD, "/tmp/testdir/dir1/dir2/", {flags=3DO_RDONLY|O_NOF=
OLLOW|O_CLOEXEC|O_PATH|O_DIRECTORY, resolve=3DRESOLVE_BENEATH}, 24) =3D -1 =
EXDEV (Invalid cross-device link)
       vs.
       openat2(AT_FDCWD, "dir1/dir2/", {flags=3DO_RDONLY|O_NOFOLLOW|O_CLOEX=
EC|O_PATH|O_DIRECTORY, resolve=3DRESOLVE_BENEATH}, 24) =3D 4
       FIXME - we don't handle chroot for relative paths
    */
    pseudo_path =3D pseudo_root_path(__func__, __LINE__, dirfd, path, 0);

The openat2() examples there need replacing with open_tree() examples.

> +	}
> +
> +	/*
> +	* Older libc versions do not provide open_tree(), so call the syscall
> +	* directly when the libc wrapper is not available.
> +	*/
> +	if (real_open_tree) {
> +		pseudo_debug(PDBGF_SYSCALL, "open_tree, calling open_tree.\n");
> +		rc =3D real_open_tree(dirfd, path, flags);
> +	} else {
> +		pseudo_debug(PDBGF_SYSCALL, "open_tree, calling syscall.\n");
> +		rc =3D real_syscall(SYS_open_tree, dirfd, path, flags);
> +	}
> +
> +	if (rc !=3D -1) {
> +		save_errno =3D errno;
> +		int stat_rc;
> +
> +		pseudo_path =3D pseudo_root_path(__func__, __LINE__, dirfd, path, 0);

This won't be needed here once pseudo_path is initialised at the top of
the function.

Best regards,

--=20
Paul Barker

