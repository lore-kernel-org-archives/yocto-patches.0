Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10156.1792585891610140030
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Oct 2026 05:31:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=D2N9H0DQ;
 spf=pass (domain: gmail.com, ip: 74.125.224.48, mailfrom: frezidok1@gmail.com)
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-676804a3a22so565014d50.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 05:31:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792585891; cv=none;
        d=google.com; s=arc-20260327;
        b=QIv8M3Dx/Sz7Ugie58pYS5s+ay8znjS50qfXZFuq2NQergRI/TuVg9xqxo0rOH+Rra
         VrBMsLMQ7yYhqR3Tfof8dCkvORvgEEq6aoqfaLU9JOr6Ltl+f1WKR5ov9Qz5ZAC4Fin1
         Ojxzfcq5bH66ufqoasa7PahVzXwlhPsrayp36AHvswsyVTNAemn6WzTq9qT5GJ7hgs51
         w0Yc1uiyMtqfBtD63aFC0Lm3VzfbAdssjq2TMxdqHY1PtZXmZQhfOYlGonQdkMv1kN2B
         biJ/RRpbaeofAiaCccKfKkU6bM7G8+MdRiSWhY/36VLdUgNIp7T4imenL2yJFKLYPhkZ
         wqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IuRjEqN3uegtxiNVq4oLlFWNYcEHbTrMgkH6ERcmkkk=;
        fh=DaNDCs4TzLtMbDpCrL3Gr/qVVSXRQuH2q3urfLYltwk=;
        b=j0QkbdW6oB707SKg3au/GjrD1uWXcrm858RTy1jI1Es+KmTMxdStLzpdVtJaMIPvqM
         PhM7V9nOvhHD/O5d29u2ayiqPWbGRTypDnpgs5Tez7aH9btL3BYXHSqw5K+SeaqSUQPM
         65KioZR4ujEW5mLYK+JQg2Y/AyD7wr0X+SpldeBHz3etsq2cfkvVLvl8MUo3U29sqbLX
         1ITf7PXbR/HLhPif7eS8hVaJM8r4pK2iS2QJdGApfEBlDQS9bT9A4GSdyH+jDrgbPNF2
         RswN8apmP9yfBbrFV5KZ4v1rFx/blssaDyTtg+U2fFE8FHl+ZmjnIz/xwUzLe3N9RWfv
         Q90w==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585891; x=1793190691; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IuRjEqN3uegtxiNVq4oLlFWNYcEHbTrMgkH6ERcmkkk=;
        b=D2N9H0DQ1rRiR9gWFWaLT+9ZI6xSPnIP8FjRfsRI/vsJZKtZJIc71unJA/4fouHZn9
         5XCw5C35MT4pGEm8qVpmvQvunHlCZfV7SAs4Iwu222j7XgX3mOQBCnRa0aURqKeCoh/d
         pZgLEZD86fBZlRrDJ60OMZbGjJKBkE5C6l19cLv/17wSaNZqYP3d9D9azK6OfRBW/rqn
         BpTucC+Ie+v/CNwOcEQnhNJdJ9FOvtN8rKCDdLuYuTfWarD+jU5FdwnzWh6DQNpVucmh
         hjAOYEVhNo8yUWVQvi7iK8ea9lverPWrRby61rKTKAzH5NFRspfPwTwZKwBISmJ7Upq9
         HPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585891; x=1793190691;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IuRjEqN3uegtxiNVq4oLlFWNYcEHbTrMgkH6ERcmkkk=;
        b=B5P7Ep9ciFl6QxGk2fhcREVYxR1HI75+mwWIM/8UrL/AQALLtsr98/vVuMstPfcbGe
         IAEHZha79WjqXAjN3s/q+jHv7DkPOP5xouiuIF4WiTkC50GqqjVwWhDiV/IArJRUVHOX
         m5t89jZa8m5y1UPhFnk2KZecVcWamYIb5a8jyjIZD3pJroTQPQC8DoKf31uklqVwE6Su
         EtlwM4D2qcASHvSOAPY28hnqIHP+BjBlK4oHrqbwUIgctj+KWlMSnDWt63rR+9GSR8Zx
         hc+V4T4BzbS+sgnfuBpvPVMqOCySsY8e00KIBb+0qr6DwfnHp85YOrM2HMpEwG/j+96y
         gv0w==
