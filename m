Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41715.1793190633373298888
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 05:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=qLB6Bk9q;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be53e5fce1so915033e87.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 05:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793190631; cv=none;
        d=google.com; s=arc-20260327;
        b=AGLD2sxN2MNCAMVi+nsLNnpqHoV1H3wvJaifVhxFZ1hx63j29M58I8muujlPGoFwOb
         1YRpNreMKygna3FQgAKMZkkFQASFvw3zBblhU8dHuCTE98HAbaiuOkwNGzyZA+eIoCAT
         3pQ2UBDaF3rSr3x9shSsa3OL/UrvBSoEemORg/iBfrURyL7pMw6njDBnJBpydFsPuhwn
         sWzoQAgp4nkK7dLG02OzN0vRKoumuHTcW6aZi4O2KbSrUIsV1pi0fZ+2KY9UZOO9EAyR
         ZZlalEBOGodGq57U7LrUathqEPfI5JguQ+ulCS03/MfolNx/Je4ZUtEdcdj/NNk9JNYp
         qWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=73U1cbk2qTnFeLsfXoNEyJSKbLgDY/2BR1I4qqw6I1k=;
        fh=0HgYofvBva/OKn6htc0542tL6rpfXHq6s4RiKCPFBFg=;
        b=kRfUZmH9icjm8D6rUvLT+nghP1Nib8bpYZ1Upv4LZqm+YtmMASc4llUa+6qnJWamTr
         c1UOZkeRFYt8fJ8xadGOzmCyVGkwhsQhkR2WwULlgGhsX0DH3IX1sm+W5wyrJVYc+ISl
         fMz6Bt2A4N/gWEaClMrVmZia54IYs3+9CU51aK09te6dvEEokWNN8s/lmbqj2TTq9JOT
         W+zjW+WgMgDperfV30J1CxsxaFOWKkezHaz0rfNmULwlYVHUnBGkIw6RXkyfztqPaeUZ
         BHvx2Ewn1DGTW8SMMUGnqJKxDfP8fpzTdqQ/2Vi3ceikJMfCYmtVD+j6idlidgpbAEKe
         vBtA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793190631; x=1793795431; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=73U1cbk2qTnFeLsfXoNEyJSKbLgDY/2BR1I4qqw6I1k=;
        b=qLB6Bk9qrpLdtAMr6n04IpIqqHxGL+Q6ObwABv6umNPq2BRwGfPK2dowYqoOQq+7J5
         cvDsM5lgxJp/i3Vn8AAIRQTYPF7LEvKL5riMGud2cDO7QWvdRPmuxNsBK0DQ7gA7nWqm
         IgZREtwWb86h9b9X1W/eNXEjAgBzPNKaC9hRthOAmuEBqflnTGny1Z2ljW1ByMqq7UmX
         XT61YcBNCtjOhXPCeS2UNkt3tjHaOZfKN0WdaX+oMQv+2oyvLGXybdkODIuf6pHOB334
         Aq/g8if5x3krJ25LghYsXrNXWcoe1M9DKwEILv0IZzW5RjywwWD8j9xWHVgNFYqx5Ld6
         6waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793190631; x=1793795431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=73U1cbk2qTnFeLsfXoNEyJSKbLgDY/2BR1I4qqw6I1k=;
        b=IBScAPJTqpX9Wcy4HDXEFoZ8nwW3d+HvrX1wGgU1jr62dWLjbR28EV2ltcYw7Ucpqq
         irkeULWspFtYyAS/r6hCqoNQfS2EOkjZJQZx6hTR36bgE1IEYAvfL2ZfZKnaD0NEk/0/
         SisuwXXY7IzTbB6bag65TUE4/qbzg+RlPN5gwjAOZc5esM5I0x/QO2bGtWKUPe35nrVZ
         ZAWZLuKsGguH7GNOrjAd6gZkSoxC0GKTqWtmB30Q1eLh6A8hymRWYmobv1CxmquFWXQw
         aygGFJv5VpMCr5WGNkl8Rvfsxz+H9lEwVu7Xuner7lGmQYUQLD/ef0gpPVWZQAeTlEeJ
         kLvQ==
