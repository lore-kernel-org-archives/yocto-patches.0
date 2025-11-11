Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959C2CCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 15:26:09 +0000 (UTC)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20226.1762874766317654766
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Nov 2025 07:26:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LQ+7Kq0C;
 spf=pass (domain: gmail.com, ip: 74.125.224.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63e2cc1ac4aso3806071d50.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 07:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762874765; x=1763479565; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBMg5+tr2nFtapmsXyiAuvCb0f0jwttQVmI3JggcXTU=;
        b=LQ+7Kq0C/YAbXzOm+LvvzxtoSpye4ncNrG0QbhlO5ZxPS1xr+VkO4RhaK9Q9MqWvuO
         7xTsfE78RjkT2RZ5B7Qt8Fhr8kQ8JbuQ1/ekz/mMY1LkBIUmCLFvMe5oOr8EI8XLjP+U
         xF2qbHmnGuXWvifWebd80k1UpgxXNoImU17xj7TBYlaX4Iec5dvXAadlAWUo21r5e3oJ
         pMv5GoQl1vvgzd/DgEj2onfPAnpnii1la4cOa5z7JcYirKppXGNvD9TjKY1KaSTqomtF
         0utlbe8ivx+zcEFCmUB9QabW3az1jp3x3/d1Y6VfPtLWJ2IhsLQ5LeiL29DHx9MJgjsW
         Hb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874765; x=1763479565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cBMg5+tr2nFtapmsXyiAuvCb0f0jwttQVmI3JggcXTU=;
        b=u6m50K5Er8QiXL8sscwV2sbXUZ/jKX9SLc2NNqGkqcPrq69kYkufJ9J0Fkl8CQoD3R
         uhlymfOWEINL/TLavHX+ZhHOmjgN+p5LIutM1wdhNbZp+U8W/TH6UJMfSzVQYilY6FGk
         p7jj02XQJzkaIHABNaep2E5EwkuPzrY8/F2e5IOchQcAKMNzcTBKSBbJ8SmUG0PDSGXY
         m6BRw8nr+WihknKAVPPSw2Vv+WDNUl14jvMM+YaMLJ6ddVB3b029Z3B86JVuvzUFWu2B
         bONqdsYJ3KS56MDqhQt7YMC8XP01stOi+wKsOOQUA7uJMT2JXLsLka65/cF/gqIfua3n
         o77g==
X-Gm-Message-State: AOJu0YwuNtc2vHKoOnaLI7nvVAKAgXThnYlce61Ez0IrhRmNnlrnezgx
	iZ2/cS8PRxfbc73Ta8BdkQqDOxopi4dFJSnN/Upgi1JzzOE0wmwqHK0EJ7iIyw6f6XRFR6tpXtA
	SOTSJwuZ8EQQYevGGdK7Wwb3B+eaK1kw=
X-Gm-Gg: ASbGncscxXdi4uP3qm0kVb763idytat21fWWj1/mMTl0OqhyiNDqY72QUSJwSlwpPxH
	EFutwxI3x0AgFlTVDWROEEWkv3KEbUbwPxJdn11p8jmomAA/8ZrPyT8sV3Tv0gbNQYI47Jruhdx
	8ptDynDVp7PUmziT3SioBqga5rgWKMGKNSlYPb+7v2aBwsXiwLSasUE9g5frfGEPhCHzUaRRk7T
	gxnwtdK0tDgv6d6NNwMsGzHTedX1nfmfWyvdd9bgmOYVi6zWf3sVXwOasHdguR5dEUFz6Zinnum
	CUACTM2znA==
X-Google-Smtp-Source: AGHT+IEM/jMdLNDdLjiurTnwEelpa1IkEfXmeZaZBpbzbYFt8q58vejS7q0RFbRcyAJ+gp34m+hMlRrAWch5GH3YjTw=
X-Received: by 2002:a05:690e:2589:b0:63e:350c:aea2 with SMTP id
 956f58d0204a3-640d45c6863mr7972794d50.47.1762874765335; Tue, 11 Nov 2025
 07:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20251103021848.3068540-1-Qi.Chen@windriver.com>
In-Reply-To: <20251103021848.3068540-1-Qi.Chen@windriver.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 11 Nov 2025 08:25:52 -0700
X-Gm-Features: AWmQ_bkbwen5IzR0La7IHsyOdDZtKhF83n3GwJnDK430kU9h8jXyqpwxwwX_EDs
Message-ID: <CAJdd5GYib3yt92tuSDcr0UQqcDL251EFXpvNuNGHrmrujnpDDg@mail.gmail.com>
Subject: Re: [meta-mingw][PATCH V2] meta-mingw: support generating Windows SDK
 with no symlink
To: Qi.Chen@windriver.com
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 15:26:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2487

On Sun, Nov 2, 2025 at 7:19=E2=80=AFPM <Qi.Chen@windriver.com> wrote:
>
> From: Chen Qi <Qi.Chen@windriver.com>
>
> On some Windows systems, symlinks are not allowed due to IT policy.
> We need to be able to generate Windows SDK without symlinks.
>
> To do this, a new variable, WINSDK_NO_SYMLINK, and a new bbclass,
> mingw_sdk_handle_symlink.bbclass, are introduced to achieve this.
>
> By default, things work as before; when setting WINSDK_NO_SYMLINK
> to "1", SDK will replace all symlinks with the actual contents.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  classes/mingw_sdk_handle_symlink.bbclass    | 25 +++++++++++++++++++++
>  conf/machine-sdk/include/mingw32-common.inc |  3 +++
>  2 files changed, 28 insertions(+)
>  create mode 100644 classes/mingw_sdk_handle_symlink.bbclass
>
> diff --git a/classes/mingw_sdk_handle_symlink.bbclass b/classes/mingw_sdk=
_handle_symlink.bbclass
> new file mode 100644
> index 0000000..2f6dbe6
> --- /dev/null
> +++ b/classes/mingw_sdk_handle_symlink.bbclass
> @@ -0,0 +1,25 @@
> +WINSDK_NO_SYMLINK ?=3D "0"
> +
> +archive_sdk:prepend:sdkmingw32 () {
> +       if [ "${WINSDK_NO_SYMLINK}" =3D "1" ]; then
> +               for parse_type in "file" "directory"; do
> +                       find "${SDK_OUTPUT}/${SDKPATH}" -type l -print0 |=
 while IFS=3D read -r -d '' symlink; do
> +                               target=3D$(readlink -f "$symlink" || echo=
 "NOTVALID")
> +                               if [ "$target" =3D "NOTVALID" ]; then
> +                                       continue
> +                               fi
> +                               if [ ! -e "$target" ]; then
> +                                       continue
> +                               elif [ -d "$target" ]; then
> +                                       if [ "$parse_type" =3D "directory=
" ]; then
> +                                               rm "$symlink" && cp -r "$=
target" "$symlink"
> +                                       fi
> +                               else
> +                                       if [ "$parse_type" =3D "file" ]; =
then
> +                                               rm "$symlink" && cp "$tar=
get" "$symlink"
> +                                       fi
> +                               fi
> +                       done
> +               done
> +       fi
> +}
> diff --git a/conf/machine-sdk/include/mingw32-common.inc b/conf/machine-s=
dk/include/mingw32-common.inc
> index 56b8052..bf3f14e 100644
> --- a/conf/machine-sdk/include/mingw32-common.inc
> +++ b/conf/machine-sdk/include/mingw32-common.inc
> @@ -59,3 +59,6 @@ GCCPIE:mingw32 =3D ""
>
>  # wine and wineserver are required to test MinGW SDKs
>  HOSTTOOLS_NONFATAL +=3D "wine wineserver"
> +
> +# handle symlinks
> +INHERIT +=3D "mingw_sdk_handle_symlink"

Does this need to be unconditional? I'd prefer something like
INHERIT:mingw32 instead if that works

> --
> 2.34.1
>