X-Gm-Message-State: AFq9FYLuvQISSqEl7Pguc4NDwjqGMRrHoB0Qmr5/Kb9NTgw0bE8pum+5
	4IC4OMU99/KYg6+iJIehjFQQYpyhr7GY9sGvjGhnoC7+Dne09YQSVobrXfV7WzjMrVHLeY6fd4R
	6WnyMFJVf9c0ApPE3gAkkppXyVoAfYDQ=
X-Gm-Gg: AYBFou3YrZr9G4snOckzMo6LBm+TnCPfmTODdlLwguHLseocCjUdCkHp39LSQpllldy
	GOU6D0YlsM7QGH7MQV6zvPVC2Xb4LqsnfQXxLpd6QoQIESWtMyDJxWgeM1DOtWHU4c2b3E12Gng
	0Mz82Lb0fYUojiZOV9yMbot/hlGY/SdVuJaqpfiHJa7uHvPAsVj9lxL9u9VXaNBjIDmgpjdv+aK
	uCRyvQoJwQ7fgsDNHpKfGmR79DzlOdZrS/RhuaP//CJzCuGdkY3HiWlA3+GxGVzN4lQo9H1RF8K
	O8Jh/i5LrR6RwS6LtwWrAXNNwv4ktEk0/ou0dz1Zs4iwp4dQgQfqz/Hll9Z6IgBBE1q+7giwnU+
	c4HemDgHHcVqkL2NZdcNjkVwSfIWU74KtoGTOhlewHbYPsjiInV0na4UnzLKdyhMl9KUOsRLP87
	s+7ddZTwp8m4M1yB15iyeT8U8mha7IN9p1NEo1
X-Received: by 2002:a05:690e:4183:b0:679:9551:d17e with SMTP id
 956f58d0204a3-67a0e58c0damr761341d50.81.1792585890483; Wed, 21 Oct 2026
 05:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261005081127.107126-1-frezidok1@gmail.com> <20261005081127.107126-2-frezidok1@gmail.com>
 <b791c7d9759e55e3c6b75c2c4270398cc9f4a1ba.camel@pbarker.dev>
In-Reply-To: <b791c7d9759e55e3c6b75c2c4270398cc9f4a1ba.camel@pbarker.dev>
From: Dmitry Sakhonchik <frezidok1@gmail.com>
Date: Wed, 21 Oct 2026 15:31:19 +0300
X-Gm-Features: AclHuK-ky2uObwBvrGyxszvZ9bvxy68HRprwsGKQDKBYEdbYqJYyyvfAltYTt8I
Message-ID: <CAP4GjN40kOstsigCWA5Xdt_-adM5jrzhu6SOR+V4s-TKySQv=g@mail.gmail.com>
Subject: Re: [pseudo] [PATCH v4 1/6] ports/linux/guts: Add open_tree wrapper
To: Paul Barker <paul@pbarker.dev>
Cc: yocto-patches@lists.yoctoproject.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="0000000000003b52b3065e58ed4f"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 12:31:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5126

--0000000000003b52b3065e58ed4f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.

Sure, I've sent the patch.

=D1=81=D1=80, 21 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 12:03, Pau=
l Barker <paul@pbarker.dev>:

