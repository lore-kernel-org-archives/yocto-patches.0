Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C78EC53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 10:15:47 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8242.1785233745606839067
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Jul 2026 03:15:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=X4rKd0Lf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493f6de72faso6048345e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 03:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785233744; x=1785838544; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+BKEJ7peUsR4t+4MgS2wT14MD4u7QaIc4S5dE1CL2XE=;
        b=X4rKd0LfO00coOPWTxgstnHcKXj1bs7h2izszeEaUkoZFyjvixhMmrJStRc9LCVT/n
         v/2ziA27SKZ02K+o96to9OWT1cmlH0kP8l3ktUTUGyS34TCeHNZdNHs5KQ9w0UahPfCL
         m+sxch7zFeYDgTmVztxOkGbhN6Z4/K+mEGmYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785233744; x=1785838544;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+BKEJ7peUsR4t+4MgS2wT14MD4u7QaIc4S5dE1CL2XE=;
        b=ZvYhfklGw/P6drmEpKunjwjTLmWVFvu49MsxVtGSuTrsKW61ivBkfDUCXRespfWQ55
         WgNSCyzy5YWb6nM15WiUqEj9vnOMYYjo3K2SH9iDsotKShWzjeLXJS7kQLVH6uGwaeJt
         z5QahPUH9waP5HV2vKQ8dEA9mUJ9sTNT8HYWwmXK7Zl/z/u/dm3evY9rz2pT9DOW0dVm
         ybXJ989DfhnAjnMOtLCCgYSALBTrQ4SYN+xck9pUZNSSOc1J+rqVmiIWXXqDpA3D6GLQ
         RaVivq6bKWCx0KgHfFuLFL3MwQFh3YYwhUHWm45yVUpVg0G4AFsBuQ3/DAO73iMCZVCi
         TQjQ==
X-Gm-Message-State: AOJu0YyhK4Fjf4ISrpt0jjxHRAdmLLeVFbCeEj1tOGCbQY11AsnSSr3p
	LataFl+qEP2xuAcfu10aj1OunornINHm1QJKg78TcsMNM8tTk8+6wV7OAWm66hwip7QrAKLZ+rE
	eGq1TSNg=
X-Gm-Gg: AR+sD12urf+qer3MLeDpXJ6LSBOYraA7tc0+nMnaUzHLYE3AbjW0EoFYT3e5UyiE7Z1
	SysFUNVSQPAINQLmtEbGvFlDWbIYC/EUUsEv7fasv3UvQqLemeP7priBdhXMk6VN7HQ5vwGhU+h
	RGt1uNjP+/AXywSCgNksFPpfI01ObYgNYxZ+WFR+LvwMrtmZQ6shmNCizv7dlDE/BRH7eDMZdMy
	nxdwyS7/w96h/mePywG2E5y9SVCJe8XfDwDuTWsmd/C5b3AyCOVc+nKmXGpBpiSfzedhXOfdBkz
	uIIbMP4C0qV4AFgDCWx2Wdzwf/xlXc21dyQPx64oImiGz1zx5mmKFSRTgtTsBUbKPv2+B/8yndN
	usG+Ga4HWpu+YGGtYTkh7UBr9kqM7N2ON8amYTHGkXe49AMVpIJxD1PIJxVFZHfVPzeV1CD3ePq
	RD6YsG31WyKh7sqIu1t5hMzTxGlsAaFqMRFvlQNmiOOk+vxjHoElBFYrDJK0deTPCF
