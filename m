Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3877C02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 07:25:37 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web11.16096.1739517936468450676
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Feb 2025 23:25:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DmFbSRbw;
 spf=pass (domain: gmail.com, ip: 209.85.208.178, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3091fecb637so2522371fa.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Feb 2025 23:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739517934; x=1740122734; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UY8HgKpZyPxnu80oDcM9IByQVE1USlQIllpjivQbrZ4=;
        b=DmFbSRbw5Ru+y1fUpZVN6tK9ayaWcyb1UF8WbKrV7763ENk4zfEKGQ+cbxmLkFgBHA
         3pPfxUYXAmYum9r+5cMO8t4cNlzYw3SgKVioEHUjObbh9rhAGVt2LN4w897mfKgQ18kk
         ROp3hVcPqmhlz6JZijmUcj87mvEtN0wK2hmQOxlyxBv+ICwQ4JipThHNvZ5mpkio60kA
         Muc9iCdpH0jZlk6bWTwDkY7hMUtKanf6xaC0IfITTt8BwyMXfZ1adD+K7UtHTM3SGoKs
         alY1w7lluCs1w6hI46SnZ5QZxmO9udwVrSFvLthZfG/p4Jn4Tf1uphxaArJUAbTkJHzo
         xFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739517934; x=1740122734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UY8HgKpZyPxnu80oDcM9IByQVE1USlQIllpjivQbrZ4=;
        b=ZTYAt+N9pFnHs/sUpjeZikGQHEpFYLCFullLSSBjeEvzvPwhUTQO5uSxLpESlJqqff
         lOnGksPOAGv2Ew8b2OiTuWXN6u6sKmbp4gF+ygELfqYsnzLycVvIXMkO8pg/w1a66RkN
         Xjr+juuseEDWy/YG6VnD7gLxc6Kw7V5AF0GzO4P4SQAMzuWvB2+caIMWH2KwV30Aa/Jq
         vfdQFcTOWfF0RhNRw4EFCrjYSYIF9nufiMU6J/cSyaSImpH20+fpwgixZhYLKpfKYf1R
         ZN2sAr52fE/qQRavE7JoY2Hmbfd8QQRiJTRnKDyO2i56axxzDvAYEuW9Kgx/XNzTSiJP
         hT3g==
X-Gm-Message-State: AOJu0Yy7XfKJGMOq9/KZTHoPcqIBLWvcryNiE5Ud0ETVZCEXNQAQUBvb
	GU/BviCcs0LwFiN36+efFR1e2FigHMzcO+GZfJUbBXHl7O5w0g3MKz59rPz19XqalE8fg325Xlc
	jgZcrdwBdUgZW6nkjzt+zr0eVi+0=
X-Gm-Gg: ASbGnctGpEZBpDaz8sZ2SidR8ZB97z4K6flesB3222RQKCwwfSuS4XL+e0YrSUtlScc
	0UjB3g8ZxhNIw7ERpOCeWEF/p7Zy9ywPyieweYJ5hsmOCH0kqd8wgr5E0mId4rYpf8YFVZa9Mkp
	k=
X-Google-Smtp-Source: AGHT+IF7BDT5v47qpZ7BQJBjR+Chor6cujYn5vmevPbfxMWvfps+WuGJ1nYvSJEu7706h6uf6YrTGRE3RbmaAjAl+D0=
X-Received: by 2002:a2e:be27:0:b0:302:5308:ba48 with SMTP id
 38308e7fff4ca-3090dcaf233mr21743481fa.12.1739517933849; Thu, 13 Feb 2025
 23:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20250211161500.3077588-1-martin.jansa@gmail.com> <d77e1e97-ded6-44bd-8d80-fd855b738b10@windriver.com>
In-Reply-To: <d77e1e97-ded6-44bd-8d80-fd855b738b10@windriver.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 14 Feb 2025 08:25:20 +0100
X-Gm-Features: AWEUYZl6OEnyGLY6fG76ngOqzecKuB2lXlkqtVeKpTdCo_leD3cr2NxrPCNUvT0
Message-ID: <CA+chaQfYxzndjbbwTMd6oiraKhknhc_HwhzeXytPqQpuTxX8mg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][mickledore][PATCH 1/3]
 tensorflow: drop Upstream-Status inside third_party .patch files
To: Hongxu Jia <hongxu.jia@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Feb 2025 07:25:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1084

