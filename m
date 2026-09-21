Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F7FC982E1
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 11:13:17 +0000 (UTC)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46799.1789989191896258674
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Sep 2026 04:13:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fnANoFuv;
 spf=pass (domain: gmail.com, ip: 74.125.224.42, mailfrom: frezidok1@gmail.com)
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-672beabd8a8so46122d50.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 04:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789989191; cv=none;
        d=google.com; s=arc-20260327;
        b=DWttiOfrKwj3n7lQLRkguKKXRPJOkFBxGwir9xfwPTycy9/MH8kZlvdWmtmryPW7gN
         7+1nBEsuDb+oRlwgUO4Od+p27seBO9ZnGOoFgoxfLkIACQUcv63vDpoxeQwcwcQ+7KoZ
         SastsQKerlNp+MX6ZxkuXRZwWOESBB91AR7e+zorK+1rj6GBoC3eKWS3rErsBLNk7afx
         SVxU8FNCsklVlWcfjypCccL1tpXX9duXV7kD81wpWkurnaYKY6ppRb6/+hfD/rIDZxc7
         9FguQOCi4N/1yISQlvkr0FzUpvYU08jGD6Y3O52Z0Juxg03oRgdDMYOEkvdA6stU1HsE
         cplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Uq60GglzMN0RrAE6AWFMel/nRHuWNTjFO96jvYXE0j8=;
        fh=y2+Uz1Oh655/noHVROAFANg0IkeeFgXaRD8dF7xjnCM=;
        b=Fbjo/x48QaMRsSOrLEZc+nkyHnxfakoYT5liLEgHKeVMTJ2fNxUcR59rU5YQdFzWtl
         qpA8OW7kcqCmJcERIZLEzm/nZ9nHAZieAiNb7VXH4YwbTVe8/V3ZEy+toz+ujwBCRixL
         G9WFiuqT8BbZQyf2P3feCUxRxDqWgEFHS/K1Wx1h7+YxTupNSfVBtgS4LZ6JTBAkACJb
         5EB0SdgWdEsPbzIGGnv25vkARD5gOb1Tg2QJdVRIxIyS3F4MI0Zzlx1E/lfb2MFGbZXs
         0RfcQ0qqVDSRXLlTvmxj9/SkA9P0wTw+pWF5LwzAGxeZGam/QDyxPVG7CHXl+F7Uk2Qs
         UdAQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789989191; x=1790593991; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uq60GglzMN0RrAE6AWFMel/nRHuWNTjFO96jvYXE0j8=;
        b=fnANoFuvkGFXGj/L12y/H/hT3hBNXlma5d4y3lk5BmexUyQDFBug+pSQYun1Qp0KqV
         GxfERFD230Px5IB+x6IaZ9OU9y6jzYu9YD3c3NOYhug6ZKZXoQj7RKQLS4al6+VVgt8E
         PR0zbBKUy97dwxPzkPs4FftS+1Epaqb1DDANSXiakVE2/oBPA5v256W97OYAh7jD39qh
         CQdv/xctcQrSNZGXbeMaHpypVxuKUUj7IQCEDhl/pgJ/3oFMc4WBCAdo+6HjCHVy3nBU
         H4C1Gah+hdyUowl6tLO3n9S3PhhUtotoKZZmgUAxhIzvMRFxDGzzmyAoYCGSVD2JWkjG
         6y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789989191; x=1790593991;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Uq60GglzMN0RrAE6AWFMel/nRHuWNTjFO96jvYXE0j8=;
        b=Q3X2Wykdh2qGkq/EKEofJ/QSMi7QuEgZSyF1X4pFjAcm4uJZEE5/HH4b3rpW8IEH+/
         nEQI2bufBYYE8xcdow1xiDA+6+ws2szgixIt5fEM66FM2BrVkoZA/sLgjUxoMTD+Rxmr
         YLDawgWhXJXei2USdBCrCt1BAGhyJUZkFd2f1NQrxG59awE4yvtOzAoxH1h2auRMp/uF
         XCSkq37oqJGpHLzQqiV7j1PvNzOoogFnIarDGYgAbokjX0lzqP3grAjdWsOtRA/E+FHr
         cMBXSBYUAHLCxnQXKWl9tpIJKybXzFRIzaP5XU7C0r5rSPNpYOcgcNVhpbkHIjrJR/V+
         WUew==
