Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135D1CAC598
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 07:23:41 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.17086.1758093814646994481
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Sep 2025 00:23:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZRbPAjNR;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f6f434c96so7175907e87.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 00:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758093812; x=1758698612; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqBjBl8bhAK2IpmzcrpcNMkivRDqRkP/nLzquqc1JYw=;
        b=ZRbPAjNRZ0x+uCyEnDE4e6eV6mJKwjdtTazEVmzBkpFUsdRg/Btv6VoyxPSy/mOvpM
         32xwfEl4abxWeglUtNmLq5SLescLm35RLnW+OIH2nLznrdqawD8qtKbU448f/vhnWUgS
         V6+jw7oiM2B15vPkhTufChD6t17XTWn5ATzxOm5O368FL3hfyebyN0rNuf8iHMSa2/gn
         Ma3FWZ/vkRbre+Q2rZ8LaLk7oRGB2jbHU1Gifxz/HgSOCIaDFTV2X19TqMRePx2PaMqa
         4YxVlZtukKQgBCvCP1Glv2IOXtuF7PjjksgwNc0jBs2w4BdVmyP/1xKgvwIrRqwnSxN0
         Tkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758093812; x=1758698612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqBjBl8bhAK2IpmzcrpcNMkivRDqRkP/nLzquqc1JYw=;
        b=VD8BqQIFO2eAwdxbiw0qYlkmmXA01Tnjym/aRWBgs+ACQV0k4s3W9GAVGCKiXQtMgV
         Ksret2xkKkPHWpk8u6Dm9e0G31sYgT1VETA9dSII1r37+DslZ6BjJCSwrRUGwLQvWmXX
         qFNOZAVcbQGV261Mh08lDgE5RhUbwSnpNEbdGntrj9hERVIVuyeitknODNZn4Gd67QTz
         k787qs5qiEYUjtPPjVLuKd8pgEJzo0vI1j3k+kyI8QVpNIzgfq6d8DK1fcA78iQONnR5
         VtMSWOqMAkPRqgkIEZk/zJnYQz2qiqJfh8CTShQnk7LQw7yzjIsmKPb6wN1tOf9Q1Jkh
         mJEA==
X-Gm-Message-State: AOJu0YxMKI2OSaM8IDOHfgLs+KnHZyPBsTPhKc4H7b3BiPBk93dt0gFd
	ARFBtuiV6XXoEteGqzqtTfamhib2E7WR0GDJHKxJsMPUQaW8tDxjWiCI+MSD2uWulRlY751Vmki
	uYmNvSw+aheQaJzZ6V05OoipMjG0pSzeDmw==
X-Gm-Gg: ASbGncv+jpjCB13dbVrmpmFRj1IewEbyVZAm+70uKLyDp37B/SMC5g2Q7PIQnhpRO36
	TVKBtWcLwh+0o/NyvH39dRjA9r0tzIY5KANHf3fxeqT0cuRGrr2c96+XrNRAddfH+MKb8o5LYSq
	wHH+hiIZvrtI8l4hnvcYyqZJxYOVsEhrqJzqVkrx3mRZs07xp3LpFlLXJp6inlIoQ8/8f2DVM04
	yP2LC3Shw==
X-Google-Smtp-Source: AGHT+IELOWAjgsnFQKZZAnXVk0uncFQRYJeDeBd8OP0jfwCHuV2Vv+9/WZDRpPhETExeNuLW8KZsLvc+ozdRd85RtCM=
X-Received: by 2002:a05:6512:224f:b0:576:89cc:95db with SMTP id
 2adb3069b0e04-57799cbd341mr401923e87.16.1758093812011; Wed, 17 Sep 2025
 00:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <185CE350789F6CFE.8958@lists.yoctoproject.org> <CA+chaQdqb7f+oo44idJwqdOd7PR4PK3Q2r4iD4mQf9F5YZzAQQ@mail.gmail.com>
 <82d8fef3-e46e-46f7-b75b-0b812c0b0cb0@windriver.com>
