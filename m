Return-Path: <ghaderer@wyplay.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0C2C79F94
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 13:34:21 +0000 (UTC)
Subject: Re: [pseudo] [PATCH] unix: realpath fails if the resolved path doesn't exist.
To: yocto-patches@lists.yoctoproject.org
From: "Gauthier HADERER" <ghaderer@wyplay.com>
X-Originating-Location: FR (193.248.130.121)
X-Originating-Platform: Linux Chrome 142
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 05 Jan 2026 05:34:19 -0800
References: <20251219140600.212527-1-ghaderer@wyplay.com> <18d3c7cf-d644-42ac-a53c-3920014deb60@kernel.crashing.org>
In-Reply-To: <18d3c7cf-d644-42ac-a53c-3920014deb60@kernel.crashing.org>
Message-ID: <502343.1767620059571907902@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="V5wDZ90HNjlS8TLYrb6c"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Jan 2026 13:34:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2896

--V5wDZ90HNjlS8TLYrb6c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The `realpath()` libc function and the realpath command have a different be=
havior. The `realpath()` libc function will fail if the target file doesn't=
 exist.
By default, the realpath command will happily return a path if the final co=
mponent is missing. To get the same behavior as the libc function, you must=
 pass the --canonicalize-existing option. Or you can use this simple progra=
m.

>=20
> #include <limits.h>
> #include <stdlib.h>
> #include <stdio.h>
> int main(int argc, char **argv) {
> if (argc !=3D 2)
> return 2;
> char *rpath =3D realpath(argv[1], NULL);
> if (!rpath) {
> perror("realpath");
> return 1;
> }
> printf("%s\n", rpath);
> free(rpath);
> return 0;
> }
>

--V5wDZ90HNjlS8TLYrb6c
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>The `realpath()` libc function and the realpath command have a differe=
nt behavior. The `realpath()` libc function will fail if the target file do=
esn't exist.</div>
<div>By default, the realpath command will happily return a path if the fin=
al component is missing. To get the same behavior as the libc function, you=
 must pass the --canonicalize-existing option. Or you can use this simple p=
rogram.</div>
<div>&nbsp;</div>
<div>
<blockquote>
<div>#include &lt;limits.h&gt;<br />#include &lt;stdlib.h&gt;<br />#include=
 &lt;stdio.h&gt;</div>
<div>int main(int argc, char **argv) {<br />&nbsp; &nbsp; if (argc !=3D 2)<=
br />&nbsp; &nbsp; &nbsp; &nbsp; return 2;</div>
<div>&nbsp; &nbsp; char *rpath =3D realpath(argv[1], NULL);<br />&nbsp; &nb=
sp; if (!rpath) {<br />&nbsp; &nbsp; &nbsp; &nbsp; perror("realpath");<br /=
>&nbsp; &nbsp; &nbsp; &nbsp; return 1;<br />&nbsp; &nbsp; }</div>
<div>&nbsp; &nbsp; printf("%s\n", rpath);<br />&nbsp; &nbsp; free(rpath);</=
div>
<div>&nbsp; &nbsp; return 0;<br />}</div>
</blockquote>
</div>

--V5wDZ90HNjlS8TLYrb6c--

