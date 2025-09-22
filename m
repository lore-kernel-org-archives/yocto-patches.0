Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87215CAC592
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 17:26:51 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web11.58584.1758562005482953532
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Sep 2025 10:26:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UPCtccS0;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-579e9fd5474so4012595e87.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758562004; x=1759166804; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0SxwUCy1Rpj87HBQmss/QzHIVdhanWasVqcWdTheFg=;
        b=UPCtccS0YD2XzshXKLLCRx3bQOo0xkDkEzs5lI7wxGiiPs/XA5Qsflj8iWnI67vdYg
         SBGH8LZbUTRZEqgROZgxiSVfskrSQqDgya4h9PaBAIdC2diIypZVMW4dvlKViwMA4HPz
         VL7I+eFn73fdd7FzkELmgW5xG1ryDuOVlL9QDvHnoou0RKC89r0dUsiMp5w0rRT+2aei
         VqMVr+MRizK8X6Z2Ee3Zso5s35cRqgQglgsewlQRNwO28SgH3Oia8EjU9iPpdjr7T26j
         c2pqeTruq7IfcK5/C9i9xm8O4xk0TndDoMI4nFCTcRTo3XisneICNuYeud69+mrGjDMs
         KJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758562004; x=1759166804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0SxwUCy1Rpj87HBQmss/QzHIVdhanWasVqcWdTheFg=;
        b=JcbrRsqKXbGrRQxvwCgRtYtEnK5GzJCB2EzbJ8BhS2W0GgRDtSHXWsJhEpLZHU7ycs
         k8R4uzBzH8gLAzZebBsbZka+mQy9UKwtPDWsPaj7zj3XsLZ6IlvQhTVttwcOCNSPrz09
         8Db3c3FWsyz/BSzo9tMUT6MIK7aH1vI8k+FX7MJe+a0W2B5gvtiFxgOWnOLZUOaziCjb
         Obmft/6eDHrlAU+//wdL2oyXLgPYND69OEjg30fEfM+Jna6kYM69AunC2CtWRttWi8vR
         XdpH34AFru72BFgd5QyEomEJUAH3SJAkF9CqQKpx4RYVP/wg/dI4+Oamp/X9lEyu0uTd
         WiLQ==
X-Gm-Message-State: AOJu0YwPI5pcXFprt4QdlXGK9HEzifFjcpEysxXasPwK2nspum7XWASd
	pyQuYw54s9rahu7wlYskVExfu3cOPEHPSXOjJ+2E9ZPMKAKYIk9TrFGphj8jxu+l1HQbPwRt30R
	0afaZgoiLFdFVYCFGU2/noBGNgK9Skrqb7g==
X-Gm-Gg: ASbGncsmlTclG4Ev9lTPZKvWyv76EsB0D6smI/xx0kbSUSVzMct7gH8ad/+FYQgui07
	WOtyZ/FqUte5PStf0PM/UOqipg1OVFBjClnxC8d+9TUzAAh5WZpnjGGRNb+o21oWvSnzPEGg5Lb
	H1ef3Zju3xBUxUC+sscsTyrwTJtO16ZkHk+aN8fC9fZLZ4uVVWlPa0qrZvDlMsdVQN/EE1mu9gm
	T0WhJCeWQ==
X-Google-Smtp-Source: AGHT+IF2silCQb2nL+PTNgsFR4QN/+DB02istcZvNt3WNkeE+Jm9/wRh2Ty5zMGegdAiJfSNnLhZjkwK4y3x1/AEWSE=
X-Received: by 2002:a05:6512:3483:b0:57a:3020:202 with SMTP id
 2adb3069b0e04-57a3020060fmr3197508e87.16.1758562003197; Mon, 22 Sep 2025
 10:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <185CE350789F6CFE.8958@lists.yoctoproject.org> <CA+chaQdqb7f+oo44idJwqdOd7PR4PK3Q2r4iD4mQf9F5YZzAQQ@mail.gmail.com>
In-Reply-To: <CA+chaQdqb7f+oo44idJwqdOd7PR4PK3Q2r4iD4mQf9F5YZzAQQ@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 22 Sep 2025 19:26:28 +0200
X-Gm-Features: AS18NWCftY2q7kE0t_yM3NYhXm6iQ4L0FFyUv5w2-YdVDJEfzYr8ZspfuBTtGoI
Message-ID: <CA+chaQcD=7jfKxKZxf+3ME9wgrXkN1PeEo7Mf9j-5Dvr-bkF0g@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][walnascar][PATCH] bazel-native:
 fix build with gcc-15
To: yocto-patches@lists.yoctoproject.org
Cc: hongxu.jia@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 17:26:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2229

ping3 for this patch in walnascar (it was already applied in scarthgap
and master/whinlatter branches over a month ago, but still missing in
walnascar).

On Mon, Sep 15, 2025 at 3:01=E2=80=AFPM Martin Jansa <martin.jansa@gmail.co=
m> wrote:
>
> ping2
>
> On Mon, Aug 18, 2025 at 4:38=E2=80=AFPM Martin Jansa via
> lists.yoctoproject.org <martin.jansa=3Dgmail.com@lists.yoctoproject.org>
> wrote:
> >
> > From: Martin Jansa <martin.jansa@gmail.com>
> >
> > Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> > ---
> >  recipes-devtools/bazel/bazel-native_6.0.0.bb  |  1 +
> >  .../bazel/files/include_stdint.patch          | 28 +++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> >  create mode 100644 recipes-devtools/bazel/files/include_stdint.patch
> >
> > diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-dev=
tools/bazel/bazel-native_6.0.0.bb
> > index 19b411b..a0daa3b 100644
> > --- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
> > +++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
> > @@ -12,6 +12,7 @@ SRC_URI =3D "https://github.com/bazelbuild/bazel/rele=
ases/download/${PV}/bazel-${P
> >             file://0001-cutsomize-native-toolchains-for-Yocto.patch \
> >             file://0001-fix-compile-failure-on-gcc-13.patch \
> >             file://1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch \
> > +           file://include_stdint.patch \
> >  "
> >
> >  inherit python3native
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
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#2035): https://lists.yoctoproject.org/g/yocto-patch=
es/message/2035
> > Mute This Topic: https://lists.yoctoproject.org/mt/114764168/3617156
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13388=
836/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> >

