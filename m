Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14012.1793811456655406980
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 08:57:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Pmh1R/6G;
 spf=pass (domain: konsulko.com, ip: 209.85.210.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-843b6f8e2c7so1027883a34.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 08:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1793811456; x=1794416256; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OtLOUmG/9WVL/+pYnSBNnVhpzVB1xuifOkoh4YapYA=;
        b=Pmh1R/6Gx/3Ppqst+QXt1DksC0vqytmKpADX4s8OhvHpyCqVD0X5J2n/SvtrWUjKEo
         dmKH9uDwm1DVE++TX6Gutq9FdM9yvrzq0XvIYUu/Z0njNqTVvD8MIWP+/NNVjJA1RoD8
         KTh5AQPAAjv77Wa5fpLdVvJPfsr14LY/JSjUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811456; x=1794416256;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OtLOUmG/9WVL/+pYnSBNnVhpzVB1xuifOkoh4YapYA=;
        b=ZlwU9kUAgAre4pb1NU52F+sEA15rmq5qnG7e8+OrZ/04AJcdwtMGSKQcKy/m/3X2ul
         juXYd2W7Li9KOChKtczGd2nyMuhSjCbYNkcWhmU3yA6RZERpJ2MymUleYjLWx3J7Ovmw
         bxBzSJppJwXmFCTG3MMmvqHidUBQxDKkEbY1GsPxAAtsW7oxQQAaNK9eeUw/090jZQF3
         ljNXdi2/lPAueeJih7yO05swCUat3ck0k0eryRBq8YfrHDO7aW2G92BQkTMcCIjHhpcu
         FQ6rz/KigDvI4uZoZWTSWjyaueJs8bo61ROwd2eYLE+iyQe11titomhS4WFZTYWCjeDA
         nQGw==
X-Gm-Message-State: APuU4Z+WTsVHiqqbBIjkeHR6nPqeGIUsIJPcb9DkS6DS9JiyK55s6YSr
	6WwxSbGMw0QXT/loaLJqHtAadNKW383f1nl0lvwUgo73dNrpRC0XT0Io/i2LMjpROoQ=
X-Gm-Gg: AYBFou2cuyoMh0Wbz6H6tZEFPPkCRTPS/5eoec6AyF0kO1emABSXNmkuGkmu3F850Xv
	4ysR/4BgbwCJ6XttJ/mZLwIYbAJ0L1Bwsra4PKlBT31M6EU9epT8VFQPHmy5yvI6Ldu+UyaAfa2
	VJi8weeO43/ioAhqm/9+W0MRFWrcpElqhkdbkEidv5DyD/Eg5dkKKEBSxCVqLdchDS4F49FSG7+
	I4AOguXXhBdknNGO5hFOMKXyojv9HKMWT0B9zqb6FXFoHfWmWuSnj/g8sK04U0StiAvgooatzfb
	YPlRyPXogvFnagR3X82G7Tpb+kv3uAIQphqftdkEyhSnvYS36cb3P4+nHDDzwf6NhQTzMGJG678
	JObVo36+7EmS6Zdj5znzu94t5CoMFTgp/IC12PeFKnGHvMEJLnFjyhtdlfvlt/s3v7rDexOIrVP
	pDWwKhgPRvqyfwJSCvSkI3KbTW7onWiv5BAt7zeBPCIKCkiVpmUcFuOZKeuHNuUra5f5RQWLqFd
	1F/H4Wm9XQLOpLYzCoKYcfkQ5yKZYZPql9Zlw+/fO1RgV+3XDYI+eTWv8e3RPWfr/PjebfO1BZD
	Yj3BZKkzjVviW/Q/kYSEitFwQbb42hLoPz6V9C5zRYcgXoUmJhZgC8rQx3CqckIqj6lKvhGxnqa
	Zg34pSKueLr7rVkGqlqRkZEKFrJpJrJDRP6oITwcKx6fxFD/RC1BtsHg=
X-Received: by 2002:a05:6830:3497:b0:81f:1790:6ad8 with SMTP id 46e09a7af769-85d3665047amr12626919a34.31.1793811455512;
        Wed, 04 Nov 2026 08:57:35 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3a1a6c8sm2330250a34.2.2026.11.04.08.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:57:35 -0800 (PST)
Date: Wed, 4 Nov 2026 11:57:34 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
cc: yocto-patches@lists.yoctoproject.org, Khem Raj <khem.raj@oss.qualcomm.com>
Subject: Re: [PATCH] tpm2-tools: Fix build
In-Reply-To: <d3ed7d76f36436b8d5edd4b8b328205e809b63e9.1793706170.git.marcel.ziswiler@codethink.co.uk>
Message-ID: <6bc780d3-0faa-9507-8364-3c82c04df75b@konsulko.com>
References: <d3ed7d76f36436b8d5edd4b8b328205e809b63e9.1793706170.git.marcel.ziswiler@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 16:57:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5235

I have merged this to master.

Thanks,

Scott


On Tue, 3 Nov 2026, Marcel Ziswiler wrote:

> Fix the following build errors:
>
> ../sources/tpm2-tools-5.8/lib/object.c: In function 'PEM_read_bio_TSSPRIVKEY_OBJ':
> ../sources/tpm2-tools-5.8/lib/object.c:28:1: error: implicit declaration of function 'ERR_raise' [-Wimplicit-function-declaration]
>    28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
>       | ^~~~~~~~~~~~~~~~~~~~~~
> ../sources/tpm2-tools-5.8/lib/object.c:28:1: error: 'ERR_LIB_PEM' undeclared (first use in this function)
>    28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
>       | ^~~~~~~~~~~~~~~~~~~~~~
> ../sources/tpm2-tools-5.8/lib/object.c:28:1: note: each undeclared identifier is reported only once for each function it appears in
> ../sources/tpm2-tools-5.8/lib/object.c:28:1: error: 'ERR_R_ASN1_LIB' undeclared (first use in this function)
>    28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
>       | ^~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
> ---
>  ...1-lib-object.h-include-openssl-err.h.patch | 39 +++++++++++++++++++
>  .../recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb |  4 +-
>  2 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools/0001-lib-object.h-include-openssl-err.h.patch
>
> diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools/0001-lib-object.h-include-openssl-err.h.patch b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools/0001-lib-object.h-include-openssl-err.h.patch
> new file mode 100644
> index 000000000000..6325c98073f4
> --- /dev/null
> +++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools/0001-lib-object.h-include-openssl-err.h.patch
> @@ -0,0 +1,39 @@
> +From c2b2c4e5cdc5bbc61779eb4271d5c317efb8c067 Mon Sep 17 00:00:00 2001
> +From: Bernd Kuhls <bernd@kuhls.net>
> +Date: Sat, 12 Sep 2026 13:22:13 +0200
> +Subject: [PATCH] lib/object.h: include openssl/err.h
> +
> +Fixes build error with OpenSSL 4.1.0-alpha1:
> +
> +lib/object.c: In function 'PEM_read_bio_TSSPRIVKEY_OBJ':
> +lib/object.c:28:1: error: implicit declaration of function 'ERR_raise' [-Wimplicit-function-declaration]
> +   28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
> +
> +lib/object.c:28:1: error: 'ERR_LIB_PEM' undeclared (first use in this function)
> +   28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
> +
> +lib/object.c:28:1: error: 'ERR_R_ASN1_LIB' undeclared (first use in this function)
> +   28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ_PEM_STRING,
> +
> +Signed-off-by: Bernd Kuhls <bernd@kuhls.net>
> +Upstream-Status: Backport [https://github.com/tpm2-software/tpm2-tools/commit/c2b2c4e5cdc5bbc61779eb4271d5c317efb8c067]
> +Signed-off-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
> +---
> + lib/object.h | 1 +
> + 1 file changed, 1 insertion(+)
> +
> +diff --git a/lib/object.h b/lib/object.h
> +index b48b55b3b06c..2c4102fcc9dd 100644
> +--- a/lib/object.h
> ++++ b/lib/object.h
> +@@ -6,6 +6,7 @@
> + #include "tpm2_util.h"
> +
> + #include <openssl/pem.h>
> ++#include <openssl/err.h>
> + #include <openssl/bio.h>
> + #include <openssl/asn1.h>
> + #include <openssl/asn1t.h>
> +--
> +2.56.0
> +
> diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
> index 4edd283a739a..a87c2d0d7fa4 100644
> --- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
> +++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
> @@ -7,7 +7,9 @@ SECTION = "tpm"
>
>  DEPENDS = "tpm2-tss openssl curl autoconf-archive-native"
>
> -SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
> +SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz \
> +           file://0001-lib-object.h-include-openssl-err.h.patch \
> +           "
>
>  SRC_URI[sha256sum] = "1cb73185cae814b4e15c7c2d0b22642d640faf48775f4156a1fd92edf84bef73"
>
>
