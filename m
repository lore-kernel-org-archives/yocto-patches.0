Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C85ECC6B33
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 15:43:30 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.241.1792079008712758668
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Oct 2026 08:43:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=MAqLiNPv;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9FD23C62206;
	Thu, 15 Oct 2026 15:44:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 353426075C;
	Thu, 15 Oct 2026 15:43:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3E3D103284F3;
	Thu, 15 Oct 2026 17:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792079001; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qF+YFvtoQGH1b2zYQ3wX2OY4UuHMH/zZBJWycGGMHWM=;
	b=MAqLiNPvtCU8j5OcGw3amdXxJb0SadG82707BbLlrNqEyaQFmbc6PMmYHvMZWWwX/1f3s/
	Hc+yGT8AWudok7rn1FVGdLny9Wq5v3lLN7CJMs//ScrS+RaQYSfQoqxxyJCKjQQYWBmoJE
	eRG2GeUy9P0/C2oqMoa8i7yqmFd3ECmwXi7Xi7c1aud5vZgmsAl+KuEtdFdjEr5B2mgXGh
	GqHVYav4adT5xPqd/HPlcIsvYtmduXJnt84Bs+Mw3nrGYSU0kCsoufPqDyegtJhhrMpXrL
	c4L4/bLdBA7wnDBfk39JmxNkw7MqZjgfBQtkoOFKpEc6wHxP06a/n0bCpai16Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 17:43:17 +0200
Message-Id: <DM5IZI5V42H3.27O69TM6XIPKC@bootlin.com>
Cc: <seebs@seebs.net>, <mark.hatle@kernel.crashing.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH] pseudo_client: Fix
 xattr/rename handling with empty paths
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261014193803.3555726-1-richard.purdie@linuxfoundation.org>
 <DM5GBKVJU334.34PL5P3DVVS4R@bootlin.com>
 <20a05c7e247e12bbf0d2adfb3286f0438ae8ac5f.camel@linuxfoundation.org>
In-Reply-To: <20a05c7e247e12bbf0d2adfb3286f0438ae8ac5f.camel@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Oct 2026 15:43:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5031

