Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C76DCA0EFF
	for <webhook@archiver.kernel.org>; Wed, 27 Aug 2025 10:05:01 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.11179.1756289095972465217
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 Aug 2025 03:04:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=V58teA7c;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-333f92d60ddso49646891fa.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 27 Aug 2025 03:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756289094; x=1756893894; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+v0Ycu+Atxm0OPJygb/WW63CZwIks39DZ4ldlLbIo0=;
        b=V58teA7cXs+x3yXABMTwfebDgCUabid4FsE3Sz10Uh5zUN8OkLsR2IL9d5x1HLH3lQ
         liU+RUK3hfdFCCg4aObRvNzpCtIXY2M6SFOenlQr13X/lqE9fCYMDTYANFkhqp3EkrpD
         lES5JrIF12yNYVwABI82aDXuqz50L/fzDiCpzq3ekvokRAh6kd/cCaBPyDRKxK7vFeQt
         JEiBqcqNJDGp+Jpd7ymAtJindmWJ9G4ulK8YXhLSCqwMXVk0qf+qPPp0HHTa2sPHS6Nu
         6yboQ9sbaol/ui3XvIufCq3flRsiMIW+VJZm00H7+x0PCbt8wKbxZmBr7CASII+pvno7
         cqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289094; x=1756893894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+v0Ycu+Atxm0OPJygb/WW63CZwIks39DZ4ldlLbIo0=;
        b=quEd8dUiymV1yXNYx5Y8utRwIeD8WrdXAduDLtAJxAx2p3jPkC57OxsbnzZMDMs5nx
         tXzTPT1sXsar17+AvzfG8/kqSVzAsLIJbpTlApJpzmP7YUQ79iKQNrNjDDE3lU2CzBYf
         NjRdP1JR3dgspfTxjvNztma+9kTT7rNF9yAKw6Ci4tvs6trUh7JjQn6a72sZnsbT6Lia
         ulhO2PBd3bjeq/wRzDQLktG6yzBFJ9Y0suV6kXbdkBc9CMpVX4SYRzLEMXPpd/Q5kMfW
         22AkGaD0CUSjwrS2uc5Pg7zT3z4FVFVxCoAHYyygEDIynzz66auyK+YXR5qsS+TrfDlE
         Jaiw==
X-Gm-Message-State: AOJu0YwCEJjjeMHGM7jZ/B8KKY0IisU3EVn4P3eN4XN10Qu50OrUFX4+
	jMuuLN7qiKpUE4mop6zWGZqciiqwc7hyi1Oxcwu1yQVXCmuPJ6Y/8qAjf9F1lxMGJ0wUfQdKoi/
	HbQyE40CpPbcd4cIFI21hSaxZ6bdV60jnFA==
X-Gm-Gg: ASbGncuWI8fSiXA2F0Ny90pxWQnt3m9aLhiSt/Jn3tuBcMZkwHnLIImgYU78hm2BVA7
	zCnMhk2fmOCJVj+qvTK4/wA8laH/DCf3ANwXXt0TolWbihaUXhBDh+Uhr8IpgCCLn2k6ZpVB7Q2
	4NNQgytxhyZZ496ziWlYovx7j+cIPwuKwjcUyxrb7w0DvRt6Cc/mq6m1twcBxbkakIwvd0d8CPf
	UqFhEKB9VzCXZwqWxcN
X-Google-Smtp-Source: AGHT+IF2YX3eW3x9sf96SlXVYtajemQD3AQp7q1VID7Grl4307dZIilYyxmVfJmtJV3Dfsndk2F4b2uGon+Q/FfdKHY=
X-Received: by 2002:a05:651c:1a0c:b0:336:6b37:c8f4 with SMTP id
 38308e7fff4ca-3366b37cf0bmr36279731fa.35.1756289093435; Wed, 27 Aug 2025
 03:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <185D236360593879.4571@lists.yoctoproject.org>
In-Reply-To: <185D236360593879.4571@lists.yoctoproject.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 27 Aug 2025 12:04:40 +0200
X-Gm-Features: Ac12FXzJQbb3lxCt3CWxIPIxJdzMYMRdmwVIdJvO1h83Mn14sFBTXROOBkC8Pe8
Message-ID: <CA+chaQcBn_=Sz-8nPaC7RNGtR4FLhc6X7DaqMGhCopVq7HWxpQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][master][PATCH] bazel-native:
 fix build with gcc-15
To: yocto-patches@lists.yoctoproject.org
Cc: hongxu.jia@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 Aug 2025 10:05:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2084

Hi,

this time you didn't forget the "From:" in the body, but the Author is
still mangled.

Are you applying the patches manually instead of "git am"?

Also ping for the same change for walnascar.

Cheers,

On Tue, Aug 19, 2025 at 12:12=E2=80=AFPM Martin Jansa via
lists.yoctoproject.org <martin.jansa=3Dgmail.com@lists.yoctoproject.org>
wrote:
>
> From: Martin Jansa <martin.jansa@gmail.com>
>
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
>  recipes-devtools/bazel/bazel-native_6.0.0.bb  |  1 +
>  .../bazel/files/include_stdint.patch          | 28 +++++++++++++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 recipes-devtools/bazel/files/include_stdint.patch
>
> diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-devto=
ols/bazel/bazel-native_6.0.0.bb
> index bc63430..4960358 100644
> --- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
> +++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
> @@ -12,6 +12,7 @@ SRC_URI =3D "https://github.com/bazelbuild/bazel/releas=
es/download/${PV}/bazel-${P
>             file://0001-cutsomize-native-toolchains-for-Yocto.patch \
>             file://0001-fix-compile-failure-on-gcc-13.patch \
>             file://1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch \
> +           file://include_stdint.patch \
>  "
>
>  inherit python3native
> diff --git a/recipes-devtools/bazel/files/include_stdint.patch b/recipes-=
devtools/bazel/files/include_stdint.patch
> new file mode 100644
> index 0000000..35c57c2
> --- /dev/null
> +++ b/recipes-devtools/bazel/files/include_stdint.patch
> @@ -0,0 +1,28 @@
> +https://github.com/lihaohong6/COPR/blob/bf48c5450a909cf8358e3cbd81cdde26=
df426e12/bazel7/include_stdint.patch
> +
> +Upstream-Status: Submitted [https://github.com/bazelbuild/bazel/issues/2=
5514]
> +
> +diff --git a/src/main/cpp/archive_utils.h b/src/main/cpp/archive_utils.h
> +index 18856ab..5298a36 100644
> +--- a/src/main/cpp/archive_utils.h
> ++++ b/src/main/cpp/archive_utils.h
> +@@ -15,6 +15,7 @@
> + #ifndef BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
> + #define BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
> +
> ++#include <cstdint>
> + #include <string>
> + #include <vector>
> +
> +diff --git a/src/main/cpp/util/logging.h b/src/main/cpp/util/logging.h
> +index b2cd459..7bf5a00 100644
> +--- a/src/main/cpp/util/logging.h
> ++++ b/src/main/cpp/util/logging.h
> +@@ -14,6 +14,7 @@
> + #ifndef BAZEL_SRC_MAIN_CPP_LOGGING_H_
> + #define BAZEL_SRC_MAIN_CPP_LOGGING_H_
> +
> ++#include <cstdint>
> + #include <memory>
> + #include <sstream>
> + #include <string>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2054): https://lists.yoctoproject.org/g/yocto-patches=
/message/2054
> Mute This Topic: https://lists.yoctoproject.org/mt/114778714/3617156
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338883=
6/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