X-Gm-Message-State: AFuF++m7wV+sdGV1OFvgERw8/E7tcs/myHepLHIvfmamWGGKt60/B9HP
	aWJLpnc3V7AzsuNt0xJxRV5VCAikkiOcGgEvfWYCsC7gVaC/ykNAek8wpUHuK+viMIECXpllCqm
	Q6IRGcEziC0l6yLVP+eop4qoPmskRdATh1AhD
X-Gm-Gg: AYBFou0QyBIYaSFzamEXLEJYmBHWZAckTvx2JhoIo+39Ld4y6OUoRfslNUypzOtufTm
	03p/o/2HMbpvGhgeEpE/xmZoL/rSaqj+DXumUFet7yBxkfwCMjAvKqnGNuj+SMe6AGV8WKWA6OP
	yVQWzo83CGbtMpulHpswzAmws+fSdB+MyfO6jFQl/Zav+T5O2BncymIQETLxNvBBLFeBSrsZI7D
	uppGeNIoCK5SQe8Azo4i+d88I1+hiP6nBnGRC4VbQqkg8feSAQm7vomTgtX0Y8LpaSoL3eO65Eb
	RkonUqSFT0pmSW/Ci0BhPtzOajqEPlLex7GY8XPZ/Xfk4yxUKIjhEh9GQIrVltUbJw==
X-Received: by 2002:a05:690e:d0c:b0:66f:c1bc:4056 with SMTP id
 956f58d0204a3-6717043655bmr4181886d50.30.1789989190808; Mon, 21 Sep 2026
 04:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260907111843.26746-1-frezidok1@gmail.com> <20260907111843.26746-2-frezidok1@gmail.com>
 <6307d52fb41715013cddf71e6493373f672f46e2.camel@pbarker.dev>
In-Reply-To: <6307d52fb41715013cddf71e6493373f672f46e2.camel@pbarker.dev>
From: Dmitry Sakhonchik <frezidok1@gmail.com>
Date: Mon, 21 Sep 2026 14:12:59 +0300
X-Gm-Features: AcwNN1WMQP70IawmykGknHyLAx1UsBy3rbavb1Rwj1QX6_jnEwWyNKW87ObYkqY
Message-ID: <CAP4GjN5Ti1jQT61PSg9oasO_c7pOwyL80Ek6KsQkZ6LTM=rndQ@mail.gmail.com>
Subject: Re: [pseudo] [PATCH v3 1/6] ports/linux/guts: Add open_tree wrapper
To: Paul Barker <paul@pbarker.dev>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000deb8e8065bfc55b3"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 11:13:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4922

--000000000000deb8e8065bfc55b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 21 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 12:2=
8, Paul Barker <paul@pbarker.dev>:

