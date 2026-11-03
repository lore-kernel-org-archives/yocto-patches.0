Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13916.1793719586149105562
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Nov 2026 07:26:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google2 header.b=DZv8vWvt;
 spf=pass (domain: smile.fr, ip: 209.85.128.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so34974645e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 07:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google2; t=1793719584; x=1794324384; darn=lists.yoctoproject.org;
        h=in-reply-to:references:cc:from:subject:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CoNEcq9i7mbSShhOu/cxzxcGVOODRtpllgS6yf24GCI=;
        b=DZv8vWvtauys2JorYih1U7D6LUa75pY6VMIEzdEot4vs7YkZL9RwS70VuOLfClmIBD
         xlJNM8ecibH+RSA7/tbgQ7opTh9RmtO/O0E9FrYsybXonklGssuwDeQCIZ2FarT62h7Q
         YR3YOEXj5U8OJhjFjIOcDcmDxnWIG2TFsFr6gkjF/ZqdFMPuxv2RAgHvncmLQgbuMcFq
         7VDZbZ4IPmCt96mNSbBRNCk40ACzk4eMHj9FUx6JwNN7Wt/Tpkz+mg1vQ1o4uGZfRMLf
         W/v8H6kXQWkCmrP2O0RCXDLUsVh7oNYaeXZTb+u0/qtQRgE0xSVHN7C66Ubb3l/iIpnS
         AzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719584; x=1794324384;
        h=in-reply-to:references:cc:from:subject:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CoNEcq9i7mbSShhOu/cxzxcGVOODRtpllgS6yf24GCI=;
        b=090BHbEfwjpgj1O5qrd8C5WMPln+UXvnTj8AWR6oE7yCeGkF9vuAOmoJuHYC+8kykQ
         oNhYDkMNCEM6oG8D4k5uwgIjcf85LHFgWx55f9tXJ61t1pra90OpLpJJ+ptal/8nIxor
         lJr3FAQ9V6Ksgji4ySEcmvCkODAznrnuEEV44G6OG23uN3NUAA02n89AoGMXZrcF3RLa
         GyssckHZtGI+xXAsg/oTf3+OHORowHFJIj1+qC3b+KJZ/if7B/iOKfBwJi+P9rhAY0Wm
         9iHeSRtVliJBWm4sIoO3twmxCPwhPYNZs9RM2fB4TfhsC+BuZOyHDv6lhB/7pmFsVY3L
         INIw==
X-Gm-Message-State: APuU4Z/OG190EMZCn5gatkqcerUJ1VY7n8X6EUSOmijbfE3L1vPv0Xr8
	/i7EDf/vHkfkhn7S33lZTZak5DHVghIcwERtw3DlsF+VOI5LGkpOpWRa2wpRFdiJ1adytBPEyTO
	80v53cCg=
X-Gm-Gg: AYBFou055AMYt/AibuooldCUAITtpAxOO09/UYpYoDln7sslSOGZ3GFJo4RUSirEyo9
	EPJn74C2+gs1kvHES+c60u+IhZAHkANhHKjq2AoEjDRS3AYCUZltPWBEHAosHGjksONFXb8+t17
	AYDIaPxevB+8ghD57HTGEwFK89eo4ZN5WU4tbj6qRL0FV6TtIiVTLHTONZkfdQmSuOgqZONE6NQ
	I9ozPqsj41bceF6c5dUwwXf4I9PdXntwOMVElZUo4JhYlzX+NVUmx7ugPPtGgK4TyRWtDk63x/z
	EEv2OQD0dVMiaM4deC8fiSTd/Ol3UbG7PzSH/qeIWb5r0fMPogsp0YNU/PT2OCtCRFiayLP1Jop
	GOqOLHpi9w1EuvrIJpgZVO4UUrskb1zqCr/iYZwmv685E2h9aEoxO5yA/enmBwk25TYrfujA31n
	vF59gFSYcrTVrRbnjgpUY1jCf9U2DCoaKxf9svokIu2iKbzhJVY5Zhi0vqcdb0MAIrcvZezeAVs
	oKLrv0PEFSjgBgYrikfG+QOCtWRuiddZ6lEUvHGegMbs3SWRHbyiBvCYQNaEseZsnRHHKHKip1S
	fWLBh75rCEfz7oW/sJad9g83BrwnyCpMd/nsUIW1ajwnpEf/k2OIAny8oZwn8j9H6S04slbijj+
	8skpD6CyHgmAUTA==
X-Received: by 2002:a05:600c:350b:b0:4a3:2f35:38aa with SMTP id 5b1f17b1804b1-4ac1932bac0mr273353785e9.29.1793719584301;
        Tue, 03 Nov 2026 07:26:24 -0800 (PST)
Return-Path: <yoann.congal@smile.fr>
Received: from localhost (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d511sm25086515f8f.8.2026.11.03.07.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 07:26:23 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 16:26:23 +0100
Message-Id: <DMLOIWW3M0ST.2LJROJT68ACDJ@smile.fr>
To: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [PATCH] tpm2-tools: Fix build
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: "Khem Raj" <khem.raj@oss.qualcomm.com>, "Scott Murray"
 <scott.murray@konsulko.com>, "Marcel Ziswiler"
 <marcel.ziswiler@codethink.co.uk>
X-Mailer: aerc 0.20.0
References: <d3ed7d76f36436b8d5edd4b8b328205e809b63e9.1793706170.git.marcel.ziswiler@codethink.co.uk>
In-Reply-To: <d3ed7d76f36436b8d5edd4b8b328205e809b63e9.1793706170.git.marcel.ziswiler@codethink.co.uk>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 15:26:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5222

Hello,

I think this lacks a [meta-security] in the subject line.

Regards,

On Tue Nov 3, 2026 at 4:18 PM CET, Marcel Ziswiler via yocto-patches wrote:
> Fix the following build errors:
>
> ../sources/tpm2-tools-5.8/lib/object.c: In function 'PEM_read_bio_TSSPRIV=
KEY_OBJ':
> ../sources/tpm2-tools-5.8/lib/object.c:28:1: error: implicit declaration =
of function 'ERR_raise' [-Wimplicit-function-declaration]
>    28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY=
_OBJ_PEM_STRING,
>       | ^~~~~~~~~~~~~~~~~~~~~~
> ../sources/tpm2-tools-5.8/lib/object.c:28:1: error: 'ERR_LIB_PEM' undecla=
red (first use in this function)
>    28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY=
_OBJ_PEM_STRING,
>       | ^~~~~~~~~~~~~~~~~~~~~~
> ../sources/tpm2-tools-5.8/lib/object.c:28:1: note: each undeclared identi=
fier is reported only once for each function it appears in
> ../sources/tpm2-tools-5.8/lib/object.c:28:1: error: 'ERR_R_ASN1_LIB' unde=
clared (first use in this function)
>    28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKEY=
_OBJ_PEM_STRING,
>       | ^~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
> ---
>  ...1-lib-object.h-include-openssl-err.h.patch | 39 +++++++++++++++++++
>  .../recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb |  4 +-
>  2 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools/0001-lib-=
object.h-include-openssl-err.h.patch
>
> diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools/0001-lib-object.=
h-include-openssl-err.h.patch b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools=
/0001-lib-object.h-include-openssl-err.h.patch
> new file mode 100644
> index 000000000000..6325c98073f4
> --- /dev/null
> +++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools/0001-lib-object.h-inclu=
de-openssl-err.h.patch
> @@ -0,0 +1,39 @@
> +From c2b2c4e5cdc5bbc61779eb4271d5c317efb8c067 Mon Sep 17 00:00:00 2001
> +From: Bernd Kuhls <bernd@kuhls.net>
> +Date: Sat, 12 Sep 2026 13:22:13 +0200
> +Subject: [PATCH] lib/object.h: include openssl/err.h
> +
> +Fixes build error with OpenSSL 4.1.0-alpha1:
> +
> +lib/object.c: In function 'PEM_read_bio_TSSPRIVKEY_OBJ':
> +lib/object.c:28:1: error: implicit declaration of function 'ERR_raise' [=
-Wimplicit-function-declaration]
> +   28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKE=
Y_OBJ_PEM_STRING,
> +
> +lib/object.c:28:1: error: 'ERR_LIB_PEM' undeclared (first use in this fu=
nction)
> +   28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKE=
Y_OBJ_PEM_STRING,
> +
> +lib/object.c:28:1: error: 'ERR_R_ASN1_LIB' undeclared (first use in this=
 function)
> +   28 | IMPLEMENT_PEM_read_bio(TSSPRIVKEY_OBJ, TSSPRIVKEY_OBJ, TSSPRIVKE=
Y_OBJ_PEM_STRING,
> +
> +Signed-off-by: Bernd Kuhls <bernd@kuhls.net>
> +Upstream-Status: Backport [https://github.com/tpm2-software/tpm2-tools/c=
ommit/c2b2c4e5cdc5bbc61779eb4271d5c317efb8c067]
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
> +=20
> + #include <openssl/pem.h>
> ++#include <openssl/err.h>
> + #include <openssl/bio.h>
> + #include <openssl/asn1.h>
> + #include <openssl/asn1t.h>
> +--=20
> +2.56.0
> +
> diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb b/meta-tp=
m/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
> index 4edd283a739a..a87c2d0d7fa4 100644
> --- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
> +++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
> @@ -7,7 +7,9 @@ SECTION =3D "tpm"
> =20
>  DEPENDS =3D "tpm2-tss openssl curl autoconf-archive-native"
> =20
> -SRC_URI =3D "https://github.com/tpm2-software/${BPN}/releases/download/$=
{PV}/${BPN}-${PV}.tar.gz"
> +SRC_URI =3D "https://github.com/tpm2-software/${BPN}/releases/download/$=
{PV}/${BPN}-${PV}.tar.gz \
> +           file://0001-lib-object.h-include-openssl-err.h.patch \
> +           "
> =20
>  SRC_URI[sha256sum] =3D "1cb73185cae814b4e15c7c2d0b22642d640faf48775f4156=
a1fd92edf84bef73"
> =20


--=20
Yoann Congal
Smile ECS

