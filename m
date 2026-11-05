Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5590.1793910295990408947
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Nov 2026 12:24:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=SGcZ9Fql;
 spf=pass (domain: konsulko.com, ip: 209.85.160.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5364042eecfso31552291cf.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Nov 2026 12:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1793910295; x=1794515095; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3FeU2w+ZY6w6kqH8J4yp3alCUXbQLnKOeoHHB6qsWY=;
        b=SGcZ9Fql/YBur66KRk4Szy044Zg/fkDdh330apZQsM4KqIf4hq9OscLec/SiiYpP7z
         jzvsaoLK3uRBPXvGC8ZKubblHLU1Gcb6k9yfWRnnrQ0BCBKdvwWZ9qNwVhE44Svydm4i
         lY5E4ayj0syr/2JVN7o44QsGEv3/M3zzqwoAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910295; x=1794515095;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3FeU2w+ZY6w6kqH8J4yp3alCUXbQLnKOeoHHB6qsWY=;
        b=YD7Mimq6iQStwvj2xAqMTgDuLyd44qheACUbGyek3Rx8Fn97lRDHZ0Zoh5eWbaDIjZ
         hSOxD+Z2n5SaAXCYUdxTnbsozvJxel4gY6L2hE81Ab1wQ6e1vWDk5zIpZDUultVGHDWg
         S69rkgxgnjhEzzi20UbMmYxilsNKPgDEWeF5dDcQ7rlCYzjyDVIFln1JiGj6osOvDaMA
         PDGOvujLQUgqgejax5Vpa7b5JMIT17bTgbjCZ3j3BGVq5WQN6qxlRWTMgrsIVFMpAlJC
         3jSxF7IIJRad1LjnSQ3YfZ6p7/+azgDGGXXs7ZMNHnjdqEVYoLUJLLEVp+Pvwsx/INwK
         2PsQ==
X-Gm-Message-State: APuU4Z/YBI/e4mXyrAR0i6ClNAWCqJO5mkInnXJZ4MjB5+ppB2fI0W4W
	GATZeF/+p1Z9SRExaCgLvYS+dsvG6yl2inHmVipxBRHaBgZT9hoJ0ZaNUA+B0AKIWWJDy7zLWpd
	qboSbyTo=
X-Gm-Gg: AYBFou2zvH22F9UJp6VYAgamaib8d+/DIIFnn55Vl8cl5LW1tTbG5rJ0y4kYFEg9VHe
	8TmzFkTw4+jD8jQhxd2nnvJIc0eGmTYXShZjzFkmPTY39BV/P+/0UftfSZpTk7Oncc/ct9hKoEN
	UURpzJbfOcCXBunJVcEQzMzP5ZhH7ZbhxhttxGpyEFE9Ny0Gsdq02XmvMQh5IVvJQcYhLKIcG62
	T2zrDZjOk10H4g/svdmLAIIrHKPIz9/bkpHezmzFYHDdjs0U08Vz4/VrH//OepcjwdH0KLs3zvu
	Dz3sIBhoSmOyt0GjrYbVcPqnlS9V+wP3+hbBh3xFNvOdv2qs7CUjBFVvgakZJ6WboMQMp4/Ysei
	IseebuhiB0ZROsY8fmBSyfoQFU3IWXUbozwjTRWE+O+VLdb/bg5C9G5UNfkfH6614+f9xcaY/pT
	nWSRmbhuTYXzMGCfhqXIqWXJQj2oJAcMF0sfbtup7AAwtlg7wSJVtSMs8nxKQ7ARmrsIsAmWtm2
	BlfJOCxVRStIw4HkJjUlMghInPCWNE9o+5LZQ7doUifEHkgjPHlqwoEjDEflR0UnN3x81NzY1Ns
	OpBFGUG9vIGRYAt7r054MJbC+zZeacwc/TL7RnxSyN4f++Li0i1zTwpwfGbXuOTMBdtMWW+jhfn
	X3DIN1kTEuHspOwTXUoRd6xsENhBDgKEATJeaAjHuJS92sTvL+vVG+fQ=
X-Received: by 2002:a05:622a:5289:b0:537:5488:de83 with SMTP id d75a77b69052e-54e14e6eff1mr6594121cf.54.1793910294575;
        Thu, 05 Nov 2026 12:24:54 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e1ff8d0e2sm2445721cf.0.2026.11.05.12.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:24:54 -0800 (PST)
Date: Thu, 5 Nov 2026 15:24:53 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: ricardo.salveti@oss.qualcomm.com
Subject: Re: [yocto-patches] [meta-security][PATCH] tpm2-openssl: Fix build
 with OpenSSL 4.1
In-Reply-To: <20261104184329.3927007-1-ricardo.salveti@oss.qualcomm.com>
Message-ID: <39dad749-846c-5008-d08d-8a91da81ec19@konsulko.com>
References: <20261104184329.3927007-1-ricardo.salveti@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Nov 2026 20:24:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5244

On Wed, 4 Nov 2026, Ricardo Salveti via yocto-patches wrote:

> OpenSSL 4.1.0 deprecates ASN1_STRING_set() and ASN1_STRING_length(),
> and its pem.h macros now call ERR_raise() without including err.h, so
> tpm2-provider-pkey.c fails to build with -Werror:
>
>   src/tpm2-provider-pkey.c:32:1: error: implicit declaration of function 'ERR_raise'
>   src/tpm2-provider-pkey.c:84:5: error: 'ASN1_STRING_set' is deprecated: Since OpenSSL 4.1
>
> Backport the upstream fix.
>
> Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>

I merged a previously contributed fix for this yesterday, please pull
master branch and try it.

Thanks,

Scott


> ---
>  ...key-fix-compilation-with-OpenSSL-4.1.patch | 86 +++++++++++++++++++
>  .../tpm2-openssl/tpm2-openssl_1.3.0.bb        |  1 +
>  2 files changed, 87 insertions(+)
>  create mode 100644 meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch
>
> diff --git a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch
> new file mode 100644
> index 0000000..0b482b1
> --- /dev/null
> +++ b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch
> @@ -0,0 +1,86 @@
> +From 9cc4cbe25702fc95c536dfb6723ae454e0039faf Mon Sep 17 00:00:00 2001
> +From: Moritz Buhl <moritz.buhl@infineon.com>
> +Date: Tue, 1 Sep 2026 09:58:28 +0200
> +Subject: [PATCH] pkey: fix compilation with OpenSSL 4.1
> +
> +Avoid deprecated OpenSSL functions, add fallback defines for older
> +versions:
> +src/tpm2-provider-pkey.c:91:5: error: 'ASN1_STRING_set' is deprecated:
> +Since OpenSSL 4.1; use ASN1_STRING_set1_data() or ASN1_STRING_set1_string()
> +[-Werror,-Wdeprecated-declarations]
> +src/tpm2-provider-pkey.c:165:41: error: 'ASN1_STRING_length' is deprecated:
> +Since OpenSSL 4.1; use ASN1_STRING_get_length()
> +[-Werror,-Wdeprecated-declarations]
> +
> +Add missing header:
> +src/tpm2-provider-pkey.c:32:1: error: call to undeclared function 'ERR_raise';
> +ISO C99 and later do not support implicit function declarations
> +[-Wimplicit-function-declaration]
> +
> +Upstream-Status: Backport [https://github.com/tpm2-software/tpm2-openssl/commit/9cc4cbe25702fc95c536dfb6723ae454e0039faf]
> +Signed-off-by: Moritz Buhl <moritz.buhl@infineon.com>
> +Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
> +---
> + src/tpm2-provider-pkey.c | 22 ++++++++++++++++------
> + 1 file changed, 16 insertions(+), 6 deletions(-)
> +
> +diff --git a/src/tpm2-provider-pkey.c b/src/tpm2-provider-pkey.c
> +index 80213af..bb56ba7 100644
> +--- a/src/tpm2-provider-pkey.c
> ++++ b/src/tpm2-provider-pkey.c
> +@@ -2,6 +2,8 @@
> +
> + #include <string.h>
> +
> ++#include <openssl/err.h>
> ++#include <openssl/opensslv.h>
> + #include <openssl/pem.h>
> + #include <openssl/rand.h>
> +
> +@@ -9,6 +11,14 @@
> +
> + #include "tpm2-provider-pkey.h"
> +
> ++#if OPENSSL_VERSION_NUMBER >= 0x40100000
> ++#define TPM2_ASN1_STRING_get_length(x)		ASN1_STRING_get_length(x)
> ++#define TPM2_ASN1_STRING_set1_data(s, d, l)	ASN1_STRING_set1_data(s, d, l)
> ++#else
> ++#define TPM2_ASN1_STRING_get_length(x)		ASN1_STRING_length(x)
> ++#define TPM2_ASN1_STRING_set1_data(s, d, l)	ASN1_STRING_set(s, d, l)
> ++#endif
> ++
> + typedef struct {
> +     ASN1_OBJECT *type;
> +     ASN1_BOOLEAN emptyAuth;
> +@@ -81,8 +91,8 @@ tpm2_keydata_write(const TPM2_KEYDATA *keydata, BIO *bout, TPM2_PKEY_FORMAT form
> +     else
> +         ASN1_INTEGER_set_uint64(tpk->parent, TPM2_RH_OWNER);
> +
> +-    ASN1_STRING_set(tpk->privkey, &privbuf[0], privbuf_len);
> +-    ASN1_STRING_set(tpk->pubkey, &pubbuf[0], pubbuf_len);
> ++    TPM2_ASN1_STRING_set1_data(tpk->privkey, &privbuf[0], privbuf_len);
> ++    TPM2_ASN1_STRING_set1_data(tpk->pubkey, &pubbuf[0], pubbuf_len);
> +
> +     switch (format) {
> +     case KEY_FORMAT_PEM:
> +@@ -150,13 +160,13 @@ tpm2_keydata_read(BIO *bin, TPM2_KEYDATA *keydata, TPM2_PKEY_FORMAT format)
> +         goto error;
> +
> +     if (Tss2_MU_TPM2B_PRIVATE_Unmarshal(ASN1_STRING_get0_data(tpk->privkey),
> +-                                        ASN1_STRING_length(tpk->privkey), NULL,
> +-                                        &keydata->priv))
> ++                                        TPM2_ASN1_STRING_get_length(tpk->privkey),
> ++                                        NULL, &keydata->priv))
> +         goto error;
> +
> +     if (Tss2_MU_TPM2B_PUBLIC_Unmarshal(ASN1_STRING_get0_data(tpk->pubkey),
> +-                                       ASN1_STRING_length(tpk->pubkey), NULL,
> +-                                       &keydata->pub))
> ++                                       TPM2_ASN1_STRING_get_length(tpk->pubkey),
> ++                                       NULL, &keydata->pub))
> +         goto error;
> +
> +     TSSPRIVKEY_free(tpk);
> +--
> +2.43.0
> +
> diff --git a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
> index 07feb00..fdef883 100644
> --- a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
> +++ b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
> @@ -7,6 +7,7 @@ DEPENDS = "autoconf-archive-native tpm2-tss openssl"
>
>  SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz \
>             file://0001-Fix-ASN1_OCTET_STRING-and-X509_NAME-access-for-OpenS.patch \
> +           file://0002-pkey-fix-compilation-with-OpenSSL-4.1.patch \
>             "
>
>  SRC_URI[sha256sum] = "9a9aca55d4265ec501bcf9c56d21d6ca18dba902553f21c888fe725b42ea9964"
>