On Thu Oct 15, 2026 at 4:25 PM CEST, Richard Purdie via lists.yoctoproject.=
org wrote:
> On Thu, 2026-10-15 at 15:38 +0200, Mathieu Dubois-Briand via lists.yoctop=
roject.org wrote:
>> On Wed Oct 14, 2026 at 9:38 PM CEST, Richard Purdie via lists.yoctoproje=
ct.org wrote:
>> > On Fedora45, we can end up in a situation where path_extra_1 (for xatt=
r/rename ops)
>> > but path is of zero length. The path_extra_1 codepath does not handle =
this well and
>> > corrupts memory.
>> >=20
>> > The issue is "partial_len =3D pathlen - 1 - strip_slash" when pathlen =
is 0 (and
>> > hence strip_slash is also 0). This leads to invalid memory writes and =
if those
>> > happen to access off the end of a mapped segment, the program segfault=
s.
>> >=20
>> > Fix the code to handle the pathlen=3D0 case.
>> >=20
>> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> > ---
>> > =C2=A0pseudo_client.c | 17 +++++++++++------
>> > =C2=A01 file changed, 11 insertions(+), 6 deletions(-)
>> >=20
>> > diff --git a/pseudo_client.c b/pseudo_client.c
>> > index 23d7b0f..002de30 100644
>> > --- a/pseudo_client.c
>> > +++ b/pseudo_client.c
>> > @@ -1789,7 +1789,7 @@ pseudo_client_op(pseudo_op_t op, int access, int=
 fd, int dirfd, const char *path
>> > =C2=A0	 */
>> > =C2=A0	if (path_extra_1) {
>> > =C2=A0		size_t full_len =3D path_extra_1len + 1 + pathlen - strip_slas=
h;
>> > -		size_t partial_len =3D pathlen - 1 - strip_slash;
>> > +		size_t partial_len =3D pathlen - strip_slash;
>> > =C2=A0		if (path_extra_2) {
>> > =C2=A0			full_len +=3D path_extra_2len + 1;
>> > =C2=A0		}
>> > @@ -1804,12 +1804,17 @@ pseudo_client_op(pseudo_op_t op, int access, i=
nt fd, int dirfd, const char *path
>> > =C2=A0				return 0;
>> > =C2=A0			}
>> > =C2=A0		}
>> > -		memcpy(alloced_path, path, partial_len);
>> > -		alloced_path[partial_len] =3D '\0';
>> > -		memcpy(alloced_path + partial_len + 1, path_extra_1, path_extra_1le=
n);
>> > -		alloced_path[partial_len + path_extra_1len + 1] =3D '\0';
>> > +		if (pathlen) {
>> > +			memcpy(alloced_path, path, partial_len - 1);
>> > +			alloced_path[partial_len - 1] =3D '\0';
>> > +		} else {
>> > +			alloced_path[0] =3D '\0';
>> > +			partial_len =3D 1;
>>=20
>> Err, I have a doubt here.
>>=20
>> Setting partial_len to 1 looks correct, but it was previously used to
>> compute full_len, that is used to check the if buffer is big enough
>> (full_len > alloced_len).
>>=20
>> So if pathlen is 0, the buffer can be 1 byte too short, right? Just
>> incrementing partial_len a bit before should fix that.
>
> I can't see where partial_len is used in the computation for full_len ?
>
> 		size_t full_len =3D path_extra_1len + 1 + pathlen - strip_slash;
> 		size_t partial_len =3D pathlen - strip_slash;
> 		if (path_extra_2) {
> 			full_len +=3D path_extra_2len + 1;
> 		}
> 		if (full_len > alloced_len) {
>                     <realloc code>
> 		}
>
> Cheers,
>
> Richard
>
Yes, sorry, my previous mail does not make any sense. Let's try that
again.

So my point is, if pathlen is 0, we have:

>		size_t full_len =3D path_extra_1len + 1 + pathlen - strip_slash;

So full_len is going to be:
path_extra_1len + 1 + 0 (pathlen) - strip_slash
So it will be at most:
path_extra_1len + 1

>		size_t partial_len =3D pathlen - strip_slash;
>		if (path_extra_2) {
>			full_len +=3D path_extra_2len + 1;
>		}
>		if (full_len > alloced_len) {
>			free(alloced_path);
>			alloced_path =3D malloc(full_len);
>			alloced_len =3D full_len;
>			if (!alloced_path) {
>				pseudo_diag("Can't allocate space for paths for a rename operation.  S=
orry.\n");
>				alloced_len =3D 0;
>				pseudo_magic();
>				return 0;
>			}

So buffer size is at most `path_extra_1len + 1`

>		}
>		if (pathlen) {
>			memcpy(alloced_path, path, partial_len - 1);
>			alloced_path[partial_len - 1] =3D '\0';
>		} else {
>			alloced_path[0] =3D '\0';
>			partial_len =3D 1;

OK, partial_len is 1

>		}
>		memcpy(alloced_path + partial_len, path_extra_1, path_extra_1len);
>		alloced_path[partial_len + path_extra_1len] =3D '\0';

Then here we write at offset `1 + path_extra_1len`.
So buffer size should be at least `1 + path_extra_1len + 1`

>		if (path_extra_2) {
>			memcpy(alloced_path + partial_len + path_extra_1len + 1, path_extra_2, =
path_extra_2len);
>		}
>		alloced_path[full_len - 1] =3D '\0';
>		path =3D alloced_path;
>		pathlen =3D full_len;
>		pseudo_debug_call(PDBGF_IPC | PDBGF_VERBOSE, pseudo_dump_data, "combined=
 path buffer", path, pathlen);

Hopefully this makes a bit more sense now :)

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


