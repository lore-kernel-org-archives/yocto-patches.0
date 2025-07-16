Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B50FC83F1B
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 06:50:14 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web11.15780.1752648612008097112
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Jul 2025 23:50:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NPtLjxM+;
 spf=pass (domain: gmail.com, ip: 209.85.167.51, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553b60de463so6048366e87.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 15 Jul 2025 23:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752648610; x=1753253410; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSAT2dnR91rbnrMBHPRxbeQyIzhKRZsTssdqZ5UZuoE=;
        b=NPtLjxM+GIknOTdnZfFpZvstUEBxGLrZNJWVvt/G1s4lOGJ6+Lb8j/BnDpvoqdNlnx
         j2P1CsdnC/Myu7Ibvn/m/ZosE+9q4B6Kce7I2CYD/1M86cOK3GyuqHcuvIWfMi8AdYnq
         58LumA2xls/5ATsYqR6l7kNxyvCM4zgDlnh2y1tK/k2+kq77JXNW4Fts8/7V3wS71/NQ
         8itu0Y0DyyRMJZXRHTIubJ3ySCU8bnJzICLzonN2kU79Nkvda78/d60kChysJxExseu7
         +7yRNz5EEMa8qIznW19dIyyO1d85F13nxwnKK/O7w87Ztsvi2TiqG6PWwrs/HTvy8PY6
         FGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752648610; x=1753253410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSAT2dnR91rbnrMBHPRxbeQyIzhKRZsTssdqZ5UZuoE=;
        b=SQYID34+WmOJNXndOPiimtvOuDfVobPTlNCHjFP/UfcQaeLKPfJZ9YFYJNnU0xHIWB
         VUl1lUrDhM4lxvlJNYnh4Te0lm3CG+0x6Wa/X5Bv4Mff76New0hMfr7vNOR4J9Z3wWJL
         dzV2EERxpAKBPLnIG7fG3fXXJdzSxV8+4CkermJLTgZ3PkbOzwoTkt7VjCzPN9ptz7IH
         hq6i8lEWfQPlllmA1HkeOrpCJN7y9ATjvOg9qCk8Z3JavTgPy5H2rRdZSrr1f3RFAAcf
         OTOmoPZTqqqXOhnp1CHZVwt9vyc63jjH+D6vVD5m4rsTcv6QiHL44PX61gKB7q/qzZHT
         5PpQ==
X-Gm-Message-State: AOJu0Yy1ZkQNt4waLRo30ejyus8FjoJrelYG7RnjnDUAJX2xoeq3xwd/
	BPFZXQw+mJoT3f5fgmWREeJcEFrqlHnxzLrt68xmN0DykUqw0KFhlq8F7vKAjlZARuW1S2z7qO1
	V7WS64DAFtLzFewAgTBEcESqIWe27ZtRjRgC7
X-Gm-Gg: ASbGncsCBmmq5qWuPwnUFQ1R/EHTw3hu3AsU8BULU+7rAEAMY/VSPCCNzFxzJbck5Go
	eJWs4k8BYx4m2Y9Fh+BhKScfuBNXpMGeS1iGWYWxQQZ4AC1eFor6/wagOVFAup66pJfMcUnnBZH
	4O6phtaqfvyf5vIfrd6Rf68RuMlJ2vBaNA/MzMvi3VI/O6RNN47Et4k2ovykLyVsyxe+mkJi4xu
	dU4McMRyw==
X-Google-Smtp-Source: AGHT+IHzUkEtQX7jJ3OMwq7+5C9+5wERJZ7ab/mj+HLI5HH7CqIXT4dQgErc1YzgqjftSay+ZjKCal5SSkDB2PrYS4E=
X-Received: by 2002:a05:6512:3f16:b0:553:ce07:de8e with SMTP id
 2adb3069b0e04-55a23f619e0mr498679e87.42.1752648609677; Tue, 15 Jul 2025
 23:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250708072436.24522-1-martin.jansa@gmail.com> <20250708072436.24522-2-martin.jansa@gmail.com>
In-Reply-To: <20250708072436.24522-2-martin.jansa@gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 16 Jul 2025 08:49:58 +0200
X-Gm-Features: Ac12FXzDYi7l9xB3ARxtRLH_BoXZNa4gOYiNcHRiicd_igonBTh1r4prMg2zsT0
Message-ID: <CA+chaQdVAzm8au9RXWgY01gwwWO_qxO6LLM=ThTOwzWU8MrUgQ@mail.gmail.com>
Subject: Re: [meta-tensorflow][PATCH 2/3] bazel-native: adapt to UNPACKDIR
 changes - avoid WORKDIR/sources
To: yocto-patches@lists.yoctoproject.org, 
	Hongxu Jia <hongxu.jia@windriver.com>
Cc: Martin Jansa <martin2.jansa@lgepartner.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Jul 2025 06:50:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1803

Hongxu Jia looks like you've created very similar commits for
whinlatter compatibility recently.

Do you monitor this ML for meta-tensorflow changes?

On Tue, Jul 8, 2025 at 9:24=E2=80=AFAM <martin.jansa@gmail.com> wrote:
>
> From: Martin Jansa <martin2.jansa@lgepartner.com>
>
> Please see
> https://git.yoctoproject.org/poky/commit/?id=3D4dd321f8b83afecd962393101b=
2a6861275b5265
> for what changes are needed, and sed commands that can be used to make th=
em en masse.
>
> Signed-off-by: Martin Jansa <martin2.jansa@lgepartner.com>
> ---
>  recipes-devtools/bazel/bazel-native_6.0.0.bb | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-devto=
ols/bazel/bazel-native_6.0.0.bb
> index 19b411b..ef9dfba 100644
> --- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
> +++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
> @@ -5,7 +5,8 @@ LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3b83ef96387f14=
655fc854ddc3c6bd57"
>  SRC_URI[md5sum] =3D "f79f57d82795b591e95f9f7fa0f9a8da"
>  SRC_URI[sha256sum] =3D "7bc0c5145c19a56d82a08fce6908c5e1a0e75e4fbfb3b6f1=
2b4deae7f4b38cbc"
>
> -SRC_URI =3D "https://github.com/bazelbuild/bazel/releases/download/${PV}=
/bazel-${PV}-dist.zip \
> +# bazel-${PV}-dist.zip doesn't have top-level directory, use subdir
> +SRC_URI =3D "https://github.com/bazelbuild/bazel/releases/download/${PV}=
/bazel-${PV}-dist.zip;subdir=3D${BP} \
>             file://0001-HttpDownloader-save-download-tarball-to-distdir.p=
atch \
>             file://0001-fix-unzip-command-not-found.patch \
>             file://0001-add-Yocto-native-sysroot-dir-to-the-default-Bazel=
-to.patch \
> @@ -25,9 +26,6 @@ DEPENDS =3D "coreutils-native \
>             openjdk-11-native \
>            "
>
> -S =3D "${WORKDIR}/sources"
> -UNPACKDIR =3D "${S}"
> -
>  inherit bazel-base
>
>  EXTRA_BAZEL_ARGS =3D " \

