Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB1C87FCA
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 06:37:00 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web11.19097.1754462213063610344
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 05 Aug 2025 23:36:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hrfOMjUS;
 spf=pass (domain: gmail.com, ip: 209.85.167.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso6877322e87.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 05 Aug 2025 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754462211; x=1755067011; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwakuNrif1dfI9q4HpLodMkIWt57e4RwxQV5TQvOQZc=;
        b=hrfOMjUSXuKi531Y6rmtmJcGaZVJwQ1sjS8y0nbkSnXmV4Fa4b9dp6cntDjMpNhQ1R
         368dRSbZluo9ZgCtsiTHdIiln4TaK3lz23z+F/kELqZMNBGv6+KQx39wGAmCnw+Ixk3Z
         9DViZCwglM7RB93F3JQGrrBACOdXaqsHPsk9DumM+gHQaRAaQo74re/KqSnSqdaWGbNs
         N5n1ZeELg6uUTKw+QWfuz6zDMwHhn7QtXq1+9T0VcVg3Lr4QFFsGPxWy7z9ryAviMG9f
         XzR3/cexiXBEC1pCVr3egPJruQqCUZZbY4w5sHnK8Te/QU3zzx/rCSue+gaZ3zONguJM
         EAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754462211; x=1755067011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwakuNrif1dfI9q4HpLodMkIWt57e4RwxQV5TQvOQZc=;
        b=XwN9sYXqIn24Gk784n/vqX2qkzWSybfQfdCbiYAuZcSvtP/XU0gFPMfPzFXevDZZUp
         wbM5XGQZrVF6zvJUr2wTV9NVwUwk5FNS/TpmkZuFGIaDXbMq+K8QpfKVMc4YjUhMpEFO
         Sm/D5pYsRvbybvqa66KwZyYVmD4qq7LII3WdEOEgsJ53/Eq1GYb1fA97vXv73q+rp0jH
         Q6AzWKTcs1rUbsI5egoWUkOuaqiekMWIkGzOeqKCex3tOSuOJONErw6Voyb+VmG6Hrbt
         TPxrpV6yVGLmah4YY6r/JItrnAIKWTyRE31Ls7H6AFu64ADTjb6RGx9nfBKVbJPRUDYt
         pP4A==
X-Gm-Message-State: AOJu0YyppMnbkNySyXGVjWqdWDYj8YwgFrT3sl32BbHUXh89q8voMO1T
	8IBlRHgX7ctTmzmR5FoBqU9QsSDgVHbQlZCslxi0HD6GtTScs0KDxO421291ANkVup5G+pExkzt
	P3vxeyRTiGeK43PSFXwwnk0C+p7dI0TU/VOlr
X-Gm-Gg: ASbGncs1/cwvd6edArhvxur1TPeOgD6Q3KnKXJTH3bUYv76/vAer2ZSXmh6F+rHXcho
	7q1R3/FeUgppNQZgtWduc1KoCVplhu3C0gYMKOudHK/+uqdjaXz+n+8O2Mqo9AHMWarztV3sdmO
	/tEs9hIlrd1dwLoey82nOevhgZPC7gIa5Yi6muNWZY1vmYPDJRM8wP41QXu9lKxxyGhx5dxPHj7
	KfYm9cTmQ==
X-Google-Smtp-Source: AGHT+IFClCNeJEaAm4FKmAxnR3u179ffizbJr42M7pqddy+Kr0E48b4S11bnZwLDImjyc3KLnYq90kYzb2AcdMdW69c=
X-Received: by 2002:a05:6512:ba6:b0:55b:89e4:fe21 with SMTP id
 2adb3069b0e04-55caf34c698mr544725e87.35.1754462210733; Tue, 05 Aug 2025
 23:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250708072436.24522-1-martin.jansa@gmail.com>
 <20250708072436.24522-2-martin.jansa@gmail.com> <CA+chaQdVAzm8au9RXWgY01gwwWO_qxO6LLM=ThTOwzWU8MrUgQ@mail.gmail.com>
 <519af080-65b3-4e68-928c-a2c5c087a5b6@windriver.com> <CA+chaQcakdJhrJMVjpx1pm_KsZ8J3N2cvg25Qc-DL2vLxbwGiA@mail.gmail.com>
 <83eb4dbb-2a6e-491f-a02e-e3ca9bba61bc@windriver.com>
In-Reply-To: <83eb4dbb-2a6e-491f-a02e-e3ca9bba61bc@windriver.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 6 Aug 2025 08:36:41 +0200
X-Gm-Features: Ac12FXzSGOICKnbBQITLEc270MzacCZ7YkzARWVx876k7Lh-0Iig8uIK7bw0e1U
Message-ID: <CA+chaQc_ci6hdKyt1mintWMH=7bpxNvy_gF5oh+x0j_qqGwErA@mail.gmail.com>
Subject: Re: [meta-tensorflow][PATCH 2/3] bazel-native: adapt to UNPACKDIR
 changes - avoid WORKDIR/sources
To: Hongxu Jia <hongxu.jia@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 Aug 2025 06:37:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1888

Hi,
can you check whinlatter branch? It's out of sync with master branch
27237386b61 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS
was now removed in whinlatter branch (as it was previously removed
from master branch and then restored).

Fetching origin
From https://git.yoctoproject.org/meta-tensorflow
   2723738..38cfa43  master     -> origin/master
   024c8dd..5865dad  walnascar  -> origin/walnascar
 + 2723738...f1e0f9d whinlatter -> origin/whinlatter  (forced update)

docker-lge @ ~/layers/meta-tensorflow $ git log --oneline 2723738..38cfa43
38cfa43 (origin/master, origin/HEAD, g/master, g/HEAD) tensorflow.inc:
fix compile fail with DEBUG_BUILD =3D "1" for cortexa53
docker-lge @ ~/layers/meta-tensorflow $ git log --oneline 024c8dd..5865dad
5865dad (origin/walnascar, g/walnascar) tensorflow.inc: fix compile
fail with DEBUG_BUILD =3D "1" for cortexa53
docker-lge @ ~/layers/meta-tensorflow $ git log --oneline 2723738...f1e0f9d
f1e0f9d (origin/whinlatter, g/whinlatter) tensorflow.inc: fix compile
fail with DEBUG_BUILD =3D "1" for cortexa53
2723738 (HEAD -> jansa/master, contrib/jansa/master, master)
classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS

docker-lge @ ~/layers/meta-tensorflow $ git log --oneline
origin/master  | head -n 3
38cfa43 tensorflow.inc: fix compile fail with DEBUG_BUILD =3D "1" for corte=
xa53
2723738 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS
eb5054c layer.conf: Update to whinlatter release series

docker-lge @ ~/layers/meta-tensorflow $ git log --oneline
origin/whinlatter  | head -n 3
f1e0f9d tensorflow.inc: fix compile fail with DEBUG_BUILD =3D "1" for corte=
xa53
eb5054c layer.conf: Update to whinlatter release series
90d52e2 bazel-native: set S from UNPACKDIR in recipes that use only local f=
iles

docker-lge @ ~/layers/meta-tensorflow $ git diff origin/master origin/whinl=
atter
diff --git a/classes/bazel.bbclass b/classes/bazel.bbclass
index f6585e0..8fca205 100644
--- a/classes/bazel.bbclass
+++ b/classes/bazel.bbclass
@@ -149,6 +149,8 @@ EOF

 EXPORT_FUNCTIONS do_configure

+PSEUDO_IGNORE_PATHS .=3D ",${WORKDIR}/bazel"
+
 inherit unsupportarch

 export YOCTO_NATIVE_SYSROOT =3D
"${BAZEL_OUTPUTBASE_DIR}/external/yocto_compiler/recipe-sysroot-native"

On Fri, Jul 18, 2025 at 9:20=E2=80=AFAM Hongxu Jia <hongxu.jia@windriver.co=
m> wrote:
>
> On 7/18/25 15:12, Martin Jansa wrote:
>
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.
>
> On Wed, Jul 16, 2025 at 9:06=E2=80=AFAM Hongxu Jia <hongxu.jia@windriver.=
com> wrote:
>
> On 7/16/25 14:49, Martin Jansa wrote:
>
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.
>
> Hongxu Jia looks like you've created very similar commits for
> whinlatter compatibility recently.
>
> Do you monitor this ML for meta-tensorflow changes?
>
> Sorry for the missing, I will take care of it next time
>
> OK, will try to remember to Cc you directly if I'm sending some
> meta-tensorflow patches in future.
>
> Can you please check what happened with master branch? there was
> 27237386b61 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS
> around 2 days ago and now it's gone, did you remove it and
> force-pushed master (please don't do that, pushing new revert commit
> instead would be appreciated) or did it disappear due to some syncing
> issues in infrastructure?
>
> I have noticed because our CI is failing either to fetch 27237386b61
> or trying to "upgrade" from 27237386b61 to previous eb5054ccf48
> without any git log between them.
>
> Got [27237386b61 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS] back,=
 there is a web hook in github to sync with https://git.yoctoproject.org/me=
ta-tensorflow
>
> You could git pull to latest
>
> //Hongxu