> On Mon, 2026-09-07 at 14:18 +0300, frezidok1@gmail.com wrote:
> > From: Dmitry Sakhonchik <frezidok1@gmail.com>
> >
> > [YOCTO #16379]
> >
> > OPEN_TREE_CLONE is not handled since it requires CAP_SYS_ADMIN and is
> outside the common pseudo use case.
>
> We should at least log an error if OPEN_TREE_CLONE is seen instead of
> silently ignoring it.
>
> >
> > Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
> > ---
> >  ports/linux/guts/open_tree.c | 46 ++++++++++++++++++++++++++++++++++++
> >  ports/linux/portdefs.h       |  9 +++++++
> >  ports/linux/wrapfuncs.in     |  1 +
> >  3 files changed, 56 insertions(+)
> >  create mode 100644 ports/linux/guts/open_tree.c
> >
> > diff --git a/ports/linux/guts/open_tree.c b/ports/linux/guts/open_tree.=
c
> > new file mode 100644
> > index 0000000..6c2aad9
> > --- /dev/null
> > +++ b/ports/linux/guts/open_tree.c
> > @@ -0,0 +1,46 @@
> > +/*
> > + * Copyright (c) 2026 Yocto Project
> > + * guts/COPYRIGHT for information.
> > + *
> > + * SPDX-License-Identifier: LGPL-2.1-only
> > + *
> > + * int open_tree(int dirfd, const char *path, unsigned int flags)
> > + *   int rc =3D -1;
> > + */
> > +
> > +     struct stat64 buf;
> > +     int save_errno;
> > +     char *pseudo_path;
> > +
> > +     if (real_open_tree) {
> > +             pseudo_debug(PDBGF_SYSCALL, "open_tree, calling
> open_tree.\n");
> > +             rc =3D real_open_tree(dirfd, path, flags);
> > +     } else {
> > +             pseudo_debug(PDBGF_SYSCALL, "open_tree, calling
> syscall.\n");
> > +             rc =3D real_syscall(SYS_open_tree, dirfd, path, flags);
> > +     }
>
> The commit message or a comment should briefly explain why we need to
> handle both ways of invoking the real open_tree syscall.
>
> > +
> > +     pseudo_path =3D pseudo_root_path(__func__, __LINE__, dirfd, path,=
 0);
>
> This should be after the (rc !=3D -1) conditional, as this call could
> clobber errno.
>
> If we use preserve_path=3D1, then the absolute path must go through
pseudo_root_path before the real open_tree call so that a possible chroot
is handled correctly.
So I think these two cases need to be somehow handled separately rather
than moving pseudo_root_path() entirely below the rc !=3D -1 check.
By the way, for some reason the openat2 wrapper is ok with the
pseudo_root_path outside of conditional.

> > +
> > +     if (rc !=3D -1) {
>
> Nitpick: To save indentation, we can check for (rc =3D=3D -1) and return =
early.
>
> > +             save_errno =3D errno;
> > +             int stat_rc;
> > +
> > +             stat_rc =3D real___fxstatat64(_STAT_VER, dirfd, pseudo_pa=
th,
> &buf, (flags & AT_SYMLINK_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
> > +
> > +             pseudo_debug(PDBGF_FILE, "open_tree(path %s), flags %o,
> stat rc %d, stat mode %o\n",
> > +                     pseudo_path, flags, stat_rc, buf.st_mode);
> > +
> > +             if (stat_rc !=3D -1) {
> > +                     pseudo_client_op(OP_OPEN, 0, rc, dirfd,
> pseudo_path, &buf);
> > +             } else {
> > +                     pseudo_debug(PDBGF_FILE, "open_tree(fd %d, path
> %d/%s, flags %d) succeeded, but stat failed (%s).\n",
> > +                             rc, dirfd, pseudo_path, flags,
> strerror(errno));
> > +                     pseudo_client_op(OP_OPEN, 0, rc, dirfd,
> pseudo_path, 0);
> > +             }
> > +             errno =3D save_errno;
> > +     }
> > +
> > +/*   return rc;
> > + * }
> > + */
> > diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
> > index 1f1a41a..565fed9 100644
> > --- a/ports/linux/portdefs.h
> > +++ b/ports/linux/portdefs.h
> > @@ -82,3 +82,12 @@ extern int unshare(int flags);
> >
> >  #define SYS_openat2 __NR_openat2
> >  #endif
> > +
> > +#ifndef SYS_open_tree
> > +
> > +#ifndef __NR_open_tree
> > +#define __NR_open_tree 428
> > +#endif
> > +
> > +#define SYS_open_tree __NR_open_tree
> > +#endif
> > diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
> > index 3cea20a..a51e9a0 100644
> > --- a/ports/linux/wrapfuncs.in
> > +++ b/ports/linux/wrapfuncs.in
> > @@ -10,6 +10,7 @@ int lchown(const char *path, uid_t owner, gid_t
> group); /* flags=3DAT_SYMLINK_NOFO
> >  int __fxstatat(int ver, int dirfd, const char *path, struct stat *buf,
> int flags);
> >  int openat(int dirfd, const char *path, int flags, ...{mode_t mode});
> /*
> flags=3D((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EX=
CL))),
> noignore_path=3D1 */
> >  int __openat_2(int dirfd, const char *path, int flags); /*
> flags=3D((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_EX=
CL))),
> noignore_path=3D1 */
> > +int open_tree(int dirfd, const char *path, unsigned int flags); /*
> noignore_path=3D1 */
>
> Does this need preserve_paths=3D1 (similar to openat2())?
>
> That would require us to account for a possible chroot in the
> open_tree() guts, but it would avoid us running pseudo_root_path() on an
> already canonicalized path which may introduce problems under a chroot.
>
> >  int mknod(const char *path, mode_t mode, dev_t dev); /*
> real_func=3Dpseudo_mknod */
> >  int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /*
> real_func=3Dpseudo_mknodat */
> >  int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev); /*
> flags=3DAT_SYMLINK_NOFOLLOW */
> >
>
> --
> Paul Barker
>
>

--000000000000deb8e8065bfc55b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 2=
1 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 12:28, Paul Barker =
&lt;<a href=3D"mailto:paul@pbarker.dev">paul@pbarker.dev</a>&gt;:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, 2026-09-07 at 14:=
18 +0300, <a href=3D"mailto:frezidok1@gmail.com" target=3D"_blank">frezidok=
1@gmail.com</a> wrote:<br>
&gt; From: Dmitry Sakhonchik &lt;<a href=3D"mailto:frezidok1@gmail.com" tar=
get=3D"_blank">frezidok1@gmail.com</a>&gt;<br>
&gt; <br>
&gt; [YOCTO #16379]<br>
&gt; <br>
&gt; OPEN_TREE_CLONE is not handled since it requires CAP_SYS_ADMIN and is =
outside the common pseudo use case.<br>
<br>
We should at least log an error if OPEN_TREE_CLONE is seen instead of<br>
silently ignoring it.<br>
<br>
&gt; <br>
&gt; Signed-off-by: Dmitry Sakhonchik &lt;<a href=3D"mailto:frezidok1@gmail=
.com" target=3D"_blank">frezidok1@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 ports/linux/guts/open_tree.c | 46 ++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 ports/linux/portdefs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 9 +++++=
++<br>
&gt;=C2=A0 ports/linux/<a href=3D"http://wrapfuncs.in" rel=3D"noreferrer" t=
arget=3D"_blank">wrapfuncs.in</a>=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 3 files changed, 56 insertions(+)<br>
&gt;=C2=A0 create mode 100644 ports/linux/guts/open_tree.c<br>
&gt; <br>
&gt; diff --git a/ports/linux/guts/open_tree.c b/ports/linux/guts/open_tree=
.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..6c2aad9<br>
&gt; --- /dev/null<br>
&gt; +++ b/ports/linux/guts/open_tree.c<br>
&gt; @@ -0,0 +1,46 @@<br>
&gt; +/*<br>
&gt; + * Copyright (c) 2026 Yocto Project<br>
&gt; + * guts/COPYRIGHT for information.<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: LGPL-2.1-only<br>
&gt; + *<br>
&gt; + * int open_tree(int dirfd, const char *path, unsigned int flags)<br>
&gt; + *=C2=A0 =C2=A0int rc =3D -1;<br>
&gt; + */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct stat64 buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int save_errno;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *pseudo_path;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (real_open_tree) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pseudo_debug(PDBGF_SY=
SCALL, &quot;open_tree, calling open_tree.\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D real_open_tree=
(dirfd, path, flags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pseudo_debug(PDBGF_SY=
SCALL, &quot;open_tree, calling syscall.\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D real_syscall(S=
YS_open_tree, dirfd, path, flags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
<br>
The commit message or a comment should briefly explain why we need to<br>
handle both ways of invoking the real open_tree syscall.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pseudo_path =3D pseudo_root_path(__func__, __LINE=
__, dirfd, path, 0);<br>
<br>
This should be after the (rc !=3D -1) conditional, as this call could<br>
clobber errno.<br>
<br></blockquote><div>If we use preserve_path=3D1, then the absolute path m=
ust go through pseudo_root_path before the real open_tree call so that a po=
ssible chroot is handled correctly.=C2=A0</div><div>So I think these two ca=
ses need to be somehow handled separately rather than moving pseudo_root_pa=
th() entirely below the rc !=3D -1 check.=C2=A0</div><div>By the way, for s=
ome reason the openat2 wrapper is ok with the pseudo_root_path outside of c=
onditional.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (rc !=3D -1) {<br>
<br>
Nitpick: To save indentation, we can check for (rc =3D=3D -1) and return ea=
rly.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0save_errno =3D errno;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int stat_rc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stat_rc =3D real___fx=
statat64(_STAT_VER, dirfd, pseudo_path, &amp;buf, (flags &amp; AT_SYMLINK_N=
OFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pseudo_debug(PDBGF_FI=
LE, &quot;open_tree(path %s), flags %o, stat rc %d, stat mode %o\n&quot;,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pseudo_path, flags, stat_rc, buf.st_mode);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (stat_rc !=3D -1) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pseudo_client_op(OP_OPEN, 0, rc, dirfd, pseudo_path, &amp;buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pseudo_debug(PDBGF_FILE, &quot;open_tree(fd %d, path %d/%s, flags %d=
) succeeded, but stat failed (%s).\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc, dirfd, pseudo_path, flags, strerror(=
errno));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pseudo_client_op(OP_OPEN, 0, rc, dirfd, pseudo_path, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D save_errno;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +/*=C2=A0 =C2=A0return rc;<br>
&gt; + * }<br>
&gt; + */<br>
&gt; diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h<br>
&gt; index 1f1a41a..565fed9 100644<br>
&gt; --- a/ports/linux/portdefs.h<br>
&gt; +++ b/ports/linux/portdefs.h<br>
&gt; @@ -82,3 +82,12 @@ extern int unshare(int flags);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define SYS_openat2 __NR_openat2<br>
&gt;=C2=A0 #endif<br>
&gt; +<br>
&gt; +#ifndef SYS_open_tree<br>
&gt; +<br>
&gt; +#ifndef __NR_open_tree<br>
&gt; +#define __NR_open_tree 428<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +#define SYS_open_tree __NR_open_tree<br>
&gt; +#endif<br>
&gt; diff --git a/ports/linux/<a href=3D"http://wrapfuncs.in" rel=3D"norefe=
rrer" target=3D"_blank">wrapfuncs.in</a> b/ports/linux/<a href=3D"http://wr=
apfuncs.in" rel=3D"noreferrer" target=3D"_blank">wrapfuncs.in</a><br>
&gt; index 3cea20a..a51e9a0 100644<br>
&gt; --- a/ports/linux/<a href=3D"http://wrapfuncs.in" rel=3D"noreferrer" t=
arget=3D"_blank">wrapfuncs.in</a><br>
&gt; +++ b/ports/linux/<a href=3D"http://wrapfuncs.in" rel=3D"noreferrer" t=
arget=3D"_blank">wrapfuncs.in</a><br>
&gt; @@ -10,6 +10,7 @@ int lchown(const char *path, uid_t owner, gid_t grou=
p); /* flags=3DAT_SYMLINK_NOFO<br>
&gt;=C2=A0 int __fxstatat(int ver, int dirfd, const char *path, struct stat=
 *buf, int flags);<br>
&gt;=C2=A0 int openat(int dirfd, const char *path, int flags, ...{mode_t mo=
de}); /* flags=3D((flags&amp;O_NOFOLLOW)||((flags&amp;(O_CREAT|O_EXCL))=3D=
=3D(O_CREAT|O_EXCL))), noignore_path=3D1 */<br>
&gt;=C2=A0 int __openat_2(int dirfd, const char *path, int flags); /* flags=
=3D((flags&amp;O_NOFOLLOW)||((flags&amp;(O_CREAT|O_EXCL))=3D=3D(O_CREAT|O_E=
XCL))), noignore_path=3D1 */<br>
&gt; +int open_tree(int dirfd, const char *path, unsigned int flags); /* no=
ignore_path=3D1 */<br>
<br>
Does this need preserve_paths=3D1 (similar to openat2())?<br>
<br>
That would require us to account for a possible chroot in the<br>
open_tree() guts, but it would avoid us running pseudo_root_path() on an<br=
>
already canonicalized path which may introduce problems under a chroot.<br>
<br>
&gt;=C2=A0 int mknod(const char *path, mode_t mode, dev_t dev); /* real_fun=
c=3Dpseudo_mknod */<br>
&gt;=C2=A0 int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev)=
; /* real_func=3Dpseudo_mknodat */<br>
&gt;=C2=A0 int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev)=
; /* flags=3DAT_SYMLINK_NOFOLLOW */<br>
&gt; <br>
<br>
-- <br>
Paul Barker<br>
<br>
</blockquote></div></div>

--000000000000deb8e8065bfc55b3--

