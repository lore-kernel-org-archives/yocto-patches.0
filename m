Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15F1C982DE
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 09:38:35 +0000 (UTC)
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45521.1789983509321881349
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Sep 2026 02:38:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=bD0dDONO;
 spf=pass (domain: gmail.com, ip: 74.125.224.141, mailfrom: frezidok1@gmail.com)
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso2422162d50.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 02:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789983508; cv=none;
        d=google.com; s=arc-20260327;
        b=YjY7lzfGY4ZzB4iRBWVSsE8AIL8H96AgtR/kBeVEUZ2UDMLG6+4qH4LsyQLoiUtsrt
         kX3KW3Zlew0eQSgZmfSbqcIIxvt1Ikzc1D0Fqk8AplEWLip+GjMNBEj9sYQc1EMjTio0
         sFfzYgF+v9gmS9mqyuOoZfFM+WRyLvaUg/otX8H263nGU3d0RyOZoa9cOlYh8ia6YGlz
         mS2H5I5buQCo+U07seWpYCMPAUYqdnt55mfXUpxycNwpHtmol1d4b261IqW9NQtwoDpr
         ljEly10bnEb7VlajJgTRsV+CpMV/l2fxjYjSzJYJIsgE5NA2CYKEGvxH8j26esvQ7r0o
         MgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YbFM0963wZETohEHEgOWpGkPzLAIW5KFU4mYx1sxEJc=;
        fh=y2+Uz1Oh655/noHVROAFANg0IkeeFgXaRD8dF7xjnCM=;
        b=c5tCTsuXmvAxJG/KQPFxeQRVzUdeCR67iAjZQABBMVeaX8uJFVSsFjarqMkW2fwGbe
         lPwzhFxhdjxx3hWUVCwX9aEQUtFkW4OEgzaKmg/XyJ5DoedoE9H8nZYf9p0wRq/RnWP6
         BTR0u1hxAXdRHULtJt7T76B5alKD3bBed0bYav6WsvQm7LyfU+Gmx3xHJ7vqwyJgNLYb
         3kCVRgItUQScxuTT1h17GfV4WwW0hhIxvKEc0Zg8RC7Dbf+x1VSqDOljzJzCUA9FQn1z
         G+jMBRwq674SDjISoa3yrU9Ge5ru8sNHXsTSXzgDPL/Uv/4Tf3wklyGBKHFsx6/R4Aa/
         QE+g==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789983508; x=1790588308; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YbFM0963wZETohEHEgOWpGkPzLAIW5KFU4mYx1sxEJc=;
        b=bD0dDONOPVkqePbTcoqysvQJF5K8KZ60iQjrSfpR8PDU+SsrKLrpD7d6PZ2NkqZ9GE
         qGEiE/ehDb3JFbMg0YYgsNhDw0I3R4kuob2kgnlCvN1qWmDXpHl1LeQ5+IERA2quB02y
         LwSumUrAO5uiZGtkBPuu9PhMBBFOdl0B27ygK71N5xg2a1zFlPJYpe69UjHdH0mirCgB
         CbdcZi/w3G+om30Jl4HsPgSPe3osQYmkh62ylxak9ujsOcezRM+dobuI1TirQIsVRDVv
         q1q7HHMjzDekDJspzLPUp9UWMrAWuUbSibL671EbGTTCW91Psq7sbQYBzNzFMWwD2qj8
         KnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983508; x=1790588308;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YbFM0963wZETohEHEgOWpGkPzLAIW5KFU4mYx1sxEJc=;
        b=PPLMcaARXklf4aTNetemGzzLlCwLW9vTPtW6zPq0wK8nJsp+xI8UGJqtveKnZ4x7ZB
         +RALHc8AUqD2gd4u+ZK6nn5cuMLBpf9f4lRInVn3l0mX+Yiv5h27rvDReYkUGMCr7z0a
         SGX4X3+WysU7DJh9sZR4+omReXC+QlPiS+xGkFuDzAaBRiDZPArWC+FKd3OBKgaATXdA
         klYq3H2BfKIM9yoyymK+b13ZiGBGBjVnRkxFYOqyNEszXK17EABiPGHjD+IxF8dbAlZC
         eT/gAO010anDgpwjS3yJVciAnfHobQTlybkI9rd3g+uzFeiOm5biuqTveeRkC7Wo4tF4
         CF/g==