> On Mon, 2026-10-05 at 11:11 +0300, frezidok1@gmail.com wrote:
> > From: Dmitry Sakhonchik <frezidok1@gmail.com>
> >
> > [YOCTO #16379]
> >
> > OPEN_TREE_CLONE is not handled since it requires CAP_SYS_ADMIN and is
> outside the common pseudo use case.
> >
> > Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
>
> Hi Dmitry,
>
> This patch has now merged to master but I've spotted a problem... Please
> could you send a follow-up patch to address this? A similar change is
> also needed in open_tree_attr().
>
> > ---
> >  ports/linux/guts/open_tree.c | 59 ++++++++++++++++++++++++++++++++++++
> >  ports/linux/portdefs.h       | 16 ++++++++++
> >  ports/linux/wrapfuncs.in     |  1 +
> >  3 files changed, 76 insertions(+)
> >  create mode 100644 ports/linux/guts/open_tree.c
> >
> > diff --git a/ports/linux/guts/open_tree.c b/ports/linux/guts/open_tree.=
c
> > new file mode 100644
> > index 0000000..ca299a1
> > --- /dev/null
> > +++ b/ports/linux/guts/open_tree.c
> > @@ -0,0 +1,59 @@
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
> > +     if (flags & OPEN_TREE_CLONE) {
> > +             pseudo_diag("ERROR: OPEN_TREE_CLONE is not supported\n");
> > +     }
> > +
> > +     if (path && path[0] =3D=3D '/') {
> > +             /* If the path is absolute, we should account for a
> potential chroot */
> > +             path =3D pseudo_path;
>
> pseudo_path is uninitialised here.
>
> I think we're missing the comment and call that's present in the
> openat2() wrapper:
>
>     /* This wrapper is not called with modified paths, therefore we have
> to handle this ourselves.
>        We can't use the standard mappings since the function needs
> relative paths to be preserved,
>        they can't be our usual absolute paths. An example difference:
>        openat2(AT_FDCWD, "/tmp/testdir/dir1/dir2/",
> {flags=3DO_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH|O_DIRECTORY,
> resolve=3DRESOLVE_BENEATH}, 24) =3D -1 EXDEV (Invalid cross-device link)
>        vs.
>        openat2(AT_FDCWD, "dir1/dir2/",
> {flags=3DO_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH|O_DIRECTORY,
> resolve=3DRESOLVE_BENEATH}, 24) =3D 4
>        FIXME - we don't handle chroot for relative paths
>     */
>     pseudo_path =3D pseudo_root_path(__func__, __LINE__, dirfd, path, 0);
>
> The openat2() examples there need replacing with open_tree() examples.
>
> > +     }
> > +
> > +     /*
> > +     * Older libc versions do not provide open_tree(), so call the
> syscall
> > +     * directly when the libc wrapper is not available.
> > +     */
> > +     if (real_open_tree) {
> > +             pseudo_debug(PDBGF_SYSCALL, "open_tree, calling
> open_tree.\n");
> > +             rc =3D real_open_tree(dirfd, path, flags);
> > +     } else {
> > +             pseudo_debug(PDBGF_SYSCALL, "open_tree, calling
> syscall.\n");
> > +             rc =3D real_syscall(SYS_open_tree, dirfd, path, flags);
> > +     }
> > +
> > +     if (rc !=3D -1) {
> > +             save_errno =3D errno;
> > +             int stat_rc;
> > +
> > +             pseudo_path =3D pseudo_root_path(__func__, __LINE__, dirf=
d,
> path, 0);
>
> This won't be needed here once pseudo_path is initialised at the top of
> the function.
>
> Best regards,
>
> --
> Paul Barker
>
>

--0000000000003b52b3065e58ed4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi.<div><br></div><div>Sure, I&#39;ve sent the patch.</div=
></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr=
" class=3D"gmail_attr">=D1=81=D1=80, 21 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=
=D0=B3. =D0=B2 12:03, Paul Barker &lt;<a href=3D"mailto:paul@pbarker.dev">p=
aul@pbarker.dev</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Mon, 2026-10-05 at 11:11 +0300, <a href=3D"mailto:frezidok1@g=
mail.com" target=3D"_blank">frezidok1@gmail.com</a> wrote:<br>
&gt; From: Dmitry Sakhonchik &lt;<a href=3D"mailto:frezidok1@gmail.com" tar=
get=3D"_blank">frezidok1@gmail.com</a>&gt;<br>
&gt; <br>
&gt; [YOCTO #16379]<br>
&gt; <br>
&gt; OPEN_TREE_CLONE is not handled since it requires CAP_SYS_ADMIN and is =
outside the common pseudo use case.<br>
&gt; <br>
&gt; Signed-off-by: Dmitry Sakhonchik &lt;<a href=3D"mailto:frezidok1@gmail=
.com" target=3D"_blank">frezidok1@gmail.com</a>&gt;<br>
<br>
Hi Dmitry,<br>
<br>
This patch has now merged to master but I&#39;ve spotted a problem... Pleas=
e<br>
could you send a follow-up patch to address this? A similar change is<br>
also needed in open_tree_attr().<br>
<br>
&gt; ---<br>
&gt;=C2=A0 ports/linux/guts/open_tree.c | 59 ++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 ports/linux/portdefs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 16 ++++++++++=
<br>
&gt;=C2=A0 ports/linux/<a href=3D"http://wrapfuncs.in" rel=3D"noreferrer" t=
arget=3D"_blank">wrapfuncs.in</a>=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 3 files changed, 76 insertions(+)<br>
&gt;=C2=A0 create mode 100644 ports/linux/guts/open_tree.c<br>
&gt; <br>
&gt; diff --git a/ports/linux/guts/open_tree.c b/ports/linux/guts/open_tree=
.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..ca299a1<br>
&gt; --- /dev/null<br>
&gt; +++ b/ports/linux/guts/open_tree.c<br>
&gt; @@ -0,0 +1,59 @@<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0if (flags &amp; OPEN_TREE_CLONE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pseudo_diag(&quot;ERR=
OR: OPEN_TREE_CLONE is not supported\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (path &amp;&amp; path[0] =3D=3D &#39;/&#39;) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If the path is abs=
olute, we should account for a potential chroot */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D pseudo_path;=
<br>
<br>
pseudo_path is uninitialised here.<br>
<br>
I think we&#39;re missing the comment and call that&#39;s present in the<br=
>
openat2() wrapper:<br>
<br>
=C2=A0 =C2=A0 /* This wrapper is not called with modified paths, therefore =
we have to handle this ourselves.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0We can&#39;t use the standard mappings since the=
 function needs relative paths to be preserved,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0they can&#39;t be our usual absolute paths. An e=
xample difference:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0openat2(AT_FDCWD, &quot;/tmp/testdir/dir1/dir2/&=
quot;, {flags=3DO_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH|O_DIRECTORY, resolve=
=3DRESOLVE_BENEATH}, 24) =3D -1 EXDEV (Invalid cross-device link)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0vs.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0openat2(AT_FDCWD, &quot;dir1/dir2/&quot;, {flags=
=3DO_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH|O_DIRECTORY, resolve=3DRESOLVE_BENE=
ATH}, 24) =3D 4<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0FIXME - we don&#39;t handle chroot for relative =
paths<br>
=C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 pseudo_path =3D pseudo_root_path(__func__, __LINE__, dirfd, p=
ath, 0);<br>
<br>
The openat2() examples there need replacing with open_tree() examples.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Older libc versions do not provide open_tree(),=
 so call the syscall<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* directly when the libc wrapper is not available=
.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
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
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (rc !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0save_errno =3D errno;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int stat_rc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pseudo_path =3D pseud=
o_root_path(__func__, __LINE__, dirfd, path, 0);<br>
<br>
This won&#39;t be needed here once pseudo_path is initialised at the top of=
<br>
the function.<br>
<br>
Best regards,<br>
<br>
-- <br>
Paul Barker<br>
<br>
</blockquote></div>

--0000000000003b52b3065e58ed4f--
