Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C49CA0EE4
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 07:29:26 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web10.69678.1755502159634370508
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 00:29:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WSy6aoiC;
 spf=pass (domain: gmail.com, ip: 209.85.208.170, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3352212fefdso3138891fa.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 00:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755502157; x=1756106957; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wzHdhSGp8kwNp1QgbCPxK32uQVyac82ISHr0N6yTu8=;
        b=WSy6aoiCfGCpzRtowIAGNTAsg/FtStufvb92WlVyxowOgvKhpDK9sOtBiDYnwl0vDj
         MpdjsW24rh0dRsdVB/aGsSfZGnkXyzXyW0tUZmTkCh3jyfhPSvmasZkpOmr/48haRYmO
         zmMhgv5ZoLxEyXpRQjHPsC5aWlKBnJwe+dmD6O/CoV3kyf96oyVEEVQKrKCYnjJ6GHt4
         AILdGN4EIY7KUdbfD9beiI5UI9ddmDE64npkIWmST2H/jvcWjB+ohaKPdRYqW6yQdHff
         AjZTLukrvmeR6yeWAQ1z3ujiip3xmn9HhWklIBHUngc+V7MXaxX7Lp+G3ZHP4MDxM1FE
         NC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755502157; x=1756106957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wzHdhSGp8kwNp1QgbCPxK32uQVyac82ISHr0N6yTu8=;
        b=FL8YK28/8yEC3EUweHxvjszNuEvHiKYtsbTdYLnDNpbsvbjPzCn1vPWgdX82DskGOL
         YDuvUiHJWDOE5A47pkSyftkMyT4nsG+C/Pv4Zb0VieTockRnrKwVsjUWVwvHSn7UsfnF
         wagABDoweOaPd+2v5ZLRGwEvGNihXz3gGgLVU7NvNQcsxDVMvtMkcLi8/VPfkhBSIXTs
         R119+EepAxjk5IBzlDXyLz/drbE6FgLdn2V+pkXdi+w2PFdqzjIknm7mQXEWEAs+s3Iz
         OcVSBw/NP3mUuNVPoi+5aadcYk9S+CM36V7cYWy59n2xmTzHb9SM+ARid/lgoD4l5rZm
         7LxQ==
X-Gm-Message-State: AOJu0Yx9STWdm8xBd2tJrNsxLWzlxV8s7Z7Fp4L0Y7e+iJkz24HJH0lX
	DXS66lCXDhkL/xpg5R8MBAdaUPOcLISzkhELBPhOnX/KIGN8nQjwVF4SJhDeejJICtGBZOfJYJp
	k4Px2qD63G9A4iSqyVjrdv9A681JwlgK8RH2C
X-Gm-Gg: ASbGncv0x/7zby1bzoHN9fwzPHbc2TEciDGoDCn+cxtO1gGPDg+dKjwBFvv2HcEv/ST
	yAgFZmhEmX+Ejz1u31PUhcP4IAkXE8GyI7xxaHgVw57BXL9lKUQMQI1suTKf/TVx4zA06GDwr4k
	G7gGsaMhS8FOM8LlhdZ/yHynuteVMaQvJs8uGgHGWEAXvcu99OKLG6lZy7JGFHQBS3ZPN263C1k
	MAPG3ZdyQ==
X-Google-Smtp-Source: AGHT+IGbeZYpXxwnb9oPCkerpTVp3IEWNfwVlV5RhDj68Y1D9KaQEFtPjBndgdLXQFhGbrdryKBRif+VzfYsbevWY5s=
X-Received: by 2002:a2e:7201:0:b0:32b:35e6:bbe8 with SMTP id
 38308e7fff4ca-33409953750mr17955391fa.21.1755502156947; Mon, 18 Aug 2025
 00:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250817204644.3817415-1-martin.jansa@gmail.com> <83270ab8-56f3-4dd2-8fc3-97500bbba85a@windriver.com>
In-Reply-To: <83270ab8-56f3-4dd2-8fc3-97500bbba85a@windriver.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 18 Aug 2025 09:29:05 +0200
X-Gm-Features: Ac12FXzYjo6TdJY3PafAUoelSZqnUR6D-zRxNIwGvSicASS0LqHa_TrGAXJb220
Message-ID: <CA+chaQemUteiTGAYPiKXzJa-YZCbvHv3QxabdwBBfK63jVtCOA@mail.gmail.com>
Subject: Re: [meta-tensorflow][scarthgap][PATCHv2] bazel-native: fix build
 with gcc-15
To: Hongxu Jia <hongxu.jia@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 07:29:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2033

Thanks Hongxu.

Did you apply it manually or something? The Author got mangled in the
process (e-mail instead of the name)
https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dscarthgap&id=3D473=
0f3f8bfeb296f3b94244a5764b40d2ccf7773

It's OK, but please check your process for applying patches.

Cheers,

On Mon, Aug 18, 2025 at 4:16=E2=80=AFAM Hongxu Jia <hongxu.jia@windriver.co=
m> wrote:
>
> Thanks for your patch, merged
>
> //Hongxu
>
> On 8/18/25 04:46, martin.jansa@gmail.com wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
> >
> > From: Martin Jansa <martin.jansa@gmail.com>
> >
> > Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> > ---
> >   recipes-devtools/bazel/bazel-native_6.0.0.bb  |  1 +
> >   .../bazel/files/include_stdint.patch          | 28 ++++++++++++++++++=
+
> >   2 files changed, 29 insertions(+)
> >   create mode 100644 recipes-devtools/bazel/files/include_stdint.patch
> >
> > diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-dev=
tools/bazel/bazel-native_6.0.0.bb
> > index 29abd0e..04ca4cc 100644
> > --- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
> > +++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
> > @@ -12,6 +12,7 @@ SRC_URI =3D "https://github.com/bazelbuild/bazel/rele=
ases/download/${PV}/bazel-${P
> >              file://0001-cutsomize-native-toolchains-for-Yocto.patch \
> >              file://0001-fix-compile-failure-on-gcc-13.patch \
> >              file://1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch \
> > +           file://include_stdint.patch \
> >   "
> >
> >   inherit python3native
> > diff --git a/recipes-devtools/bazel/files/include_stdint.patch b/recipe=
s-devtools/bazel/files/include_stdint.patch
> > new file mode 100644
> > index 0000000..35c57c2
> > --- /dev/null
> > +++ b/recipes-devtools/bazel/files/include_stdint.patch
> > @@ -0,0 +1,28 @@
> > +https://github.com/lihaohong6/COPR/blob/bf48c5450a909cf8358e3cbd81cdde=
26df426e12/bazel7/include_stdint.patch
> > +
> > +Upstream-Status: Submitted [https://github.com/bazelbuild/bazel/issues=
/25514]
> > +
> > +diff --git a/src/main/cpp/archive_utils.h b/src/main/cpp/archive_utils=
.h
> > +index 18856ab..5298a36 100644
> > +--- a/src/main/cpp/archive_utils.h
> > ++++ b/src/main/cpp/archive_utils.h
> > +@@ -15,6 +15,7 @@
> > + #ifndef BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
> > + #define BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
> > +
> > ++#include <cstdint>
> > + #include <string>
> > + #include <vector>
> > +
> > +diff --git a/src/main/cpp/util/logging.h b/src/main/cpp/util/logging.h
> > +index b2cd459..7bf5a00 100644
> > +--- a/src/main/cpp/util/logging.h
> > ++++ b/src/main/cpp/util/logging.h
> > +@@ -14,6 +14,7 @@
> > + #ifndef BAZEL_SRC_MAIN_CPP_LOGGING_H_
> > + #define BAZEL_SRC_MAIN_CPP_LOGGING_H_
> > +
> > ++#include <cstdint>
> > + #include <memory>
> > + #include <sstream>
> > + #include <string>
>
>