X-Gm-Message-State: AFuF++nXgS625A2YA5bNk8FiukKD+voD/lfS/Odvws2kPCjMhftcvAsj
	JMnHoK2zc5ci2ug5M4Yhr/SvVH2i7wOv/NTNSNPXseWQgQz1e6uIRQDjJF/1hdadcgZS0RgtwiA
	htB1bjq94LFShDMtKhIrpVgMydmdijAY=
X-Gm-Gg: AYBFou13ytjUC3+9LzrLSmvhPFDYqr5UdvHea+Xvk6aKgNlbLm+2zLzYUjpDm5nksFz
	/sXQTWO4j6DUaot/kapsAfVoomqCRiSj6JURAeDIcHmBhCpucUoSmIDnjaDB41xWBVAIBaokyIf
	elx1F4dGBD++OK7VyZCOyWhpZBms981Evx9Xolk3fxbBogszip7t4v9nAB+ioZNFvKXqW3z1X+j
	Fcpd5HT9eJuq2hMVVLce952PQdK4c3iTIU6OFzELzKsXULH9ED89ghLgAEaKEY18iS3/fO+oaqG
	Zdh5D3d014yfzHR+cBSMYm+gmVbKxN/fJSfKmaMOms5Cinoy6WvUalU=
X-Received: by 2002:a05:690e:12cd:b0:671:3b1b:997d with SMTP id
 956f58d0204a3-6717fe14d33mr3709079d50.88.1789983508299; Mon, 21 Sep 2026
 02:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260907111843.26746-1-frezidok1@gmail.com> <20260907111843.26746-3-frezidok1@gmail.com>
 <5aaaf1ec9fe53be5da40a6501786ac03888f5d82.camel@pbarker.dev>
In-Reply-To: <5aaaf1ec9fe53be5da40a6501786ac03888f5d82.camel@pbarker.dev>
From: Dmitry Sakhonchik <frezidok1@gmail.com>
Date: Mon, 21 Sep 2026 12:38:16 +0300
X-Gm-Features: AcwNN1UY-JzqupRSGwhHa7yohGhwnqVS_G0fj8P1vCT7X4dIW9q6F7j2xeDXcZ8
Message-ID: <CAP4GjN74fVGqkBpW7h-HLz28+5=PajHz6nCCTiJYmXDF53=8pg@mail.gmail.com>
Subject: Re: [pseudo] [PATCH v3 2/6] test: Add open_tree test
To: Paul Barker <paul@pbarker.dev>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000002a812f065bfb03b9"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 09:38:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4921

--0000000000002a812f065bfb03b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 21 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 12:0=
9, Paul Barker <paul@pbarker.dev>:

> On Mon, 2026-09-07 at 14:18 +0300, frezidok1@gmail.com wrote:
> > From: Dmitry Sakhonchik <frezidok1@gmail.com>
> >
> > [YOCTO #16379]
> >
> > Covers basic open_tree wrapper functionality and the AT_EMPTY_PATH case=
.
> >
> > Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
> > ---
> >  test/test-open_tree.c  | 139 +++++++++++++++++++++++++++++++++++++++++
> >  test/test-open_tree.sh |   5 ++
> >  2 files changed, 144 insertions(+)
> >  create mode 100644 test/test-open_tree.c
> >  create mode 100755 test/test-open_tree.sh
> >
> > diff --git a/test/test-open_tree.c b/test/test-open_tree.c
> > new file mode 100644
> > index 0000000..0fc02f4
> > --- /dev/null
> > +++ b/test/test-open_tree.c
> > @@ -0,0 +1,139 @@
> > +#define _GNU_SOURCE
> > +
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <sys/stat.h>
> > +#include <sys/mount.h>
> > +
> > +#define TEST_DIR "test-open-tree-dir"
> > +#define TEST_FILE "test-open-tree-file"
> > +
> > +static int test_no_flags(void) {
> > +    int treefd =3D -1;
> > +    int fd =3D -1;
> > +    int rc =3D 1;
> > +
> > +    treefd =3D open_tree(AT_FDCWD, TEST_DIR, 0);
> > +    if (treefd =3D=3D -1) {
> > +        perror("open_tree");
> > +        goto out;
> > +    }
> > +
> > +    fd =3D openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666);
> > +    if (fd < 0) {
> > +        perror("openat");
> > +        goto out;
> > +    }
> > +
> > +    rc =3D 0;
> > +out:
> > +    if (treefd !=3D -1) {
> > +        close(treefd);
> > +    }
> > +    if (fd !=3D -1) {
> > +        close(fd);
> > +    }
> > +    return rc;
> > +}
> > +
> > +static int test_relative_dirfd(void) {
> > +    int basefd =3D -1;
> > +    int treefd =3D -1;
> > +    int fd =3D -1;
> > +    int rc =3D 1;
> > +
> > +    basefd =3D open(".", O_PATH | O_DIRECTORY);
> > +    if (basefd < 0) {
> > +        perror("open");
> > +        goto out;
> > +    }
> > +
> > +    treefd =3D open_tree(basefd, TEST_DIR, 0);
> > +    if (treefd < 0) {
> > +        perror("open_tree");
> > +        goto out;
> > +    }
> > +
> > +    fd =3D openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666);
> > +    if (fd < 0) {
> > +        perror("openat");
> > +        goto out;
> > +    }
> > +
> > +    rc =3D 0;
> > +out:
> > +    if (basefd !=3D -1) {
> > +        close(basefd);
> > +    }
> > +    if (treefd !=3D -1) {
> > +        close(treefd);
> > +    }
> > +    if (fd !=3D -1) {
> > +        close(fd);
> > +    }
> > +    return rc;
> > +}
> > +
> > +static int test_at_empty_path(void) {
> > +    int treefd =3D -1;
> > +    int dirfd =3D -1;
> > +    int fd =3D -1;
> > +    int rc =3D 1;
> > +
> > +    dirfd =3D open(TEST_DIR, O_PATH | O_DIRECTORY);
> > +    if (dirfd < 0) {
> > +        perror("open");
> > +        goto out;
> > +    }
> > +
> > +    treefd =3D open_tree(dirfd, "", AT_EMPTY_PATH);
> > +    if (treefd =3D=3D -1) {
> > +        perror("open_tree");
> > +        goto out;
> > +    }
> > +
> > +    fd =3D openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666);
> > +    if (fd < 0) {
> > +        perror("openat");
> > +        goto out;
> > +    }
> > +
> > +    rc =3D 0;
> > +out:
> > +    if (dirfd !=3D -1) {
> > +        close(dirfd);
> > +    }
> > +    if (treefd !=3D -1) {
> > +        close(treefd);
> > +    }
> > +    if (fd !=3D -1) {
> > +        close(fd);
> > +    }
> > +    return rc;
> > +}
> > +
> > +static void cleanup(void) {
> > +    if (unlink(TEST_DIR "/" TEST_FILE) =3D=3D -1 && errno !=3D ENOENT)=
 {
> > +        perror("unlink");
> > +    }
> > +    if (rmdir(TEST_DIR) =3D=3D -1 && errno !=3D ENOENT) {
> > +        perror("rmdir");
> > +    }
> > +}
> > +
> > +int main(void) {
> > +    cleanup();
> > +
> > +    if (mkdir(TEST_DIR, 0777) =3D=3D -1) {
> > +        perror("mkdir");
> > +        return 1;
> > +    }
> > +
> > +    int rc =3D test_no_flags() || test_at_empty_path() ||
> test_relative_dirfd();
>
> This will short-circuit on the first failing test. We should run all
> test cases and accumulate the pass/fail results.
>
> > +
> > +    cleanup();
>
> Do we need to run cleanup() between test cases? Or at least cleanup
> TEST_FILE between test cases?
>

I don't think so. In every test case we always open TEST_DIR with open_tree
and then openat(TEST_FILE) with O_CREAT.
So I think removing this file is not necessary.

>
> > +
> > +    return rc;
> > +}
> > diff --git a/test/test-open_tree.sh b/test/test-open_tree.sh
> > new file mode 100755
> > index 0000000..1654a0b
> > --- /dev/null
> > +++ b/test/test-open_tree.sh
> > @@ -0,0 +1,5 @@
> > +#!/bin/sh
> > +
> > +./test/test-open_tree
> > +
> > +PSEUDO_IGNORE_PATHS=3D/ ./test/test-open_tree
> > \ No newline at end of file
>
> This runs test-open_tree twice but the script exit code only depends on
> the second invocation. We should or these two results together.
>
> Nitpick: Missing newline at end of file.
>
> Best regards,
>
> --
> Paul Barker
>
>

