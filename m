Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFDFCAC59A
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 13:01:51 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.32732.1757941301474078878
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Sep 2025 06:01:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZjvkCQKT;
 spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso3999086e87.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757941299; x=1758546099; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdsAHWMerIbd2K+6MXQS+Jy+4F4tSYasKe++hmkChl8=;
        b=ZjvkCQKTD3kdMGjElCxtBXjcC5n6r38BxIqZI5s92QxjxQzNlQADKRR2YXbkEciX74
         HrfeRjUBD1s6hzLX0yKj8l/uzshCpRdINehTz0OsBjy8+UzT13kMw2aJr0uwHrieSUmz
         rbJMkXeJ8Lr8YpZQQp7kxs8IrTXjb8ubgBw5SmsvOmU7HaM7X+BDl+EZnN/8sRvMD5nb
         AiV/MLA9wfaQfg68r0GeJ+PAoHPFR24ZmdhRmWKEyRmvIWGxDsgC6j4Fzi0NNQejlVpx
         8gYvC+Y0tIGgiO21qyxQxVxKwDpfkhmxE4BTyF+4AZr2BxnxuEkEP773NRdMGSJNNVK0
         RBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757941299; x=1758546099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdsAHWMerIbd2K+6MXQS+Jy+4F4tSYasKe++hmkChl8=;
        b=GyNwp8kTspTBwisHDwF2Mw00QHvMblU5mWQJQ2ITOxyivSR3Vc0mdlgg6rXtTi2mvO
         iMR9QaKl2sF+JlCMRunhVDjq3jkrBQ4PWSB5oy3UMDcckChp9vZXFiI3BAxlCHu1AWhT
         0b/NEPBcQDlzVMIkEzh+r4ggy4xYD6ZagM5ekgRIddhTleTxR/1y7iXupEMjiopgCtEE
         aeXMcW+UGZVFG7obRpgv+iCDrG5qDjzu4qvI5gtIuocN5QwbdXUk/Zy/tkDnIXCvFvGn
         vM7aI2nO5Uuc8X5iAWSCWNwMOYgYUmTVdBHQHd8PdRvxRagQJ1E7lZwETolCg+u4UTTQ
         9PxA==
X-Gm-Message-State: AOJu0YxxCPTW3T9npgpiFx3HuSODvypgickhQYXWEqlpvapQ3nEDBn+y
	06/sUee/v6eSF2BoPOg9eP2+lXTZXBRWCWB9pcUgIN7NNUlr8wDi4pH46wPqMtFEX5dS2zBvjWv
	M2r8L+dVCLLu7sOKD2JZ9bU95l3UWkcIdzw==
X-Gm-Gg: ASbGncuvpU9pIArlSItrsv/T6iykNBseGk2+rElpUW/knw6XuMjpEkHWyytAqABNVxC
	ljS95haFS39xOYLXwjC55KsNKGpcHt3p6qL0lmYoCmPVI1uVvL7g7qGpw2aOfW16ghVcpfZHEf5
	7g9VWwQ7DGGQ2LLJiHg6NqLnXY6kmaPVHqjL1EKWmgG9cw7QfAjDum7VkxoB4yDrYBrY3OfZiNa
	nCpM6BARkYAN7rxVQxq
X-Google-Smtp-Source: AGHT+IE4KK1ZH/g/gmZwGVv7wZQCAIuUwk5tFDwri2w0i6ofh2aBSVFmhv/A9sIGv61Uxif/C9lVxfmpwLQViw/jcws=
X-Received: by 2002:a05:6512:ba2:b0:55f:4400:f2f6 with SMTP id
 2adb3069b0e04-57050df2df9mr3698826e87.42.1757941297545; Mon, 15 Sep 2025
 06:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <185CE350789F6CFE.8958@lists.yoctoproject.org>
In-Reply-To: <185CE350789F6CFE.8958@lists.yoctoproject.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 15 Sep 2025 15:01:25 +0200
X-Gm-Features: AS18NWDnjQTWgiPcmy4eNfFVWhxRZmrh9_kYW5MV0pC-qBkDi8g9lB5RW0wt3CE
Message-ID: <CA+chaQdqb7f+oo44idJwqdOd7PR4PK3Q2r4iD4mQf9F5YZzAQQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][walnascar][PATCH] bazel-native:
 fix build with gcc-15
To: yocto-patches@lists.yoctoproject.org
Cc: hongxu.jia@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 13:01:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2192

ping2

On Mon, Aug 18, 2025 at 4:38=E2=80=AFPM Martin Jansa via
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
> index 19b411b..a0daa3b 100644
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
> View/Reply Online (#2035): https://lists.yoctoproject.org/g/yocto-patches=
/message/2035
> Mute This Topic: https://lists.yoctoproject.org/mt/114764168/3617156
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338883=
6/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