X-Gm-Message-State: AFq9FYIkuI6FY/5smvKFQmF1qpB8AGCQa9AXQbgW+BssRcKeKnwjzDVv
	uRehJtR9MQ/ZAJgh7Gw6I8UtEZJo7yycW65a4433JQsdBEFVBjtz69qJ0fm9KtyLTlYllwnOm6z
	7abUd9tr5tZQ3w1rmPakQTRdiYXvRQdPyqzwW3YQ=
X-Gm-Gg: AYBFou2uqKYf5dkp2V0Q6BI0RAAanIDPXfKMj/LjWYZK2ZYOs9y114RPi/DfG5KE3Ox
	/FPtarZIpye8BTimyPHksz5akp5PMloeC5jodMdEI/P+pAsh0Uw9Ju5a3nLvvTmDQRH3GoRvLio
	DqZyU4ff9t6Dt4FzXCPuMKN3x1MP9LIjAt+H4d8nR++Gp6zzmpljNi9WE5QVXU+bQ4wPVsO9Tpk
	JUDjb5XCYMboBjVsn1IjID6X4AuW+eoaKyGzxCpUgtW+DGxyA3FU/a/fPiU6++L/AdEncxsi9B0
	K4eXzgfZHh/WkIefRuaxGoQYSzOFScXmHWvEpQNtTXv7stSbOsE10JwiSDsTBn1ZYW32I0ameCy
	JTL55Fmmih2oNo8j4T3XyysiP68gOQVzl3SRJiKfyrTXnw98iQvaDVuvXrKW2vOOg30t5zFAsbG
	5n9hZkDrb8D9qFEWCy+Q==
X-Received: by 2002:a05:6512:33d4:b0:5b8:e99c:cfa1 with SMTP id
 2adb3069b0e04-5bfcad8803bmr1057418e87.31.1793190630934; Wed, 28 Oct 2026
 05:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261028122004.93109-1-ddrake@baylibre.com>
In-Reply-To: <20261028122004.93109-1-ddrake@baylibre.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 28 Oct 2026 13:30:16 +0100
X-Gm-Features: AclHuK8SAnZOQi_xEogdrMfNoZb733ZkQS0KXOzbX2e60ovqe5lhD0pO2sWeNQE
Message-ID: <CA+chaQdeSpjs819yNAQyvBAeRgeZf-VR1VtGTzk6oa7bvjdxRw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][PATCH] tensorflow.inc: fix
 fetch of LLVM for XLA
To: yocto-patches@lists.yoctoproject.org
Cc: Hongxu Jia <jiahongxujia@163.com>, Hongxu Jia <hongxujia83@gmail.com>, 
	Daniel Drake <ddrake@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 12:30:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5171

I've the same locally (and I didn't send it, just because jenkins
servers never triggered it, so I was wondering if it's something
specific to my local builds).

Acked-by: Martin Jansa <martin.jansa@gmail.com>