In-Reply-To: <82d8fef3-e46e-46f7-b75b-0b812c0b0cb0@windriver.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 17 Sep 2025 09:23:19 +0200
X-Gm-Features: AS18NWCqyvwWh9KQxE_tJoU21GzH3JexT0UREqkU8WHvYpKTs4Uad7E25zhiMz0
Message-ID: <CA+chaQfzyyAUbSSbzh-PEM=GWxkW5e4xbAcxvWzypvWvaN92Dg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][walnascar][PATCH] bazel-native:
 fix build with gcc-15
To: Hongxu Jia <hongxu.jia@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 07:23:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2203

That broke our builds which expect the old locked revisions to exist
and this change is still missing in walnascar, right?

Cheers,

On Wed, Sep 17, 2025 at 4:08=E2=80=AFAM Hongxu Jia <hongxu.jia@windriver.co=
m> wrote:
>
> On 9/15/25 21:01, Martin Jansa wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
> >
> > ping2
> >
> > On Mon, Aug 18, 2025 at 4:38=E2=80=AFPM Martin Jansa via
> > lists.yoctoproject.org <martin.jansa=3Dgmail.com@lists.yoctoproject.org=
>
> > wrote:
> >> From: Martin Jansa <martin.jansa@gmail.com>
>
> I force update git repo to correct the author, no change on content,
> just commit message and author updates
>
> //Hongxu
>
> >> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> >> ---
> >>   recipes-devtools/bazel/bazel-native_6.0.0.bb  |  1 +
> >>   .../bazel/files/include_stdint.patch          | 28 +++++++++++++++++=
++
> >>   2 files changed, 29 insertions(+)
> >>   create mode 100644 recipes-devtools/bazel/files/include_stdint.patch
> >>
> >> diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-de=
vtools/bazel/bazel-native_6.0.0.bb
> >> index 19b411b..a0daa3b 100644
> >> --- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
> >> +++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
> >> @@ -12,6 +12,7 @@ SRC_URI =3D "https://github.com/bazelbuild/bazel/rel=
eases/download/${PV}/bazel-${P
> >>              file://0001-cutsomize-native-toolchains-for-Yocto.patch \
> >>              file://0001-fix-compile-failure-on-gcc-13.patch \
> >>              file://1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch \
> >> +           file://include_stdint.patch \
> >>   "
> >>
> >>   inherit python3native
> >> diff --git a/recipes-devtools/bazel/files/include_stdint.patch b/recip=
es-devtools/bazel/files/include_stdint.patch
> >> new file mode 100644
> >> index 0000000..35c57c2
> >> --- /dev/null
> >> +++ b/recipes-devtools/bazel/files/include_stdint.patch
> >> @@ -0,0 +1,28 @@
> >> +https://github.com/lihaohong6/COPR/blob/bf48c5450a909cf8358e3cbd81cdd=
e26df426e12/bazel7/include_stdint.patch
> >> +
> >> +Upstream-Status: Submitted [https://github.com/bazelbuild/bazel/issue=
s/25514]
> >> +
> >> +diff --git a/src/main/cpp/archive_utils.h b/src/main/cpp/archive_util=
s.h
> >> +index 18856ab..5298a36 100644
> >> +--- a/src/main/cpp/archive_utils.h
> >> ++++ b/src/main/cpp/archive_utils.h
> >> +@@ -15,6 +15,7 @@
> >> + #ifndef BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
> >> + #define BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
> >> +
> >> ++#include <cstdint>
> >> + #include <string>
> >> + #include <vector>
> >> +
> >> +diff --git a/src/main/cpp/util/logging.h b/src/main/cpp/util/logging.=
h
> >> +index b2cd459..7bf5a00 100644
> >> +--- a/src/main/cpp/util/logging.h
> >> ++++ b/src/main/cpp/util/logging.h
> >> +@@ -14,6 +14,7 @@
> >> + #ifndef BAZEL_SRC_MAIN_CPP_LOGGING_H_
> >> + #define BAZEL_SRC_MAIN_CPP_LOGGING_H_
> >> +
> >> ++#include <cstdint>
> >> + #include <memory>
> >> + #include <sstream>
> >> + #include <string>
> >>
> >>
> >> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >> Links: You receive all messages sent to this group.
> >> View/Reply Online (#2035): https://lists.yoctoproject.org/g/yocto-patc=
hes/message/2035
> >> Mute This Topic: https://lists.yoctoproject.org/mt/114764168/3617156
> >> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> >> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338=
8836/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> >> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >>
> >>
>