Not sure what happened, but it does apply fine from patchwork (and
doesn't even mangle my e-mail address with Martin Jansa via
lists.yoctoproject.org
<martin.jansa=3Dgmail.com@lists.yoctoproject.org>), see:

HEAD is now at 3d7625d MAINTAINERS.md: fix e-mail address
martin@jama /OE/layers/meta-tensorflow $ wget
https://patchwork.yoctoproject.org/project/yocto/patch/20250211161500.30775=
88-1-martin.jansa@gmail.com/mbox/
-O - | git am
--2025-02-14 08:20:15--
https://patchwork.yoctoproject.org/project/yocto/patch/20250211161500.30775=
88-1-martin.jansa@gmail.com/mbox/
Resolving patchwork.yoctoproject.org... 34.211.161.74, 54.71.59.185,
54.191.94.169
Connecting to patchwork.yoctoproject.org|34.211.161.74|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 13812 (13K) [text/plain]
Saving to: =E2=80=98STDOUT=E2=80=99

-
100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>]
 13.49K  --.-KB/s    in 0s

2025-02-14 08:20:16 (1.94 GB/s) - written to stdout [13812/13812]

Applying: tensorflow: drop Upstream-Status inside third_party .patch files
martin@jama /OE/layers/meta-tensorflow $ git show -1 --pretty=3Dfuller | he=
ad
commit f26bbd26fc161ebd5a8028348dc612cdd8b0d528
Author:     Martin Jansa <martin.jansa@gmail.com>
AuthorDate: Tue Feb 11 17:14:57 2025 +0100
Commit:     Martin Jansa <martin.jansa@gmail.com>
CommitDate: Fri Feb 14 08:20:16 2025 +0100

    tensorflow: drop Upstream-Status inside third_party .patch files

    * these patches create:
      third_party/0001-XNNPACK-support-32-bit-x86.patch

meta-tensorflow $ git show -1 --pretty=3Dfuller g/mickledore | head
commit 3d7625d7ab0b98859519f9b0ba056b989b7e2a48
Author:     Martin Jansa via lists.yoctoproject.org
<martin.jansa=3Dgmail.com@lists.yoctoproject.org>
AuthorDate: Thu Feb 6 15:29:20 2025 +0100
Commit:     Hongxu Jia <hongxu.jia@windriver.com>
CommitDate: Fri Feb 7 10:57:19 2025 +0800

    MAINTAINERS.md: fix e-mail address

    CAUTION: This email comes from a non Wind River email account!
    Do not click links or open attachments unless you recognize the
sender and know the content is safe.

Maybe you were fetching/creating "'[yocto-patches]
[meta-tensorflow][mickledore][PATCH 1_3]tensorflow: drop
Upstream-Status inside third_party .patch f... -" somewhere else than
patchwork?

The same changes are also applied in:
https://github.com/shr-project/meta-tensorflow
if cherry-picking from there is easier for you.

Regards,