--0000000000002a812f065bfb03b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 2=
1 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 12:09, Paul Barker =
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
&gt; Covers basic open_tree wrapper functionality and the AT_EMPTY_PATH cas=
e.<br>
&gt; <br>
&gt; Signed-off-by: Dmitry Sakhonchik &lt;<a href=3D"mailto:frezidok1@gmail=
.com" target=3D"_blank">frezidok1@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 test/test-open_tree.c=C2=A0 | 139 ++++++++++++++++++++++++++++++=
+++++++++++<br>
&gt;=C2=A0 test/test-open_tree.sh |=C2=A0 =C2=A05 ++<br>
&gt;=C2=A0 2 files changed, 144 insertions(+)<br>
&gt;=C2=A0 create mode 100644 test/test-open_tree.c<br>
&gt;=C2=A0 create mode 100755 test/test-open_tree.sh<br>
&gt; <br>
&gt; diff --git a/test/test-open_tree.c b/test/test-open_tree.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..0fc02f4<br>
&gt; --- /dev/null<br>
&gt; +++ b/test/test-open_tree.c<br>
&gt; @@ -0,0 +1,139 @@<br>
&gt; +#define _GNU_SOURCE<br>
&gt; +<br>
&gt; +#include &lt;errno.h&gt;<br>
&gt; +#include &lt;fcntl.h&gt;<br>
&gt; +#include &lt;stdio.h&gt;<br>
&gt; +#include &lt;unistd.h&gt;<br>
&gt; +#include &lt;sys/stat.h&gt;<br>
&gt; +#include &lt;sys/mount.h&gt;<br>
&gt; +<br>
&gt; +#define TEST_DIR &quot;test-open-tree-dir&quot;<br>
&gt; +#define TEST_FILE &quot;test-open-tree-file&quot;<br>
&gt; +<br>
&gt; +static int test_no_flags(void) {<br>
&gt; +=C2=A0 =C2=A0 int treefd =3D -1;<br>
&gt; +=C2=A0 =C2=A0 int fd =3D -1;<br>
&gt; +=C2=A0 =C2=A0 int rc =3D 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 treefd =3D open_tree(AT_FDCWD, TEST_DIR, 0);<br>
&gt; +=C2=A0 =C2=A0 if (treefd =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;open_tree&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 fd =3D openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666=
);<br>
&gt; +=C2=A0 =C2=A0 if (fd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;openat&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rc =3D 0;<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 if (treefd !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(treefd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (fd !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return rc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int test_relative_dirfd(void) {<br>
&gt; +=C2=A0 =C2=A0 int basefd =3D -1;<br>
&gt; +=C2=A0 =C2=A0 int treefd =3D -1;<br>
&gt; +=C2=A0 =C2=A0 int fd =3D -1;<br>
&gt; +=C2=A0 =C2=A0 int rc =3D 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 basefd =3D open(&quot;.&quot;, O_PATH | O_DIRECTORY);<b=
r>
&gt; +=C2=A0 =C2=A0 if (basefd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;open&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 treefd =3D open_tree(basefd, TEST_DIR, 0);<br>
&gt; +=C2=A0 =C2=A0 if (treefd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;open_tree&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 fd =3D openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666=
);<br>
&gt; +=C2=A0 =C2=A0 if (fd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;openat&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rc =3D 0;<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 if (basefd !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(basefd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (treefd !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(treefd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (fd !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return rc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int test_at_empty_path(void) {<br>
&gt; +=C2=A0 =C2=A0 int treefd =3D -1;<br>
&gt; +=C2=A0 =C2=A0 int dirfd =3D -1;<br>
&gt; +=C2=A0 =C2=A0 int fd =3D -1;<br>
&gt; +=C2=A0 =C2=A0 int rc =3D 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dirfd =3D open(TEST_DIR, O_PATH | O_DIRECTORY);<br>
&gt; +=C2=A0 =C2=A0 if (dirfd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;open&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 treefd =3D open_tree(dirfd, &quot;&quot;, AT_EMPTY_PATH=
);<br>
&gt; +=C2=A0 =C2=A0 if (treefd =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;open_tree&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 fd =3D openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666=
);<br>
&gt; +=C2=A0 =C2=A0 if (fd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;openat&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rc =3D 0;<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 if (dirfd !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(dirfd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (treefd !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(treefd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (fd !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return rc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void cleanup(void) {<br>
&gt; +=C2=A0 =C2=A0 if (unlink(TEST_DIR &quot;/&quot; TEST_FILE) =3D=3D -1 =
&amp;&amp; errno !=3D ENOENT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;unlink&quot;);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (rmdir(TEST_DIR) =3D=3D -1 &amp;&amp; errno !=3D ENO=
ENT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;rmdir&quot;);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +int main(void) {<br>
&gt; +=C2=A0 =C2=A0 cleanup();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (mkdir(TEST_DIR, 0777) =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;mkdir&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 int rc =3D test_no_flags() || test_at_empty_path() || t=
est_relative_dirfd();<br>
<br>
This will short-circuit on the first failing test. We should run all<br>
test cases and accumulate the pass/fail results.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cleanup();<br>
<br>
Do we need to run cleanup() between test cases? Or at least cleanup<br>
TEST_FILE between test cases?<br></blockquote><div><br></div><div>I don&#39=
;t think so. In every test case we always open TEST_DIR with open_tree and =
then openat(TEST_FILE) with O_CREAT.</div><div>So I think removing this fil=
e is not necessary.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return rc;<br>
&gt; +}<br>
&gt; diff --git a/test/test-open_tree.sh b/test/test-open_tree.sh<br>
&gt; new file mode 100755<br>
&gt; index 0000000..1654a0b<br>
&gt; --- /dev/null<br>
&gt; +++ b/test/test-open_tree.sh<br>
&gt; @@ -0,0 +1,5 @@<br>
&gt; +#!/bin/sh<br>
&gt; +<br>
&gt; +./test/test-open_tree<br>
&gt; +<br>
&gt; +PSEUDO_IGNORE_PATHS=3D/ ./test/test-open_tree<br>
&gt; \ No newline at end of file<br>
<br>
This runs test-open_tree twice but the script exit code only depends on<br>
the second invocation. We should or these two results together.<br>
<br>
Nitpick: Missing newline at end of file.<br>
<br>
Best regards,<br>
<br>
-- <br>
Paul Barker<br>
<br>
</blockquote></div></div>

--0000000000002a812f065bfb03b9--