On Wed, Oct 28, 2026 at 1:20=E2=80=AFPM Daniel Drake via
lists.yoctoproject.org <ddrake=3Dbaylibre.com@lists.yoctoproject.org>
wrote:
>
> Building tensorflow-lite fails in do_compile when Bazel fetches llvm-raw:
>
>   WARNING: Download from https://storage.googleapis.com/mirror.tensorflow=
.org/github.com/llvm/llvm-project/archive/909041e4802c4b9a2223ca04099f35bf1=
dbbd460.tar.gz
>   failed: class java.io.FileNotFoundException GET returned 404 Not Found
>   ...
>   Error in download_and_extract: java.io.IOException: Error downloading [=
...]:
>   Checksum was 00b1077e029fa57e6f2d9ac24936a49acf23ebc051b04f487131116258=
be6248
>   but wanted 3f986184ee126677dbd77edb16d6b82c057ec869fefd7a9871979941e52e=
837a
>
> The archive pinned by XLA is not on mirror.tensorflow.org, and the archiv=
e
> GitHub now generates for the same LLVM commit has a different checksum, s=
o
> the pin can no longer be satisfied from either URL.
>
> Pin the checksum of the archive GitHub currently serves. Future upstream
> releases will point to a newer LLVM commit.
>
> Signed-off-by: Daniel Drake <ddrake@baylibre.com>
> ---
>  ...01-xla-update-sha256-of-LLVM-archive.patch | 28 +++++++++++++++++++
>  recipes-framework/tensorflow/tensorflow.inc   |  1 +
>  2 files changed, 29 insertions(+)
>  create mode 100644 recipes-framework/tensorflow/files/0001-xla-update-sh=
a256-of-LLVM-archive.patch
>
> diff --git a/recipes-framework/tensorflow/files/0001-xla-update-sha256-of=
-LLVM-archive.patch b/recipes-framework/tensorflow/files/0001-xla-update-sh=
a256-of-LLVM-archive.patch
> new file mode 100644
> index 0000000..3a6cc72
> --- /dev/null
> +++ b/recipes-framework/tensorflow/files/0001-xla-update-sha256-of-LLVM-a=
rchive.patch
> @@ -0,0 +1,28 @@
> +From: Daniel Drake <ddrake@baylibre.com>
> +Subject: [PATCH] xla: update sha256 of LLVM archive
> +
> +Bazel can no longer fetch llvm-raw. The mirror.tensorflow.org copy of th=
e
> +archive returns 404, and the archive GitHub now generates for the same L=
LVM
> +commit has a different checksum than the one pinned here.
> +
> +Pin the checksum of the archive GitHub currently serves. The LLVM commit=
 is
> +unchanged.
> +
> +Upstream-Status: Inappropriate [workaround for a regenerated GitHub arch=
ive; upstream master pins a newer LLVM commit]
> +Signed-off-by: Daniel Drake <ddrake@baylibre.com>
> +---
> + third_party/xla/third_party/llvm/workspace.bzl | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/third_party/xla/third_party/llvm/workspace.bzl b/third_part=
y/xla/third_party/llvm/workspace.bzl
> +--- a/third_party/xla/third_party/llvm/workspace.bzl
> ++++ b/third_party/xla/third_party/llvm/workspace.bzl
> +@@ -5,7 +5,7 @@
> + def repo(name):
> +     """Imports LLVM."""
> +     LLVM_COMMIT =3D "909041e4802c4b9a2223ca04099f35bf1dbbd460"
> +-    LLVM_SHA256 =3D "3f986184ee126677dbd77edb16d6b82c057ec869fefd7a9871=
979941e52e837a"
> ++    LLVM_SHA256 =3D "00b1077e029fa57e6f2d9ac24936a49acf23ebc051b04f4871=
31116258be6248"
> +
> +     tf_http_archive(
> +         name =3D name,
> diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-framew=
ork/tensorflow/tensorflow.inc
> index e337519..69bfefc 100644
> --- a/recipes-framework/tensorflow/tensorflow.inc
> +++ b/recipes-framework/tensorflow/tensorflow.inc
> @@ -27,6 +27,7 @@ SRC_URI =3D "git://github.com/tensorflow/tensorflow.git=
;branch=3Dr2.21;protocol=3Dhttp
>      file://0001-set-x83_64-to-arch-of-whl.patch \
>      file://0001-fix-compile-failed-with-clang-21.patch \
>      file://0001-fix-clang-22.patch \
> +    file://0001-xla-update-sha256-of-LLVM-archive.patch \
>  "
>
>  DEPENDS +=3D " \
> --
> 2.56.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5170): https://lists.yoctoproject.org/g/yocto-patches=
/message/5170
> Mute This Topic: https://lists.yoctoproject.org/mt/121975268/3617156
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338883=
6/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