On Fri, Feb 14, 2025 at 4:20=E2=80=AFAM Hongxu Jia <hongxu.jia@windriver.co=
m> wrote:
>
> Hi Martin,
>
> Apply the patch on mickledore failed
>
> $ git branch
>    hardknott
>    kirkstone
>    master
> * mickledore
>    thud
>
> $ git log
> commit 3d7625d7ab0b98859519f9b0ba056b989b7e2a48 (HEAD -> mickledore,
> origin/mickledore)
> Author: Martin Jansa via lists.yoctoproject.org
> <martin.jansa=3Dgmail.com@lists.yoctoproject.org>
> Date:   Thu Feb 6 15:29:20 2025 +0100
>
>      MAINTAINERS.md: fix e-mail address
>
>      CAUTION: This email comes from a non Wind River email account!
>      Do not click links or open attachments unless you recognize the
> sender and know the content is safe.
>
>      yocto@yoctoproject.org doesn't exist and yocto-patches is probably
> better than
>      yocto@lists.yoctoproject.org
>
>      Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
>
> $ git am '[yocto-patches] [meta-tensorflow][mickledore][PATCH 1_3]
> tensorflow: drop Upstream-Status inside third_party .patch f... -
> "Martin Jansa via lists.yoctoproj
> ect.org" <martin.jansa=3Dgmail.com@lists.yoctoproject.org> - 2025-02-12
> 0014.eml'
> Applying: tensorflow: drop Upstream-Status inside third_party .patch file=
s
> error: patch failed:
> recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-failure-for-qem=
uarm.patch:28
> error:
> recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-failure-for-qem=
uarm.patch:
> patch does not apply
> Patch failed at 0001 tensorflow: drop Upstream-Status inside third_party
> .patch files
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> //Hongxu
> On 2/12/25 00:14, Martin Jansa via lists.yoctoproject.org wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
> >
> > * these patches create:
> >    third_party/0001-XNNPACK-support-32-bit-x86.patch
> >    third_party/0001-cpuinfo-support-32-bit-x86.patch
> >    third_party/0001-hardcode-go-SDKS.patch
> >    third_party/eigen3/0001-workaround-ice-failure-while-building-from-s=
ource-wi.patch
> >
> >    which aren't applied by do_patch bitbake task but by bazel:
> >
> >    tensorflow $ grep patch_file tensorflow/workspace2.bzl | head -n 2
> >    tensorflow/workspace2.bzl: patch_file =3D ["//third_party:0001-XNNPA=
CK-support-32-bit-x86.patch"],
> >    tensorflow/workspace2.bzl: patch_file =3D ["//third_party:0001-cpuin=
fo-support-32-bit-x86.patch"],
> >    tensorflow/workspace2.bzl: patch_file =3D ["//third_party:0001-hardc=
ode-go-SDKS.patch"],
> >    third_party/eigen3/workspace.bzl: patch_file =3D ["//third_party/eig=
en3:0001-workaround-ice-failure-while-building-from-source-wi.patch"],
> >
> >    so they don't really need Upstream-Status and including it there
> >    might cause false possitive e.g. in
> >    0001-fix-XNNPACK-build-failure-for-qemuarm.patch
> >
> >    ERROR: tensorflow-lite-2.10.0-r0 do_patch: QA Issue: Malformed Upstr=
eam-Status in patch
> >    recipes-framework/tensorflow/tensorflow-lite/0001-fix-XNNPACK-build-=
failure-for-qemuarm.patch
> >    Please correct according to https://docs.yoctoproject.org/contributo=
r-guide/recipe-style-guide.html#patch-upstream-status :
> >     Upstream-Status: Inappropriate [oe specific] [patch-status]
> >    ERROR: tensorflow-lite-2.10.0-r0 do_patch: Fatal QA errors were foun=
d, failing task.
> >
> >    caused by extra space before Upstream-Status
> >
> >    Maybe we should drop 0001-fix-XNNPACK-build-failure-for-qemuarm.patc=
h completely
> >    as it was already dropped from tensorflow in:
> >    https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dmickledore&=
id=3Dbaae9cd6d92f69aa16b874958a332e1d3a362fea
> >    and from tensorflow-lite in scarthgap branch:
> >    https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dscarthgap&i=
d=3D29509c97e9009ed0ae99ce6c2554e463575dc10c
> >
> >    and is now used only for tensorflow-lite, refresh it to apply
> >
> >    It was originally introduced for both in:
> >    https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dmickledore&=
id=3De0efac349f2aac3d65ccbeee20475dbb1ea3dd19
> >    and refreshed in:
> >    https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dmickledore&=
id=3D30fbec74ea37b646473b08d0ee8d3992ccd56245
> >
> > Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> > ---
> >   .../tensorflow/files/0001-hardcode-go-SDKS.patch    |  4 +---
> >   .../0001-support-32-bit-x64-and-arm-for-yocto.patch |  7 ++-----
> >   ...y-eigen_archive-workaround-ice-failure-whi.patch |  4 +---
> >   ...019-fix-XNNPACK-build-failure-for-qemuarm.patch} | 13 ++++--------=
-
> >   .../tensorflow/tensorflow-lite_2.12.0.bb            |  2 +-
> >   5 files changed, 9 insertions(+), 21 deletions(-)
> >   rename recipes-framework/tensorflow/files/{0001-fix-XNNPACK-build-fai=
lure-for-qemuarm.patch =3D> 0019-fix-XNNPACK-build-failure-for-qemuarm.patc=
h} (97%)
> >
> > diff --git a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.p=
atch b/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
> > index b705ec7..e365c27 100644
> > --- a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
> > +++ b/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
> > @@ -38,7 +38,7 @@ new file mode 100644
> >   index 00000000000..b51d7262f4c
> >   --- /dev/null
> >   +++ b/third_party/0001-hardcode-go-SDKS.patch
> > -@@ -0,0 +1,49 @@
> > +@@ -0,0 +1,47 @@
> >   +From 34242e73f76eff09ee33152c58c3be650331b7ff Mon Sep 17 00:00:00 20=
01
> >   +From: Hongxu Jia <hongxu.jia@eng.windriver.com>
> >   +Date: Thu, 1 Dec 2022 15:07:10 +0000
> > @@ -53,8 +53,6 @@ index 00000000000..b51d7262f4c
> >   +downloaded archive, so hardcode go SDKS list files rather than
> >   +fetch from internet
> >   +
> > -+Upstream-Status: Inappropriate [Yocto specific]
> > -+
> >   +Signed-off-by: Hongxu Jia <hongxu.jia@eng.windriver.com>
> >   +---
> >   + go/private/sdk.bzl | 7 +++++++
> > diff --git a/recipes-framework/tensorflow/files/0001-support-32-bit-x64=
-and-arm-for-yocto.patch b/recipes-framework/tensorflow/files/0001-support-=
32-bit-x64-and-arm-for-yocto.patch
> > index a855b30..22bd6c1 100644
> > --- a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-ar=
m-for-yocto.patch
> > +++ b/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-ar=
m-for-yocto.patch
> > @@ -56,7 +56,7 @@ new file mode 100644
> >   index 00000000000..2141c37236b
> >   --- /dev/null
> >   +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
> > -@@ -0,0 +1,29 @@
> > +@@ -0,0 +1,27 @@
> >   +From 2345756776fa09fd95e29f96f781e15e3b18a61b Mon Sep 17 00:00:00 20=
01
> >   +From: Hongxu Jia <hongxu.jia@windriver.com>
> >   +Date: Tue, 17 Aug 2021 01:09:53 -0700
> > @@ -64,8 +64,6 @@ index 00000000000..2141c37236b
> >   +
> >   +Use android_x86 as a workaround to support 32 bit x86
> >   +
> > -+Upstream-Status: Inappropriate [oe specific]
> > -+
> >   +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> >   +---
> >   + BUILD.bazel | 1 -
> > @@ -91,7 +89,7 @@ new file mode 100644
> >   index 00000000000..0c83cf01675
> >   --- /dev/null
> >   +++ b/third_party/0001-cpuinfo-support-32-bit-x86.patch
> > -@@ -0,0 +1,28 @@
> > +@@ -0,0 +1,27 @@
> >   +From f5e52b2db5516954dab9026e4f386982c4c3c3a4 Mon Sep 17 00:00:00 20=
01
> >   +From: Hongxu Jia <hongxu.jia@windriver.com>
> >   +Date: Mon, 19 Sep 2022 00:10:18 -0700
> > @@ -99,7 +97,6 @@ index 00000000000..0c83cf01675
> >   +
> >   +Use android_x86 as a workaround to support 32 bit x86
> >   +
> > -+Upstream-Status: Inappropriate [oe specific]
> >   +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> >   +---
> >   + BUILD.bazel | 1 -
> > diff --git a/recipes-framework/tensorflow/files/0001-third_party-eigen_=
archive-workaround-ice-failure-whi.patch b/recipes-framework/tensorflow/fil=
es/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
> > index b1571ab..2056c20 100644
> > --- a/recipes-framework/tensorflow/files/0001-third_party-eigen_archive=
-workaround-ice-failure-whi.patch
> > +++ b/recipes-framework/tensorflow/files/0001-third_party-eigen_archive=
-workaround-ice-failure-whi.patch
> > @@ -24,7 +24,7 @@ new file mode 100644
> >   index 00000000000..436f35fca13
> >   --- /dev/null
> >   +++ b/third_party/eigen3/0001-workaround-ice-failure-while-building-f=
rom-source-wi.patch
> > -@@ -0,0 +1,69 @@
> > +@@ -0,0 +1,67 @@
> >   +From 035fd96026e18d61c19da038ab2b0f7a61e97799 Mon Sep 17 00:00:00 20=
01
> >   +From: Hongxu Jia <hongxu.jia@windriver.com>
> >   +Date: Mon, 19 Sep 2022 01:08:18 -0700
> > @@ -37,8 +37,6 @@ index 00000000000..436f35fca13
> >   +But we could not patch on native gcc,so try to workaround,
> >   +Refer: https://github.com/tensorflow/tensorflow/issues/25323
> >   +
> > -+Upstream-Status: Inappropriate [wr-installer specific]
> > -+
> >   +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> >   +---
> >   + unsupported/Eigen/CXX11/src/Tensor/TensorImagePatch.h | 3 ++-
> > diff --git a/recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-=
failure-for-qemuarm.patch b/recipes-framework/tensorflow/files/0019-fix-XNN=
PACK-build-failure-for-qemuarm.patch
> > similarity index 97%
> > rename from recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-f=
ailure-for-qemuarm.patch
> > rename to recipes-framework/tensorflow/files/0019-fix-XNNPACK-build-fai=
lure-for-qemuarm.patch
> > index dea74d9..1a792ee 100644
> > --- a/recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-failure=
-for-qemuarm.patch
> > +++ b/recipes-framework/tensorflow/files/0019-fix-XNNPACK-build-failure=
-for-qemuarm.patch
> > @@ -1,4 +1,4 @@
> > -From c15caa4d5f133307a23114c41a9c497e5ec9da2c Mon Sep 17 00:00:00 2001
> > +From 2ace7a16a8033169b7ddb71a79956416644ffa3e Mon Sep 17 00:00:00 2001
> >   From: Hongxu Jia <hongxu.jia@windriver.com>
> >   Date: Thu, 23 Mar 2023 10:28:04 +0800
> >   Subject: [PATCH] fix XNNPACK build failure for qemuarm
> > @@ -13,10 +13,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com=
>
> >    1 file changed, 209 insertions(+), 7 deletions(-)
> >
> >   diff --git a/third_party/0001-XNNPACK-support-32-bit-x86.patch b/thir=
d_party/0001-XNNPACK-support-32-bit-x86.patch
> > -index 2141c37236b..ca6a38545b1 100644
> > +index e2c053e6f8c..89ba615a9fe 100644
> >   --- a/third_party/0001-XNNPACK-support-32-bit-x86.patch
> >   +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
> > -@@ -1,22 +1,36 @@
> > +@@ -1,20 +1,34 @@
> >   -From 2345756776fa09fd95e29f96f781e15e3b18a61b Mon Sep 17 00:00:00 20=
01
> >   +From 5ba6883121e91a334cc97ee98eea6ef0afb7a314 Mon Sep 17 00:00:00 20=
01
> >    From: Hongxu Jia <hongxu.jia@windriver.com>
> > @@ -28,8 +28,6 @@ index 2141c37236b..ca6a38545b1 100644
> >
> >   +Does not support 32 bit ARM with Neon DotProduct
> >   +
> > - Upstream-Status: Inappropriate [oe specific]
> > -
> >    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> >    ---
> >   - BUILD.bazel | 1 -
> > @@ -59,7 +57,7 @@ index 2141c37236b..ca6a38545b1 100644
> >     config_setting(
> >         name =3D "android_x86",
> >         values =3D {
> > -@@ -24,6 +38,194 @@ index 27ab07c9..f223d2ab 100644
> > +@@ -22,6 +36,194 @@ index 27ab07c9..f223d2ab 100644
> >             "cpu": "x86",
> >         },
> >     )
> > @@ -255,6 +253,3 @@ index 2141c37236b..ca6a38545b1 100644
> >   -2.30.2
> >   +2.27.0
> >
> > ---
> > -2.27.0
> > -
> > diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb b/r=
ecipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
> > index 83fd12d..e76a09b 100644
> > --- a/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
> > +++ b/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
> > @@ -15,7 +15,7 @@ SRC_URI +=3D " \
> >              file://yocto_compiler_configure.bzl \
> >             "
> >   SRC_URI:append:arm =3D " \
> > -           file://0001-fix-XNNPACK-build-failure-for-qemuarm.patch \
> > +    file://0019-fix-XNNPACK-build-failure-for-qemuarm.patch \
> >   "
> >
> >   SRC_URI +=3D "https://storage.googleapis.com/download.tensorflow.org/=
models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=3Dmodel-inv3"
> > --
> > 2.48.1
> >
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#1061): https://lists.yoctoproject.org/g/yocto-patch=
es/message/1061
> > Mute This Topic: https://lists.yoctoproject.org/mt/111125079/3617049
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13176=
071/3617049/43253763/xyzzy [hongxu.jia@eng.windriver.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> >
>