X-Received: by 2002:a05:600c:1f95:b0:495:4f84:7280 with SMTP id 5b1f17b1804b1-496c641fe08mr17116085e9.4.1785233743562;
        Tue, 28 Jul 2026 03:15:43 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:901:c1b8:a3bd:87c1? ([2001:8b0:aba:5f3c:901:c1b8:a3bd:87c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44b84edsm105454405e9.5.2026.07.28.03.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 03:15:42 -0700 (PDT)
Message-ID: <75f931b54054383a3de7f871ecaa10928c36a5b9.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH v2 1/2] ports/linux/guts:
 Implement close_range() instead of returning ENOSYS
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, Babanpreet Singh
	 <bbnpreetsingh@gmail.com>
Cc: Paul Barker <paul@pbarker.dev>, Mark Hatle <mark.hatle@amd.com>, Randy
 MacLeod <randy.macleod@windriver.com>, Vincent Haupert
 <mail@vincent-haupert.de>
Date: Tue, 28 Jul 2026 11:15:41 +0100
In-Reply-To: <18C669BEC7E582E7.1643407@lists.yoctoproject.org>
References: <20260715054142.7-1-bbnpreetsingh@gmail.com>
		 <20260716055633.7-1-bbnpreetsingh@gmail.com>
		 <20260716055633.7-2-bbnpreetsingh@gmail.com>
	 <18C669BEC7E582E7.1643407@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 10:15:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4557

On Tue, 2026-07-28 at 10:22 +0100, Richard Purdie via lists.yoctoproject.or=
g wrote:
> On Thu, 2026-07-16 at 05:56 +0000, Babanpreet Singh wrote:
> > The close_range() wrapper added in 35433e6 ("ports/linux/guts: Add
> > close_range wrapper for glibc 2.34") returns ENOSYS on the assumption
> > that callers handle that. systemd v260 no longer does: it removed its
> > /proc/self/fd fallback and treats a close_range() failure as fatal, so
> > every fork+exec under pseudo aborts:
> >=20
> > =C2=A0=C2=A0=C2=A0 Failed to close all file descriptors: Function not i=
mplemented
> > =C2=A0=C2=A0=C2=A0 '(mkfs)' failed with exit status 1.
> >=20
> > A client side op closes the low descriptors one at a time, skipping the
> > ones pseudo needs for itself, and returns the first fd above pseudo's
> > own so the caller can pass the rest of the range to the kernel directly=
.
> >=20
> > CLOSE_RANGE_UNSHARE is handled by calling unshare(CLONE_FILES) before
> > closing anything, so the closes only affect the caller and not other
> > processes sharing the descriptor table. Unknown flags and an inverted
> > range are rejected with EINVAL before anything is closed.
> >=20
> > A range starting entirely above INT_MAX cannot contain any of pseudo's
> > fds and is also passed straight through.
> >=20
> > [YOCTO #16339]
> >=20
> > AI-Generated: Uses Claude (claude-opus-4-8)
> > Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
> > ---
> > =C2=A0enums/op.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0ports/linux/guts/close_range.c | 54 ++++++++++++++++++++++++++---=
-
> > =C2=A0ports/linux/portdefs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 16 +++++++++
> > =C2=A0pseudo_client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 60 +++++++++++++++++++++++++++=
+++++++
> > =C2=A04 files changed, 124 insertions(+), 7 deletions(-)
>=20
> Unfortunately there is something wrong in this patch. I added this
> series and your other series fixing the closed fds and with this patch
> present, we see failures:
>=20
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/50/builds/4259
>=20
> i.e. linux-libc-headers do_install fails, which is one of the first
> pieces of the OE build to use pseudo. This should be reproducible in a
> OE build with "bitbake linux-libc-headers -c install", with a patch
> like the one below applied to update pseudo.
>=20
> As soon as I revert this patch, the builds work ok. I also tested with
> the second series applied without this patch (patches tweaked to apply)
> and that also seems to build ok, so it would appear to be something in
> this change.
>=20
> I've not dug into it in detail yet but I wanted to share the issue now
> I've isolated it.

I had a look at the code and had a theory about the type conversions on
maxfd being an issue. This patch appears to help:

diff --git a/ports/linux/guts/close_range.c b/ports/linux/guts/close_range.=
c
index c615148..784d066 100644
--- a/ports/linux/guts/close_range.c
+++ b/ports/linux/guts/close_range.c
@@ -7,6 +7,7 @@
  *      int rc =3D -1;
  */
        pseudo_msg_t *msg;
+       int maxintfd;
=20
        /* The kernel rejects both of these outright and closes nothing whe=
n
         * it does, so validate before touching anything.
@@ -43,17 +44,21 @@
         */
        if (lowfd > INT_MAX)
                return real_close_range(lowfd, maxfd, flags);
+       if (maxfd > INT_MAX)
+               maxintfd =3D INT_MAX;
+       else
+               maxintfd =3D (int) maxfd;=20
=20
        /* Same shape as closefrom(): the client op closes the descriptors =
its
         * own are mixed in with by hand, stepping around the ones pseudo n=
eeds
         * to keep, and hands back the first fd the kernel can safely be tu=
rned
         * loose on.
         */
-       //msg =3D pseudo_client_op(OP_CLOSE_RANGE, 0, lowfd, -1, 0, 0, maxf=
d);
-       //if (maxfd >=3D (unsigned int) msg->fd)
-       //      rc =3D real_close_range(msg->fd, maxfd, flags);
-       //else
-       //      rc =3D 0;
+       msg =3D pseudo_client_op(OP_CLOSE_RANGE, 0, lowfd, -1, 0, 0, maxint=
fd);
+       if (maxfd >=3D (unsigned int) msg->fd)
+               rc =3D real_close_range(msg->fd, maxfd, flags);
+       else
+               rc =3D 0;
        errno =3D ENOSYS;
        rc =3D -1;
=20
diff --git a/pseudo_client.c b/pseudo_client.c
index 98112bc..e846dc9 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -1653,7 +1653,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, =
int dirfd, const char *path
        static size_t alloced_len =3D 0;
        int strip_slash;
        int startfd, i;
-       unsigned int close_range_maxfd =3D 0;
+       int close_range_maxfd =3D 0;
=20
 #ifdef PSEUDO_PROFILING
        struct timeval tv1_op, tv2_op;
@@ -1777,7 +1777,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, =
int dirfd, const char *path
        if (op =3D=3D OP_CLOSE_RANGE) {
                va_list ap;
                va_start(ap, buf);
-               close_range_maxfd =3D va_arg(ap, unsigned int);
+               close_range_maxfd =3D va_arg(ap, int);
                va_end(ap);
        }
=20
@@ -2017,7 +2017,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, =
int dirfd, const char *path
                /* the fds below startfd are the ones our own are mixed in
                 * with, so close those by hand and skip the ones we need
                 */
-               for (i =3D fd; i < startfd && (unsigned int) i <=3D close_r=
ange_maxfd; ++i) {
+               for (i =3D fd; i < startfd && i <=3D close_range_maxfd; ++i=
) {
                        if (i =3D=3D pseudo_util_debug_fd || i =3D=3D pseud=
o_util_evlog_fd ||
                                        i =3D=3D pseudo_prefix_dir_fd || i =
=3D=3D pseudo_localstate_dir_fd ||
                                        i =3D=3D pseudo_pwd_fd || i =3D=3D =
pseudo_pwd_lck_fd ||
@@ -2026,7 +2026,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, =
int dirfd, const char *path
                        pseudo_client_close(i);
                        close(i);
                }
-               if (close_range_maxfd >=3D (unsigned int) startfd)
+               if (close_range_maxfd >=3D startfd)
                        pseudo_client_close_range(startfd, close_range_maxf=
d);
                /* tell the caller to start at startfd instead of fd */
                result =3D &msg;

which is I suspect because there is code doing:

close_range(3, ~0U, xxx);

Whether we should just force maxfd to INT_MAX always, I'm not sure. I
don't think the high fds are usable.

Cheers,

Richard

